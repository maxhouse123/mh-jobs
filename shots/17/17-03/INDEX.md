# JOB-17-03 截图索引（C：中介端 Copy link 点了有看得见的反应）

本包截图**只在本机**（`~/mh-verify/shots/JOB-16/17-03/`），**不公开图片**：Sent invites 列表与手动复制弹窗里含 partner1 名下真实测试邀请链接（带 token）与姓名/邮箱，虽已 mask 姓名，但链接 token 属敏感，按 QUEUE-16 §0.6「拿不准就不公开，只在 INDEX.md 写『本机有图』」处理。红绿判据以脚本量出的可见文字/网络计数为准（见回执与 `jobs/JOB-17-03/gate/out/*.json`）。

| 文件名（本机） | 端/版 | 这一步点了什么 | 红/绿 |
|---|---|---|---|
| partner-v163-grant-RED-chromium.png | 中介端 v163 | 给剪贴板权限，点 Copy link，1.5s | 红：无提示条，按钮 1.5s 时已被清单重画复原为「复制链接」 |
| partner-v163-deny-RED-chromium.png | 中介端 v163 | 拒绝剪贴板（writeText 抛 NotAllowedError），点 Copy link | 红：屏幕上无任何反应（旧码无 .catch，1 条未捕获拒绝 = 病本身） |
| partner-v164-grant-GREEN-chromium.png | 中介端 v164 | 给剪贴板权限，点 Copy link，1.5s | 绿：提示条「链接已复制」+ 按钮「已复制」，剪贴板 = 该邀请链接 |
| partner-v164-deny-GREEN-chromium.png | 中介端 v164 | 拒绝剪贴板，点 Copy link | 绿：走 textarea+execCommand 备用成功 → 同样弹提示条 |
| partner-v164-manual-modal-GREEN-chromium.png | 中介端 v164 | 拒绝剪贴板 **且** execCommand 也失败，点 Copy link | 绿：本端 showConfirm 单按钮（取消隐藏）弹窗显示可选中链接 +「没能自动复制…」 |
