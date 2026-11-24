# Âm thanh & hiệu ứng trong Classroom Feud

Game dùng âm thanh thu sẵn (nhúng thẳng trong `Classroom-Feud.html`, không cần file riêng, chơi được khi mất mạng). Nếu trình duyệt không giải mã được, game tự dùng âm thanh tổng hợp như trước.

## Nguồn (đều CC0: dùng tự do, kể cả thương mại, không bắt buộc ghi công)

| Gói | Tác giả | Link |
|-----|---------|------|
| 200 Free SFX | Kronbits | https://kronbits.itch.io/freesfx |
| Interface SFX Pack 1 | ObsydianX | https://obsydianx.itch.io/interface-sfx-pack-1 |

Âm thanh đã được cắt khoảng lặng, chuẩn hóa âm lượng, đổi sang mono Opus/WebM 48 kbps (tổng ~115 KB).

## Âm thanh và hiệu ứng theo từng thao tác

| Thao tác | Âm thanh | Hiệu ứng hình |
|----------|----------|---------------|
| Mở ô có điểm | Tiếng lật "vút" + "ting" đồng xu (Kronbits *Swooosh 07*, *PickUp Coin 04*) | Ô lật, số **+điểm** bay lên từ ô, pháo giấy nhỏ |
| Mở ô **điểm cao nhất** | Thêm giai điệu chiến thắng (*Success Melody 01*) | Nhãn vàng **TOP ANSWER!**, ô phát sáng nhấp nháy, vệt sáng quét 2 lần, pháo giấy lớn |
| Mở ô trong vòng **nhân điểm** | Thêm tiếng phép thuật lấp lánh (*Magic 06*) + kèn | Dấu ×2 đóng lên ô, số điểm to màu vàng, pháo giấy vừa |
| Vòng nhân điểm bắt đầu | Tiếng nạp năng lượng (*Charge StereoUP 01*) + chuông | Màn giới thiệu DOUBLE POINTS |
| Vòng thường bắt đầu | Tiếng "vút" + kèn ngắn | Màn giới thiệu vòng |
| Sai (X) | Tiếng sai (*Event Wrong Echo 03*) + tiếng đập | Chữ X lớn, bảng rung |
| Đủ 3 lần sai | Còi báo động (*Alarmed 06*) + kèn | Bảng "CƠ HỘI CƯỚP ĐIỂM" |
| Cướp điểm thành công | Trống dồn + tiếng tăng sức mạnh (*PowerUP 23*) | Pháo giấy ở bục đội |
| Cướp điểm thất bại | Tiếng thất bại (*Negative Long 01*) | Bảng rung |
| Mở hết bảng | Giai điệu hoàn thành (*Success Melody 04*) | Mưa pháo giấy ngắn |
| Hết giờ | Tiếng thất bại + giọng "Time out!" | Đồng hồ nhấp nháy, chữ HẾT GIỜ |
| Cộng điểm tay / đổi lượt / mở ô không tính điểm | Tiếng đồng xu / tiếng nút (ObsydianX *cursor_style_2*) | — |
| Kết thúc trò chơi | Kèn chiến thắng + giọng "You win!" + hợp xướng (*Success Melody 02*) | Mưa pháo giấy |

Đếm ngược 3-2-1 và tiếng tích tắc đồng hồ vẫn là âm tổng hợp.

Máy bật chế độ "giảm chuyển động" (Windows: Settings → Accessibility → Visual effects → Animation effects) sẽ tắt pháo giấy và rung; nhãn TOP ANSWER và số điểm vẫn hiện nhưng đứng yên.

## Đổi âm thanh

Dữ liệu nằm trong `const SFX_DATA = {...}` (base64 WebM/Opus) của `Classroom-Feud.html`; cách phối từng thao tác nằm trong `const MIX = {...}` của module `Sound`. Muốn đổi tiếng nào, báo Claude tên thao tác và tiếng mong muốn.

## Hiệu ứng ánh sáng (nút bóng đèn trên thanh trên cùng)

8 hiệu ứng, bật/tắt từng cái, mỗi cái có nút **Thử** để xem trước. Có 3 mức nhanh: **Tắt**, **Nhẹ nhàng** (đèn pha, hào quang đội, tia vàng, bụi vàng), **Đã đời** (tất cả — mặc định).

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

Không có hiệu ứng nào chớp quá 3 lần/giây. Máy bật "giảm chuyển động" sẽ tắt ánh sáng và pháo giấy, trừ khi đánh dấu ô "Vẫn chạy ánh sáng…" trong khung. Cài đặt được lưu trên trình duyệt.
