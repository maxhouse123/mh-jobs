# JOB-GP1 · CC 自主决定账本
每条：时间 / 章·镜 / 问题 / 选项 / 选了哪个 / 理由 / 改了哪些文件。规矩见 RULING-20261012-gp1 §2.5。

---

## 2026-10-12 第11趟（Mac mini 无人值守）

### D-11-1 · ch6-6「校名揭晓」= 产品自身 reveal 渲染喂演示校数据（RULING §2.1c，ch8 先例）
- **章·镜**：ch6 / 6-6（校名揭晓）。
- **问题**：RULING §1 定 ch6「6-4 解锁 → 6-6 校名揭晓」。但源码复核 + 真机实证（probe-ch6full）证实：partner 端 beta 解锁按钮 `.cloud-offer-unlock`→`_cloudAdmUnlock`→`agent_unlock_offer` RPC **只翻 `unlocked_at`，服务端不去盲**——`get_agent_unlocked_offer_school`(迁移0184) 对已翻 unlocked_at 且 sent_by 非空的 offer 仍返回 `[]`；真校名只有「接受 offer + 付通知书解锁费」后才由服务端放出（源 L5621 privacy 文案亦明示）。pt-06 是盲 pending offer，走解锁按钮永远不现校名。
- **选项**：(a) 移到已付款学生 pt-09（但 ch6 是 pt-06 两盲 offer 的戏，换人破叙事）；(b) 删 6-6（RULING 要求保留）；(c) 用产品自身 reveal 渲染喂演示校数据（ch8「提额已批」横幅先例）；(d) 自造界面（铁律15 禁）。
- **选了**：(c)。6-4 仍真点解锁按钮（真写 unlocked_at，authentic 动作 + toast），6-6 的 `pre` 把**真·演示大学**数据注入产品自己的 `_p130_SchoolCache[offerId]`，再调产品自己的 `openCloudAdmissionModal` 重绘——`admission-id-tag--unlocked` + `_p130_ContactBlock` 由**产品源码**渲染，像素与已付款学生(pt-09)完全同源。注入的校名/城市/联系方式全是既有演示校 Demo University 的真数据（demo.maxhouses.net / +86 10 0000 0000 / demo@maxhouses.net，全假），非自造。
- **理由**：RULING §2.1 授权「产品自身渲染函数 + 样例数据」做前端示意（c 档），与 ch8 先例同。真帧复验 6-6：绿色 unlocked 胶囊「Demo University · 演示大学 · 📍 Wuhan / 武汉 · SCH-1AD6C8」+ 联系块全出，无真 PII、无 @gmail。
- **改了**：jobs/JOB-GP1/rec/shots-v1.json（6-6 加 pre 注入；6-4 去掉等不到的 `wait .admission-id-tag--unlocked`，改真点+停顿）。

### D-11-2 · ch6-7 字幕去掉「倒计时」（RULING §2.1b，最小改）
- **章·镜**：ch6 / 6-7（接受）。
- **问题**：RULING §1 列 6-7 =「接受与倒计时」。但真机实证：倒计时/截止日块（源 L5624-5633）只在 `resp==='accepted' && letter_uploaded && !paid` 时渲染；pt-06 盲 pending offer 的录取弹窗**无任何倒计时/截止日元素**，画面只有「✓ Accept this program」按钮 + START DATE 2027-09-01 + SCHOLARSHIP。字幕原文「Accept before the deadline — the countdown is right here」宣称画面没有的倒计时，触发自审 §3-4（字幕与画面不符）。
- **选项**：(a) 移镜（倒计时在后段付款链，非 ch6 戏）；(b) 最小改字幕为画面真有之物（开学日期/奖学金）；(c) 产品渲染喂数据造一个倒计时（画蛇添足、且 pending 态本无此逻辑）；(d) 删 6-7（RULING 要保留接受镜）。
- **选了**：(b)。四语字幕改为陈述画面真有的「接受该专业 + 开学日期 + 奖学金」，不提倒计时。EN/中最小改，RU/FR 据 EN 重译并回译自检。
  - EN: "Accept the programme — the start date and scholarship are right here."
  - 中: "接受这个专业——开学日期和奖学金都在这里。"
  - RU: "Примите программу — дата начала и стипендия указаны здесь."
  - FR: "Acceptez le programme — la date de rentrée et la bourse sont indiquées ici."
- **理由**：四条重点文字一字未动（6-7 非重点句）。章内字幕按 RULING §2.2 据画面真值最小改，6-7 音频四语重配。
- **改了**：jobs/JOB-GP1/captions-v1.json（6-7 四语）、jobs/JOB-GP1/rec/shots-v1.json（6-7 capEN/capZH 同步）、voice/{en,zh,ru,fr}/6-7.m4a 重生。

### D-11-3 · ch6 删 6-5（优惠码 ¥0 镜移 7-0），shot_count 61→60（+7-0 后回 61）
- **章·镜**：ch6 / 6-5。
- **问题/依据**：RULING §1 定案——¥0 优惠码属通知书付款链，不在 pt-06 盲解锁链上，删 6-5、移到第7章开头 7-0（pt-07 真付款单上录，复用 6-5 音频字幕）。
- **选了**：照 RULING 执行。shots-v1.json 删 6-5 镜；captions 的 6-5 条留待改名 7-0（ch7 趟处理）。
- **改了**：jobs/JOB-GP1/rec/shots-v1.json（删 6-5）。

### D-11-4 · ch7 新增 7-0（¥0 优惠码，照 RULING §1），并重录 ch7 EN 横竖
- **章·镜**：ch7 / 7-0（新）+ 7-1..7-4（重录）。
- **做了**：
  - **7-0**：pt-07(Nilufar) 通知书付款单上，真机驱动「开录取弹窗→Pay now→付款单显示 ¥3,000→优惠码框打 MAXHOUSE→Apply→应付 ¥0(橙框≥2s)→勾同意→确认」。确认走 `confirmPayment()`→`coupon_agent_pay_offer` RPC **真写 letter_paid_at**（探针实证：确认后 2s 内下载钮出现、offer 转 paid、建 1 条 coupon_redemption）。7-0 旁白/字幕/四语配音**复用原 6-5**（voice/*/6-5.m4a 直接拷成 7-0.m4a，durations 同步），字幕一字未改。
  - **7-1..7-4 重录**：pt-07 经 7-0 确认后转 paid → 7-1 下载通知书（校名 Demo University 此处是**真·服务端去盲**，因已付款）；7-2 pt-08 JW202；7-3 pt-09 建档进度；7-4 pt-09 列表卡。全部改**按名字解析 viewReferredStudent(N)**（N=列表序随 rebuild 变，硬编码 2/3/4 已失效；Nilufar 现=5，按名字找最稳）。
  - **置态**：录前 `st-pt07-pay-cleanup.sql`（pt-07 未付+通知书已传，删自家 ¥0 payment_order 1 行、coupon_redemptions 0 行——授权 §0.3/§0.4+RULING §1）+ `st-pt08-jw202.sql`。录后 rebuild 复位 verify 16/16 PASS（两版各一次）。
  - **G-3 D1 遮蔽**：探针实证当前 v184 付款单**无** PayPal / 1st-free / half-price 说明元素（findText 零命中），无需遮蔽；优惠码框/¥0/确认钮均未动（符合 D1）。
  - **OP-4 快剪改用 7-0 ¥0**；storyboard 升 v1.1；shots/captions 同步。
- **选项/选了**：RULING §1 已定方案（7-0 真付款链录 ¥0），本可用 §1 的「确认录不到则置态补」兜底；实测确认 RPC 本地走得通 → 用真确认（更忠实，7-1 下载钮自然出现）。
- **真帧复验**：7-0 横竖 ¥0.00 橙框 + ¥3,000 删除线 + MAXHOUSE，邮箱全遮 agency.demo@example.com；7-1 下载钮现；零 @gmail。EN 横竖成片 ~42s / 1920x1080 & 1080x1920 带音轨。
- **改了**：rec/shots-v1.json（7-0 新 + 7-1..7-4 名字解析 + OP-4）、captions-v1.json（6-5→7-0）、states/st-pt07-pay-cleanup.sql（新）、voice/*/7-0.m4a（拷自 6-5）、storyboard-v1.md（v1.1）、rec/patch-ch7.mjs / probe-ch70.mjs（工装）。
