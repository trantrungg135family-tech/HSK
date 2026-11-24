# Classroom Feud

Trò chơi kiểu "Family Feud" cho lớp học tiếng Anh, gói trong một file duy nhất: `Classroom-Feud.html`. Mở file bằng Chrome hoặc Edge là chơi được; không cần cài đặt. Dữ liệu (câu hỏi, thư viện, lớp học, trận đang chơi) được lưu trên trình duyệt của máy đang dùng.

Âm thanh và hiệu ứng (ô điểm cao nhất, vòng nhân điểm, sai, cướp điểm…) lấy từ các gói CC0 trên itch.io và được nhúng sẵn trong file: xem [SOUNDS.md](SOUNDS.md).

## Quy trình chính: Google Sheet → duyệt → chọn bộ → chơi

Ngân hàng câu hỏi chính là Google Sheet **NGÂN HÀNG CÂU HỎI CLASSROOM FEUD** ([mở sheet](https://docs.google.com/spreadsheets/d/17W9UR-HAxUWoh-Lb8RQV37EIOTfJ30ZDTOHhBDUfOv8/edit)). Định dạng chi tiết: [SHEET-BANK.md](SHEET-BANK.md).

1. **Câu hỏi trong sheet.** Mỗi cấp độ một tab: `Starters`, `Movers`, `Flyers`, `KET`. Mỗi cấp có 5–10 bộ tên `Starters 1`, `Starters 2`, …; mỗi bộ 5 câu, mỗi câu một chủ đề khác nhau. Mỗi dòng là một câu = một vòng chơi.
2. **Duyệt.** Đọc câu hỏi trong sheet, sửa nếu cần, rồi ghi `Y` (hoặc `X`, `✓`, `OK`, `Có`, `Duyệt`, `1`, `TRUE`) vào cột **Approved** của câu muốn dùng. Để trống hoặc `N` = chưa duyệt, game bỏ qua câu đó. Bộ chỉ hiện trong game khi có ít nhất một câu đã duyệt.
3. **Tạo lớp** (làm một lần). Bấm **Quản lý lớp**, thêm từng lớp với cấp độ (vd. `1A` · Starters, `2A` · Movers, `3A` · Flyers, `4A` · KET (A2 Key)).
4. **Chọn lớp → cấp độ → bộ.** Trên màn hình Thiết lập, chọn lớp trong ô **Lớp**. Ở mục **Ngân hàng câu hỏi (Google Sheet)**, ô **Cấp độ** tự chuyển theo cấp của lớp (có thể đổi tay). Danh sách hiện từng bộ theo thứ tự trong sheet, vd. *Movers 3 — 5 câu: Food, Weather, …* kèm lịch sử của lớp: "Đã chơi N lần · lần cuối dd/mm/yyyy". Bộ lớp **chưa chơi** được tô vàng. Bấm **Xem** để đọc trước, **Dùng bộ này** để nạp vào phần soạn (tên trò chơi = tên bộ; tên đội, hệ số nhân, thời gian giữ nguyên).
5. **Chơi.** Bấm **Xem trước** để kiểm tra, rồi **Bắt đầu**. Khi bắt đầu, bộ được ghi vào lịch sử của lớp.

Ghi chú:

- Mỗi lần mở game, game tự tải lại sheet. Sau khi sửa hoặc duyệt thêm trong sheet, bấm **Tải lại**.
- Game lưu bản tải gần nhất trên trình duyệt, nên khi mất mạng vẫn chọn bộ được; dòng trạng thái ghi "Dữ liệu lúc …".
- Dòng đã duyệt nhưng có lỗi (thiếu câu hỏi, đáp án thiếu điểm, điểm không phải số 0–999, …) bị bỏ qua; bấm **Xem lỗi** để biết số dòng cần sửa trong sheet.
- Thông báo lỗi thường gặp: *mất mạng*; *sheet chưa chia sẻ* (Chia sẻ → Quyền truy cập chung → "Bất kỳ ai có đường liên kết"); *không thấy tab hoặc tiêu đề cột bị đổi*; *chưa có bộ nào được duyệt* (ghi `Y` vào cột Approved).
- Muốn dùng sheet khác: bấm **Link Google Sheet**, dán link (hoặc ID) của sheet rồi bấm **Lưu và tải**. Sheet mới phải có cùng tên tab và tiêu đề cột. Game chỉ đọc sheet, không bao giờ sửa sheet.

## Cách cũ: Excel → duyệt → nhập → chơi theo lớp

Vẫn dùng được, song song với Google Sheet.

1. **Tạo file câu hỏi.** Claude tạo file Excel theo chủ đề (vd. `question-sets/feud-food-20261124.xlsx`) với các sheet `Starters`, `Movers`, `Flyers`, `KET`. Định dạng chi tiết: [EXCEL-FORMAT.md](EXCEL-FORMAT.md).
2. **Duyệt.** Mở file trong Excel, đọc từng câu, sửa nếu cần. Ghi `Y` (hoặc `X`, `✓`, `OK`, `Có`, `Duyệt`, `1`, `TRUE`) vào cột **Approved** của những câu muốn dùng. Để trống hoặc ghi `N` = không nhập. Lưu file.
3. **Nhập vào game.** Trên màn hình Thiết lập, ở mục **Lớp học & thư viện câu hỏi**, bấm **Nhập Excel** rồi chọn file. Lần đầu cần có Internet để tải bộ đọc Excel.
   - Chỉ các dòng đã duyệt được nhập. Mỗi chủ đề trên một sheet thành **một bộ** trong thư viện (vd. *Movers · Food*).
   - Dòng có lỗi (thiếu câu hỏi, điểm không phải số 0–999, …) bị bỏ qua; bảng kết quả ghi rõ sheet và số dòng để sửa trong Excel rồi nhập lại.
   - Nhập lại cùng cấp độ + chủ đề sẽ **cập nhật** bộ cũ: câu trùng nội dung được thay bằng bản mới, câu mới được thêm vào cuối.
4. **Tạo lớp.** Bấm **Quản lý lớp**, thêm từng lớp với cấp độ của lớp (vd. `1A` · Starters, `2A` · Movers, `3A` · Flyers). Có thể sửa tên, đổi cấp độ hoặc xóa lớp.
5. **Chọn lớp và bộ câu hỏi.** Chọn lớp trong ô **Lớp**. Game hiện các bộ của cấp độ lớp đó kèm lịch sử: "Đã chơi N lần · lần cuối dd/mm/yyyy". Bộ lớp **chưa chơi** được tô vàng và xếp lên đầu (đây là các bộ đã nhập từ Excel; bộ trong Google Sheet nằm ở mục riêng ngay bên dưới). Bấm **Dùng bộ này** để nạp câu hỏi vào phần soạn (tên trò chơi = chủ đề; tên đội, hệ số nhân, thời gian giữ nguyên).
6. **Chơi.** Bấm **Xem trước** để kiểm tra, rồi **Bắt đầu**. Khi bắt đầu, lượt chơi được ghi vào lịch sử của lớp. Các lớp cùng cấp độ dùng chung bộ câu hỏi, nhưng mỗi lớp có lịch sử riêng.

## Thư viện câu hỏi

Bấm **Thư viện câu hỏi** để xem mọi bộ theo cấp độ, tìm theo chủ đề, xem nội dung từng vòng, hoặc xóa bộ.

- **Sao lưu thư viện**: xuất toàn bộ bộ câu hỏi và lớp học (kèm lịch sử) ra một file `.json`. Nên làm định kỳ, vì dữ liệu chỉ nằm trên trình duyệt của máy này.
- **Khôi phục bản sao lưu**: nạp file sao lưu trên máy khác; dữ liệu được gộp vào thư viện hiện có.
- **Xóa toàn bộ dữ liệu** (thanh dưới cùng) không xóa thư viện, danh sách lớp và link Google Sheet.

Các chức năng cũ (câu hỏi mẫu, Nhập/Xuất file JSON, Bộ đã lưu) vẫn dùng như trước.
