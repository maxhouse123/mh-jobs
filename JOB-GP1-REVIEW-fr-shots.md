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
