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

### ch9 v185 定版重录（返工第34趟 2026-10-13，review1 §一 背景）
trip23 的字幕/高亮（§三.6）照旧正确，本趟只换**录制底座 v184→v185**（漏斗修复已上线，RULING-e）重录 ch9 4 镜，使背景数字落定版。亲验 en-land 9-1/9-2 原始帧 + en-land/port 联络表：增值服务区标题行右「Invested on this student: **¥0**」（缺陷1 销账，无负数）；Audit ¥1,500 / Human-assisted ¥600 / Exposure boost from ¥4,500 三行与字幕逐镜对账仍「是」。4 镜 box 全 resolve、无 MISS、全片 no @gmail。时长 land **22.73s** / port **22.79s**（v185 重录值，替代 trip23 的 22.82/22.78）。开工+收工 verify 17/17 PASS（ch9 读-only 零写库）。
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
- ⚠ 上表 2-3 / 2-4 两行**已被第 38 趟（第三轮返工 RULING-20261013b §三.1）取代**——见下节。

## ch2 §三.1（第三轮返工 · RULING-20261013b，第38趟 2026-10-13 · v185 定版重录）
RULING-20261013b §三.1 复核第二版查出：**2-3** 原来框的是 `.partner-students-count`「9 students」**计数药丸**，不是卡片；**2-4** 原来只框一张卡的徽章文字，没做到 review1 §三.2 首选的「依次框各张卡」，而每张卡的**状态行 `.partner-student-issue`** 其实真实显示不同阶段。本趟按 §三.1 重做（四语横竖全部用 v185 重录；另按 §三.7 录前 `st-ch8-quota-off`、录后 `st-ch8-quota-restore` 去掉工作台顶部「Quota raise pending」横幅，收工 verify 17/17 回基线）：
- **2-3**：高亮改框列表**第一张学生卡整卡**（`.partner-students-list .partner-student-card:nth-of-type(1)`＝Serikova Aizhan），字幕不改。
- **2-4**：改为**依次框 5 张处在不同真实阶段的卡的状态行**（`.partner-student-card:nth-of-type(N) .partner-student-issue`，N=1/4/5/6/8；录制层 rec.mjs 新增 `hlseq` 多段高亮，每段 hold 1.3s、环不熄仅移动，逐段占其时段 ~76% ≥70%）。字幕按屏上依次出现的阶段、用产品说法写、**不加引号**（避 §四.4 逐字比对），四语重配音。不框徽章。
- 实证底座 `_probe-ch2-nth.mjs`：四语 land 下 5 个 nth 状态行均 resolve+可见；8 片 timeline 2-4 `seq` 全 `YYYYY`（5/5 resolved）。

| 镜 | 字幕原文（新/未改） | 高亮区 DOM 实际文字（从最终成片实帧亲验） | 同一件事？ |
|----|----------|---------------------|-----------|
| 2-3 | Each card carries the student's current stage.（未改） | 整框第一张学生卡 Serikova Aizhan（含姓名/徽章「Submitted · awaiting platform review」/状态行/增值服务区） | 是（框的是卡片本身，不再是计数药丸） |
| 2-4 seg1 | （同下整句）under review … | nth1 Serikova Aizhan 状态行「⏳ All documents currently under review」 | 是 |
| 2-4 seg2 | … approved and matching … | nth4 Mbarga Junior 状态行「✓ Core documents approved · awaiting school matches」 | 是 |
| 2-4 seg3 | … a new offer … | nth5 Hussain Bilal 状态行「🆕 New offer from A university · name revealed after admission · MSc Computer Science — awaiting student decision · yesterday」 | 是（双盲守住：A university·录取后公布校名） |
| 2-4 seg4 | … a letter issued … | nth6 Karimova Nilufar 状态行「💰 Letter issued by A university · … · student must pay **¥3,000** in 30 days · 30d left」（¥3,000 为**正数**） | 是 |
| 2-4 seg5 | … admission complete. | nth8 Volkov Dmitri 状态行「Admission complete · MSc Mechanical Engineering · 1w ago」 | 是 |

2-4 整句字幕（EN）：*Each student card carries its own status line, showing exactly where that student stands — under review, approved and matching, a new offer, a letter issued, admission complete.*

- 时长（最终成片，秒）：land en 35.8 / zh 38.0 / ru 37.2 / fr 36.0；port 同量级。2-4 窗 13.8s（5 段），配音 en 10.9/zh 14.0/ru 13.8/fr 11.3s，静默尾≤2.9s（§四 容许≤3s）。8 片全 res OK + audio yes，录制全 **no @gmail**。
- 亲眼逐帧复验（EN land seg1/2/3/4/5 + 2-1 + 2-3 全帧；ZH land seg3 全帧）：环框在正确状态行；**2-1 工作台顶部已无「Quota raise pending」横幅**（§三.7 去横幅生效），TOTAL PAYMENTS PROCESSED **¥0** 无负数；增值服务 ¥1,500/¥600/¥4,500、letter ¥3,000 均正数；双盲守住（A university / 某院校·录取后公布校名）；页头平台 WhatsApp/Email（Service@maxhouses.net）不遮（D-14-3/D-15-1）；演示机构 Demo Agency 无真 PII；**无 beta/placeholder/test/负数**。
- RU/FR 的 2-4 状态行里「New offer from / Letter issued by / student must pay ¥3,000 in 30 days / awaiting student decision / yesterday」等片段为产品 i18n 英文回退（D-18-4：俄法界面英文回退照录不补），非本片引入。字幕本身为对应语言全译（captions-v1.json）。
- 联络表（本节证据）：`~/mh-jobs/shots/GP1/<lang>/ch2-contact-{land,port}-<lang>.png`（逐镜中点）+ `ch2-2-4-segments-{land,port}-<lang>.png`（2-4 五段逐段）。

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

## ch3 §三.8（节奏 3-1/3-8）+ §四（草稿残留）+ §一（工作台 v185，返工第30趟 2026-10-12 · 定版重录）
前置：ch3 是 state 章（3-8 真 submit→真 app_no，耗配额 9→10、建 guide-pt-ch3 生）。本趟在 v185 底座对 ch3 整章四语横竖定版重录，处理 review1 三处：
- **§三.8 节奏（录制层实现 review1「后期剪掉等待的那几秒」）**：给 rec.mjs 加 `preOff` 开关——把「导航/加载/真提交」放镜外（offCamera）跑，不计入字幕窗口帧，等结果落定后才开录，保证字幕说的东西在窗口里占 ~100%。
  - **3-1（旧病：点完按钮后镜尾 openWizard 切走，高亮环落在向导空白处）**：去掉 3-1 的 `special:openWizard`，把「开向导」移到 3-2 的 offCamera `pre`。→ 3-1 全窗口停在高亮的「Submit New Student Referral」按钮（亲验 3-1 尾帧 t≈5s 仍框按钮，无空白环）；3-2 开录即向导 step1、高亮 Semester（亲验 3-2 首帧已是向导、中帧框 Semester 选择框）。
  - **3-8（旧病「app_no 落在段尾」，trip12 已记）**：3-8 的真 submit + 等 app_no 全放 offCamera，开录时 app_no 已渲染。亲验 3-8 首帧（窗口 t0）即显 `MH-xxxxxx`（en-land 本趟 MH-EQ3SS3 / ru-land MH-G35SC4，每次真 submit 新码，录后 scoped 删）、中帧高亮环框住 app_no。app_no 全窗口在画面。
- **§四（草稿残留）**：本趟每录一变体前后各跑 `st-ch3-cleanup.sql`（删 guide-pt-ch3 + 把 pt-01 草稿还原成基线 Ayesha Malik/step2/_demo=pt-01）；真 submit 后立即 `st-ch3-mark-test.sql` 标 is_test（安全网）。收工 verify **#17 PASS**（pt-01 draft==基线，无 ch3 向导覆盖残留）。
- **§一（工作台 v185）**：3-9 列表背景＝v185 真值，推荐生卡「Invested on this student: ¥0」（无负数，缺陷1 销账）。

| 镜 | 字幕原文（未改） | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 3-1 | Tap "Submit New Student Referral". | `.partner-add-student-btn`「+ Submit New Student Referral」（工作台底，全窗口高亮） | 是（§三.8 修后全程框按钮） |
| 3-2 | Step one: the plan — intake term, funding, degree level and major. | 向导 step1：Intended program type 六卡（Short-term/Chinese Language/Associate/Bachelor's/Master's/Doctorate）+ 高亮 `#wzSemStart`「Semester *」选择框 | 是 |
| 3-3 | Step two: the student's profile, exactly as in the passport. | 向导 step2 档案：高亮「Date of birth」行（同屏 Passport no. 等；演示 Demo Aisha / 护照 DE1234567 样号） | 是 |
| 3-4 | Step three: upload the documents. | 向导 step3 `.mat-grid`：高亮 `#wz_card_passport` 上传槽（23 槽矩阵） | 是 |
| 3-5 | The AI pre-check flags problems before a university ever sees the file. | `#wz_card_transcript` 内产品自身琥珀条「Pre-check reminders · transcript.jpg · The transcript scan is blurry in the lower half — please upload a clearer copy.」+ sticky「⚠ Documents with AI notes: 1」（RULING §1.2 产品渲染，四语本地化） | 是 |
| 3-6 | The passport name check catches spelling differences right away. | `#wz_card_passport` 内护照姓名核对琥珀条（名字不一致提醒「does not match」） | 是 |
| 3-7 | Leave any time — your draft is saved in the cloud. | `#pwzExitModal` 退出三选一弹窗，高亮「💾 Save draft & exit」 | 是 |
| 3-8 | Confirm and submit. The student gets an application number. | `.student-app-id-num`「YOUR APPLICATION ID · MH-EQ3SS3」（Demo Aisha · #10 · Pakistan · bachelor · 2026-fall · DOCUMENTS UNDER REVIEW；§三.8 修后全窗口在画面） | 是 |
| 3-9 | From now on this student is bound to you. | `.partner-student-status-pending`「Submitted · awaiting platform review」（推荐生卡，渲染全/有脸的基线生卡；同卡「Invested on this student: ¥0」无负数） | 是 |

- 时长：land 60.23s / port 60.25s（9 镜）。8 片（四语横竖）全 res OK + audio yes。全片 DOM 扫描 **no @gmail**；8 录屏 9 镜 hl 全 resolve、零 MISS。
- 逐张亲眼复验（EN land 联络表 + 3-1尾/3-2首中/3-8首中/3-9中 原始帧）：3-1 全程框按钮无空白环、3-2 开录即向导、3-8 app_no 全窗口在画面（§三.8 达标）；3-9「Invested ¥0」无负数（§一.3/缺陷1 销账）；注册演示生 Demo Aisha 无真 PII、护照 DE1234567 样号、邮箱掩码 agency.demo@example.com；无 beta/内测/test 控件；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。
- 记账：真 submit（submit_referral）仅 insert students、不发邮件/站内通知（trip20 实证）；每变体真码不同（录后 scoped 删）；收工 verify 17/17 PASS、draft 回基线。

## ch7 §二.3（7-1 两段高亮）+ §三.5（7-4 字幕对账）+ §一（工作台 v185，返工第31趟 2026-10-12 · 定版重录）
前置：ch7 是 state 章（7-0 真付 ¥0 写 letter_paid_at）。v185 底座四语横竖定版重录。处理 review1 三处：
- **§二.3（7-1）**：高亮改两段（rec.mjs 新增 `hl2`）——先框真揭晓校名条 `.admission-id-tag--unlocked`，再框下载钮 `.admission-doc-btn-letter`。7-1 字幕/配音 trip21 已改，本趟只改高亮。
- **§三.5（7-4）**：病根＝卡徽章 `s.status` 读废弃列 students.stage（恒 NULL，与漏斗同根）→ 恒 pending、gate_open 覆盖成蓝「Documents approved · matching」，产品从不在卡徽章真显 enrolled（已知产品问题，留 SUMMARY）。但卡**状态行**（`.partner-student-issue`，源 cloudTl.completed）稳定真显「⏳ Admission complete」。→ 走 review1 §三.5 兜底，字幕由「Enrolled. Done.」改**与状态行逐字一致**的「Admission complete.」。
- **§一**：7-4 卡「Invested on this student: ¥0」无负数（v185）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 7-0 | Enter the coupon code — ¥0. No agency fee, no application fee. | `.payment-amount-value`「¥0.00」（UNLOCK FEE — TOTAL DUE；下方 ¥3,000.00 删除线 · MAXHOUSE −¥3,000.00） | 是 |
| 7-1 | The university is revealed — download the admission letter here. | 两段：①`.admission-id-tag--unlocked`「🔓 Demo University · 演示大学 · 📍 Wuhan / 武汉 · SCH-1AD6C8」(揭晓校名条) ②`.admission-doc-btn-letter`「Admission Letter · Official PDF · 录取通知书 ⬇」(下载钮) | 是（§二.3 两段先校名后下载） |
| 7-2 | The JW202 follows the same way. | `.admission-doc-btn-jw`「JW202 Form · 签证申请用 · For visa application ⬇」 | 是 |
| 7-3 | The platform files the student into the university's own enrolment system for you. | `.offer-progress`「✓ Accept offer · ✓ School issues admission letter · ✓ School issues JW202 · ✓ Enrolled」(建档进度条含 ✓入学) | 是 |
| 7-4 | Admission complete. | `#gp1-74-card` 内状态行「⏳ Admission complete · MSc Mechanical Engineering · 1w ago」（整卡高亮；卡「Invested on this student: ¥0」无负数） | 是（字幕=状态行逐字） |

- 时长：land 44.66s / port 43.29s（5 镜）。8 片（四语横竖）全 res OK + audio yes。全片 DOM 扫描 **no @gmail**；8 录屏 5 镜 hl 全 resolve（7-1 含 hl2），零 MISS。
- 逐张亲眼复验（EN land 全 5 镜原始帧）：7-0 ¥0.00 橙框 + ¥3,000 删除线 + MAXHOUSE（邮箱掩码 agency.demo@example.com、app id MH-NEPTRN）；7-1 phase1 框校名条、phase2 框下载钮（§二.3 达标）；7-4 状态行「⏳ Admission complete」= 字幕逐字、「Invested ¥0」无负数（§一/缺陷1 销账）；无 beta/内测/test 控件；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。
- 记账（留业主·已知产品问题）：7-4 卡**徽章**「Documents approved · matching」（蓝 pending）对已入学生恒显矛盾——根因 `s.status = r.stage||'pending'`（L7311）读废弃列 students.stage（恒 NULL），非本趟引入，未改产品码（§三.5 兜底），留 SUMMARY。收工 verify 17/17 PASS，baseline 守住。

## ch8 §三.7（横幅：录前 scoped 撤待审提额）+ §一（工作台 v185，返工第32趟 2026-10-13 · 定版重录）
前置：ch8 是 state 章。基线有一张 pending quota_request（verify #13）→ 工作台顶恒显 amber「Quota raise pending: 10→30」，与 8-2/8-3「才去申请」叙事矛盾（review1 §三.7）。
- **§三.7 做法**：录前 scoped 把该行 `status='approved'`（`decided_at` 保持 NULL）→ 产品 `_qrApplyBanner` 判非 pending 且最新行未裁决 → 横幅清空（8-1/8-2/8-3 无横幅）；`partners.referral_quota` 不动（仍 10）。录后 restore 还原 pending，verify #13 回基线。
- **8-1 字幕随 §11 改**：产品**无常驻名额表**（review1 §三.1 已证），去横幅后 8-1 高亮的 `.partner-stats-hero-card` 只显「STUDENTS SUBMITTED 9」→ 字幕由「Your quota is almost used up.」改述屏真有的数「You've submitted nine students.」（四语重配音）；「名额已满」语境由 8-2 弹窗标题「Referral quota reached · used 9/10」承接。
- **8-4 改前端示意为产品自身渲染**：旧 8-4 改写 pending 卡文本造绿条（去横幅后无此卡）→ 改调产品自身 `_qrApplyBanner()` 喂样例已批数据（§8 先例「用产品自己的渲染函数喂样例」），渲染真·绿条；横幅四语由产品 LL 本地化（zh 真中文、en/ru/fr 走产品 LL 的 EN 回退＝D-18-4 记录的真产品行为）。
- **§一**：8-1/8-4 工作台 hero「TOTAL PAYMENTS PROCESSED ¥0」无负数（缺陷1 销账）；hero 卡**不显名额数**，故 8-4「now 30 seats」横幅与屏上无任何名额数字冲突。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 8-1 | You've submitted nine students. | `.partner-stats-hero-card`「STUDENTS SUBMITTED · 9」（**无** pending 横幅；同屏 TOTAL PAYMENTS PROCESSED ¥0 无负数、漏斗 9→3→2→1·5 offer·人均 0.6） | 是 |
| 8-2 | Request a raise right here. | `.modal-bg.show .modal-body`「Referral quota reached · You have used 9/10 seats. Request a raise below — it takes effect once approved.」+ 目标名额/理由表单 | 是 |
| 8-3 | Tell us how many more students you expect; we review it within two working days. | `.modal-bg.show .btn-primary`「Submit request」（表单已填目标 30 + 理由；不真提交·零写库） | 是 |
| 8-4 | Approved — your quota grows with your results. | `#qrPendingBanner`「✓ Quota raise approved: your quota is now 30 seats.」（产品自身 `_qrApplyBanner` 喂样例渲染·§8 先例·绿条） | 是 |

- 时长：land 30.32s / port 30.07s（4 镜）。8 片（四语横竖）全 res OK + audio yes。全片 DOM 扫描 **no @gmail**；8 录屏 4 镜 hl 全 resolve、零 MISS。
- 逐张亲眼复验（EN land 8-1/8-4 原始帧 + 四语 land 联络表 + en-port 联络表）：8-1 **无 pending 横幅**、框住 STUDENTS SUBMITTED 9（§三.7 达标）；8-4 产品绿条「approved: now 30 seats」（非伪造 HTML）；全程 ¥0 无负数、Demo Agency 无真 PII、邮箱掩码、无 beta/内测/test 控件、页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。
- 记账：8-3 不真提交（零写库）；录前 st-ch8-quota-off（status→approved/decided_at NULL）、录后 st-ch8-quota-restore（→pending）；开工+收工 verify 17/17 PASS，baseline 守住（scoped 复位，无全量 rebuild）。

## ch5 定版重录（两态·v185，返工第33趟 2026-10-13 · 落 §三.3 5-2 + §三.4 5-4 真态 + §三.8 5-1 + §一）
前置：ch5＝材料退回章（guide-pt-03 Islam Rahim）。此前 trip24 只 banked 5-2 新字幕（过渡版）、trip25 只落 5-4 真态机制与置态/复位脚本（帧捕获明文延后至 ch5 定版重录）。本趟缺陷2 已 v185 修好上线（RULING-20261012d/e），对已修数据**两态定版重录全章**：5-1/5-2/5-3 在退回基线录、5-4 在 apply `st-pt03-reupload` 后单录，由 `prod-ch --tags` 按镜序拼成一章（rec 全程只读，DB 置态/复位走 db-run.sh，录后 reset 回退态、verify 17/17 守住）。工具：rec.mjs 加 `--only`/`--tagsuffix`、prod-ch.mjs 加多 tag 拼章、gp1-finish.mjs chapterShotDurs 合并 companion `b` out 目录。
- **§三.4（5-4 真态·零改产品码）**：靠产品自己的 0104 supersede——pt-03 真·新建一行更正版 transcript（uploaded_at 更晚、无新裁决）→ `get_partner_student_doc_statuses` 不再返回 reject → 详情弹窗 transcript 槽 `slot.status` 真变 `reviewing`、徽章真变 `.badge-reviewing`、矩阵「Awaiting initial review」。非前端伪造（旧 setInterval 改字已删）。
- **§一**：5-1 工作台背景 v185，`Invested on this student: ¥0` 无负数（缺陷1 销账）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 5-1 | A document was returned. Open the student. | `#__ch5card`（Islam Rahim 学生卡）「Submitted · awaiting platform review」+ 卡「Invested on this student: ¥0」（无负数） | 是（该生有材料被退回→打开其详情） |
| 5-2 | The transcript was returned — the Maxhouse review team requested a change. | `.reviewer-row-rejected`「⚠ Maxhouse review team · Modification requested」（材料「Academic transcript · REJECTED」） | 是 |
| 5-3 | Upload the corrected file. | `.replace-box-rej`「Re-upload a new version」换版框 + 暂存样件「SPECIMEN-e… · 180.0 KB」（前端暂存·零写库） | 是 |
| 5-4 | Back under review — no need to resubmit the whole application. | `#studentDetailModal .badge-reviewing`「REVIEWING」+「Academic transcript · 2 files uploaded」+ 矩阵「⚙ System · Awaiting initial review」（同帧无 `.badge-rejected`、无「Modification requested」） | 是（更正件已上传→成绩单真·回审核中，待初审） |
- 时长：land 36.87s / port 36.83s（4 镜）。8 片（四语横竖）全 res OK + audio yes；8 录屏 4 镜 hl 全 resolve、零 MISS；全片 DOM 扫描 **no @gmail**。
- 逐张亲眼复验（EN land 4 镜原始帧 + 四语 land/port 联络表）：5-1「Invested ¥0」无负数（§一/缺陷1 销账）；5-2 框住「Modification requested」退回行（§三.3 达标）；5-4 产品**真·审核中**徽章 REVIEWING + 「Awaiting initial review」（非前端伪造，§三.4 达标）；演示生 Islam Rahim 无真 PII；无 beta/内测/test 控件；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。
- 记账：录前 apply `st-pt03-reupload`（新建 transcript v2）、录后 `st-pt03-reupload-reset-cleanup` 删 v2 回退态；开工+收工 verify **17/17 PASS 0 FAIL**，baseline 守住（scoped 复位，无全量 rebuild）。ch5 v1 在 `_v1/` 留底、dist 覆盖为定版 v2。全片不重拼（待全部工作台章完后统一拼）。

## ch10 §一（设置章·读-only·v185 工作台背景定版重录，返工第35趟 2026-10-13）
> ⚠ **本节（含下表 10-2/10-3/10-4 三行）已被第 48 趟（第三轮返工 RULING-20261013b §三.10）取代**——第二版（trip35）虽已换 v185 底座重录，但第三轮裁决要求十章全部用 v185 定版重录一次、不沿用任何旧录像，并补 §三.7 去提额横幅 + §三.9 俄法章节条实帧复验；见文末「ch10 §三.10」节。
ch10＝设置章（账户/语言/退出），3 镜 10-2/10-3/10-4，全程在已登录 hub 上高亮设置菜单项·读-only·零写库·无弹窗置态。review1 未标 ch10 任何字幕缺陷→字幕/高亮一字未动；review1 §一列 ch10 为「背景含工作台数字」章，v184 缓存帧 hero 有负数/漏斗（缺陷1/2），v185 漏斗修复上线后（RULING-e）须 v185 重录使背景数字落定版。本趟纯换录制底座 v184→v185 重录 ch10 3 镜 × 四语 × 横竖＝8 片覆盖 dist。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 10-2 | Account settings live under the gear. | `#settingsMenu [onclick*="openAccountSettings"]`「⚙ Account settings」（设置下拉 ACCOUNT 区·齿轮图标项） | 是 |
| 10-3 | Four interface languages. | `.lang-switcher`「EN · 中 · РУ · FR」四语切换按钮组（下拉 LANGUAGE 区） | 是 |
| 10-4 | Sign out when you share a computer. | `[onclick*="settingsSignOut"]`「⟶ Sign out」（设置下拉底部红色退出项） | 是 |

- 时长：land 16.31s / port 16.32s（3 镜）。8 片（四语横竖）全 res OK + audio yes；8 录屏 3 镜 hl 全 resolve、零 MISS；全片 DOM 扫描 **no @gmail**。
- 逐张亲眼复验（EN land 10-2 原始帧 f00022 + 四语 land 联络表）：背景 hero「TOTAL PAYMENTS PROCESSED ¥0」**无负数**（缺陷1 销账，§一达标）、「STUDENTS SUBMITTED 9」；下拉三项高亮逐镜对账「是」；演示生/机构 Demo Agency 无真 PII、邮箱掩码 `agency.demo@example.c…`（no @gmail）、Partner Code PA-E62FC6FF；无 beta/内测/test 控件；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。
- 记账：ch10 读-only，开工+收工 verify **17/17 PASS 0 FAIL**，baseline 全程守住（零置态/零写库）。ch10 v1 早在 `_v1/` 留底、dist 覆盖为定版 v2。全片不重拼（待全部工作台章完后统一拼）。

## 开场快剪 OP-3 / OP-4 / OP-5（review1 §五，返工第36趟 2026-10-13 · 缺陷2 v185 上线后接做）
前置：trip26 已做 OP-2 快剪（素材 ch6 盲 offer，不受阻塞）；OP-3/4/5 的素材 3-8（真 app_no）/7-0（¥0 付款）/7-1（校名揭晓+下载）当时含工作台/漏斗、受缺陷2 阻塞。缺陷2 已随中介端 v185 修好并 2026-10-12 21:38 上线（RULING-e），ch3/ch7 亦于 trip30/31 v185 定版重录，素材就位→本趟接做 OP-3/4/5，仿 trip26 OP-2 做法。
要求（review1 §五，同 OP-2）：每张重点卡总时长不变（=配音+0.5s）、配音一字不动；先满屏卡面 2.5s，再切对应章节真实画面（静音、配音续），底部叠重点标题条，直到本卡结束；横竖各用对应画幅素材；四条重点文字一字不改。
实现（`gp1-finish.mjs`，零改产品代码/迁移，复用 trip26 `keypointStrip`/`buildQuickCut`）：`OP_BROLL` 加 OP-3/4/5 三条，按**镜号**从该章 timeline 取起止（逐语言/画幅各异，非硬编码时刻）。
- **OP-3**（ch3 3-8）：窗口 [3-8.start, min(3-8.end, +brollDur)]，3-8 整镜＝提交成功页，动态播完后末帧定格 app_no。
- **OP-4**（ch7 7-0，`still:4.5`）：7-0 的 pre 在镜内跑（非 offCamera），ts0~3 开窗转场、ts~4 ¥0 发票落定、再点付款→成功页带「Paid (beta placeholder)」吐司（各语言付款时点不一·ru-port ts9 已处理中）。故 OP-4 **不取动态窗**（会漂入 beta 成功页），改**定格 ts≈4.5 的干净 ¥0 发票单帧**（¥0 全程在画面＝本重点「零平台费」），彻底避开 lead-in/处理中/beta 吐司。
- **OP-5**（ch7 7-1，`leadin:1.0`）：窗口 [7-1.start+1.0, min(7-1.end, +brollDur)]，跳过开窗转场 1s，落在录取详情（揭晓校名条 `.admission-id-tag--unlocked` + 下载通知书钮 `.admission-doc-btn-letter` 两段高亮），末帧定格在下载钮高亮。
- 均加 `tpad=clone` 把末帧克隆补满 brollDur 并强制 **30fps CFR**（定格窗短于 brollDur 时避免低帧率/VFR 致全片拼接 A/V 漂移）；实测四语 OP-3/4/5 帧数＝时长×30 整。

| 镜 | 字幕原文（配音，不改） | 快剪后画面（b-roll 帧 DOM） | 同一件事？ |
|----|----------|---------------------|-----------|
| OP-3 前 2.5s | Your student stays yours ／ Submitting binds the student to you… The platform never takes your student. | 重点②卡满屏（紫底橙圈 2 + 标题 + 正文） | 是 |
| OP-3 2.5s~尾 | （同句配音续） | ch3 3-8 真实画面：演示生 Demo Aisha 详情「YOUR APPLICATION ID **MH-EYJ5EE**」（橙框）· DOCUMENTS UNDER REVIEW · #10 Demo Aisha · Pakistan · bachelor · 2026-fall，底叠「② Your student stays yours」 | 是（"提交即绑定、学生归你"↔同一学生提交成功拿到专属申请编号） |
| OP-4 前 2.5s | Zero platform fees ／ There is no platform fee, no application fee… the service fee you agreed with the student is entirely yours. | 重点③卡满屏（紫底橙圈 3 + 标题 + 正文） | 是 |
| OP-4 2.5s~尾 | （同句配音续） | ch7 7-0 定格：付款单「UNLOCK FEE — TOTAL DUE **¥0.00**」· ¥3,000.00 · MAXHOUSE −¥3,000.00 · Applicant/Paid by `agency.demo@example.com` · MH-NEPTRN · SCH-1AD6C8，底叠「③ Zero platform fees」 | 是（"零平台费"↔优惠码后应付 ¥0 全程在画面） |
| OP-5 前 2.5s | Written by the university, delivered to you ／ The admission letter is written by the university… you download it and hand it to the student. | 重点④卡满屏（紫底橙圈 4 + 标题 + 正文） | 是 |
| OP-5 2.5s~尾 | （同句配音续） | ch7 7-1 真实画面：录取详情「Admission Letter Ready — JW202 coming soon」· 揭晓校名条 Demo University · 演示大学 · Wuhan/武汉 · SCH-1AD6C8（橙框）· 下载钮「Admission Letter Official PDF · 录取通知书」↓（橙框）· School revealed · contact details，底叠「④ Written by the university, delivered to you」 | 是（"校名揭晓·通知书直发给你下载"↔同一画面校名解锁+下载钮） |

- 逐张亲眼复验（EN land OP-3/4/5 card 帧 + b-roll 帧 + 尾帧；EN port OP-4 复验）：OP-3 真 app_no、OP-4 ¥0（无负数）、OP-5 校名揭晓+下载；全程**无 beta/内测/test 控件**（7-1 的 `.cloud-offer-unlock` beta 链接由录制层 HIDE_INIT 在原始帧即遮；OP-4 定格 ts4.5 避开 7-0 末尾「Paid (beta placeholder)」吐司）；演示生/机构无真 PII、邮箱掩码 `agency.demo@example.com`（no @gmail）；双盲守住（OP-5 校名揭晓＝付款解锁后合法态，非盲态泄校名）；标题条文字＝ EN OP-3/4/5 卡标题/ED-1 回顾串一字一致。
- 卡总时长不变（EN OP-3 15.6 / OP-4 9.1 / OP-5 14.5s，=配音+0.5），配音未动。OP-3/4/5 做完→全部工作台章+开场快剪返工完毕，本趟重拼四语横竖全片/速览（纳入全部 v185 定版章）。

## ch1 §三.10 + §三.7 + §三.9（第三轮返工 · RULING-20261013b，第39趟 2026-10-13 · v185 定版重录·不沿用旧录像）
RULING-20261013b §三.10 要求十章全部用 v185 重录、不再沿用任何旧录像；本趟对 ch1 整章四语横竖（8 片）用 v185 重新录制、合成、覆盖 dist。ch1 第 1～7 镜＝注册/入驻 UI（产品自身渲染·client-side·零写库），review1/本轮未标 ch1 任何字幕缺陷→**字幕/高亮一字未改**（字幕原文见上「ch1 §一」节表格）。本节落两处新处理：
- **§三.7（去提额横幅）**：1-8 露工作台顶部 hero，v185 基线有一张 pending quota_request（verify #13）→ 顶部恒显 amber「Quota raise pending: 10 → 30」。录前 `st-ch8-quota-off.sql`（quota_requests 单列 pending→approved、decided_at 保持 NULL→产品 `_qrApplyBanner` 清横幅）、录后 `st-ch8-quota-restore.sql` 还原 pending；收工 verify #13 回 pending、17/17 PASS。→ **本趟 1-8 已无横幅**（横版 en 原始帧 f00402 + 竖版 en 原始帧 f00438 亲验：header 与 hero 之间无 amber 横幅）。
  - ⚠ 上「ch1 §一（trip29）」节末「记账」行称「1-8 同帧有 Quota raise pending 横幅…在 ch1 叙事中属真实背景态、不矛盾」——**该行已被本节取代**：§三.10/§三.7 要求凡露工作台顶部的镜（含 1-8）一律去横幅，本趟已按此重录。
- **§三.9（俄法章节条左标签）**：en 章节条左标签仍「Partner Hub」（不在 §三.9 范围）。ru→「Центр партнёров」、fr→「Espace partenaires」、zh→「合作伙伴端」（gp1-overlays.mjs BAR_I18N，trip38 已改并 commit；本趟 ch1 重烧继承）。横版 ru/fr 成片实帧亲验章节条＝「Центр партнёров」/「Espace partenaires」。
- 1-8 hero 背景数字：`TOTAL PAYMENTS PROCESSED ¥0`（无负数，缺陷1 销账）、`STUDENTS SUBMITTED 9`、APPROVED/approved 徽章橙框。
- 时长（最终成片，秒）：land en 49.45 / zh 49.44 / ru 51.21 / fr 49.68；port en 49.45 / zh 49.49 / ru 51.26 / fr 49.59。8 片全 res OK + audio yes，录制全 **no @gmail**。8 镜 box 全 resolve。
- 亲眼逐帧复验：EN land 1-8 原始帧 f00402（hero 橙框·¥0·无横幅·STUDENTS 9）、EN port 1-8 原始帧 f00438（竖版同·无横幅·¥0）、RU land 章节条「Центр партнёров」、FR land 章节条「Espace partenaires」。全程无 beta/placeholder/test、¥0 无负数；注册段邀请码打码、SPECIMEN 样件、无真护照号/电话、演示机构 Demo Agency 无真 PII；页头平台 WhatsApp/Email（Service@maxhouses.net）不遮（D-14-3/D-15-1）。
- 联络表（本节证据）：`~/mh-jobs/shots/GP1/<lang>/ch1-contact-{land,port}-<lang>.png`（逐镜中点，四语全部用本趟最终成片重新生成）。

## ch3 §三.3 + §三.4 + §三.8 + §三.7 + §三.10（第三轮返工 · RULING-20261013b，第40趟 2026-10-13 · v185 定版重录·不沿用旧录像）
ch3＝提交第一个学生章（state 章：3-8 真 submit 建 guide-pt-ch3，录后 st-ch3-mark-test 安全标 + st-ch3-cleanup scoped 单删还原基线草稿，不跑全量 rebuild，D-12-2）。本趟四语横竖 8 片全部用 v185 重录，落 review2 的三处镜级缺陷 + §三.7 横幅：

- **§三.3（3-3 中俄法横竖：整段停在档案字段并高亮）**：review2 指 v2 的 zh/ru/fr 3-3 字幕中点画面停在表单最底（个人陈述/页脚），看不到出生日期/护照号也看不到高亮。**根因**：3-3 原非 preOff，向导第一步→第二步的 `_wzNext` 渲染+等待在镜内跑（字幕从 s.start 起即覆盖这段转场），长字幕语言（zh/ru/fr）的字幕中点可能落在转场/滚动未定帧。**改法（纯录制层）**：shots-v1.json 给 3-3 加 `preOff:true`——把「填第一步+翻到第二步+等 Date of birth 出现」整段放镜外（offCamera），录制从「第二步·档案」已渲染好起录，随即 `input[type="date"]`（语言无关）滚到视口中并打环，dwell+tail 全程画面停在 DOB/护照行。字幕/高亮选择器一字未改。
- **§三.4（3-9 滚到刚提交的 Demo Aisha 卡再框）**：review2 指 v2 的 3-9 框住 #9 Serikova Aizhan（旧 hl `.partner-student-status-pending` 取首个 pending 卡），而 3-8 刚提交的是 #10 Demo Aisha。**改法**：3-9 的 `pre` 在 `loadMyReferrals()` 后轮询（最多 25×400ms）找名字含「Aisha」的 `.partner-student-card` 打 `data-mh39` 标，hl/waitFor 改 `[data-mh39]`——环即框住刚提交的 #10 Demo Aisha 整卡。
- **§三.8（俄法 3-1 引用按钮名对齐界面，§四.4 逐字）**：主审 grep 实证 v185 外挂 i18n 包的真值——`maxhouse-partner-i18n-v183-ru.js`：`'partner.students.addBtn':'Направить нового студента'`；`-fr.js`：`'Soumettre un nouveau référencement'`（`.partner-add-student-btn` span `data-i18n="partner.students.addBtn"`，第 6386 行）。v2 俄法 3-1 字幕引的是「Отправить нового студента」/「Soumettre un nouvel étudiant」，与按钮对不上。**改法**：captions-v1.json 俄 3-1→「Нажмите «Направить нового студента».」、法 3-1→「Touchez « Soumettre un nouveau référencement ».」（最小改·回译自检：Направить нового студента＝Refer a new student；nouveau référencement＝submit a new referral，均＝按钮+EN 原意），重 TTS 俄法 3-1。EN/ZH 3-1 本已逐字对（EN 按钮 Submit New Student Referral／ZH 提交新学生推荐），不改。
- **§三.7（去提额横幅）**：ch3 的 3-1/3-9 在工作台 my-referrals 列表上。录前 `st-ch8-quota-off.sql`（quota_requests pending→approved、decided_at 留 NULL→`_qrApplyBanner` 清横幅）、录后 `st-ch8-quota-restore.sql` 还原；收工 verify #13 回 pending、17/17 PASS。
- **§一（工作台背景 ¥0 无负数）**：3-9 的 Demo Aisha 卡增值服务区「Invested on this student: ¥0」无负数。

| 镜 | 字幕原文（配音·EN·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 3-1 | Tap "Submit New Student Referral". | 橙环框「+ Submit New Student Referral」按钮（引号内文字＝按钮文字逐字一致） | 是 |
| 3-3 | Step two: the student's profile, exactly as in the passport. | 第二步「Profile」激活；橙环框「Date of birth」日期输入框，右侧「Passport no.」可见（档案字段，非表单底/个人陈述） | 是 |
| 3-9 | From now on this student is bound to you. | 橙环框 #10「Demo Aisha」整卡（Documents under review · Pakistan · bachelor · Referred 10/13/2026 · Invested ¥0），其下 #9 Serikova Aizhan 未框 | 是（刚提交即绑定的那名学生＝#10 Demo Aisha） |

- §四.5 整镜扫描：ch3 画面＝登录（offCamera 不录）+ 工作台列表 + 推荐向导，无付款/内测/offer-解锁元素；8 片录制 DOM 全 **no @gmail**（rec 逐镜 leak 检均 ✅）；无 beta/placeholder/test 字样；唯一 ¥ 金额＝增值服务「Activate ¥1,500/¥600/from ¥4,500」（正数）与「Invested ¥0」（零，非负）。演示生 Demo Aisha、演示机构 Demo Agency 无真 PII，邮箱 agency.demo@example.com；页头平台 WhatsApp/Email（Service@maxhouses.net）不遮（D-14-3/D-15-1）。
- **port 3-9 注记（§二.5 港宽约束照实录）**：竖版 Demo Aisha 卡含增值服务区，整卡高度≈竖版页面区满高，scrollIntoView-center 后姓名行落在吸顶页头下沿、#10 徽章+增值 ¥0 仍在框内——该卡仍被唯一框住（对比其下未框的 #9 Serikova），与 review1 §二.5「手机宽度下照实录」同性质；横版整卡全可见。
- 时长（最终成片，秒）：land en 58.62 / zh 59.92 / ru 59.96 / fr 58.99；port en 58.61 / zh 59.83 / ru 59.97 / fr 58.95。8 片全 res OK + audio yes。
- 联络表（本节证据，四语全部用本趟最终成片重生成）：`~/mh-jobs/shots/GP1/<lang>/ch3-contact-{land,port}-<lang>.png`（逐镜字幕中点）。

## ch4 §三.10 + §一（第三轮返工 · RULING-20261013b，第41趟 2026-10-13 · v185 定版重录·不沿用旧录像）
ch4＝具名邀请（委托学生自传）章（state 章：pt-04 置 intake_mode='delegate' + 必传材料齐 4/4，4-5 真 submit 写 submitted_at；每变体录前 `st-pt04-docs-full.sql` 置态、录后 `st-pt04-reset-cleanup.sql` scoped 复位——清 intake_mode/submitted_at + 删预置 SPECIMEN transcript 行，不动 app_no=MH-EXET28、不跑全量 rebuild，D-12-2）。review1/review2 未标 ch4 任何字幕缺陷→**字幕/高亮一字未改**。本趟按 §三.10「十章全部用 v185 重录、不沿用任何旧录像」把 ch4 整章四语横竖（8 片）用 v185 重录、合成、覆盖 dist。
- **§一（负数金额销账·本趟核心）**：第二版（trip36「照原版入拼」）对 ch4 沿用 v184 旧录像，英文 4-4/4-5 委托卡右侧「Invested on this student: ¥-3,000」为负数（漏斗缺陷1，v185 已修）。本趟 v185 重录后，四语 4-4/4-5 委托卡所在页面增值服务区金额＝**¥0（无负数）**——亲帧复验 EN land 4-4 原始帧 f00215 /（4-5 窗口）f00298「Invested on this student: ¥0」；ZH land 4-4 f00215「该学生已投入：¥0」；RU land 4-4 f00214「Вложено в студента: ¥0」；FR land 4-4 f00212「Investi pour cet étudiant : ¥0」。
- **§三.7（提额横幅）N/A**：ch4 全 5 镜画面均在工作台「已发邀请/委托卡/学生卡」区（scrollIntoView 后处于列表中段），不露工作台顶部 hero，故无「Quota raise pending」amber 横幅——亲帧 EN land 4-1 原始帧 f00025（吸顶页头下即「Submit New Student Referral / Invite student to self-upload / Sent invites」，header 与内容之间无 amber 横幅）。本趟 ch4 不需 st-ch8-quota-off。
- **§三.9（俄法章节条左标签）**：ru→「Центр партнёров」、fr→「Espace partenaires」（gp1-overlays BAR_I18N，trip38 已改并 commit；本趟 ch4 重烧继承）。联络表实帧亲验：ru 章节条＝「Центр партнёров」、fr＝「Espace partenaires」；zh＝「合作伙伴端」、en＝「Partner Hub」。

| 镜 | 字幕原文（配音·EN·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 4-1 | Too many files to collect? Let the student upload them. | 橙环框「✉ Invite student to self-upload」按钮（其上另有 Submit New Student Referral） | 是 |
| 4-2 | Fill in the student's email and the plan you agreed. Send. | 邀请弹窗表单：#dlName 填「Aizhan Serikova」、#dlEmail 填「aizhan.demo@example.com」（演示号·no @gmail） | 是 |
| 4-3 | Copy the link or resend it. | 橙环框「Sent invites」列表行：Aizhan Serikova · agency.demo@example.com · Sent/Registered（Copy/Resend 钮，链接 token 未明文） | 是 |
| 4-4 | The student registers and uploads; you watch the progress. | 橙环框委托卡：Delegated·student uploads / Required documents 3/4 / 时间线 Invite sent→Student registered 2026-10-12→Documents complete 3/4→You submitted（Waiting for you） | 是 |
| 4-5 | The submit button stays with you — only you file the application. | 橙环框「Submit application」按钮（Required documents 4/4 齐·按钮由灰变绿可点） | 是 |

- §四.5 整镜扫描：ch4 画面＝登录（offCamera 不录）+ 工作台邀请区 + 委托卡；无付款/offer-解锁元素；8 片录制 DOM 全 **no @gmail**（演示邮箱 aizhan.demo@/agency.demo@example.com）；无 beta/placeholder/test 字样；¥ 金额＝增值服务「Activate ¥1,500/¥600/from ¥4,500」（正数）与「Invested ¥0」（零，非负）。演示生 Aizhan Serikova/Okoye Emeka、演示机构 Demo Agency 无真 PII；页头平台 WhatsApp +49 152 24910967/Email Service@maxhouses.net 不遮（D-14-3/D-15-1）。俄法委托卡所在页面若干动态串（Premium services / All documents currently under review 等）英文回退＝D-18-4 照录不补。
- 时长（最终成片，秒）：land en 42.87 / zh 42.96 / ru 43.12 / fr 42.85；port en 42.58 / zh 42.86 / ru 42.86 / fr 42.78。8 片全 res OK + audio yes。
- 联络表（本节证据，四语全部用本趟最终成片重生成）：`~/mh-jobs/shots/GP1/<lang>/ch4-contact-{land,port}-<lang>.png`（逐镜字幕中点）。

## ch5 第三轮返工（RULING-20261013b §三.2(a)+§三.7+§一·第42趟 2026-10-13 · v185 两态定版重录）
**取代上方 trip33「ch5 定版重录」节的 5-1 行**（旧 5-1 高亮列表卡、与字幕「A document was returned」对不上=review2 §三.2 病灶）。本趟 5-1 改从通知铃取镜：铃内有 urgent 退回通知，标题本地化「Your student had a document returned」与字幕同义→字幕一字不改、不重配音。录制层给产品漏挂类的 `#stuNotifList` 补产品自带 `.stu-notif-list`（启用产品本设计的滚动，产品 bug 入 SUMMARY）+ preOff 把开铃/定位放镜外（§四.2 高亮占比 ~88%）。§三.7 land 5-1 露 hero→st-ch8-quota-off 去「Quota raise pending」横幅、录后 restore（verify#13 回 pending）。§一 工作台 ¥0 无负数。§三.8 N/A（ch5 字幕无引号引用按钮名）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（字幕中点 DOM 读+亲帧复验） | 同一件事？ |
|---|---|---|---|
| 5-1 | A document was returned. Open the student. | 通知铃 urgent 通知标题「Your student had a document returned」+ desc「The transcript of Rahim Islam was returned. Reason: …」（理由 EN 回退 D-18-4） | 是（铃内退回通知↔字幕「a document was returned」；随后 5-2 开学生） |
| 5-2 | The transcript was returned — the Maxhouse review team requested a change. | `.reviewer-row-rejected`：⚠ Maxhouse review team · Modification requested（材料 Academic transcript · REJECTED） | 是 |
| 5-3 | Upload the corrected file. | 换版区「Upload corrected version」红钮 + 提示「Choose the corrected file …」 | 是 |
| 5-4 | Back under review — no need to resubmit the whole application. | transcript 槽徽章 `.badge-reviewing`＝REVIEWING；矩阵「⚙ System · Awaiting initial review」（2 files uploaded，真·0104 supersede 态，非伪造） | 是 |

- §四.2：5-1 字幕窗 ~5.4s、高亮通知可见 ~88%（≥70%）；5-2/5-3/5-4 高亮全程在弹窗内≥90% 可见。
- §四.5 整镜扫描：beta/placeholder/test/负数 **0 命中**；@gmail 录制层 MASK_INIT 遮（rec 8/8 no @gmail）；页头平台 WhatsApp/Service@maxhouses.net 不遮（D-14-3/D-15-1）。
- 亲帧复验：EN land 5-1(f29 铃+退回通知高亮·无横幅·¥0·STUDENTS 9)/5-2(f76 Modification requested 行)/5-4(ch5b f20 REVIEWING 徽章)；EN port 5-1(f25 全宽面板退回通知高亮)。演示生 Islam Rahim 无真 PII、双盲守住、无 beta/负数。
- 时长：land 32.47s / port 32.49s（4 镜）。

## ch6 §三.10 + §三.7 + §一 + §三.9（第三轮返工 · RULING-20261013b，第43趟 2026-10-14 · v185 定版重录·不沿用旧录像）
ch6＝盲态进度（Offers from several universities）章：读-only（viewReferredStudent 开委托生 Bilal 详情→两盲 offer 卡；openCloudAdmissionModal 开盲态录取弹窗；6-7 高亮「接受该专业」affordance 不点、不写库）。§二（删 6-4/6-6 揭晓、改只读流程）在 trip21(D-21-1) 已执行，本趟仅按 §三.10「十章全部用 v185 重录、不沿用任何旧录像」把 ch6 整章四语横竖（8 片）用 v185 重录、合成、覆盖 dist。review1/review2 未标 ch6 任何字幕缺陷→**字幕/高亮一字未改**。
- **§一（负数销账·复核）**：第二版 ch6 为 v184 旧录像（review2 §一.1「第6章同样是 v184 录的」）。本趟 v185 base 探针（`_probe-ch6-hero.mjs`）实证各镜负数金额 **(none)**；§四.5 in-frame 扫描四语横竖全 CLEAN（无 ¥- 负数）。亲帧复验 EN land 6-1/6-2/6-3/6-7：盲 offer 卡与弹窗金额＝正数学费/奖学金，无负数。
- **§三.7（提额横幅·本趟处理）**：`_probe-ch6-hero.mjs` 实证 ch6 各镜（含详情/弹窗态）`#qrPendingBanner`「⏳ Quota raise pending: 10 → 30」在屏（产品常驻顶部横幅）→ 录前 `st-ch8-quota-off.sql` 去横幅、录后 `st-ch8-quota-restore.sql` 还原 pending（读-only 章：一次 off→录全 8 变体→一次 restore）。亲帧复验 EN land 6-1 contact：header「Partner Hub / Hussain Bilal」与内容间**无 amber「Quota raise pending」横幅**。收工 verify #13 回 pending、17/17 PASS。
- **§三.8 N/A**：ch6 字幕无引号引用按钮/标签名。
- **§三.9（俄法章节条左标签）**：ru→「Центр партнёров」、fr→「Espace partenaires」（gp1-overlays BAR_I18N，trip38 已改并 commit；本趟 ch6 重烧继承）。联络表实帧亲验：ru 章节条＝「Центр партнёров」、fr＝「Espace partenaires」；zh＝「合作伙伴端」、en＝「Partner Hub」。
- **@gmail 记账**：录制首轮 en-land 6-2 leak 检报 ⚠GMAIL——`_probe-ch6-gmail.mjs` 定位＝委托邀请列表 `.dl-inv-sub` / 审核值 `.review-val` 的 `maxhouseapp+guide-pt-04/06@gmail.com`，文档位置 top≈4263/4348px（视口仅 543px 高）**off-screen·inFrame:false**，从不在录制裁剪帧内；成因＝leak 检扫整个 body.innerText（含屏外）取到 MASK 下次 sweep（每 80ms）前的 <80ms 瞬态。重录 en-land 一次即 ✅ no @gmail；§四.5 in-frame 扫描四语横竖 MAIL 全 CLEAN。最终 8 片画面无真邮箱。

| 镜 | 字幕原文（配音·EN·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 6-1 | Two universities admitted this student. | 委托生 Hussain Bilal 详情·橙环框两盲 offer 卡区（SCH-1AD6CR·UNIVERSITY·MSc Computer Science·MATCHED / SCH-B6X61C·UNIVERSITY·View full offer，均盲码无校名） | 是 |
| 6-2 | Before unlock you see the programme, tuition and scholarship — written by the university itself — but not its name. | 录取弹窗 Admission Details·橙环框盲码标签「SCH-1AD6CR」；弹窗内 MSc Computer Science·学费/奖学金行（学校所填），无校名 | 是 |
| 6-3 | Compare, then accept the one you prefer. | 橙环框奖学金行「Full scholarship (tuition waived)」（盲态·学校所填数据·LL 恒英文回退 D-18-4） | 是 |
| 6-7 | Accept the programme — the start date and scholarship are right here. | 橙环框「✓ Accept this programme」绿钮（旁 Start date 2027-09-01 + Full scholarship，affordance 高亮不点·不写库） | 是 |

- §四.5 整镜扫描（in-frame·MASK+HIDE 复现录制层）：四语横竖全 **CLEAN**——无 beta/placeholder/test/内测/测试、无负数金额、无真邮箱（`.cloud-offer-unlock` beta 解锁链接 HIDE_INIT 遮）。演示生 Hussain Bilal 无真 PII、双盲守住（offer 卡/弹窗全程盲码 SCH-xxxxxx，无真校名）。页头平台 WhatsApp/Email（Service@maxhouses.net）不遮（D-14-3/D-15-1）。俄法弹窗内学费/奖学金/开学等动态串英文回退＝D-18-4 照录不补。
- 时长（最终成片，秒）：land en 25.91 / zh 26.28 / ru 26.55 / fr 25.99；port en 25.83 / zh 26.36 / ru 26.68 / fr 25.89。8 片全 res OK + audio yes + 4 镜 box 全 resolve。
- 联络表（本节证据，四语全部用本趟最终成片重生成）：`~/mh-jobs/shots/GP1/<lang>/ch6-contact-{land,port}-<lang>.png`（逐镜字幕中点）。

## ch7 §三.5 + §三.6 + §三.7 + §一（+§三.9）（第三轮返工 · RULING-20261013b，第45趟 2026-10-14 · v185 定版重录·state 章 pt-07/08 置态）
ch7＝通知书/JW202/建档章（Letter, JW202 & enrolment filing）。state 章：每变体录前 `st-pt07-pay-cleanup`（pt-07 accepted+通知书已传+未付）+ `st-pt08-jw202`（pt-08 传 JW202 SPECIMEN 供 7-2 下载钮），7-0 真付 ¥0 优惠码路（写 letter_paid_at + 建 1 条 coupon_redemption），录全 8 变体后 `st-pt0708-reset-cleanup` 复位（verify #6/#7/#8）+ `st-ch8-quota-restore`（verify #13）。字幕四语不变。
- **§三.5（7-0 付款成功页 beta 提示·本趟核心）**：7-0 ¥0 发票 dwell 在镜内（`.payment-amount-value`「¥0.00」橙环框），dwell ~3.6s + 预点 1.4s ≥2s；真付确认点击（`#payConfirmBtn`）+ 等待（付款成功产品 `_s7Toast`「Paid (beta placeholder)…」浮条寿命 ~2.6s）全在**镜外**（shot.actOff → offCamera）跑，等 toast 自然消失后才恢复 tail → 内测 toast 帧**永不入片**。双保险：rec.mjs HIDE_INIT 另按文字含 beta/placeholder/内测/测试 的 toast/fixed 浮条打 display:none（录制层遮，不碰产品码）。真付 DB 照写、7-1 校名揭晓不受影响。
- **§三.6（7-4 只框状态行·本趟核心）**：7-4 高亮改框列表卡状态行 `.partner-student-issue`「⏳ Admission complete · MSc Mechanical Engineering · 1w ago」（经 `#gp1-74-issue` 合成标记 rAF 实时贴合状态行 box）、**不框整卡**、不框徽章；实测 box≈856×100（状态行高，非整卡）。字幕四语不变。徽章「Documents approved · matching」在屏但不框（§二.1 产品问题留 SUMMARY）。
- **§三.7（提额横幅）**：ch7 列表顶部 `#qrPendingBanner`「Quota raise pending: 10→30」在屏（trip44 `_probe-ch7-quota` 实证 top=238 in-view）→ 录前 `st-ch8-quota-off` 去横幅、录后 `st-ch8-quota-restore`（verify#13 回 pending）。
- **§一（负数销账·复核）**：7-0 发票折扣行「¥3,000.00 · MAXHOUSE −¥3,000.00」＝优惠码抵扣（§四.5 白名单正常显示，非违规负数）；应付大字 ¥0.00；列表卡「Invested on this student: ¥0」无负数。§四.5 in-frame 扫描四语横竖负数全 CLEAN。
- **§三.9**：ru 章节条「Центр партнёров」/fr「Espace partenaires」（trip38 overlay 继承）；zh「合作伙伴端」/en「Partner Hub」不动。

| 镜 | 字幕原文（EN·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 7-0 | Enter the coupon code — ¥0. No agency fee, no application fee. | 付款弹窗「UNLOCK FEE — TOTAL DUE」·橙环框应付大字「¥0.00」（下方 ¥3,000.00·MAXHOUSE −¥3,000.00 抵扣行；Applicant/Paid by = agency.demo@example.com 脱敏） | 是 |
| 7-1 | The university is revealed — download the admission letter here. | 录取弹窗：先框揭晓校名条 `.admission-id-tag--unlocked`，后框「Download admission letter」钮（两段高亮 review1 §二.3） | 是 |
| 7-2 | The JW202 follows the same way. | 橙环框「JW202」下载钮 `.admission-doc-btn-jw` | 是 |
| 7-3 | The platform files the student into the university's own enrolment system for you. | 橙环框建档进度 `.offer-progress`（MSc Mechanical Engineering + 清单含 Enrollment ✓） | 是 |
| 7-4 | Admission complete. | 橙环框列表卡状态行「⏳ Admission complete · MSc Mechanical Engineering · 1w ago」（只框状态行，不框整卡/徽章） | 是 |

- §四.2：7-0 ¥0 高亮 dwell≥2s 全程在弹窗内≥90% 可见；7-4 状态行高亮经 rAF 贴合、dwell 全程≥70% 在视口内。
- §四.5 整镜扫描（in-frame·MASK+HIDE 复现录制层，4 语×2 视口）：**ALL CLEAN**——beta/placeholder/test/内测/测试 0 命中（含产品 `_s7Toast` 付款成功 beta 浮条，HIDE_INIT 遮住）、负数 0 命中（MAXHOUSE 抵扣行白名单）、真邮箱 0 命中（@gmail MASK→agency.demo@example.com）。页头平台 WhatsApp/Service@maxhouses.net 不遮（D-14-3/D-15-1）。
- 亲帧复验：EN land 7-0(f9 ¥0 橙框·无 beta toast·无横幅)/7-4(f97 状态行框·徽章不框·Invested ¥0)；ru land + zh/fr contact 逐镜复验 ¥0/校名揭晓/JW202/建档/状态行。
- 时长（最终成片，秒）：land en 38.40 / zh 38.51 / ru 38.20 / fr 38.02；port en 37.98 / zh 38.59 / ru 38.16 / fr 38.61。8 片全 res OK + audio yes + 5 镜 box 全 resolve。
- 联络表（四语全部用本趟最终成片重生成）：`~/mh-jobs/shots/GP1/en/ch7-contact-{land,port}-en.png`。

## ch8 §三.7（照 D-32-1）+ §一 + §三.9 + §三.10（第三轮返工 · RULING-20261013b，第46趟 2026-10-14 · v185 定版重录·名额与提额章）
ch8＝名额与提额章（Quota & requesting more）。**零 DB 写**：8-1 读工作台统计卡；8-2/8-3 用 `pre` 调产品 `_qrOpenRaise({used:9,quota:10})` 开弹窗、填数量 30+理由但**不点提交**；8-4 调产品自身 `_qrApplyBanner` 喂样例已批数据渲染真绿条（§8 先例·不写库）。字幕四语未改（review1/review2 未标 ch8 字幕缺陷；trip32 已 bank）。
- **§三.7（提额横幅·照 D-32-1）**：基线有 1 张 pending `quota_request`（verify#13）→ 工作台顶部恒显 amber「Quota raise pending: 10→30」，与 8-2/8-3「才去申请」叙事矛盾 → 录前 `st-ch8-quota-off`（该行 status pending→approved·decided_at 保持 NULL → 产品 `_qrApplyBanner` 判非 pending 且无裁决 → box 清空无横幅；`partners.referral_quota` 不动仍 10、hero 数字不变），录后 `st-ch8-quota-restore` 还原 pending（收工 verify#13 回 pending）。读-only：一次 quota-off → 录全 8 变体 → 一次 restore。
- **§一（负数销账）**：v185 base 工作台背景「TOTAL PAYMENTS PROCESSED ¥0」无负数（亲帧 EN land 8-1 f15 / 8-4 f157）。§四.5 in-frame 扫描四语横竖负数全 CLEAN。
- **§三.9**：ru 章节条「Центр партнёров」/fr「Espace partenaires」（trip38 overlay 继承·联络表实帧亲验）；zh「合作伙伴端」/en「Partner Hub」不动。
- **§四.4（引用按钮名逐字）N/A**：ch8 四镜字幕均未用引号引界面按钮/标签名（8-2「Request a raise right here」、8-3 描述动作、8-4「Approved…」），无逐字比对对象。

| 镜 | 字幕原文（EN·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 8-1 | You've submitted nine students. | 工作台统计卡「STUDENTS SUBMITTED 9」橙环框（右侧「TOTAL PAYMENTS PROCESSED ¥0」无负数；§三.7 去横幅后 header 与内容间无 amber「Quota raise pending」横幅） | 是 |
| 8-2 | Request a raise right here. | 「Referral quota reached · 当前 9/10 席已用」提额弹窗 body 橙环框（zh 本地化「推荐名额已用完」；ru/fr 弹窗标题 EN 回退 D-18-4） | 是 |
| 8-3 | Tell us how many more students you expect; we review it within two working days. | 提额弹窗「Submit request / 提交申请」提交钮橙环框（目标名额填 30 + 理由；高亮全程贴合提交钮，填表在后半段完成——亲帧 zh-port f148 默认 15、f181 已填 30+理由） | 是 |
| 8-4 | Approved — your quota grows with your results. | 产品自身 `_qrApplyBanner` 喂样例渲染绿条「Quota raise approved: your quota is now 30 seats」橙环框（§8 先例·零写库；zh 本地化「提额申请已批准：配额已调整为 30 席」；ru/fr EN 回退 D-18-4） | 是 |

- §四.2：8-1/8-2/8-4 高亮全程在视口内≥90% 可见、dwell≥70%；8-3 高亮＝提交钮，f148 与 f181 皆橙框在屏（highlight 全程≥90%），填表值 15→30 在窗口后半完成（caption 述「填预计人数」＝表单动作，与画面一致）。
- §四.5 整镜扫描（in-frame·MASK+HIDE 复现录制层·`_scan-ch8-forbidden.mjs`·4 语×2 视口）：**ALL CLEAN**——beta/placeholder/test/内测/测试 0 命中、负数 0 命中、真邮箱 0 命中（@gmail MASK→agency.demo@example.com）。页头平台 WhatsApp/Service@maxhouses.net 不遮（D-14-3/D-15-1）。
- 亲帧复验：EN land 8-1(f15 9 学生·¥0·无横幅)/8-4(f157 产品绿条非伪造·¥0)；ru land + fr land + zh port 联络表逐镜复验（章节条 ru/fr 本地化、zh 弹窗全中文、ru/fr 弹窗与绿条 EN 回退 D-18-4 照录）；Demo Agency 无真 PII。
- 时长（最终成片，秒）：land 30.14 / port 30.09。8 片全 res OK + audio yes + 4 镜 box 全 resolve。
- 联络表（四语全部用本趟最终成片重生成）：`~/mh-jobs/shots/GP1/en/ch8-contact-{land,port}-en.png`。

## ch9 §三.10（+§三.7+§一+§三.9）（第三轮返工 · RULING-20261013b，第47趟 2026-10-14 · v185 定版重录·增值服务章·读-only）
ch9＝增值服务章（Optional / value-added services）。**读-only·零 DB 写**：CONTEXT['9'] 仅把首张推荐生列表卡的 `.partner-premium-block` 滚到视口中心，逐镜高亮服务行（9 张卡服务行同构同价，字幕不点名学生，取首卡即可），全程零点击、零写库。字幕四语未改（review1/review2 未标 ch9 任何镜级缺陷；§三.10 仅要求 v185 定版重录一次）。
- **§三.10（定版重录·本趟目的）**：ch9 整章四语横竖 8 片用 v185 重录→`_prodch9.sh` 合成覆盖 dist→`gp1-finish --stage contact --chapter 9` 四语联络表。md5 比对 dist vs `_v2/` 8 片全差异（真重录非 stale）。
- **§三.7（提额横幅·安全·照 ch6 读-only 先例）**：虽 9-* 把 premium block 滚到视口中心、hero 顶部横幅多滚出视口（扫描只计视口内可见文字），为杜绝「Quota raise pending 10→30」amber 横幅任何残留，录前 `st-ch8-quota-off` 去横幅、录后 `st-ch8-quota-restore`（收工 verify#13 回 pending）。读-only：一次 off→录全 8 变体→一次 restore。
- **§一（负数销账）**：每张卡「Invested on this student: ¥0」无负数（亲帧 EN land 9-1 f30）；服务价 ¥1,500 / ¥600 / 从 ¥4,500 起均正数。§四.5 in-frame 扫描四语横竖负数全 CLEAN。
- **§三.9**：ru 章节条「Центр партнёров」/fr「Espace partenaires」（trip38 overlay 继承·联络表实帧亲验）；zh「合作伙伴端」/en「Partner Hub」不动。
- **§四.4（引用按钮名逐字）N/A**：ch9 四语字幕均未用引号（" " / 「」/ « »）引界面按钮或标签名——全为描述性散文（"the Audit Service" / "Human-assisted Search" / "paid exposure" 无引号），程序扫 ch9 四语 captions 引号标记 0 命中，无逐字比对对象。
- **§四（9-4 forbid）**：9-4 高亮行为「Exposure boost · inactive / Best for students below a school task's bar or with no news after a long wait」，**无「优先审核 / priority review」字样**（shot forbid 满足）。

| 镜 | 字幕原文（EN·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 9-1 | Optional extras, only if you want them: | `.partner-premium-title`「🎁 PREMIUM SERVICES」橙环框（右侧「Invested on this student: ¥0」无负数；§三.7 去横幅后无提额横幅） | 是 |
| 9-2 | the Audit Service, which removes the basic 2-offer cap and adds 30 days of premium placement, | premium 第 2 行橙环框「🚀 Audit Service · Inactive · Activate ¥1,500」 | 是 |
| 9-3 | Human-assisted Search, where a Maxhouse advisor builds a bespoke school shortlist for the student, | premium 第 3 行橙环框「🤝 Human-assisted Search · Inactive · Activate ¥600」 | 是 |
| 9-4 | and paid exposure, which places the student in more universities' candidate pools. | `.partner-premium-row--boost` 橙环框「📈 Exposure boost · inactive · Activate · from ¥4,500」（无「优先审核」字样） | 是 |

- §四.2：9-1..9-4 高亮均在滚到视口中心的 premium block 内，全程≥90% 可见、dwell≥70%；box 四镜全 resolve（land 1795×43/105/105/176）。
- §四.5 整镜扫描（in-frame·MASK+HIDE 复现录制层·`_scan-ch9-forbidden.mjs`·4 语×2 视口）：**ALL CLEAN**——beta/placeholder/test/内测/测试 0 命中、负数 0 命中、真邮箱 0 命中（@gmail MASK→agency.demo@example.com）。页头平台 WhatsApp/Service@maxhouses.net 不遮（D-14-3/D-15-1）。
- 亲帧复验：EN land 9-1(f30 PREMIUM SERVICES 框·Invested ¥0·无横幅)/9-2(f75 Audit ¥1,500)/9-4(f165 Exposure boost ¥4,500)；zh land f75(增值服务/Audit 服务 激活 ¥1,500·该学生已投入 ¥0·章节条 合作伙伴中心)、ru land f30(章节条 Центр партнёров·Вложено в студента ¥0·PREMIUM/Audit/Human-assisted EN 回退 D-18-4)；联络表四语逐镜复验。Demo 生 Serikova Aizhan / Okoye Emeka 无真 PII、双盲守住（无校名）。
- 时长（最终成片，秒）：land en 22.82 / zh 23.80 / ru 26.35 / fr 24.32；port en 22.78 / zh 23.75 / ru 26.39 / fr 24.27。8 片全 res OK + audio yes + 4 镜 box 全 resolve。
- 联络表（四语全部用本趟最终成片重生成）：`~/mh-jobs/shots/GP1/<lang>/ch9-contact-{land,port}-<lang>.png`（逐镜字幕中点）。

## ch10 §三.10（+§三.7+§一+§三.9）（第三轮返工 · RULING-20261013b，第48趟 2026-10-14 · v185 定版重录·设置/语言/账户章·读-only·十章重录收尾）
ch10＝设置/语言/账户章（Account, language & security），3 镜 10-2/10-3/10-4。**读-only·零 DB 写**：CONTEXT['10'] 仅 `toggleSettingsMenu` 开设置下拉菜单（不开 asModal，使 Account settings/语言/Sign out 全程在菜单内可见），逐镜高亮菜单项 / 顶条语言切换器，全程零点击提交、零写库。字幕四语未改（review1/review2 未标 ch10 任何镜级缺陷；§三.10 仅要求 v185 定版重录一次）。ch10 是第十章，本趟即十章全部 v185 定版重录收尾。
- **§三.10（定版重录·本趟目的）**：ch10 整章四语横竖 8 片用 v185 重录→`_prodch10.sh` 合成覆盖 dist→`gp1-finish --stage contact --chapter 10` 四语联络表。md5 比对 dist vs `_v2/` 8 片全差异（真重录非 stale；覆盖前先 cp 第二版 8 片入 `_v2/`，_v2 原无 ch10）。
- **§三.7（提额横幅·RULING 明列第 10 章顶部有「Quota raise pending 10→30」横幅）**：设置菜单浮在工作台之上、露 hero 顶部。录前 `st-ch8-quota-off`（quota_requests 单列 pending→approved·decided_at 保持 NULL→产品清横幅）、录后 `st-ch8-quota-restore`（收工 verify#13 回 pending）。读-only：一次 off→录全 8 变体→一次 restore。亲帧四语横竖联络表 header 与 hero 间**无 amber 提额横幅**。
- **§一（负数销账）**：背景 hero「TOTAL PAYMENTS PROCESSED ¥0」无负数（亲帧四语横竖联络表）、「STUDENTS SUBMITTED 9」；§四.5 in-frame 扫描四语横竖负数全 CLEAN。
- **§三.9**：ru 章节条「Центр партнёров」/fr「Espace partenaires」（trip38 overlay 继承·本趟联络表实帧亲验 land+port 均已本地化）；zh「合作伙伴端」/en「Partner Hub」不动。
- **§四.4（引用按钮名逐字）N/A**：ch10 四语字幕均未用引号（" " / 「」/ « »）引界面按钮或标签名——全为描述性散文（"under the gear" / "Four interface languages" 等无引号），无逐字比对对象。

| 镜 | 字幕原文（EN·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 10-2 | Account settings live under the gear. | `#settingsMenu [onclick*="openAccountSettings"]`「⚙ Account settings」橙环框（设置下拉 ACCOUNT 区·齿轮项） | 是 |
| 10-3 | Four interface languages. | 顶条 `.lang-switcher`「EN · 中 · РУ · FR」四语切换按钮组橙环框 | 是 |
| 10-4 | Sign out when you share a computer. | `#settingsMenu [onclick*="settingsSignOut"]`「⟶ Sign out」橙环框（设置下拉底部红色退出项） | 是 |

- §四.2：10-2/10-3/10-4 高亮均在打开的设置菜单内（10-3 在顶条语言器），全程≥90% 可见、dwell≥70%；box 三镜全 resolve（land 705×93 / 383×80 / 705×93；port 752×99 / 408×85 / 752×99）。
- §四.5 整镜扫描（in-frame·MASK+HIDE 复现录制层·`_scan-ch10-forbidden.mjs`·4 语×2 视口）：**ALL CLEAN**——beta/placeholder/test/内测/测试 0 命中、负数 0 命中、真邮箱 0 命中（账户邮箱 @gmail MASK→agency.demo@example.com）。页头平台 WhatsApp/Service@maxhouses.net 不遮（D-14-3/D-15-1）。
- 亲帧复验（四语 land+port 联络表逐镜）：设置菜单 ACCOUNT 区邮箱掩码 `agency.demo@example.c…`、Partner Code PA-E62FC6FF、Agency Demo Agency（无真 PII）；三项高亮逐镜对账全「是」；¥0 无负数、无提额横幅、无 beta/内测/test；ru/fr 菜单项真本地化（Настройки аккаунта/Выйти · Paramètres du compte/Se déconnecter，非 EN 回退）、zh 全中文（账户设置/退出登录）；hero「Your referral performance」等动态 LL 串在 ru/fr 仍 EN 回退（D-18-4 照录不补）。
- 时长（最终成片，秒）：land en 16.31 / zh 16.30 / ru 16.32 / fr 16.27；port en 16.31 / zh 16.31 / ru 16.23 / fr 16.31。8 片全 res OK + audio yes + 3 镜 box 全 resolve、全片 no @gmail。
- 记账：ch10 读-only，开工+收工 verify **17/17 PASS 0 FAIL**，baseline 全程守住（零置态/零写库·scoped quota off→restore）。ch10 v1 在 `_v1/` 留底、v2 在 `_v2/` 留底、dist 覆盖为第三轮定版。全片不重拼（待 OP 快剪重做后统一重拼）。
- 联络表（四语全部用本趟最终成片重生成）：`~/mh-jobs/shots/GP1/<lang>/ch10-contact-{land,port}-<lang>.png`。
