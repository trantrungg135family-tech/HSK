---
name: feud-questions
description: Tạo bộ câu hỏi tiếng Anh cho game Classroom Feud (kiểu Family Feud, "Name something...") theo chủ đề giáo viên đưa ra, cho ba cấp Cambridge YLE Starters, Movers, Flyers, rồi xuất thành một file Excel .xlsx trong question-sets/ để giáo viên duyệt và nhập vào game. Dùng skill này khi giáo viên nói "tạo bộ câu hỏi chủ đề ...", "bộ câu hỏi", "câu hỏi Classroom Feud", "câu hỏi Feud", "làm câu hỏi cho Starters/Movers/Flyers", "file Excel câu hỏi", hoặc chỉ đưa ra một chủ đề (Food, Animals, School, Tet...) và muốn có câu hỏi cho game, kể cả khi không nhắc tên skill.
---

# Tạo bộ câu hỏi Classroom Feud

Giáo viên đưa một chủ đề → Claude viết câu hỏi khảo sát tiếng Anh cho 3 cấp Starters / Movers / Flyers → lưu thành **một** file `.xlsx` để giáo viên mở bằng Excel, sửa, đánh dấu duyệt, rồi nhập vào game.

Định dạng file là hợp đồng cố định với game, mô tả trong `classroom-feud/EXCEL-FORMAT.md`. Đọc file đó trước nếu nghi ngờ. **Không** sửa file đó hay bất cứ gì trong `classroom-feud/` khi dùng skill này. Script dưới đây đã tạo đúng định dạng.

## Quy trình

1. **Xác định chủ đề.** Lấy từ lời giáo viên (vd. "chủ đề Food" → `Food`). Viết tên chủ đề bằng tiếng Anh, viết hoa chữ đầu (`Food`, `Animals`, `My School`). Chỉ hỏi lại khi chủ đề thật sự không rõ hoặc quá rộng/khó hiểu; nếu đã rõ thì làm luôn.
2. **Số câu.** Mặc định **6 câu mỗi cấp**. Giáo viên có thể yêu cầu nhiều hơn, ít hơn, hoặc chỉ một số cấp (cấp không yêu cầu thì để mảng rỗng; sheet vẫn được tạo, chỉ có dòng tiêu đề).
3. **Viết câu hỏi** theo hướng dẫn nội dung bên dưới, lưu thành file JSON tạm (trong scratchpad, hoặc thư mục tạm của hệ thống) theo schema bên dưới, mã hoá UTF-8.
4. **Tạo file Excel** bằng script (Windows PowerShell 5.1, không cần Python/Node/Excel):

   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .claude/skills/feud-questions/scripts/New-FeudWorkbook.ps1 -JsonPath <file.json> -OutputPath question-sets/feud-<topic-slug>-<YYYYMMDD>.xlsx
   ```

   - `<topic-slug>`: chủ đề viết thường, bỏ dấu, khoảng trắng → `-` (vd. `My School` → `my-school`).
   - `<YYYYMMDD>`: ngày hôm nay. Nếu file đã tồn tại và giáo viên không bảo ghi đè, thêm hậu tố `-2`, `-3`...
   - Script chạy từ thư mục gốc repo. Nó kiểm tra độ dài, điểm 0–999, tối đa 8 đáp án, và in cảnh báo nếu tổng điểm lệch xa 100 hoặc đáp án chưa xếp theo điểm giảm dần → sửa JSON rồi chạy lại.
5. **Báo cho giáo viên** (bằng tiếng Việt): đường dẫn file, số câu mỗi cấp, liệt kê ngắn các câu hỏi, và nhắc cách duyệt: mở file, sửa tuỳ ý, gõ/chọn **Y** ở cột **Approved** cho câu muốn giữ, lưu, rồi nhập file vào game. Không tự điền cột Approved.

## Schema JSON đầu vào

```json
{
  "topic": "Food",
  "levels": {
    "Starters": [
      { "question": "Name a fruit.", "answers": [["Banana", 28], ["Mango", 22], ["Apple", 18], ["Watermelon", 14], ["Orange", 10], ["Grapes", 8]] }
    ],
    "Movers": [ ... ],
    "Flyers": [ ... ]
  }
}
```

- `topic` (bắt buộc): chủ đề, ghi vào cột `Topic` của mọi dòng.
- `levels.Starters|Movers|Flyers`: danh sách câu hỏi. Mỗi câu: `question` (≤ 200 ký tự), `answers` = mảng `[text, points]` (1–8 cặp, text ≤ 80 ký tự, points nguyên 0–999, xếp điểm giảm dần).
- Tuỳ chọn mỗi câu: `topic` (ghi đè chủ đề chung), `note` (ghi vào cột `Note`).
- Ví dụ đầy đủ: `examples/food.json`.

File Excel tạo ra có sheet `Hướng dẫn` (hướng dẫn duyệt tiếng Việt) và sheet `Starters`, `Movers`, `Flyers` với cột Topic, Question, Answer 1/Points 1 … Answer 8/Points 8, Approved (ô chọn Y/N), Note; dòng tiêu đề in đậm và cố định.

## Hướng dẫn nội dung

### Chung cho mọi cấp
- Kiểu khảo sát Family Feud: **"Name something…"**, "Name a…", "Name a place where…", "Name something you do when…". Câu hỏi phải có nhiều đáp án hợp lý để cả lớp đoán.
- Bối cảnh đời sống thật của **học sinh tiểu học và THCS Việt Nam**: nhà, trường, gia đình, đồ ăn, sở thích, phương tiện đi lại (xe máy, xe đạp, xe buýt), thời tiết, chợ, siêu thị, lễ hội (Tết, Trung thu), kỳ nghỉ... Đáp án phản ánh câu trả lời mà học sinh Việt Nam thật sự hay nói (vd. "something you eat with rice" → Fish, Chicken... ; món Việt viết không dấu nếu cần: `Pho`, `Banh chung`, `Spring rolls`).
- **5–6 đáp án** mỗi câu, xếp từ phổ biến nhất xuống, điểm giảm dần, **tổng ≈ 100** (chấp nhận 90–110; nên đúng 100).
- Đáp án ngắn (1–3 từ), viết hoa chữ đầu, không dấu chấm, phù hợp lứa tuổi, không trùng nhau trong cùng một câu. Tránh nội dung nhạy cảm, bạo lực, thương hiệu.
- Các câu trong một cấp nên khác nhau về góc nhìn (không lặp ý), có câu dễ và câu khó hơn một chút.
- Chính tả và ngữ pháp tiếng Anh phải chuẩn; câu hỏi kết thúc bằng dấu chấm (hoặc dấu hỏi nếu là câu hỏi).

### Starters (≈ Pre-A1)
- Từ vựng trong (hoặc rất gần) **Cambridge YLE Starters wordlist**: đồ ăn cơ bản (apple, banana, bread, cake, chicken, egg, fish, milk, rice, water...), con vật, màu sắc, đồ dùng học tập, đồ chơi, phòng trong nhà, gia đình, quần áo, cơ thể.
- Ngữ pháp: hiện tại đơn, `can`, `there is/are`, `have got`. Câu rất ngắn: "Name a fruit.", "Name something you eat for breakfast.", "Name an animal at the zoo."
- Đáp án là danh từ đơn giản 1–2 từ.

### Movers (≈ A1)
- Từ vựng **Movers wordlist** (thêm: market, supermarket, picnic, hungry, thirsty, noodles, soup, vegetables, weather, sports, jobs, places in town...).
- Ngữ pháp: hiện tại đơn/tiếp diễn, quá khứ đơn cơ bản, `when` clauses, so sánh hơn đơn giản: "Name something you eat when you are hungry after school.", "Name a place you can go with your family at the weekend."
- Có thể nhắc bối cảnh Việt Nam rõ hơn (Tet, chợ, xe buýt trường).

### Flyers (≈ A2)
- Từ vựng **Flyers wordlist** (thêm: butter, honey, jam, sugar, chopsticks, restaurant, snack, festival, future, environment, jobs...).
- Ngữ pháp rộng hơn: quá khứ, `should/shouldn't`, `might`, `usually/often`, so sánh, `would`: "Name a food you shouldn't eat too much of.", "Name something your family might order at a restaurant."
- Có thể hỏi ý kiến, thói quen, tình huống ("Name a snack students often buy outside the school gate.").

## Kiểm tra trước khi báo xong
- Script chạy không lỗi, không còn cảnh báo (hoặc giáo viên đã chấp nhận).
- Đủ số câu mỗi cấp, mỗi câu 5–6 đáp án, tổng điểm ≈ 100, cột Approved trống.
- File nằm ở `question-sets/feud-<topic-slug>-<YYYYMMDD>.xlsx`.
