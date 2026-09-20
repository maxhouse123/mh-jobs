# JOB-16-05 截图索引（元素级裁剪，画面仅合成测试件，无 PII）

| 文件 | 哪端·哪版 | 这一步 | 红/绿 |
|---|---|---|---|
| student-v396-slim-fromDB-GREEN.png | 学生端 v396 | stuA 真登，重登后从**库里** slim_* 五列渲染的文件卡：`【测试】r16-slim.jpg` + 「✓ 已瘦身 680 KB → 45 KB · 1 页」（卡更高、带瘦身行）| 绿 |
| student-v395-slim-none-RED.png | 学生端 v395 | 同一份库态、同一份文件，v395 不读库 slim → 文件卡**没有**瘦身行（卡更矮）| 红 |
| partner-v163-slim-beforeReload-GREEN.png | 中介端 v163 | partner1 真登代传（is_test 学生 StuB），代传暂存件瘦身行渲染「✓ 已瘦身 680 KB → 45 KB · 1 页」（session；**提交落库未在无头 harness 复现**，见回执四）| 绿(渲染) |

说明：学生端红绿为「同一份 DB 行、v396 显 / v395 不显」的对照——差别正是本次修复（读库 slim_*）。
中介端此图证明代传端瘦身行**会渲染**；代传**提交落库**因 Q1/AI 多步闸在无头下未跑通，DB 持久化标「未放行」（wiring 与学生端全等，学生端 E2E 已 DB 验证绿）。
