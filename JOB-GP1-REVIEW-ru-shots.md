# REVIEW-ru-shots · 逐镜对账表（review1 §十一）· RU

取帧点＝每镜字幕显示中点那一帧。高亮区文字从当时 DOM 读。随返工逐章追加。

## ch9 §三.6（增值服务名，返工第23趟 2026-10-12）
根因同 EN（增值服务区只在推荐生列表卡渲染；改不开弹窗、高亮列表卡真行）。
D-18-4：RU 界面里产品动态串回退成英文（PREMIUM SERVICES / Audit Service / Human-assisted Search / Inactive / Activate 均英文；boost 行与 Вложено 本地化）——产品真实行为，照录不补，写进 SUMMARY 产品问题。字幕用俄文点名服务并描述，与所框行指同一服务＝同一件事。

| 镜 | 字幕原文 | 高亮区 DOM 实际文字 | 同一件事？ |
|----|----------|---------------------|-----------|
| 9-1 | Дополнительные услуги — по желанию: | 📦 PREMIUM SERVICES · Вложено в студента: ¥0 | 是（框增值服务区标题行） |
| 9-2 | услуга Audit Service, снимающая базовый лимит в 2 предложения и дающая приоритетное размещение на 30 дней, | 🚀 Audit Service · Inactive · Activate ¥1,500 | 是（框 Audit Service 行；据 `partner.vapay.auditDesc` 重译回译） |
| 9-3 | услуга Human-assisted Search, где консультант Maxhouse составляет индивидуальный список вузов для студента, | 🤝 Human-assisted Search · Inactive · Activate ¥600 | 是（框 Human-assisted Search 行；据 `partner.vapay.searchDesc` 重译回译） |
| 9-4 | и платное продвижение, которое помещает студента в списки кандидатов большего числа вузов. | 📡 Платное продвижение · не активно … Активировать · от ¥4,500 | 是（框 Платное продвижение/Exposure boost 行，字幕未改） |

- 时长：land 26.46s / port 26.41s。no @gmail。章节条左标签「Partner Hub」(D-18-5)。演示生 Serikova Aizhan，无真 PII。
- 逐张亲眼复验（含 port 9-3 全分辨率）：各镜框对应行，port 下 Human-assisted Search 标签换行致行加高，高亮只罩该行、未越到 boost 行。
- item-7 RU 禁用词扫描：0 命中（_scan-ru-forbidden 73 串 PASS）。
