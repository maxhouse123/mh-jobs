# JOB-GS5-02 回执 · 媒体提速：边缘缓存 + 缓存头 + 缓存规则 + faststart

日期 2026-10-07 ｜ 无人值守 ｜ 包 GS5-02 ｜ 改 `functions/guide/school/media/[[path]].js` + `_headers` 的 /guide/school/ 段 + 新建一条 Cloudflare 缓存规则

## 一句话
给视频「提速」做了四件事：①视频文件第一次放出来后在 Cloudflare 边缘存一份，**同一个视频第二次打开直接从边缘拿、更快**；②目录页 HTML 允许边缘缓存（页面本身不含密钥）；③在 Cloudflare 加了一条只管 `/guide/school/` 页面的缓存规则；④核对了所有 18 个 mp4 的「快启动」标记——**全都已经在文件头，不用动**。**鉴权一个字没改**：没有访问码照样 403，缓存只在验过码之后才查/写，缓存里不含访问码。

## 具体改了什么
1. **媒体函数加边缘缓存（鉴权逻辑一字不动）** `functions/guide/school/media/[[path]].js`
   - 顺序铁定：**先验通行证 + 码仍 active + 设备在册**（原样保留），**全部通过后**才进缓存逻辑；无证/码失效在任何缓存动作之前就 403。
   - 缓存键 = 规范化 URL（**剥掉 Cookie、不含访问码、不含 Range**），所以同一视频所有持证用户共享边缘那一份。
   - 命中：由 Cloudflare 边缘按 Range 切 206 回；**回给浏览器的响应头仍强制 `private, no-store`**（视频绝不进浏览器缓存、不可下载，安全不降），只额外打一个 `cf-cache: HIT` 标记。
   - 未命中：后台（`ctx.waitUntil`）取完整对象写入边缘（TTL 7 天），**本次请求照旧按 Range 从 R2 流式回**（放流逻辑与原来逐行一致），打 `cf-cache: MISS`。
   - manifest、缩略图、各 mp4 同一条路径、同样先过闸。
2. **HTML 缓存头** `_headers` 的 /guide/school/ 段：目录页 `/guide/school/`（含 index.html）改 `public, max-age=300, stale-while-revalidate=86400`；**`/guide/school/api/*`、`/media/*`、`/admin/*` 一律 `no-store`**（码态实时、媒体服务端放流、后台走 Access）。
3. **Cloudflare 缓存规则**（只经 `jobs/cf-api.sh`，先 GET 留底再改）
   - 区域 maxhouses.net。先 GET 现有缓存规则存底 `jobs/JOB-GS5/cf/cache-ruleset-before.json`：原有 2 条（`portal versioned html`、`guide-student-html`）。
   - **发现 `/guide/student` 已有自己的 `guide-student-html` 规则**；为遵「不改其它规则」，本轮**只新增** 1 条 `guide-html-cache`，**只管 `/guide/school/` 的 HTML**（表达式排除 `/api`、`/media`、`/admin`），`cache=true`、`edge_ttl=respect_origin`（按 Cache-Control 计 TTL）。用 POST 追加单条，不动原 2 条。
   - GET 回读核对 `jobs/JOB-GS5/cf/cache-ruleset-after.json`：3 条规则，**原 2 条逐字段未变**（程序核对 same=true），新规则在、enabled、respect_origin、表达式正确。
4. **faststart**：本机 `guide/dist/school/zh/` 下 18 个 mp4（14 章 + 开场 + 片尾 + 整片 + 速览）逐个扫顶层 atom —— **全部 `ftyp → moov → …mdat`，moov 在文件头**（装配流水线 concatCopy 本就带 `-movflags +faststart`）。**无需重 mux、无需重传**。

## 上线前的活体安检（现部署仍是 gs4 旧函数，缓存规则已即时生效）
缓存规则是 Cloudflare 侧即时生效的；但新 `_headers` 与新媒体函数要等 GS5-04 推送部署后才上线。现在实测确认规则没搞坏线上：
- 无证取 media manifest → **403** ✅（鉴权完好）
- 目录页 HTML → 200，`cache-control: no-store`、`cf-cache: BYPASS` ✅（新 _headers 未部署前仍 no-store，规则 respect_origin 正确尊重 no-store 不缓存，**非破坏**；部署新头后应转 HIT）
- 有证取 media manifest → **200** ✅

## 为什么 22 条线上真验放到 GS5-04
改过的媒体函数与 _headers **要 push 部署后才上线**，只有上线环境才能真测缓存命中/无证 403/停码失效。故 GS-1 的 12 条 + GS-4 的 10 条 + 本轮 6 条（点章全屏、Esc 回目录、自动下一章保持全屏、EN 不可见、缩略图首屏 ≤6、第二次 cf-cache=HIT）**统一在 GS5-04 推送后跑**，一条不过不收口。

## 范围与红线
- 鉴权逻辑逐行未改；缓存键不含码；无证 403 在缓存之前。
- Cloudflare 只经 cf-api.sh、禁 DELETE；只新增 1 条规则，DNS/Access/绑定/其它规则未碰。
- 主仓库已 commit 未 push（`18e488d JOB-GS5-02 …`），统一 GS5-04 推送。

## 下一步
GS5-03：按 GS5-00 审计——仅 14-1「六类→五类」计数错需改（涉重录 ch14 + 重合成整片/速览 + 重传 + 改 manifest）；2-1/7-2/12-5 为近义/代表性、已判匹配不重录。将评估重录可行性与风险后决定。
