# TODO

_Cập nhật: 2026-11-24 — bàn giao trước khi người dùng đổi tài khoản Claude. Commit trước đó: 787d3e3_

## Đang làm tiếp theo
1. Đọc file này, chạy `git pull` (Git ở `C:\Program Files\Git\cmd\git.exe` nếu `git` không có trong PATH).
2. Kiểm tra tài khoản mới có Google Sheets connector và mở được sheet `17W9UR-HAxUWoh-Lb8RQV37EIOTfJ30ZDTOHhBDUfOv8` (dùng `get_spreadsheet` với `fields: ["sheets.properties"]`). Nếu không mở được: nhờ người dùng bật/kết nối Google Sheets connector, hoặc chia sẻ sheet cho tài khoản Google của connector. Game vẫn đọc sheet công khai, không phụ thuộc connector.
3. Chờ người dùng duyệt câu hỏi trong sheet (cột Approved = Y) rồi thử thật trong game: Game setup → Question bank (Google Sheet) → chọn cấp → chọn bộ → Start. Việc này chưa được thử với dòng đã duyệt trên sheet thật (session phụ chỉ thử bằng CSV giả).
4. Khi người dùng đưa chủ đề hoặc xin thêm bộ: dùng skill `feud-questions`, ghi tiếp vào tab đúng cấp với số bộ tiếp theo (Starters 6, Movers 6…).

## Session phụ đang chạy
| Tên | ID | Task | Nhánh | Trạng thái |
|-----|----|------|-------|------------|
| (không có) | | | | |

## Chờ (phụ thuộc / chờ người dùng)
- Người dùng duyệt 100 câu trong Google Sheet.

## Đã xong gần đây
- Google Sheet ngân hàng câu hỏi: tab `Hướng dẫn`, `Starters`, `Movers`, `Flyers`, `KET`; mỗi cấp 5 bộ × 5 câu (100 câu), tổng điểm mỗi câu 90–110, cột Approved có dropdown Y/N và đang trống.
- Game (`classroom-feud/Classroom-Feud.html`): thẻ "Question bank (Google Sheet)" (chọn cấp → bộ, Refresh, Sheet link, cache offline), thêm cấp KET ở mọi nơi. Đã thử: tải sheet thật được, báo đúng "chưa có bộ nào được duyệt".
- Skill `feud-questions` giờ ghi thẳng vào Google Sheet; chỉ xuất .xlsx khi người dùng xin file Excel.
- Trước đó: Import Excel, thư viện bộ câu hỏi, quản lý lớp + lịch sử chơi; 4 file Excel Movers (Food, School Activities, Classroom, Clothes) trong `question-sets/`.
- Skill `session-relay`, `CLAUDE.md`, file này.

## Ghi chú & quyết định đã chốt
- Mọi thay đổi commit và push lên https://github.com/trantrungg135family-tech/HSK, nhánh `main`. Repo public → không đưa PDF giáo trình lên (`*.pdf` đã ignore). Commit dùng email noreply của GitHub; đăng nhập GitHub đã lưu trên máy (Git Credential Manager), không phụ thuộc tài khoản Claude.
- Ngân hàng câu hỏi chính: Google Sheet https://docs.google.com/spreadsheets/d/17W9UR-HAxUWoh-Lb8RQV37EIOTfJ30ZDTOHhBDUfOv8/edit — định dạng trong `classroom-feud/SHEET-BANK.md`. Bộ = 5 câu chủ đề trộn, đặt tên `<Cấp> <số>`. Giữ bước duyệt Approved. Người dùng chọn giữ quyền "ai có link đều sửa được" (đã cảnh báo rủi ro).
- Mỗi lớp (1A, 2A, 3A…) gắn một cấp Starters/Movers/Flyers/KET; game nhớ lớp đã chơi bộ nào. Vẫn giữ Import Excel (`classroom-feud/EXCEL-FORMAT.md`) + thư viện cục bộ.
- Máy không có Python/Node; có PowerShell 5.1 và Excel. Thử game trong trình duyệt: phục vụ thư mục `classroom-feud/` qua localhost bằng một script PowerShell HttpListener nhỏ (file:// chặn fetch).
- Bản gốc game trên Desktop (`C:\Users\Admin\Desktop\CLASSROOM FEUD`) là bản cũ; bản đang phát triển ở `classroom-feud/`.
