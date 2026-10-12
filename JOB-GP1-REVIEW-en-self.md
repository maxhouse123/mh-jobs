# REVIEW-en-self.md · 英文母版十一项自审（返工后·review1 §六）

> 状态：**十一项全过 · EN 返工清关 ✅** — 第37趟（2026-10-13 Mac mini 无人值守）收口。
> 本文件是返工后的 v2 自审，覆盖并取代第15趟的九项版（v1）。返工依据：RULING-20261012b-review1.md（十一项、四语）+ RULING-20261012c-rework.md。
> 逐镜对账表（第十一项）见 `REVIEW-en-shots.md`（随返工逐章/逐镜追加，**0 条「否」**）。
> **铁律15 人眼闸仍在**：业主上线前亲验成片，第3项「页头平台自有联系保留不遮」届时可一句话改判。
> 成片（不入 git/mh-jobs）：`~/guide/dist/partner/{full,trailer,OP,ED}-{land,port}-en.mp4` + `segments/{land,port}/{full,trailer}-en-segNN.mp4`。v1 成片在 `_v1/` 留底。

## 成片规格（EN，本趟 ffprobe 实测）
- 全片 master：land **426.6s** / port **424.7s**（约 7 分 05 秒）。
- 速览（trailer）master：land **164.3s** / port **162.8s**（约 2 分 44 秒）。
- OP 开场 **54.8s**（OP-1 品牌卡 / OP-2..5 四条重点卡**已做快剪** / OP-6 目录卡）；ED 片尾 **13.0s**（ED-1 四条回顾 / ED-2 二维码）。
- 分段：全片 land/port 各 **12 段**、速览各 **5 段**（含 ED 尾段），各段逐段 probe 有 video+audio。
- 全片含章节：ch1–ch10（ch1-3/5/7-10 为 v185 定版重录；ch4/ch6 review1 未标工作台背景缺陷、照 trip21 返工版/原版入拼）+ OP + ED。

## 十一项逐条

| # | 审项 | 结论 | 证据 / 说明 |
|---|---|---|---|
| 1 | 每镜 expect/forbid 全过；跟随镜 IoU≥0.90、边差≤6px | ✅ | 各章 v185 定版重录时逐镜 expect/forbid + IoU 闸在 rec.mjs 内强制，录前/录后 verify **17/17 PASS**（见各趟回执）；8 录屏各镜 hl 全 resolve、零 MISS。 |
| 2 | 每章横竖联络表推 shots/GP1/en、**逐张亲眼看图** | ✅ | 返工各章联络表取帧点＝**每镜字幕中点**（review1 §六新口径），逐张亲验画面↔字幕一致；见 REVIEW-en-shots.md 各章「逐张亲眼复验」行。 |
| 3 | 全片任何帧无真邮箱/电话/WhatsApp/护照号/邀请码明文 | ✅（选 A·页头平台联系保留，业主亲验可改判） | 全片各章 DOM 扫描 **no @gmail**（演示生/机构经 MASK_INIT 全盖 `agency.demo@example.com` / `firstname.demo@example.com`）；邀请码掩码、护照号样号 DE1234567、SPECIMEN 样件。页头平台自有 WhatsApp/Email（maxhouses.net 平台域）= 平台公开客服、非第三方 PII、非双盲破墙 → CC 自处理选 A 保留（D-15-1）。 |
| 4 | 字幕↔按钮逐镜对账（GS-5 式） | ✅ | 凡字幕点名控件/标签，逐字引真控件文本（从 DOM 读）。返工修：1-1「New agency? Register」、3-1「Submit New Student Referral」逐字引真控件；5-2/7-4 等按 review1 §三改述真画面。全表见 REVIEW-en-shots.md（第十一项）与 REVIEW-en-caption-button-audit.md。 |
| 5 | 7-0：¥0 大字橙框内连续可见≥2s（逐帧量） | ✅ | ch7 7-0：`.payment-amount-value`「¥0.00」在橙框 UNLOCK FEE—TOTAL DUE 内，同屏 ¥3,000.00 删除线 · MAXHOUSE −¥3,000.00；¥0 连续可见 ≥2s 后转成功页（见 en-shots 7-0 行）。 |
| 6 | 字幕横版≤2行、竖版≤3行48px，无溢出；配音不超镜长不截断 | ✅ | 各镜字幕在字幕带内无溢出（裁带复证）；每镜段时长 = max(录制视长, 配音+0.45~0.5s)，配音不截断（prod-ch/gp1-finish 公式）。 |
| 7 | 四语字幕禁用词扫描（零中介/没有纠纷/优先审核/半价/绕过GPA·HSK/真名校名） | ✅ | 本趟对 captions-v1.json 全 **57 镜 × 4 语**正则扫描（禁用词 EN/ZH/RU/FR 变体 + 真名校名中/拉写），**0 命中**。 |
| 8 | 片尾二维码逐语言解码 = https://www.maxhouses.net/partner-portal/?src=video-en | ✅ | 本趟对成片 `ED-{land,port}-en.mp4` 抽实帧经 jsQR **真帧解码**：横竖两版均解出 `https://www.maxhouses.net/partner-portal/?src=video-en`，逐字一致（非再生成，是对实际画面的解码）。 |
| 9 | 整片与速览齐全、按镜界切 20~40s、时长与分镜相符 | ✅ | 全片 12 段 / 速览 5 段，皆按真镜界切；除 ED 片尾刻意独立成尾段外落 [20,40]s 内。速览镜单照 RULING §1 + review1 §二.5（删 6-5；6/7 章段 6-2 → 7-0/7-1/7-3）。 |
| 10 | **数字与状态合理**（无负数/无矛盾统计/无 beta·test 控件/无残留数据） | ✅ | 缺陷1（负数金额）：v185 定版重录后 hero「TOTAL PAYMENTS PROCESSED **¥0**」、推荐生卡「Invested on this student: **¥0**」全片无负数。缺陷2（全 0 漏斗）：中介端 v185（RULING-d/e，2026-10-12 21:38 上线）已修，2-2 漏斗 **9→3→2→1 · 5 offer · 人均 0.6**（真值）。beta/内测/test 控件：7-1 的 `.cloud-offer-unlock` beta 链接由录制层 HIDE_INIT 在原始帧即遮、OP-4 定格避开「Paid (beta placeholder)」吐司；captions 全 57 镜扫描无 beta/test 字样。残留：ch3 §四草稿残留已清并加入 st-ch3-cleanup + verify #17（pt-01 draft==基线）。 |
| 11 | **逐镜对账表** | ✅ | `REVIEW-en-shots.md`：每镜取字幕中点帧、高亮区 DOM 实际文字、是否同一件事；**0 条「否」**。 |

## review1 逐条如何处理（EN）
- **§一（工作台数字）**：缺陷1 数据层修（已 v185 定版重录各含工作台章，¥0 无负数）；缺陷2 判定为**产品算法问题**（漏斗读废弃列 students.stage + 对云端生硬编码 0），已由中介端 v185 修复上线（RULING-d/e）→ 不再阻塞，含工作台章 ch1/2/3/5/7/8/9/10 全 v185 定版重录。
- **§二（ch6 去「解锁→揭晓」）**：trip21 删 6-4/6-6 + 去 `_p130_SchoolCache` 注入 → ch6 = 6-1→6-2→6-3→6-7 全程只读；6-3 改「Compare, then accept the one you prefer.」、7-1 改「The university is revealed — download the admission letter here.」+ 两段高亮（先校名条后下载钮，trip31 hl2）；beta 链接 MASK_INIT 盖住；速览镜单改 6-2 → 7-0/7-1/7-3。
- **§三（字幕对账）**：2-2/2-4（改述真漏斗/真标签）、5-2（改述退回理由）、5-4（真态·审核中徽章）、7-4（改「Admission complete.」＝状态行逐字）、8-1（改「You've submitted nine students.」）、9-2/9-3（照产品服务名 Audit/Human-assisted 改）。
- **§四（残留）**：ch3 草稿残留清理入 st-ch3-cleanup + verify #17；真提交生即标 is_test；真 submit 不发邮件/通知（trip20 实证）。
- **§五（开场快剪）**：OP-2（trip26）+ OP-3/4/5（trip36）全做——每卡先满屏 2.5s 再切该章真实画面叠标题条，配音不动、卡总时长不变。
- **§六节奏（3-1/3-8/5-1）**：rec.mjs `preOff` 把导航/加载/真提交放镜外，字幕说的东西全窗口在画面。

## 留给业主的产品问题（EN 复核所见，详见 SUMMARY）
1. 卡状态徽章颜色对已匹配/已入学生恒显 pending 蓝（`students.stage` 列全库 NULL，`s.status=r.stage||'pending'`，L7311）——标签已对、颜色语义不一致。
2. 中介端工作台无「名额已用/剩余」显示（故 2-2 改述漏斗）。
3. 录取弹窗底部 beta「Unlock to view (status flip only, no payment)」内测链接，真实中介也看得见（视频里已遮）。
4. 7-0 付款成功页末尾「Paid (beta placeholder)」吐司（OP-4 定格规避）。
