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
