# TODO

_Cập nhật: 2026-11-24 — bàn giao trước khi người dùng đổi tài khoản Claude (lần 2). Commit trước đó: e88242d_

## Đang làm tiếp theo
1. Đọc file này, chạy `git pull` (Git ở `C:\Program Files\Git\cmd\git.exe` nếu `git` không có trong PATH).
2. Hỏi người dùng đã thử game chưa (âm thanh, ánh sáng, tải Google Sheet khi mở bằng bấm đúp) và có muốn đổi gì không.
3. Ba cải thiện UI/UX màn chơi đã xong (xem "Đã xong gần đây"); nhờ người dùng thử trên máy chiếu thật.
   Các đề xuất khác (làm sau nếu người dùng muốn): chia màn thiết lập thành bước/thẻ (Chọn bộ / Cài đặt / Sửa câu hỏi); đưa thẻ Google Sheet lên trên thẻ Excel; màn kết quả thêm biểu đồ điểm theo vòng (bục xếp hạng đã có).
4. Chờ người dùng duyệt câu hỏi trong Google Sheet (cột Approved = Y) rồi thử thật: Game setup → Question bank (Google Sheet) → chọn cấp → chọn bộ → Start.
5. Khi người dùng đưa chủ đề hoặc xin thêm bộ: dùng skill `feud-questions`, ghi tiếp vào tab đúng cấp với số bộ tiếp theo (Starters 6, Movers 6…). Nếu cần sửa sheet bằng connector: kiểm tra tài khoản mới mở được sheet `17W9UR-HAxUWoh-Lb8RQV37EIOTfJ30ZDTOHhBDUfOv8`; game thì đọc sheet công khai, không cần connector.

## Session phụ đang chạy
| Tên | ID | Task | Nhánh | Trạng thái |
|-----|----|------|-------|------------|
| (không có) | | | | |

## Chờ (phụ thuộc / chờ người dùng)
- Người dùng nghe/xem thử âm thanh và ánh sáng trên loa/máy chiếu thật, góp ý tiếng hoặc hiệu ứng muốn đổi.
- Người dùng duyệt 100 câu trong Google Sheet.

## Đã xong gần đây
- Ô gõ đáp án (`#ansBar`, `const AM` so khớp + `const Ans`): giáo viên gõ câu học sinh nói + Enter → khớp đáp án ẩn thì mở ô (trống dồn ngắn), đã mở thì báo "đã có trên bảng", không khớp thì tính sai; khi cướp điểm thì khớp = cướp thành công, không = thất bại; chưa chắc thì hỏi "Có phải ý là…?" (Enter / Backspace / Esc). Phím `/` hoặc Enter để vào ô, Esc thoát; tắt trong Thông tin trò chơi (`cfg.answerBox`). Đáp án ghi `TV / Television` chỉ hiện "TV". Bảng thử so khớp 79/79; đã thử trong trình duyệt: đúng, chữ hoa/dấu câu, sai chính tả, số nhiều, chứa từ, đã mở, sai → X, 3 sai → cướp, cướp đúng/sai, hỏi lại cả 2 lựa chọn, vòng ×2, hoàn tác, phím tắt không chạy khi gõ, VI, không lỗi console. Chưa thử trên máy chiếu thật.
- Hiệu ứng vui (9 mục đã duyệt trong `classroom-feud/PROPOSAL-FX.md`): trống dồn khi giữ phím số/giữ chuột trên ô (bấm nhanh vẫn mở ngay); tiếng khán giả reo/vỗ tay (Gregor Quendel, **CC BY 4.0** — ghi công trong `SOUNDS.md` và mục Cách chơi) + tiếng "ôi…" tổng hợp khi sai; giọng đọc tiếng Anh giọng nữ Kenney (CC0): 3-2-1-go, Round n / Final round, Correct, Wrong, Hurry up, Congratulations / It's a tie, Ready-Go khi bấm chuông; khung Âm thanh có mức Lớp yên tĩnh / Bình thường / Sân khấu + công tắc khán giả / giọng / trống; Light show thêm "Pháo hoa sao" (màu đội) và "Băng rôn và vương miện" (vương miện đội dẫn, LEAD CHANGE!, 🔥 3 IN A ROW / ON FIRE, bục nảy); bấm chuông face-off (Q / P, nút Bấm chuông hoặc phím O, tùy chọn tự chạy đầu mỗi vòng trong Thông tin trò chơi); màn kết quả có bục xếp hạng + 5 giải MVP. File game 388 → ~538 KB. Thử ở 1280×720 và 1920×1080 (face-off, trống dồn phím + chuột, chuỗi 3/5, cướp điểm, đổi ngôi, vòng ×2, kết quả, VI, hoàn tác), 36 âm giải mã được, không lỗi console. Chưa xem được lúc pháo hoa nổ (khung trình duyệt bị ẩn) và chưa nghe trên loa thật.
- Thanh điều khiển (`#consoleWrap`, `const CtlBar`) tự thu thành dải 12 px ở mép dưới sau 3 giây chuột không ở gần; hiện lại khi đưa chuột xuống mép, Tab vào, hoặc chạm dải. Không thu khi đang mở Points/Sound/Lights, hộp thoại, hay đang chờ cướp điểm; phím tắt và phím H vẫn chạy.
- Câu hỏi (`#question`) to ~1,5 lần (`clamp(26px,min(5vw,8.1vh),90px)`); câu dài (tới 200 ký tự) tự thu nhỏ bằng `fitQuestion()` để không chèn bảng (đã thử 1280×720, 1920×1080, 600×900).
- 3 ô X (`#strikes`) to hơn và nằm giữa ngay dưới câu hỏi, trên bảng; thông báo vòng (`#roundNote`) thành nhãn vàng to đặt cạnh ô X; đồng hồ đặt bên phải hàng đó.
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
- Game có link web cố định (GitHub Pages, bật 2026-11-25, nguồn: nhánh `main`, thư mục gốc): https://trantrungg135family-tech.github.io/HSK/classroom-feud/Classroom-Feud.html — mỗi lần push lên `main` thì link tự cập nhật sau ~1 phút. Dữ liệu lớp/thư viện ở bản web lưu riêng với bản mở bằng file.
- Bản gốc game trên Desktop (`C:\Users\Admin\Desktop\CLASSROOM FEUD`) là bản cũ; bản đang phát triển ở `classroom-feud/`.
