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

### D-12-1 · ch3 全章施工（EN 横竖成片）——向导四步真机驱动 + 3-5/3-6 AI 预检用产品渲染喂样例（RULING §1.2）
- **章·镜**：ch3 / 3-1..3-9（第12趟，2026-10-12 Mac mini 无人值守）。
- **做法（照 RULING §1.2 + §2）**：
  - **3-1→3-4 向导四步**：CONTEXT['3'] 不设（保留登录后列表视图供 3-1 高亮 `.partner-add-student-btn`）。3-1 special=openWizard 开向导；3-2 高亮 step1 `#wzSemStart`；3-3 pre 注入 step1 合法字段(Demo Aisha/Pakistan/bachelor·CS/self/2026-fall)+`_wzNext`→step2，高亮 `text=/Date of birth/`（step2 输入**无 id**，实证只 `#wzNationality/#wzSemStart` 有 id，故用 label 文本选择器）；3-4 pre 注入 step2 合法档案+`_wzNext`→step3，高亮 `#wz_card_passport`（上传槽卡）。
  - **3-5 AI 预检（RULING §1.2 产品渲染喂样例，ch8 先例）**：wizard step3 pre 注入 `state.wiz.docs.transcript=[{name,path:'demo/referral-drafts/transcript/..',draftId}]` + `state._aiDraftHints[path]={verdict:'fail',issues:['The transcript scan is blurry in the lower half — please upload a clearer copy.']}` 后 `_wzRender()` → 产品自身 `_aiHintBandHtml` 琥珀条「Pre-check reminders ⚠ transcript.jpg + 问题 + 产品自带 footer」真渲染 + sticky `.ai-agg`「⚠ 1 document(s) have AI reminders」。高亮 `#wz_card_transcript`。零 EF/零桶/零自造界面。**关键实证**：草稿判路径认领条件是 `String(path).indexOf('/referral-drafts/')>0`（**须有前缀**，前导斜杠起始=0 不命中）→ path 用 `demo/referral-drafts/...`。
  - **3-6 护照姓名核对（同 §1.2）**：同法 pre 注入 passport 槽 `verdict:'unsure',issues:['The passport name does not match the name entered — please check the spelling.']`→产品琥珀条渲染，高亮 `#wz_card_passport`。（R-2 软提醒另有 `r2vBad` 链，但向导内用 AI 条承载姓名核对最直接，RULING §1.2 授权。）
  - **3-7 退出三选一**：pre `cancelReferralForm()` 开 `#pwzExitModal`（3 钮「💾 Save draft & exit / Keep editing / Discard」），高亮「Save draft & exit」按钮；act 完后 `_pwzExitChoice('stay')` 关窗保留向导态供 3-8。**未真存草稿**（避免写库+丢向导态）——退出-存草稿的入口肉眼可见即传达「草稿存云端」，字幕一字未改（RULING §2(b) 最近真画面最小改）。原图纸「草稿卡 #pwzDraftCard」降级为「退出存草稿入口」。
  - **3-8 真 submit → 真 app_no（RULING §2(a) 忠实真流程）**：pre 重注入全字段+清 `state.wiz.docs={}`/`state._aiDraftHints={}`（否则 Q1 闸+AI 闸拦提交）+`step=4;_wzRender()`+click `#wzNextBtn`→`_wzNext`@step4→`_wzFinalize`（check_collision+submit_referral+档案补写+submitted_at，**真 RPC 走通**）。waitFor `.student-app-id-num`（真 submit ~8s，比常规镜长），高亮真 app_no（横 `MH-XJ4XDA`；竖 `MH-R8JT4M`）。产生 guide-pt-ch3 学生(is_test=false)。
  - **3-9 列表卡审核中**：pre `closeStudentDetailModal()`+`loadMyReferrals()` 回列表，高亮 `.partner-student-status-pending`（class 选择器=语言无关，利后续中俄法）「Submitted · awaiting platform review」。首个 pending 卡=基线生(渲染完整、有脸)，非新 Aisha（新生无脸、且语言无关定位新卡脆）；字幕「bound to you」不指名，忠实传达「提交生显示审核中、绑定于你」。
- **复位（关键·避开本机脸库缺口）**：3-8 真 submit 的 guide-pt-ch3(is_test=false)**不能走 rebuild-partner.sh**——本机 jobs/JOB-G6 脸库缺 129 张(LEDGER-4 双机分割)，全量 rebuild 的 assign-faces 必崩；且 cleanup 的 is_test 安全闸遇 is_test=false 会整体回滚。故新建 `states/st-ch3-cleanup.sql`（scoped 单删 guide-pt-ch3 及其附属，不碰 9 名基线生/脸）。录 land→scoped 删→verify 16/16→录 port→scoped 删→verify 16/16，两版各复位一次。
- **真帧肉眼复验（iron-law-15）**：3-5 产品琥珀条+样例问题+高亮环+字幕对位；3-8 app_no 真高亮；3-9 列表审核中卡；全链零 @gmail（MASK TreeWalker 全扫）。EN 横 68.9s / 竖 69.4s（1920x1080 / 1080x1920 带音轨）。3-8 因真 submit 延迟段偏长(~13s)，app_no 落段尾，字幕 5s 后有拖尾——how-to 可接受，不打转。
- **改了**：rec/shots-v1.json（3-1..3-9 pre/act/waitFor/hl 全补、修死选择器 `.ai-hint`/`.amber-box`/`#wzInput_dob`/`.partner-student-status-reviewing`）、states/st-ch3-cleanup.sql（新）、rec/probe-ch3b.mjs（工装探针）。成片 ~/guide/dist/partner/ch3-{land,port}-en.mp4。

### D-12-2 · 本机脸库缺口 → ch3 复位改 scoped 删、不跑全量 rebuild（记账留后趟）
- **问题**：本趟首次为复位跑 `rebuild-partner.sh`，在第 5/6 步 assign-faces-gp1.mjs 读本地脸图崩（ENOENT `guide/dist/faces/f-01c0...jpg`）。实测 jobs/JOB-G6/faces-catalog.json 列 201 张 usable，本机 guide/dist/faces/ 只在其中 72 张（缺 129）。按 LEDGER-4，脸库在 MacBook 全、Mac mini 缺（本地资产不入 git、不跨机同步）。
- **影响**：trip 开场 verify 16/16（#14 脸 PASS）靠的是基线 9 生**既有脸**（早前在有全库的机器上传桶、DB 指针在）；本机**无法重跑全量 rebuild**（faces 必崩）。幸 cleanup 的 is_test 闸遇 guide-pt-ch3(is_test=false) 整体回滚→9 名基线生未被删、脸原封（故崩后 verify 仍 16/16，无净损）。
- **选了**：ch3（及后续任何真 submit 的章）复位一律走 scoped 单删（st-ch3-cleanup.sql 式），**不跑 rebuild-partner.sh**；基线 9 生/脸始终不动。
- **留后趟/业主**：若将来确需全量 rebuild（如重建基线），须在有全脸库的机器(MacBook)上做，或把缺的 129 张脸补到本机 guide/dist/faces/。本条仅记账，不停工（不属 RULING §2.6 四种停下情形）。
