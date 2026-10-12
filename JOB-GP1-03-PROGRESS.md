最后一趟：2026-10-12 第19趟 — **GP-1 视频制作收官：EN·ZH·RU·FR 四语四件套全齐 ✅**。本趟先补完 RU 全片合成(D-19-1/2/3)，再全程做完 FR(D-19-4/5)。① RU 全片合成：gp1-finish 的 KEYPOINT_TITLE/RECAP_LINES/BRAND_CARD/CATALOG_TITLE/RECAP_EYEBROW 补 ru(标题逐字取 ED-1.ru 回顾串保 OP/ED 一字一致)+capFor 加 ru/fr 读 captions-v1.json；bookend/film/trailer --lang ru → full 467.4s(14段零漂移)/trailer 187s(6段)/OP59.7/ED14.7；item-8 解 ED-ru=...?src=video-ru；真 Chrome 播放全 readyState4/pageErr0；五卡肉眼复验俄文无豆腐块。② FR：工装 prep(CH_TITLE_FR + 3-5/3-6 pre_fr + 8-3 act_fr + gp1-finish fr 卡面，capFor 已通用)；逐章 verify16/16→(置态)→录横竖→(复位)→verify，置态章复用语言无关 scoped 件(ch3 真submit MH-7CTJXC 两版DELETE1×2复位/ch4/ch6/ch7 ¥0真付 DELETE1+基线INSERT1)，**全程 baseline 16/16 守住**；真帧复验 ch1法文门禁+章节条/ch3 app_no/ch6 demo联系无真PII/ch7 ¥0橙框+masked邮箱；20录屏 DOM 扫描 no @gmail；item-7 FR 74串0命中PASS；FR 合成 full 460.3s(13段)/trailer 179.9s(6段)/OP56/ED13.9；item-8 解 ED-fr=...?src=video-fr；真 Chrome 全过。四语对账 0 缺(各 20 章+4 bookend+2 full+2 trailer+分段齐，联络表各20张推 mh-jobs/shots/GP1/<lang>/)。full 时长 EN443/ZH459/RU467/FR460s。章节条左标签 ru/fr 保"Partner Hub"(=产品FR门禁页头字面，与 RU 发货一致，业主眼验可一句话要求 RU+FR 同本地化)。film seg12(FR45.4=ZH44.9先例)/trailer seg05(RU42.8)略超40 = collapse 并孤段所致，接受记账。**下趟：GP-1 已收官——写 SUMMARY-GP1.md(PUSH_OK=yes)即停；不开 GP-2(不传R2/不动Cloudflare/不推主仓库)**。成片在本机 guide/dist/partner/，不入 git/mh-jobs。不推主仓库、不上线。

# JOB-GP1-03 进度交接（**视频制作已收官 · EN·ZH·RU·FR 四语全齐**）

## 第 19 趟（2026-10-12 Mac mini 无人值守）· RU 全片合成 + FR 全程 → GP-1 视频制作收官
### A. RU 全片合成（D-19-1/2/3）
- **gp1-finish ru 卡面**：KEYPOINT_TITLE/RECAP_LINES 逐字取 captions-v1.json ED-1.ru 俄文回顾串(① Одна подача — много вузов ② Ваш студент остаётся вашим ③ Никаких сборов платформы ④ Заполняет вуз — доставляем вам，OP/ED 一字一致)；BRAND_CARD.ru/CATALOG_TITLE.ru「Десять коротких глав」/RECAP_EYEBROW.ru「КРАТКО」；capFor 加 ru/fr 读 captions-v1.json(OP-2..5 正文+ED-2 说明本语，en/zh 不动)。
- **合成**：bookend OP 59.7s/ED 14.7s；film full-land/port 467.4s(14 段,masterDur==unitSum 零漂移)；trailer 187.2/187.5s(6 段)。item-8 ED-ru 横竖=`...?src=video-ru`。真 Chrome 播放全 readyState4/seek 近尾/pageErr0。五卡(OP-1/5/6、ED-1/2)肉眼复验俄文无豆腐块、品牌紫橙、OP/ED 四条一字一致。
- **分段 OOR**：trailer seg05=42.8s(超40，[6-2,6-6,7-0,7-1,7-3])——collapse 把 7-3 孤段并回所致(RU 配音更长落点不同)；接受(两害取其轻，孤段<20更糟)。film 仅 ED 尾段 14.7s(刻意)。
### B. FR 全程（D-19-4/5）
- **工装 prep**：prod-ch 加 CH_TITLE_FR(+CH_TITLE_FOR fr)；_patch-fr-shots.mjs 为 3-5/3-6 加 pre_fr(AI 预检法文样例)+8-3 act_fr(提额理由法文)；gp1-finish 卡面加 fr(标题取 ED-1.fr)。capFor 已通用。FR voice 59件+durations、captions 58/58 有 fr 齐。
- **逐章录制**：每章 verify→(置态)→录横竖→(复位)→verify。读-only(1/2/5/8/9/10)直录；置态章复用语言无关 scoped 件——ch3=st-ch3-cleanup(真 submit app_no MH-7CTJXC，两版各 DELETE1×2+COMMIT→verify16)；ch4=st-pt04-docs-full 置态+st-pt04-reset-cleanup(UPDATE1+DELETE1,两版 verify16)；ch6=st-pt06-reset(UPDATE1,两版 verify16)；ch7=录前空跑证复位可靠→st-pt07-pay-cleanup+st-pt08-jw202 置态→录→st-pt0708-reset-cleanup(真¥0付 DELETE1+基线¥0单 INSERT1,两版 verify16)。**全程 baseline 16/16 守住**。
- **真帧肉眼复验**：ch1 门禁「Connexion partenaire / Nouvelle agence ? Inscription」+章节条「Chapitre 1 Inscription et activation」；ch3 3-8 app_no MH-7CTJXC 橙框+Demo Aisha+3-9「en attente」；ch6 6-6 揭晓全 demo 联系(maxhouse_demo/demo@maxhouses.net/+86…0000)「L'université est révélée」无真 PII、6-7 SCH-1AD6C8 盲码；ch7 7-0 ¥0.00 橙框内+划除¥3,000·MAXHOUSE−¥3,000+masked agency.demo@example.com/MH-NEPTRN。20 录屏 DOM 扫描全 ✅ no @gmail。
- **item-7 FR**：_scan-fr-forbidden.mjs 扫 74 条 FR 串 → 0 命中(5 类禁用词+真名校名)，PASS。
- **FR 合成**：bookend OP 56.0s/ED 13.9s；film full-land 460.3/port 458.9s(13 段零漂移)；trailer 179.9/178.8s(6 段)。item-8 ED-fr=`...?src=video-fr`。真 Chrome 全过。OP-6「Dix courts chapitres」+10 章 FR 标题、ED-1「EN BREF」+4 行=OP 标题一致，无豆腐块。
- **分段 OOR**：film seg12=45.4s([8-4,9-1..9-4,10-2..10-4])——与 **ZH film seg12=44.9s(已过自审发货)同一先例**，collapse 并孤段，接受记账。ED 尾段 13.9s(刻意)。
### C. 四语对账 + 章节条左标签
- **对账 0 缺**：EN/ZH/RU/FR 各 20 章 mp4 + 4 bookend + 2 full + 2 trailer；分段 full(en/zh/fr 26=13×2、ru 28=14×2)+trailer(12=6×2)；联络表各 20 张(en 21)推 ~/mh-jobs/shots/GP1/<lang>/。full-land 时长 EN443/ZH459/RU467/FR460s。
- **章节条左标签 ru/fr 保「Partner Hub」**：= 产品 FR 门禁页头字面「ESPACE PARTENAIRES · PARTNER HUB」+与已发货 RU 一致；仅 ZH 本地化为「合作伙伴端」。业主眼验闸(铁律15)可一句话要求 RU+FR 同本地化(仅重烧章节条,代价小)。
- **改了(主仓库,不推)**：rec/gp1-finish.mjs(ru+fr 卡面、capFor ru/fr)、rec/prod-ch.mjs(CH_TITLE_FR + capFor ru/fr 已在 D-18-1)、rec/shots-v1.json(3-5/3-6 pre_fr、8-3 act_fr)、rec/_patch-fr-shots.mjs(新)、rec/_scan-fr-forbidden.mjs(新)、DECISIONS.md。成片/voice 不入 git/mh-jobs。
### D. 收官状态
- **GP-1 视频制作收官**：四语横竖四件套全齐在本机 guide/dist/partner/。EN 九项自审全过(trip15,REVIEW-en-self.md)；RU/FR 逐趟做 item-7 禁用词扫+item-8 QR 解码+真帧脱敏复验+真 Chrome 播放。DB 全程 baseline 16/16 守住。
- **下一步=写 SUMMARY-GP1.md(PUSH_OK=yes)即停**。不开 GP-2：不传 R2、不动 Cloudflare、不推主仓库。

## 第 18 趟（2026-10-12 Mac mini 无人值守）· 开录俄语 RU → RU 十章横竖齐 10/10
- **工装两修（RU 片本会带错内容，先修再录）**：
  - **D-18-1 字幕源**：prod-ch.mjs capFor() 对 ru/fr 原直返 capEN（注释称 ru/fr 全片阶段再处理，实为 film 只拼接不重烧→照原注释 RU 永久英文字幕）。改 ru/fr 分支从 captions-v1.json 取 c[lang] 译文；en/zh 仍从 shots-v1.json 原样取（EN 母版+ZH 基线逐字节不变）。首帧实证修好（ch1 字幕俄文）。
  - **D-18-2 章节条标题**：加 CH_TITLE_RU（照 EN 母版逐章译+回译自检，从简控宽防省略框溢出）+ CH_TITLE_FOR ru 分支。同 ZH 走 CH_TITLE_ZH 处理。章节条「Глава N  <RU标题>」逐帧复验无溢出。
- **D-18-3 镜级 RU 变体**：3-5/3-6 加 pre_ru（琥珀 AI 预检卡俄文样例 issues，产品 _wzRender 渲染 RULING §1.2）；8-3 加 act_ru（#qrReason 俄文自由文本）。经 rec/_patch-ru-shots.mjs 落 shots-v1.json。
- **D-18-4 RU UI 俄/英混排 = 真实产品**：v184 的 RU = REP_I18N ru 词典 + I18N_RU + LL(zh,en) 两语助手；LL 动态拼接串（Quota raise pending / Your referral performance / STUDENTS SUBMITTED 等）在 ru 回退英文，词典覆盖处显俄文 → 画面俄英混排。照 RULING §二.1 照录真实画面；修它须改端口 i18n 码（§0.2 禁，亦 §二.6② 停下情形），**不改、记账、继续**。业主上线前亲验可另判。
- **D-18-5 8-4 已批卡保持英文**：RU 下待审卡本回退英文，base pre 命中（真帧 box 2200x127），注入英文已批卡与上下文一致；不加 pre_ru。旁白字幕仍俄文。
- **逐章录制（D-18-6）**：每章 verify16/16→(置态)→录横竖→(复位)→verify。
  - 读-only/零DB 章（1/2/5/8/9/10）直录（baseline 不动）。
  - 置态章复用 ZH 趟 scoped 件（**语言无关**）：ch3=st-ch3-cleanup（真 submit 耗名额 9→10，真 app_no MH-Y68WT2，录后单删复位）；ch4=st-pt04-docs-full 置态 + st-pt04-reset-cleanup 复位（app_no MH-EXET28 不覆写）；ch6=录后 st-pt06-reset（两 offer unlocked_at 清 + student_response 回 pending）；ch7=st-pt07-pay-cleanup+st-pt08-jw202 置态 + st-pt0708-reset-cleanup 复位（录前先空跑状态往返证复位可靠=16/16 再录）。
  - 真写库镜（ch3 submit / ch4 submitted_at / ch6 unlocked_at / ch7 ¥0 真付 letter_paid_at+核销）均录后 scoped 复位，**每章 verify 16/16，全程基线守住**。无全量 rebuild（本机 faces 空 0/201，D-16-4）。
- **真帧肉眼复验（抽帧）**：ch1 门禁「Вход для партнёров」/入驻表单俄文/工作台「Партнёр · одобрено」（+英文回退 Quota raise pending 真实产品）；ch3 琥珀卡「Напоминания предварительной проверки」+我注入 RU issue + app_no MH-Y68WT2 橙框；ch6 6-6 揭晓「🔓 Demo University · 演示大学 · Wuhan/武汉 · SCH-1AD6C8」全 demo 联系（+86…0000/demo@maxhouses.net/maxhouse_demo）无真 PII；ch7 7-0「Плата за разблокировку письма о зачислении」¥0 大字橙框内（§3.5）+划除 ¥3,000·MAXHOUSE−¥3,000、masked agency.demo@example.com/MH-NEPTRN；ch8 8-3 目标30+「Ожидаем больше студентов…」+Отмена俄文；ch4 已发邀请两行 aizhan.demo@/agency.demo@example.com 全掩码、Отозвать俄文。
- **脱敏（铁律9）**：20 录屏 DOM 扫描全 ✅ no @gmail；画面层演示邮箱 firstname.demo@/agency.demo@/aizhan.demo@example.com；邀请码 MAXHOUSE-PARTNER-XXXX 掩码；SCH-/MH-/PA- 为非密标识。
- **item-7（RU 禁用词扫）**：rec/_scan-ru-forbidden.mjs 扫 74 条 RU 串（caption ru + keypoint ru + CH_TITLE_RU + AI 注入）对 5 类禁用词 + 真实名校名 → **0 命中，RU 过**。
- **交付**：~/guide/dist/partner/ch1..10-{land,port}-ru.mp4（各带音轨/1920x1080·1080x1920）；联络表 ~/mh-jobs/shots/GP1/ru/ch1..10-contact-{land,port}-ru.png（20 张）。
- **DB**：全程 baseline 16/16 守住（置态章 scoped 置态+复位，ch7 录前空跑证复位）。
- **成片现状**：EN 全齐(清关) · ZH 全齐 · **RU 十章横竖齐 10/10**（本趟）· FR 待录。
- **改了**（主仓库，不推）：rec/prod-ch.mjs（D-18-1/2）、rec/shots-v1.json（D-18-3）、rec/_patch-ru-shots.mjs（新·工具）、rec/_scan-ru-forbidden.mjs（新·工具）、DECISIONS.md。**成片/voice 不入 git/mh-jobs**。
- **下趟**：RU 全片合成——gp1-finish 的 KEYPOINT_TITLE/BRAND_CARD/CATALOG_TITLE/RECAP_LINES/RECAP_EYEBROW 补 ru 分支（照 storyboard §一 四条重点 ru 标题，EN/ZH 不动）→ bookend/film/trailer --lang ru → OP/ED/full/trailer-ru + 20-40s 分段 → item-8 jsQR 解 ED-ru（期望 ...?src=video-ru）→ 真 Chrome 播放复证。再 FR（FR 复用 capFor 已通用，需补 CH_TITLE_FR + 3-5/3-6 pre_fr + 8-3 act_fr + gp1-finish fr 卡面）。

## 第 17 趟（2026-10-12 Mac mini 无人值守）· ZH 全片合成 → ZH 四件套全齐
- **gp1-finish 加 lang 感知（D-17-1）**：bookend 卡面硬编码英文本地化为 zh（照 storyboard §一「四条重点·定稿」中文标题 + CH_TITLE_ZH，逐字取、不自造、不改四条重点口径）。KEYPOINT_TITLE/RECAP_LINES/BRAND_CARD/CATALOG_TITLE 改 {en,zh} 两层；recapCard 加 eyebrow 形参（EN「IN SHORT」不变／zh「要点回顾」）；OP-6 列表改用 CH_TITLE_FOR(n,'zh')。EN 路径（LANG 默认 en）逐字节不变。
- **ZH 合成（D-17-2）**：bookend/film/trailer --lang zh。full-{land,port}-zh 459.4/458.3s(13段)、trailer 182.7/181.5s(6段)、OP 59.16s、ED 12.62s；分段 out-of-range 仅 ED 尾段(12.6s，同 EN 13s 先例有意保留)。短段并回：groupSegments 把 <20s 内容短段并回上段（ED 尾段不动）；film stage 加清 full-*-seg 旧段（防段数变动残留，为 RU/FR 防残留）。
- **item-8（D-17-3）**：jsQR 真帧解 ED-zh 横竖 = `https://www.maxhouses.net/partner-portal/?src=video-zh`，与 RULING §3.8 一致 ✅。
- **验证**：六张 OP/ED 卡(OP-1/3/5/6、ED-1/2 land)逐张肉眼复验——中文无豆腐块、品牌紫橙、OP-5 最长标题换行正、OP-6 十章中文齐、ED-1 四点中文=OP 标题一致、eyebrow=要点回顾、ED-2 QR+「扫码注册…」。真 Chrome 播放 full/trailer/seg01 land+port 全 readyState4/seek 近尾/pageErr=0；unitSum==master 零漂移；分段 land/port 各 full 13 + trailer 6。
- **DB**：本趟**零 DB 操作**（纯合成，baseline 16/16 自 trip16 未动）。
- **成片现状**：EN 全齐(trip15 清关) · **ZH 全齐**(本趟) · RU/FR 待录（资产就绪）。

## 第 16 趟（2026-10-12 Mac mini 无人值守）· 开录中文 ZH（ch1+ch2）
- **章节条本地化（D-16-1）**：gp1-overlays.chapterBar 加 `lang` 形参（默认 en，EN 母版逐字节不变）+ BAR_I18N（zh 左标签「合作伙伴端」/前缀「第 N 章」；ru/fr 预留）；prod-ch 加 CH_TITLE_ZH（照 storyboard 10 章名）+ CH_TITLE_FOR，chapterBar 调用传 LANG。抽 ch1 首帧肉眼复验中文正常无豆腐块。
- **ZH ch1（注册与开通，D-16-2）**：照 EN trip13 三登录态编排仅 `--lang zh`。零 DB 写入（baseline 不动，无需 rebuild）。成片 ch1-{land,port}-zh.mp4（49.46/49.48s，8 镜，1920x1080/1080x1920 带音轨）；联络表 shots/GP1/zh/ch1-contact-{land,port}-zh.png 逐张亲验（8 格齐、1-1→1-8 字幕↔画面一致、邀请码 MAXHOUSE-PARTNER-XXXX 掩码、演示邮箱 firstname.demo@example.com、零 @gmail）。
- **ZH ch2（工作台）**：CONTEXT 同 EN（2-5 toggleStuNotifPanel）。零 DB 写入。成片 ch2-{land,port}-zh.mp4（28.16/28.12s，5 镜）；联络表亲验（工作台/名额/进度/五档徽章/通知 五镜齐、中文 UI、仅演示生名、零 @gmail）。
- **item-3 页头平台联系**：ZH 片同 D-15-1 口径（平台自有 WhatsApp/+49…/Service@maxhouses.net 保留不遮，铁律15 人眼闸保留）。
- **DB**：开工 verify 16/16 PASS；ch1/ch2 零 DB 写入，baseline 未动。
- **成片现状（ZH）**：1·2·3·4·5·6·7·8·9·10 = **10/10 齐**。全量 rebuild 本机禁用（faces 空 0/201，D-16-4），有置态章一律 scoped 复位。


## 第 15 趟（2026-10-12 Mac mini 无人值守）· EN 英文母版九项自审全过 → EN 清关
- **item-2 收口**：ch2/ch5/ch8/ch9/ch10 横竖联络表逐张亲眼看图（接 trip14 已验 ch1/3/6/7+ch4页头）→ 10 章×横竖 20 张全验。每格画面与该镜字幕一致；演示生邮箱 = agency.demo@example.com（MASK），参考码 PA-xxxx/盲码 SCH-xxxx 为非密标识，全片零 @gmail。
- **item-3 自处理定案（D-15-1，解除 D-14-3 挂起）**：登录后 portal 页头常驻平台自有联系（WhatsApp/电话 `+49 152 24910967` + `Service@maxhouses.net`，maxhouses.net 平台自有域）= 平台自有公开客服联系，非学生/第三方 PII、非对手校、非双盲破墙。逐条比对 RULING §2.6 四种停下情形**全不命中**（不缺权限/不动产品码/非品牌承诺/不碰线上）→ CC 自处理+记账，**选 A 保留不遮**。item-3 口径收窄为本意（铁律6 零信任 PII）。**铁律15 保留**：业主上线前亲验成片可一句话改判 B（遮蔽，届时扩 MASK 重录 ch2..10 或后期打码）。
- **item-4 对账表 + 修引号标签（D-15-2/3/4）**：出全镜对账表 `REVIEW-en-caption-button-audit.md`（引号标签镜逐字对账/动作描述镜达意核/陈述镜不涉）。两处引号标签原为意译、与真控件不符 → 逐字改齐真控件（v184 实证：1-1 登录链接「New agency? Register →」、3-1 列表钮「Submit New Student Referral」；ZH 本就一致不改）。按 §2.2 重配 EN 音（删 1-1/3-1 m4a 重生，时长 4→3.6 / 1.44→1.834s）→ 用**缓存帧**（不重录、不碰DB、不碰portal）经 prod-ch 重烧字幕+重混 → 重出 ch1/ch3 EN 横竖 4 片 → gp1-finish 重拼全片(443.2/443.1s,13段)+速览(177.2/177.6s,6段)+重生 ch1/ch3 联络表。抽帧肉眼复证 1-1 字幕=画面控件逐字一致；真 Chrome 播放 full/trailer land+port+seg01 全 readyState4/seek近尾/零 pageErr。
- **item-8 二维码解码（D-15-5）**：/tmp 装 jsqr@1.4.0+pngjs（代理，不入 git），对成片 ED-{land,port}-en.mp4 第10s 抽帧 jsQR **真帧解码** → 横竖均 = `https://www.maxhouses.net/partner-portal/?src=video-en`，与 §3.8 逐字一致。
- **九项状态**：1✅(录制时闸) 2✅ 3✅(选A·人眼闸保留) 4✅ 5✅ 6✅ 7✅(EN+中;RU/FR随录建扫) 8✅(EN;RU/FR/ZH随录解) 9✅ → **全过，EN 清关，可开录中俄法**。
- **改了**（主仓库，不推）：shots-v1.json(capEN 1-1/3-1)、captions-v1.json(en/ru/fr 1-1 + en 3-1)、REVIEW-en-self.md、REVIEW-en-caption-button-audit.md(新)、DECISIONS.md。**成片/voice** 不入 git/mh-jobs。
- **DB**：本趟**零 DB 操作**；baseline 16/16 自 trip14 未动（本趟纯合成/自审，用缓存帧，不录制）。

## 第 14 趟（2026-10-12 Mac mini 无人值守）· EN 自审前置合成 + 开审
- **OP/ED 叠层卡成片**（新 rec/gp1-finish.mjs，复用 gp1-overlays 的 brand/keypoint/recap/qr 卡）：OP-1 品牌卡 / OP-2..5 四条重点卡（卡面=四条重点逐字文案，文字未改）/ OP-6 目录卡（列10章）；ED-1 四条回顾（4✓）/ ED-2 二维码（qrcode 生成 ...?src=video-en + 网址 + 「邀请码见引导页」）。逐卡定格到配音时长+0.5s，混本语配音，编码同 prod-ch(crf21/aac)。横竖各出，卡逐张肉眼复验品牌紫橙正。
- **全片拼接 + 分段**：OP 卡 + 各章 mp4 按镜界切子片 + ED 卡 → `full-{land,port}-en.mp4`(443.2s) + `segments/{orient}/full-en-segNN.mp4`(13段)。分镜边界用 prod-ch 段时长公式重算(与各章成片实测 diff≤0.07s)，splitChapter 末镜对齐真尾。贪心聚 20~40s，ED 强制独立成 13s 收尾段。
- **速览(招募片)**：照 RULING §1 镜单(OP-1~6→1-1/1-7/1-8→2-1/2-4→3-1/3-8→4-1/4-5→6-2/6-6→7-0/7-1/7-3→ED-1/ED-2) → `trailer-{land,port}-en.mp4`(177s) + 6 段。删 6-5、第6/7章段改 6-2/6-6→7-0/7-1/7-3 已落。
- **验证**：真 Chrome 播放 full/trailer land+port + seg01 全 readyState4、seek 近尾、零 pageErr；全段逐段 probe 有 A+V、段和=master；OP/ED 卡 + ch6/ch7 联络表 + 6-2 字幕带 + 7-0 ¥0 橙框 + 页头区 皆肉眼复验。
- **联络表**：gp1-finish `contact` stage 生成全 10 章×横竖共 20 张(每镜段中一帧网格)推 shots/GP1/en/。drawtext 未编入此 ffmpeg → 无镜号标注，镜序见 stage 输出。
- **九项自审(REVIEW-en-self.md，进行中)**：见该文件。**item-3 发现**最关键（D-14-3，待业主一句话定遮蔽口径）。
- **成片**(不入 git/mh-jobs)：~/guide/dist/partner/{full,trailer,OP,ED}-{land,port}-en.mp4 + segments/。改了(主仓库，不推)：rec/gp1-finish.mjs(新)、DECISIONS.md、REVIEW-en-self.md(新)。
- **DB**：本趟**零 DB 操作**(纯合成/自审，不碰库，基线 16/16 不动)。

## 第 13 趟（2026-10-12 Mac mini 无人值守）

## 第 13 趟（2026-10-12 Mac mini 无人值守）
- **ch1 注册与开通（EN 横竖成片，~49.4s，8 镜，真帧肉眼复验、零 @gmail）→ EN 十章齐 10/10**：
  - 本章跨三登录态，一趟内走通、**全程零 DB 写入**（录前 verify 16/16 → 录 land → 录 port → 录后 verify 16/16，基线零漂移，无需 rebuild）。
  - **1-1..1-4 真·未登录门禁**：harness 对 ch1 开场跳过自动登录，停在真门禁。1-1 整屏登录卡(EN)；1-2 高亮「New agency? Register →」；1-3 注册盒邀请码框(占位 `MAXHOUSE-PARTNER-XXXX`=掩码，非真码)；1-4 高亮「Register」钮(不点，避开真 signUp)。
  - **1-5..1-7 产品 render 喂样例(RULING §2.1c，ch8 先例)**：实证 `guide_ptReg` 邮箱未验证、无法真登录(被「请先验证邮箱」拦) → 1-5..1-7 改用产品自身 `renderOnboardingView()`(入驻表单，样例预填 Demo Agency Reg/Pakistan/firstname.demo@example.com) / `renderPendingView()`(审核中琥珀卡「Under review」)直渲，零自造界面。
  - **1-8 真登录已批工作台**：shot `login:'guide_partner'` 镜前真登录(已批伙伴可登) → `renderActiveView` 工作台，高亮 hero「Demo Agency · Partner agency · approved」。只读。
  - **harness 加固(rec.mjs)**：抽 `doLogin(key)`(任意账号先 goto 回门禁再登)、`CH==='1'` 不自动登录、shot 级 `login` 字段镜前切登录态——供后续跨登录态/多账号章复用。
  - 交付：成片 ~/guide/dist/partner/ch1-{land,port}-en.mp4(1920x1080 / 1080x1920 带音轨)；联络表 ~/mh-jobs/shots/GP1/en/ch1-contact-{land,port}-en.png(逐张看过，8 格齐、无泄露)；主仓库 commit(不推)。
  - 自审待办(REVIEW-en-self §4)：1-1 字幕引号内「Register your agency」≠真按钮「New agency? Register →」，EN 自审阶段统一(去引号，口播词不变→voice 不重生)。
- **成片现状（EN）**：1·2·3·4·5·6·7·8·9·10（**10/10 齐**）。

## 第 12 趟（2026-10-12 Mac mini 无人值守）
- **ch3 提交第一个学生（guide-pt-01 向导，EN 横竖成片已出，~69s，9 镜，真帧肉眼复验、零 @gmail）**：
  - 3-1 列表「Submit New Student Referral」→ 3-2 向导 step1 计划(开学季/资助/层次/专业) → 3-3 step2 档案(DOB/护照号，step2 输入无 id 用 label 文本选择器) → 3-4 step3 材料上传槽 → **3-5 AI 预检琥珀条** → **3-6 护照姓名核对琥珀条** → 3-7 退出三选一(存草稿入口) → 3-8 真 submit 出真 app_no → 3-9 列表卡「审核中」。
  - **3-5/3-6 照 RULING §1.2 用产品自身渲染喂样例**（ch8 先例）：wizard step3 pre 注入 `state.wiz.docs[槽]=[{path:'demo/referral-drafts/槽/..'}]` + `state._aiDraftHints[path]={verdict:'fail'|'unsure',issues:[真口吻英文样例]}` → `_wzRender()` → 产品 `_aiHintBandHtml` 琥珀条「Pre-check reminders ⚠ + 问题 + 产品自带 footer」+ sticky `.ai-agg` 真渲染。零 EF/零桶/零自造。**关键坑**：草稿判认领条件 `indexOf('/referral-drafts/')>0` 须有前缀（前导斜杠=0 不命中）。见 DECISIONS D-12-1。
  - **3-8 真 submit**：清 docs/hints 过 Q1+AI 闸 → `_wzFinalize`(check_collision+submit_referral 真 RPC) → 真 app_no(横 MH-XJ4XDA / 竖 MH-R8JT4M) 高亮。真 submit ~8s，段偏长。
  - **图纸死选择器全校正**：`.ai-hint`/`.amber-box`/`#wzInput_dob`(step2 无此 id)/`.partner-student-status-reviewing`(真 class=`.partner-student-status-pending`)。
- **复位（本机脸库缺口·D-12-2）**：3-8 真 submit 的 guide-pt-ch3(is_test=false) **不走 rebuild-partner.sh**——本机 jobs/JOB-G6 脸库缺 129/201 张(LEDGER-4 双机分割)，全量 rebuild 的 assign-faces 必崩；且 cleanup 的 is_test 闸遇 is_test=false 整体回滚。新建 `states/st-ch3-cleanup.sql`(scoped 单删 guide-pt-ch3，不碰 9 基线生/脸)。录 land→删→verify16/16→录 port→删→verify16/16。
- **交付**：成片 ~/guide/dist/partner/ch3-{land,port}-en.mp4；联络表 ~/mh-jobs/shots/GP1/en/ch3-contact-{land,port}-en.png；主仓库 commit e301615(不推)。
- **成片现状（EN）**：2·3·4·5·6·7·8·9·10（**9/10**）；**缺 1**。


## 第 11 趟（2026-10-12 Mac mini 无人值守）
业主 2026-10-12 下 RULING-20261012-gp1：视频做到收官、上线前停；分镜与产品对不上时 CC 自处理记账不停（四种情况才停）。本趟从该裁决接着做。
- **ch6 多校录取（pt-06 Bilal 两盲 offer）= 照 RULING §1 重做，EN 横竖成片已出**（~42s，6 镜，1920x1080 / 1080x1920，带英文旁白字幕，真帧肉眼复验、零 @gmail）：
  - 6-1 两盲 offer 卡 → 6-2 开录取弹窗(盲码 SCH-1AD6C8 + 专业 + 开学 + 奖学金，无校名) → 6-3 奖学金行 → 6-4 点解锁(无旁白·真写 unlocked_at) → 6-6 校名揭晓(Demo University·演示大学 + 联系块) → 6-7 接受该专业按钮。删 6-5。
  - **6-6 校名揭晓用产品自身 reveal 渲染喂演示校数据（铁律14-P2 + RULING §2.1c，ch8 先例）**：源码+真机实证证明 partner 端 beta 解锁只翻 unlocked_at、服务端不去盲（get_agent_unlocked_offer_school 对未付款 offer 返回 []），真校名要付款才放。故 6-6 把真·演示大学数据注入产品自己的 _p130_SchoolCache 再调 openCloudAdmissionModal 重绘——像素与已付款学生(pt-09)同源，非自造。见 DECISIONS D-11-1。
  - **6-7 字幕去掉「倒计时」**：真机 pending 盲 offer 无倒计时元素（倒计时块仅 accepted+letterUp+!paid 才渲染），四语字幕改为陈述画面真有的「接受该专业 + 开学日期 + 奖学金」，6-7 音频四语重配。见 DECISIONS D-11-2。
  - **harness 加固**：MASK 脱敏加 MutationObserver（re-render 即刻补扫）+ 抓泄露前强制 sweep + sweep 间隔 120→80ms——消除「弹窗重开后、下次 sweep 前」的 @gmail 瞬露窗口（ch6-2 首录曾因此报泄露，修后零泄露）。
- **DB 全程守住 16/16**：ch6 land/port 各录一次（6-4 真写 unlocked_at），**录后各 rebuild 复位 verify 16/16 PASS**。
- **ch7 多校通知书/建档 = 照 RULING §1 加 7-0 + 重录，EN 横竖成片已出**（~42s，5 镜，带英文旁白字幕，真帧复验、零 @gmail）：
  - **7-0（新·¥0 优惠码）**：pt-07 通知书付款单真机驱动「Pay now→¥3,000→优惠码 MAXHOUSE→应付 ¥0(橙框≥2s)→勾同意→确认(真写 letter_paid_at)」；确认走 `coupon_agent_pay_offer` RPC 实证走通（确认后下载钮出现、offer 转 paid）。旁白/字幕/四语配音**复用原 6-5**（直接拷音频，字幕一字未改）。
  - **7-1..7-4 重录**：7-0 确认后 pt-07 转 paid → 7-1 下载通知书（校名 Demo University 此处是真·服务端去盲，因已付款）；7-2 pt-08 JW202；7-3 pt-09 建档进度；7-4 pt-09 列表卡。全改**按名字解析 viewReferredStudent(N)**（硬编码 2/3/4 已随 rebuild 失效）。
  - 置态 st-pt07-pay-cleanup.sql（授权删 pt-07 自家 ¥0 单 1 行）+ st-pt08-jw202.sql；录后各 rebuild 复位 verify 16/16 PASS。G-3 D1 遮蔽：当前 v184 付款单无 PayPal/half-price 元素，无需遮。OP-4 快剪改用 7-0；storyboard 升 v1.1。见 DECISIONS D-11-3/4。
- **下一步（下趟）**：ch3（3-5 AI 预检用产品渲染函数喂样例，3-6 护照核对同理；真 submit 录 app_no 后 rebuild）、ch1（注册从零，需 no-login 路径 + guide-pt-reg 账号）；EN 十章齐 → 开场/片尾 overlays → 全片+速览拼接(20-40s 分段) → 联络表 shots/GP1/en → REVIEW-en-self.md 九项自审 → 过了录中俄法 → GP1-04/05 收官 → SUMMARY-GP1.md。
- 成片现状（EN）：2·4·5·**6(新)**·**7(新,含7-0)**·8·9·10（8/10）；**缺 1·3**。

---
## 【历史·第 10 趟】停审待拍板（已被 RULING-20261012-gp1 解除）
第 10 趟零 DB 写入、只读探针验证 ch3 向导全链 + ch6 源码复核发现两冲突写了 NEEDS_OWNER_DECISION。业主已于 2026-10-12 以 RULING 拍板（ch6 ¥0 移 7-0、ch3 AI 预检用产品渲染），请示单改名 -resolved。

---
## 【历史】第 9 趟新成片：第 5、7、8 章（横+竖，带英文旁白字幕，真帧肉眼复验、零 @gmail 泄露）

## 一句话（给业主）
这趟又录好了三章操作演示：「材料被退回怎么补传」「录取通知书 / JW202 下载与建档完成」「名额快用完怎么申请提额」。都是横屏竖屏两版、带英文配音字幕，画面里学生真邮箱全部打码。录完数据库一键还原，自检 16/16 全过。还顺手把脱敏做得更严（现在任何角落出现的真邮箱都自动盖掉）。剩「多校录取解锁」「提交第一个学生」「机构注册」三章没录。

## 本趟实际完成（已验证）
1. **ch5 材料被退回（pt-03 Rahim Islam）**：5-1 列表卡→5-2 退回理由(Maxhouse 退回·英文原因)→5-3 点「换版」选 SPECIMEN 文件(前端暂存不写库)→5-4 徽章转「Under review」(前端示意·不写库)。**零数据库写入**。横 31.8s / 竖 32.1s。
2. **ch7 通知书/JW202/建档（pt-07 Nilufar / pt-08 Abena / pt-09 Dmitri）**：7-1 录取弹窗下载「Admission Letter」→7-2 下载「JW202 Form」→7-3 建档进度条(Accept✓/Letter✓/JW202✓/Enrollment✓)→7-4 列表卡「Admission complete」。录前置态 `st-pt07-letter.sql`+`st-pt08-jw202.sql`(传 SPECIMEN 到既有 specimen/ 对象，非真上传)，**录后 rebuild 复位 16/16**。横/竖各 28.5s。
3. **ch8 名额与提额（Demo Agency）**：8-1 统计卡「已提交 9」→8-2 打开「Referral quota reached」弹窗(传真值 used:9/quota:10，修掉 _qrOpenRaise 冷调出的 undefined/NaN)→8-3 填 30+理由、高亮 Submit(不真提交)→8-4 横幅转「Quota raise approved: now 30」(前端示意)。**零数据库写入**。横/竖各 30s。
4. **harness 三项加固（rec.mjs，复用于后续章）**：
   - `file` 动作原语：`{t:'file',sel,path}` → setInputFiles 选本地 SPECIMEN(ch5-3 换版用)。
   - `waitFor` 字段：镜前 runPre 后等指定选择器可见(≤9s)再高亮——解两级弹窗(detail→#admissionModal)异步开启的时序，ch7 用它稳稳等出下载按钮。
   - **MASK 脱敏升级为 TreeWalker 全文本节点扫描**：原只盖「叶子元素」文本，漏了「含子节点元素的直系文本节点」里的 @gmail(ch7-2 pt-08 详情里学生邮箱曾漏 1 次)；改成 TreeWalker 遍历 document.body 所有文本节点，@gmail 不论嵌套层级一律盖成 agency.demo@example.com。ch7 重录后 land+port 全 ✅ 无泄露。
5. **两级弹窗真机实证（ch7，写进本文件下方）**：`openCloudAdmissionModal(lane,idx,offerId)` 填 `#admissionModalBody`、给 `#admissionModal` 加 `.show`；offerId 是运行时 uuid(rebuild 变)，pre 里用 setInterval 从 detail 的 school-card onclick 现抓现开。下载钮渲染条件 = `letter_paid_at 非空 && (letter_uploaded_at||jw202_uploaded_at)`(源 L5544 `_renderCloudAdmissionBody`)——只上传不付款不出钮；pt-07/08/09 基线已 `letter_paid_at`，故置态只补 uploaded_at 即现钮。

## 成片进度表（正式成片，本机 ~/guide/dist/partner/，不进 git/桶）
| 章 | 横 | 竖 | 趟 |
|---|---|---|---|
| 2 | ✅ | ✅ | trip7 |
| 4 | ✅ | ✅ | trip8（动作章首杀）|
| 5 | ✅ | ✅ | **trip9** |
| 7 | ✅ | ✅ | **trip9** |
| 8 | ✅ | ✅ | **trip9** |
| 9 | ✅ | ✅ | trip5 |
| 10 | ✅ | ✅ | trip6 |
| **1 / 3 / 6** | — | — | **待录** |
| 开场OP/片尾ED/拼接/海报/缩略图/联络表 | — | — | 待章节齐 |

## 下一趟（剩 ch6 / ch3 / ch1 + 收尾）
每章铁律：开工先 verify 16/16（不过先 `bash jobs/JOB-GP1/rebuild-partner.sh`）→置态→录 land+port→复位(rebuild)→verify。
- **ch6 多校录取（pt-06 Bilal，两盲 offer）= ⚠图纸与现实冲突·需业主拍板（铁律14-P2）**。trip9 已把 ch6 全链真机 + 源码读通（只读探针，零写库，verify 16/16 复核过）：
  - **可录的真流程（无冲突）**：6-1 卡「2 offers」→开 detail；6-2 两张盲 `.school-card.school-card-clickable`(offerId=运行时 uuid，本轮 09c33dd3…/16e071e9…，rebuild 变；pt-06 本轮=viewReferredStudent(3))，盲态显 专业/学费/奖学金/截止、**校名遮成 SCH-1AD6C8 / SCH-8E561C**；6-3 比两份奖学金；6-4 `#admissionModal` 内 `.cloud-offer-unlock`(onclick=`_cloudAdmUnlock()`)→**揭晓 Demo University**；6-7 `.btn-offer-accept`(onclick=`_cloudAdmRespond('accepted')`)接受。unlock 与 accept **都写 pt-06 自家 offer**，录后必 rebuild 复位(verify #5 两盲 pending)。
  - **冲突点 = 6-5/6-6「优惠码 MAXHOUSE → 应付 ¥0」**：真机里 **unlock 不收款**——按钮原文 L5642「解锁查看（内测：仅状态翻转，不收款）」，`_cloudAdmUnlock`→`_agentUnlockOffer`(只翻 unlocked_at)→重开弹窗揭晓校名，**全程无付款单、无优惠码框**。¥0 的 MAXHOUSE 优惠码是**另一条链**：录取通知书付款 `_cloudAdmPay()`(L5107)→`#paymentModal`→`#couponInput` 打 MAXHOUSE→`SCHOOL_PAYMENT_AMOUNT=3000` 减到 ¥0；而这颗「💳 Pay now to view & download」钮(L5637)**只在 offer 已接受且学校已出通知书、尚未付款时**才出现。pt-06 是盲 offer，没接受、没通知书 → **在 pt-06 身上根本到不了优惠码 ¥0 画面**。全库唯一有 ¥0 MAXHOUSE 付款单的是 pt-07(verify #7，但已 letter_paid，付过了，不会再弹付款框)。
  - **→ 请业主三选一**：(A) ch6 去掉 ¥0 优惠码镜，只录「盲比→解锁揭晓→接受」，¥0「不收费」卖点改放别处/片尾；(B) 授权把 6-5「¥0 优惠码」镜改录在**真付款链**上——临时把某生(建议 pt-07)的 `letter_paid_at` 置空(Demo Agency 自家 offer，录后 rebuild 复位)，开其录取通知书付款弹窗真打 MAXHOUSE→¥0，接受学生主角切成 Nilufar(旁白不点名，弹窗聚焦金额/优惠码)；(C) 改分镜。**CC 不自修、不自造付款界面(铁律14-P2+铁律15)**，等拍板。
- **ch3 提交第一个学生（pt-01 草稿 Ayesha）= 向导开法待实证**：trip9 探针实测 `openReferralForm`/`_wzOpen`/`_wzNext`/`openAddStudentModal` 都在，但 `_wzGoStep`/`_wzSubmit`/`submitReferral` **undefined**；直接 `openReferralForm()`**没弹出可见 modal**(`.modal-bg.show`=空)，`[id^=wz]` 元素在但 hidden。下趟先定位向导真开法(可能需先进 pt-01 草稿上下文或别的入口)、步进(`_wzNext` 连点?)、各步 input id、提交函数。之后打字填表+传 SPECIMEN+提交→真 app_no(写 pt-01)；MRZ 合成护照 OCR 不触发则按 storyboard §2.6 预授权改静态高亮。录后 reset 回草稿。
- **ch1 注册从零**：harness 现**强制登录 guide_partner**，ch1 需「不登录」路径——rec.mjs 要加 `--nologin` 分支或 ch1 专用录法(gateShowRegister→注册→资质打字→传 2 SPECIMEN→审核中→切 guide_partner 录 APPROVED)。先删 guide-pt-reg 账号(注册才走得通)，录完 rebuild 重建 reg。**最复杂，建议放最后或留待下趟**。
- 齐后：开场 OP / 片尾 ED（gp1-overlays）→ 整片拼接 full/quick → 联络表 → 写 `JOB-GP1-03.md` + `SUMMARY-GP1-A.md`(REVIEW=yes) + `~/mh-verify/rGP1-STOP.txt`=WAIT_REVIEW 停审。

## 两级弹窗 / ch7 实证索引（供下趟 ch6 复用）
- 学生卡→`viewReferredStudent(N)`，N=列表显示序(非 pt 号)。本轮基线真机映射：N=2 Nilufar(pt-07)、N=3 Abena(pt-08)、N=4 Dmitri(pt-09)、N=8 Rahim(pt-03)。**rebuild 后顺序可能变，录前用 DB 名字→viewReferredStudent 现对**。
- detail 内 `[onclick*="openCloudAdmissionModal"]` = school-card，eval 其 onclick 开 `#admissionModal`。
- 下载钮 `.admission-doc-btn-letter` / `.admission-doc-btn-jw`；建档进度 `.offer-progress`(含 ✓Enrollment)；揭晓胶囊 `.admission-id-tag--unlocked`；校名联系块 `_p130_ContactBlock`(含 @gmail，靠 MASK TreeWalker 盖)。

## 合规
未改五端 HTML(只读 partner v184)；未碰 JOB-G*/GS*/GP0 原文件；未碰 R2/CF；未起后台任务；node 走代理。写入仅 ch7 置态(pt-07 letter / pt-08 jw202，指既有 specimen/ 对象)，**录后 rebuild 清回基线 verify 16/16 PASS**；ch5/ch8 零 DB 写入(前端暂存/示意)。画面脱敏：真帧复验 + 程序 @gmail 探测双证，本轮全章 ✅ 无泄露。本轮**不推主仓库**、未写 NEED_PUSH；主仓库仅点名 commit 自己的文件。
