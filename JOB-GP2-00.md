# JOB-GP2-00 回执 · 先挡住不该公开的目录（停点一）

日期：2026-10-14（第 1 趟）。零 DB 写。CC 未碰线上/R2/Cloudflare/主仓库推送。

## 1. 红→绿清单（GP-2 全部产出）
| 产出 | 状态 |
|---|---|
| 挡法（functions/_middleware.js 返回 404） | ✅ 绿（已建、已本地验证、已提交） |
| 部署方式盘点 | ✅ 绿 |
| 顶层目录「该公开 / 不该公开」分类 | ✅ 绿 |
| 不该公开路径线上现状 curl 抽查 | ✅ 绿 |
| 本机 wrangler pages dev 逐条验证（内部 404 / 公开 200） | ✅ 绿 |
| 本地截图（shots/GP2/local/） | ✅ 绿 |
| G-9 cleanup dry-run（只读） | ✅ 绿 |
| 流畅档（GP2-01） | ⬜ 红（本任务不做，后续任务） |
| 分段清单（GP2-01/02） | ⬜ 红（后续） |
| 海报缩略图（GP2-01） | ⬜ 红（后续） |
| 分享图（GP2-01） | ⬜ 红（后续） |
| 上传脚本与清单（GP2-02） | ⬜ 红（后续） |
| 引导页（GP2-03） | ⬜ 红（后续） |
| 缓存规则 JSON（GP2-03） | ⬜ 红（后续） |
| 线上真验 + 测速（GP2-04） | ⬜ 红（后续） |
| 体检表（GP2-05） | ⬜ 红（后续） |

挡内部目录相关的 7 项全绿；其余红项属 GP2-01 起的后续任务，本停点不做。

## 2. 部署方式盘点
- **方式**：Cloudflare Pages + Git 集成，跟踪分支 `main`，**输出目录 = 仓库根**（push=自动部署，记忆与现状一致）。证据：`/jobs/QUEUE-G8.md`、`/supabase/**`、`/migrations/**` 线上可直接 GET 到仓库里的文件（见 §4）。
- **构建**：无 wrangler.toml / wrangler.json / .pages.yml / 构建命令；纯静态 + Pages Functions。
- **现有 Pages 配置**：只有 `_headers`（40 条 header 规则）；**无 `_routes.json`、无 `_redirects`**。Functions 现有 `functions/share/[[path]].js`、`functions/guide/school/**`（含 `_middleware.js`）。
- **线上 = origin/main**，本机 main 领先 origin/main **69 个提交**（66 条既有未推 + 本趟 3 条）。注意 `jobs/QUEUE-G8.md` **已在 origin/main、线上已 200**——即内部目录泄露**现在就存在**，挡法是关掉既有洞、非新增暴露。

## 3. 顶层分类（origin/main 顶层）
**该公开（放行）**：`index.html` `404.html` `favicon*.{ico,png}` `assets/` `vendor/`（tesseract OCR）`guide/`（student/school/后续 partner）`admin-portal/ student-portal/ school-portal/ reviewer-portal/ partner-portal/` `share/`（经 functions）`functions/`（serverless，非静态文件）`_headers`（Pages 配置，不作为资源服务）。

**不该公开（挡成 404）**：
- 顶层目录（11）：`jobs/` `supabase/` `migrations/` `docs/` `scripts/` `tests/` `assist/` `promo-video/` `shots/` `tools/` `.claude/`
- 根级散落文件（11）：`CLAUDE.md` `.env.example` `.gitignore` `gen-audit-1C.mjs` `selftest-1C.mjs` `selftest-audit-1C.mjs` `selftest-dedup.mjs` `selftest-fullflow.mjs` `selftest-JK.mjs` `selftest-OP.mjs` `selftest-uicap.mjs`

## 4. 线上现状抽查（curl，只读；只记路径与状态码）
| 路径 | 线上现状 |
|---|---|
| /jobs/QUEUE-G8.md | **200（泄露）** |
| /jobs/G1/captions-review.md | **200（泄露）** |
| /supabase/functions/_shared/cors.ts | **200（泄露·EF 源码）** |
| /migrations/0069_offer_live_unique.sql | **200（泄露·SQL）** |
| /assist/logo-blue.jpg | **200** |
| /shots/G7/school/H5-card-14-3.png | **200** |
| /tools/audit_refs.py | **200** |
| /.claude/commands/recon.md | **200** |
| /.gitignore | **200** |
| /selftest-OP.mjs | **200** |
| /gen-audit-1C.mjs | **200** |
| /docs/…handoff….md | 404（当前即 404，原因未知；挡法仍覆盖以求确定性） |
| /scripts/backup-db.sh | 404（同上） |
| /tests/README.md | 404（同上） |
| /promo-video/assist/…png | 404（同上） |
| /CLAUDE.md | 404（同上·但敏感度最高，仍纳入挡法以求确定） |
| /.env.example | 404（同上） |
| 公开 /、/partner-portal/、/guide/student/ | 200 |

> 为何有的已 404：origin/main 里这些文件都在（已核 `git cat-file -e`），线上却 404——属 Cloudflare 侧不明行为。**无论当前 200/404，Functions 中间件执行与静态文件是否存在无关，一律强制 404，故结果确定**。

## 5. 挡法（已建、未推）
`functions/_middleware.js`（新文件，62 行，提交 `d26edb1`，**只改这一个文件**）：
- 根中间件对 denylist 顶层前缀与根级文件一律返回 **404**（回品牌 `404.html`，与真实缺页无差别）；其余 `context.next()` 放行。
- **为何用根 `_middleware` 而非逐目录 `functions/<dir>/[[path]].js`**：①`.claude` 是点开头目录，Pages Functions 构建忽略点开头路由目录，逐目录函数挡不住；②根级散落文件逐个建函数零散易漏；③单文件集中声明便于审核。见决定账 **D-GP2-1-3**。
- 不改任何已有 functions；`/guide/school/*` 与 `/share/*` 既有函数链经 `next()` 照常执行（本地已验 200）。

## 6. 本机验证（npx wrangler pages dev · 端口 8788）
Worker 编译通过、40 条 header 规则解析通过。逐条 curl：
- **内部 → 404（16 条全过）**：/jobs/QUEUE-G8.md、/supabase/…cors.ts、/migrations/…sql、/docs/…、/scripts/backup-db.sh、/tests/README.md、/assist/logo-blue.jpg、/promo-video/…png、/shots/…png、/tools/audit_refs.py、/.claude/commands/recon.md、/CLAUDE.md、/.env.example、/.gitignore、/selftest-OP.mjs、/gen-audit-1C.mjs。
- **公开 → 200（全过）**：/、/404.html、/partner-portal/、/student-portal/、/school-portal/、/admin-portal/、/reviewer-portal/、/guide/student/、/guide/school/、/assets/fonts/manrope-300.woff2、/vendor/tesseract/tesseract.min.js、/favicon.ico、/share/。（/assets/ 目录根 404 = 无 index，正常。）
- 被挡路径返回的是品牌 404 页（OPS-1 404-fallback）、非内部文件内容。
- 截图：`~/mh-jobs/shots/GP2/local/{home-200,partner-portal-200,blocked-jobs-404,blocked-supabase-404}.png`。

## 7. G-9 尾巴（dry-run，只读，未 --apply）
`bash jobs/JOB-G9/cleanup-apply.sh --dry-run` 原样结果：
```
GUARD_OK delete=34 (pub=28 priv=6) bytes=202784780
protected_24h still holding: 0 pub
```
删除集：pub 28（guide/student/v2/{ru,zh} 的 c10-g8/lite/full/quick/quick-lite + posters/thumbs 等被 g9 顶替旧对象）+ priv 6（guide/school/v1/zh/quick-lite-g9-01..06）。**与任务书预期 public=28 private=6 一致**，守卫 GUARD_OK、零断链、24h 保护 0。CC 不 --apply（留业主卡 §步④）。

## 8. 提交与账
- 主仓库提交（未推）：`d26edb1` 挡法（仅 functions/_middleware.js）、`9c086a5` 截图工具（jobs/JOB-GP2/_shot-local.mjs）、另 `e236a6a` GP2-00a。
- 决定：D-GP2-1-3（挡法选根中间件，见 DECISIONS.md）。
- 请示单：`jobs/JOB-GP2/NEEDS_OWNER_DECISION.md`（＋ ~/mh-jobs/JOB-GP2-NEEDS_OWNER_DECISION-<ts>.md）。停点一，结束本趟。
