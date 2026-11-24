# Đề xuất: thêm âm thanh, hình ảnh, chuyển động cho Classroom Feud

_Ngày 24/11/2026 · Chỉ là đề xuất, chưa sửa game. Thầy/cô duyệt từng mục (ghi ✅ / ❌ / sửa lại) rồi Claude mới làm._

Nguyên tắc giữ nguyên: game vẫn là **một file HTML duy nhất**, chơi được khi mất mạng; chỉ dùng tài nguyên **CC0** (repo công khai). Mục nào chỉ có nguồn CC-BY hoặc giấy phép chưa rõ thì ghi rõ và có phương án thay thế.

**⭐ = 8 đề xuất nên làm trước.** Kích thước tính cho âm mono Opus 48 kbps nhúng base64 (≈ 8 KB mỗi giây âm thanh). File hiện nặng ~390 KB (trong đó âm thanh ~115 KB).

---

## 0. Hiện trạng: game đang có gì ở từng sự kiện

| Sự kiện | Âm thanh hôm nay | Hình ảnh hôm nay |
|---|---|---|
| Bắt đầu trận (đếm 3-2-1-GO) | Tích tắc + "go" tổng hợp | Số to nhảy giữa màn |
| Giới thiệu vòng | Vút (Kronbits) + kèn tổng hợp | Màn "Round n/N" 2 giây, đèn đổi màu |
| Vòng nhân điểm ×2 | Tiếng nạp năng lượng + chuông | Nhãn DOUBLE POINTS, bụi vàng |
| Mở ô có điểm | Vút + "ting" xu | Ô lật, +điểm bay, pháo giấy nhỏ, hào quang đội |
| Ô điểm cao nhất | + giai điệu thắng | Nhãn TOP ANSWER, tia vàng, chớp máy ảnh, pháo giấy lớn |
| Mở ô không tính điểm / mở lần lượt | Tiếng nút | Ô lật |
| Sai (X) 1–2 | Tiếng sai + đập | X lớn, bảng rung, viền đỏ |
| Đủ 3 sai → cơ hội cướp | Còi báo + kèn | Bảng "CƠ HỘI CƯỚP ĐIỂM", đèn xoay đỏ |
| Cướp thành công | Trống dồn tổng hợp + power-up | Pháo giấy ở bục đội, disco |
| Cướp thất bại | Tiếng thất bại | Bảng rung, đèn đỏ |
| Mở hết bảng | Giai điệu hoàn thành | Mưa pháo giấy ngắn, disco |
| Đồng hồ: mỗi giây / 3 giây cuối / hết giờ | Tích tắc / tích cao / thất bại + giọng "Time out!" | Vòng đếm, nhịp tim đỏ, chữ HẾT GIỜ |
| Đổi lượt đội | Tiếng nút | Bục đội nhấp nháy, hào quang đổi phía |
| Cộng/trừ điểm tay | Xu / tiếng nút | Chip điểm bay |
| Thay đổi điểm số trên bục | — (không có) | Số đổi ngay, không chạy số |
| Sang vòng tiếp | (như giới thiệu vòng) | — không có tóm tắt vòng vừa xong |
| Hoàn tác (Undo) | Tiếng nút | Thông báo nhỏ |
| Kết thúc trận | Kèn thắng + "You win!" + hợp xướng | Tên đội thắng, vương miện, mưa pháo giấy, tia vàng, disco |
| Nhạc nền | Vòng nhạc game-show **tổng hợp** (bật/tắt trong khung Âm thanh) | — |
| Lúc chờ (giáo viên đang giảng) | — | Đèn pha quét nhẹ |

Khoảng trống rõ nhất: **không có tiếng đám đông** (reo, "ôi", vỗ tay), **không có trống hồi hộp trước khi lật ô**, **không có giọng đọc** ngoài "Time out!"/"You win!", điểm không **chạy số**, không có **chuỗi trả lời đúng**, màn kết quả chưa có **bục xếp hạng**, và học sinh ít có việc để **làm** ngoài trả lời.

---

## 1. Nguồn tài nguyên đã kiểm tra (chưa tải gì)

| Gói | Link | Giấy phép (đọc trên trang) | Dùng cho |
|---|---|---|---|
| Kenney – Voiceover Pack (92 file OGG, giọng nam + nữ) | https://kenney.nl/assets/voiceover-pack (bản OpenGameArt: https://opengameart.org/content/voiceover-pack-40-lines) | **CC0** | "Ready? Set… Go!", "Final round", "Correct", "Wrong", "Congratulations", "You win", "It's a tie", "Hurry up", "Time over", "New highscore", số 1–10 |
| Kenney – Music Jingles (85 đoạn nhạc ngắn) | https://kenney.nl/assets/music-jingles | **CC0** | Nhạc hiệu 1–3 giây cho chuyển vòng, chuỗi đúng, bục xếp hạng |
| Chequered Ink – 400+ Sounds Pack (400 + 96 WAV) | https://ci.itch.io/400-sounds-pack | **CC0 / Public Domain** | "Musical Effects", "Card & Board Game Sounds", "Human Noises", UI — ứng viên cho trống dồn, tiếng tách, tiếng "yay"; phải nghe thử bản xem trước trên Dropbox để chọn file |
| CoMiGo – Short Music Loops | https://comigo.itch.io/music-loops | **CC0** | Nhạc nền thu sẵn (vd. *SweetTalk*, *DeterminedStart*, *OrientalParty*) thay vòng nhạc tổng hợp |
| Kenney – Particle Pack (80 PNG 512 px) | https://kenney.nl/assets/particle-pack | **CC0** | Sao, lửa, tia sáng cho pháo hoa (thu nhỏ còn 64 px) |
| Kenney – Emotes Pack (480 PNG) | https://kenney.nl/assets/emotes-pack | **CC0** | Bong bóng cảm xúc cho linh vật (tim, sao, chấm than…) |
| Gregor Quendel – Free Crowd Cheering Sounds | https://gregor-quendel.itch.io/free-crowd-cheering-sounds | **CC-BY 4.0** — phải ghi công (đơn giản: 1 dòng trong SOUNDS.md + màn Giới thiệu). Zip 260 MB | Tiếng đám đông reo hò (rất hay, nhưng không phải CC0) |
| The Designer's Choice – CROWDS | https://nicholasjudy567.itch.io/the-designers-choice-crowds | "royalty-free, credit or not" — **không ghi CC0**, có `License.txt` chưa đọc được (nằm trong gói tải) | Có nhóm *children*, *reactions*, *applause*, *celebration* — đúng nhất cho lớp học, nhưng phải đọc `License.txt` trước khi dùng |
| Đã có trong game: Kronbits 200 Free SFX, ObsydianX Interface SFX Pack 1 | https://kronbits.itch.io/freesfx · https://obsydianx.itch.io/interface-sfx-pack-1 | **CC0** | Còn nhiều tiếng chưa dùng (pop, jump, powerup khác) |

Không tìm được gói **CC0** nào trên itch.io có sẵn tiếng **trống dồn** hay **"Ooh/Aww" của khán giả**. Phương án: (a) tìm trong *400+ Sounds Pack* (CC0) khi nghe thử, (b) tổng hợp bằng code (game đã có sẵn bộ tổng hợp tiếng trống), (c) dùng CC-BY có ghi công nếu thầy/cô đồng ý.

---

## 2. Âm thanh

**1. ⭐ Trống dồn hồi hộp trước khi lật ô** — Giáo viên giữ phím số (hoặc bấm ô lần 1) → trống dồn 1–2 giây, ô rung nhẹ; nhả/bấm lần 2 → "bùm" + lật ô. Bấm nhanh như cũ thì lật ngay, không trống.
- Vì sao: cả lớp nín thở rồi hét lên khi lật — khoảnh khắc vui nhất của Family Feud.
- Nguồn: vẽ bằng code (trống tổng hợp sẵn có, nâng cấp: snare cuộn + chũm chọe) **hoặc** một file trống trong *400+ Sounds Pack* (CC0) nếu có.
- Kích thước: 0 KB (code) / ~20 KB (file). Công: **S–M**.
- Rủi ro: dùng cho mọi ô sẽ chậm game → chỉ khi giữ phím, hoặc bật "Trống cho ô cuối/ô top".

**2. ⭐ Tiếng đám đông: reo khi đúng, "Ôi…" khi sai, vỗ tay khi hết bảng** — Thêm lớp tiếng khán giả nhỏ phía sau tiếng hiện có.
- Vì sao: tạo cảm giác "trường quay", học sinh bắt chước hò theo.
- Nguồn: *Gregor Quendel Crowd Cheering* (CC-BY, file *04 Strong cheering II – Short*, *05 Soft cheering I*) hoặc *Designer's Choice CROWDS* (children/reactions — cần đọc License.txt). "Ôi/Aww" chưa có nguồn CC0 → tạm bỏ hoặc dùng "Human Noises" trong *400+ Sounds* nếu phù hợp.
- Kích thước: 3 đoạn × ~2 s ≈ **50 KB**. Công: **S** (sau khi chọn được file).
- Rủi ro: tiếng đám đông dễ ồn trên loa lớp → mức mặc định nhỏ (30%), có công tắc riêng.

**3. ⭐ Giọng đọc tiếng Anh ở các mốc** — "Ready? Set… Go!" ở đếm ngược, "Round three!" / "Final round!" ở giới thiệu vòng, "Correct!" khi top answer, "Wrong!" ở lần sai thứ 3, "Hurry up!" ở 5 giây cuối, "It's a tie!" khi hòa, "Congratulations!" ở màn kết quả.
- Vì sao: học sinh nghe tiếng Anh thật, lặp lại theo — vừa vui vừa học.
- Nguồn: **Kenney Voiceover Pack (CC0)** — chọn một giọng (nữ nghe thân thiện với trẻ nhỏ) ~12 file.
- Kích thước: ~12 × 0,8 s ≈ **80 KB**. Công: **S**.
- Rủi ro: thấp; có công tắc "Giọng đọc".

**4. Nhạc hiệu ngắn khi chuyển vòng / chuỗi đúng** — thay kèn tổng hợp ở giới thiệu vòng bằng jingle thật 1–2 s; jingle riêng cho "chuỗi 3".
- Nguồn: **Kenney Music Jingles (CC0)**, 3 file (vd. nhóm *jingles_NES* / *jingles_PIZZI* — chọn khi nghe).
- Kích thước: ~3 × 2 s ≈ **45 KB**. Công: **S**.

**5. Nhạc nền thu sẵn (tùy chọn)** — thay vòng nhạc tổng hợp bằng 1 bản nhạc vui lặp được; tự nhỏ đi khi có hiệu ứng (đã có bus riêng).
- Nguồn: **CoMiGo Short Music Loops (CC0)** — *SweetTalk* hoặc *DeterminedStart*.
- Kích thước: 30–40 s ở 32 kbps ≈ **150–200 KB** (đắt nhất). Công: **S**.
- Rủi ro: nhạc liên tục gây mệt trong 40 phút → mặc định **tắt**, chỉ bật lúc chờ/kết quả.

**6. ⭐ Mức âm lượng theo lớp (preset)** — Trong khung Âm thanh thêm 3 nút: **Lớp yên tĩnh** (hiệu ứng 40%, không đám đông, không nhạc), **Bình thường**, **Sân khấu** (to, có đám đông + nhạc). Thêm công tắc riêng: Đám đông / Giọng đọc / Nhạc.
- Vì sao: giáo viên đổi nhanh theo phòng, giờ học, lớp cạnh bên.
- Nguồn: code. Kích thước ~2 KB. Công: **S**.

**7. Tiếng đồng hồ hồi hộp hơn** — 5 giây cuối tích tắc nhanh dần + nhịp tim trầm (đã có đèn nhịp tim, chưa có tiếng tim).
- Nguồn: code. 0 KB. Công: **S**. Rủi ro: trẻ nhỏ có thể căng thẳng → chỉ khi bật đồng hồ.

**8. Tiếng "chạy số" khi điểm tăng** — tiếng tách-tách nhỏ theo nhịp số chạy trên bục (đi kèm mục 11).
- Nguồn: ObsydianX cursor sẵn có / code. 0 KB. Công: **S**.

---

## 3. Hình ảnh & chuyển động

**9. ⭐ Pháo hoa / sao bung theo màu đội** — ô top answer, cướp điểm thành công và màn thắng có pháo hoa nổ thành sao (không chỉ giấy vụn); hạt mang màu đội ghi điểm.
- Nguồn: vẽ bằng canvas (đã có hệ thống Lights + Confetti); tùy chọn thêm 3–4 hạt *star/flare/spark* từ **Kenney Particle Pack (CC0)** thu 64 px.
- Kích thước: 0 KB (canvas) / ~15 KB (PNG). Công: **M**.
- Rủi ro: tắt khi "giảm chuyển động" như pháo giấy hiện tại.

**10. Ô "rung rinh" trước khi lật + lật 3D chậm hơn cho top answer** — đi cùng trống dồn (mục 1).
- Nguồn: CSS. 0 KB. Công: **S**.

**11. ⭐ Điểm trên bục chạy số + bục "nảy" khi nhận điểm, vương miện cho đội dẫn đầu** — số đếm lên trong ~0,8 s; đội đang dẫn có vương miện nhỏ đung đưa; khi đổi ngôi dẫn, vương miện bay sang và hiện "LEAD CHANGE!".
- Vì sao: học sinh nhìn bục điểm liên tục; thấy đổi ngôi tạo bùng nổ cảm xúc.
- Nguồn: code/CSS + SVG vương miện vẽ tay. ~3 KB. Công: **S–M**.

**12. ⭐ Linh vật phản ứng** — một nhân vật dễ thương (vd. con cú "Feudy") ở góc màn: vỗ cánh khi đúng, há miệng "Wow!" ở top answer, ôm đầu khi sai, nhảy múa khi thắng; bong bóng cảm xúc phía trên.
- Vì sao: trẻ tiểu học rất thích nhân vật; giảm cảm giác "bị phạt" khi sai.
- Nguồn: **vẽ bằng SVG/CSS** (không lấy nhân vật có bản quyền); bong bóng từ **Kenney Emotes Pack (CC0)** hoặc vẽ code.
- Kích thước: ~8–15 KB (SVG + vài PNG emote). Công: **M**.
- Rủi ro: có thể gây phân tâm → công tắc "Linh vật", đặt ở góc không che bảng.

**13. Thẻ tóm tắt cuối vòng** — trước khi sang vòng sau hiện 2 giây: "Round 2: Team A +45, Team B +20 · Top answer: *pizza*".
- Nguồn: code. 0 KB. Công: **S**.

**14. Cảnh báo "bám đuổi" / "lội ngược dòng"** — khi đội sau kém ≤ 10 điểm ở vòng cuối: nhãn "CLOSE GAME!" + đèn nhấp nháy hai màu.
- Nguồn: code. 0 KB. Công: **S**.

**15. Chế độ "Nhẹ nhàng cho lớp nhỏ"** — lần sai dùng chữ "Try again!" màu cam, tiếng nhẹ, không rung bảng.
- Vì sao: học sinh 6–7 tuổi dễ buồn với X đỏ và còi.
- Nguồn: code + giọng "Wrong" thay bằng không giọng. 0 KB. Công: **S**.

---

## 4. Tương tác với học sinh

**16. ⭐ Vòng bấm chuông (Face-off buzzer)** — đầu mỗi vòng, đại diện 2 đội tranh quyền trả lời: đội A bấm **phím trái** (vd. Q hoặc chuột trái của bàn phím rời), đội B bấm **phím phải** (P). Ai bấm trước: bục sáng, tiếng chuông riêng của đội, các phím khác bị khóa; game tự đặt lượt cho đội đó. Bấm sớm khi câu hỏi chưa hiện → "Too early!".
- Vì sao: học sinh trực tiếp chạm vào game — tăng tham gia rõ nhất.
- Nguồn: code; tiếng chuông 2 loại từ Kronbits/ObsydianX đã có hoặc thêm 2 tiếng (~10 KB). Công: **M**.
- Rủi ro: tranh cãi ai bấm trước → hiện chênh lệch thời gian ("A nhanh hơn 0,12 s").

**17. Mỗi đội tự chọn màu + tiếng chuông + biểu tượng** — ở màn thiết lập: 6 màu, 4 tiếng chuông (bíp, chuông, còi, kèn), 8 biểu tượng (🐯 🦊 🐼 🚀 ⚡ 🌟 …, dùng emoji hệ thống, 0 KB).
- Vì sao: học sinh "sở hữu" đội, hò hét theo tiếng của mình.
- Nguồn: code + tiếng có sẵn. ~10 KB. Công: **M**.

**18. ⭐ Chuỗi trả lời đúng (streak)** — đội mở đúng liên tiếp 3 ô không sai: huy hiệu "🔥 3 IN A ROW!", lửa nhỏ trên bục; 5 ô: "ON FIRE!". Sai thì tắt lửa.
- Nguồn: code + jingle Kenney (mục 4). 0–15 KB. Công: **S**.

**19. Nút "Hype" cho giáo viên** — 3 phím tắt bảng âm thanh: vỗ tay, reo, "Ooh" — giáo viên khen học sinh trả lời hay dù không có trên bảng.
- Nguồn: dùng lại tiếng ở mục 2. 0 KB thêm. Công: **S**.

**20. Chọn học sinh ngẫu nhiên** — nhập sĩ số mỗi đội; nút "Ai trả lời?" quay số → "Team A – bạn số 7!" (tiếng trống dồn + dừng).
- Vì sao: học sinh ít nói cũng được gọi, cả đội chú ý.
- Nguồn: code. 0 KB. Công: **S–M**.

**21. Đồng thanh đếm ngược** — trước vòng cuối hiện "Cả lớp cùng đếm: 3… 2… 1…" chữ rất to, chậm (1 s/số) để học sinh hô theo.
- Nguồn: code + giọng Kenney số "3,2,1". 0 KB thêm. Công: **S**.

---

## 5. Màn kết quả

**22. ⭐ Bục xếp hạng + MVP** — hai bục nhô lên lần lượt (đội thua trước, trống dồn, rồi đội thắng nảy lên bục cao với vương miện + pháo hoa), sau đó hiện các giải nhỏ: **Top Answer King** (đội mở nhiều ô top nhất), **Best Steal** (cướp điểm nhiều nhất), **Longest Streak**, **Fastest Buzzer** (nếu dùng mục 16).
- Vì sao: đội thua vẫn có giải → không buồn; công bố từng bước tạo cao trào.
- Nguồn: code/canvas + giọng "Congratulations!", jingle Kenney. ~0 KB thêm. Công: **M**.

**23. Biểu đồ điểm theo vòng** — đường điểm của 2 đội chạy dần qua các vòng (thấy lúc đổi ngôi).
- Nguồn: canvas/SVG. 0 KB. Công: **S–M**.

**24. Hòa thì có "Sudden death"** — khi hòa: giọng "It's a tie!", nút "Câu hỏi phụ" lấy 1 câu dự phòng, ai bấm chuông trước + đúng ô top là thắng.
- Nguồn: code + giọng Kenney. Công: **M**.

**25. Chụp màn kết quả thành ảnh** — nút lưu PNG bảng điểm + bục để gửi nhóm phụ huynh/lớp.
- Nguồn: canvas. 0 KB. Công: **M**.

---

## 6. Top 8 đề xuất (khuyên làm trước)

| # | Mục | Công | Thêm vào file |
|---|---|---|---|
| 1 | Trống dồn trước khi lật ô (giữ phím) | S–M | 0–20 KB |
| 2 | Tiếng đám đông reo / vỗ tay (chờ chốt nguồn CC-BY hoặc CROWDS) | S | ~50 KB |
| 3 | Giọng đọc tiếng Anh Kenney (Ready-Go, Final round, Correct, Congratulations…) | S | ~80 KB |
| 6 | Preset âm lượng lớp + công tắc riêng | S | ~2 KB |
| 11 | Điểm chạy số, bục nảy, vương miện + "LEAD CHANGE!" | S–M | ~3 KB |
| 16 | Vòng bấm chuông face-off bằng 2 phím | M | ~10 KB |
| 18 | Chuỗi đúng 🔥 3 IN A ROW | S | 0–15 KB |
| 22 | Bục xếp hạng + giải MVP ở màn kết quả | M | ~0 KB |

(Mục 9 pháo hoa sao, 12 linh vật và 17 đội tự chọn màu/tiếng là ứng viên tiếp theo.)

## 7. Ước tính dung lượng

- **Top 8:** khoảng **+150–180 KB** → file từ ~390 KB lên ~**560 KB**.
- **Làm tất cả trừ nhạc nền:** khoảng **+250 KB** → ~**640 KB**.
- **Thêm nhạc nền thu sẵn (mục 5):** +150–200 KB → ~**850 KB**. Vẫn mở tức thì trên máy lớp, nhưng đây là mục nặng nhất nên để tùy chọn.

## 8. Lưu ý chung cho lớp học

- Mọi hiệu ứng mới tôn trọng "giảm chuyển động" như hiện tại; không chớp quá 3 lần/giây.
- Đám đông và nhạc mặc định nhỏ; preset "Lớp yên tĩnh" tắt hẳn.
- Nguồn CC-BY (nếu chọn): ghi công ở `SOUNDS.md` và dòng nhỏ trong mục Giới thiệu của game.
- Sau khi duyệt, Claude mới tải gói (từ trang gốc), nghe thử, cắt, nén Opus, nhúng base64 và cập nhật `SOUNDS.md`.

**Cần thầy/cô quyết:** (a) đồng ý dùng tiếng đám đông CC-BY (ghi công 1 dòng) hay chỉ CC0? (b) giọng đọc nam hay nữ? (c) có muốn linh vật không, nếu có thì con gì?
