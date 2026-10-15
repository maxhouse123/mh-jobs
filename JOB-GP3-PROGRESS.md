最后一趟：2026-10-15 12:11 GP-3：做完 GP3-00 诊断（A字幕=原生控制条盖贴底字幕带、非文件问题；B跟随框=位置准、病在时序同步晚起/早熄），写请示单停点一；下趟等 RULING-*-done 裁决后做 GP3-01(页面) 或 GP3-02(成片)。

## 任务顺序
- [x] GP3-00 诊断（停点一）—— A 字幕可见性 / B 跟随框 / C OP·ED·速览（已写 NEEDS_OWNER_DECISION，停）
- [ ] GP3-01 修页面（若裁走页面）
- [ ] GP3-02 修成片（若裁需要）
- [ ] GP3-03 线上真验 + 收官

## 已停点一（等裁）
- 请示单 jobs/JOB-GP3/NEEDS_OWNER_DECISION.md（= JOB-GP3-NEEDS_OWNER_DECISION-20261015-121128.md）
- 三问待业主：A/B 方案口径 + 字幕现象设备确认（手机/电脑、章/速览、播放/暂停、横/竖）
- 证据 ~/mh-jobs/shots/GP3/（A_*、B_*、C_*、pageA2/_metrics.json）

## 本趟记录
- A：线上 v4 四语横竖 HD/lite/seg/trailer 抽帧→字幕带全烧入贴底；真浏览器→控制条盖字幕是主因，两页同病；顶部播放器 cover vs 学生 contain 隐患。
- B：80 timeline 全 resolved；稳态位置≤2px；时序晚起 0.5-2.0s/早熄~1s，集中交互触发镜。
- C：OP/ED 整屏卡不受影响；trailer 有字幕；QR 承 GP-1。
- 工装：jobs/JOB-GP3/gp3-00-*.mjs（5 个）。
