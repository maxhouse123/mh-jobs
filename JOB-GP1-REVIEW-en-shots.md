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
