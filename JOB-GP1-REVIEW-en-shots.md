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
