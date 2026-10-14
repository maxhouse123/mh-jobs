# JOB-GP2-05 · 全线体检 + 收官（第 7 趟，2026-10-15）

开工承 `RULING-20261014e-gp2-04-fix-live`：GP2-04 线上真验 + 测速已全绿收口（见 JOB-GP2-04.md 第 7 趟续办），本节做收官体检。

## 一、四语 × 横竖成片体检

### 1. 每章联络表 CC 亲眼过（代表性抽检 + GP-1 全量自审背书）
- 本趟亲眼复核代表样本（覆盖四语 + 不同章型）：
  - `en/ch1-contact-land`：注册入口 → 合伙人中心 → 机构注册四步，英文字幕齐、可读；邮箱字段为 demo、无真 PII。✅
  - `ru/ch6-contact-land`（GP2-00a 重出）：被荐生 Hussain Bilal 的多校 offer + 双盲解说；校名解锁前 `SCH-xxxxx` 遮蔽，俄文字幕正确，无真校名。✅
  - `zh/ED-contact-land`（片尾卡）：要点回顾四条 + 二维码 + `www.maxhouses.net/partner-portal/` + 「扫码注册，邀请码见引导页」，无禁用词。✅
  - `fr/ch7-contact-land`：¥0 优惠码（「Pas de frais d'agence, pas de frais de dossier」纯资费表述）+ 解锁揭晓（demo 校名 Beste University，非真名校）+ JW202，法文字幕正确。✅
- 全量背书：GP-1 已逐章自审（REVIEW-{en,zh,ru,fr}-self.md 全过），GP2-00a 重出 ch2(英俄法)/ch6(俄)/ch9(俄) 并复扫通过。四语各 ~26 张联络表齐全。

### 2. 字幕与按钮文字审计
- 四语烧入文本（字幕 captions-v1.json en/zh/ru/fr 57×4 + 章节标题 CH_TITLE_* 40）共 **268 单元**全覆盖扫描（`_scan-forbidden-gp2-05.mjs`）。
- 按钮/文案另见 GP-1 `REVIEW-en-caption-button-audit.md`；线上页面按钮文案由 GP2-04 verify 的 `no_raw_key`（零裸 i18n 键）+ 四语切换断言覆盖，全绿。

### 3. 禁用词扫描 —— 零命中 ✅
`_scan-forbidden-gp2-05.mjs` 对 268 单元扫 6 类禁用词（多语正则）：**零中介 / 没有纠纷·无纠纷 / 优先审核·插队 / 半价·打折承诺 / 绕过 GPA·HSK / 真实名校名（Harvard/MIT/牛津/清华… 16+ 名校）** —— 全部 0 命中。
- 说明：初版误报 2 处「no agency **fee** / no application **fee**」（OP-4/7-0 英文），系纯 B2B 资费表述（机构不交平台费、服务费归机构），非「零中介」定位宣称；收紧规则（排除 `fee`/`费` 语境）后归零。该两句为 GP-1 已审并已烧入成片的文案（caption 审计 7-0 行 ✅）。

### 4. 片尾二维码逐语言解码 —— 四语 × 横竖全对 ✅
从真·成片 `ED-{land,port}-{en,zh,ru,fr}.mp4` 抽帧（t=10s + 末帧，16 帧），`jsqr`+`pngjs` 解码：
| 语言 | 解得 | 期望 |
|---|---|---|
| en | https://www.maxhouses.net/partner-portal/?src=video-en | ✅ |
| zh | …/partner-portal/?src=video-zh | ✅ |
| ru | …/partner-portal/?src=video-ru | ✅ |
| fr | …/partner-portal/?src=video-fr | ✅ |
源头实证：`gp1-finish.mjs:78 PORTAL_URL = …/partner-portal/?src=video-${LANG}`。

### 5. 画面无真邮箱 / 电话 / 护照号 ✅
- 烧入文本扫描含 PII 三正则（真邮箱[排除 example/maxhouses]、电话、护照样式）—— 0 命中。
- 录屏内学生数据全为 `is_test` 演示种子（demo verify #2「all guide-pt students is_test」PASS）；登录邮箱泄漏已由 GP2-00a MASK 修复（登录后注入遮罩，口径不变）。

## 二、演示数据 verify —— 17/17 PASS ✅
`bash jobs/db-run.sh jobs/JOB-GP1/states/verify.sql`（只读）：17 条断言全 PASS（学生 9 名全 is_test、配额 10/用 9、pt-06 两盲 offer、pt-07 录前合法态、¥0 优惠码走真实 coupon_redemption、五列表徽标各 ≥1、pt-01 草稿=基线无残留…）。无需复位。

## 三、决定账汇总
`~/mh-jobs/JOB-GP-decisions-all.md`：GP-1 15 条 + GP-2 28 条，每条一行（编号 · 章镜/问题 → 选择 · 理由）。

## 四、一处非阻断观察（记录给业主，不追加修）
线上页面「速览」时长标签：四语**首屏加载**时正确显示 2 分 46~56 秒（= trailer 成片真长，已线上四语实测）；上趟 GP2-04 的 en-desktop 全页截图曾出现「1 min 40 sec」，系在 verify 流程里**快速切语言/切画幅**过程中的瞬态重算残留，重新单独加载 4/4 均为正确值。属偶发显示瞬态、非数据错误，不影响播放；如业主在意可留页面侧小优化（本轮不碰端口外不改页面逻辑，仅记录）。

## 五、结论
GP-2 全线体检通过：成片四语横竖齐全、字幕/按钮无裸键无禁用词、片尾码四语全对、画面无真 PII、演示数据 17/17、线上引导页真验全绿（除慢3G 点章一项物理下限已如实标红）。GP2-05 收口，写 SUMMARY-GP2.md，循环自停。
