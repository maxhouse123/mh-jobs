# JOB-GP2-04 · 线上真验 + 测速（第 6 趟，2026-10-14）

开工核对：五端口 `git diff origin/main --stat` 为空、无未跟踪端口文件 —— PASS。停点二已由业主卡 1390 解除（528 对象传入公开桶 v4/、5 笔推上线 1c1adfd、装 RULING-20261014d-gp2-03-live）。

## 结论（重要）
**线上引导页当前不可用 —— 十章永不加载、页面停在「Could not load」。这是一个只在线上暴露的阻断缺陷。**
已定位病根、备好修法并本机 E2E 实证修复有效；**上线需推主仓库（停点④），写请示单停下，等业主卡推送后再续 GP2-04 线上真验与测速。**

## 一、线上真验（只读，经代理无头浏览器打真线上）
对 `https://www.maxhouses.net/guide/partner/?lang=<en|zh|ru|fr>` 四语 × 手机405/电脑1440 真验，发现：

- 页面 HTML 本身 200、robots noindex 在、邀请码 `MAXHOUSE-PARTNER-2026` 显示、注册按钮 href 运行时拼成 `/partner-portal/?src=guide-<lang>`、og:image 本语言、四语分享图 200 image/jpeg、去下载（video `controlsList=nodownload`）—— 这些**静态/DOM 项全在**。
- **但章列表（`#chList .ch`）永远是 0 条**，页面显示 `Could not load — tap to retry`。控制台实证：
  ```
  Access to fetch at 'https://media.maxhouses.net/guide/partner/v4/en/lite-manifest.json?v=gp2-20261014'
  from origin 'https://www.maxhouses.net' has been blocked by CORS policy:
  No 'Access-Control-Allow-Origin' header is present on the requested resource.
  （manifest.json 同样被挡）
  ```
- 截图（打码无需，无 PII）：`shots/GP2/online/gp2-04-BROKEN-en.png`、`gp2-04-BROKEN-zh.png`。

### 病根
GP2-03 页面 `fetchManifest()` 用跨源 `fetch()` 取 `media.maxhouses.net` 上的 `manifest.json`/`lite-manifest.json`。curl 带 `Origin` 实证：media.maxhouses.net **不发 `Access-Control-Allow-Origin` 头**（桶未配 CORS），故浏览器 CORS 挡下跨源 JSON 读取 → `MAN` 空 → 十章不渲染、整片/速览/点章全失效。
- 媒体视频本身没问题：`Range` 请求 206、`<video>`/`<img>` 元素跨源直载不需要 CORS。只有 `fetch()`/XHR 读跨源响应才需 ACAO。
- **线上学生页为何没事**：它不跨源 fetch 清单——章数据内联在页面、媒体以元素直载。伙伴页 GP2-03 新引入的「运行时 fetch 清单」是唯一需要 CORS 的调用。
- **本地闸为何没抓到**：`gp2-03-gate.mjs` 用 `route.fulfill` 把清单当同源本机文件喂入，绕过 CORS（route-stub 假模式盲区）。
- **业主卡验收为何没抓到**：业主卡只 curl HEAD 200 + 查 robots/邀请码，HEAD 不触发 CORS、未用浏览器驱动 fetch。

## 二、修法已备好并本机 E2E 实证（Option 2：同源清单，不碰基建）
- 4 语 `manifest.json`+`lite-manifest.json`（共 8 文件、64KB）从 ~/guide/dist cp 进 `guide/partner/m/<lang>/`，由 Pages **同源**服务。
- 页面 `fetchManifest` 一行：`var b=D.MEDIA+'/'+lang` → `var b='m/'+lang`（同源相对址）。清单内 `base` 仍指 media.maxhouses.net 的 R2，**媒体照旧 R2 直载**（视频/图是元素、无需 CORS）。BUILD `gp2-20261014`→`gp2-20261014b`（版本探针随之变，便于验新部署）。
- **自验**：
  - 本地闸 `gp2-03-gate.mjs` 8 context × 14 项仍 **ALL PASS**（章帧 82~164ms）。
  - **新增 E2E 真验**（`jobs/JOB-GP2/_probe-cors-fix.mjs`）：`wrangler pages dev` 同源服页 + **真实 R2 媒体经代理**（localhost bypass）：
    ```
    [en] chapters=10 realMediaFrame=true(919ms)  corsErrs=0 => PASS
    [zh] chapters=10 realMediaFrame=true(1234ms) corsErrs=0 => PASS
    [ru] chapters=10 realMediaFrame=true(1385ms) corsErrs=0 => PASS
    [fr] chapters=10 realMediaFrame=true(1227ms) corsErrs=0 => PASS
    CORS-FIX E2E: ALL PASS ✅（同源清单 + 真 R2 媒体，CORS 错误=0）
    ```
- 为何不取 Option 1（给 R2 桶加 CORS）：那动 Cloudflare/R2（本线红线不碰）、有全桶 blast radius、本机无法自验；同源清单自包含、合仓库 self-host 哲学、我能全程自验。详见请示单。

## 三、测速（本趟无法在线上做，随修复推上后补）
验收线（流畅档 3G 点章 ≤2.5s / 慢3G ≤4s / 高清 4G 0 卡顿）都要页面能加载章节才能测；线上现在十章不加载，**测速推迟到 CORS 修复推上线后的下一趟**（用 `jobs/JOB-GP2/gp2-04-measure.mjs`，照 g9-05-measure 口径，net=4g/3g/slow3g × 直连/代理）。本趟只得到页面 HTML 首字节正常。

## 四、RULING-20261014d 三件只读附加（都只读、都未执行线上）
1. **CF 缓存规则**：`bash jobs/cf-api.sh GET` 实读线上 cache ruleset（存档 `jobs/JOB-GP2/cf/cache-ruleset-live-20261014.json`）。两条 guide-student 规则逐字段：
   - `guide-student-html`：expr `(starts_with(path,"/guide/student"))`；edge_ttl=**bypass_by_default**、browser_ttl=respect_origin、cache=true。
   - `guide-student-html-cache`：expr `(http.host eq "www.maxhouses.net" and starts_with(path,"/guide/student"))`；edge_ttl=**respect_origin**、browser_ttl=respect_origin、cache=true。**（最后匹配、真正生效的是这条＝边缘真缓存）**
   据此把 `jobs/JOB-GP2/cf/guide-partner-html-cache-rule.json` 改成克隆 `guide-student-html-cache`（expr 换 `/guide/partner`）；新增幂等脚本 `jobs/JOB-GP2/cf/apply-cache-rule.sh`（按名查重跳过、只增不改不删、改前改后各 GET、`--dry-run` 纯 GET）。CC 不执行；`--dry-run` 实证：规则未存在、ruleset id 解析正常。`/guide/partner/` 裸地址连取两次 cf-cache-status 均 **DYNAMIC**（无缓存规则，佐证需加，留 GP2-06）。
2. **G-9 收尾脚本 bash 3.2 兼容**：`jobs/JOB-G9/cleanup-apply.sh` 的 `mapfile`（bash 4.0+）改为 `read` 循环读数组。`/bin/bash -n` 语法通过；`/bin/bash --dry-run` 自证 `GUARD_OK delete=34 (pub=28 priv=6)`（RULING-d 预期数）。**未执行删除**。按提交白名单不随 GP2 提交，脚本改动留在工作区给业主 G-9 卡取用。
3. **裸地址 `/jobs/QUEUE-G8.md`**：本趟实测 `HTTP/2 404  x-mh-block: 1  cf-cache-status: DYNAMIC` —— 仍 404、挡法有效（与业主卡 1390 一致）。未清任何缓存。
4. 教训入账 D-GP2-6-4（变量后紧跟全角字符用 `${var}` + 真改真传路径要在本机跑真实分支假模式）。

## 五、本机攒下、未推
主仓库点名提交（未推）：`guide/partner/`（页面 CORS 修 + `m/<lang>/` 8 个同源清单 + BUILD bump）、`jobs/JOB-GP2`（cf 规则改 + apply-cache-rule.sh + cache-ruleset 存档 + gp2-04-verify/measure/_probe-* 脚本 + DECISIONS）。`jobs/JOB-G9/cleanup-apply.sh` 的 bash3.2 修改留工作区不提交（白名单外，给 G-9 业主卡）。

**下一步**：写请示单（CORS 修复推送 + 可选 GP2-06 缓存规则/G-9 两张业主卡），停本趟。业主卡推送 `guide/partner/**` 后，下趟续 GP2-04 线上真验（应全绿）+ 测速 → GP2-05 收官。
