---
name: session-relay
description: Quy trình làm việc giữ context của phiên chính luôn thấp - chia nhiều task cho các session phụ, theo dõi % context, và khi context đạt khoảng 40-50% thì commit + push, ghi bàn giao vào TODO.md rồi tự clear chat để phiên mới đọc TODO.md và làm tiếp. Dùng skill này mỗi khi người dùng giao từ hai task trở lên trong một lần, khi bắt đầu một phiên mới cần đọc TODO.md để làm tiếp, khi người dùng nói "tiếp tục", "làm tiếp", "bàn giao", "handoff", "dọn context", hoặc bất cứ khi nào context của phiên này đã cao và cần bàn giao, kể cả khi người dùng không nhắc tên skill.
---

# Session relay

Mục tiêu: phiên chính chỉ làm **điều phối** (nhận việc, chia việc, kiểm tra kết quả, bàn giao). Việc nặng chạy ở session phụ, nên context của phiên chính tăng chậm. Khi context lên khoảng 40-50%, phiên chính lưu mọi thứ lên Git và TODO.md rồi clear, để phiên sau bắt đầu từ 0 mà không mất gì.

Repo: `origin` = https://github.com/trantrungg135family-tech/HSK (nhánh `main`).
Git nằm ở `C:\Program Files\Git\cmd\git.exe` nếu lệnh `git` chưa có trong PATH.

## 1. Khi bắt đầu một phiên (hoặc ngay sau khi clear)

1. Đọc `TODO.md` ở gốc repo. Đó là nguồn sự thật duy nhất về việc đang dở.
2. `git pull` (hoặc `git status`) để chắc code local khớp với lần bàn giao trước.
3. Nếu các mục trong TODO.md nhắc tới session phụ còn đang chạy, kiểm tra bằng `mcp__ccd_session_mgmt__list_sessions` (`linked: true`) hoặc theo tên/ID được ghi lại.
4. Làm tiếp mục đầu tiên có trạng thái chưa xong, theo đúng các bước dưới đây. Không cần hỏi lại người dùng những gì TODO.md đã ghi rõ.

## 2. Khi được giao nhiều task

Lý do: mỗi task chạy trong phiên chính sẽ kéo toàn bộ file đã đọc, output lệnh, lỗi... vào context. Đưa sang session phụ thì phiên chính chỉ nhận lại bản báo cáo ngắn.

- Tách yêu cầu thành các task độc lập. Task nào **nhỏ** (trả lời câu hỏi, sửa một chỗ, vài lệnh) thì làm luôn ở đây: mở session cho nó tốn hơn là làm.
- Mỗi task thật sự (sửa code nhiều file, nghiên cứu dài, tính năng mới...) → một session phụ bằng `mcp__ccd_session__start_session`:
  - `initiation: "user_asked"` (người dùng đã yêu cầu quy trình này), `context: "fresh"`.
  - `prompt` gồm: task cụ thể, file/thư mục liên quan, thế nào là xong, và dặn session đó **commit lên nhánh riêng của nó và push nhánh đó** khi xong, cuối cùng báo lại tên nhánh + tóm tắt 3-5 dòng.
  - `background`: mục tiêu chung của dự án và các quyết định đã chốt mà task cần biết (tối thiểu 80 ký tự).
  - `use_worktree: true` khi các task có thể đụng cùng file (mặc định an toàn). Chỉ dùng `false` cho task chỉ đọc.
  - Đặt `name` ngắn, dễ nhận ra (vd. `hsk-vocab-import`).
- Task phụ thuộc kết quả của task khác thì chưa mở; ghi vào TODO.md là "chờ X".
- Ghi ngay mỗi session vừa mở vào TODO.md (tên, ID `local_…`, task, nhánh dự kiến). Nếu phiên này bị clear giữa chừng, phiên sau vẫn biết ai đang làm gì.
- Khi một session báo xong: đọc diff/nhánh của nó để kiểm tra (đừng tin báo cáo suông), cập nhật TODO.md. Gộp nhánh vào `main` chỉ khi người dùng đồng ý; nếu chưa có lệnh, ghi vào TODO.md "nhánh X chờ merge".

## 3. Theo dõi context

Gọi `mcp__ccd_session_mgmt__get_usage` (mặc định `session_id: "self"`) và xem phần trăm context:
- sau mỗi task làm xong ngay trong phiên chính,
- sau mỗi lần nhận báo cáo từ session phụ,
- trước khi bắt đầu một việc có vẻ sẽ đọc nhiều file.

Nếu ≥ 40% thì bắt đầu bàn giao (mục 4) ngay khi việc đang làm đến điểm dừng an toàn (không để file sửa dở). Nếu ≥ 50% thì bàn giao luôn, kể cả khi phải ghi "đang làm dở bước…" vào TODO.md. Ngưỡng 40% chừa chỗ cho chính việc bàn giao.

Nếu `get_usage` báo không đọc được context, ước lượng theo độ dài cuộc trò chuyện và bàn giao sớm thay vì muộn.

## 4. Bàn giao (handoff)

Làm theo thứ tự này, vì bước sau dựa vào bước trước:

1. **Cập nhật `TODO.md`** theo mẫu ở mục 5. Viết cho một người chưa thấy cuộc trò chuyện này: ghi quyết định, lý do, đường dẫn file, lệnh cần chạy. Những gì không có trong TODO.md hoặc Git thì sẽ mất sau khi clear.
2. **Commit**: `git add -A` rồi `git commit -m "handoff: <tóm tắt ngắn>"`. Kiểm tra `git status` trước, đừng commit file bí mật (`.env`, key, token…).
3. **Push**: `git push origin main`. Nếu push lỗi (chưa đăng nhập, bị từ chối, conflict…) thì **dừng, không clear**: báo người dùng lỗi gì và để họ xử lý. Clear khi chưa push được có thể làm mất bàn giao.
4. Báo người dùng 2-3 dòng: đã commit gì, TODO.md đang có những mục nào, phiên sau sẽ làm gì đầu tiên.
5. **Clear**: gọi `mcp__ccd_session_mgmt__clear_session` với `session_id: "self"`. Lệnh clear chạy khi lượt này kết thúc, nên mọi thứ cần nói phải nói trước. App có thể hỏi người dùng xác nhận.

Sau khi clear, CLAUDE.md (luôn được nạp) nhắc phiên mới đọc TODO.md. Người dùng chỉ cần gửi một tin như "tiếp tục" là phiên mới chạy mục 1.

## 5. Mẫu TODO.md

```markdown
# TODO

_Cập nhật: <YYYY-MM-DD HH:MM> — commit <hash ngắn>_

## Đang làm tiếp theo
1. <việc cụ thể đầu tiên phiên sau phải làm, kèm file/lệnh>

## Session phụ đang chạy
| Tên | ID | Task | Nhánh | Trạng thái |
|-----|----|------|-------|------------|

## Chờ (phụ thuộc / chờ người dùng)
- <việc> — chờ <gì>

## Đã xong gần đây
- <việc> (commit/nhánh)

## Ghi chú & quyết định đã chốt
- <quyết định> — vì <lý do>
```

Giữ TODO.md ngắn: chuyển các mục "Đã xong" cũ hơn vài lần bàn giao vào cuối file hoặc xoá đi, vì lịch sử đã có trong Git.
