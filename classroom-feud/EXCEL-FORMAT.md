# Định dạng Excel cho bộ câu hỏi Classroom Feud

Đây là "hợp đồng" chung giữa skill tạo câu hỏi (`.claude/skills/feud-questions`) và chức năng nhập Excel của game (`classroom-feud/Classroom-Feud.html`). Bên nào đổi định dạng thì phải sửa cả hai và file này.

## Workbook

Một file `.xlsx` cho mỗi chủ đề, tên gợi ý: `feud-<chu-de>-<YYYYMMDD>.xlsx` (vd. `feud-food-20261124.xlsx`).

Các sheet:

| Sheet | Nội dung |
|---|---|
| `Hướng dẫn` | Hướng dẫn duyệt ngắn bằng tiếng Việt (game bỏ qua sheet này) |
| `Starters` | Câu hỏi cấp Starters (Pre A1) |
| `Movers` | Câu hỏi cấp Movers (A1) |
| `Flyers` | Câu hỏi cấp Flyers (A2) |

Game chỉ đọc các sheet có tên là `Starters`, `Movers`, `Flyers` (không phân biệt hoa thường, bỏ khoảng trắng thừa). Sheet khác bị bỏ qua.

## Cột trên mỗi sheet cấp độ

Dòng 1 là tiêu đề. Mỗi dòng từ dòng 2 trở đi là **một câu hỏi (một vòng chơi)**.

| Cột | Tiêu đề | Nội dung |
|---|---|---|
| A | `Topic` | Chủ đề, vd. `Food` (cùng chủ đề trong một sheet = một bộ) |
| B | `Question` | Câu hỏi tiếng Anh, tối đa 200 ký tự |
| C, E, G, I, K, M, O, Q | `Answer 1` … `Answer 8` | Đáp án, tối đa 80 ký tự |
| D, F, H, J, L, N, P, R | `Points 1` … `Points 8` | Điểm, số nguyên 0–999 |
| S | `Approved` | Ô duyệt. Để trống = chưa duyệt |
| T | `Note` | Ghi chú của người duyệt (game bỏ qua) |

- Cặp đáp án/điểm để trống thì bỏ qua. Mỗi câu hỏi cần ít nhất 1 đáp án hợp lệ; nên có 5–6.
- Đáp án xếp từ phổ biến nhất (điểm cao nhất) xuống; tổng điểm một câu nên khoảng 100.

## Duyệt

Giá trị ở cột `Approved` được coi là **đã duyệt** nếu (không phân biệt hoa thường, bỏ khoảng trắng): `Y`, `Yes`, `X`, `✓`, `✔`, `OK`, `Có`, `Co`, `Duyệt`, `1`, `TRUE`.
Mọi giá trị khác (kể cả để trống, `N`, `No`) = chưa duyệt, game **không** nhập dòng đó.

## Cách game gom thành bộ

- Một **bộ câu hỏi** = (cấp độ theo tên sheet, `Topic`). Các dòng đã duyệt cùng sheet và cùng Topic thành các vòng của một bộ, theo thứ tự dòng.
- Nhập lại cùng cấp độ + Topic thì cập nhật bộ cũ: câu hỏi trùng nội dung (so không phân biệt hoa thường) được thay bằng bản mới, câu mới được thêm vào cuối.
