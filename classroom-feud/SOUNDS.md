# Âm thanh & hiệu ứng trong Classroom Feud

Game dùng âm thanh thu sẵn (nhúng thẳng trong `Classroom-Feud.html`, không cần file riêng, chơi được khi mất mạng). Nếu trình duyệt không giải mã được, game tự dùng âm thanh tổng hợp như trước.

## Nguồn và giấy phép

| Gói | Tác giả | Link | Giấy phép |
|-----|---------|------|-----------|
| 200 Free SFX | Kronbits | https://kronbits.itch.io/freesfx | CC0 |
| Interface SFX Pack 1 | ObsydianX | https://obsydianx.itch.io/interface-sfx-pack-1 | CC0 |
| Voiceover Pack (giọng nữ) | Kenney (www.kenney.nl) | https://kenney.nl/assets/voiceover-pack | CC0 (đã đọc `License.txt` trong gói) |
| Free Crowd Cheering Sounds | Gregor Quendel | https://gregor-quendel.itch.io/free-crowd-cheering-sounds | **CC BY 4.0** — phải ghi công (xem dưới) |

**Ghi công bắt buộc (CC BY 4.0):** Tiếng khán giả reo hò: “Free Crowd Cheering Sounds” của Gregor Quendel (gregorquendel.com), giấy phép CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/). Đã cắt hai đoạn ngắn (*04 – Strong cheering II – Short*, *03 – Strong cheering I*) và chuẩn hóa âm lượng. Dòng ghi công này cũng có trong mục **Cách chơi** (nút ?) của game.

CC0 không bắt buộc ghi công; vẫn liệt kê ở đây để cảm ơn.

Âm thanh đã được cắt khoảng lặng, chuẩn hóa âm lượng, đổi sang mono Opus/WebM (hiệu ứng 48 kbps, đám đông 40 kbps, giọng đọc 32 kbps). Tổng dữ liệu âm thanh ~226 KB (base64), file game ~538 KB.

## Âm thanh và hiệu ứng theo từng thao tác

| Thao tác | Âm thanh | Hiệu ứng hình |
|----------|----------|---------------|
| Đếm ngược 3-2-1-GO | Tích tắc + giọng "Three, two, one, go!" | Số to giữa màn |
| Vòng bắt đầu | Tiếng "vút" + kèn; giọng "Round two" … "Final round" (vòng cuối) | Màn giới thiệu vòng |
| Vòng nhân điểm bắt đầu | Tiếng nạp năng lượng (*Charge StereoUP 01*) + chuông + giọng | Màn giới thiệu DOUBLE POINTS |
| Bấm chuông (face-off) | Giọng "Ready?", rồi tiếng "GO!" + giọng "Go!"; chuông đội A (ding-ding), kèn đội B; reo hò nhỏ | Màn BẤM CHUÔNG, ô đội bấm trước sáng lên, ô đội chậm ghi "chậm hơn … giây" |
| Giữ phím số / giữ chuột trên ô | **Trống dồn** to dần (tổng hợp bằng code); thả ra: tiếng chũm chọe "bùm" | Ô rung + viền vàng, rồi lật |
| Mở ô có điểm | Tiếng lật "vút" + "ting" đồng xu (Kronbits *Swooosh 07*, *PickUp Coin 04*) + reo hò nhỏ | Ô lật, số **+điểm** bay lên, pháo giấy nhỏ, bục đội nảy lên, điểm chạy số |
| Mở ô **điểm cao nhất** | Giai điệu chiến thắng (*Success Melody 01*) + giọng "Correct!" + reo hò | Nhãn **TOP ANSWER!**, ô sáng, pháo giấy lớn, **pháo hoa sao màu đội** |
| Mở ô trong vòng **nhân điểm** | Thêm tiếng phép thuật (*Magic 06*) + kèn | Dấu ×2 đóng lên ô |
| 3 đáp án đúng liên tiếp (không sai) | Hợp âm đi lên + chuông | Băng rôn **🔥 3 IN A ROW!**, nhãn 🔥3 dưới bục đội |
| 5 đáp án đúng liên tiếp | Tiếng "ON FIRE" + chũm chọe | Băng rôn **🔥 ON FIRE!**, pháo hoa sao |
| Đổi đội dẫn đầu | Kèn ngắn + reo hò | Băng rôn **LEAD CHANGE!**, vương miện bay sang bục đội mới, pháo hoa |
| Sai (X) | Tiếng sai (*Event Wrong Echo 03*) + tiếng đập + tiếng khán giả "ôi…" (tổng hợp) | Chữ X lớn, bảng rung; chuỗi đúng bị xóa |
| Đủ 3 lần sai | Còi báo động (*Alarmed 06*) + kèn | Bảng "CƠ HỘI CƯỚP ĐIỂM" |
| Cướp điểm thành công | Trống dồn + *PowerUP 23* + vỗ tay | Pháo giấy ở bục đội, pháo hoa sao |
| Cướp điểm thất bại | Tiếng thất bại (*Negative Long 01*) + giọng "Wrong!" + "ôi…" | Bảng rung |
| Mở hết bảng | Giai điệu hoàn thành (*Success Melody 04*) + vỗ tay | Mưa pháo giấy, pháo hoa vàng |
| Đồng hồ còn 5 giây | Giọng "Hurry up!" (khi đặt từ 8 giây trở lên) | — |
| Hết giờ | Tiếng thất bại + giọng "Time out!" | Đồng hồ nhấp nháy, chữ HẾT GIỜ |
| Cộng điểm tay / đổi lượt / mở ô không tính điểm | Tiếng đồng xu / tiếng nút (ObsydianX *cursor_style_2*) | Có thể kích hoạt LEAD CHANGE |
| Kết thúc trò chơi | Kèn chiến thắng + "You win!" + hợp xướng + vỗ tay + giọng "Congratulations!" (hòa: "It's a tie!") | **Bục xếp hạng** (đội nhì lên trước, đội thắng lên sau với vương miện), **giải MVP**, mưa pháo giấy, pháo hoa màu đội thắng |

Giải MVP ở màn kết quả (chỉ hiện giải có người đạt; bằng nhau thì "Cả hai đội"): Vua đáp án top, Cướp điểm đỉnh nhất, Chuỗi đúng dài nhất, Bấm chuông nhanh nhất, Thợ săn đáp án.

## Khung Âm thanh (nút loa)

- **Mức âm lượng lớp học:** *Lớp yên tĩnh* (hiệu ứng 45%, không tiếng khán giả, không nhạc), *Bình thường* (mặc định: hiệu ứng 80%, có tiếng khán giả), *Sân khấu* (100%, có tiếng khán giả + nhạc nền).
- Công tắc riêng: **Tiếng khán giả**, **Giọng đọc tiếng Anh**, **Trống dồn khi giữ ô**, Nhạc nền.

## Bấm chuông (face-off)

Bật cho cả trận bằng ô **Bấm chuông giành lượt ở đầu mỗi vòng** trong *Thông tin trò chơi*, hoặc bấm nút **Bấm chuông** (phím **O**) bất cứ lúc nào. Đội A bấm **Q**, đội B bấm **P** (hoặc chạm vào ô của đội). Bấm trước "GO!" bị khóa 1,5 giây. **Esc** để bỏ qua. Có thể hoàn tác.

## Đổi âm thanh

Dữ liệu nằm trong `const SFX_DATA = {...}` (base64 WebM/Opus) của `Classroom-Feud.html` (giọng đọc tên `v_…`, đám đông `cheer`, `applause`); cách phối từng thao tác nằm trong `const MIX = {...}` và các hàm `say`, `crowd`, `rollStart`, `buzz`, `sting` của module `Sound`. Muốn đổi tiếng nào, báo Claude tên thao tác và tiếng mong muốn.

## Hiệu ứng ánh sáng (nút bóng đèn trên thanh trên cùng)

10 hiệu ứng, bật/tắt từng cái, mỗi cái có nút **Thử** để xem trước. Có 3 mức nhanh: **Tắt**, **Nhẹ nhàng** (đèn pha, hào quang đội, tia vàng, bụi vàng, pháo hoa sao, băng rôn), **Đã đời** (tất cả — mặc định).

| Hiệu ứng | Khi nào |
|----------|---------|
| Đèn pha sân khấu | Luôn quét trong lúc chơi; màu theo đội đang trả lời, vàng ở vòng nhân điểm; chuyển vàng/đỏ/trắng theo sự kiện |
| Hào quang đội | Phía đội đang trả lời sáng lên, bừng sáng khi ghi điểm hoặc đổi lượt |
| Chớp đèn máy ảnh | Ô điểm cao nhất, cướp điểm thành công, công bố đội thắng |
| Tia hào quang vàng | Xoay quanh ô điểm cao nhất; sau tên đội thắng ở màn kết quả |
| Đèn báo đỏ | Viền đỏ khi sai; đèn xoay + viền đập 3 nhịp khi đủ 3 lần sai; khi cướp điểm thất bại, hết giờ |
| Bụi vàng lấp lánh | Vòng nhân điểm và màn kết quả |
| Đèn disco | Mở hết bảng, cướp điểm thành công, màn kết quả |
| Nhịp tim đồng hồ | 3 giây cuối của đồng hồ đếm giờ |
| Pháo hoa sao | Tên lửa bay lên rồi nổ thành sao màu đội: ô điểm cao nhất, cướp điểm, mở hết bảng, đổi ngôi, chuỗi 5, đội thắng |
| Băng rôn và vương miện | Vương miện trên bục đội dẫn đầu, nhãn 🔥 chuỗi đúng, băng rôn LEAD CHANGE! / 3 IN A ROW! / ON FIRE! (tắt cái này thì cũng tắt tiếng kèn đi kèm) |

Không có hiệu ứng nào chớp quá 3 lần/giây. Máy bật "giảm chuyển động" sẽ tắt ánh sáng, pháo giấy, pháo hoa và bục nảy, trừ khi đánh dấu ô "Vẫn chạy ánh sáng…" trong khung; băng rôn và bục xếp hạng vẫn hiện nhưng đứng yên. Cài đặt được lưu trên trình duyệt.
