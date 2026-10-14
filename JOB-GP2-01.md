# JOB-GP2-01 回执 · 成片整理（本机，不停）

趟：第 3 趟（2026-10-14）。承 RULING-20261014c-gp2-00-done（停点一已解除，挡法上线 7ad527c）。
开工核对：五端口 `git diff origin/main --stat` 为空、无未跟踪端口文件 —— PASS（零端口改动）。
全部产物在本机 `~/guide/dist/partner/`（不入 git、不传桶）；脚本与 gate 清单在 `jobs/JOB-GP2/`（入主仓库，未推）。

## 做了什么（四项全绿）

### 1. 流畅档 lite（照 G8 lite-transcode cp 改 → `jobs/JOB-GP2/gp2-01-lite.mjs`）
- 覆盖 236 个 lite：**80 章**(ch1~10×横竖×四语) + **98 full 分段** + **58 trailer 分段**。
- 规格：横版 960×540、竖版 540×960、全部 `+faststart`(moov 在头)。
- **关键事实**：GP-1 的 HD 母带是静态 UI 录屏、均码天生极低（land 1080p 仅 ~230kbps），crf 转 540p 只 148~185kbps，落到任务书码率区间**以下**；改用 1-pass ABR 把码率顶进区间：
  - land `-b:v 200k -minrate 170k -maxrate 250k` → 实测 **178~250kbps**
  - port `-b:v 155k -minrate 148k -maxrate 195k`（初版 bv175/mx220 繁忙帧冲到 235 超限，已收紧）→ 实测 **153~217kbps**
- 闸（逐文件）全过：res 精确、moov 在头、Δdur≤0.2、kbps≤上限（land≤250/port≤220）、解码 3s 无 error；**fail=0**。
- **偏差（记账 D-GP2-3-2）**：29 个 land lite（最静态的 ch5/ch8/ch10 与 ED 尾重的 full-seg12/trailer 末段）落 178~199kbps，略低 200 下限——内容过静，强塞码率无质量意义、反增体积违「流畅档=弱网更小」本意，故接受。540p 静态 UI 即便 180k 仍清晰；上限全部守住。

### 2. 分段（速览重切 → `jobs/JOB-GP2/gp2-01-trailer.mjs`，照 g9b-02 cp 改）
- 病根：GP-1 旧切法速览**首段 37.6s、seg04 45.4s 超限**。
- 新切法：首段=「累计≤20 的最大镜界」(宁短勿长)、其余 g9b 贪心(绝不 >40)、ED-1/ED-2 独立成 ~13s 尾段。
- 结果（四语横竖，HD 段，重写 `segments/<o>/trailer-manifest-<lang>.json`）：
  - 首段 **12.9~14.9s（全 ≤20 ✓）**；所有中段 **20~40 ✓**；**无 >40 段**；ED 尾段 ~13~15s 独立；moov 在头；段和 vs master **Δ≤0.08s**。
- 整片分段：GP-1 已切（全 ≤40，最长 39.96，无首段≤20 约束）→ 不重切，lite 1:1 转码即可。
- 高清、流畅两档：HD 段＝GP-1 既有(速览段本趟重切)、Lite 段＝本趟 236 个，一一对应、无缺。

### 3. 海报 + 章缩略图（`jobs/JOB-GP2/gp2-01-posters.mjs`，照 posters.mjs 法、用本机 cwebp）
- 每语×画幅：**章缩略图**(land 384×216/port 216×384，≤25KB，实测最大 23.3 ✓) + **章海报**(540/960，≤60KB) + **整片海报** + **速览海报** + **封面**(品牌帧)。
- 每语 thumbs=20、posters=24、cover=2。抽帧：章取片中代表帧、整片/速览/封面取 t=1.0 开场品牌卡。

### 4. 分享图（`jobs/JOB-GP2/gp2-01-share.mjs`，playwright 无头截图）
- 四语各一张 `<lang>/share-<lang>.jpg` 1200×630：品牌 MAXHOUSE + 四条重点橙✓ + 「Partner Guide」本语 + 副标 + 页脚 URL。
- 四条重点短标题取自 captions-v1 keypoints / OP 卡短标（与成片一字一致）。
- 四语 65~76KB（全 ≤150KB ✓）；**已肉眼核英、中两张渲染正确**（品牌/徽标/四✓/CJK 字体均正常）。

## 闸（GP2-01 收尾）逐条
- 四语×横竖×各段 高清与流畅齐全：✓（HD 既有＋Lite 236 全在，无缺 lite）
- ffprobe 分辨率在范围、moov 在头：✓（res 精确、全 moov-first）
- 码率在范围：✓（port 全区间内；land 上限守住，29 个静态段略低下限已记账）
- 分段清单 JSON 与镜头边界对上：✓（trailer-manifest 四语横竖重写，segs 带 shots）
- 速览首段 ≤20、所有段 20~40：✓（首段 12.9~14.9；中段全 20~40；ED 尾 ~13s 为设计内收尾段）

## 本机脚本/清单（入主仓库 jobs/JOB-GP2，未推）
`gp2-01-trailer.mjs`、`gp2-01-lite.mjs`、`gp2-01-posters.mjs`、`gp2-01-share.mjs`、`_run-lite.sh`、`_run-lite-port.sh`、`lite-gate-{en,zh,ru,fr}.json`、`poster-gate-{en,zh,ru,fr}.json`、`share-gate.json`。
成片/lite/海报/分享图本身在 `~/guide/dist/partner/`（不入 git、不传桶，上传留 GP2-02）。

## 下一步
GP2-02 上传脚本与清单（本机，不上传）→ GP2-03 引导页（停点二）。
