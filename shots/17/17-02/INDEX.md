# JOB-17-02 公开截图（元素级 · 合成件 · 无 PII）

| 文件 | 哪端哪版 | 这一步 | 红/绿 |
|---|---|---|---|
| admin-v217-pdf-direct-GREEN.png | 管理端 v217（stub 会话） | 真点「查看原件」→ 走 admin_log_doc_view 直读存储（网络：RPC+storage GET，无 admin-doc），信息行标「直读」 | 绿 |
| reviewer-v42-3rd-group-open-GREEN.png | 审核端 v42（reviewer1 真登） | 滚到第 3 个学生组停一会（IntersectionObserver 预取该组）→ 真点「查看」→ 该件 0 个新请求、94ms 秒开 | 绿 |

说明：两张均为元素级截图（弹窗/预览体本身），画面内 PDF 为 kit2 合成件（c3.pdf），无任何真实学生 PII。
红版对照（旧 v216 走 admin-doc、旧 v41 点开发起新下载）以脚本量得的网络计数为准（gate-admin.mjs / gate-reviewer.mjs 日志），非视觉件不单独出图。
