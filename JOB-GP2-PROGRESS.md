最后一趟：2026-10-14 第 3 趟 GP-2：做完 GP2-01 成片整理（236 个 lite 全过 land178~250/port153~217、速览四语横竖重切首段≤20无>40、每语 20 缩略图+24 海报+封面、四语分享图 65~76KB 已肉眼核）；主仓库攒下 GP2-01 脚本+gate 清单一笔(未推)。下趟＝GP2-02 上传脚本与清单（本机，不上传）。

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
