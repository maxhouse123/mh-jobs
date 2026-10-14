# REVIEW-zh-shots · 逐镜对账表（review1 §十一）· ZH

取帧点＝每镜字幕显示中点那一帧。高亮区文字从当时 DOM 读。随返工逐章追加。

## ch9 §三.6（增值服务名，返工第23趟 2026-10-12）
根因同 EN（增值服务区只在推荐生列表卡渲染，非详情弹窗；改不开弹窗、高亮列表卡真行）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字 | 同一件事？ |
|----|----------|---------------------|-----------|
| 9-1 | 可选的增值服务，用不用都行： | 📦 增值服务 · 该学生已投入：¥0 | 是（框增值服务区标题行） |
| 9-2 | Audit 服务，解除基础版两个 offer 上限，并提供 30 天优先推荐位； | 🚀 Audit 服务 · 未激活 · 激活 ¥1,500 | 是（框 Audit 服务行；据产品 `partner.vapay.auditDesc`="解除基础版 2 个 offer 上限、优先推荐位、30 天服务期。" 改写） |
| 9-3 | 人工搜索，由 Maxhouse 顾问为学生定制专属学校清单； | 🤝 人工搜索 · 未激活 · 激活 ¥600 | 是（框人工搜索行；据 `partner.vapay.searchDesc`="Maxhouse 顾问为该学生定制专属学校清单。" 改写） |
| 9-4 | 付费曝光，让学生进入更多学校的候选池。 | 📡 付费曝光 · 未激活 … 激活 · ¥4,500 起 | 是（框付费曝光行，字幕未改） |

- 时长：land 23.82s / port 23.82s。no @gmail。章节条左标签「合作伙伴端」。演示生 Serikova Aizhan，无真 PII。
- 逐张亲眼复验：各镜框对应行，不越界。

### ch9 v185 定版重录（返工第34趟 2026-10-13，review1 §一 背景）
trip23 字幕/高亮照旧正确，本趟只换录制底座 v184→v185 重录 ch9 4 镜使背景落定版。亲验 ZH land/port 联络表：增值服务区标题行右「该学生已投入：**¥0**」（缺陷1 销账，无负数）；Audit ¥1,500 / 人工搜索 ¥600 / 付费曝光 ¥4,500 起三行与字幕逐镜对账仍「是」。中文字幕无乱码方块，4 镜 box 全 resolve、无 MISS、no @gmail。时长 land **23.77s** / port **23.76s**（v185 重录值）。ch9 读-only 零写库，开工+收工 verify 17/17 PASS。

## ch5 §三.4（5-4 字幕说审核中、徽章却 REJECTED，返工第25趟 2026-10-12）
问题（review1 §三.4）：5-4 字幕「回到审核中，不用整份重交。」，但旧实现用 `setInterval` 把 `.badge-rejected` 伪造成「Under review」= 前端假帧，画面从未真变审核中。
改法（真态化·零改产品代码）：靠产品自己的 0104 supersede 逻辑——`states/st-pt03-reupload.sql` 给 pt-03 真·新建一行更正版 transcript（version2、uploaded_at 更晚、无新裁决）→ 旧 rejected 裁决被取代 → 详情弹窗徽章真变 `.badge-reviewing`。shot 5-4 去伪造、`hl=.badge-reviewing,.reviewer-row-pending`、`expect=[.badge-reviewing]`、`forbid=[.badge-rejected]`。zh 字幕本就"回到审核中"、与真态一致，不改。复位 `st-pt03-reupload-reset-cleanup.sql`，verify 17/17 往返守住。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（登录态探针 `_probe-pt03-review.mjs` 读真态 DOM，class 与界面语言无关） | 同一件事？ |
|----|----------|---------------------|-----------|
| 5-4 | 回到审核中，不用整份重交。 | `.badge-reviewing`（成绩单槽徽章，`status.reviewing` 态）；材料矩阵 `.reviewer-row-pending`「⏳ ⚙ System · Awaiting initial review」；同帧无 `.badge-rejected`、无「Modification requested」 | 是（更正件已传→真回到审核中，待初审） |

- 实证同 EN：置态后 `badge_reviewing=1 / badge_rejected=0 / row_rejected=0 / row_pending=1`；复位后 verify 17/17。
- **帧捕获待 ch5 定版重录**（5-2 退回态与 5-4 审核中态单 pass 不可兼得，两态录制）；本趟落「证真态机制 + 改 shot」，同 trip21 对 7-1 先例。

## 开场快剪 OP-2（review1 §五，返工第26趟 2026-10-12） ⟶ **已被第50趟（第三轮 OP 重做）取代**
问题/依据/做法同 EN REVIEW「开场快剪 OP-2」节（review1 §五：卡总时长不变、配音不动，前 2.5s 满屏卡面→切对应章真实画面静音续配音+叠重点标题条）。本趟只做 OP-2（素材 ch6 6-1/6-2 两份盲 offer，不受缺陷2 阻塞）；OP-3/4/5 静止卡面待缺陷2 裁后接做。零改产品代码/迁移。

| 镜 | 字幕原文（配音，不改） | 快剪后画面（b-roll 中帧 DOM） | 同一件事？ |
|----|----------|---------------------|-----------|
| OP-2 前 2.5s | 一次提交，多校同审 ／（正文配音） | 重点①卡满屏（紫底橙圈 1 + 中文标题 + 正文） | 是 |
| OP-2 2.5s~尾 | （同一句配音续） | ch6 中文真实画面：学生 Hussain Bilal 详情「录取意向」列两份盲 offer（SCH-1AD6C8 / SCH-8E561C，均 大学 · 待决定、无校名），底部叠「① 一次提交，多校同审」 | 是 |

- 亲眼复验（ZH land+port b-roll 中帧）：两份盲 offer、无校名（双盲守住）、无 beta/内测控件、演示生无真 PII；界面中文本地化（合作伙伴面板·学生 / 录取意向 / 待决定 / 查看完整录取 / 添加个人备注）；标题条＝ ZH OP-2 卡标题/ED-1 回顾串一字一致；专业名 "MSc Computer Science" 产品动态串回退英文（D-18-4）。
- OP-2 卡 9.5s 不变 → 全片 land 445.3s / port 444.4s。

## ch2 §三.1 / §三.2（工作台漏斗 + 卡状态徽章，返工第28趟 2026-10-12 · v185 上线后定版重录）
缺陷2 已由 v185 修好上线；录制底座切 v185 + 加 offCamera 等待（offers≥5 且 gate_open≥6）。§三.1（2-2）：工作台无「名额已用/剩余」显示→改述屏上真有的录取漏斗。§三.2（2-4）：`.partner-student-status-approved` class 永不存在（stage 列恒 NULL→class 恒 pending；真标签「材料已通过·匹配中」是 gate_open 覆盖标签，6 张）→ hl 改按真标签文本高亮、字幕改述真档。详见 REVIEW-en-shots.md 同节。

| 镜 | 字幕原文（新/未改） | 高亮区 DOM 实际文字（v185 真帧） | 同一件事？ |
|----|----------|---------------------|-----------|
| 2-1 | 工作台把你推荐的每一位学生放在一处。 | 工作台整屏：合作机构·Demo Agency + 统计面板 + 9 张推荐生卡（整屏 integral） | 是 |
| 2-2 | 你的推荐漏斗：已提交、已发录取通知书、已付款、已录取。 | `.partner-stats-funnel`：已提交 **9** → 33% → 已发录取通知书 **3** → 67% → 已付款 **2** → 50% → 已录取 **1**（下方「累计收到 5 个学校 offer · 平均每位学生 0.6 个」） | 是（漏斗四段＝屏上四段，v185 真值） |
| 2-3 | 每张卡显示学生当前所处的阶段。 | `.partner-students-count`「9 位学生」 | 是 |
| 2-4 | 每张卡显示所处阶段——材料已通过、正在与学校匹配。 | `.partner-student-status`（Mbarga Junior 卡）「**材料已通过 · 匹配中**」；辅行「✓ 核心材料已通过审核 · 等待学校匹配」 | 是（字幕↔屏上同文字标签；6 张卡同档） |
| 2-5 | 学校一有动作，通知就到。 | 通知铃（角标 55）→ 开通知面板（≥4 条） | 是 |

- 时长：land 29.34s / port 29.35s。中文字幕无乱码方块。全片 no @gmail。亲眼复验（ZH land 联络表）：漏斗 9/3/2/1 无负数全 0、2-4 框「材料已通过·匹配中」、¥0 TOTAL PAYMENTS PROCESSED 保留、演示生无真 PII、无 beta 控件。

## ch2 §三.1（第三轮返工 · RULING-20261013b，第38趟 2026-10-13 · v185 定版重录）
⚠ 上表 2-3 / 2-4 两行**已被本节取代**。RULING-20261013b §三.1 复核第二版查出：2-3 框的是「9 students」计数药丸非卡片；2-4 只框一张卡徽章、没依次框各张卡状态行。本趟重做（四语横竖 v185 重录；§三.7 录前 `st-ch8-quota-off`/录后 `st-ch8-quota-restore` 去掉「提额待审」横幅，收工 verify 17/17）：
- **2-3**：改框列表**第一张学生卡整卡**（Serikova Aizhan），字幕不改「每张卡显示学生当前所处的阶段。」。
- **2-4**：改为**依次框 5 张不同真实阶段的卡状态行**（`.partner-student-issue`，nth 1/4/5/6/8；rec.mjs 新增 `hlseq` 多段高亮，每段 hold 1.3s、环不熄仅移动，逐段占其时段 ~76%≥70%），字幕重写并重配音：**「每张学生卡都有自己的状态行，清楚显示该学生所处的阶段——审核中、材料已通过并匹配中、收到新 offer、已发录取通知书、录取完成。」**

| 镜 | 高亮区 DOM 实际文字（从最终成片实帧亲验） | 同一件事？ |
|----|---------------------|-----------|
| 2-3 | 整框第一张学生卡 Serikova Aizhan（徽章「已提交 · 等待平台审核」） | 是 |
| 2-4 seg1 | nth1 Serikova Aizhan「⏳ 所有材料正在审核中」 | 是 |
| 2-4 seg2 | nth4 Mbarga Junior「✓ 核心材料已通过审核 · 等待学校匹配」 | 是 |
| 2-4 seg3 | nth5 Hussain Bilal「🆕 某院校 · 录取后公布校名 发来新 offer · 录取专业 MSc Computer Science — 等待学生回应 · 昨天」 | 是（双盲守住） |
| 2-4 seg4 | nth6 Karimova Nilufar「💰 某院校 · … 已发录取通知书 · 学生需在 30 天内付费 **¥3,000**」（正数） | 是 |
| 2-4 seg5 | nth8 Volkov Dmitri「录取完成 · MSc Mechanical Engineering · 1 周前」 | 是 |

- 时长（成片）：land zh 38.0s。8 片 res OK + audio yes，录制全 no @gmail。2-4 窗 13.8s / 配音 zh 14.0s。
- 亲眼复验（ZH land seg3 全帧）：环框「发来新 offer」行、章节条「第 2 章 工作台」、页头「合作伙伴端/合作伙伴中心」本地化；¥0 无负数、¥1,500/¥600/¥4,500/¥3,000 正数；无 beta/内测/test；双盲守住。联络表见 `~/mh-jobs/shots/GP1/zh/ch2-contact-*.png`+`ch2-2-4-segments-*.png`。

## ch1 §一（1-8 工作台负数金额，返工第29趟 2026-10-12 · v185 定版重录）
前置：ch1 第 1～7 镜＝注册/入驻 UI（产品自身渲染、零写库），review1 未标 ch1 字幕缺陷；唯 1-8 背景 hero 有 review1 §一 的负数金额（v184 缓存帧 `TOTAL PAYMENTS PROCESSED ¥-9,000`）。本趟 v185 底座整章四语横竖定版重录，1-8 背景自动显 `¥0`。字幕一字未改。

| 镜 | 字幕原文（未改） | 高亮区 DOM 实际文字（v185 真帧） | 同一件事？ |
|----|----------|---------------------|-----------|
| 1-1 | 打开合作伙伴端。第一次来，点「新机构注册」。 | 登录门整屏（含「新机构注册」链接，整屏 integral） | 是 |
| 1-3 | 输入引导页上的邀请码，再填邮箱和密码。 | `#regInvite` 邀请码框（明文已打码） | 是 |
| 1-5 | 填机构信息：名称、国家、联系人、每年送生量。 | 入驻资质表单（机构名/国家/联系人/年送生量） | 是 |
| 1-6 | 上传负责人证件和机构资质文件。 | 上传区（负责人证件 + 机构资质 SPECIMEN 样件） | 是 |
| 1-7 | 提交。平台在 2 个工作日内完成审核。 | 「审核中」琥珀药丸状态页 | 是 |
| 1-8 | 审核通过，工作台就开通了。 | `.hero`（Demo Agency · 已通过 徽章橙框）；同帧 hero 统计「学生已提交 9」「TOTAL PAYMENTS PROCESSED ¥0」（**非 v184 的 ¥-9,000**） | 是 |

- 时长：land 49.45s / port 49.48s（8 镜）。中文字幕无乱码方块。全片 no @gmail。亲眼复验（ZH land 联络表 + 1-8 原始帧）：1-8 hero ¥0（负数销账）、学生已提交 9、已通过徽章橙框；无负数、无 beta 控件；注册号画面 no @gmail、邀请码打码、SPECIMEN 样件；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。1-8 同帧「10→30 提额待审」横幅＝基线真实背景态（verify #13），与 ch1 叙事不矛盾（ch8 叙事矛盾由 §三.7 另处理）。

## ch3 §三.8（节奏 3-1/3-8）+ §四（草稿残留）+ §一（工作台 v185，返工第30趟 2026-10-12 · 定版重录）
前置同 EN 段：ch3 state 章 v185 底座四语横竖定版重录。§三.8 节奏＝rec.mjs 加 `preOff`（导航/加载/真提交放镜外跑，字幕窗口里字幕说的东西占 ~100%）：3-1 去 openWizard、移到 3-2 offCamera pre → 3-1 全窗口框按钮、3-2 开录即向导；3-8 真 submit+等 app_no 放 offCamera → 开录 app_no 已在画面。§四＝每变体前后跑 st-ch3-cleanup 还原 pt-01 基线草稿 + 真 submit 后即 mark-test，收工 verify #17 PASS。§一＝3-9 卡「Invested on this student: ¥0」无负数。中文 UI 字幕四语各自对照。

| 镜 | 中文字幕（未改） | 高亮区 DOM 实际文字（v185 真帧） | 同一件事？ |
|----|----------|---------------------|-----------|
| 3-1 | 点「提交新学生推荐」。 | `.partner-add-student-btn`「提交新学生推荐」（全窗口高亮） | 是 |
| 3-2 | 第一步，申请计划：开学季、资助方式、学历层次和专业。 | 向导 step1 层次六卡 + 高亮「学期/Semester」选择框 `#wzSemStart` | 是 |
| 3-3 | 第二步，学生档案，按护照填写。 | 向导 step2：高亮「出生日期」行（演示 Demo Aisha，护照 DE1234567 样号） | 是 |
| 3-4 | 第三步，上传材料。 | 向导 step3 `.mat-grid` 高亮护照上传槽 | 是 |
| 3-5 | AI 预检在学校看到之前就把问题指出来。 | 琥珀「预检提醒」条：成绩单下半部分模糊——请上传更清晰版本 + sticky「⚠ AI 标注 1 份」（产品渲染） | 是 |
| 3-6 | 护照姓名核对当场发现拼写不一致。 | 护照卡姓名核对琥珀条（不一致提醒） | 是 |
| 3-7 | 随时退出，草稿存在云端。 | 退出弹窗高亮「存草稿并退出」 | 是 |
| 3-8 | 确认提交，学生拿到申请编号。 | `.student-app-id-num`「你的申请编号 · MH-xxxxxx」（Demo Aisha·#10；§三.8 修后全窗口在画面） | 是 |
| 3-9 | 从现在起，这名学生与你绑定。 | `.partner-student-status-pending`「已提交·等待平台审核」（基线生卡；同卡「Invested ¥0」无负数） | 是 |

- 时长：land 70.52s / port 70.46s（9 镜）。横竖 2 片 res OK + audio yes，no @gmail，9 镜 hl 全 resolve。亲验同 EN：3-1 全程框按钮、3-8 app_no 全窗口、3-9 ¥0 无负数、演示生无真 PII、无 beta、页头平台 WhatsApp/Email 不遮。

## ch7 §二.3（7-1 两段高亮）+ §三.5（7-4 字幕对账）+ §一（工作台 v185，返工第31趟 2026-10-12 · 定版重录）
前置：ch7 是 state 章（7-0 真付 ¥0）。v185 底座定版重录。§二.3＝7-1 高亮改两段（先框揭晓校名条 `.admission-id-tag--unlocked`、再框下载钮）；§三.5＝7-4 字幕由「已入学，完成。」改成与卡状态行逐字一致的「录取完成。」（卡状态行 `.partner-student-issue` 稳定真显「⏳ 录取完成」；卡徽章蓝「材料已通过·匹配中」＝已知产品问题，根因 s.status 读废弃列 students.stage 恒 NULL，留 SUMMARY）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 7-0 | 输入优惠码，应付 0 元。不收中介费，不收报名费。 | `.payment-amount-value`「¥0.00」（应付总额；下方 ¥3,000.00 删除线 · MAXHOUSE −¥3,000.00） | 是 |
| 7-1 | 校名揭晓，录取通知书就在这里下载。 | 两段：①`.admission-id-tag--unlocked`「🔓 演示大学 · Demo University · 📍 Wuhan / 武汉 · SCH-1AD6C8」(揭晓校名条) ②`.admission-doc-btn-letter`「录取通知书 · Official PDF ⬇」(下载钮) | 是（两段先校名后下载） |
| 7-2 | JW202 同样在这里。 | `.admission-doc-btn-jw`「JW202 Form · 签证申请用 ⬇」 | 是 |
| 7-3 | 平台替你把学生录入学校自己的报名系统。 | `.offer-progress`「✓接受 offer · ✓学校发放录取通知书 · ✓学校发放 JW202 表 · ✓入学」(建档进度条) | 是 |
| 7-4 | 录取完成。 | `#gp1-74-card` 内状态行「⏳ 录取完成 · MSc Mechanical Engineering · 1w ago」（整卡高亮；卡「Invested ¥0」无负数） | 是（字幕=状态行逐字） |

- 时长：land 43.997846s / port 43.244172s（5 镜）。横竖 2 片 res OK + audio yes，no @gmail，5 镜 hl 全 resolve（7-1 含 hl2）。亲验 zh-land 联络表：7-0 ¥0 橙框、7-1 校名条揭晓、7-4 状态行「录取完成」= 字幕逐字、「Invested ¥0」无负数、页头平台 WhatsApp/Email 不遮。
- 记账（留业主·已知产品问题）：7-4 卡徽章「材料已通过·匹配中」对已入学生恒显矛盾（根因 students.stage 恒 NULL），未改产品码（§三.5 兜底），留 SUMMARY。

## ch8 §三.7（横幅：录前 scoped 撤待审提额）+ §一（工作台 v185，返工第32趟 2026-10-13）
处理同 REVIEW-en-shots 的 ch8 节：录前 scoped 置该 pending quota_request `status='approved'`（decided_at NULL）→ 去横幅；8-1 字幕随 §11 改为述屏真有的「STUDENTS SUBMITTED 9」；8-4 改调产品自身 `_qrApplyBanner` 喂样例（§8 先例），中文横幅走产品真中文渲染。录后 restore 回 pending。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字 | 同一件事？ |
|----|----------|---------------------|-----------|
| 8-1 | 你已提交九名学生。 | `.partner-stats-hero-card`「已提交学生总数 · 9」（无提额横幅；同屏 ¥0 无负数、漏斗 9→3→2→1·5 offer·人均 0.6） | 是 |
| 8-2 | 在这里申请提额。 | `.modal-bg.show .modal-body`「推荐名额已用完 · 当前 9/10 席已用。可向平台申请提额，批准后立即生效。」+ 表单 | 是 |
| 8-3 | 填预计人数，平台 2 个工作日内审核。 | `.modal-bg.show .btn-primary`「提交申请」（表单已填目标 30 + 理由；不真提交） | 是 |
| 8-4 | 已批，名额随业绩增长。 | `#qrPendingBanner`「✓ 提额申请已批准：配额已调整为 30 席。」（产品自身 `_qrApplyBanner` 喂样例·绿条） | 是 |

- 时长：land 28.31s / port 28.26s（4 镜）。全 res OK + audio yes，no @gmail，4 镜 hl 全 resolve。
- 亲验 zh land 联络表四镜：8-1 无横幅框 9、8-2 真中文「推荐名额已用完」、8-4 真中文绿条「提额申请已批准：配额已调整为 30 席」；¥0 无负数、演示生无真 PII、无 beta。收工 verify 17/17 PASS。

## ch5 定版重录（两态·v185，返工第33趟 2026-10-13 · 落 §三.3 5-2 + §三.4 5-4 真态 + §三.8 5-1 + §一）
前置：ch5＝材料退回章（guide-pt-03 Islam Rahim）。此前 trip24 只 banked 5-2 新字幕（过渡版）、trip25 只落 5-4 真态机制与置态/复位脚本（帧捕获明文延后至 ch5 定版重录）。本趟缺陷2 已 v185 修好上线（RULING-20261012d/e），对已修数据**两态定版重录全章**：5-1/5-2/5-3 在退回基线录、5-4 在 apply `st-pt03-reupload` 后单录，由 `prod-ch --tags` 按镜序拼成一章（rec 全程只读，DB 置态/复位走 db-run.sh，录后 reset 回退态、verify 17/17 守住）。工具：rec.mjs 加 `--only`/`--tagsuffix`、prod-ch.mjs 加多 tag 拼章、gp1-finish.mjs chapterShotDurs 合并 companion `b` out 目录。
- **§三.4（5-4 真态·零改产品码）**：靠产品自己的 0104 supersede——pt-03 真·新建一行更正版 transcript（uploaded_at 更晚、无新裁决）→ `get_partner_student_doc_statuses` 不再返回 reject → 详情弹窗 transcript 槽 `slot.status` 真变 `reviewing`、徽章真变 `.badge-reviewing`、矩阵「Awaiting initial review」。非前端伪造（旧 setInterval 改字已删）。
- **§一**：5-1 工作台背景 v185，`Invested on this student: ¥0` 无负数（缺陷1 销账）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 5-1 | 有材料被退回，打开学生详情。 | `#__ch5card`（Islam Rahim 学生卡）+ 卡「Invested ¥0」（无负数） | 是 |
| 5-2 | 成绩单被退回，迈克豪斯审核团队要求修改。 | `.reviewer-row-rejected`「Maxhouse review team · 要求修改/Modification requested」（材料「成绩单 · REJECTED」；"Maxhouse review team" 为产品 LL 动态串英文回退，D-18-4 记账） | 是 |
| 5-3 | 上传修正后的文件。 | `.replace-box-rej`「重新上传新版本」换版框 + 暂存样件「SPECIMEN-e…」 | 是 |
| 5-4 | 回到审核中，不用整份重交。 | `#studentDetailModal .badge-reviewing`「审核中」+「成绩单 · 2 个文件已上传」+ 矩阵「⚙ 系统 · 等待初步审核」（真·中文本地化；同帧无 REJECTED） | 是 |
- 时长：land 36.82s / port 36.77s（4 镜）。8 片（四语横竖）全 res OK + audio yes；8 录屏 4 镜 hl 全 resolve、零 MISS；全片 DOM 扫描 **no @gmail**。
- 逐张亲眼复验（EN land 4 镜原始帧 + 四语 land/port 联络表）：5-1「Invested ¥0」无负数（§一/缺陷1 销账）；5-2 框住「Modification requested」退回行（§三.3 达标）；5-4 产品**真·审核中**徽章 REVIEWING + 「Awaiting initial review」（非前端伪造，§三.4 达标）；演示生 Islam Rahim 无真 PII；无 beta/内测/test 控件；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。
- 记账：录前 apply `st-pt03-reupload`（新建 transcript v2）、录后 `st-pt03-reupload-reset-cleanup` 删 v2 回退态；开工+收工 verify **17/17 PASS 0 FAIL**，baseline 守住（scoped 复位，无全量 rebuild）。ch5 v1 在 `_v1/` 留底、dist 覆盖为定版 v2。全片不重拼（待全部工作台章完后统一拼）。

## ch10 §一（设置章·读-only·v185 工作台背景定版重录，返工第35趟 2026-10-13）
> ⚠ **本节（含下表 10-2/10-3/10-4 三行）已被第 48 趟（第三轮返工 RULING-20261013b §三.10）取代**——第二版（trip35）虽已换 v185 底座重录，但第三轮裁决要求十章全部用 v185 定版重录一次、不沿用任何旧录像，并补 §三.7 去提额横幅 + §三.9 俄法章节条实帧复验；见文末「ch10 §三.10」节。
ch10＝设置章（账户/语言/退出），3 镜 10-2/10-3/10-4，全程在已登录 hub 上高亮设置菜单项·读-only·零写库·无弹窗置态。review1 未标 ch10 任何字幕缺陷→字幕/高亮一字未动；review1 §一列 ch10 为「背景含工作台数字」章，v184 缓存帧 hero 有负数/漏斗，v185 漏斗修复上线后须 v185 重录使背景数字落定版。本趟纯换录制底座 v184→v185 重录 ch10 3 镜 × 四语 × 横竖＝8 片覆盖 dist。中文 UI 全本地化（账户设置/退出登录/章节条「第 10 章 · 账户、语言、安全」）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 10-2 | 账户设置在齿轮里。 | `#settingsMenu [onclick*="openAccountSettings"]`「⚙ 账户设置」（设置下拉 账户 区·齿轮图标项） | 是 |
| 10-3 | 四种界面语言。 | `.lang-switcher`「EN · 中 · РУ · FR」四语切换按钮组（下拉 语言 区） | 是 |
| 10-4 | 共用电脑时记得退出。 | `[onclick*="settingsSignOut"]`「⟶ 退出登录」（设置下拉底部红色退出项） | 是 |

- 时长：land 16.33s / port 16.32s（3 镜）。8 片（四语横竖）全 res OK + audio yes；8 录屏 3 镜 hl 全 resolve、零 MISS；全片 DOM 扫描 **no @gmail**。
- 逐张亲眼复验（zh land 联络表）：背景 hero「TOTAL PAYMENTS PROCESSED ¥0」**无负数**（缺陷1 销账，§一达标）、「STUDENTS SUBMITTED 9」；下拉三项高亮逐镜对账「是」；Demo Agency 无真 PII、邮箱掩码（no @gmail）；无 beta/内测/test 控件；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。
- 记账：ch10 读-only，开工+收工 verify **17/17 PASS 0 FAIL**，baseline 全程守住（零置态/零写库）。ch10 v1 早在 `_v1/` 留底、dist 覆盖为定版 v2。全片不重拼。

## 开场快剪 OP-3 / OP-4 / OP-5（review1 §五，返工第36趟 2026-10-13） ⟶ **已被第50趟（第三轮 OP 重做·新素材）取代**
做法同 trip26 OP-2、同 EN 本趟（见 REVIEW-en-shots.md 开场快剪 OP-3/4/5 段）：卡前 2.5s 满屏卡面→切对应镜真实画面（静音·配音续·底叠重点标题条），卡总时长/配音不变；按镜号从 ch3/ch7 的 zh timeline 取窗；OP-4 定格 ts≈4.5 干净 ¥0 发票避 beta 吐司；tpad 补满 30fps CFR。

| 镜 | 字幕原文（配音，不改） | 快剪后画面（b-roll 帧 DOM） | 同一件事？ |
|----|----------|---------------------|-----------|
| OP-3 前 2.5s | 学生归你，没人绕开你 ／ 一旦提交，这名学生就与你绑定…平台永远不会抢走你的学生。 | 重点②卡满屏（橙圈 2 + 中文标题/正文） | 是 |
| OP-3 2.5s~尾 | （同句配音续） | ch3 3-8：演示生 Demo Aisha 详情「您的申请编号 **MH-M4S9FH**」（橙框）· 材料审核中 · 实时监控中 · #10 Demo Aisha·Pakistan·bachelor·2026-fall，底叠「② 学生归你，没人绕开你」 | 是 |
| OP-4 前 2.5s | 学生不交平台费，你的服务费全归你 ／ 没有平台费，没有报名费…你与学生约定的服务费全部归你。 | 重点③卡满屏（橙圈 3 + 中文标题/正文） | 是 |
| OP-4 2.5s~尾 | （同句配音续） | ch7 7-0 定格：付款单「应付总额 **¥0.00**」· ¥3,000·MAXHOUSE −¥3,000 · 申请人/付款人 `agency.demo@example.com` · MH-NEPTRN · SCH-1AD6C8，底叠「③ 学生不交平台费…」 | 是（¥0 全程在画面） |
| OP-5 前 2.5s | 奖学金学校亲自填，通知书 JW202 直发，学校系统平台代录 ／ 录取通知书由学校亲自填写…你下载后转交学生。 | 重点④卡满屏（橙圈 4 + 中文标题/正文） | 是 |
| OP-5 2.5s~尾 | （同句配音续） | ch7 7-1：录取详情·揭晓校名条 演示大学·Wuhan/武汉·SCH-1AD6C8（橙框）· 下载钮「录取通知书 Official PDF」↓（橙框）· 校名已揭晓·联系方式，底叠「④ 奖学金学校亲自填…」 | 是 |

- 亲验（ZH land OP-3 尾帧＝真 app_no MH-M4S9FH）：中文本地化、无负数、无 beta/test、演示生无真 PII、邮箱掩码 no @gmail、双盲守住（校名揭晓＝付款解锁后合法态）、标题条＝ZH OP 卡标题/ED-1 回顾一字一致。卡总时长不变（ZH OP-3 16.0 / OP-4 9.1 / OP-5 18.0s），配音未动。

## ch1 §三.10 + §三.7 + §三.9（第三轮返工 · RULING-20261013b，第39趟 2026-10-13 · v185 定版重录·不沿用旧录像）
RULING-20261013b §三.10 要求十章全部用 v185 重录、不沿用旧录像。本趟 ch1 整章中文横竖重录。ch1 第 1～7 镜＝注册/入驻 UI（产品渲染·零写库），review1/本轮未标 ch1 字幕缺陷→**字幕一字未改**。
- **§三.7（去提额横幅）**：1-8 露工作台顶部，v185 基线 pending quota_request→顶部恒显 amber「Quota raise pending: 10→30」。录前 `st-ch8-quota-off`、录后 `st-ch8-quota-restore`，收工 verify #13 回 pending、17/17 PASS。本趟 1-8 已无横幅。
- **§三.9（章节条）**：zh 章节条左标签「合作伙伴端」（不在 §三.9 改动范围，照旧）；ru「Центр партнёров」、fr「Espace partenaires」为本轮改动。
- 1-8 hero：`TOTAL PAYMENTS PROCESSED ¥0`（无负数，缺陷1 销账）、`STUDENTS SUBMITTED 9`、「已通过」徽章橙框。
- 时长：land 49.44s / port 49.49s（8 镜）。横竖 2 片 res OK + audio yes，全片 no @gmail，8 镜 box 全 resolve。
- 亲眼复验（ZH 共享 EN land 1-8 原始帧论据·背景数字与语言无关；ZH land/port 联络表）：1-8 hero ¥0、无横幅、STUDENTS 9、已通过徽章橙框；中文 UI 本地化（合作伙伴端/章节条「第 1 章」）；无 beta/内测/test、¥0 无负数；注册段邀请码打码、SPECIMEN 样件、无真 PII；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。hero 卡部分 LL 动态串英文回退＝D-18-4 照录不补。
- 联络表：`~/mh-jobs/shots/GP1/zh/ch1-contact-{land,port}-zh.png`（四语全部用本趟成片重新生成）。

## ch3 §三.3 + §三.4 + §三.8 + §三.7 + §三.10（第三轮返工 · RULING-20261013b，第40趟 2026-10-13 · v185 定版重录）
ch3 四语横竖 8 片 v185 重录（做法与根因同 REVIEW-en-shots.md 对应节）。中文镜本趟落 §三.3（3-3 preOff→停在档案字段）、§三.4（3-9 框刚提交的 Demo Aisha #10 卡）、§一（¥0 无负数）、§三.7（去提额横幅）。§三.8 俄法专项，中文 3-1 按钮本已逐字对（界面「提交新学生推荐」）不改。

| 镜 | 字幕原文（配音·ZH·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 3-1 | 点「提交新学生推荐」。 | 橙环框「+ 提交新学生推荐」按钮（引号内＝按钮文字逐字一致） | 是 |
| 3-3 | 第二步，学生档案，按护照填写。 | 第二步「档案」激活；橙环框「出生日期」日期框，右侧「护照号」可见（档案字段，非表单底/个人陈述） | 是 |
| 3-9 | 从现在起，这名学生与你绑定。 | 橙环框 #10「Demo Aisha」整卡（Documents under review · Pakistan · bachelor · Invested ¥0），其下 #9 Serikova 未框 | 是（刚提交即绑定＝#10 Demo Aisha） |

- §四.5：ch3 无付款/内测元素；8 片 DOM 全 no @gmail；无 beta/test；¥ 金额皆正数或 ¥0（非负）；演示生/机构无真 PII；页头平台联系方式不遮（D-14-3/D-15-1）。
- 时长（秒）：land zh 59.92；port zh 59.83。联络表 `~/mh-jobs/shots/GP1/zh/ch3-contact-{land,port}-zh.png`。

## ch4 §三.10 + §一（第三轮返工 · RULING-20261013b，第41趟 2026-10-13 · v185 定版重录·不沿用旧录像）
ch4＝具名邀请（委托学生自传）章（state 章：pt-04 置 intake_mode='delegate' + 必传材料 4/4，4-5 真 submit；每变体录前 `st-pt04-docs-full.sql` 置态、录后 `st-pt04-reset-cleanup.sql` scoped 复位，不动 app_no=MH-EXET28、不跑全量 rebuild，D-12-2）。review1/review2 未标 ch4 字幕缺陷→**字幕/高亮一字未改**，纯按 §三.10 v185 重录四语横竖 8 片覆盖 dist。
- **§一（负数销账·核心）**：第二版「照原版入拼」沿用 v184 旧录像，英文 4-4/4-5 委托卡「Invested ¥-3,000」为负（漏斗缺陷1，v185 已修）。本趟 v185 重录后四语 4-4/4-5 页面金额＝**¥0（无负数）**——亲帧 ZH land 4-4 f00215「该学生已投入：¥0」、EN land 4-4 f00215「Invested ¥0」、RU land 4-4 f00214「Вложено ¥0」、FR land 4-4 f00212「Investi ¥0」。
- **§三.7 N/A**：ch4 全 5 镜在工作台已发邀请/委托卡/学生卡区（列表中段），不露工作台顶部 hero→无提额横幅（亲帧 EN land 4-1 f00025，header 与内容间无 amber 横幅），不需 st-ch8-quota-off。
- **§三.9**：ru 章节条＝「Центр партнёров」、fr＝「Espace partenaires」（trip38 已改 overlay，本趟继承）；zh＝「合作伙伴端」、en＝「Partner Hub」。联络表实帧亲验。

| 镜 | 字幕原文（配音·中·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 4-1 | 材料太多收不过来？让学生自己传。 | 橙环框「✉ 邀请学生自传」按钮 | 是 |
| 4-2 | 填学生邮箱和你们定好的计划，发送。 | 邀请弹窗：姓名「Aizhan Serikova」+邮箱「aizhan.demo@example.com」（演示号·no @gmail） | 是 |
| 4-3 | 可以复制链接，也可以重发。 | 橙环框「已发邀请」行：Aizhan Serikova · agency.demo@example.com · 已发送/已注册（复制链接/重发） | 是 |
| 4-4 | 学生注册上传，你看进度。 | 橙环框委托卡：委托·学生自传 / 必传材料 3/4 / 时间线 邀请发出→学生注册 2026-10-12→材料传齐 已传 3/4→你提交申请（等你提交） | 是 |
| 4-5 | 提交权在你手里，只有你能提交申请。 | 橙环框「提交申请」按钮（必传材料 4/4·由灰变绿可点） | 是 |

- §四.5：ch4 画面＝登录（offCamera）+ 工作台邀请区 + 委托卡；无付款/内测元素；8 片 DOM 全 no @gmail（aizhan.demo@/agency.demo@example.com）；无 beta/test；¥＝增值服务「¥1,500/¥600/¥4,500 起」（正数）与「已投入 ¥0」（非负）；演示生/机构无真 PII；页头平台联系方式不遮（D-14-3/D-15-1）。
- 时长（秒）：land zh 42.96；port zh 42.86。联络表 `~/mh-jobs/shots/GP1/zh/ch4-contact-{land,port}-zh.png`。

## ch5 第三轮返工（RULING-20261013b §三.2(a)+§三.7+§一·第42趟 2026-10-13 · v185 两态定版重录）
取代上方 trip33「ch5 定版重录」节的 5-1 行。本趟 5-1 改从通知铃取镜：铃内 urgent 退回通知标题本地化「你的学生有材料被退回」与字幕同义→字幕一字不改、不重配音。录制层给 `#stuNotifList` 补产品自带 `.stu-notif-list` 启用滚动（产品 bug 入 SUMMARY）+ preOff。§三.7 land 5-1 去「Quota raise pending」横幅、录后 restore。§一 工作台 ¥0 无负数。§三.8 N/A。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（字幕中点+亲帧） | 同一件事？ |
|---|---|---|---|
| 5-1 | 有材料被退回，打开学生详情。 | 通知铃 urgent 通知标题「你的学生有材料被退回」+ desc「Rahim Islam 的「transcript」被退回。原因：…」（理由 EN 回退 D-18-4） | 是 |
| 5-2 | 成绩单被退回，迈克豪斯审核团队要求修改。 | `.reviewer-row-rejected`：⚠ Maxhouse review team · 要求修改（材料 Academic transcript · 已拒绝/REJECTED） | 是 |
| 5-3 | 上传修正后的文件。 | 换版区「上传修正版」红钮 + 提示 | 是 |
| 5-4 | 回到审核中，不用整份重交。 | transcript 槽徽章 `.badge-reviewing`＝审核中；矩阵「⚙ 系统 · 等待初步审核」（真·0104 supersede 态，非伪造） | 是 |

- §四.2：5-1 高亮可见 ~88%（≥70%）；5-2/5-3/5-4 弹窗内≥90%。§四.5：beta/test/负数 0 命中；MASK_INIT 遮 @gmail；页头平台不遮（D-14-3/D-15-1）。
- 亲帧复验：ZH land 5-1(f22 铃+「你的学生有材料被退回」高亮·无横幅·¥0·已提交 9)/5-4(ch5b 审核中徽章) + zh land 联络表四镜。演示生 Islam Rahim 无真 PII、双盲守住。
- 时长：land 32.35s / port 32.36s。

## ch6 §三.10 + §三.7 + §一 + §三.9（第三轮返工 · RULING-20261013b，第43趟 2026-10-14 · v185 定版重录·不沿用旧录像）
ch6＝盲态进度章：读-only（开委托生 Bilal 详情→两盲 offer 卡；开盲态录取弹窗；6-7 高亮「接受该专业」affordance 不点、不写库）。§二 trip21(D-21-1) 已执行，本趟按 §三.10 用 v185 重录整章四语横竖（8 片）。字幕/高亮一字未改。
- §一（负数销账·复核）：v185 base 探针各镜负数 (none)；§四.5 in-frame 扫描全 CLEAN。
- §三.7（提额横幅）：ch6 各镜 `#qrPendingBanner` 在屏→录前 st-ch8-quota-off 去横幅、录后 restore（verify#13 回 pending）。亲帧 ZH land 6-1 contact 工作台顶部无「Quota raise pending」横幅。
- §三.8 N/A（无引号引用按钮名）。
- §三.9：ru「Центр партнёров」/fr「Espace partenaires」（trip38 overlay 继承）；zh 章节条＝「合作伙伴端」。

| 镜 | 字幕原文（配音·ZH·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 6-1 | 两所学校录取了这名学生。 | 委托生 Hussain Bilal 详情·橙环框两盲 offer 卡区（SCH-1AD6CR·MSc Computer Science·MATCHED / SCH-B6X61C，均盲码无校名） | 是 |
| 6-2 | 解锁前能看到专业、学费、奖学金——都是学校亲自填的——但看不到校名。 | 录取弹窗·橙环框盲码「SCH-1AD6CR」；弹窗内 MSc Computer Science·学费/奖学金行，无校名 | 是 |
| 6-3 | 比较之后，接受你中意的那份。 | 橙环框奖学金行「Full scholarship (tuition waived)」（盲态·学校所填·LL 英文回退 D-18-4） | 是 |
| 6-7 | 接受这个专业——开学日期和奖学金都在这里。 | 橙环框「✓ Accept this programme」绿钮（旁开学日期 2027-09-01 + 奖学金，不点不写库） | 是 |

- §四.5 整镜扫描（in-frame·MASK+HIDE）：四语横竖全 CLEAN——无 beta/placeholder/test/内测/测试、无负数、无真邮箱。演示生 Hussain Bilal 无真 PII、双盲守住（全程盲码 SCH-xxxxxx）。页头平台 WhatsApp/Service@maxhouses.net 不遮（D-14-3/D-15-1）。
- 时长（秒）：land zh 26.28；port zh 26.36（全 res OK + audio yes + 4 镜 resolve）。
- 联络表：`~/mh-jobs/shots/GP1/zh/ch6-contact-{land,port}-zh.png`。

## ch7 §三.5 + §三.6 + §三.7 + §一（第三轮返工 · RULING-20261013b，第45趟 2026-10-14 · v185 定版重录·state 章 pt-07/08 置态）
ch7＝通知书/JW202/建档章。state 章：每变体 st-pt07-pay-cleanup + st-pt08-jw202 置态，7-0 真付 ¥0 优惠码路，录全 8 变体后 st-pt0708-reset-cleanup + st-ch8-quota-restore 复位。字幕不变。
- **§三.5（7-0 beta 提示）**：7-0 ¥0 发票 dwell 在镜内（橙框「¥0.00」≥2s）；真付确认点击+等待（产品付款成功「Paid (beta placeholder)」浮条寿命 ~2.6s）全在镜外（actOff）跑，toast 消失后才恢复录制 → 内测 toast 帧永不入片。双保险 rec.mjs HIDE_INIT 遮含 beta/placeholder/内测/测试 的浮条。真付 DB 照写。
- **§三.6（7-4 只框状态行）**：7-4 橙环框列表卡状态行 `.partner-student-issue`（经 `#gp1-74-issue` rAF 贴合），box≈701×100（状态行高，非整卡），不框徽章。字幕不变。
- **§三.7（提额横幅）**：ch7 列表顶 `#qrPendingBanner` 在屏→录前 st-ch8-quota-off 去横幅、录后 restore（verify#13 回 pending）。
- **§一（负数销账）**：7-0 折扣行「MAXHOUSE −¥3,000.00」＝优惠码抵扣（白名单）；应付 ¥0.00；卡「Invested …¥0」无负数。§四.5 扫描 CLEAN。
- **§三.9**：zh 章节条＝「合作伙伴端」（不在 §三.9 范围、不动）；联络表亲验 zh land/port 章节条＝「合作伙伴端」。

| 镜 | 字幕原文（配音·ZH·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 7-0 | 输入优惠码，应付 0 元。不收中介费，不收报名费。 | 付款弹窗·橙环框应付大字「¥0.00」（下方 ¥3,000.00·MAXHOUSE −¥3,000.00 抵扣行；Applicant/Paid by = agency.demo@example.com 脱敏） | 是 |
| 7-1 | 校名揭晓，录取通知书就在这里下载。 | 录取弹窗：先框揭晓校名条，后框「下载录取通知书」钮（两段高亮） | 是 |
| 7-2 | JW202 同样在这里。 | 橙环框「JW202」下载钮 | 是 |
| 7-3 | 平台替你把学生录入学校自己的报名系统。 | 橙环框建档进度（MSc Mechanical Engineering + 清单含 Enrollment ✓） | 是 |
| 7-4 | 录取完成。 | 橙环框列表卡状态行「录取完成 · MSc Mechanical Engineering · …」（只框状态行，不框整卡/徽章） | 是 |

- §四.5 整镜扫描（in-frame·MASK+HIDE）：zh 横竖全 CLEAN——beta/placeholder/test/内测/测试 0 命中（含付款成功 beta 浮条 HIDE 遮）、负数 0（抵扣行白名单）、真邮箱 0。页头平台不遮（D-14-3/D-15-1）。
- 时长（秒）：land zh 38.51；port zh 38.59（全 res OK + audio yes + 5 镜 resolve）。
- 联络表：`~/mh-jobs/shots/GP1/zh/ch7-contact-{land,port}-zh.png`。

## ch8 §三.7（照 D-32-1）+ §一 + §三.9 + §三.10（第三轮返工 · RULING-20261013b，第46趟 2026-10-14 · v185 定版重录·名额与提额章）
ch8＝名额与提额章（Quota & requesting more）。**零 DB 写**：8-1 读工作台统计卡；8-2/8-3 用 `pre` 调产品 `_qrOpenRaise({used:9,quota:10})` 开弹窗、填数量 30+理由但**不点提交**；8-4 调产品自身 `_qrApplyBanner` 喂样例已批数据渲染真绿条（§8 先例·不写库）。字幕四语未改（review1/review2 未标 ch8 字幕缺陷；trip32 已 bank）。
- **§三.7（提额横幅·照 D-32-1）**：基线有 1 张 pending `quota_request`（verify#13）→ 工作台顶部恒显 amber「Quota raise pending: 10→30」，与 8-2/8-3「才去申请」叙事矛盾 → 录前 `st-ch8-quota-off`（该行 status pending→approved·decided_at 保持 NULL → 产品 `_qrApplyBanner` 判非 pending 且无裁决 → box 清空无横幅；`partners.referral_quota` 不动仍 10、hero 数字不变），录后 `st-ch8-quota-restore` 还原 pending（收工 verify#13 回 pending）。读-only：一次 quota-off → 录全 8 变体 → 一次 restore。
- **§一（负数销账）**：v185 base 工作台背景「TOTAL PAYMENTS PROCESSED ¥0」无负数（亲帧 EN land 8-1 f15 / 8-4 f157）。§四.5 in-frame 扫描四语横竖负数全 CLEAN。
- **§三.9**：ru 章节条「Центр партнёров」/fr「Espace partenaires」（trip38 overlay 继承·联络表实帧亲验）；zh「合作伙伴端」/en「Partner Hub」不动。
- **§四.4（引用按钮名逐字）N/A**：ch8 四镜字幕均未用引号引界面按钮/标签名（8-2「Request a raise right here」、8-3 描述动作、8-4「Approved…」），无逐字比对对象。

| 镜 | 字幕原文（ZH·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 8-1 | 你已提交九名学生。 | 工作台统计卡「STUDENTS SUBMITTED 9」橙环框（右侧「TOTAL PAYMENTS PROCESSED ¥0」无负数；§三.7 去横幅后 header 与内容间无 amber「Quota raise pending」横幅） | 是 |
| 8-2 | 在这里申请提额。 | 「Referral quota reached · 当前 9/10 席已用」提额弹窗 body 橙环框（zh 本地化「推荐名额已用完」；ru/fr 弹窗标题 EN 回退 D-18-4） | 是 |
| 8-3 | 填预计人数，平台 2 个工作日内审核。 | 提额弹窗「Submit request / 提交申请」提交钮橙环框（目标名额填 30 + 理由；高亮全程贴合提交钮，填表在后半段完成——亲帧 zh-port f148 默认 15、f181 已填 30+理由） | 是 |
| 8-4 | 已批，名额随业绩增长。 | 产品自身 `_qrApplyBanner` 喂样例渲染绿条「Quota raise approved: your quota is now 30 seats」橙环框（§8 先例·零写库；zh 本地化「提额申请已批准：配额已调整为 30 席」；ru/fr EN 回退 D-18-4） | 是 |

- §四.2：8-1/8-2/8-4 高亮全程在视口内≥90% 可见、dwell≥70%；8-3 高亮＝提交钮，f148 与 f181 皆橙框在屏（highlight 全程≥90%），填表值 15→30 在窗口后半完成（caption 述「填预计人数」＝表单动作，与画面一致）。
- §四.5 整镜扫描（in-frame·MASK+HIDE 复现录制层·`_scan-ch8-forbidden.mjs`·4 语×2 视口）：**ALL CLEAN**——beta/placeholder/test/内测/测试 0 命中、负数 0 命中、真邮箱 0 命中（@gmail MASK→agency.demo@example.com）。页头平台 WhatsApp/Service@maxhouses.net 不遮（D-14-3/D-15-1）。
- 亲帧复验：EN land 8-1(f15 9 学生·¥0·无横幅)/8-4(f157 产品绿条非伪造·¥0)；ru land + fr land + zh port 联络表逐镜复验（章节条 ru/fr 本地化、zh 弹窗全中文、ru/fr 弹窗与绿条 EN 回退 D-18-4 照录）；Demo Agency 无真 PII。
- 时长（最终成片，秒）：land 28.20 / port 28.24。8 片全 res OK + audio yes + 4 镜 box 全 resolve。
- 联络表（四语全部用本趟最终成片重生成）：`~/mh-jobs/shots/GP1/zh/ch8-contact-{land,port}-zh.png`。

## ch9 §三.10（+§三.7+§一+§三.9）（第三轮返工 · RULING-20261013b，第47趟 2026-10-14 · v185 定版重录·增值服务章·读-only）
ch9＝增值服务章（增值服务 / value-added services）。**读-only·零 DB 写**：CONTEXT['9'] 仅把首张推荐生列表卡的 `.partner-premium-block` 滚到视口中心，逐镜高亮服务行，全程零点击、零写库。字幕四语未改（review1/review2 未标 ch9 缺陷；§三.10 仅要求 v185 定版重录一次）。
- **§三.10**：ch9 整章四语横竖 8 片用 v185 重录→合成覆盖 dist→四语联络表。md5 比对 dist vs `_v2/` 8 片全差异（真重录）。
- **§三.7（安全·照 ch6 读-only 先例）**：录前 `st-ch8-quota-off` 去「Quota raise pending 10→30」横幅、录后 `st-ch8-quota-restore`（verify#13 回 pending）。读-only：一次 off→录全 8 变体→一次 restore。
- **§一**：每张卡「该学生已投入：¥0」无负数（亲帧 zh land f75）；¥1,500/¥600/¥4,500 起均正数。§四.5 扫描四语横竖负数全 CLEAN。
- **§三.9**：ru 章节条「Центр партнёров」/fr「Espace partenaires」（trip38 继承）；zh「合作伙伴端」/en「Partner Hub」不动。
- **§四.4 N/A**：ch9 四语字幕均未用引号引界面按钮名（全描述性散文），无逐字比对对象。
- **§四（9-4 forbid）**：9-4 高亮行「付费曝光·未激活 / 材料够不着学校任务门槛、或提交很久没动静的学生，最适合开通」，**无「优先审核」字样**。

| 镜 | 字幕原文（ZH·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 9-1 | 可选的增值服务，用不用都行： | `.partner-premium-title`「🎁 增值服务」橙环框（右侧「该学生已投入：¥0」无负数；§三.7 去横幅后无提额横幅） | 是 |
| 9-2 | Audit 服务，解除基础版两个 offer 上限，并提供 30 天优先推荐位； | premium 第 2 行橙环框「🚀 Audit 服务 · 未激活 · 激活 ¥1,500」 | 是 |
| 9-3 | 人工搜索，由 Maxhouse 顾问为学生定制专属学校清单； | premium 第 3 行橙环框「🤝 人工搜索 · 未激活 · 激活 ¥600」 | 是 |
| 9-4 | 付费曝光，让学生进入更多学校的候选池。 | `.partner-premium-row--boost` 橙环框「📈 付费曝光·未激活·激活·¥4,500 起」（无「优先审核」字样） | 是 |

- §四.2：9-1..9-4 高亮均在滚到视口中心的 premium block 内，全程≥90% 可见、dwell≥70%；box 四镜全 resolve。
- §四.5 整镜扫描（in-frame·MASK+HIDE·`_scan-ch9-forbidden.mjs`·4 语×2 视口）：**ALL CLEAN**——beta/test/内测/测试 0、负数 0、真邮箱 0（@gmail→agency.demo@example.com）。页头平台 WhatsApp/Service@maxhouses.net 不遮（D-14-3/D-15-1）。
- 亲帧复验：zh land f75（增值服务/Audit 服务 激活 ¥1,500·该学生已投入 ¥0·章节条 合作伙伴中心）；EN/ru/fr 联络表逐镜复验。Demo 生 Serikova Aizhan / Okoye Emeka 无真 PII、双盲守住（无校名）。
- 时长（最终成片，秒）：land zh 23.80（en 22.82 / ru 26.35 / fr 24.32）；port zh 23.75（en 22.78 / ru 26.39 / fr 24.27）。8 片全 res OK + audio yes + 4 镜 box 全 resolve。
- 联络表（四语全部用本趟最终成片重生成）：`~/mh-jobs/shots/GP1/zh/ch9-contact-{land,port}-zh.png`。

## ch10 §三.10（+§三.7+§一+§三.9）（第三轮返工 · RULING-20261013b，第48趟 2026-10-14 · v185 定版重录·设置/语言/账户章·读-only·十章重录收尾）
ch10＝设置/语言/账户章，3 镜 10-2/10-3/10-4。**读-only·零 DB 写**：CONTEXT['10'] 仅 `toggleSettingsMenu` 开设置下拉菜单（不开 asModal），逐镜高亮菜单项 / 顶条语言切换器，全程零点击提交、零写库。字幕四语未改（review1/review2 未标 ch10 任何镜级缺陷；§三.10 仅要求 v185 定版重录一次）。ch10 是第十章，本趟即十章全部 v185 定版重录收尾。中文 UI 全本地化（账户设置/退出登录/章节条「第 10 章 · 账户、语言、安全」）。
- **§三.10（定版重录·本趟目的）**：ch10 整章四语横竖 8 片用 v185 重录→`_prodch10.sh` 合成覆盖 dist→四语联络表。md5 比对 dist vs `_v2/` 8 片全差异（真重录；覆盖前先 cp 第二版 8 片入 `_v2/`，_v2 原无 ch10）。
- **§三.7（提额横幅）**：设置菜单浮在工作台之上·露 hero 顶部。录前 `st-ch8-quota-off` 去横幅、录后 `st-ch8-quota-restore`（收工 verify#13 回 pending）；读-only 一次 off→录全 8 变体→一次 restore。亲帧四语横竖联络表 header 与 hero 间无 amber 提额横幅。
- **§一（负数销账）**：背景 hero「总处理付款 ¥0」无负数、「学生已提交 9」；§四.5 in-frame 扫描四语横竖负数全 CLEAN。
- **§三.9**：ru 章节条「Центр партнёров」/fr「Espace partenaires」（trip38 继承·本趟联络表实帧亲验 land+port 均本地化）；zh「合作伙伴端」/en「Partner Hub」不动。
- **§四.4 N/A**：ch10 四语字幕均未用引号引界面按钮名，无逐字比对对象。

| 镜 | 字幕原文（中·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 10-2 | 账户设置在齿轮里。 | `#settingsMenu [onclick*="openAccountSettings"]`「⚙ 账户设置」橙环框（设置下拉 账户 区·齿轮项） | 是 |
| 10-3 | 四种界面语言。 | 顶条 `.lang-switcher`「EN · 中 · РУ · FR」四语切换按钮组橙环框 | 是 |
| 10-4 | 共用电脑时记得退出。 | `#settingsMenu [onclick*="settingsSignOut"]`「⟶ 退出登录」橙环框（设置下拉底部红色退出项） | 是 |

- §四.2：10-2/10-3/10-4 高亮均在打开的设置菜单内（10-3 在顶条语言器），全程≥90% 可见、dwell≥70%；box 三镜全 resolve（land 705×93 / 383×80 / 705×93；port 752×99 / 408×85 / 752×99）。
- §四.5 整镜扫描（in-frame·`_scan-ch10-forbidden.mjs`·4 语×2 视口）：**ALL CLEAN**——beta/placeholder/test/内测/测试 0 命中、负数 0 命中、真邮箱 0 命中（账户邮箱 @gmail MASK→agency.demo@example.com）。页头平台联系方式不遮（D-14-3/D-15-1）。
- 亲帧复验（四语 land+port 联络表逐镜）：设置菜单账户区邮箱掩码、Partner Code PA-E62FC6FF、机构 Demo Agency 无真 PII；三项高亮逐镜对账全「是」；¥0 无负数、无提额横幅、无 beta/内测/test；zh 菜单项全中文（账户设置/退出登录）；ru/fr 菜单项真本地化、hero 动态 LL 串 ru/fr 仍 EN 回退（D-18-4 照录）。
- 时长（最终成片，秒）：land zh 16.30（en 16.31 / ru 16.32 / fr 16.27）；port zh 16.31（en 16.31 / ru 16.23 / fr 16.31）。8 片全 res OK + audio yes + 3 镜 box 全 resolve、全片 no @gmail。
- 记账：ch10 读-only，开工+收工 verify **17/17 PASS 0 FAIL**，baseline 全程守住。ch10 v1 在 `_v1/`、v2 在 `_v2/` 留底、dist 覆盖第三轮定版。全片待 OP 重做后统一重拼。
- 联络表：`~/mh-jobs/shots/GP1/zh/ch10-contact-{land,port}-zh.png`。

## 第三轮十一项重审 · 开场 OP-1~OP-6 + 片尾 ED + 速览（当独立片查）对账（第50趟 2026-10-14 · RULING-20261013b §四.6 · 用最终成片重生成）
> 上面 trip26 OP-2 节、trip36 OP-3/4/5 节已标「已被第50趟取代」：第三轮（trip49）OP-2~5 用 v185 新素材重做、四语全片/速览/分段重拼。OP-3 中文真申请号第三轮＝**MH-5T6PPH**（证真新素材·非沿用旧录像）。
> **查法**：十章横竖联络表用 `gp1-finish --stage contact` 对**最终 dist 成片** `ch<N>-<orient>-zh.mp4` 重生成（每镜字幕中点取帧），逐张亲眼看；OP/ED 另从**最终成片 per-shot 段** `out/_book/zh/land/OP-*.mp4`/`ED-*.mp4` 抽卡帧+b-roll 中帧亲眼看；片尾二维码从**最终 ED 成片** `ED-{land,port}-zh.mp4` 抽帧 jsQR 真帧解码。

| 镜 | 卡标题/字幕（配音，不改） | b-roll/卡 真画面（亲眼） | 同一件事？ |
|----|----------|---------------------|-----------|
| OP-1 | 迈克豪斯 · 合作机构操作指南 — 为中国高校招收学生 —— 一次提交，多校录取 | 品牌卡满屏 | 是 |
| OP-2 卡 | ① 一次提交，多校同审 | 重点①卡满屏 | 是 |
| OP-2 b-roll | （同句配音续） | ch6 盲 offer 详情：录取详情 / 盲码 **SCH-1AD6C8**（pending）/ **MSc Computer Science**（专业无校名）/ 校注演示串 / 接受钮，底叠「① 一次提交，多校同审」 | 是（**双盲守住无校名**） |
| OP-3 卡 | ② 学生归你，没人绕开你 | 重点②卡满屏 | 是 |
| OP-3 b-roll | （同句配音续） | ch3 3-8 合作伙伴面板·学生 Demo Aisha：您的申请编号 **MH-5T6PPH**（橙框）· 材料审核中 · 实时监控中 · #10 Demo Aisha·Pakistan·bachelor·2026-fall，底叠「② 学生归你…」 | 是（新素材 MH-5T6PPH） |
| OP-4 卡 | ③ 学生不交平台费，你的服务费全归你 | 重点③卡满屏 | 是 |
| OP-4 b-roll | （同句配音续） | ch7 7-0 定格：录取通知书解锁费 — 应付总额 **¥0.00** · ¥3,000.00 删除线 · MAXHOUSE −¥3,000.00 · 申请人/付款人 `agency.demo@example.com` · MH-NEPTRN · SCH-1AD6C8 · 合作伙伴编号 PA-E62FC6FF，底叠「③ 学生不交平台费…」 | 是（**¥0 无 beta·无非白名单负数·邮箱 example.com**） |
| OP-5 卡 | ④ 奖学金学校亲自填，通知书 JW202 直发，学校系统平台代录 | 重点④卡满屏 | 是 |
| OP-5 b-roll | （同句配音续） | ch7 7-1 录取详情：揭晓校名条 **Demo University · 演示大学 · SCH-1AD6C8** · 下载钮 录取通知书 ↓，底叠「④ 奖学金学校亲自填…」 | 是（校名揭晓＝解锁后合法态·Demo University 演示校名） |
| OP-6 | 十个短章节 | 目录卡满屏 | 是 |
| ED-1 | 要点回顾：四条＝四条重点标题 | 片尾回顾卡四行＝ ① 一次提交，多校同审 / ② 学生归你，没人绕开你 / ③ 学生不交平台费… / ④ 奖学金学校亲自填… | 是（与 OP 卡一字一致） |
| ED-2 | 二维码 → partner-portal | **jsQR 真帧解码（land+port 均）= `https://www.maxhouses.net/partner-portal/?src=video-zh`** 逐字一致 | 是 |

**速览（trailer）当独立片查**：最终 `trailer-{land,port}-zh.mp4`（land 171.6s），镜单同 EN（OP-1~6 → 工作台/章节高亮 → ED-1/2，21 镜/5 段，§三.11 不变）。seg04 的 6-2 盲 offer 无校名、7-0 优惠码 ¥0 **无 beta**、7-1 校名揭晓（解锁后）——复用 ch7 成片同批 per-shot 段（HIDE_INIT+actOff），beta 帧从未进片。自成可独立看懂的招募片。
**整镜扫描（§四.5）**：OP/ED 卡文案受控常量、b-roll 取自各章第三轮成片（§四.5 逐章 ALL CLEAN），hi-res 亲验 ¥0 无 beta、无非白名单负数、邮箱全 example.com → **0 命中**。


## 第四轮返工 · 字幕行数表（§四.7）+ OP/ED 联络表重出（2026-10-14 第52趟 · RULING-20261014a-review3 §二.3/§二.5）
> 行数闸（§四.7）取代第三版「段时长公式」充数（裁决 §一.4）：从**最终 dist 成片**每镜字幕中点帧扫白像素量行数与底边距。自审表第 6 项改引用本表。

### 字幕行数表（10 章 × 横竖，zh）

| 镜 | 横 行/闸(≤2) | 横 底边距 | 竖 行/闸(≤3) | 竖 底边距 | 过否 |
|----|----|----|----|----|----|
| 1-1 | 1/2 | 53px | 2/3 | 62px | PASS |
| 1-3 | 1/2 | 53px | 1/3 | 90px | PASS |
| 1-5 | 1/2 | 53px | 2/3 | 62px | PASS |
| 1-6 | 1/2 | 53px | 1/3 | 91px | PASS |
| 1-7 | 1/2 | 53px | 1/3 | 91px | PASS |
| 1-8 | 1/2 | 53px | 1/3 | 90px | PASS |
| 2-1 | 1/2 | 53px | 1/3 | 91px | PASS |
| 2-2 | 1/2 | 53px | 2/3 | 62px | PASS |
| 2-3 | 1/2 | 53px | 1/3 | 91px | PASS |
| 2-4 | 2/2 | 30px | 2/3 | 33px | PASS |
| 2-5 | 1/2 | 53px | 1/3 | 91px | PASS |
| 3-1 | 1/2 | 53px | 1/3 | 91px | PASS |
| 3-2 | 1/2 | 53px | 2/3 | 62px | PASS |
| 3-3 | 1/2 | 52px | 1/3 | 89px | PASS |
| 3-4 | 1/2 | 53px | 1/3 | 91px | PASS |
| 3-5 | 1/2 | 53px | 1/3 | 91px | PASS |
| 3-6 | 1/2 | 53px | 1/3 | 91px | PASS |
| 3-7 | 1/2 | 53px | 1/3 | 91px | PASS |
| 3-8 | 1/2 | 53px | 1/3 | 91px | PASS |
| 3-9 | 1/2 | 53px | 1/3 | 91px | PASS |
| 4-1 | 1/2 | 53px | 1/3 | 91px | PASS |
| 4-2 | 1/2 | 53px | 1/3 | 90px | PASS |
| 4-3 | 1/2 | 53px | 1/3 | 90px | PASS |
| 4-4 | 1/2 | 53px | 1/3 | 91px | PASS |
| 4-5 | 1/2 | 53px | 1/3 | 90px | PASS |
| 5-1 | 1/2 | 53px | 1/3 | 91px | PASS |
| 5-2 | 1/2 | 53px | 1/3 | 91px | PASS |
| 5-3 | 1/2 | 53px | 1/3 | 91px | PASS |
| 6-1 | 1/2 | 53px | 1/3 | 91px | PASS |
| 6-2 | 1/2 | 53px | 2/3 | 62px | PASS |
| 6-3 | 1/2 | 53px | 1/3 | 91px | PASS |
| 6-7 | 1/2 | 53px | 1/3 | 91px | PASS |
| 7-0 | 1/2 | 52px | 1/3 | 62px | PASS |
| 7-1 | 1/2 | 53px | 1/3 | 90px | PASS |
| 7-2 | 1/2 | 53px | 1/3 | 91px | PASS |
| 7-3 | 1/2 | 53px | 1/3 | 91px | PASS |
| 7-4 | 1/2 | 53px | 1/3 | 91px | PASS |
| 8-1 | 1/2 | 53px | 1/3 | 91px | PASS |
| 8-2 | 1/2 | 53px | 1/3 | 91px | PASS |
| 8-3 | 1/2 | 53px | 1/3 | 91px | PASS |
| 8-4 | 1/2 | 53px | 1/3 | 90px | PASS |
| 9-1 | 1/2 | 53px | 1/3 | 91px | PASS |
| 9-2 | 1/2 | 52px | 2/3 | 62px | PASS |
| 9-3 | 1/2 | 53px | 2/3 | 62px | PASS |
| 9-4 | 1/2 | 53px | 1/3 | 90px | PASS |
| 10-2 | 1/2 | 53px | 1/3 | 91px | PASS |
| 10-3 | 1/2 | 53px | 1/3 | 91px | PASS |
| 10-4 | 1/2 | 53px | 1/3 | 91px | PASS |

**zh 行数闸汇总：ALL PASS**（横≤2 行 / 竖≤3 行 / 底边距≥8px，从最终 dist 成片 ch<N>-<orient>-zh.mp4 字幕中点帧 chromium 扫白像素量，工具 rec/_gate-lines.mjs）。

### OP/ED 联络表（从最终 OP/ED 成片 `out/_book/zh/<orient>/OP-*.mp4`·`ED-*.mp4` 重出，工具 rec/_op-ed-contact.mjs）
- 推 `OP-contact-{land,port}-zh.png` + `ED-contact-{land,port}-zh.png`（每张卡取卡面中点，OP-2~5 另取快剪 b-roll 中点，ED-2 取二维码帧）。**取代**旧 `OP2-quickcut-*` / `OP345-quickcut-*`（trip26/36 第二版图，已被第52趟取代）。
- ED-2 二维码 jsQR 真帧解码（land+port）= `https://www.maxhouses.net/partner-portal/?src=video-zh` 逐字一致。

### ⚠ 观察（第52趟发现·非 review3 字幕缺陷）：OP-2 横版 b-roll 画面拉伸 ⟶ **已於第53趟修复（见下节）**
- OP-2 的 b-roll 取自第6章画面。第6章**横版**的录制帧在 trip43 `_runch6.sh` orient 变量污染时被按**竖版视口**（405×600→1080×1600 竖）录下、真横版帧已失（第3/7章横版帧仍为正常 3000×1358，不受影响）。故 OP-2 **横版** b-roll＝竖内容被压进 1920×868 横画幅 → 横向拉伸（四语皆然）。
- **内容无误**：双盲守住（只露 SCH-xxxxxx 盲码·无校名）、¥0/申请号/揭晓等不受影响；仅 OP-2 横版这段纵横比失真。第6章**成片**（ch6-land-zh.mp4，另有正常横帧来源）与**竖版 OP-2** 均正常。
- 工装层根因＝横版 ch6 源帧已失，忠实修复需**重录第6章横版**（独立一章一趟，且须先修 `_runch6.sh` orient 污染 bug 防复发）。本趟照 §二.4 不重录、记账留后续；下趟处理。


## 第四轮返工 trip53 · OP-2 横版 b-roll 拉伸修复（2026-10-14 · RULING-20261014a-review3 §二.4 残留清零）
> 第52趟遗留的「OP-2 横版 b-roll 画面横向拉伸」本趟照裁决 §二.4「没有帧的章才重录」忠实修复——**重录第6章横版**（zh）取得正确横版帧，重出 OP。

- **根因复盘**：OP-2 的 b-roll 从 `out/zh-land-ch6/frames` 直接取原始帧（无章节条/字幕）。该目录的横版帧原被 trip43 按竖版视口（405×600→1080×1600 竖）录下，OP-2 横版把竖内容压进 1920×868 横画幅 → 横向拉伸。第6章**成片**另有正常横帧来源故不受影响。
- **本趟做法**：`_runch6.sh land:zh`（去提额横幅 → 录横版 → 复位），当前 rec.mjs TAG 已正常（`zh-land-ch6`，非 trip43 的乱码 `zh-zh-land-ch6`），**无需改 _runch6.sh**（orient 污染是 trip43 历史问题，现行代码已正）。新帧实测 **3000×1358**（正常横版），tag=`zh-land-ch6`。第6章只读（仅 quota-off/restore 单列可逆），录后 DB verify **17/17 PASS 0 FAIL**。
- **重出链**：`gp1-finish --stage bookend/film/trailer --lang zh` → 重出 OP-land/ED-land + 重拼 full-land/trailer-land（横竖两版，zh 亦重拼仅为纳入修好的 OP-2 横版 b-roll，字幕/章节一字未改）。
- **亲帧复验**：OP-2 横版 b-roll 现为正常横版（1920×1080 无拉伸）、双盲守住（只露盲码/无校名）、¥0 无负数、无 beta。时长与 trip49/52 一致（见 PROGRESS）。
- **行数表不变**：本趟零字幕改动（第6章成片未重建、仅重录原始帧），§四.7 行数表同第52趟；复核 `_gate-lines.mjs --tags zh-land-ch6` 四镜 **ALL PASS**（横≤2 行）。
- **ED-2 二维码**：重出后 jsQR 真帧解码（land+port）= `https://www.maxhouses.net/partner-portal/?src=video-zh` 逐字一致。
- **留底**：第52趟已把 full/trailer-land 覆盖为第四轮版（未先入 _v3，trip52 记账缺口，第三轮 full/trailer-land 不可逆——详 DECISIONS D-53-1）；本趟 OP-2 修复在第四轮版上继续，无新 3rd-round 文件可留底。

## 第 6 章横版新素材 §四.5 复扫（GP2-00a 补跑 · 2026-10-14）
- **背景**：第 53 趟 ch6 横版用第三轮新素材重录后，`_scan-ch6-forbidden.mjs` 的整镜禁用词复扫被记为「Supabase 登录限流未跑完」（SUMMARY-GP1 §四.5 降级）。本趟（GP2-00a）补跑。
- **工具**：`jobs/JOB-GP2/_scan-ch6-forbidden-gp2.mjs`（照裁决「每种语言只登录一次」改自 rec/_scan-ch6-forbidden.mjs：每语开一个 context 只 signInWithPassword 一次，land 扫完同页 setViewportSize→port 复跑，8 次登录降到 4 次）。扫描口径一字照原版：MASK_INIT(@gmail→agency.demo@example.com) + HIDE_INIT(遮 .cloud-offer-unlock) + BETA/NEG/REALMAIL in-frame。
- **真病根（并非限流）**：登录账号本身是 gmail；原 MASK_INIT 作为 initScript 在登录前就把 #emailInput 里的真 gmail 改写成 DEMO → 提交后 Supabase 返「Invalid login credentials」，表现得像登录卡住/限流。修法：MASK/HIDE 改到登录解锁之后再 page.evaluate 注入（要扫的被荐生详情+录取弹窗在注入之后才渲染，遮罩口径不变）。记 D-GP2-1-2。
- **流程证实非空**：探针确认登录解锁后 viewReferredStudent(Bilal #4)→详情→openCloudAdmissionModal 真打开（body.innerText≈10052 字、hasAdmission=true），是非空扫描，排除「模态没开=假 CLEAN」。
- **结果（4 语 × 2 视口 · 2026-10-14 14:01，唯一一次登录/语言）**：
  - en land: CLEAN / en port: CLEAN
  - zh land: CLEAN / zh port: CLEAN
  - ru land: CLEAN / ru port: CLEAN
  - fr land: CLEAN / fr port: CLEAN
  - **SCAN_RESULT: ALL CLEAN** —— beta/placeholder/test/内测/测试 0 命中、负数金额 0 命中、真邮箱 0 命中。页头平台 WhatsApp +49 152 24910967 / Service@maxhouses.net 不遮（D-14-3/D-15-1）。
- **本语（zh）**：zh land CLEAN / zh port CLEAN。
