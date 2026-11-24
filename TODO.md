# TODO

_Cập nhật: 2026-11-24 — commit e94bb62_

## Đang làm tiếp theo
1. Chờ người dùng thử quy trình: "tạo bộ câu hỏi chủ đề X" → duyệt file trong `question-sets/` → nhập vào game (Import Excel) → tạo lớp → chọn bộ → chơi.

## Session phụ đang chạy
| Tên | ID | Task | Nhánh | Trạng thái |
|-----|----|------|-------|------------|
| (không có) | | | | |

## Chờ (phụ thuộc / chờ người dùng)
- (trống)

## Đã xong gần đây
- Skill `feud-questions` (`.claude/skills/feud-questions/`, script `New-FeudWorkbook.ps1`) + mẫu `question-sets/feud-food-20261124.xlsx`.
- Game: Import Excel (chỉ nhập dòng Approved), thư viện bộ câu hỏi, quản lý lớp + lịch sử chơi; `classroom-feud/README.md`. Đã thử: file mẫu duyệt 9/18 câu → 3 bộ, 9 vòng, bỏ qua 9; không lỗi console.
- Copy game Classroom Feud từ Desktop vào `classroom-feud/` (bản gốc trên Desktop giữ nguyên).
- Viết `classroom-feud/EXCEL-FORMAT.md`: định dạng Excel chung cho skill và game.
- Skill `session-relay`, `CLAUDE.md`, file này.

## Ghi chú & quyết định đã chốt
- Mọi thay đổi commit và push lên https://github.com/trantrungg135family-tech/HSK, nhánh `main`. Repo public → không đưa PDF giáo trình lên (`*.pdf` đã ignore).
- Classroom Feud: bộ câu hỏi do Claude tạo qua skill (không dùng API key), xuất .xlsx (không dùng Google Sheets). Mỗi lớp (1A, 2A, 3A…) gắn một cấp Starters/Movers/Flyers; bộ câu hỏi lưu thành thư viện, dùng lại nhiều lần.
- Máy không có Python/Node; có PowerShell 5.1 và Excel.
