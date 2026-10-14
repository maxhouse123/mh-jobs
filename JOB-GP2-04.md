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

---

## 【第 7 趟续办｜2026-10-15】CORS 修复上线后 · 线上真验 ALL PASS + 测速

承 `RULING-20261014e-gp2-04-fix-live`（业主卡 1391 推 33a02cb 上线，同源清单 m/<lang>/ + 版本串 gp2-20261014b）。本趟真浏览器打真线上续验。

### 一、线上真验（真浏览器，经代理打 https://www.maxhouses.net/guide/partner/）—— ALL PASS ✅
`node gp2-04-verify.mjs`，16 个 context 全绿：
- **主循环 8 个**（en/zh/ru/fr × 手机405/电脑1440）：http_200 / 无裸键 / 四条重点 / **十章** / 邀请码 MAXHOUSE-PARTNER-2026 显示可复制 / 注册带 src=guide-<lang> / robots noindex / og 本语言 share-<lang>.jpg / 无横向溢出 / 可点区≥44 / 画幅自动（手机 port·电脑 land）/ **点第1章真 CDN 出首帧**（408~1130ms）/ nodownload / 切画幅 / 切语言 / **0 控制台错误（CORS 已灭）** —— 每项 PASS。
- **速览分段串播 4 个**（lite 强制，en/zh/ru/fr）：segmode✓ / 接缝前进 segReqs=2✓ / **真实连续播放**（窗口采样 advances=6）✓。
- **弱网自动降档 2 个**（connection=3g stub，zh/en）：3g 识别✓ / 点整片自动走 lite 分段（seqNav 显示）✓。
- **整片 HD 母带 2 个**（hd 档，en/zh 电脑）：单 master 非分段✓ / **连续播放**（advances=8）✓ / 0 控制台错误✓。

截图 16 张入 `~/mh-jobs/shots/GP2/online/gp2-04-*.png`（旧 gp2-04-BROKEN-*.png 保留作上趟病证，已被本趟绿图取代）。肉眼复核 zh-mobile（竖·十章齐）/ en-desktop（横·十章齐）渲染正确。

**工装两处加固（只改工装脚本，不碰端口/页面）**：① `quick_playing` 原为单点采样，恰落切段握手瞬态→误判；改为 ~3s 窗口采样「currentTime 真前进」。② 弱网降档加 400ms 绑定 settle + 单次补点，吸收多 context 后偶发漏点。加固前后逻辑经专项探针 `_probe-quick-play.mjs`（四语 36~38/40 采样在播、0 暂停）与 `_probe-downgrade.mjs`（en×2/zh effQ=lite、seqNav 1ms 显示）双证。

### 二、测速（gp2-04-measure.mjs，CDP 模拟网 + 手机 CPU×4，每格多次取中位）
| 档 | 网 | 视图 | 连法 | 点章出画面(中位) | 速览首帧 | 卡顿 | 判 |
|---|---|---|---|---|---|---|---|
| 流畅 lite | 3G | 手机 | 代理 | **1475ms** | 931ms | 0 | ✅ ≤2.5s |
| 流畅 lite | 3G | 手机 | 直连 | **1646ms** | 929ms | 0 | ✅ ≤2.5s |
| 流畅 lite | 慢3G | 手机 | 代理 | **6766ms** | 2870ms | 4 | 🔴 >4s |
| 流畅 lite | 慢3G | 手机 | 直连 | **6074ms** | 3023ms | 4 | 🔴 >4s |
| 高清 hd | 4G | 手机 | 代理 | 895ms | 1457ms | **0** | ✅ 0卡顿 |
| 高清 hd | 4G | 电脑 | 代理 | 739ms | 1575ms | **0** | ✅ 0卡顿 |

- 首屏首字节 1.6~2.9s；页面 cache-control `max-age=300, stale-while-revalidate=86400`。
- **第 2 次访问 cf-cache-status = DYNAMIC**（两次都 DYNAMIC）——因 `/guide/partner` 的**边缘缓存规则属 GP2-06 业主卡**（apply-cache-rule.sh 已备、CC 不执行），现状无边缘缓存属预期，不算缺陷。
- **🔴 唯一未达线：慢3G（400kbps）点章 ~6s > 4s**。直连/代理一致（非代理假象），属物理带宽下限（lite ch1 首帧需缓冲量 ÷ 400kbps≈6s）；慢3G 速览亦 4 次停顿。按任务书 §GP2-04-2「达不到的如实标红，不无限追加」——**标红如实记录，不再追加压缩**（再压会伤画质/违码率下限）。3G 及以上、4G 高清全部达标。

### 三、结论
线上引导页**已完全可用**：十章加载、四语、画幅自动、点章/速览/整片均真实播放、CORS 零错、弱网自动降档生效。测速除慢3G 点章一项标红外全部达标。GP2-04 收口。下一步 GP2-05 全线体检 + 收官。
