# JOB-GP2-00b 回执 · 补 _routes.json + 中间件取证头（第 2 趟）

承 RULING-20261014b-gp2-00-routes（答复停点一请示单，该请示单已被业主卡改名 -resolved）。

## 0. 开工核对
- 五端口 `git diff origin/main --stat -- student-portal school-portal partner-portal admin-portal reviewer-portal` 为空 —— PASS（本趟零端口改动）。
- 本趟只改两个文件：新建 `_routes.json`、改 `functions/_middleware.js`。零 DB 写。

## 1. 做了什么（照 RULING 二/三/五）
### 1.1 新建仓库根 `_routes.json`（收窄函数作用域）
- 格式：`version:1`、`include` 24 条、`exclude:[]`；通配符只在末尾；规则数 24 « 100 上限。
- 校验：`python3 -m json.tool` OK；`node` 读出 version=1 / include=24 / exclude=0 / 末尾外通配符=0。
- include 24 条 = ①既有函数 `/share/*`、`/guide/school/*`（**必含，漏则绕过学校端访问码闸、分享函数失效**）② 11 内部目录 `/jobs/* /supabase/* /migrations/* /docs/* /scripts/* /tests/* /assist/* /promo-video/* /shots/* /tools/* /.claude/*` ③ 11 根级文件 `/CLAUDE.md /.env.example /.gitignore /gen-audit-1C.mjs /selftest-1C.mjs /selftest-audit-1C.mjs /selftest-dedup.mjs /selftest-fullflow.mjs /selftest-JK.mjs /selftest-OP.mjs /selftest-uicap.mjs`。
- 作用：生产环境 Pages 只对这 24 条路径调函数；其余（首页、五端口、assets、字体、tesseract、guide/student、favicon…）直接出静态文件——省一跳、不吃免费档每日 10 万次函数额度、中间件 bug 不波及全站。
- 盘点确认 `functions/` 下只有 `share/` 与 `guide/school/` 两棵函数树（`find functions -type f`），两者都在 include，**无既有函数被 include 漏掉**。

### 1.2 改 `functions/_middleware.js`（只加取证头 + 注释）
- 命中挡法返回 404 时加一个头 `x-mh-block: 1`（品牌 404 与纯文本兜底两条都加）；denylist / next() 透传逻辑一字未动。
- 顶部加注释说明 _routes.json 作用域与「DENY 两组须与 include 第 2、3 组一一对应」。
- `node --check` 语法通过。diff：`functions/_middleware.js | 19 insertions(+), 2 deletions(-)`。

## 2. 本机重验（`~/mh-verify` 的 wrangler 3.114.17 · `wrangler pages dev . :8789`）
Worker 编译通过、40 条 header 规则解析通过。curl 逐条（`--noproxy '*'`）：

**内部 16 条（期望 404 + x-mh-block=1）全过**：
/jobs/QUEUE-G8.md、/supabase/config.toml、/migrations/x.sql、/docs/ui-design-language.md、/scripts/backup-db.sh、/tests/README.md、/assist/logo-blue.jpg、/promo-video/x.png、/shots/x.png、/tools/audit_refs.py、/.claude/commands/recon.md、/CLAUDE.md、/.env.example、/.gitignore、/selftest-OP.mjs、/gen-audit-1C.mjs —— 全部 `code=404 x-mh-block=1`。

**公开 9 条（期望 200 + 无 x-mh-block）全过**：
/、/partner-portal/、/student-portal/、/school-portal/、/admin-portal/、/reviewer-portal/、/guide/student/、/vendor/tesseract/tesseract.min.js、/favicon.ico —— 全部 `code=200 x-mh-block=0`。

**/share/ 与 /guide/school/ 仍走各自函数（RULING 四.3，不只看 200）**：
- `/guide/school/admin/api/ping` → **403** `{"error":"forbidden","reason":"access_required"}` —— 这是 guide/school 中间件验 Access 失败的专有响应，根中间件挡法只会回 404+x-mh-block，故此 403 实锤 guide/school 函数链执行。
- `/guide/school/` → 200、无 x-mh-block。
- `/share/og-brand.png` → 200 image/png（share 函数非 HTML 原样透传）。
- `/share/TESTTOKEN123` → 404 text/html、带 `Access-Control-Allow-Origin:*`、**无 x-mh-block** —— 是 share 函数路径（取不到投影回退静态 404.html），非根中间件挡法。

**Playwright 截图 + 头取证（`jobs/JOB-GP2/_shot-local-00b.mjs`，:8789）ALL PASS**：
home-200 / guide-student-200 / guide-school-fn-200（均 200 x-mh-block=0）、blocked-jobs-404 / blocked-claude-404（均 404 x-mh-block=1）。图推 `~/mh-jobs/shots/GP2/local/`。

## 3. RULING 四.4：wrangler 是否认 _routes.json —— 实测「本机 dev 不认，但不影响挡法正确性」
判别法（不改任何文件）：`/jobs`（裸目录，无尾斜杠）**不被 include 的 `/jobs/*` 匹配**，但被中间件 `isBlocked('/jobs')` 命中。
- 实测 `/jobs`、`/supabase`、`/docs`、`/tools` 裸目录 → **404 + x-mh-block=1**。
- 结论：本机 `wrangler pages dev` 3.114.17 **不按 _routes.json 做作用域裁剪**，对所有路由都跑函数（已知的本机 dev 局限）。因为裸 `/jobs` 不在 include 却仍被中间件挡，只能是中间件在 include 外的路径上也执行了。
- 不影响正确性的理由：①挡法本身靠中间件 `isBlocked`，与 _routes.json 无关 —— 16 条内部全 404+头、9 条公开全 200 已证；②_routes.json 的 schema 合法（version1/24include/exclude空/末尾通配符/«100 条）已证；③include 恰好 = 两棵既有函数树 + denylist，无函数被漏；④生产环境 Cloudflare 按 _routes.json 规范执行：只 24 条 include 走函数，其余纯静态，正是 RULING 二节的提速/额度/爆炸半径目标。
- 生产无空洞核查：唯一不被 `/<dir>/*` 匹配的是裸 `/<dir>`（无尾斜杠）。该目录下每个真实文件都是 `/<dir>/x` 形态、被 include 命中→中间件 404；裸 `/<dir>` 本身无可服务的静态资产（Pages 不做目录列举），生产回 404 或 308→`/<dir>/`（再被 include 命中挡），无泄漏。

## 4. G-9 尾巴（dry-run，只读，未 --apply）
本趟重跑 `bash jobs/JOB-G9/cleanup-apply.sh --dry-run` 原样结果：
```
GUARD_OK delete=34 (pub=28 priv=6) bytes=202784780
protected_24h still holding: 0 pub (未到24h的顶替对象=本趟不删)
replaced-list already absent (pub): 0
OTHER unreferenced NOT deleting: pub=0 priv=0
```
与任务书预期 public=28 private=6 一致、守卫 GUARD_OK、零断链。CC 不 --apply（留业主卡）。
（注：dry-run 会重写 `jobs/JOB-G9/cleanup-plan-g9.json` 为计划产物；该文件属 G-9 线，本线不提交、不碰。）

## 5. 提交与账
- 主仓库提交（**未推**）：`a850824` JOB-GP2-00b（**仅** `_routes.json` 新增 + `functions/_middleware.js` 改，一笔）。
- 连同上趟待推：`d26edb1`（挡法 functions/_middleware.js 首版）、`9c086a5`（截图工具）、`590354e`、`e236a6a` 等 JOB-GP1/GP2 提交。
- 决定账：D-GP2-2-1。
- 请示单（停点一）：`jobs/JOB-GP2/NEEDS_OWNER_DECISION.md` ＋ `~/mh-jobs/JOB-GP2-NEEDS_OWNER_DECISION-20261014-1454.md`。结束本趟。

## 6. 下趟
业主卡照请示单：单推挡法两文件（_routes.json + _middleware.js）上线→线上验内部 404 带头/公开 200 不带头/share+guide-school 经函数→再推其余攒下提交→G-9 --apply→装 RULING-*-gp2-00-done.md 重启循环→接 GP2-01 成片整理。
