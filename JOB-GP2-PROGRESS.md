最后一趟：2026-10-15 第 7 趟 GP-2 **收官**：GP2-04 线上真验 ALL PASS(16 context)+测速(3G点章1.5s/4G高清0卡顿达标，慢3G点章~6s如实标红·物理下限)；GP2-05 体检全过(禁用词 268 单元零命中、片尾码四语全对、无真 PII、demo verify 17/17、联络表抽检+GP-1全量背书)；写 SUMMARY-GP2.md(PUSH_OK=yes) + JOB-GP-decisions-all.md(GP-1 15+GP-2 28)。主仓库攒 **2 笔**未推(470c4f6 GP2-04工装+决定 / b9cd716 GP2-05扫描工装)。**GP-2 自动循环结束**；下步＝业主亲眼看片 → 满意后授权 GP2-06 对外(去 noindex 一行+首页入口，另行裁决)。

（上趟存档）第 6 趟 GP-2：GP2-04 线上真验**发现阻断缺陷**——引导页跨源 fetch 清单被 CORS 挡（media.maxhouses.net 不发 ACAO）→ 十章永不加载（本地 route-stub 闸与业主 curl HEAD 都绕过 CORS 未抓到；学生页不跨源 fetch 故无此病）。已备修法（Option 2 同源清单：8 清单入 guide/partner/m/，页面 fetch 基址改 'm/'+lang，BUILD→gp2-20261014b）并本机 E2E 实证（wrangler pages dev 同源清单×真 R2 媒体，四语 CORS 错0、真媒首帧0.9~1.4s；本地闸仍 ALL PASS）。RULING-d 三件只读附加全做：① cf 规则改克隆 guide-student-html-cache + 幂等 apply-cache-rule.sh(--dry-run 未执行) + 线上 ruleset 存档；② jobs/JOB-G9/cleanup-apply.sh 改 bash3.2(read 循环替 mapfile)，--dry-run 自证 GUARD_OK delete=34(pub28 priv6) 未删，留工作区给 G-9 业主卡；③ 裸 /jobs/QUEUE-G8.md 仍404。主仓库攒 **7de43e7** 1 笔未推。写请示单（CORS 修复推送 + 两张 GP2-06 备选卡）停下。**下趟＝业主卡推 7de43e7 + 验十章出来 + 装 RULING-*-gp2-04-fix-live 后，续 GP2-04 线上真验(应全绿)+测速 → GP2-05 收官。**

# JOB-GP2 进度表

- 线路：机构中介端操作说明视频 GP-2（成片整理 + 引导页，只在本机准备，推送/上传/Cloudflare 由业主卡执行）。
- 任务顺序：GP2-00a → GP2-00(停点一) → GP2-01 → GP2-02 → GP2-03(停点二) → GP2-04 → GP2-05。
- 成片在 ~/guide/dist/partner/（不入 git、不传桶）。

## 趟账
### 第 1 趟（2026-10-14 开）
- 开工核对：五端口 git diff origin/main --stat 为空、无未跟踪文件 —— PASS。
- GP-1 成片齐（~/guide/dist/partner/ ch1~10/OP/ED/full/trailer/segments 四语横竖）—— PASS。
- **GP2-00a 完成**：重出 ch2(英俄法横竖)/ch6(俄)/ch9(俄) 章联络表 + ch2 2-4 分段带(英俄法) 覆盖旧图；ch6 横版 §四.5 禁用词复扫 4 语×横竖 ALL CLEAN（修 MASK 篡改登录邮箱真病根，每语只登录一次）。推 mh-jobs 41d1c0f。
- **GP2-00 完成（停点一）**：建 functions/_middleware.js 挡 11 内部目录+11 根级散落文件；wrangler pages dev 验证内部 404/公开 200；G9 dry-run GUARD_OK pub=28 priv=6。主仓库提交 d26edb1(挡法)/9c086a5(截图工具)/590354e(请示单)，未推。写请示单停点一。
- **下趟**：等业主卡执行推送+验证+G9 apply、装 RULING-*-gp2-00-done.md 后，接 GP2-01 成片整理（流畅档/分段/海报缩略图/分享图）。

### 第 2 趟（2026-10-14）
- 开工核对：五端口 git diff origin/main --stat 为空 —— PASS（零端口改动）。
- **GP2-00b 完成**（承 RULING-20261014b-gp2-00-routes）：①新建仓库根 `_routes.json`（version1/include24=既有 share+guide-school 两函数树 + 11 内部目录 + 11 根级文件/exclude空），JSON 合法；②`functions/_middleware.js` 404 加取证头 `x-mh-block:1`（只加这一头）。
- 本机 wrangler pages dev :8789 重验：内部 16/16=404+x-mh-block=1、公开 9/9=200 无头、`/guide/school/admin/api/*`=403 access_required（函数实锤）、`/share/*` 非挡法路径。Playwright 5 图 ALL PASS，推 shots/GP2/local/。
- RULING 四.4：实测本机 wrangler 3.114.17 **不认 _routes.json**（裸 /jobs 仍 404+头为判据）；记账 D-GP2-2-1，作用域裁剪留线上验（请示单第二节）。
- G-9 dry-run 重跑仍 GUARD_OK pub=28 priv=6。
- 主仓库提交（未推）：`a850824`（仅 _routes.json + functions/_middleware.js，一笔）。
- 请示单（停点一·第 2 版）覆盖写 + 复制推 ~/mh-jobs。结束本趟。

### 第 3 趟（2026-10-14）· GP2-01 成片整理
- 开工核对：五端口 git diff origin/main --stat 为空、无未跟踪端口文件 —— PASS。停点一已由业主卡 1387 解除（挡法上线 7ad527c、装 RULING-20261014c）。
- **GP2-01 完成**（四项全绿，回执 ~/mh-jobs/JOB-GP2-01.md）：
  - ①流畅档 lite 236 个（80 章+98 full 段+58 trailer 段），1-pass ABR：land 178~250kbps、port 153~217kbps，res 精确、moov 在头、解码无错、fail=0。偏差：29 个最静态 land 段落 178~199（略低 200 下限，内容过静，记账 D-GP2-3-2 接受）。port 初版 bv175/mx220 冲到 235 超限→收紧 bv155/mx195。
  - ②速览分段重切（照 g9b）：四语横竖首段 12.9~14.9s（≤20 ✓）、中段全 20~40、无 >40、ED 尾 ~13s 独立、段和 vs master Δ≤0.08s。重写 trailer-manifest 四语横竖。整片段 GP-1 已合规不重切。
  - ③海报/缩略图（ffmpeg 抽帧+cwebp）：每语 20 缩略图(≤25KB，最大 23.3)+24 海报(章×画幅+整片+速览)+2 封面。
  - ④分享图（playwright 1200×630 JPEG）：四语 65~76KB≤150KB，英中已肉眼核渲染正确。
- 决定账：D-GP2-3-1(速览重切口径)/3-2(lite 编码参数+偏差)/3-3(媒体模型供 GP2-03)/3-4(海报/分享图实现)。
- 主仓库提交（未推）：GP2-01 脚本 + gate 清单一笔（gp2-01-*.mjs/_run-lite*.sh/lite-gate-*/poster-gate-*/share-gate + DECISIONS）。成片/lite/海报/分享图在 ~/guide/dist/partner/（不入 git、不传桶，上传留 GP2-02）。
- **下趟**：GP2-02 上传脚本与清单（本机，不上传；照 g9-03-upload + GS5c make-manifest，只 --dry-run）。

### 第 4 趟（2026-10-14）· GP2-02 上传脚本与清单
- 开工核对：五端口 `git diff origin/main --stat` 为空、无未跟踪端口文件 —— PASS。停点一已解除（GP2-00 live 7ad527c + RULING-20261014c）。
- **GP2-02 完成**（回执 ~/mh-jobs/JOB-GP2-02.md；本任务非停点）：
  - ①`gp2-02-manifest.mjs`：四语各三清单（`manifest.json` HD+展示、`lite-manifest.json` 流畅段串播序、`seg-manifest.json` 段 dur+shots），写入 ~/guide/dist/partner/<lang>/。媒体址相对 base + `?v=md5-8`（照 GS5c）。章标题四语源 prod-ch.mjs CH_TITLE 系列（=章节条烧入文案）。段数动态枚举（ru full 13/zh trailer 8）。血缘三问：缺片即报错停、不兜底。
  - ②`gp2-upload.sh`：只写公桶 `guide/partner/v4/<lang>/<land|port>/`、不删；幂等（并发 HEAD 字节比对跳过已一致）；经 r2-put.sh 上传（它读 .env，本脚本不碰密钥）+ 二次读回 HEAD200/Range206/长度；`--dry-run` 只分类报数。CC 只跑 --dry-run。
  - ③上传计划 528 对象/558.0MB（章HD80+章Lite80+masterHD16+流畅段156+海报96+缩略图80+封面8+清单12）。**--dry-run 实测 v4/ 空、528 全新、0 已在**。
  - 桶键决定 D-GP2-4-1~4-4：HD 分段/OP/ED 母带不入桶（页面 HD 走 master）；分享图 jpg 不入桶（r2-put 无 .jpg CT → GP2-03 随页面入 guide/partner 由 Pages 服务）。
- 主仓库提交（未推）：`b4d976d`（gp2-02-manifest.mjs + gp2-upload.sh + gp2-upload-plan.tsv + DECISIONS + .gitignore）。连 GP2-01 `b0dfba9` 共 2 笔待业主卡推。
- **下趟**：GP2-03 引导页 guide/partner/index.html（**停点二**）——cp 线上学生页 g9c 改，四语/画幅自动/十章目录/速览+整片/注册区公开邀请码 MAXHOUSE-PARTNER-2026/分享/去下载/robots noindex/_headers 新增段/缓存规则 JSON；做完写停点二请示单。

### 第 5 趟（2026-10-14）· GP2-03 引导页（停点二）
- 开工核对：五端口 `git diff origin/main --stat` 为空、无未跟踪端口文件 —— PASS（零端口改动）。停点一已解除（GP2-00 live 7ad527c + RULING-20261014c）。
- **GP2-03 完成（停点二）**（回执 ~/mh-jobs/JOB-GP2-03.md）：
  - 新建 `guide/partner/index.html`（单文件 44.6KB≤60KB，零第三方 `<script src>`）：四语(en/zh/ru/fr)+画幅自动(手机竖/电脑横，可切、记 localStorage)+十章目录(缩略图懒加载)+速览/整片双缓冲分段串播(HD 单 master / Lite 分段，弱网自动降档)+下一章/续看。
  - 注册区：一行「2 工作日审核」(分镜 1-7 口播四语)+公开邀请码 `MAXHOUSE-PARTNER-2026`(顶部常量，db-run.sh 只读实证 partner_code 匹配且 enabled)+复制钮+「注册你的机构」链 `/partner-portal/?src=guide-<lang>`。
  - 分享 WA/TG/复制/微信QR；og 本语言 `/guide/partner/share-<lang>.jpg`(同源，4 张已入页目录)；品牌图复用线上 brand-300.png。去下载(controlsList=nodownload+禁右键)；robots noindex(先上线不对外)。清单运行时 fetch(?v=BUILD，换片改一行)。
  - `_headers` 增 `/guide/partner/*` 段(照 `/guide/student/*`，只+5行)；`jobs/JOB-GP2/cf/guide-partner-html-cache-rule.json`(照线上 guide-student-html)留业主卡。
  - 本地闸 `jobs/JOB-GP2/gp2-03-gate.mjs`：playwright 全站 route 截流打本机成片(绝不碰生产)，四语×手机405/电脑1440 = 8 context×14 项 **ALL PASS**(章首帧 82~164ms≤2.5s)；lite 分段串播单测另过(速览段 550ms 出帧)。截图 8 张 shots/GP2/local/。
- 决定账 D-GP2-5-1~5-7。
- 主仓库提交（未推）：`ffadae3`(页面+分享图+_headers+cf JSON+gate/qr/probe+DECISIONS)、`fbb1231`(停点二请示单)。连 b0dfba9/b4d976d 共 **4 笔**待业主卡推。
- 写停点二请示单（NEEDS_OWNER_DECISION.md 覆盖写 + 复制推 mh-jobs）。结束本趟。
- **下趟**：等业主卡上传(528/558MB)+加缓存规则+推 4 笔+装 `RULING-<日期>-gp2-03-live.md` 后，接 **GP2-04**（线上真验 + 测速，只读）。

### 第 6 趟（2026-10-14）· GP2-04 线上真验 + RULING-20261014d 三件只读附加
- 开工核对：五端口 `git diff origin/main --stat` 为空、无未跟踪端口文件 —— PASS。停点二已解除（业主卡 1390：528 对象入公开桶 v4/、5 笔推上线 1c1adfd、装 RULING-20261014d）。本机 HEAD==origin/main==1c1adfd。
- **GP2-04 线上真验发现阻断缺陷**（回执 ~/mh-jobs/JOB-GP2-04.md）：引导页 `fetchManifest` 跨源 `fetch` media.maxhouses.net 的 manifest.json，该域不发 `Access-Control-Allow-Origin` → 浏览器 CORS 挡 → `MAN` 空 → **十章永不加载、页面停「Could not load」**。病根实证：curl 带 Origin 无 ACAO；无头浏览器控制台 CORS 报错；线上截图 shots/GP2/online/gp2-04-BROKEN-{en,zh}.png。为何没早发现：本地闸 route.fulfill 当同源喂清单(绕 CORS)、业主卡只 curl HEAD(不触发 CORS)；学生页不跨源 fetch 清单故无此病。
- **修法已备 + 本机 E2E 实证**（Option 2 同源清单，不碰基建）：4 语 8 清单(64KB)入 `guide/partner/m/<lang>/` 由 Pages 同源服务；页面 fetch 基址 `D.MEDIA+'/'+lang`→`'m/'+lang`（媒体仍走清单 base 的 R2，视频/图元素无需 CORS）；BUILD→`gp2-20261014b`。本地闸 8×14 仍 ALL PASS；新增 E2E：`wrangler pages dev`(同源清单)×真 R2 媒体(经代理,localhost bypass) 四语各 10 章、真媒首帧 0.9~1.4s、**CORS 错误 0**。
- **RULING-20261014d 三件只读附加**（都只读、未执行线上）：① 实读线上 cache ruleset(存档 cf/cache-ruleset-live-20261014.json)——学生页真正生效的是 `guide-student-html-cache`(边缘 respect_origin)，据此把 cf JSON 改成克隆它(expr 换 /guide/partner)+新增幂等 `apply-cache-rule.sh`(按名查重/只增不改不删/改前改后 GET/--dry-run 纯 GET)，`--dry-run` 实证规则未存在、ruleset 解析正常，CC 未执行；② `jobs/JOB-G9/cleanup-apply.sh` 的 `mapfile`→`read` 循环(bash3.2 兼容)，`/bin/bash -n` 过、`--dry-run` 自证 `GUARD_OK delete=34(pub=28 priv=6)` 未删，白名单外留工作区给 G-9 业主卡；③ 裸 `/jobs/QUEUE-G8.md` 仍 `HTTP/2 404 x-mh-block:1`；④ 教训入账 D-GP2-6-4。
- 决定账 D-GP2-6-1~6-4。主仓库点名提交（未推）：`7de43e7`（guide/partner 页面+m/8清单+BUILD bump；jobs/JOB-GP2 cf 规则+apply 脚本+ruleset 存档+gp2-04-verify/measure+_shot-broken+DECISIONS）。
- 写请示单（CORS 修复推送 + 两张 GP2-06 备选卡：缓存规则/G-9 收尾）覆盖写 NEEDS_OWNER_DECISION.md + 复制推 ~/mh-jobs。结束本趟。
- **下趟**：业主卡推 7de43e7 + 浏览器验十章出来(BUILD gp2-20261014b)+ 装 `RULING-<日期>-gp2-04-fix-live.md` 后，续 **GP2-04 线上真验(应全绿)+测速**(gp2-04-measure.mjs，net 4g/3g/slow3g×直连/代理) → **GP2-05 收官**。

### 第 7 趟（2026-10-15）· GP2-04 修复上线后续验 + GP2-05 收官
- 开工承 `RULING-20261014e-gp2-04-fix-live`：业主卡 1391 推 33a02cb 上线(同源清单+gp2-20261014b)，线上验收全过。本机续真浏览器真验 + 测速 + 收官体检。
- **GP2-04 收口**（回执 ~/mh-jobs/JOB-GP2-04.md 第7趟续）：
  - 线上真验 `gp2-04-verify.mjs` **16 context ALL PASS**：主循环 8(四语×手机/电脑：十章/点章出CDN帧 408~1130ms/邀请码/注册src/robots/og本语言/切画幅切语言/**0 CORS 错**)+速览串播 4(窗口采样真连播 advances=6)+弱网降档 2+整片HD母带 2(单master非分段+连播)。截图 16 张 shots/GP2/online/。肉眼复核 zh-mobile/en-desktop 渲染正确。
  - 工装两处加固(只改脚本不碰端口/页面)：quick_playing/整片播放判据单点→窗口采样(灭切段握手瞬态误判)；弱网降档加 400ms settle+单次补点。专项探针 `_probe-quick-play`(四语 36~38/40 在播0暂停)、`_probe-downgrade`(effQ=lite seqNav 1ms)双证。
  - 测速 `gp2-04-measure.mjs`(CDP 模拟网+手机CPU×4+多次中位)：**3G 点章 1.5s≤2.5s✅、4G 高清 0 卡顿✅、慢3G 点章 ~6s>4s 🔴如实标红**(直连6.07/代理6.77 一致，物理带宽下限，按任务书不追加)。2nd cf-cache-status=DYNAMIC(属预期，边缘缓存规则属 GP2-06)。
- **GP2-05 收口**（回执 ~/mh-jobs/JOB-GP2-05.md）：
  - 禁用词+PII 扫描 `_scan-forbidden-gp2-05.mjs`：四语字幕 57×4+章标题 40=**268 单元零命中**(6 类禁用词+PII三正则)。初版误报 2 处「no agency fee」纯资费表述，收紧规则排除 fee/费语境后归零。
  - 片尾二维码：真成片 ED-{land,port}-{en,zh,ru,fr} 抽帧 jsqr 解码，**四语×横竖全对** `/partner-portal/?src=video-<lang>`。
  - 画面无真 PII(学生全 is_test，登录邮箱 GP2-00a 已遮)；联络表四语代表样本亲眼过(en-ch1/ru-ch6/zh-ED/fr-ch7)+GP-1 全量自审背书。
  - 演示数据 verify **17/17 PASS**(db-run.sh 只读)，无需复位。
  - 决定账汇总 `~/mh-jobs/JOB-GP-decisions-all.md`(GP-1 15+GP-2 28，每条一行)。
  - 一处非阻断观察：速览时长标签快速连切语言时偶发瞬态(单独打开均正确 2:46~2:56)，记录不追加。
- 决定账 D-GP2-7-1~7-5。主仓库点名提交（未推，**2 笔**）：`470c4f6`(gp2-04-verify+DECISIONS)、`b9cd716`(_scan-forbidden-gp2-05)。
- 写 `~/mh-jobs/SUMMARY-GP2.md`(首行 PUSH_OK=yes)。**GP-2 自动循环结束**。
- **下步(不在本轮自动)**：业主手机/电脑亲眼看四语成片 → 满意后授权 **GP2-06 对外**(去 noindex 一行+本机验+请示单，业主卡推；首页「看操作视频」入口+注册来源进档案另立工单)。
