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
