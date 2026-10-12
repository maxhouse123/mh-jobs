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
