# Ngân hàng câu hỏi trên Google Sheets

Đây là "hợp đồng" giữa Claude (người nhập câu hỏi vào sheet) và game (`Classroom-Feud.html`, phần Game setup đọc sheet). Bên nào đổi định dạng thì sửa cả hai và file này.

- Sheet: **NGÂN HÀNG CÂU HỎI CLASSROOM FEUD**
- ID: `17W9UR-HAxUWoh-Lb8RQV37EIOTfJ30ZDTOHhBDUfOv8`
- Link: https://docs.google.com/spreadsheets/d/17W9UR-HAxUWoh-Lb8RQV37EIOTfJ30ZDTOHhBDUfOv8/edit
- Chia sẻ: ai có link đều xem và sửa được (chủ sheet chọn giữ như vậy).

## Tab

| Tab | sheetId | Nội dung |
|---|---|---|
| `Hướng dẫn` | 0 | Hướng dẫn duyệt (game bỏ qua) |
| `Starters` | 1 | Cấp Starters (Pre A1) |
| `Movers` | 2 | Cấp Movers (A1) |
| `Flyers` | 3 | Cấp Flyers (A2) |
| `KET` | 4 | Cấp A2 Key for Schools (KET) |

Không đổi tên tab hay tiêu đề cột: game đọc theo đúng tên.

## Cột (giống nhau ở 4 tab cấp độ)

Dòng 1 là tiêu đề, mỗi dòng sau là **một câu hỏi = một vòng chơi**.

| Cột | Tiêu đề | Nội dung |
|---|---|---|
| A | `Set` | Tên bộ: `<Cấp> <số>`, vd. `Starters 1`, `KET 3` |
| B | `Topic` | Chủ đề của câu hỏi, vd. `Food`, `Animals` |
| C | `Question` | Câu hỏi tiếng Anh, tối đa 200 ký tự |
| D, F, H, J, L, N, P, R | `Answer 1` … `Answer 8` | Đáp án, tối đa 80 ký tự |
| E, G, I, K, M, O, Q, S | `Points 1` … `Points 8` | Điểm, số nguyên 0–999 |
| T | `Approved` | Ô duyệt (dropdown Y/N). Trống = chưa duyệt |
| U | `Note` | Ghi chú (game bỏ qua) |

- Mỗi **bộ** có **5 câu**, mỗi câu một chủ đề khác nhau (chọn ngẫu nhiên từ chương trình Cambridge của cấp đó và đời sống thực tế của học sinh ở độ tuổi đó). Mỗi cấp 5–10 bộ.
- Các dòng của một bộ nằm liền nhau, theo thứ tự `Starters 1`, `Starters 2`, … Thêm bộ mới thì nối tiếp xuống dưới với số tiếp theo.
- Mỗi câu 5–6 đáp án, xếp điểm giảm dần, tổng điểm khoảng 100.
- Giá trị duyệt hợp lệ giống `EXCEL-FORMAT.md`: `Y`, `Yes`, `X`, `✓`, `✔`, `OK`, `Có`, `Co`, `Duyệt`, `1`, `TRUE` (không phân biệt hoa thường).

## Cách game đọc

Game đọc từng tab dạng CSV công khai, không cần đăng nhập:

```
https://docs.google.com/spreadsheets/d/<ID>/gviz/tq?tqx=out:csv&headers=1&sheet=<Tab>
```

Game chỉ lấy dòng đã duyệt, gom theo cột `Set`, và chỉ hiện những bộ có ít nhất một câu đã duyệt.
