# TODO

_Cập nhật: 2026-11-24 — commit e94bb62_

## Đang làm tiếp theo
1. Chờ người dùng duyệt câu hỏi trong Google Sheet (Approved = Y) và thử chọn cấp → bộ trong Game setup. Chưa thử game với dòng đã duyệt trên sheet thật (session phụ đã thử bằng CSV giả).

## Session phụ đang chạy
| Tên | ID | Task | Nhánh | Trạng thái |
|-----|----|------|-------|------------|
| (không có) | | | | |

## Chờ (phụ thuộc / chờ người dùng)
- (trống)

## Đã xong gần đây
- Google Sheet ngân hàng câu hỏi: 4 tab × 5 bộ × 5 câu (100 câu), tổng điểm mỗi câu 90–110. Game có thẻ "Question bank (Google Sheet)" + cấp KET. Skill `feud-questions` giờ ghi thẳng vào sheet.
- Skill `feud-questions` (`.claude/skills/feud-questions/`, script `New-FeudWorkbook.ps1`) + mẫu `question-sets/feud-food-20261124.xlsx`.
- Game: Import Excel (chỉ nhập dòng Approved), thư viện bộ câu hỏi, quản lý lớp + lịch sử chơi; `classroom-feud/README.md`. Đã thử: file mẫu duyệt 9/18 câu → 3 bộ, 9 vòng, bỏ qua 9; không lỗi console.
- Copy game Classroom Feud từ Desktop vào `classroom-feud/` (bản gốc trên Desktop giữ nguyên).
- Viết `classroom-feud/EXCEL-FORMAT.md`: định dạng Excel chung cho skill và game.
- Skill `session-relay`, `CLAUDE.md`, file này.

## Ghi chú & quyết định đã chốt
- Mọi thay đổi commit và push lên https://github.com/trantrungg135family-tech/HSK, nhánh `main`. Repo public → không đưa PDF giáo trình lên (`*.pdf` đã ignore).
- Classroom Feud: bộ câu hỏi do Claude tạo qua skill (không dùng API key), xuất .xlsx (không dùng Google Sheets). Mỗi lớp (1A, 2A, 3A…) gắn một cấp Starters/Movers/Flyers; bộ câu hỏi lưu thành thư viện, dùng lại nhiều lần.
- Máy không có Python/Node; có PowerShell 5.1 và Excel.
- Ngân hàng câu hỏi chính là Google Sheet `17W9UR-HAxUWoh-Lb8RQV37EIOTfJ30ZDTOHhBDUfOv8` (xem `classroom-feud/SHEET-BANK.md`): tab Starters/Movers/Flyers/KET, bộ 5 câu chủ đề trộn, 5 bộ mỗi cấp, giữ bước duyệt Approved. Người dùng chọn giữ quyền "ai có link đều sửa được". Vẫn giữ Import Excel + thư viện + lớp.
