# TODO

_Cập nhật: 2026-11-24 — bàn giao trước khi người dùng đổi tài khoản Claude (lần 2). Commit trước đó: e88242d_

## Đang làm tiếp theo
1. Đọc file này, chạy `git pull` (Git ở `C:\Program Files\Git\cmd\git.exe` nếu `git` không có trong PATH).
2. Hỏi người dùng đã thử game chưa (âm thanh, ánh sáng, tải Google Sheet khi mở bằng bấm đúp) và có muốn đổi gì không.
3. Câu hỏi đang chờ người dùng trả lời: **làm 3 cải thiện UI/UX ưu tiên** hay chưa? Ba việc đó, trong `classroom-feud/Classroom-Feud.html`:
   - Thanh điều khiển giáo viên (`.controls`, phím H đã có) tự thu thành dải mỏng khi không di chuột, để màn chiếu gọn.
   - Câu hỏi (`#question`) to hơn khoảng 1,5 lần.
   - Thông báo trong vòng (`#roundNote`, ví dụ "Team B stole 44 points!") và 3 ô X (`#strikes`) to hơn, đặt giữa.
   Các đề xuất khác (làm sau nếu người dùng muốn): chia màn thiết lập thành bước/thẻ (Chọn bộ / Cài đặt / Sửa câu hỏi); đưa thẻ Google Sheet lên trên thẻ Excel; màn kết quả thêm bục xếp hạng hoặc biểu đồ điểm theo vòng.
4. Chờ người dùng duyệt câu hỏi trong Google Sheet (cột Approved = Y) rồi thử thật: Game setup → Question bank (Google Sheet) → chọn cấp → chọn bộ → Start.
5. Khi người dùng đưa chủ đề hoặc xin thêm bộ: dùng skill `feud-questions`, ghi tiếp vào tab đúng cấp với số bộ tiếp theo (Starters 6, Movers 6…). Nếu cần sửa sheet bằng connector: kiểm tra tài khoản mới mở được sheet `17W9UR-HAxUWoh-Lb8RQV37EIOTfJ30ZDTOHhBDUfOv8`; game thì đọc sheet công khai, không cần connector.

## Session phụ đang chạy
| Tên | ID | Task | Nhánh | Trạng thái |
|-----|----|------|-------|------------|
| (không có) | | | | |

## Chờ (phụ thuộc / chờ người dùng)
- Người dùng chọn có làm 3 cải thiện UI/UX ở trên không.
- Người dùng nghe/xem thử âm thanh và ánh sáng trên loa/máy chiếu thật, góp ý tiếng hoặc hiệu ứng muốn đổi.
- Người dùng duyệt 100 câu trong Google Sheet.

## Đã xong gần đây
- Light show (e88242d): nút bóng đèn trên thanh trên → khung 8 hiệu ứng ánh sáng vẽ bằng canvas (`const Lights`, canvas `#lsBack` sau app và `#lsFront` trước app): đèn pha, hào quang đội, chớp máy ảnh, tia vàng, đèn báo đỏ, bụi vàng, disco, nhịp tim đồng hồ. Mỗi cái bật/tắt + nút Thử; preset Tắt/Nhẹ nhàng/Đã đời (mặc định Đã đời); lưu ở `localStorage` key `feud.v1.lights`. Máy bật "giảm chuyển động" thì tắt ánh sáng + pháo giấy, trừ khi tích ô "Vẫn chạy…". Đã thử trong trình duyệt 1280×720: top answer, 3 lần sai, cướp điểm, màn kết quả, không lỗi console. Mô tả trong `classroom-feud/SOUNDS.md`.
- Phân tích UI/UX đã gửi người dùng trong chat (tóm tắt ở mục "Đang làm tiếp theo" 3).
- Sửa tải Google Sheet khi giáo viên mở game bằng bấm đúp (file://): Google không trả CORS cho origin `null` → game chuyển sang JSONP (`gsFetchTabJsonp` + `gsTableToCsv`); đã so khớp từng ký tự với CSV ở cả 4 tab.
- Âm thanh: 15 âm CC0 từ itch.io (Kronbits *200 Free SFX*, ObsydianX *Interface SFX Pack 1*) nhúng base64 Opus trong `Classroom-Feud.html` (`SFX_DATA`, phối trong `MIX` của module `Sound`, âm tổng hợp làm dự phòng). Hiệu ứng: nhãn TOP ANSWER, +điểm bay từ ô, pháo giấy, bảng rung khi sai, giọng "Time out!". Bảng ánh xạ trong `classroom-feud/SOUNDS.md`. Chưa nghe trên loa thật.
- Google Sheet ngân hàng câu hỏi: tab `Hướng dẫn`, `Starters`, `Movers`, `Flyers`, `KET`; mỗi cấp 5 bộ × 5 câu, cột Approved đang trống.
- Trước đó: thẻ Question bank (Google Sheet) trong game, cấp KET, skill `feud-questions` ghi vào sheet, Import Excel, thư viện bộ câu hỏi, quản lý lớp + lịch sử chơi, skill `session-relay`.

## Ghi chú & quyết định đã chốt
- Mọi thay đổi commit và push lên https://github.com/trantrungg135family-tech/HSK, nhánh `main`. Repo public → không đưa PDF giáo trình lên (`*.pdf` đã ignore). Commit dùng email noreply của GitHub; đăng nhập GitHub đã lưu trên máy (Git Credential Manager), không phụ thuộc tài khoản Claude.
- Ngân hàng câu hỏi chính: Google Sheet https://docs.google.com/spreadsheets/d/17W9UR-HAxUWoh-Lb8RQV37EIOTfJ30ZDTOHhBDUfOv8/edit — định dạng trong `classroom-feud/SHEET-BANK.md`. Bộ = 5 câu chủ đề trộn, đặt tên `<Cấp> <số>`. Giữ bước duyệt Approved. Người dùng chọn giữ quyền "ai có link đều sửa được" (đã cảnh báo rủi ro).
- Mỗi lớp (1A, 2A, 3A…) gắn một cấp Starters/Movers/Flyers/KET; game nhớ lớp đã chơi bộ nào. Vẫn giữ Import Excel (`classroom-feud/EXCEL-FORMAT.md`) + thư viện cục bộ.
- Game vẫn là **một file HTML duy nhất** (âm thanh nhúng sẵn) — giữ nguyên nguyên tắc này. Chỉ dùng tài nguyên CC0 khi thêm âm thanh/hình (repo public).
- Máy không có Python/Node/ffmpeg; có PowerShell 5.1 và Excel. Thử game: phục vụ `classroom-feud/` qua localhost bằng script PowerShell HttpListener nhỏ (tự viết lại, ~25 dòng). Trình duyệt tích hợp của app bật sẵn "giảm chuyển động" → khi thử ánh sáng phải tích ô "Vẫn chạy…" trong khung Light show. Giáo viên mở game bằng bấm đúp (file://) → luôn kiểm tra cả đường JSONP khi đụng tới phần tải sheet.
- itch.io: trang danh sách có Cloudflare chặn bot (không vượt); trang từng gói vào được. Tải gói miễn phí: POST `/<slug>/download_url` lấy trang tải, bấm nút Download và bắt URL CDN (hết hạn 60 giây) rồi `curl`. Cẩn thận trình duyệt tích hợp có thể tự lưu file zip vào thư mục dự án — kiểm tra `git status` trước khi commit.
- Bản gốc game trên Desktop (`C:\Users\Admin\Desktop\CLASSROOM FEUD`) là bản cũ; bản đang phát triển ở `classroom-feud/`.
