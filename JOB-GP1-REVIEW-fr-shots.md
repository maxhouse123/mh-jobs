# REVIEW-fr-shots · 逐镜对账表（review1 §十一）· FR

取帧点＝每镜字幕显示中点那一帧。高亮区文字从当时 DOM 读。随返工逐章追加。

## ch9 §三.6（增值服务名，返工第23趟 2026-10-12）
根因同 EN（增值服务区只在推荐生列表卡渲染；改不开弹窗、高亮列表卡真行）。
D-18-4：FR 界面里产品动态串回退成英文（PREMIUM SERVICES / Audit Service / Human-assisted Search / Inactive / Activate 均英文；boost 行 "Boost de visibilité" 与 Investi 本地化）——产品真实行为，照录不补，写进 SUMMARY 产品问题。字幕用法文点名服务并描述，与所框行指同一服务＝同一件事。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字 | 同一件事？ |
|----|----------|---------------------|-----------|
| 9-1 | Des options supplémentaires, seulement si vous le souhaitez : | 📦 PREMIUM SERVICES · Investi pour cet étudiant : ¥0 | 是（框增值服务区标题行） |
| 9-2 | le service Audit, qui lève le plafond de 2 admissions de l'offre de base et ajoute 30 jours de placement prioritaire, | 🚀 Audit Service · Inactive · Activate ¥1,500 | 是（框 Audit Service 行；据 `partner.vapay.auditDesc` 重译回译） |
| 9-3 | la Recherche assistée, où un conseiller Maxhouse établit une liste d'établissements sur mesure pour l'étudiant, | 🤝 Human-assisted Search · Inactive · Activate ¥600 | 是（框 Human-assisted Search 行；据 `partner.vapay.searchDesc` 重译回译） |
| 9-4 | et une mise en avant payante, qui place l'étudiant dans les viviers de candidats de davantage d'universités. | 📡 Boost de visibilité · inactif … Activer · à partir de ¥4,500 | 是（框 Boost de visibilité/Exposure boost 行，字幕未改） |

- 时长：land 24.27s / port 24.24s。no @gmail。章节条左标签「Partner Hub」(D-18-5)。演示生 Serikova Aizhan，无真 PII。
- 逐张亲眼复验：各镜框对应行，不越界。
- item-7 FR 禁用词扫描：0 命中（_scan-fr-forbidden 73 串 PASS）。

### ch9 v185 定版重录（返工第34趟 2026-10-13，review1 §一 背景）
trip23 字幕/高亮照旧正确，本趟只换录制底座 v184→v185 重录 ch9 4 镜使背景落定版。亲验 FR land/port 联络表：增值服务区标题行右「Investi pour cet étudiant : **¥0**」（缺陷1 销账，无负数）；chrome 法文本地化（Espace partenaires 等）；Audit Service / Human-assisted Search 等 LL 动态串英文回退（D-18-4，照录不补，留 SUMMARY）。4 镜 box 全 resolve、无 MISS、no @gmail。时长 land **24.18s** / port **24.30s**（v185 重录值）。ch9 读-only 零写库，开工+收工 verify 17/17 PASS。

## 开场快剪 OP-2（review1 §五，返工第26趟 2026-10-12）
问题/依据/做法同 EN REVIEW「开场快剪 OP-2」节。本趟只做 OP-2（素材 ch6 6-1/6-2 两份盲 offer）；OP-3/4/5 静止卡面待缺陷2 裁后接做。零改产品代码/迁移。

| 镜 | 字幕原文（配音，不改） | 快剪后画面（b-roll 中帧 DOM） | 同一件事？ |
|----|----------|---------------------|-----------|
| OP-2 前 2.5s | Une seule soumission, de nombreuses universités ／（正文配音） | 重点①卡满屏（紫底橙圈 1 + 法文标题 + 正文） | 是 |
| OP-2 2.5s~尾 | （同一句配音续） | ch6 法文真实画面：学生 Hussain Bilal 详情「OFFRES D'ADMISSION」列两份盲 offer（SCH-1AD6C8 / SCH-8E561C，均 UNIVERSITÉ · EN ATTENTE、无校名），底部叠「① Une seule soumission, de nombreuses universités」 | 是 |

- 亲眼复验（FR land b-roll 中帧）：两份盲 offer、无校名（双盲守住）、无 beta 控件、演示生无真 PII；界面法文本地化（TABLEAU PARTENAIRE·ÉTUDIANT / ÉCOLES INTÉRESSÉES / ACTION REQUISE / DOCS APPROUVÉS）；标题条＝ FR OP-2 卡标题/ED-1 回顾串一字一致；专业名英文回退（D-18-4）。
- OP-2 卡 11.1s 不变 → 全片 land 446.0s / port 444.7s。

## ch2 §三.1 / §三.2（工作台漏斗 + 卡状态徽章，返工第28趟 2026-10-12 · v185 上线后定版重录）
缺陷2 已由 v185 修好上线；录制底座切 v185 + 加 offCamera 等待（offers≥5 且 gate_open≥6）。§三.1（2-2）：工作台无「名额已用/剩余」显示→改述屏上真有的录取漏斗。§三.2（2-4）：真标签「Documents validés · mise en relation」是 gate_open 覆盖标签（`.partner-student-status-approved` class 永不存在）→ hl 按真法文标签文本高亮、字幕改述真档。详见 REVIEW-en-shots.md 同节。

| 镜 | 字幕原文（新/未改） | 高亮区 DOM 实际文字（v185 真帧） | 同一件事？ |
|----|----------|---------------------|-----------|
| 2-1 | Votre espace partenaire réunit tous les étudiants que vous avez recommandés au même endroit. | 工作台整屏 + 9 张推荐生卡（整屏 integral） | 是 |
| 2-2 | Votre entonnoir de recommandations : soumis, lettre émise, payé, inscrit. | `.partner-stats-funnel` 四段：**9** → 33% → **3** → 67% → **2** → 50% → **1**（下方 5 offer · 人均 0.6） | 是（漏斗四段＝屏上四段 9/3/2/1；段名法文或英文回退 D-18-4） |
| 2-3 | Chaque fiche indique l'étape actuelle de l'étudiant. | `.partner-students-count`「9 …」推荐生计数药丸 | 是 |
| 2-4 | Chaque fiche affiche son étape : approuvé et en appariement avec les écoles. | `.partner-student-status`（Mbarga Junior 卡）「**Documents validés · mise en relation**」 | 是（字幕↔屏上同文字标签；6 张卡同档） |
| 2-5 | Les notifications vous préviennent dès qu'une université agit. | 通知铃（角标 55）→ 开通知面板（≥4 条） | 是 |

- 时长：land 27.68s / port 27.62s。全片 no @gmail。亲眼复验（FR land 联络表）：漏斗 9/3/2/1 无负数全 0、2-4 框「Documents validés · mise en relation」、¥0 保留、演示生无真 PII、无 beta 控件；部分界面串英文回退（D-18-4）。

## ch2 §三.1（第三轮返工 · RULING-20261013b，第38趟 2026-10-13 · v185 定版重录）
⚠ 上表 2-3 / 2-4 两行**已被本节取代**。同 §三.1 重做（四语横竖 v185 重录；§三.7 去「提额待审」横幅，收工 verify 17/17；§三.9 章节条左标签改产品页头名）：
- **2-3**：改框列表**第一张学生卡整卡**（Serikova Aizhan），字幕不改。
- **2-4**：改为**依次框 5 张不同真实阶段的卡状态行**（nth 1/4/5/6/8；rec.mjs 新增 `hlseq`，每段 ~76%≥70%），字幕重写并重配音：**«Chaque fiche étudiant possède sa propre ligne de statut, indiquant précisément où en est l'étudiant — en cours d'examen, validé et en appariement, une nouvelle offre, une lettre émise, admission terminée.»**
- **§三.9**：章节条左标签 `Partner Hub`→**«Espace partenaires»**（＝v185 法文页头名；gp1-overlays.mjs BAR_I18N.fr.hub），只重烧章节条、重拼本章。

| 镜 | 高亮区 DOM 实际文字（最终成片实帧亲验） | 同一件事？ |
|----|---------------------|-----------|
| 2-3 | 整框第一张学生卡 Serikova Aizhan（徽章「En attente」） | 是 |
| 2-4 seg1 | nth1「⏳ All documents currently under review」(产品英文回退) | 是 |
| 2-4 seg2 | nth4「✓ Documents clés validés · en attente d'écoles」 | 是 |
| 2-4 seg3 | nth5「🆕 New offer from Un établissement · nom communiqué après admission · MSc Computer Science — awaiting student decision · yesterday」 | 是（双盲守住） |
| 2-4 seg4 | nth6「💰 Letter issued by Un établissement · … · student must pay **¥3,000** in 30 days」（正数） | 是 |
| 2-4 seg5 | nth8「Admission terminée · MSc Mechanical Engineering · 1w ago」 | 是 |

- 时长（成片）：land fr 36.0s。8 片 res OK + audio yes，录制全 no @gmail。2-4 窗 13.8s / 配音 fr 11.3s（静默尾≤3s）。
- 亲眼复验（FR land seg5 全帧）：环框「Admission terminée」行、**章节条左标签已改「Espace partenaires」**（§三.9）、页头「Espace partenaires」本地化；¥0 无负数、各 ¥ 正数；无 beta/test；双盲守住；状态行内「New offer from / Letter issued by / student must pay ¥3,000 / awaiting student decision / yesterday」为产品英文回退（D-18-4，照录不补），字幕本身为法文全译。联络表见 `~/mh-jobs/shots/GP1/fr/ch2-*.png`。

## ch1 §一（1-8 工作台负数金额，返工第29趟 2026-10-12 · v185 定版重录）
前置：ch1 第 1～7 镜＝注册/入驻 UI（产品自身渲染、零写库），review1 未标 ch1 字幕缺陷；唯 1-8 背景 hero 有 review1 §一 的负数（v184 `TOTAL PAYMENTS PROCESSED ¥-9,000`）。本趟 v185 底座整章四语横竖定版重录，1-8 背景自动显 `¥0`。字幕一字未改。

| 镜 | 字幕原文（未改） | 高亮区 DOM 实际文字（v185 真帧） | 同一件事？ |
|----|----------|---------------------|-----------|
| 1-1 | Ouvrez le portail partenaire. Touchez « Nouvelle agence ? Inscription ». | 登录门整屏（整屏 integral） | 是 |
| 1-3 | Saisissez le code d'invitation de la page guide, puis votre e-mail et un mot de passe. | `#regInvite` 邀请码框（已打码） | 是 |
| 1-5 | Présentez votre agence : nom, pays, personne à contacter, étudiants par an. | 入驻资质表单 | 是 |
| 1-6 | Téléversez la pièce d'identité du responsable et votre licence d'exploitation. | 上传区（SPECIMEN 样件） | 是 |
| 1-7 | Soumettez. Notre équipe examine les nouvelles agences sous deux jours ouvrés. | 「审核中」琥珀药丸状态页 | 是 |
| 1-8 | Une fois approuvé, votre espace partenaire est ouvert. | `.hero`（Demo Agency · Partenaire · approuvé，橙框）；同帧 hero「STUDENTS SUBMITTED 9」「TOTAL PAYMENTS PROCESSED ¥0」（**非 v184 的 ¥-9,000**） | 是 |

- 时长：land 49.62s / port 49.68s（8 镜）。全片 no @gmail。亲眼复验（FR land 1-8 原始帧）：1-8 hero ¥0（负数销账）、STUDENTS SUBMITTED 9、approuvé 徽章橙框；无负数、无 beta 控件；法文 UI（Espace partenaires / Aucun étudiant boosté，部分串英文回退 D-18-4）；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。

## ch3 §三.8（节奏 3-1/3-8）+ §四（草稿残留）+ §一（工作台 v185，返工第30趟 2026-10-12 · 定版重录）
前置同 EN 段。FR 字幕来自 captions-v1.json（trip19 已随 FR 录制核验）。D-18-4：工作台/向导动态串在 FR 同样回退英文＝真实产品，照录、记入 SUMMARY。§三.8/§四/§一 处理同 EN。

| 镜 | FR 字幕 | 高亮区 DOM 实际（v185 真帧，法/英混排=真产品 D-18-4） | 同一件事？ |
|----|----------|---------------------|-----------|
| 3-1 | Touchez « Soumettre un nouvel étudiant ». | `.partner-add-student-btn`（全窗口高亮） | 是 |
| 3-2 | Étape un : le projet — session, financement, niveau, spécialité. | 向导 step1 + 高亮 `#wzSemStart` | 是 |
| 3-3 | Étape deux : le profil de l'étudiant, exactement comme sur le passeport. | step2 高亮 DOB 行（Demo Aisha / DE1234567） | 是 |
| 3-4 | Étape trois : téléversez les documents. | step3 `.mat-grid` 护照槽 | 是 |
| 3-5 | La prévérification par IA signale les problèmes avant même qu'une université ne voie le dossier. | 琥珀预检条（FR 本地化·moitié inférieure floue）+ sticky 1 doc flagged（产品渲染） | 是 |
| 3-6 | La vérification du nom sur le passeport repère aussitôt les différences d'orthographe. | 护照卡姓名核对琥珀条 | 是 |
| 3-7 | Quittez à tout moment — votre brouillon est enregistré dans le cloud. | 退出弹窗存草稿钮 | 是 |
| 3-8 | Confirmez et soumettez. L'étudiant reçoit un numéro de dossier. | `.student-app-id-num`「… · MH-xxxxxx」（Demo Aisha·#10；§三.8 修后全窗口在画面） | 是 |
| 3-9 | Désormais, cet étudiant vous est rattaché. | `.partner-student-status-pending`（pending 标签，基线生卡；同卡 Invested ¥0 无负数） | 是 |

- 时长：land 69.59s / port 69.51s（9 镜）。横竖 2 片 res OK + audio yes，no @gmail，9 镜 hl 全 resolve。亲验同 EN/RU：3-8 app_no 全窗口、3-9 ¥0 无负数、演示生无真 PII、无 beta、页头不遮。

## ch7 §二.3（7-1 两段高亮）+ §三.5（7-4 字幕对账）+ §一（工作台 v185，返工第31趟 2026-10-12 · 定版重录）
前置：ch7 state 章，v185 定版重录。§二.3＝7-1 两段高亮（先 `.admission-id-tag--unlocked` 揭晓校名条、再 `.admission-doc-btn-letter` 下载钮）；§三.5＝7-4 字幕由「Inscrit. Terminé.」改成与卡状态行逐字一致的「Admission terminée.」。亲验 fr-land 7-4 真帧：产品**真本地化**渲染状态行「⏳ Admission terminée」（非英文回退），与字幕逐字一致；卡徽章蓝「Documents validés · mise en relation」＝已知产品问题（留 SUMMARY）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 7-0 | Saisissez le code promo — ¥0. Pas de frais d'agence, pas de frais de dossier. | `.payment-amount-value`「¥0.00」（应付总额；下方 ¥3,000.00 删除线 · MAXHOUSE −¥3,000.00） | 是 |
| 7-1 | L'université est révélée — téléchargez la lettre d'admission ici. | 两段：①`.admission-id-tag--unlocked`「🔓 Demo University · 演示大学 · 📍 Wuhan / 武汉 · SCH-1AD6C8」②`.admission-doc-btn-letter`「录取通知书 · Official PDF ⬇」 | 是（两段先校名后下载） |
| 7-2 | Le JW202 se télécharge de la même façon. | `.admission-doc-btn-jw`「JW202 Form · For visa application ⬇」 | 是 |
| 7-3 | La plateforme inscrit l'étudiant dans le système d'inscription de l'université à votre place. | `.offer-progress` 建档进度条「✓ Accept offer · ✓ admission letter · ✓ JW202 · ✓ Enrolled」 | 是 |
| 7-4 | Admission terminée. | `#gp1-74-card` 内状态行「⏳ Admission terminée · MSc Mechanical Engineering · 1w ago」（整卡高亮；卡「Investi pour cet étudiant : ¥0」无负数） | 是（字幕=状态行逐字） |

- 时长：land 43.596644s / port 43.518685s（5 镜）。横竖 2 片 res OK + audio yes，no @gmail，5 镜 hl 全 resolve（7-1 含 hl2）。章节条左标签 Partner Hub（D-18-4/RULING-c §3）；页头平台 WhatsApp/Email 不遮。
- 记账（留业主·已知产品问题）：7-4 卡徽章「Documents validés · mise en relation」对已入学生恒显矛盾（根因 students.stage 恒 NULL），未改产品码（§三.5 兜底），留 SUMMARY。

## ch8 §三.7（横幅：录前 scoped 撤待审提额）+ §一（工作台 v185，返工第32趟 2026-10-13）
做法同 en/zh 节。FR 界面动态串走产品 LL 的 EN 回退（D-18-4），故 8-2/8-4 横幅为英文；字幕为法文，描述同一件事。8-1 字幕随 §11 改述「STUDENTS SUBMITTED 9」。

| 镜 | 字幕原文(fr) | 高亮区 DOM 实际文字（产品 EN 回退） | 同一件事？ |
|----|----------|---------------------|-----------|
| 8-1 | Vous avez soumis neuf étudiants. | `.partner-stats-hero-card`「STUDENTS SUBMITTED · 9」（无横幅；¥0 无负数、漏斗 9→3→2→1） | 是 |
| 8-2 | Demandez une augmentation ici même. | `.modal-bg.show .modal-body`「Referral quota reached · used 9/10 seats」+ 表单 | 是 |
| 8-3 | Indiquez combien d'étudiants supplémentaires vous prévoyez ; nous l'examinons sous deux jours ouvrés. | `.modal-bg.show .btn-primary`「Submit request」（表单已填 30 + 理由） | 是 |
| 8-4 | Approuvé — votre quota grandit avec vos résultats. | `#qrPendingBanner`「✓ Quota raise approved: your quota is now 30 seats.」（产品自身 `_qrApplyBanner` 喂样例） | 是 |

- 时长：land 31.89s / port 31.68s（4 镜）。全 res OK + audio yes，no @gmail，4 镜 hl 全 resolve。
- 亲验 fr land 联络表四镜：8-1 无横幅框 9、章节条法文「Chapitre 8 · Quota et augmentation」、8-4 绿条（EN 回退·产品渲染）；¥0 无负数、无 beta。收工 verify 17/17 PASS。

## ch5 定版重录（两态·v185，返工第33趟 2026-10-13 · 落 §三.3 5-2 + §三.4 5-4 真态 + §三.8 5-1 + §一）
前置：ch5＝材料退回章（guide-pt-03 Islam Rahim）。此前 trip24 只 banked 5-2 新字幕（过渡版）、trip25 只落 5-4 真态机制与置态/复位脚本（帧捕获明文延后至 ch5 定版重录）。本趟缺陷2 已 v185 修好上线（RULING-20261012d/e），对已修数据**两态定版重录全章**：5-1/5-2/5-3 在退回基线录、5-4 在 apply `st-pt03-reupload` 后单录，由 `prod-ch --tags` 按镜序拼成一章（rec 全程只读，DB 置态/复位走 db-run.sh，录后 reset 回退态、verify 17/17 守住）。工具：rec.mjs 加 `--only`/`--tagsuffix`、prod-ch.mjs 加多 tag 拼章、gp1-finish.mjs chapterShotDurs 合并 companion `b` out 目录。
- **§三.4（5-4 真态·零改产品码）**：靠产品自己的 0104 supersede——pt-03 真·新建一行更正版 transcript（uploaded_at 更晚、无新裁决）→ `get_partner_student_doc_statuses` 不再返回 reject → 详情弹窗 transcript 槽 `slot.status` 真变 `reviewing`、徽章真变 `.badge-reviewing`、矩阵「Awaiting initial review」。非前端伪造（旧 setInterval 改字已删）。
- **§一**：5-1 工作台背景 v185，`Invested on this student: ¥0` 无负数（缺陷1 销账）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 5-1 | Un document a été renvoyé. Ouvrez l'étudiant. | `#__ch5card`（Islam Rahim 学生卡）+ 卡「Invested ¥0」（无负数） | 是 |
| 5-2 | Le relevé de notes est renvoyé — l'équipe Maxhouse demande une correction. | `.reviewer-row-rejected`「Maxhouse review team · Modification requested」（材料「Relevé de notes · REJECTED」；该行为产品 LL 动态串英文回退，D-18-4 记账） | 是 |
| 5-3 | Téléversez le fichier corrigé. | `.replace-box-rej`「Téléverser une nouvelle version」换版框 + 暂存样件 SPECIMEN | 是 |
| 5-4 | De nouveau en examen — pas besoin de resoumettre tout le dossier. | `#studentDetailModal .badge-reviewing`「EN EXAMEN」+「Relevé de notes · 2 fichiers téléversés」+ 矩阵「⚙ Système · En attente de la première vérification」（真·法文本地化；同帧无 REJECTED） | 是 |
- 时长：land 36.67s / port 36.81s（4 镜）。8 片（四语横竖）全 res OK + audio yes；8 录屏 4 镜 hl 全 resolve、零 MISS；全片 DOM 扫描 **no @gmail**。
- 逐张亲眼复验（EN land 4 镜原始帧 + 四语 land/port 联络表）：5-1「Invested ¥0」无负数（§一/缺陷1 销账）；5-2 框住「Modification requested」退回行（§三.3 达标）；5-4 产品**真·审核中**徽章 REVIEWING + 「Awaiting initial review」（非前端伪造，§三.4 达标）；演示生 Islam Rahim 无真 PII；无 beta/内测/test 控件；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）。
- 记账：录前 apply `st-pt03-reupload`（新建 transcript v2）、录后 `st-pt03-reupload-reset-cleanup` 删 v2 回退态；开工+收工 verify **17/17 PASS 0 FAIL**，baseline 守住（scoped 复位，无全量 rebuild）。ch5 v1 在 `_v1/` 留底、dist 覆盖为定版 v2。全片不重拼（待全部工作台章完后统一拼）。

## ch10 §一（设置章·读-only·v185 工作台背景定版重录，返工第35趟 2026-10-13）
> ⚠ **本节（含下表 10-2/10-3/10-4 三行）已被第 48 趟（第三轮返工 RULING-20261013b §三.10）取代**——第二版（trip35）虽已换 v185 底座重录，但第三轮裁决要求十章全部用 v185 定版重录一次、不沿用任何旧录像，并补 §三.7 去提额横幅 + §三.9 俄法章节条实帧复验；见文末「ch10 §三.10」节。
ch10＝设置章（账户/语言/退出），3 镜 10-2/10-3/10-4，全程在已登录 hub 上高亮设置菜单项·读-only·零写库。review1 未标 ch10 字幕缺陷→字幕/高亮一字未动；本趟纯换录制底座 v184→v185 重录使背景数字落定版。FR UI 高亮目标全本地化（Paramètres du compte / Se déconnecter）、章节条「Chapitre 10 · Compte, langue, sécurité」；页头 D-18-5 保留「Partner Hub」。hero 卡标签/提额横幅为产品 LL 动态串英文回退（D-18-4 照录，入 SUMMARY），与 ch1/ch9 同背景、非本趟引入。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（从 v185 真帧 DOM 读） | 同一件事？ |
|----|----------|---------------------|-----------|
| 10-2 | Les réglages du compte se trouvent sous l'engrenage. | `#settingsMenu [onclick*="openAccountSettings"]`「⚙ Paramètres du compte」（下拉 COMPTE 区·齿轮项，FR 本地化） | 是 |
| 10-3 | Quatre langues d'interface. | `.lang-switcher`「EN · 中 · РУ · FR」四语切换按钮组（下拉 LANGUE 区） | 是 |
| 10-4 | Déconnectez-vous si l'ordinateur est partagé. | `[onclick*="settingsSignOut"]`「⟶ Se déconnecter」（下拉底部红色退出项，FR 本地化） | 是 |

- 时长：land 16.30s / port 16.29s（3 镜）。8 片（四语横竖）全 res OK + audio yes；8 录屏 3 镜 hl 全 resolve、零 MISS；全片 DOM 扫描 **no @gmail**。
- 逐张亲眼复验（fr land 10-2 原始帧 f00022 + fr land 联络表）：背景 hero「TOTAL PAYMENTS PROCESSED ¥0」**无负数**（缺陷1 销账，§一达标）、「STUDENTS SUBMITTED 9」；下拉三项高亮逐镜对账「是」，FR 本地化真帧（Paramètres du compte/Se déconnecter 非 EN 回退）；Demo Agency 无真 PII、邮箱掩码（no @gmail）；无 beta/内测/test 控件；页头平台 WhatsApp/Email 不遮。
- 记账：ch10 读-only，开工+收工 verify **17/17 PASS 0 FAIL**，baseline 守住（零置态/零写库）。ch10 v1 在 `_v1/` 留底、dist 覆盖为定版 v2。全片不重拼。

## Montage rapide d'intro OP-3 / OP-4 / OP-5（review1 §五，返工第36趟 2026-10-13）
做法同 trip26 OP-2、同 EN（见 REVIEW-en-shots.md）：卡前 2.5s 满屏→切对应镜真实画面（静音·配音续·底叠重点标题条），卡总时长/配音不变；按镜号从 ch3/ch7 的 fr timeline 取窗；OP-4 定格 ts≈4.5 干净 ¥0 发票避 beta 吐司；tpad 补满 30fps CFR。

| 镜 | 字幕原文（配音，不改·法） | 快剪后画面（b-roll 帧 DOM） | 同一件事？ |
|----|----------|---------------------|-----------|
| OP-3 前 2.5s | Votre étudiant reste le vôtre ／ … | 重点②卡满屏（橙圈 2 + 法标题/正文） | 是 |
| OP-3 2.5s~尾 | （同句配音续） | ch3 3-8：演示生 Demo Aisha 详情·真 app_no「MH-xxxxxx」（橙框）· 法本地化状态·#10，底叠「② Votre étudiant reste le vôtre」 | 是 |
| OP-4 前 2.5s | Aucuns frais de plateforme ／ … | 重点③卡满屏（橙圈 3 + 法标题/正文） | 是 |
| OP-4 2.5s~尾 | （同句配音续） | ch7 7-0 定格：付款单「**¥0.00**」· ¥3,000·MAXHOUSE −¥3,000 · 演示生 demo 邮箱 · MH-NEPTRN · SCH-1AD6C8，底叠「③ Aucuns frais de plateforme」 | 是（¥0 全程在画面） |
| OP-5 前 2.5s | Rempli par l'université, livré chez vous ／ … | 重点④卡满屏（橙圈 4 + 法标题/正文） | 是 |
| OP-5 2.5s~尾 | （同句配音续） | ch7 7-1：录取详情「Détails d'admission · Lettre d'admission prête — JW202 à venir」· 揭晓校名条 演示大学·Wuhan·SCH-1AD6C8（橙框）· 下载钮「Lettre d'admission PDF officiel」（橙框）· École révélée·coordonnées，底叠「④ Rempli par l'université…」 | 是（亲验 FR land OP-5） |

- 亲验（FR land OP-5＝校名揭晓+下载法本地化）：无负数、无 beta/test、演示生无真 PII、邮箱掩码 no @gmail、双盲守住（校名揭晓＝付款解锁后合法态）、标题条＝FR OP 卡标题/ED-1 回顾一字一致（D-18-4：产品动态串英文回退照录）。卡总时长不变（FR OP-3 15.4 / OP-4 9.3 / OP-5 15.2s），配音未动。

## ch1 §三.10 + §三.7 + §三.9（第三轮返工 · RULING-20261013b，第39趟 2026-10-13 · v185 定版重录·不沿用旧录像）
RULING-20261013b §三.10 要求十章全部用 v185 重录。本趟 ch1 整章法文横竖重录。1～7 镜＝注册/入驻 UI（产品渲染·零写库），review1/本轮未标 ch1 字幕缺陷→**字幕一字未改**。
- **§三.7（去提额横幅）**：1-8 露工作台顶部，录前 `st-ch8-quota-off`、录后 `st-ch8-quota-restore`，收工 verify #13 回 pending、17/17 PASS。本趟 1-8 已无「Quota raise pending」横幅。
- **§三.9（章节条左标签）**：fr 章节条左标签 `Partner Hub`→**«Espace partenaires»**（＝v185 法文页头名；gp1-overlays.mjs BAR_I18N.fr.hub，trip38 已改 commit，本趟 ch1 重烧继承）。**横版 fr 成片实帧亲验：章节条＝「Espace partenaires」**（/tmp/ch1-fr-bar.png 裁帧确认）。
- 1-8 hero：`TOTAL PAYMENTS PROCESSED ¥0`（无负数，缺陷1 销账）、`STUDENTS SUBMITTED 9`、approuvé 徽章橙框。
- 时长：land 49.68s / port 49.59s（8 镜）。横竖 2 片 res OK + audio yes，no @gmail，8 镜 box 全 resolve。
- 亲眼复验（FR land 章节条裁帧 + FR land/port 联络表）：章节条「Espace partenaires」、页头法文本地化；1-8 ¥0 无负数、无横幅、STUDENTS 9；无 beta/test。hero 卡部分 LL 动态串英文回退＝D-18-4 照录不补。
- 联络表：`~/mh-jobs/shots/GP1/fr/ch1-contact-{land,port}-fr.png`。

## ch3 §三.3 + §三.4 + §三.8 + §三.7 + §三.10（第三轮返工 · RULING-20261013b，第40趟 2026-10-13 · v185 定版重录）
ch3 四语横竖 8 片 v185 重录。法文镜本趟核心＝**§三.8（3-1 引用按钮名对齐界面）**：主审 grep 实证 v185 `maxhouse-partner-i18n-v183-fr.js` 真值 `'partner.students.addBtn':'Soumettre un nouveau référencement'`。v2 法 3-1 字幕引「Soumettre un nouvel étudiant」对不上→本趟改 captions-v1.json 法 3-1＝「Touchez « Soumettre un nouveau référencement ».」（最小改·回译＝submit a new referral＝按钮+EN 原意），重 TTS。另落 §三.3（3-3 preOff→停档案字段）、§三.4（3-9 框 Demo Aisha #10）、§一（¥0）、§三.7（去横幅）。

| 镜 | 字幕原文（配音·FR·本趟改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 3-1 | Touchez « Soumettre un nouveau référencement ». | 橙环框「+ Soumettre un nouveau référencement」按钮（«»内＝按钮文字逐字一致·§四.4 过） | 是 |
| 3-3 | Étape deux : le profil de l'étudiant, exactement comme sur le passeport. | 第二步「Profil」激活；橙环框「Date de naissance」日期框，右侧「N° de passeport」可见（档案字段，非表单底） | 是 |
| 3-9 | Désormais, cet étudiant vous est rattaché. | 橙环框 #10「Demo Aisha」整卡（à l'examen · Pakistan · bachelor · Invested ¥0），其下 #9 Serikova 未框 | 是（刚提交即绑定＝#10 Demo Aisha） |

- 法界面英文回退片段（增值服务名等）＝产品 i18n 回退，D-18-4 照录不补；高亮/引用的按钮名（Soumettre un nouveau référencement）、字段名（Date de naissance/N° de passeport）、章节条（Espace partenaires）均真本地化。
- §四.5：8 片 DOM 全 no @gmail；无 beta/test；¥ 皆正数或 ¥0。时长 land fr 58.99 / port fr 58.95。联络表 `~/mh-jobs/shots/GP1/fr/ch3-contact-{land,port}-fr.png`。

## ch4 §三.10 + §一（第三轮返工 · RULING-20261013b，第41趟 2026-10-13 · v185 定版重录·不沿用旧录像）
ch4＝具名邀请（委托学生自传）章（state 章：pt-04 置 intake_mode='delegate' + 必传材料 4/4，4-5 真 submit；每变体录前 `st-pt04-docs-full.sql` 置态、录后 `st-pt04-reset-cleanup.sql` scoped 复位，不动 app_no=MH-EXET28、不跑全量 rebuild，D-12-2）。review1/review2 未标 ch4 字幕缺陷→**字幕/高亮一字未改**，纯按 §三.10 v185 重录四语横竖 8 片覆盖 dist。
- **§一（负数销账·核心）**：第二版「照原版入拼」沿用 v184 旧录像，英文 4-4/4-5 委托卡「Invested ¥-3,000」为负（漏斗缺陷1，v185 已修）。本趟 v185 重录后四语 4-4/4-5 页面金额＝**¥0（无负数）**——亲帧 FR land 4-4 f00212「Investi pour cet étudiant : ¥0」、EN land 4-4 f00215「Invested ¥0」、ZH land 4-4 f00215「该学生已投入：¥0」、RU land 4-4 f00214「Вложено ¥0」。
- **§三.7 N/A**：ch4 全 5 镜在工作台已发邀请/委托卡/学生卡区（列表中段），不露工作台顶部 hero→无提额横幅（亲帧 EN land 4-1 f00025），不需 st-ch8-quota-off。
- **§三.9**：fr 章节条＝「Espace partenaires」（trip38 已改 overlay，本趟继承，联络表实帧亲验）；ru＝「Центр партнёров」、zh＝「合作伙伴端」、en＝「Partner Hub」。

| 镜 | 字幕原文（配音·法·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 4-1 | Trop de fichiers à rassembler ? Laissez l'étudiant les téléverser. | 橙环框「✉ Invite student to self-upload」委托邀请钮（产品该串英文回退 D-18-4） | 是 |
| 4-2 | Renseignez l'e-mail de l'étudiant et le projet convenu. Envoyez. | 邀请弹窗表单：姓名「Aizhan Serikova」+邮箱「aizhan.demo@example.com」（演示号·no @gmail） | 是 |
| 4-3 | Copiez le lien ou renvoyez-le. | 橙环框已发邀请行：Aizhan Serikova · agency.demo@example.com ·（复制/重发钮） | 是 |
| 4-4 | L'étudiant s'inscrit et téléverse ; vous suivez la progression. | 橙环框委托卡：Délégué·l'étudiant téléverse / Documents obligatoires 3/4 / 时间线 Invitation envoyée→Étudiant inscrit 2026-10-12→Documents complets 3/4→Vous avez soumis | 是 |
| 4-5 | Le bouton d'envoi reste chez vous — vous seul déposez le dossier. | 橙环框「Soumettre la candidature」按钮（Documents obligatoires 4/4·由灰变绿可点） | 是 |

- §四.5：ch4 画面＝登录（offCamera）+ 工作台邀请区 + 委托卡；无付款/内测元素；8 片 DOM 全 no @gmail（aizhan.demo@/agency.demo@example.com）；无 beta/test；¥＝增值服务（Activer ¥1,500/¥600/dès ¥4,500，正数）与「Investi ¥0」（非负）；法界面英文回退片段（Premium services 等）＝D-18-4 照录不补；演示生/机构无真 PII；页头平台联系方式不遮（D-14-3/D-15-1）。
- 时长（秒）：land fr 42.85；port fr 42.78。联络表 `~/mh-jobs/shots/GP1/fr/ch4-contact-{land,port}-fr.png`。

## ch5 第三轮返工（RULING-20261013b §三.2(a)+§三.7+§一+§三.9·第42趟 2026-10-13 · v185 两态定版重录）
取代 trip33 节 5-1 行。5-1 改从通知铃：urgent 退回通知标题本地化「Document de votre étudiant renvoyé」与字幕同义→字幕不改、不重配音。录制层补 `.stu-notif-list` 启用滚动 + preOff。§三.7 去横幅。§一 ¥0。§三.8 N/A。§三.9 章节条「Espace partenaires」（trip38 overlay 继承，land 5-1 成片帧亲验）。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字（字幕中点+亲帧） | 同一件事？ |
|---|---|---|---|
| 5-1 | Un document a été renvoyé. Ouvrez l'étudiant. | 铃 urgent 通知标题「Document de votre étudiant renvoyé」+ desc「Le transcript de Rahim Islam a été renvoyé. Motif : …」（理由 EN 回退 D-18-4） | 是 |
| 5-2 | Le relevé de notes est renvoyé — l'équipe Maxhouse demande une correction. | `.reviewer-row-rejected`：⚠ Maxhouse review team · Modification requested（材料 Relevé de notes · REJECTED） | 是 |
| 5-3 | Téléversez le fichier corrigé. | 换版区「Téléverser la version corrigée」红钮 + 提示 | 是 |
| 5-4 | De nouveau en examen — pas besoin de resoumettre tout le dossier. | transcript 槽徽章 `.badge-reviewing`＝EN EXAMEN；矩阵「⚙ Système · En attente de la première vérification」（真态） | 是 |

- §四.2：5-1 ~88%；弹窗镜≥90%。§四.5：beta/test/负数 0 命中；MASK_INIT 遮 @gmail；页头平台不遮。法文动态串 EN 回退＝D-18-4 照录。
- 亲帧复验：FR land 5-1(f22「Document de votre étudiant renvoyé」高亮·无横幅·¥0·章节条 Espace partenaires)/5-4(ch5b EN EXAMEN 徽章)。演示生 Islam Rahim 无真 PII、双盲守住。
- 时长：land 32.39s / port 32.46s。

## ch6 §三.10 + §三.7 + §一 + §三.9（第三轮返工 · RULING-20261013b，第43趟 2026-10-14 · v185 定版重录·不沿用旧录像）
ch6＝盲态进度章：读-only（开委托生 Bilal 详情→两盲 offer 卡；开盲态录取弹窗；6-7 高亮「接受该专业」affordance 不点、不写库）。§二 trip21(D-21-1) 已执行，本趟按 §三.10 用 v185 重录整章四语横竖（8 片）。字幕/高亮一字未改。
- §一（负数销账·复核）：v185 base 探针各镜负数 (none)；§四.5 in-frame 扫描全 CLEAN。
- §三.7（提额横幅）：ch6 各镜 `#qrPendingBanner` 在屏→录前 st-ch8-quota-off 去横幅、录后 restore（verify#13 回 pending）。
- §三.8 N/A（无引号引用按钮名）。
- **§三.9（法文章节条·本语言重点）**：fr 章节条左标签＝「Espace partenaires」（gp1-overlays BAR_I18N，trip38 改并 commit；本趟重烧继承）。联络表实帧亲验 fr land/port 章节条＝「Espace partenaires」、右「Chapitre 6 · Offres des universités」。

| 镜 | 字幕原文（配音·FR·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 6-1 | Deux universités ont admis cet étudiant. | 委托生 Hussain Bilal 详情·橙环框两盲 offer 卡区（SCH-1AD6CR·MSc Computer Science / SCH-B6X61C，均盲码无校名） | 是 |
| 6-2 | Avant le déblocage, vous voyez le programme, les frais et la bourse — saisis par l'université elle-même — mais pas son nom. | 录取弹窗·橙环框盲码「SCH-1AD6CR」；MSc Computer Science·学费/奖学金行，无校名 | 是 |
| 6-3 | Comparez, puis acceptez celle que vous préférez. | 橙环框奖学金行「Full scholarship (tuition waived)」（盲态·LL 英文回退 D-18-4） | 是 |
| 6-7 | Acceptez le programme — la date de rentrée et la bourse sont indiquées ici. | 橙环框「✓ Accept this programme」绿钮（旁开学日期 2027-09-01 + 奖学金，不点不写库） | 是 |

- §四.5 整镜扫描（in-frame·MASK+HIDE）：fr 横竖全 CLEAN——无 beta/placeholder/test、无负数、无真邮箱。双盲守住（盲码 SCH-xxxxxx）。法文弹窗内动态串英文回退＝D-18-4 照录不补。页头平台不遮（D-14-3/D-15-1）。
- 时长（秒）：land fr 25.99；port fr 25.89（全 res OK + audio yes + 4 镜 resolve）。
- 联络表：`~/mh-jobs/shots/GP1/fr/ch6-contact-{land,port}-fr.png`。

## ch7 §三.5 + §三.6 + §三.7 + §一 + §三.9（第三轮返工 · RULING-20261013b，第45趟 2026-10-14 · v185 定版重录·state 章 pt-07/08 置态）
ch7＝通知书/JW202/建档章。state 章：每变体 st-pt07-pay-cleanup + st-pt08-jw202 置态，7-0 真付 ¥0 优惠码路，录全 8 变体后 st-pt0708-reset-cleanup + st-ch8-quota-restore 复位。字幕不变。
- **§三.5（7-0 beta 提示）**：7-0 ¥0 发票 dwell 在镜内（橙框「¥0.00」≥2s）；真付确认点击+等待（产品付款成功「Paid (beta placeholder)」浮条 ~2.6s）全在镜外（actOff）跑 → 内测 toast 帧永不入片。双保险 HIDE_INIT 遮含 beta/placeholder/内测/测试 浮条。真付 DB 照写。
- **§三.6（7-4 只框状态行）**：7-4 橙环框状态行 `.partner-student-issue`（`#gp1-74-issue` rAF 贴合），box≈864×100（状态行高，非整卡），不框徽章。字幕不变。
- **§三.7（提额横幅）**：录前 st-ch8-quota-off 去横幅、录后 restore（verify#13 回 pending）。
- **§一（负数销账）**：7-0 折扣行「MAXHOUSE −¥3,000.00」＝优惠码抵扣（白名单）；应付 ¥0.00；卡「Invested …¥0」无负数。§四.5 扫描 CLEAN。
- **§三.9（法文章节条·本语言重点）**：fr 章节条左标签＝「Espace partenaires」（gp1-overlays BAR_I18N，trip38 改并 commit；本趟重烧继承）。联络表实帧亲验 fr land/port 章节条＝「Espace partenaires」。

| 镜 | 字幕原文（配音·FR·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读；动态串 LL 英文回退 D-18-4） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 7-0 | Saisissez le code promo — ¥0. Pas de frais d'agence, pas de frais de dossier. | 付款弹窗·橙环框应付大字「¥0.00」（下方 ¥3,000.00·MAXHOUSE −¥3,000.00 抵扣行；Applicant/Paid by = agency.demo@example.com 脱敏） | 是 |
| 7-1 | L'université est révélée — téléchargez la lettre d'admission ici. | 录取弹窗：先框揭晓校名条，后框「Download admission letter」钮（两段高亮） | 是 |
| 7-2 | Le JW202 se télécharge de la même façon. | 橙环框「JW202」下载钮 | 是 |
| 7-3 | La plateforme inscrit l'étudiant dans le système d'inscription de l'université à votre place. | 橙环框建档进度（MSc Mechanical Engineering + 清单含 Enrollment ✓） | 是 |
| 7-4 | Admission terminée. | 橙环框列表卡状态行「Admission complete · MSc Mechanical Engineering · …」（只框状态行，不框整卡/徽章；动态串 EN 回退 D-18-4） | 是 |

- §四.5 整镜扫描（in-frame·MASK+HIDE）：fr 横竖全 CLEAN——beta/placeholder/test 0、负数 0（抵扣行白名单）、真邮箱 0。法文弹窗/状态行动态串英文回退＝D-18-4 照录不补。页头平台不遮（D-14-3/D-15-1）。
- 时长（秒）：land fr 38.02；port fr 38.61（全 res OK + audio yes + 5 镜 resolve）。
- 联络表：`~/mh-jobs/shots/GP1/fr/ch7-contact-{land,port}-fr.png`。

## ch8 §三.7（照 D-32-1）+ §一 + §三.9 + §三.10（第三轮返工 · RULING-20261013b，第46趟 2026-10-14 · v185 定版重录·名额与提额章）
ch8＝名额与提额章（Quota & requesting more）。**零 DB 写**：8-1 读工作台统计卡；8-2/8-3 用 `pre` 调产品 `_qrOpenRaise({used:9,quota:10})` 开弹窗、填数量 30+理由但**不点提交**；8-4 调产品自身 `_qrApplyBanner` 喂样例已批数据渲染真绿条（§8 先例·不写库）。字幕四语未改（review1/review2 未标 ch8 字幕缺陷；trip32 已 bank）。
- **§三.7（提额横幅·照 D-32-1）**：基线有 1 张 pending `quota_request`（verify#13）→ 工作台顶部恒显 amber「Quota raise pending: 10→30」，与 8-2/8-3「才去申请」叙事矛盾 → 录前 `st-ch8-quota-off`（该行 status pending→approved·decided_at 保持 NULL → 产品 `_qrApplyBanner` 判非 pending 且无裁决 → box 清空无横幅；`partners.referral_quota` 不动仍 10、hero 数字不变），录后 `st-ch8-quota-restore` 还原 pending（收工 verify#13 回 pending）。读-only：一次 quota-off → 录全 8 变体 → 一次 restore。
- **§一（负数销账）**：v185 base 工作台背景「TOTAL PAYMENTS PROCESSED ¥0」无负数（亲帧 EN land 8-1 f15 / 8-4 f157）。§四.5 in-frame 扫描四语横竖负数全 CLEAN。
- **§三.9**：ru 章节条「Центр партнёров」/fr「Espace partenaires」（trip38 overlay 继承·联络表实帧亲验）；zh「合作伙伴端」/en「Partner Hub」不动。
- **§四.4（引用按钮名逐字）N/A**：ch8 四镜字幕均未用引号引界面按钮/标签名（8-2「Request a raise right here」、8-3 描述动作、8-4「Approved…」），无逐字比对对象。

| 镜 | 字幕原文（FR·captions-v1） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 8-1 | Vous avez soumis neuf étudiants. | 工作台统计卡「STUDENTS SUBMITTED 9」橙环框（右侧「TOTAL PAYMENTS PROCESSED ¥0」无负数；§三.7 去横幅后 header 与内容间无 amber「Quota raise pending」横幅） | 是 |
| 8-2 | Demandez une augmentation ici même. | 「Referral quota reached · 当前 9/10 席已用」提额弹窗 body 橙环框（zh 本地化「推荐名额已用完」；ru/fr 弹窗标题 EN 回退 D-18-4） | 是 |
| 8-3 | Indiquez combien d'étudiants supplémentaires vous prévoyez ; nous les examinons sous deux jours ouvrés. | 提额弹窗「Submit request / 提交申请」提交钮橙环框（目标名额填 30 + 理由；高亮全程贴合提交钮，填表在后半段完成——亲帧 zh-port f148 默认 15、f181 已填 30+理由） | 是 |
| 8-4 | Approuvé — votre quota grandit avec vos résultats. | 产品自身 `_qrApplyBanner` 喂样例渲染绿条「Quota raise approved: your quota is now 30 seats」橙环框（§8 先例·零写库；zh 本地化「提额申请已批准：配额已调整为 30 席」；ru/fr EN 回退 D-18-4） | 是 |

- §四.2：8-1/8-2/8-4 高亮全程在视口内≥90% 可见、dwell≥70%；8-3 高亮＝提交钮，f148 与 f181 皆橙框在屏（highlight 全程≥90%），填表值 15→30 在窗口后半完成（caption 述「填预计人数」＝表单动作，与画面一致）。
- §四.5 整镜扫描（in-frame·MASK+HIDE 复现录制层·`_scan-ch8-forbidden.mjs`·4 语×2 视口）：**ALL CLEAN**——beta/placeholder/test/内测/测试 0 命中、负数 0 命中、真邮箱 0 命中（@gmail MASK→agency.demo@example.com）。页头平台 WhatsApp/Service@maxhouses.net 不遮（D-14-3/D-15-1）。
- 亲帧复验：EN land 8-1(f15 9 学生·¥0·无横幅)/8-4(f157 产品绿条非伪造·¥0)；ru land + fr land + zh port 联络表逐镜复验（章节条 ru/fr 本地化、zh 弹窗全中文、ru/fr 弹窗与绿条 EN 回退 D-18-4 照录）；Demo Agency 无真 PII。
- 时长（最终成片，秒）：land 31.78 / port 31.79。8 片全 res OK + audio yes + 4 镜 box 全 resolve。
- 联络表（四语全部用本趟最终成片重生成）：`~/mh-jobs/shots/GP1/fr/ch8-contact-{land,port}-fr.png`。

## ch9 §三.10（+§三.7+§一+§三.9）（第三轮返工 · RULING-20261013b，第47趟 2026-10-14 · v185 定版重录·增值服务章·读-only）
ch9＝增值服务章（Options supplémentaires / value-added services）。**读-only·零 DB 写**：CONTEXT['9'] 仅把首张推荐生列表卡的 `.partner-premium-block` 滚到视口中心，逐镜高亮服务行，零点击零写库。字幕四语未改（§三.10 仅要求 v185 定版重录一次）。
- **§三.10**：ch9 整章四语横竖 8 片用 v185 重录→合成覆盖 dist→四语联络表。md5 比对 dist vs `_v2/` 8 片全差异（真重录）。
- **§三.7（安全·照 ch6 读-only 先例）**：录前 `st-ch8-quota-off` 去横幅、录后 restore（verify#13 回 pending）。一次 off→录全 8 变体→一次 restore。
- **§一**：每张卡「Investi pour cet étudiant : ¥0」无负数（亲帧 fr land f165）；¥1,500/¥600/¥4,500 均正数。§四.5 扫描四语横竖负数全 CLEAN。
- **§三.9**：fr 章节条「Espace partenaires」（本语·成片帧亲验）/ru「Центр партнёров」（trip38 继承）；zh/en 不动。
- **§四.4 N/A**：ch9 四语字幕均未用引号引界面按钮名（全描述性散文），无逐字比对对象。
- **D-18-4**：9-1 标题 / 9-2 Audit / 9-3 Human-assisted 等 premium 动态串在 fr 下英文回退，照录不补；9-4 付费曝光行 fr 本地化「Boost de visibilité · inactif / Activer · dès ¥4,500」。

| 镜 | 字幕原文（FR·配音·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读；动态串 LL 英文回退 D-18-4） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 9-1 | Des options supplémentaires, seulement si vous le souhaitez : | `.partner-premium-title`「🎁 PREMIUM SERVICES」(EN 回退) 橙环框（右侧「Investi pour cet étudiant : ¥0」无负数；§三.7 去横幅后无提额横幅） | 是 |
| 9-2 | le service Audit, qui lève le plafond de 2 admissions de l'offre de base et ajoute 30 jours de placement prioritaire, | premium 第 2 行橙环框「🚀 Audit Service · Inactive · Activate ¥1,500」(EN 回退) | 是 |
| 9-3 | la Recherche assistée, où un conseiller Maxhouse établit une liste d'établissements sur mesure pour l'étudiant, | premium 第 3 行橙环框「🤝 Human-assisted Search · Inactive · Activate ¥600」(EN 回退) | 是 |
| 9-4 | et une mise en avant payante, qui place l'étudiant dans les viviers de candidats de davantage d'universités. | `.partner-premium-row--boost` 橙环框「📈 Boost de visibilité · inactif · Activer · dès ¥4,500」（无「优先审核」字样） | 是 |

- §四.2：9-1..9-4 高亮均在视口中心 premium block 内，全程≥90% 可见、dwell≥70%；box 四镜全 resolve。
- §四.5 整镜扫描（in-frame·`_scan-ch9-forbidden.mjs`·4 语×2 视口）：**ALL CLEAN**——beta/test 0、负数 0、真邮箱 0。页头平台不遮（D-14-3/D-15-1）。
- 亲帧复验：fr land（章节条 Espace partenaires·Investi ¥0·premium 动态串 EN 回退 D-18-4·付费曝光行 fr 本地化）；EN/zh/ru 联络表逐镜复验。Demo 生无真 PII、双盲守住。
- 时长（最终成片，秒）：land fr 24.32（en 22.82 / zh 23.80 / ru 26.35）；port fr 24.27（en 22.78 / zh 23.75 / ru 26.39）。8 片全 res OK + audio yes + 4 镜 box 全 resolve。
- 联络表（四语全部用本趟最终成片重生成）：`~/mh-jobs/shots/GP1/fr/ch9-contact-{land,port}-fr.png`。

## ch10 §三.10（+§三.7+§一+§三.9）（第三轮返工 · RULING-20261013b，第48趟 2026-10-14 · v185 定版重录·设置/语言/账户章·读-only·十章重录收尾）
ch10＝设置/语言/账户章，3 镜 10-2/10-3/10-4。**读-only·零 DB 写**：CONTEXT['10'] 仅 `toggleSettingsMenu` 开设置下拉菜单（不开 asModal），逐镜高亮菜单项 / 顶条语言切换器，全程零点击提交、零写库。字幕四语未改（review1/review2 未标 ch10 任何镜级缺陷；§三.10 仅要求 v185 定版重录一次）。ch10 是第十章，本趟即十章全部 v185 定版重录收尾。FR 菜单项全本地化（Paramètres du compte / Se déconnecter）、章节条「Chapitre 10 · Compte, langue, sécurité」。
- **§三.10（定版重录·本趟目的）**：ch10 整章四语横竖 8 片用 v185 重录→`_prodch10.sh` 合成覆盖 dist→四语联络表。md5 比对 dist vs `_v2/` 8 片全差异（真重录；覆盖前先 cp 第二版 8 片入 `_v2/`，_v2 原无 ch10）。
- **§三.7（提额横幅）**：设置菜单浮在工作台之上·露 hero 顶部。录前 `st-ch8-quota-off` 去横幅、录后 `st-ch8-quota-restore`（收工 verify#13 回 pending）；读-only 一次 off→录全 8 变体→一次 restore。亲帧 fr land+port 联络表 header 与 hero 间无 amber 提额横幅。
- **§一（负数销账）**：背景 hero「TOTAL PAYMENTS PROCESSED ¥0」无负数（fr hero 卡标签为 LL 动态串英文回退 D-18-4，¥0 数值正常）；§四.5 in-frame 扫描四语横竖负数全 CLEAN。
- **§三.9**：fr 章节条「Espace partenaires」（trip38 继承·本趟 land+port 联络表实帧亲验已本地化）；ru「Центр партнёров」、zh「合作伙伴端」、en「Partner Hub」各自另见。
- **§四.4 N/A**：ch10 fr 字幕（Les réglages du compte se trouvent sous l'engrenage. / Quatre langues d'interface. / Déconnectez-vous si l'ordinateur est partagé.）均未用引号引界面按钮名——描述性散文，无逐字比对对象；高亮框住的菜单项 Paramètres du compte / Se déconnecter 本身即 FR 本地化，与叙述一致。

| 镜 | 字幕原文（法·不改） | 字幕中点画面高亮区实际文字（成片实帧肉眼读） | 同一件事？ |
|----|------------------------|------------------------------------------------|-----------|
| 10-2 | Les réglages du compte se trouvent sous l'engrenage. | `#settingsMenu [onclick*="openAccountSettings"]`「⚙ Paramètres du compte」橙环框（设置下拉 COMPTE 区·齿轮项·FR 本地化） | 是 |
| 10-3 | Quatre langues d'interface. | 顶条 `.lang-switcher`「EN · 中 · РУ · FR」四语切换按钮组橙环框 | 是 |
| 10-4 | Déconnectez-vous si l'ordinateur est partagé. | `#settingsMenu [onclick*="settingsSignOut"]`「⟶ Se déconnecter」橙环框（设置下拉底部红色退出项·FR 本地化） | 是 |

- §四.2：10-2/10-3/10-4 高亮均在打开的设置菜单内（10-3 在顶条语言器），全程≥90% 可见、dwell≥70%；box 三镜全 resolve（land 705×93 / 383×80 / 705×93；port 752×99 / 408×85 / 752×99）。
- §四.5 整镜扫描（in-frame·`_scan-ch10-forbidden.mjs`·4 语×2 视口）：**ALL CLEAN**——beta/placeholder/test/内测/测试 0 命中、负数 0 命中、真邮箱 0 命中（账户邮箱 @gmail MASK→agency.demo@example.com）。页头平台联系方式不遮（D-14-3/D-15-1）。
- 亲帧复验（fr land+port 联络表逐镜）：设置菜单账户区（E-mail 掩码邮箱、Partner Code PA-E62FC6FF、Agency Demo Agency 无真 PII、Copier FR 本地化）；三项高亮逐镜对账全「是」；¥0 无负数、无提额横幅、无 beta；菜单项 Paramètres du compte/Se déconnecter 真本地化、hero 动态 LL 串仍 EN 回退（D-18-4 照录不补）。
- 时长（最终成片，秒）：land fr 16.27（en 16.31 / zh 16.30 / ru 16.32）；port fr 16.31（en 16.31 / zh 16.31 / ru 16.23）。8 片全 res OK + audio yes + 3 镜 box 全 resolve、全片 no @gmail。
- 记账：ch10 读-only，开工+收工 verify **17/17 PASS 0 FAIL**，baseline 全程守住。ch10 v1 在 `_v1/`、v2 在 `_v2/` 留底、dist 覆盖第三轮定版。全片待 OP 重做后统一重拼。
- 联络表：`~/mh-jobs/shots/GP1/fr/ch10-contact-{land,port}-fr.png`。
