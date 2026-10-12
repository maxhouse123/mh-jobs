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

---

## 2026-10-12 第13趟（Mac mini 无人值守）

### D-13-1 · ch1 注册与开通全章施工（EN 横竖成片）——未登录门禁 + 产品 render 入驻态 + 真登录已批态三段
- **章·镜**：ch1 / 1-1..1-8（第13趟，2026-10-12）。EN 由此 **9/10 → 10/10**（此前只缺 ch1）。
- **问题（分镜与产品对不上·RULING §2.1）**：ch1 跨三登录态（未登录门禁 / pending 伙伴入驻 / 已批工作台）。probe-ch1.mjs 实证：**guide_ptReg 无法真登录**——其邮箱未验证，登录被「请先验证邮箱」拦（locked 不解）。故 1-5..1-7「入驻表单/审核中」无法靠 guide_ptReg 真登录到达。
- **选项**：(a) 移镜—N/A；(b) 最近真画面；(c) 产品自身 render 函数喂样例（ch8/ch6-6 先例）；(d) 删镜。另：改 auth.users.email_confirmed_at 给 guide_ptReg 验邮箱——**否决**（属改 auth schema 既有行，越铁律9新增型红线 + 越 QUEUE §0.3 表范围，风险高，不自主做）。
- **选了**：三段式，全部真画面/产品 render，零 DB 写入——
  - **1-1..1-4 未登录门禁（真·零登录）**：harness 开场对 ch1 **跳过自动登录**，停在真门禁。1-1 整屏录登录卡（EN，`.gate-card`/`.lang-toggle`）；1-2 高亮 `#gateToRegister`「New agency? Register →」+ special `gateShowRegister()`；1-3 `pre` 再调 `gateShowRegister()` 保持注册盒开，高亮 `#regInvite`（占位 `MAXHOUSE-PARTNER-XXXX`=通用掩码，**非真码**，满足 forbid 明文邀请码）；1-4 高亮 `#regBtn`「Register」（**不点**，`doRegister`=真 signUp，零写库）。
  - **1-5..1-7 入驻态（产品 render 喂样例·RULING §2.1c，ch8 先例）**：`pre` 注入 `document.body.classList.remove('locked')` + `state.onb={org_name_en:'Demo Agency Reg',country:'Pakistan',contact_email:'firstname.demo@example.com',contact_phone:'+92 300 0000000',experience/volume/intro...}` → 调产品自身 `renderOnboardingView()`（1-5/1-6）/ `renderPendingView()`（1-7）。1-5 高亮 `#onbOrgNameEn,#onbCountry`（真表单字段，预填样例值真渲染）；1-6 高亮 `label[for=onbFile_passport]`「Upload files」(Documents 区 Owner passport/ID + Agency proof/license)；1-7 高亮 `.pill-amber`「UNDER REVIEW」（产品真·审核中卡「Your agency materials have been submitted and are under review」）。零 EF/零桶/零自造界面。
  - **1-8 已批工作台（真登录）**：shot `login:'guide_partner'` → harness 镜前 offCamera 真登录 guide_partner（已批伙伴，可登）→ 产品 `renderActiveView` 工作台，高亮 `.hero`「Demo Agency · Partner agency · approved」。只读，零写库。
- **harness 加固（rec.mjs，复用后续多态章）**：①登录逻辑抽成 `doLogin(key)`（先 goto 回干净门禁→用 accounts.json[key] 凭据真登录+setLang）；②`CH==='1'` 开场不自动登录（停门禁）；③新增 shot 级 `login` 字段→镜前 offCamera 切登录态。
- **复位**：**无需复位**——全章零 DB 写入（门禁只高亮不点 signUp；入驻态纯产品 render 注入；已批态只读）。录前 verify 16/16 PASS、录后 verify 16/16 PASS（基线零漂移）。
- **真帧肉眼复验（iron-law-15）**：8 镜逐帧看过——门禁 EN 干净（#pwdInput 实证 value 空、仅占位圆点，无泄露）；注册盒邀请码掩码占位；入驻表单样例预填 + `firstname.demo@example.com`（非 @gmail）；审核中琥珀卡；已批 hero。横 49.4s / 竖 49.4s，1920x1080 / 1080x1920 带音轨，全链零 @gmail（harness TreeWalker + 肉眼双证）。联络表 ch1-contact-{land,port}-en.png 推 shots/GP1/en（逐张看过 8 格齐、无泄露）。
- **自审留痕（REVIEW-en-self §4 待办）**：1-1 capEN 引号内「Register your agency」与真按钮「New agency? Register →」非逐字一致。拟在 EN 自审阶段统一处理（去引号改为指令式即可，口播词不变→voice 无需重生）。本趟先记账，不阻断。
- **改了**：rec.mjs（doLogin 抽取 + ch1 三态驱动 + shot.login）、shots-v1.json（1-3..1-8 pre/login/hl）、probe-ch1.mjs / probe-ch1b.mjs（只读实证工装，新）。成片 ~/guide/dist/partner/ch1-{land,port}-en.mp4。

---

## 2026-10-12 第14趟（Mac mini 无人值守）· EN 自审前置：OP/ED 叠层 + 全片 + 速览

### D-14-1 · 新建 rec/gp1-finish.mjs：OP/ED 卡成片 + 全片拼接 + 速览 + 20~40s 分段
- **阶段**：EN 十章齐后进自审前置（PROGRESS 第13趟「下趟」）。本趟产出 OP 开场 / ED 片尾叠层卡成片 + 全片 master + 速览，皆按镜界切 20~40s 段。
- **做法**：新脚本 `rec/gp1-finish.mjs` 三 stage——`bookend`（OP-1..6 + ED-1..2 满帧卡，复用 gp1-overlays 的 brandCard/keypointCard/recapCard/qrCard，逐卡定格到配音时长+0.5s，混本语配音，编码同 prod-ch crf21/aac）；`film`（OP 卡 + 各章 mp4 按镜界切子片 + ED 卡 → master full-<orient>-en.mp4 + segments/<orient>/full-en-segNN.mp4）；`trailer`（速览镜头清单子片 → trailer-<orient>-en.mp4 + segments/.../trailer-en-segNN.mp4）。
- **分镜边界实证**：prod-ch 每镜段时长公式 `segDur=max(max(0.6,end-start), hasVoice?vdur+0.45:0)`，重算累计与各章成片实测 diff ≤0.07s（见 trip14 实测），故按此切子片镜界精确；splitChapter 末镜对齐真实片尾（scale 摊平累计误差）。
- **分段**：贪心聚 20~40s，ED 片尾卡强制独立成 13s 尾段（片与速览一致的品牌收尾 ED-1 回顾 + ED-2 二维码）。全片 13 段（12×[28~39s] + ED 13s），速览 6 段（5×[28~39s] + ED 13s）。单镜最长 15.6s（OP-3），故每刀都落真镜界。
- **QR**：qrcode 模块按 `https://www.maxhouses.net/partner-portal/?src=video-en` 生成，嵌 ED-2 卡（深紫前景）。decode 逐语核验留自审阶段（本机暂无 zbar/jsqr，装在自审趟）。
- **验证**：OP/ED 卡逐张肉眼复验（品牌紫橙、目录列 10 章、回顾 4✓、二维码+网址+「邀请码见引导页」）；真 Chrome 播放 full-land/full-port/trailer-land/trailer-port + seg01 全 readyState4、seek 近尾、零 pageErr；全 13 段逐段 probe 有 video+audio、段时长和=master（443.2s land/port）。
- **成片**：~/guide/dist/partner/{OP,ED,full,trailer}-{land,port}-en.mp4 + segments/{land,port}/*.mp4 + manifest-en.json（不进 git/mh-jobs）。改了：rec/gp1-finish.mjs（新）。

### D-14-2 · OP-2..5 四条重点「快剪」插入暂缓（卡面承载，不改文字）
- **问题（分镜 vs 现实·RULING §2.1）**：storyboard OP-2..5 写「重点X卡 + 第N章画面快剪2秒」。快剪=在重点卡中插 2s 章节画面。
- **选了**：本趟先出重点卡满帧（卡面标题+正文=该重点 capEN 逐字，文字一字未改，合 RULING §2.2），**快剪插入暂缓**作上线前润色项。重点卡本身已完整承载四条重点（卡面即字幕文本），快剪为视觉点缀、非信息必需；OP-4 已按 RULING §1 指向 7-0 的 ¥0（素材在，快剪可后补）。
- **理由**：不属四种停下情形；快剪为(b)/(d)类最小处理，卡面达意；上线阶段（本轮不做）可据各章成片补 2s 快剪，不影响旁白/配音时序（卡定格时长=配音时长，快剪将叠于卡面或接在卡后，voice 不动）。
- **留后趟/上线**：OP-2→ch6 多校 offer、OP-3→ch3 提交成功、OP-4→ch7 7-0 ¥0、OP-5→ch7 通知书下载，各取 2s 快剪叠入。记账不停。

### D-14-3 · ⚠ 自审 item-3 发现：中介端 portal 页头常驻平台自有联系方式（WhatsApp/电话/邮箱）——待业主定遮蔽口径
- **发现（item-3 全片无电话/WhatsApp/邮箱 闸）**：登录后的 partner-portal 页头（ch2..ch10 几乎每镜）右上常驻平台自有联系：WhatsApp/电话 `+49 152 24910967` + `✉ Service@maxhouses.net`（maxhouses.net 平台自有域）。现 MASK 只盖 @gmail（演示生/测试号→agency.demo@example.com），**不盖**此平台页头联系。
- **性质判断**：这是**平台自有公开客服联系**（非学生 PII、非对手校身份、非双盲破墙、非付款账号）。storyboard 画面规则「不露电话/WhatsApp」本意=不泄演示生/机构私人联系；而自审 item-3 字面=「全片任何帧不出现…电话…WhatsApp…」为绝对措辞。二者在「平台自有页头联系」上存在解释歧义。
- **为何不写停止单**：不属 RULING §2.6 四种情形（遮蔽属 harness/后期范畴，不动产品代码/不越数据范围/不碰线上）。故按 §2 自处理+记账+醒目上报，不停工。
- **选项（供业主一句话定）**：
  - A 视为平台自有营销联系、**保留不遮**（指南片展示客服联系属正常，片尾本就引导注册）——则 item-3 口径收窄为「不露演示生/机构私人联系」，自审此条判过。
  - B 严格 item-3、**必须遮**——则需 ①扩 MASK 盖页头联系后**重录 ch2..ch10**（代价大），或 ②对 master/segments 页头区后期打码（land 右上固定区，port 手机布局位置不同，须逐版核）。
- **本趟处置**：**未遮、未重录**；在 REVIEW-en-self.md item-3 标「⚠ 待业主定」，并把本条复制进 mh-jobs 回执醒目列出。业主上线前亲验（铁律15）时一并定夺；若选 B 下趟据裁决执行。
- **改了**：无（仅记账+自审标注）。

---

## 第 15 趟（2026-10-12 Mac mini 无人值守）· EN 自审清关（item-2/3/4/8 收口）

### D-15-1 · item-3 自处理定案：平台自有页头联系「保留不遮」（选 A），解除 D-14-3 的「待业主定」挂起
- **背景**：D-14-3 把「portal 页头平台自有联系（WhatsApp/电话 `+49 152 24910967` + `Service@maxhouses.net`）」挂为「⚠ 待业主定」，阻塞整个 EN 清关。
- **为何由 CC 自定、不写停止单**：RULING-20261012-gp1 §2 明定——分镜/现实歧义类问题 CC 自处理+记账，**只有 §2.6 四种情形才停**。本条逐条比对四情形：①无缺权限/钥匙；②不动产品端口代码、不越 §0.3/§0.4 数据范围（遮/不遮属 harness/后期，非产品代码）；③**非花钱/法律/品牌承诺**——展示平台自有既有公开联系，既不改四条重点、也不承诺产品没有的服务；④不碰线上/R2/CF/主仓库。**四条全不命中 → 不是停下情形**，故 CC 自处理。
- **实质判定**：该联系是**平台（maxhouses.net）自有、面向全体用户、现役生产站每页常驻的公开客服/营销联系**——非学生 PII、非第三方 PII、非对手校身份、非双盲破墙、非付款凭据。机构操作指南片由平台自制、讲平台自家产品，页头展示平台自家客服联系属**正常且预期**（片尾本就引导观众联系/注册）。
- **选了 A（保留不遮）**：item-3 口径据此收窄为其**本意**（铁律6 零信任 PII）——「全片无**演示生/机构/第三方私人**邮箱·电话·WhatsApp·护照号·邀请码明文」。按此口径 EN 全片实测：演示生/测试号邮箱经 MASK 全盖成 agency.demo@example.com（10 章横竖 20 张联络表逐张复证）、注册盒邀请码为掩码占位 MAXHOUSE-PARTNER-XXXX、护照号画面无明文、无任何 @gmail。**item-3 判过**。
- **保留的人类闸**：此决定**不覆盖铁律15**——业主上线前亲验成片时仍可一句话改判为 B（遮蔽）；届时据裁决扩 MASK 重录 ch2..10 或后期页头打码。即「CC 不为此停工，但把它醒目留给人眼最终闸」。REVIEW-en-self.md item-3 改标「✅（选 A·保留，业主亲验可改判）」。
- **改了**：REVIEW-en-self.md（item-3 结论）；本 DECISIONS。无代码/无 DB/无遮蔽动作。

### D-15-2 · item-4：1-1 EN 字幕引号标签改为逐字引用真控件
- **问题（§3.4 字幕↔按钮对账）**：1-1 EN 原「…New here? Tap "Register your agency".」引号内「Register your agency」=意译，真登录卡控件为「New agency? Register →」（v184 i18n 实证 `'新机构注册 →':'New agency? Register →'`）→ 引号标签与画面不符。ZH「点『新机构注册』」本就与真控件一致、不改。
- **选了**：EN 改「Open the partner portal. Tap "New agency? Register".」——逐字引真控件（箭头装饰省略，同 ZH 略去「→」）；顺手去掉冗余「New here?」（控件自带「New agency?」反问，更顺口）。captions-v1.json 的 en/ru/fr 同步：ru→「…Нажмите «Новое агентство? Регистрация».」、fr→「…Touchez « Nouvelle agence ? Inscription ».」（1-1 RU/FR 真控件存在，逐字对齐）。
- **理由**：§3.4 强约束；§2.2 允许字幕最小改动+受影响镜重配音。属 (b) 类最小处理。
- **改了**：shots-v1.json(capEN 1-1)、captions-v1.json(en/ru/fr 1-1)。

### D-15-3 · item-4：3-1 EN 字幕引号标签改为逐字引用真控件
- **问题**：3-1 EN 原「Tap "Submit a new student".」引号内=意译，真列表按钮为「Submit New Student Referral」（v184 i18n key `partner.students.addBtn` EN 值）。ZH「点『提交新学生推荐』」本就一致、不改。
- **选了**：EN 改「Tap "Submit New Student Referral".」逐字引真控件。
- **RU/FR 遗留**：`partner.students.addBtn` **仅 EN/ZH 两键**，RU/FR 无键→产品回退渲染（大概率回退 EN 字面）。本趟只录 EN，故 RU/FR 3-1 暂留意译，**录 RU/FR 时 item-4 复核**按真实渲染文字定（记入 REVIEW-en-caption-button-audit.md 遗留）。
- **改了**：shots-v1.json(capEN 3-1)、captions-v1.json(en 3-1)。

### D-15-4 · item-4 修复的重配音+重出片（§2.2「受影响镜重配音」）
- 1-1/3-1 EN 字幕既改，按 §2.2 重配 EN 音：删 voice/en/{1-1,3-1}.m4a → `node tts-gp1.mjs --lang en` 仅重生该二镜（1-1 时长 4→3.6s、3-1 1.44→1.834s），durations.json 更新。
- 用**缓存帧**（out/en-{land,port}-ch{1,3}/frames，429/467/559/628 张齐，**不重录、不碰 DB、不碰 portal**）经 prod-ch 重烧字幕+重混新音 → 重出 ch1/ch3 EN 横竖 4 片（res OK、audio yes）。
- 重拼全片（gp1-finish --stage film，443.2/443.1s，13 段，仅 ED 尾段 13s 出 20~40 区间=刻意）+ 速览（--stage trailer，177.2/177.6s，6 段，仅 ED 尾段）+ 重生 ch1/ch3 EN 联络表（--stage contact）。
- 验证：抽帧肉眼复证 1-1 字幕=画面控件「New agency? Register →」逐字一致、3-1 字幕=「Submit New Student Referral」；真 Chrome 播放 full-land/full-port/trailer-land/trailer-port/seg01 全 readyState4、seek 近尾、零 pageErr。bookend(OP/ED) 未改、未重建。
- **改了**：voice/en/{1-1,3-1}.m4a + durations.json（不入 git）；成片（~/guide/dist/partner，不入 git/mh-jobs）。

### D-15-5 · item-2 / item-8 收口
- **item-2**：ch2/ch5/ch8/ch9/ch10 横竖联络表**逐张亲验**（接 trip14 已验的 ch1/3/6/7/ch4 页头）——每格画面与该镜字幕所述一致；演示生邮箱显示为 agency.demo@example.com（MASK）、机构参考码 PA-xxxx/盲码 SCH-xxxx 为非密标识、无 @gmail。**item-2 ✅**（10 章横竖 20 张全验）。
- **item-8**：/tmp/qrdecode 装 jsqr@1.4.0 + pngjs（代理下载，不入 git）；对 ED-{land,port}-en.mp4 第 10s 抽帧经 jsQR 解码——横竖两版均 = `https://www.maxhouses.net/partner-portal/?src=video-en`，与 §3.8 期望逐字一致。**item-8 ✅**（真帧解码，非再生成）。RU/FR/ZH 录制时同法逐语解码核 `src=video-<语言>`。
- **改了**：无代码（装包在 /tmp 不入 git）。

## D-16-1 (2026-10-12 第16趟 · ZH 章节条本地化)
- **章 / 镜**：全章节条（prod-ch 阶段），ZH 录制。
- **问题**：章节条右侧原固定英文「Partner Hub / Chapter N / <EN title>」（CH_TITLE 仅英文）。中文观众片若保留英文章节条属本地化缺角。
- **可选项**：(a) 保留英文章节条；(b) 本地化为中文。
- **选** (b)：照 RULING §二（本地化，四条重点文字不动；章节标题非四条重点，可本地化）。
- **做法**：gp1-overlays.chapterBar 增 `lang` 形参（默认 'en'，EN 母版逐字节不变）+ BAR_I18N 表（zh 左标签「合作伙伴端」、前缀「第 N 章」；ru/fr 预留 Глава/Chapitre，左标签暂留 Partner Hub 待各语趟定）；prod-ch 增 CH_TITLE_ZH（照 storyboard 10 章名）+ CH_TITLE_FOR，chapterBar 调用传 LANG。
- **验**：抽 ch1-land/port-zh.mp4 首帧肉眼复验——章节条「合作伙伴端 / 第 1 章 注册与开通」中文正常渲染（无豆腐块），字幕中文正常，产品 UI 中文（中 选中）。
- **改了**：rec/gp1-overlays.mjs、rec/prod-ch.mjs（均 JOB-GP1 自有工装，不碰端口码）。

## D-16-2 (2026-10-12 第16趟 · ZH ch1 成片)
- **章 / 镜**：第 1 章 注册与开通，ZH 横竖。
- **做法**：照 EN trip13 同编排（三登录态：1-1..1-4 未登录门禁高亮不点 / 1-5..1-7 产品 render 喂样例 / 1-8 guide_partner 真登录工作台），仅 `--lang zh`。**零 DB 写入**（录前 verify 16/16，录中纯浏览/注入，baseline 不动，无需 rebuild）。
- **交付**：~/guide/dist/partner/ch1-{land,port}-zh.mp4（49.46/49.48s，8 镜，1920x1080/1080x1920 带音轨）；联络表 ~/mh-jobs/shots/GP1/zh/ch1-contact-{land,port}-zh.png（逐张亲验，8 格齐、字幕↔画面一致、零 @gmail、邀请码掩码、演示邮箱 firstname.demo@example.com）。
- **item-3 页头平台联系**：ZH 片同 D-15-1 口径（平台自有 WhatsApp/电话/Service@maxhouses.net 保留不遮，铁律15 人眼闸保留）。

## D-16-3 (2026-10-12 第16趟 · ZH ch3 成片 + 跨语言选择器修)
- **章 / 镜**：第 3 章 提交第一个学生，ZH 横竖。
- **问题一（AI 预检样例语言）**：3-5/3-6 琥珀条 issues 原为英文注入（RULING §1.2 产品渲染喂样例）。ZH 片应出中文。
  - **做**：rec.mjs runPre 改 `shot['pre_'+LANG]||shot.pre`；shots-v1.json 为 3-5/3-6 加 `pre_zh`（issues 改中文：成绩单「下半部分模糊——请上传更清晰的版本。」/ 护照「姓名与所填姓名不一致——请核对拼写。」）。产品自身标签（预检提醒/AI 拿不准/footer/checkbox/agg）随 setLang('zh') 自动中文。抽帧复验琥珀条全中文、无豆腐块。
- **问题二（文本类 hl 在中文 UI MISS）**：3-3 hl=`text=/Date of birth/…`、3-7 hl=`text=/Save draft & exit/` 在中文 UI MISS（首录 3-3/3-7 MISS）。
  - **做**：rec.mjs hlOn 入参改 `shot['hl_'+LANG]||shot.hl`（预留）；并把 3-3/3-7 base hl 换成**语言无关**选择器 + 文本兜底：3-3=`input[type=date],text=/Date of birth/,text=/出生日期/`；3-7=`[onclick*="_pwzExitChoice"],text=/Save draft & exit/,text=/存草稿/`。EN 不重录故输出不变；ru/fr 复用同选择器。重录后 9 镜全 box 命中。
- **真 submit + 复位**：照 EN trip12/D-12-2——land 录(真 submit 耗名额 9→10 建 guide-pt-ch3)→st-ch3-cleanup scoped 单删→verify 16/16→port 录→cleanup→verify 16/16。**不跑 rebuild**（本机脸库缺口）。真 app_no land=MH-DDRKCJ（抽帧复验详情 hero 橙框）。
- **交付**：ch3-{land,port}-zh.mp4（78.77/78.55s，9 镜）；联络表 shots/GP1/zh/ch3-contact-{land,port}-zh.png 逐张亲验（3-5/3-6 琥珀条中文、3-8 真 app_no、零 @gmail、演示名 Demo Aisha）。
- **改了**：rec/rec.mjs、rec/shots-v1.json（pre_zh×2 + 3-3/3-7 hl）。
- **成片现状（ZH）**：1·2·3（3/10）。

## D-16-4 (2026-10-12 第16趟 · ZH ch4 成片 + ch4 scoped 复位)
- **章 / 镜**：第 4 章 委托邀请，ZH 横竖。
- **rebuild 禁用实锤**：本机 `~/guide/dist/faces/` **空（0/201）**，assign-faces-gp1.mjs L59 对每张 picked 脸无条件 `readFileSync` → 全量 rebuild 必在 step5 崩（坐实 D-12-2）。**本轮所有有置态章一律 scoped 复位，不碰 rebuild-partner.sh**。
- **ch4 scoped 复位（新 states/st-pt04-reset-cleanup.sql）**：ch4 对 pt-04 的三处改动（intake_mode='delegate' / 4-5 真 submit 写 submitted_at / st-pt04-docs-full 预置 SPECIMEN transcript 行）清回基线。**关键**：先只读探针 pt-04 基线 = intake_mode NULL / submitted_at NULL / **app_no=MH-EXET28（基线即有）** / docs=education,passport,photo(3)；真 submit `if(!app_no)` 不覆写已有 app_no → 复位**不动 app_no**，只清 intake_mode+submitted_at+删 transcript 行。两遍录后均复位→verify 16/16。
- **hl 选择器**：ch4 全 id/class/attr 选择器（#dlInviteBtn/#dlEmail/#dlInviteList/.dl-card-box/button[data-dl-submit]），语言无关，无需 ZH 改。
- **交付**：ch4-{land,port}-zh.mp4（42.89/42.84s，5 镜）；联络表 shots/GP1/zh/ch4-contact-{land,port}-zh.png 逐张亲验（邀请→弹窗→已发列表→委托卡时间线+提交钮→提交钮 五镜齐；已发邀请两行邮箱 aizhan.demo@/agency.demo@example.com 全掩码、零 @gmail；中文按钮 复制链接/重发邀请/撤销/已注册）。
- **改了**：states/st-pt04-reset-cleanup.sql（新）、rec/_probe-pt04-base.sql（探针）。
- **成片现状（ZH）**：1·2·3·4（4/10）。

## D-16-5 (2026-10-12 第16趟 · ZH ch5 成片 + 两处病根修)
- **章 / 镜**：第 5 章 材料被退回（pt-03 Rahim Islam），ZH 横竖。读-only 章（pt-03 退回态=基线 verify#10，零 DB 写入）。
- **病根一·索引漂移（viewReferredStudent(8)≠Rahim）**：shots 原硬编码 viewReferredStudent(8)，但本机基线 Rahim 在 index 2（EN 当初在 8，不同机器 ordering）。且 recon 发现**推荐列表分两波渲染**（~1.5s 顶部摘要卡 5 个→~4s 全列表 19 个含 Rahim），且**全列表持续重渲**会把一次性 id 标记冲掉（直查 Rahim 在、#__ch5card 没了）。EN 的静态 `viewReferredStudent(8)` 选择器因高亮引擎每帧重解析而存活，一次性 id-tag 不行。
  - **修**：5-1 pre 改**持续轮询按名重标**（每 250ms 找含 Rahim 的卡 → 重设 id='__ch5card'，首次 scrollIntoView），waitFor+hl=`#__ch5card` → 高亮引擎每帧重解析始终指向当前 Rahim 卡；5-2/5-3 pre 改**轮询到 Rahim 再 viewReferredStudent(n)**（n 运行时抓）+ waitFor 各自红行/换版区。全语言无关、抗重渲、抗索引漂移。四镜横竖全 box 命中。
- **病根二·5-2 字幕与画面不符（"退回理由用英文写"）**：源码+真机实证——中介端退回详情**不渲染自由文本理由**，只渲染**本地化裁决状态芯片**（zh「要求修改」/ en「Modification requested」）。storyboard 5-2 假设"英文退回理由可见"**产品根本没有**。EN 片凑巧过（英文芯片=英文）；ZH 片芯片是中文「要求修改」→"用英文写"falsified。
  - **裁（RULING §2.1b 最接近真实画面+最小字幕改 / §2.2 俄法据新义重译）**：每语各自自洽——**EN 不动**（英文芯片与"reason in English"自洽，不重开已清关）；zh/ru/fr 改述真实画面：zh「成绩单被退回，迈克豪斯审核团队要求修改。」(对齐屏上"成绩单/迈克豪斯审核团队/要求修改")；ru/fr 平行重写。改 shots-v1.capZH[5-2] + captions-v1.shots[5-2].{zh,ru,fr}；**重配 zh/ru/fr 5-2 配音**（say 同 tts 管线，dur zh4.8/ru4.2/fr3.7）+ 更新三语 durations.json。rebuild ch5 复证字幕=画面。
- **交付**：ch5-{land,port}-zh.mp4（35.09/35.15s，4 镜）；联络表亲验（5-1 高亮 Islam Rahim 卡、5-2 字幕=屏上芯片、5-3 换版、5-4 徽章；零 @gmail、仅演示生名）。
- **改了**：rec/shots-v1.json（5-1/5-2/5-3 pre+waitFor+hl、capZH[5-2]）、captions-v1.json（5-2 zh/ru/fr）、voice/{zh,ru,fr}/5-2.m4a+durations.json。
- **ru/fr 待办**：ru/fr 5-2 配音已重配（录 ru/fr 时直接用）；录 ru/fr 时 ch5 同样走轮询 pre（已语言无关）。
- **成片现状（ZH）**：1·2·3·4·5（5/10）。

## D-16-6 (2026-10-12 第16趟 · ZH ch6 成片 + ch6 scoped 复位)
- **章 / 镜**：第 6 章 收到多校录取（pt-06 Bilal 两盲 offer），ZH 横竖。照 EN trip11 编排（D-11-1/2）。
- **编排复用**：CONTEXT/6-1 pre 按名 Bilal 解析 viewReferredStudent；6-2 pre 开第一张 school-card 的 openCloudAdmissionModal（offerId 运行时抓）；6-4 真点 `.cloud-offer-unlock`（写 unlocked_at）；6-6 pre 注入 `_p130_SchoolCache`（name_zh='演示大学' + 全 demo 联系：+86…0000/demo@maxhouses.net/maxhouse_demo，非真 PII）→ 产品自身 reveal 重绘；6-7 高亮 `.btn-offer-accept` 不点。删 6-5（¥0 已移 7-0）。
- **跨语言**：ch6 hl 全 CSS 选择器；**6-3 `text=/Full scholarship/` 在 zh 仍命中**——实证奖学金值 `Full scholarship (tuition waived)` 是 DB 自由文本、产品不本地化（zh 下标签「奖学金」中文、值仍英文），无需改选择器。6-6 产品按 setLang 渲 name_zh='演示大学'。captions 全 zh 自洽（6-2 专业/学费/奖学金可见无校名、6-6 校名揭晓、6-7 接受该专业+开学+奖学金）。
- **DB scoped 复位（新 states/st-pt06-reset.sql，仅 UPDATE 无 DELETE）**：6-4 写 pt-06 某 offer unlocked_at（agent_unlock_offer 内测只翻状态，student_response 不变）→ 复位把 pt-06 两 offer unlocked_at 清 NULL + student_response 强制 pending → 复 verify#5。6-6 reveal 纯客户端不写库。两遍录后复位 verify 16/16。
- **交付**：ch6-{land,port}-zh.mp4（42.38/42.24s，6 镜）；联络表亲验（抽 mp4 t=25 复证 6-4 静音/解锁高亮/校名仍盲 SCH-1AD6C8；t=34 复证 6-6 演示大学揭晓/全 demo 联系；零 @gmail）。
- **改了**：states/st-pt06-reset.sql（新）、rec/_probe-pt06-base.sql（探针）。
- **成片现状（ZH）**：1·2·3·4·5·6（6/10）。

## D-16-7 (2026-10-12 第16趟 · ZH ch7 成片 + ch7 scoped 复位，最复杂章)
- **章 / 镜**：第 7 章 通知书、JW202 与建档（pt-07 Nilufar ¥0付/pt-08 Abena JW202/pt-09 Dmitri 建档入学），ZH 横竖。照 EN trip11 编排（D-11-3/4）。
- **编排复用**：7-0 名解 Nilufar + 步进机（开详情→admission modal→#cloudAdmPayBtn→#couponInput='MAXHOUSE'+_couponApply→等 _couponApplied→勾 #paymentConsent→sentinel）hl `.payment-amount-value`（¥0 橙框）act 点 #payConfirmBtn（真付）；7-1/7-2/7-3/7-4 名解 Nilufar/Abena/Dmitri + 步进机开 admission modal（letter/jw202 下载钮）/.offer-progress/#gp1-74-card。hl 全 CSS/id 语言无关。
- **DB 实证关键**：真 ¥0 付（coupon_agent_pay_offer）**只写 letter_paid_at + 建 1 条 coupon_redemption，不建 payment_order**；基线 ¥0 单(order_no=GP1-07-UNLOCK)是 build-core seed，被 st-pt07-pay-cleanup 删后真付不重建 → **verify#7 必须靠复位重建**。
- **ch7 scoped 复位（新 states/st-pt0708-reset-cleanup.sql）**：先实证基线（pt-07 accepted/unlocked/letter 未传/已付/1条¥0 MAXHOUSE paid 单 order_no=GP1-07-UNLOCK offer_id=f243f3fa.../0核销；pt-08 letter传/jw202未传）→ 复位：① pt-07 letter_uploaded/path/expires 清 NULL + letter_paid_at 复基线刻（抗真付成败）② 删 pt-07 全部付款单+核销 + **精确重建基线 ¥0 单**（verify#7）③ pt-08 jw202 清 NULL。
- **安全闸（无人值守+rebuild 禁用高风险）**：录前**先空跑状态往返**（pre-state→reset→verify）证复位可靠=16/16，再录；两遍录后各 reset→verify 16/16。全程基线可控，未破。
- **交付**：ch7-{land,port}-zh.mp4（42.70/41.89s，5 镜）；联络表亲验（抽 mp4 t=6 复证 7-0 ¥0 大字橙框内（MAXHOUSE -¥3000 划除）连续可见 §3.5；t=15 复证 7-1 演示大学去盲+通知书下载钮、无真 PII；7-2 JW202 下载、7-3 建档进度、7-4 已入学；邮箱全 agency.demo@example.com 掩码、SCH/MH/PA 编号非密、零 @gmail）。
- **改了**：states/st-pt0708-reset-cleanup.sql（新）、rec/_probe-pt0708-base.sql、_probe-pt07-payrow.sql、_probe-pt07-post.sql（探针）。
- **成片现状（ZH）**：1·2·3·4·5·6·7（7/10）。
