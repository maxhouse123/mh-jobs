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

## 开场快剪 OP-2（review1 §五，返工第26趟 2026-10-12）
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
ch10＝设置章（账户/语言/退出），3 镜 10-2/10-3/10-4，全程在已登录 hub 上高亮设置菜单项·读-only·零写库·无弹窗置态。review1 未标 ch10 任何字幕缺陷→字幕/高亮一字未动；review1 §一列 ch10 为「背景含工作台数字」章，v184 缓存帧 hero 有负数/漏斗，v185 漏斗修复上线后须 v185 重录使背景数字落定版。本趟纯换录制底座 v184→v185 重录 ch10 3 镜 × 四语 × 横竖＝8 片覆盖 dist。中文 UI 全本地化（账户设置/退出登录/章节条「第 10 章 · 账户、语言、安全」）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 10-2 | 账户设置在齿轮里。 | `#settingsMenu [onclick*="openAccountSettings"]`「⚙ 账户设置」（设置下拉 账户 区·齿轮图标项） | 是 |
| 10-3 | 四种界面语言。 | `.lang-switcher`「EN · 中 · РУ · FR」四语切换按钮组（下拉 语言 区） | 是 |
| 10-4 | 共用电脑时记得退出。 | `[onclick*="settingsSignOut"]`「⟶ 退出登录」（设置下拉底部红色退出项） | 是 |

- 时长：land 16.33s / port 16.32s（3 镜）。8 片（四语横竖）全 res OK + audio yes；8 录屏 3 镜 hl 全 resolve、零 MISS；全片 DOM 扫描 **no @gmail**。
- 逐张亲眼复验（zh land 联络表）：背景 hero「TOTAL PAYMENTS PROCESSED ¥0」**无负数**（缺陷1 销账，§一达标）、「STUDENTS SUBMITTED 9」；下拉三项高亮逐镜对账「是」；Demo Agency 无真 PII、邮箱掩码（no @gmail）；无 beta/内测/test 控件；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。
- 记账：ch10 读-only，开工+收工 verify **17/17 PASS 0 FAIL**，baseline 全程守住（零置态/零写库）。ch10 v1 早在 `_v1/` 留底、dist 覆盖为定版 v2。全片不重拼。
