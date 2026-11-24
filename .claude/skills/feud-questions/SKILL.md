---
name: feud-questions
description: Tạo và thêm câu hỏi tiếng Anh cho game Classroom Feud (kiểu Family Feud, "Name something...") vào ngân hàng câu hỏi trên Google Sheet, cho bốn cấp Starters, Movers, Flyers và KET (Cambridge A2 Key for Schools). Dùng skill này khi giáo viên nói "thêm bộ câu hỏi", "tạo bộ câu hỏi chủ đề ...", "thêm câu hỏi vào ngân hàng", "ngân hàng câu hỏi", "Google Sheet câu hỏi", "câu hỏi Classroom Feud", "câu hỏi Feud", "làm câu hỏi cho Starters/Movers/Flyers/KET", hoặc chỉ đưa ra một chủ đề (Food, Animals, School, Tet, Technology...) và muốn có câu hỏi cho game, kể cả khi không nhắc tên skill. Chỉ xuất file Excel .xlsx khi giáo viên nói rõ muốn file Excel.
---

# Tạo câu hỏi Classroom Feud (ngân hàng Google Sheet)

Mặc định, câu hỏi mới được **thêm vào Google Sheet "NGÂN HÀNG CÂU HỎI CLASSROOM FEUD"** (ID `17W9UR-HAxUWoh-Lb8RQV37EIOTfJ30ZDTOHhBDUfOv8`). Giáo viên mở sheet, sửa và gõ **Y** ở cột **Approved**; game đọc các bộ đã duyệt thẳng từ sheet.

Bố cục sheet (tab, cột A–U, cách đặt tên bộ) là hợp đồng với game, mô tả trong `classroom-feud/SHEET-BANK.md`. Đọc file đó trước khi ghi. **Không** sửa file đó hay gì trong `classroom-feud/` khi dùng skill này, không đổi tên tab hay tiêu đề cột, không đụng tab `Hướng dẫn`.

## Quy trình (mặc định: Google Sheet)

1. **Xác định cấp và chủ đề.** Cấp: Starters, Movers, Flyers, KET (không nói rõ thì làm cả bốn cấp, hoặc hỏi nếu có vẻ chỉ muốn một cấp). Số bộ: mặc định **1 bộ mỗi cấp** nếu giáo viên không nói; làm theo số họ yêu cầu.
2. **Chủ đề giáo viên đưa ra chỉ là gợi ý.** Mỗi bộ vẫn gồm **5 câu, mỗi câu một chủ đề khác nhau** (theo chương trình Cambridge của cấp đó và đời sống thực của học sinh). Nếu giáo viên cho một chủ đề (vd. Food), đưa chủ đề đó vào 1–2 câu của bộ, các câu còn lại lấy chủ đề khác. Chỉ khi giáo viên nói rõ muốn bộ **một chủ đề duy nhất** thì cả 5 câu cùng chủ đề (khác góc nhìn).
3. **Đọc tab của cấp đó** bằng công cụ Google Sheets (`get_values`, range `<Tab>!A:C`). Tìm số bộ lớn nhất đã có (vd. `Starters 5` → bộ mới là `Starters 6`) và dòng trống đầu tiên. Đọc các câu hỏi cũ để **không lặp lại** câu hỏi đã có ở cấp đó.
4. **Viết câu hỏi** theo hướng dẫn nội dung bên dưới.
5. **Ghi vào sheet**: một lần `update_values` cho mỗi tab, vào `<Tab>!A<dòng đầu>:S<dòng cuối>`, các dòng của một bộ liền nhau. Cột A = tên bộ `<Cấp> <số>`, B = chủ đề của câu đó, C = câu hỏi, rồi các cặp Answer/Points (D,E … R,S); cặp không dùng để `""`; **điểm gửi dạng số**; cột T (Approved) và U (Note) để trống. Trước khi ghi, tải skill `anthropic-skills:google-workspace` và đọc `references/sheets.md` của nó (lưu ý: giá trị như `1/2` hay `00123` có thể bị đổi thành ngày/số, thêm dấu `'` đầu giá trị nếu cần). Chỉ ghi vào tab của cấp liên quan.
6. **Kiểm tra**: đọc lại vùng vừa ghi bằng `get_values`; đúng số dòng, tên bộ đúng, không câu hỏi trống, mỗi câu 5–6 đáp án, điểm giảm dần và tổng ≈ 100.
7. **Báo cho giáo viên** (tiếng Việt): link sheet, tab và tên bộ vừa thêm, liệt kê ngắn các câu hỏi, nhắc cách duyệt: mở sheet, sửa tuỳ ý, chọn **Y** ở cột **Approved** cho câu muốn giữ. Không tự điền cột Approved.

## Phương án khác: file Excel .xlsx

Chỉ dùng khi giáo viên **nói rõ muốn file Excel**. Định dạng file là hợp đồng với game ở `classroom-feud/EXCEL-FORMAT.md`. Quy trình:

1. Viết câu hỏi (mặc định 6 câu mỗi cấp, có thể yêu cầu khác), lưu thành file JSON tạm (scratchpad hoặc thư mục tạm, UTF-8) theo schema bên dưới.
2. Tạo file bằng script (Windows PowerShell 5.1, không cần Python/Node/Excel), chạy từ thư mục gốc repo:

   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .claude/skills/feud-questions/scripts/New-FeudWorkbook.ps1 -JsonPath <file.json> -OutputPath question-sets/feud-<topic-slug>-<YYYYMMDD>.xlsx
   ```

   - `<topic-slug>`: chủ đề viết thường, bỏ dấu, khoảng trắng → `-` (vd. `My School` → `my-school`). `<YYYYMMDD>`: ngày hôm nay; nếu file đã có và giáo viên không bảo ghi đè, thêm hậu tố `-2`, `-3`...
   - Script kiểm tra độ dài, điểm 0–999, tối đa 8 đáp án, và cảnh báo nếu tổng điểm lệch xa 100 hoặc đáp án chưa giảm dần → sửa JSON rồi chạy lại.
3. Báo đường dẫn file, số câu mỗi cấp, và cách duyệt (gõ/chọn **Y** ở cột **Approved**, lưu, nhập file vào game).

Schema JSON đầu vào:

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
- `levels.Starters|Movers|Flyers` (script Excel chưa hỗ trợ KET): mỗi câu có `question` (≤ 200 ký tự) và `answers` = mảng `[text, points]` (1–8 cặp, text ≤ 80 ký tự, points nguyên 0–999, giảm dần).
- Tuỳ chọn mỗi câu: `topic` (ghi đè chủ đề chung), `note`. Ví dụ đầy đủ: `examples/food.json`.

## Hướng dẫn nội dung

### Chung cho mọi cấp
- Kiểu khảo sát Family Feud: **"Name something…"**, "Name a…", "Name a place where…", "Name something you do when…". Câu hỏi phải có nhiều đáp án hợp lý để cả lớp đoán.
- Bối cảnh đời sống thật của **học sinh tiểu học và THCS Việt Nam**: nhà, trường, gia đình, đồ ăn, sở thích, phương tiện đi lại (xe máy, xe đạp, xe buýt), thời tiết, chợ, siêu thị, lễ hội (Tết, Trung thu), kỳ nghỉ... Đáp án phản ánh câu trả lời mà học sinh Việt Nam thật sự hay nói (vd. "something you eat with rice" → Fish, Chicken... ; món Việt viết không dấu nếu cần: `Pho`, `Banh chung`, `Spring rolls`).
- **5–6 đáp án** mỗi câu, xếp từ phổ biến nhất xuống, điểm giảm dần, **tổng ≈ 100** (chấp nhận 90–110; nên đúng 100).
- Đáp án ngắn (1–3 từ), viết hoa chữ đầu, không dấu chấm, phù hợp lứa tuổi, không trùng nhau trong cùng một câu. Tránh nội dung nhạy cảm, bạo lực, thương hiệu.
- Các câu trong một cấp nên khác nhau về góc nhìn (không lặp ý), có câu dễ và câu khó hơn một chút.
- Chính tả và ngữ pháp tiếng Anh phải chuẩn; câu hỏi kết thúc bằng dấu chấm (hoặc dấu hỏi nếu là câu hỏi).

### Starters (≈ Pre-A1)
- Từ vựng trong (hoặc rất gần) **Cambridge YLE Starters wordlist**: đồ ăn cơ bản (apple, banana, bread, cake, chicken, egg, fish, milk, rice, water...), con vật, màu sắc, đồ dùng học tập, đồ chơi, phòng trong nhà, gia đình, quần áo, cơ thể, số đếm, thể thao.
- Ngữ pháp: hiện tại đơn, `can`, `there is/are`, `have got`. Câu rất ngắn: "Name a fruit.", "Name something you eat for breakfast.", "Name an animal at the zoo."
- Đáp án là danh từ đơn giản 1–2 từ.

### Movers (≈ A1)
- Từ vựng **Movers wordlist** (thêm: market, supermarket, picnic, hungry, thirsty, noodles, soup, vegetables, weather, sports, jobs, places in town, health...).
- Ngữ pháp: hiện tại đơn/tiếp diễn, quá khứ đơn cơ bản, `when` clauses, so sánh hơn đơn giản: "Name something you eat when you are hungry after school.", "Name a place you can go with your family at the weekend."
- Có thể nhắc bối cảnh Việt Nam rõ hơn (Tet, chợ, xe buýt trường).

### Flyers (≈ A2)
- Từ vựng **Flyers wordlist** (thêm: butter, honey, jam, sugar, chopsticks, restaurant, snack, festival, future, environment, jobs...).
- Ngữ pháp rộng hơn: quá khứ, `should/shouldn't`, `might`, `usually/often`, so sánh, `would`: "Name a food you shouldn't eat too much of.", "Name something your family might order at a restaurant."
- Có thể hỏi ý kiến, thói quen, tình huống ("Name a snack students often buy outside the school gate.").

### KET (A2 Key for Schools)
- Học sinh THCS khoảng 11–15 tuổi, trình độ **A2 Key for Schools**: từ vựng và ngữ pháp A2 (hiện tại đơn/tiếp diễn, quá khứ đơn, `going to`, so sánh hơn/nhất, `have to`, `should`, `Would you like...?`).
- Chủ đề: daily routines, shopping, travel, technology, health, entertainment, school life, hobbies, food and restaurants, friends and social media.
- Ví dụ: "Name something you do on your phone every day.", "Name a school subject students find difficult.", "Name something you take on a holiday.", "Name a way to stay healthy."
- Đáp án vẫn ngắn (1–3 từ) và phản ánh điều học sinh Việt Nam thật sự hay trả lời; câu hỏi có thể dài và tự nhiên hơn các cấp dưới.

## Kiểm tra trước khi báo xong
- Đúng tab, bộ mới nối tiếp số cuối cùng, không lặp câu hỏi đã có; mỗi bộ 5 câu khác chủ đề (trừ khi giáo viên xin bộ một chủ đề).
- Mỗi câu 5–6 đáp án, điểm giảm dần, tổng ≈ 100, cột Approved và Note trống; đã đọc lại sheet để kiểm tra.
- Nếu xuất Excel: script chạy không lỗi, file nằm ở `question-sets/feud-<topic-slug>-<YYYYMMDD>.xlsx`.
