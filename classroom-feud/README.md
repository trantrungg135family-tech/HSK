# Classroom Feud

Trò chơi kiểu "Family Feud" cho lớp học tiếng Anh, gói trong một file duy nhất: `Classroom-Feud.html`. Mở file bằng Chrome hoặc Edge là chơi được; không cần cài đặt. Dữ liệu (câu hỏi, thư viện, lớp học, trận đang chơi) được lưu trên trình duyệt của máy đang dùng.

## Quy trình: Excel → duyệt → nhập → chơi theo lớp

1. **Tạo file câu hỏi.** Claude tạo file Excel theo chủ đề (vd. `question-sets/feud-food-20261124.xlsx`) với ba sheet `Starters`, `Movers`, `Flyers`. Định dạng chi tiết: [EXCEL-FORMAT.md](EXCEL-FORMAT.md).
2. **Duyệt.** Mở file trong Excel, đọc từng câu, sửa nếu cần. Ghi `Y` (hoặc `X`, `✓`, `OK`, `Có`, `Duyệt`, `1`, `TRUE`) vào cột **Approved** của những câu muốn dùng. Để trống hoặc ghi `N` = không nhập. Lưu file.
3. **Nhập vào game.** Trên màn hình Thiết lập, ở mục **Lớp học & thư viện câu hỏi**, bấm **Nhập Excel** rồi chọn file. Lần đầu cần có Internet để tải bộ đọc Excel.
   - Chỉ các dòng đã duyệt được nhập. Mỗi chủ đề trên một sheet thành **một bộ** trong thư viện (vd. *Movers · Food*).
   - Dòng có lỗi (thiếu câu hỏi, điểm không phải số 0–999, …) bị bỏ qua; bảng kết quả ghi rõ sheet và số dòng để sửa trong Excel rồi nhập lại.
   - Nhập lại cùng cấp độ + chủ đề sẽ **cập nhật** bộ cũ: câu trùng nội dung được thay bằng bản mới, câu mới được thêm vào cuối.
4. **Tạo lớp.** Bấm **Quản lý lớp**, thêm từng lớp với cấp độ của lớp (vd. `1A` · Starters, `2A` · Movers, `3A` · Flyers). Có thể sửa tên, đổi cấp độ hoặc xóa lớp.
5. **Chọn lớp và bộ câu hỏi.** Chọn lớp trong ô **Lớp**. Game hiện các bộ của cấp độ lớp đó kèm lịch sử: "Đã chơi N lần · lần cuối dd/mm/yyyy". Bộ lớp **chưa chơi** được tô vàng và xếp lên đầu. Bấm **Dùng bộ này** để nạp câu hỏi vào phần soạn (tên trò chơi = chủ đề; tên đội, hệ số nhân, thời gian giữ nguyên).
6. **Chơi.** Bấm **Xem trước** để kiểm tra, rồi **Bắt đầu**. Khi bắt đầu, lượt chơi được ghi vào lịch sử của lớp. Các lớp cùng cấp độ dùng chung bộ câu hỏi, nhưng mỗi lớp có lịch sử riêng.

## Thư viện câu hỏi

Bấm **Thư viện câu hỏi** để xem mọi bộ theo cấp độ, tìm theo chủ đề, xem nội dung từng vòng, hoặc xóa bộ.

- **Sao lưu thư viện**: xuất toàn bộ bộ câu hỏi và lớp học (kèm lịch sử) ra một file `.json`. Nên làm định kỳ, vì dữ liệu chỉ nằm trên trình duyệt của máy này.
- **Khôi phục bản sao lưu**: nạp file sao lưu trên máy khác; dữ liệu được gộp vào thư viện hiện có.
- **Xóa toàn bộ dữ liệu** (thanh dưới cùng) không xóa thư viện và danh sách lớp.

Các chức năng cũ (câu hỏi mẫu, Nhập/Xuất file JSON, Bộ đã lưu) vẫn dùng như trước.
