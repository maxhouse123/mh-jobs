最后一趟：2026-10-14 14:56 GP-2：第 2 趟做完 GP2-00b（补 _routes.json 收窄函数作用域至 24 条路径 + 中间件 404 加取证头 x-mh-block:1；本机 wrangler 重验内部 16/16=404+头、公开 9/9=200 无头、share+guide-school 经函数实锤；实测本机 dev 不认 _routes.json 已记账并写进请示单由线上验兜底；G-9 dry-run 仍 GUARD_OK pub=28 priv=6；主仓库提交 a850824 未推），停在停点一已写新请示单。下趟＝等业主卡装 RULING-*-gp2-00-done.md 后接 GP2-01 成片整理。

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
