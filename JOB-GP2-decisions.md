# JOB-GP2 决定账

CC 自己做的每个决定按 D-GP2-<趟>-<序> 记在这里；每趟结束复制到 ~/mh-jobs/JOB-GP2-decisions.md 推送。

## 第 1 趟（2026-10-14）

- **D-GP2-1-1** · GP2-00a 联络表重出 · ch2 的 2-4 分段联络表用现成 `rec/_seg-strip-24.mjs` 重跑，该工具一次循环四语。裁决只点名英/俄/法（zh ch2 第四轮未重烧），但工具对 zh 也从「当前最终成片」重渲一张同名图——内容与旧图一致、纯覆盖、无副作用，故不改工具、四语全出。理由：最省改动且结果自洽（覆盖口径＝「文件名与原来一致」）。改文件：~/mh-jobs/shots/GP1/{en,zh,ru,fr}/ch2-2-4-segments-*.png。
- **D-GP2-1-3** · GP2-00 挡法选「根 `functions/_middleware.js` denylist」而非任务书首选的「逐目录 `functions/<dir>/[[path]].js`」。理由：①`.claude` 是点开头目录，Pages Functions 构建忽略点开头路由目录 → 逐目录函数挡不住，会漏；②根目录散落文件（CLAUDE.md/.env.example/.gitignore/selftest-*.mjs/gen-audit-1C.mjs）逐个建函数零散且易漏；③一个文件集中声明 denylist 便于审核与维护，对公开路径仅 next() 透传。任务书明说「选一种在 Cloudflare Pages 上确定生效的挡法」且散落文件可列给 Claude 裁——本法一次覆盖目录+点目录+散落文件，更完整。风险（中间件跑在 100% 请求上、逻辑错可能误挡公开页）由本机 wrangler pages dev 逐条验证兜住：公开页/资源/share 全 200、16 条内部路径全 404。改文件：仅新建 functions/_middleware.js，不动任何已有 functions。
- **D-GP2-1-2** · GP2-00a 禁用词复扫 · 第 53 趟 ch6 横版复扫「登录限流」的真病根＝登录账号是 gmail，原 `_scan-ch6-forbidden.mjs` 的 MASK_INIT 作为 initScript 在登录前把 #emailInput 的真 gmail 改写成 DEMO → Supabase 返 Invalid credentials，被误判为限流。修法：①照裁决「每语只登录一次」把 8 次登录降到 4（每语一 context，land/port 共用会话）；②MASK/HIDE 改到登录解锁后再 page.evaluate 注入（扫描内容在注入后渲染，遮罩口径不变）。新工具 `jobs/JOB-GP2/_scan-ch6-forbidden-gp2.mjs`，原工具不动。结果四语横竖 ALL CLEAN。理由：定位到真因后，正确修比空等限流窗口更稳，且满足裁决的「每语一次登录」。

## 第 2 趟（2026-10-14）

- **D-GP2-2-1** · GP2-00b `_routes.json` 的 include 严格照 RULING-20261014b 24 条（既有 `/share/*`、`/guide/school/*` + 11 内部目录 + 11 根级文件），`exclude:[]`。实测本机 `wrangler pages dev` 3.114.17 **不认 _routes.json**（对所有路由都跑函数）：判据＝裸 `/jobs`（不被 `/jobs/*` include 匹配）仍返 404+x-mh-block，说明中间件在 include 外路径也执行。决定：不因本机 dev 不认而改设计——①挡法正确性靠中间件 isBlocked 本身（已逐条验），与 _routes.json 无关；②_routes.json 是生产侧提速/额度/爆炸半径优化，Cloudflare 生产按规范执行；③经核 `functions/` 仅 share/ 与 guide/school/ 两棵函数树、都在 include，无函数被漏；④生产无空洞（裸 `/<dir>` 无可服务资产、Pages 不做目录列举）。把这一「本机不认」的事实写进请示单，由业主卡在**线上**验第六节第 2 条兜底。理由：RULING 四.4 明确允许「本机不认就写清原因 + 用别的办法证明路由正确」，本法已给出判据与生产正确性论证。
