# REVIEW-en-self.md · 英文母版九项自审（RULING-20261012-gp1 §3）

> 状态：**进行中（未全过）** — 第14趟（2026-10-12 Mac mini 无人值守）开审。
> EN 十章 + OP 开场 + ED 片尾已合成，全片 master + 速览 + 20~40s 分段齐。
> **本趟结论：EN 尚未清关、不得开录中俄法**——item-3 待业主定遮蔽口径、item-4/item-8 待下趟执行、item-2 余 5 章联络表待逐张亲验。
> 成片（不入 git/mh-jobs）：~/guide/dist/partner/{full,trailer,OP,ED}-{land,port}-en.mp4 + segments/{land,port}/{full,trailer}-en-segNN.mp4 + manifest-en.json。

## 成片规格（实测）
- 全片 master：land 1920x1080 / port 1080x1920，**443.2s（7分23秒）**，真 Chrome 播放 readyState4、seek 近尾、零 pageErr。
- 速览 master：land/port **177s（约2分57秒）**，真 Chrome 播放通过。
- 全片分 **13 段**（12×[27.5~38.7s] + ED 尾段 13s），速览分 **6 段**（5×[28.1~39.4s] + ED 尾段 13s）；各段逐段 probe 有 video+audio，段时长和 = master。
- OP 开场 54.8s（OP-1 品牌卡 / OP-2..5 四条重点卡 / OP-6 目录卡），ED 片尾 13s（ED-1 四条回顾 / ED-2 二维码）。

## 九项逐条

| # | 审项 | 结论 | 证据 / 说明 |
|---|---|---|---|
| 1 | 每镜 expect/forbid 全过；跟随镜 IoU≥0.90、边差≤6px | ✅（录制时闸过） | 各章录制时逐镜 expect/forbid + IoU 闸在 rec.mjs 内强制，10 章录前/录后 verify 16/16 全过（见各趟回执）。全片级为各章成片直接拼接，未改帧，闸值不变。 |
| 2 | 每章横竖联络表推 shots/GP1/en、**逐张亲眼看图** | ⚠ 部分 | 本趟生成全 10 章×横竖共 20 张联络表（每镜段中一帧，网格；drawtext 未编入此 ffmpeg 故镜序见 manifest）。**本趟已亲验**：ch1·ch3（前趟）、**ch6**（双盲最敏感：盲码 SCH-xxxxxx + 「校名待揭晓」，仅解锁后 Demo University，无真校名，无 @gmail）、**ch7**（¥0 / 通知书 / JW202 / 建档，皆 Demo University 演示数据，无 @gmail）、ch4 页头区。**余 ch2/ch5/ch8/ch9/ch10 联络表已生成、待下趟逐张亲验**。 |
| 3 | 全片任何帧无真邮箱/电话/WhatsApp/护照号/邀请码明文 | ⚠ **待业主定** | **@gmail 洁净**（演示生/测试号经 MASK 全盖成 agency.demo@example.com，多帧肉眼复证）；注册盒邀请码为掩码占位 MAXHOUSE-PARTNER-XXXX；护照号画面未见明文。**发现（D-14-3）**：登录后 partner-portal 页头（ch2..ch10 几乎每镜）右上常驻**平台自有**客服联系：WhatsApp/电话 `+49 152 24910967` + `Service@maxhouses.net`（maxhouses.net 平台自有域）。此为平台自有公开联系、非学生 PII/非对手校/非双盲破墙。item-3 字面（禁电话/WhatsApp/邮箱）与「平台自有营销联系」存歧义 → **留业主一句话定：A 保留不遮（视为平台客服联系）/ B 必遮（需扩 MASK 重录 ch2..10 或后期打码页头区）**。见 DECISIONS D-14-3。 |
| 4 | 字幕↔按钮逐镜对账表（GS-5 式） | ⬜ 待下趟 | 大表，需逐镜核「字幕提到的按钮/标签名」与画面真实文字一致。**已知待修（前趟记）**：1-1 capEN 引号内「Register your agency」≠真按钮「New agency? Register →」，拟去引号改指令式（口播词不变→voice 不重生）。 |
| 5 | 7-0：¥0 大字橙框内连续可见≥2s（逐帧量） | ✅ | ch7-land 7-0：6s、8s 两帧均见 ¥0 大字在橙色框内（间隔2s、连续可见），之后转「Payment Successful」；字幕「Enter the coupon code — ¥0. No agency fee, no application fee.」。与 trip11 设计（¥0 停≥2s）一致。 |
| 6 | 字幕横版≤2行、竖版≤3行48px，无溢出；配音不超镜长不截断 | ✅（字幕；配音随镜已校） | 最长章字幕 6-2（115 字符）实测：land 2 行、port 3 行，均在字幕带内无溢出（裁带肉眼复证）。配音每镜段时长 = max(录制视长, 配音+0.45~0.5s)，故不截断（prod-ch/gp1-finish 公式）。 |
| 7 | 四语字幕禁用词扫描（零中介/没有纠纷/优先审核/半价/绕过GPA·HSK/真名校名） | ✅ EN+中；RU/FR 待建 | shots-v1.json capEN+capZH 全镜扫描 **0 命中**（禁用词 + 真名校名正则，含清华/北大/复旦等）。RU/FR 字幕尚未建（录中俄法阶段随建随扫）。 |
| 8 | 片尾二维码逐语言解码 = https://www.maxhouses.net/partner-portal/?src=video-<语言> | ⬜ 待下趟 | ED-2 二维码由 qrcode 模块按 `...?src=video-en` **生成即正确**（构造保证）；**逐帧解码核验待装解码器**（本机无 zbar/jsqr，下趟 npm 装 jsqr+pngjs 后对成片抽帧解码）。 |
| 9 | 整片与速览齐全、按镜界切 20~40s、时长与分镜相符 | ✅ | 全片 13 段、速览 6 段，皆按真镜界切（单镜最长 15.6s=OP-3，故每刀落镜界）；除 ED 片尾**刻意独立成 13s 收尾段**（ED-1 回顾+ED-2 二维码，片与速览一致）外全部落 [27.5,39.4]s。速览镜单照 RULING §1（删 6-5，第6/7章段 6-2/6-6→7-0/7-1/7-3）。manifest 见 segments/<orient>/。 |

## 尚缺（下趟清）
1. **item-3 业主裁决**：页头平台联系 A 保留 / B 必遮；若 B，扩 MASK 重录 ch2..10 或后期页头打码。
2. **item-4**：字幕↔按钮逐镜对账表 + 修 1-1「Register your agency」措辞。
3. **item-8**：装 jsqr+pngjs，对 ED-2（四语）二维码抽帧解码核地址。
4. **item-2**：ch2/ch5/ch8/ch9/ch10 联络表逐张亲验。
5. 全部过后 → 开录 中/俄/法（RU/FR 字幕随建随做 item-7 扫描）。

## OP-2..5「快剪」暂缓（记账，D-14-2）
storyboard OP-2..5 写「重点卡+2s章节快剪」。本趟先出重点卡满帧（卡面即四条重点逐字文案，文字未改），**快剪插入作上线前润色暂缓**；重点卡已完整达意，上线阶段可据各章成片补 2s 快剪（叠于卡面/接卡后，voice 不动）。非四种停下情形。
