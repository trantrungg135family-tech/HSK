<#
.SYNOPSIS
  Builds a Classroom Feud question workbook (.xlsx) from a JSON file, with no
  dependencies (no Excel, no Python). Layout follows classroom-feud/EXCEL-FORMAT.md.

.PARAMETER JsonPath
  UTF-8 JSON file:
  {
    "topic": "Food",
    "levels": {
      "Starters": [ { "question": "Name a fruit.", "answers": [["Banana", 30], ["Apple", 25]], "note": "" } ],
      "Movers":   [ ... ],
      "Flyers":   [ ... ]
    }
  }
  Optional per-question "topic" overrides the top-level topic. "note" is optional.

.PARAMETER OutputPath
  Destination .xlsx path (overwritten if it exists).

.EXAMPLE
  powershell -NoProfile -ExecutionPolicy Bypass -File New-FeudWorkbook.ps1 -JsonPath food.json -OutputPath question-sets\feud-food-20261124.xlsx
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$JsonPath,
    [Parameter(Mandatory = $true)][string]$OutputPath
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$LevelNames = @('Starters', 'Movers', 'Flyers')
$MaxAnswers = 8

function Resolve-FullPath([string]$p) {
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($p)
}

function Escape-Xml([string]$s) {
    if ($null -eq $s) { return '' }
    # Drop control characters that are illegal in XML 1.0 (keep tab, LF, CR).
    $s = [regex]::Replace($s, '[\x00-\x08\x0B\x0C\x0E-\x1F]', '')
    return [System.Security.SecurityElement]::Escape($s)
}

function Get-ColLetter([int]$index) {
    # 1-based column index -> letters (A..Z, AA..)
    $name = ''
    while ($index -gt 0) {
        $m = ($index - 1) % 26
        $name = [char](65 + $m) + $name
        $index = [math]::Floor(($index - 1) / 26)
    }
    return $name
}

function New-TextCell([string]$ref, [string]$text, [int]$style = 0) {
    $s = if ($style) { " s=`"$style`"" } else { '' }
    if ([string]::IsNullOrEmpty($text)) {
        if ($style) { return "<c r=`"$ref`"$s/>" } else { return '' }
    }
    return "<c r=`"$ref`"$s t=`"inlineStr`"><is><t xml:space=`"preserve`">$(Escape-Xml $text)</t></is></c>"
}

function New-NumberCell([string]$ref, $value, [int]$style = 0) {
    $s = if ($style) { " s=`"$style`"" } else { '' }
    return "<c r=`"$ref`"$s><v>$value</v></c>"
}

# ---------- Read + validate input ----------
$jsonFull = Resolve-FullPath $JsonPath
if (-not (Test-Path -LiteralPath $jsonFull)) { throw "JSON file not found: $jsonFull" }
$raw = [System.IO.File]::ReadAllText($jsonFull, [System.Text.Encoding]::UTF8)
$data = $raw | ConvertFrom-Json

$defaultTopic = [string]$data.topic
if ([string]::IsNullOrWhiteSpace($defaultTopic)) { throw 'JSON must have a non-empty "topic".' }
if ($null -eq $data.levels) { throw 'JSON must have a "levels" object (Starters / Movers / Flyers).' }

$warnings = New-Object System.Collections.Generic.List[string]
$rowsByLevel = @{}
foreach ($level in $LevelNames) {
    $rows = New-Object System.Collections.Generic.List[object]
    $items = $data.levels.$level
    if ($null -eq $items) { $items = @() }
    $n = 0
    foreach ($q in @($items)) {
        $n++
        $question = ([string]$q.question).Trim()
        if (-not $question) { throw "$level question #$n has no text." }
        if ($question.Length -gt 200) { throw "$level question #$n is longer than 200 characters." }
        $topic = if ($q.topic) { ([string]$q.topic).Trim() } else { $defaultTopic.Trim() }
        $answers = New-Object System.Collections.Generic.List[object]
        foreach ($a in @($q.answers)) {
            $pair = @($a)
            $text = ([string]$pair[0]).Trim()
            if (-not $text) { continue }
            if ($text.Length -gt 80) { throw "$level question #$n answer '$text' is longer than 80 characters." }
            $pts = 0
            if ($pair.Count -gt 1 -and $null -ne $pair[1]) { $pts = [int]$pair[1] }
            if ($pts -lt 0 -or $pts -gt 999) { throw "$level question #$n answer '$text' has points outside 0-999." }
            $answers.Add(@($text, $pts))
        }
        if ($answers.Count -lt 1) { throw "$level question #$n has no answers." }
        if ($answers.Count -gt $MaxAnswers) { throw "$level question #$n has more than $MaxAnswers answers." }
        $sum = ($answers | ForEach-Object { $_[1] } | Measure-Object -Sum).Sum
        if ($sum -lt 90 -or $sum -gt 110) { $warnings.Add("$level #${n}: points sum to $sum (expected ~100)") }
        for ($i = 1; $i -lt $answers.Count; $i++) {
            if ($answers[$i][1] -gt $answers[$i - 1][1]) { $warnings.Add("$level #${n}: answers not sorted by points"); break }
        }
        $rows.Add([pscustomobject]@{ Topic = $topic; Question = $question; Answers = $answers; Note = [string]$q.note })
    }
    $rowsByLevel[$level] = $rows
}

# ---------- Build OOXML parts ----------
$xmlHead = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
$nsMain = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main'
$nsRel = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships'

# Styles: 0 default, 1 header (bold, fill, border, wrap), 2 wrap top-aligned, 3 bold title (large), 4 centered (Approved/points)
$stylesXml = @"
$xmlHead
<styleSheet xmlns="$nsMain">
<fonts count="3">
<font><sz val="11"/><name val="Calibri"/><family val="2"/></font>
<font><b/><sz val="11"/><name val="Calibri"/><family val="2"/></font>
<font><b/><sz val="14"/><name val="Calibri"/><family val="2"/></font>
</fonts>
<fills count="4">
<fill><patternFill patternType="none"/></fill>
<fill><patternFill patternType="gray125"/></fill>
<fill><patternFill patternType="solid"><fgColor rgb="FFDDEBF7"/><bgColor indexed="64"/></patternFill></fill>
<fill><patternFill patternType="solid"><fgColor rgb="FFFFF2CC"/><bgColor indexed="64"/></patternFill></fill>
</fills>
<borders count="2">
<border><left/><right/><top/><bottom/><diagonal/></border>
<border><left/><right/><top/><bottom style="thin"><color rgb="FF8EA9DB"/></bottom><diagonal/></border>
</borders>
<cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>
<cellXfs count="6">
<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>
<xf numFmtId="0" fontId="1" fillId="2" borderId="1" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment horizontal="center" vertical="center" wrapText="1"/></xf>
<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0" applyAlignment="1"><alignment vertical="top" wrapText="1"/></xf>
<xf numFmtId="0" fontId="2" fillId="0" borderId="0" xfId="0" applyFont="1"/>
<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0" applyAlignment="1"><alignment horizontal="center" vertical="top"/></xf>
<xf numFmtId="0" fontId="1" fillId="3" borderId="0" xfId="0" applyFont="1" applyFill="1" applyAlignment="1"><alignment horizontal="center" vertical="top"/></xf>
</cellXfs>
<cellStyles count="1"><cellStyle name="Normal" xfId="0" builtinId="0"/></cellStyles>
</styleSheet>
"@

function New-LevelSheetXml($rows) {
    $headers = @('Topic', 'Question')
    for ($i = 1; $i -le $MaxAnswers; $i++) { $headers += "Answer $i"; $headers += "Points $i" }
    $headers += 'Approved'; $headers += 'Note'   # columns S, T
    $approvedCol = Get-ColLetter 19
    $lastCol = Get-ColLetter $headers.Count

    $sb = New-Object System.Text.StringBuilder
    [void]$sb.Append("<row r=`"1`" ht=`"20`" customHeight=`"1`">")
    for ($c = 0; $c -lt $headers.Count; $c++) {
        [void]$sb.Append((New-TextCell "$(Get-ColLetter ($c + 1))1" $headers[$c] 1))
    }
    [void]$sb.Append('</row>')

    $r = 1
    foreach ($row in $rows) {
        $r++
        [void]$sb.Append("<row r=`"$r`">")
        [void]$sb.Append((New-TextCell "A$r" $row.Topic 2))
        [void]$sb.Append((New-TextCell "B$r" $row.Question 2))
        for ($i = 0; $i -lt $row.Answers.Count; $i++) {
            $ac = Get-ColLetter (3 + 2 * $i)
            $pc = Get-ColLetter (4 + 2 * $i)
            [void]$sb.Append((New-TextCell "$ac$r" $row.Answers[$i][0] 2))
            [void]$sb.Append((New-NumberCell "$pc$r" $row.Answers[$i][1] 4))
        }
        [void]$sb.Append("<c r=`"$approvedCol$r`" s=`"5`"/>")
        [void]$sb.Append((New-TextCell "T$r" $row.Note 2))
        [void]$sb.Append('</row>')
    }

    $cols = New-Object System.Text.StringBuilder
    [void]$cols.Append('<col min="1" max="1" width="14" customWidth="1"/>')
    [void]$cols.Append('<col min="2" max="2" width="46" customWidth="1"/>')
    for ($i = 0; $i -lt $MaxAnswers; $i++) {
        $a = 3 + 2 * $i; $p = $a + 1
        [void]$cols.Append("<col min=`"$a`" max=`"$a`" width=`"16`" customWidth=`"1`"/>")
        [void]$cols.Append("<col min=`"$p`" max=`"$p`" width=`"8`" customWidth=`"1`"/>")
    }
    [void]$cols.Append('<col min="19" max="19" width="11" customWidth="1"/>')
    [void]$cols.Append('<col min="20" max="20" width="30" customWidth="1"/>')

    $lastRow = [math]::Max($r, 2)
    $dvRange = "${approvedCol}2:${approvedCol}1000"
    return @"
$xmlHead
<worksheet xmlns="$nsMain" xmlns:r="$nsRel">
<dimension ref="A1:$lastCol$lastRow"/>
<sheetViews><sheetView workbookViewId="0"><pane ySplit="1" topLeftCell="A2" activePane="bottomLeft" state="frozen"/><selection pane="bottomLeft" activeCell="A2" sqref="A2"/></sheetView></sheetViews>
<sheetFormatPr defaultRowHeight="15"/>
<cols>$($cols.ToString())</cols>
<sheetData>$($sb.ToString())</sheetData>
<dataValidations count="1"><dataValidation type="list" allowBlank="1" showInputMessage="1" showErrorMessage="1" errorStyle="warning" errorTitle="Approved" error="Chọn Y (giữ) hoặc N (bỏ)." promptTitle="Duyệt" prompt="Y = giữ câu này, để trống hoặc N = bỏ." sqref="$dvRange"><formula1>"Y,N"</formula1></dataValidation></dataValidations>
<pageMargins left="0.7" right="0.7" top="0.75" bottom="0.75" header="0.3" footer="0.3"/>
</worksheet>
"@
}

function New-GuideSheetXml([string]$topic, $rowsByLevel) {
    $counts = ($LevelNames | ForEach-Object { "$_ $($rowsByLevel[$_].Count)" }) -join ' · '
    $lines = @(
        @("Bộ câu hỏi Classroom Feud - chủ đề: $topic", 3),
        @("Số câu: $counts", 0),
        @('', 0),
        @('Cách duyệt', 1),
        @('1. Mở từng sheet Starters, Movers, Flyers. Mỗi dòng là một câu hỏi (một vòng chơi).', 2),
        @('2. Sửa thoải mái: câu hỏi, đáp án, điểm. Có thể xoá dòng hoặc thêm dòng mới (tối đa 8 đáp án mỗi câu).', 2),
        @('3. Đáp án nên xếp từ phổ biến nhất (điểm cao nhất) xuống; tổng điểm một câu nên khoảng 100.', 2),
        @('4. Ở cột Approved (cột S), chọn Y cho những câu muốn giữ. Để trống hoặc N = không nhập vào game.', 2),
        @('5. Cột Note để ghi chú riêng, game bỏ qua cột này.', 2),
        @('6. Lưu file (.xlsx), rồi mở game Classroom Feud và dùng chức năng nhập Excel để đưa các câu đã duyệt vào thư viện câu hỏi của lớp.', 2),
        @('', 0),
        @('Lưu ý', 1),
        @('- Không đổi tên các sheet Starters, Movers, Flyers và không đổi dòng tiêu đề (dòng 1).', 2),
        @('- Các dòng cùng sheet và cùng Topic sẽ thành một bộ câu hỏi trong game, theo thứ tự dòng.', 2),
        @('- Giá trị được coi là đã duyệt: Y, Yes, X, ✓, OK, Có, Duyệt, 1, TRUE.', 2),
        @('- Nhập lại cùng cấp độ và Topic sẽ cập nhật bộ cũ: câu trùng được thay, câu mới được thêm vào cuối.', 2),
        @('- Game bỏ qua sheet Hướng dẫn này.', 2)
    )
    $sb = New-Object System.Text.StringBuilder
    $r = 0
    foreach ($l in $lines) {
        $r++
        [void]$sb.Append("<row r=`"$r`">$(New-TextCell "A$r" $l[0] $l[1])</row>")
    }
    return @"
$xmlHead
<worksheet xmlns="$nsMain" xmlns:r="$nsRel">
<dimension ref="A1:A$r"/>
<sheetViews><sheetView workbookViewId="0" showGridLines="0"/></sheetViews>
<sheetFormatPr defaultRowHeight="15"/>
<cols><col min="1" max="1" width="110" customWidth="1"/></cols>
<sheetData>$($sb.ToString())</sheetData>
<pageMargins left="0.7" right="0.7" top="0.75" bottom="0.75" header="0.3" footer="0.3"/>
</worksheet>
"@
}

$sheetNames = @('Hướng dẫn') + $LevelNames
$sheetXml = @{}
$sheetXml[1] = New-GuideSheetXml $defaultTopic $rowsByLevel
for ($i = 0; $i -lt $LevelNames.Count; $i++) { $sheetXml[$i + 2] = New-LevelSheetXml $rowsByLevel[$LevelNames[$i]] }

$sheetsEl = ''; $wbRels = ''; $ctOverrides = ''
for ($i = 1; $i -le $sheetNames.Count; $i++) {
    $sheetsEl += "<sheet name=`"$(Escape-Xml $sheetNames[$i - 1])`" sheetId=`"$i`" r:id=`"rId$i`"/>"
    $wbRels += "<Relationship Id=`"rId$i`" Type=`"$nsRel/worksheet`" Target=`"worksheets/sheet$i.xml`"/>"
    $ctOverrides += "<Override PartName=`"/xl/worksheets/sheet$i.xml`" ContentType=`"application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml`"/>"
}
$stylesRid = $sheetNames.Count + 1
$wbRels += "<Relationship Id=`"rId$stylesRid`" Type=`"$nsRel/styles`" Target=`"styles.xml`"/>"

$parts = [ordered]@{}
$parts['[Content_Types].xml'] = @"
$xmlHead
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
<Default Extension="xml" ContentType="application/xml"/>
<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>
$ctOverrides
<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
<Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>
</Types>
"@
$parts['_rels/.rels'] = @"
$xmlHead
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
<Relationship Id="rId1" Type="$nsRel/officeDocument" Target="xl/workbook.xml"/>
<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>
<Relationship Id="rId3" Type="$nsRel/extended-properties" Target="docProps/app.xml"/>
</Relationships>
"@
$now = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
$parts['docProps/core.xml'] = @"
$xmlHead
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<dc:title>Classroom Feud - $(Escape-Xml $defaultTopic)</dc:title>
<dc:creator>feud-questions skill</dc:creator>
<dcterms:created xsi:type="dcterms:W3CDTF">$now</dcterms:created>
<dcterms:modified xsi:type="dcterms:W3CDTF">$now</dcterms:modified>
</cp:coreProperties>
"@
$parts['docProps/app.xml'] = @"
$xmlHead
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties"><Application>Microsoft Excel</Application></Properties>
"@
$parts['xl/workbook.xml'] = @"
$xmlHead
<workbook xmlns="$nsMain" xmlns:r="$nsRel">
<bookViews><workbookView activeTab="1"/></bookViews>
<sheets>$sheetsEl</sheets>
</workbook>
"@
$parts['xl/_rels/workbook.xml.rels'] = @"
$xmlHead
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">$wbRels</Relationships>
"@
$parts['xl/styles.xml'] = $stylesXml
for ($i = 1; $i -le $sheetNames.Count; $i++) { $parts["xl/worksheets/sheet$i.xml"] = $sheetXml[$i] }

# ---------- Zip ----------
$outFull = Resolve-FullPath $OutputPath
$outDir = Split-Path -Parent $outFull
if ($outDir -and -not (Test-Path -LiteralPath $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }
if (Test-Path -LiteralPath $outFull) { Remove-Item -LiteralPath $outFull -Force }

$utf8 = New-Object System.Text.UTF8Encoding($false)
$fs = [System.IO.File]::Open($outFull, [System.IO.FileMode]::CreateNew)
try {
    $zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
    try {
        foreach ($name in $parts.Keys) {
            $entry = $zip.CreateEntry($name, [System.IO.Compression.CompressionLevel]::Optimal)
            $bytes = $utf8.GetBytes(($parts[$name] -replace "`r`n", "`n"))
            $s = $entry.Open()
            try { $s.Write($bytes, 0, $bytes.Length) } finally { $s.Dispose() }
        }
    } finally { $zip.Dispose() }
} finally { $fs.Dispose() }

$summary = ($LevelNames | ForEach-Object { "$_=$($rowsByLevel[$_].Count)" }) -join ', '
Write-Output "Wrote $outFull ($summary)"
foreach ($w in $warnings) { Write-Warning $w }
