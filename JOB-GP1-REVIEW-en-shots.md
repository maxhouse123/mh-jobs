# REVIEW-en-shots · 逐镜对账表（review1 §十一）· EN

取帧点＝每镜字幕显示中点那一帧。高亮区文字从当时 DOM 读（非抄分镜）。
本文件随返工逐章追加；满章返工完毕后并入 EN 十一项重审。

## ch9 §三.6（增值服务名，返工第23趟 2026-10-12）
根因：增值服务区（PREMIUM SERVICES）由 `_v107renderPremiumBlock` 在 `renderPartnerStudentsSection` 内渲染，**只在推荐生列表卡里，不在详情弹窗**（实证：`#studentDetailModal` 内 0 个 `.partner-premium-block`）。旧版 CONTEXT 开详情弹窗→弹窗遮住列表、高亮回退到弹窗后首张列表卡的行→9-2/9-3 框错行且不在视口。改为不开弹窗、滚首张列表卡增值服务区、逐镜高亮 first-visible 真行（9 张卡服务行同构同价，字幕不点名学生）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字 | 同一件事？ |
|----|----------|---------------------|-----------|
| 9-1 | Optional extras, only if you want them: | 📦 PREMIUM SERVICES · Invested on this student: ¥0 | 是（框增值服务区标题行） |
| 9-2 | the Audit Service, which removes the basic 2-offer cap and adds 30 days of premium placement, | 🚀 Audit Service · Inactive · Activate ¥1,500 | 是（框 Audit Service 行；据产品 `partner.vapay.auditDesc`="removes the 2-offer basic-tier cap, premium placement, and a 30-day service window." 改写） |
| 9-3 | Human-assisted Search, where a Maxhouse advisor builds a bespoke school shortlist for the student, | 🤝 Human-assisted Search · Inactive · Activate ¥600 | 是（框 Human-assisted Search 行；据 `partner.vapay.searchDesc`="a Maxhouse advisor builds a bespoke shortlist for the student." 改写） |
| 9-4 | and paid exposure, which places the student in more universities' candidate pools. | 📡 Exposure boost · inactive … Activate · from ¥4,500 | 是（框 Exposure boost 行，字幕未改，review1 §三.6 保留） |

- 时长：land 22.82s / port 22.78s。全片 DOM 扫描 no @gmail。
- 页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1 批准）。演示生 Serikova Aizhan，无真 PII。
- 高亮逐张亲眼复验：9-2 框 Audit Service 行、9-3 框 Human-assisted Search 行、9-4 框 Exposure boost 行，各不越界。

## ch5 §三.3（5-2 字幕与画面对不上，返工第24趟 2026-10-12）
问题（review1 §三.3）：5-2 旧 EN 字幕「The reason is written in English, so every agent can read it.」声称画面上有"用英文写的退回理由"，但中介端退回详情**不渲染任何自由文本理由**，只渲染本地化裁决芯片（EN「Modification requested」）。ZH/RU/FR 已在 trip16（D-16-5）改成描述真实画面；EN 当初因"英文芯片=英文、自洽"未改。review1 §三.3 明令「不要因为英文已清关就不改」，EN 一并改成描述真实画面。
改法：EN 字幕改为「The transcript was returned — the Maxhouse review team requested a change.」与 zh/ru/fr 对齐。缓存帧重烧（5-2 为详情弹窗帧，不含工作台漏斗，不碰 DB）——改 `shots-v1.json` capEN[5-2]（烧字幕源）+ `captions-v1.json` shots[5-2].en（配音源）→ 重配 EN 5-2 配音（3.3s→4.4s，仍在 5-2 的 6.51s 视窗内，不越界进 5-3）→ `prod-ch` 重合成 EN ch5 横竖（缓存帧，无需重录）。

| 镜 | 字幕原文（新） | 高亮区 DOM 实际文字（从 5-2 段中帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 5-2 | The transcript was returned — the Maxhouse review team requested a change. | `.reviewer-row-rejected`：⚠ Maxhouse review team · Modification requested（材料为 "Academic transcript · REJECTED"） | 是（"transcript"↔Academic transcript；"Maxhouse review team"↔屏上同名芯片；"requested a change"↔Modification requested） |

- 时长：land 32.02s / port 32.09s（4 镜）。5-2 段中帧横竖均亲眼复验：高亮框住 "Maxhouse review team · Modification requested" 行、字幕 2 行内不溢出、no @gmail、演示生 Islam Rahim 无真 PII。
- **⚠ ch5 非最终版（5-1 仍阻塞）**：本趟仅返工 5-2。5-1 是工作台 hero 帧，缓存帧里仍显旧 `TOTAL PAYMENTS PROCESSED ¥-9,000`（缺陷1 已在 D-20-2 数据层修好＝hero ¥0，但此缓存帧录于修复前）且含缺陷2 的全 0 漏斗（产品算法 bug，待业主裁决）。ch5 最终版待缺陷2 NEEDS_OWNER_DECISION 裁决后、对已修数据重录全章（届时 5-1 自动显 ¥0，5-2 新字幕已就位）。5-3/5-4 不含漏斗，字幕与画面一致。

## ch5 §三.4（5-4 字幕说审核中、徽章却 REJECTED，返工第25趟 2026-10-12）
问题（review1 §三.4）：5-4 字幕「Back under review — no need to resubmit the whole application.」，但旧实现用 `setInterval` 把 `.badge-rejected` 的文字改成「Under review」并改色 = **前端伪造**，画面从未真变审核中。review1 §三.4 要「在 §0.3/§0.4 范围内给 pt-03 真上传一份 SPECIMEN 更正版成绩单，等状态真变成审核中再高亮，录完 scoped 复位」。
改法（真态化·零改产品代码）：靠产品自己的 0104 supersede 逻辑——给 pt-03 真·新建一行更正版 transcript（`states/st-pt03-reupload.sql`：version2、uploaded_at 更晚、无新裁决）→ `get_partner_student_doc_statuses` 取代旧 rejected → 详情弹窗 `slot.status` 变 `reviewing`。shot 5-4 去伪造、改 `hl=.badge-reviewing,.reviewer-row-pending`、`expect=[.badge-reviewing]`、`forbid=[.badge-rejected]`。字幕四语本就描述"回到审核中"、与真态一致，不改字幕不改配音。复位 `st-pt03-reupload-reset-cleanup.sql` 回退态，verify 17/17 往返守住。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（登录态探针 `_probe-pt03-review.mjs` 从真态 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 5-4 | Back under review — no need to resubmit the whole application. | `.badge-reviewing`（transcript 槽徽章）＝ `status.reviewing` 态；材料矩阵 `.reviewer-row-pending`「⏳ ⚙ System · Awaiting initial review」；同帧 `.badge-rejected=0`、无「Modification requested」 | 是（更正件已上传→成绩单真·回到审核中，待初审；非整份重交） |

- 实证：置态后探针读到 `badge_reviewing=1 / badge_rejected=0 / row_rejected=0 / row_pending=1 / modRequested=false`；复位后 verify 17/17（0 FAIL，#10 退回态恢复）。
- **帧捕获待 ch5 定版重录**：5-2 需退回态、5-4 需审核中态，单 rec pass 不可兼得（置态后 5-2 的 `.reviewer-row-rejected` 消失）；故 5-4 帧捕获随 ch5 全章定版重录（缺陷2 裁后）按两态录制做，同 trip21 对 7-1「先落字幕/机制、再录」的先例。本趟落「证真态机制 + 改 shot 定义」，DB 全程只读往返、收工 clean。

## 开场快剪 OP-2（review1 §五，返工第26趟 2026-10-12）
问题（review1 §五）：开场四条重点卡（OP-2..5）各约 9~16s 全是静止卡面，合计约 50s；速览（招募片）也以这四张卡开头。中介多在手机上从社媒点开，开头长时间静止易被划走。review1 §五 令「现在就做快剪」：每张重点卡总时长不变（=配音+0.5s）、配音不动；先满屏卡面约 2.5s，再切到对应章节真实画面（静音、配音续），画面叠一条重点标题条，直到本卡结束；横竖各用对应画幅素材；四条重点文字一字不改。
本趟范围：**只有 OP-2 不受缺陷2 阻塞**——其素材是第6章 6-1/6-2 的两份盲 offer（ch6 已在 trip21/22 返工完、beta 链接已遮蔽）。OP-3/4/5 的素材 3-8/7-0/7-1 含工作台/漏斗，仍受缺陷2 阻塞，本趟保持静止卡面，待缺陷2 NEEDS_OWNER_DECISION 裁后接做。
实现（`gp1-finish.mjs` + `gp1-overlays.mjs`，零改产品代码/迁移）：新增 `keypointStrip` 叠层（重点标题条＝紫带+橙编号圈+标题，置于底部字幕带位置、取代章节字幕）；`buildQuickCut` 对 OP-2 产出 card(2.5s)+b-roll（取 ch6 原始帧 `out/<lang>-<orient>-ch6/frames`、页面定位同 prod-ch、静音、底部叠标题条）+ 全程配音；卡总时长不变（EN 10.4s）。

| 镜 | 字幕原文（配音，不改） | 快剪后画面（b-roll 中帧 DOM） | 同一件事？ |
|----|----------|---------------------|-----------|
| OP-2 前 2.5s | One submission, many universities ／ Submit a student once and the same file enters the candidate pools of many Chinese universities at the same time. Offers arrive in parallel… | 重点①卡满屏（紫底橙圈 1 + 标题 + 正文） | 是 |
| OP-2 2.5s~尾 | （同一句配音续） | ch6 真实画面：学生 Hussain Bilal 详情 ADMISSION OFFERS 列两份盲 offer（SCH-1AD6C8 / SCH-8E561C，均 UNIVERSITY · PENDING DECISION、无校名），底部叠「① One submission, many universities」 | 是（"一次提交→多校同审"↔同一学生拿到两所大学盲 offer） |

- 逐张亲眼复验（EN land+port b-roll 中帧 + 尾帧）：两份盲 offer、无校名（双盲守住）、无 beta/内测/test 控件、演示生 Hussain Bilal 无真 PII、标题条文字＝ EN OP-2 卡标题/ED-1 回顾串一字一致。专业名 "MSc Computer Science" 为产品动态串（D-18-4 已记账）。
- OP-2 卡总时长 10.4s 不变 → 全片 land 427.9s / port 428.1s（见本趟 DECISIONS/PROGRESS）。

## ch2 §三.1 / §三.2（工作台漏斗 + 卡状态徽章，返工第28趟 2026-10-12 · v185 上线后定版重录）
前置：缺陷2（工作台录取漏斗/人均 offer 对云端学生全 0）已由中介端 v185 修好并于 2026-10-12 21:38 上线（RULING-20261012d/e）。本趟把录制底座 `rec.mjs` 从 v184 切到线上同版 v185，并对 ch2 工作台章定版重录（四语横竖）。另加录制底座 offCamera 阻塞等待：`_getPartnerStats().totalOffers≥5 且 _p130_STATS gate_open≥6`，确保含工作台的章背景漏斗＝线上真值、卡状态「匹配中」标签已载（否则录早了漏斗定格 9/0/0/0、卡标签定格「已提交·等待审核」）。

- **§三.1（2-2）**：原字幕「Here is your referral quota: used and remaining.」。只读实证（`_probe-ch2-dom.mjs`）：工作台**没有任何「名额已用/剩余」显示**（全工作台仅 ch8 的「Quota raise pending: 10 → 30」横幅提到 quota）。按 review1 §三.1「产品没有这个显示，就把字幕最小改成画面真有的内容」——改为高亮并描述屏上真有的**录取漏斗**（也正是 v185 修好的那块）。
- **§三.2（2-4）**：原字幕列五档「Under review, ready for offers, offer in progress, accepted, enrolled」，原 hl 选 `.partner-student-status-approved`。实证：该 class **永不存在**——卡状态 class＝`partner-student-status-${s.status}`，而 `s.status=r.stage||'pending'`、`students.stage` 列全库恒 NULL，故 9 张卡 class 恒 `-pending`；真正的「材料已通过·匹配中」是 `_p131T('matching')` **覆盖标签**（当 `_p130_STATS[sid].gate_open` 为真时显示，演示数据 6 张 gate_open）。屏上真有的两档＝3 张「Submitted · awaiting platform review」+ 6 张「Documents approved · matching」。按 review1 §三.2「做不到依次框五档就把字幕最小改成画面真有的阶段」——hl 改为按真标签文本逐语言高亮（`text=Documents approved · matching`），字幕改述该真档。

| 镜 | 字幕原文（新/未改） | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 2-1 | Your Partner Hub shows every student you referred, in one place. | 工作台整屏：Partner Hub / Demo Agency / 统计面板 + 9 张推荐生卡（整屏 integral，无单点高亮） | 是 |
| 2-2 | Your referral funnel: submitted, letter issued, paid, enrolled. | `.partner-stats-funnel`：SUBMITTED **9** → 33% → LETTER ISSUED **3** → 67% → PAID **2** → 50% → ENROLLED **1**（下方「5 total offers received · avg 0.6 per student」） | 是（字幕四段＝屏上漏斗四段，v185 真值） |
| 2-3 | Each card carries the student's current stage. | `.partner-students-count`「9 students」（My referred students 区标题右侧计数药丸） | 是（指向推荐生列表） |
| 2-4 | Each card shows its stage — approved and matching with schools. | `.partner-student-status`（Mbarga Junior 卡）「**Documents approved · matching**」；辅行「✓ Core documents approved · awaiting school matches」 | 是（"approved and matching"↔屏上同文字标签；6 张卡同档） |
| 2-5 | Notifications tell you the moment a university acts. | `#stuNotifBell` 通知铃（角标 55）→ `openNotif` 开 `#stuNotifList`（≥4 条通知） | 是 |

- 时长：land 27.66s / port 27.66s。8 片（四语横竖）全 res OK + audio yes。全片 DOM 扫描 **no @gmail**。
- 逐张亲眼复验（EN land 联络表 + 2-2/2-4 原始帧）：2-2 漏斗 9/3/2/1 无负数无全 0；2-4 框住「Documents approved · matching」真标签；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）；¥0 TOTAL PAYMENTS PROCESSED 保留（§一.3）；演示生 Mbarga Junior / Islam Rahim 无真 PII；无 beta/内测/test 控件。
- **记入 SUMMARY「留给业主的产品问题」**：①中介端工作台无「名额已用/剩余」显示（故 2-2 改述漏斗）；②卡状态徽章颜色恒 pending 蓝（`students.stage` 列恒 NULL），即便标签已是「材料已通过·匹配中」（gate_open 覆盖），色与标签语义不一致——属产品层 stage 列未回填的历史问题，非本片可改。

## ch1 §一（1-8 工作台负数金额，返工第29趟 2026-10-12 · v185 定版重录）
前置：ch1 第 1～7 镜＝注册/入驻 UI（产品自身 gateShowRegister/renderPendingView 渲染，client-side 驱动、零写库），review1 未标 ch1 任何字幕缺陷；唯 1-8「切到 guide_partner：APPROVED 徽章 + 工作台」背景里有 review1 §一 点名的工作台数字问题——v184 缓存帧的 hero 显 `TOTAL PAYMENTS PROCESSED ¥-9,000`（负数，缺陷1）。本趟在 v185 底座（含 trip28 offCamera 等待）对 ch1 整章四语横竖定版重录，1-8 背景自动显修好后的 `¥0`。字幕一字未改。

| 镜 | 字幕原文（未改） | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 1-1 | Open the partner portal. Tap "New agency? Register". | 登录门整屏 `.gate-card`＋`.lang-toggle`（Partner portal 登录卡，含「New agency? Register」链接）（整屏 integral，无单点高亮） | 是 |
| 1-3 | Enter the invite code from the guide page, then your email and a password. | `#regInvite` 邀请码输入框（注册盒 `#gateRegisterBox` 内，邀请码明文已 forbid 打码） | 是 |
| 1-5 | Tell us about your agency: name, country, contact person, students per year. | `#onbOrgNameEn,#onbCountry`（入驻资质表单：机构名/国家/联系人/年送生量字段区） | 是 |
| 1-6 | Upload the owner's ID and your business licence. | `label[for="onbFile_passport"],.onb-doc-card`（上传区：负责人证件 + 机构资质 SPECIMEN 样件卡） | 是 |
| 1-7 | Submit. Our team reviews new agencies within two working days. | `.pill-amber,.card-big`（提交后「审核中」状态页，琥珀药丸 pending 卡） | 是 |
| 1-8 | Once approved, your Partner Hub is open. | `.hero`（Demo Agency · Partner approved 徽章，橙框）；同帧工作台 hero 统计＝`STUDENTS SUBMITTED 9` / `TOTAL PAYMENTS PROCESSED ¥0`（**非 v184 的 ¥-9,000**） | 是 |

- 时长：land 49.43s / port 49.44s（8 镜）。8 片（四语横竖）全 res OK + audio yes。全片 DOM 扫描 **no @gmail**。
- 逐张亲眼复验（EN land 联络表 + 1-8 原始帧 46s）：1-8 hero `TOTAL PAYMENTS PROCESSED ¥0`（负数已消失，review1 §一 销账）、`STUDENTS SUBMITTED 9`、APPROVED 徽章橙框；无负数、无 beta/内测/test 控件；注册演示号画面 no @gmail、邀请码打码、SPECIMEN 样件、无真护照号/电话；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。
- 记账：1-8 同帧有「Quota raise pending: 10 → 30」横幅＝基线真实待审提额请求（verify #13），在 ch1 叙事中属真实背景态、不矛盾（该横幅与 ch8 叙事的矛盾由 §三.7 ch8 返工时 scoped 撤除后再录处理，与 ch1 无关）。
