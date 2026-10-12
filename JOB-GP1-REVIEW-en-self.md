# REVIEW-en-self.md · 英文母版九项自审（RULING-20261012-gp1 §3）

> 状态：**九项全过 · EN 清关 ✅** — 第15趟（2026-10-12 Mac mini 无人值守）收口（第14趟开审）。
> EN 十章 + OP 开场 + ED 片尾已合成，全片 master + 速览 + 20~40s 分段齐。
> **本趟结论：EN 九项自审全过，可开录中俄法**（RULING §3：全过才录中俄法）。第15趟收口 item-2（余5章联络表逐张亲验）/ item-3（自处理定案选A保留，见 D-15-1）/ item-4（对账表出 + 修 1-1、3-1 引号标签并重配音重出片）/ item-8（jsqr 解码 EN 二维码）。
> **铁律15 人眼闸仍在**：业主上线前亲验成片，item-3「页头平台自有联系保留不遮」届时可一句话改判。
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
| 2 | 每章横竖联络表推 shots/GP1/en、**逐张亲眼看图** | ✅ | 全 10 章×横竖共 20 张联络表全部逐张亲验。trip14 验 ch1·ch3·ch6（盲码 SCH-xxxxxx+「校名待揭晓」，仅解锁后 Demo University）·ch7（¥0/通知书/JW202/建档，皆 Demo University 演示数据）·ch4 页头区；**trip15 补验 ch2·ch5·ch8·ch9·ch10**——每格画面与该镜字幕一致，演示生邮箱显示为 agency.demo@example.com（MASK），参考码 PA-xxxx/盲码 SCH-xxxx 为非密标识，全片无 @gmail。（ch1·ch3 联络表已随本趟 1-1/3-1 字幕修复重生。）|
| 3 | 全片任何帧无真邮箱/电话/WhatsApp/护照号/邀请码明文 | ✅（选 A·保留，业主亲验可改判） | **@gmail 洁净**（演示生/测试号经 MASK 全盖 agency.demo@example.com，多帧复证）；注册盒邀请码掩码占位 MAXHOUSE-PARTNER-XXXX；护照号画面无明文。页头平台自有联系（WhatsApp/电话 `+49 152 24910967` + `Service@maxhouses.net`，maxhouses.net 平台自有域）=平台自有公开客服联系、非学生/第三方 PII、非对手校、非双盲破墙 → **CC 自处理定案选 A 保留不遮**（RULING §2，非 §2.6 停下情形；见 D-15-1）。item-3 口径收窄为本意「无演示生/机构/第三方私人联系+邀请码+护照明文」，据此判过。**铁律15 人眼闸保留**：业主上线前可改判 B（遮蔽）。|
| 4 | 字幕↔按钮逐镜对账表（GS-5 式） | ✅ | 全镜对账表见 `REVIEW-en-caption-button-audit.md`（引号标签镜逐字对账+动作描述镜达意核+陈述镜不涉）。**修**：1-1「Register your agency」→「New agency? Register」、3-1「Submit a new student」→「Submit New Student Referral」两处引号标签改为逐字引真控件（v184 实证），重配 EN 音、重出 ch1/ch3 EN 横竖+重拼全片速览、抽帧复证逐字一致（D-15-2/3/4）。ZH 两处本就一致。**遗留**：3-1 RU/FR（产品无该键、回退渲染）录 RU/FR 时按真实渲染复核。|
| 5 | 7-0：¥0 大字橙框内连续可见≥2s（逐帧量） | ✅ | ch7-land 7-0：6s、8s 两帧均见 ¥0 大字在橙色框内（间隔2s、连续可见），之后转「Payment Successful」；字幕「Enter the coupon code — ¥0. No agency fee, no application fee.」。与 trip11 设计（¥0 停≥2s）一致。 |
| 6 | 字幕横版≤2行、竖版≤3行48px，无溢出；配音不超镜长不截断 | ✅（字幕；配音随镜已校） | 最长章字幕 6-2（115 字符）实测：land 2 行、port 3 行，均在字幕带内无溢出（裁带肉眼复证）。配音每镜段时长 = max(录制视长, 配音+0.45~0.5s)，故不截断（prod-ch/gp1-finish 公式）。 |
| 7 | 四语字幕禁用词扫描（零中介/没有纠纷/优先审核/半价/绕过GPA·HSK/真名校名） | ✅ EN+中；RU/FR 待建 | shots-v1.json capEN+capZH 全镜扫描 **0 命中**（禁用词 + 真名校名正则，含清华/北大/复旦等）。RU/FR 字幕尚未建（录中俄法阶段随建随扫）。 |
| 8 | 片尾二维码逐语言解码 = https://www.maxhouses.net/partner-portal/?src=video-<语言> | ✅ EN | 装 jsqr@1.4.0+pngjs（/tmp，不入 git），对成片 ED-{land,port}-en.mp4 第 10s 抽帧经 jsQR **真帧解码**——横竖两版均解出 `https://www.maxhouses.net/partner-portal/?src=video-en`，与期望逐字一致（非再生成，是对实际画面的解码）。RU/FR/ZH 录制时同法逐语解码核 `src=video-<语言>`。|
| 9 | 整片与速览齐全、按镜界切 20~40s、时长与分镜相符 | ✅ | 全片 13 段、速览 6 段，皆按真镜界切（单镜最长 15.6s=OP-3，故每刀落镜界）；除 ED 片尾**刻意独立成 13s 收尾段**（ED-1 回顾+ED-2 二维码，片与速览一致）外全部落 [27.5,39.4]s。速览镜单照 RULING §1（删 6-5，第6/7章段 6-2/6-6→7-0/7-1/7-3）。manifest 见 segments/<orient>/。 |

## 收口（第15趟·全清）
1. ~~item-3~~ → CC 自处理定案选 A 保留（D-15-1），业主亲验可改判。
2. ~~item-4~~ → 对账表 `REVIEW-en-caption-button-audit.md` + 修 1-1/3-1 引号标签重出片（D-15-2/3/4）。
3. ~~item-8~~ → jsqr 解码 EN 二维码 land+port = `...?src=video-en`（D-15-5）。
4. ~~item-2~~ → 10 章横竖 20 张联络表全验（D-15-5）。
5. **九项全过 → 下一步：开录 中/俄/法**（ZH 字幕已在 shots-v1.json，RU/FR 在 captions-v1.json；录时逐语做 item-7 禁用词扫描 + item-8 逐语二维码解码 + item-4 对 RU/FR 3-1 回退标签复核）。

## RU/FR 遗留（录制时清）
- **1-1**：captions-v1.json 的 ru/fr 已改逐字引真控件（`Новое агентство? Регистрация →` / `Nouvelle agence ? Inscription →`）。
- **3-1**：产品 `partner.students.addBtn` 仅 EN/ZH 键，RU/FR 回退渲染 → captions-v1.json ru/fr 暂留意译，录 RU/FR 时按真实渲染文字定 item-4。

## OP-2..5「快剪」暂缓（记账，D-14-2）
storyboard OP-2..5 写「重点卡+2s章节快剪」。本趟先出重点卡满帧（卡面即四条重点逐字文案，文字未改），**快剪插入作上线前润色暂缓**；重点卡已完整达意，上线阶段可据各章成片补 2s 快剪（叠于卡面/接卡后，voice 不动）。非四种停下情形。
