# JOB-G8-00c · 体检先红（只读）— 第 3 趟（跑完学生线测速矩阵 + 打通学校线测速）

日期 2026-10-10　机器 Mac mini　本趟代号 G8-00（第 3 趟续做）

## 一句话（大白话）
前两趟把摸底做完了，就差三件：①完整测速矩阵、②清理摸底、③第10章 live 确认。本趟把**测速矩阵的学生线两种语言（英文+中文）全部 28 格跑完了**，数据存进 `speed-before.json`；还顺手把**学校线测速的拦路虎（访问码闸门）打通了**——自造了 `G8-test` 码、改好测速脚本能自动输码进门、冒烟验证能真测到学校视频。**还差**：学校线矩阵 14 格（下趟直接开跑，全就绪）、清理摸底、第10章 live 确认。

---

## 本趟做完的（真数据）

### 1) 学生线测速矩阵 28 格全跑完 → `jobs/JOB-G8/speed-before.json`
英文、中文各 14 格（直连/代理 × 无限速/4G/3G/慢3G × 单章ch1/整片full/速览quick），每格 3 次取中位。**0 个坏格**。已复制到 `~/mh-jobs/JOB-G8-00-speed-before.json`。

**关键 TTFF（出第一帧毫秒，中位；代理路=海外学生）：**

| 场景 | 单章ch1 | 整片full | 速览quick | 判 |
|---|---|---|---|---|
| 代理·无限速 en/zh | 481 / 529 | 840 / 955 | 660 / 716 | 绿 |
| 代理·4G en/zh | 624 / 603 | 1730 / 2007 | 924 / 1058 | 绿 |
| 代理·3G en/zh | 1165 / 1158 | **3947 / 4780** | 1977 / 2154 | 🟡 整片偏慢 |
| 代理·慢3G en/zh | 3771 / 3782 | （矩阵不测full）| **7054 / 7758** | 🔴 速览 >6s |
| 直连·无限速 en/zh | 482 / 619 | 855 / 929 | 682 / 692 | 绿 |

**60 秒真卡顿**（只有带 `--stall 60` 的单章格真观察 60 秒；其余格的「1 次卡顿」其实是**出第一帧前的起播缓冲**，不是播放中断，stallMs≈TTFF 为证）：
- 单章 ch1 在 无限速/4G/3G 下 **60 秒内 0 次真卡顿**（那 1 次=起播缓冲）。
- 单章 ch1 慢3G：en 2 次/累计 4.6s、zh 2 次/累计 4.0s → **除起播外约 1 次真卡顿**。单章整体表现其实不差。

**协议**：页面与资源全走 **h2（HTTP/2），没有 h3/QUIC**。→ 坐实「http3 疑似关」（与前趟令牌读不到 zone 设置、tiered_cache=off 吻合），G8-01 要开 http3。

**cf-cache**：页面与媒体第 2/3 次基本 HIT（个别第 1 次 MISS/UPDATING）；「2 次后 HIT」达成，和前趟结论一致。

**本趟先红结论**：真痛点是**弱网下整片/速览出第一帧太慢**（慢3G 速览 7–7.8s 红、3G 整片 4–4.8s 黄；根因=整片 moov 586–762KB@400k 要 12–16s、1080p 重），**不是** HTML/媒体不缓存。单章表现良好。→ G8-04 的 540p 流畅版 + 串播（整片不再整包下 moov）是对症的。

### 2) 学校线测速打通（访问码闸门已解决）
- 学校观看页 `guide/school/` 有**访问码闸门**（`#gateView`→输码→POST `/guide/school/api/redeem` 核码种 `mh_gs` cookie→boot 时 `/api/me` 自动解锁出播放器）。码存在 Cloudflare KV（命名空间 `worker-mh-guide-gate`=GATE_KV）。
- **自造 `G8-test` 码**（§1.1 要求：max_devices=5、2天过期）：用 `bash jobs/cf-api.sh PUT` 写进 KV（令牌有 KV 写权限，成功）。码值、码记录文件放 `jobs/JOB-G8/.gate-code*`，**已加 .gitignore，绝不进仓库/截图/回执正文**。过期时间 2026-10-12（够下几趟用），**G8-05 验完要删它**（删前列清单、只删它、绝不动业主自用码）。
- **改好 `measure.mjs`**：学校线在 goto 前用 `ctx.request.post` 自动 redeem 种 cookie（码从环境变量 `MH_GATE_CODE` 读、不写死），页面自动解锁。单一稳定设备号 `g8-measure-dev`，少占配额。
- **冒烟验证通过**：`MH_GATE_CODE=$(cat jobs/JOB-G8/.gate-code) node measure.mjs --line school --lang zh --path proxy --net none --what quick --runs 1 --stall 0` → TTFF 894ms、真播到 `quick-g7.mp4?v=...`、成功解锁。
- ⚠ 学校媒体 URL 带 `?v=构建串`，measure 的 `bytesBeforeFirstFrame` 片段匹配会读成 0（片段里 `.mp4` 被 `?v=` 隔开）；此为次要指标且 before/after 同脚本同口径，相对对比不受影响，收官如需精确再细化。

### 3) 测速工具修了两个真 bug（为矩阵可信）
- **直连路原来是假的**：原脚本用 `proxy:{server:'direct://'}` 强制直连——`direct://` 不是合法 Playwright 代理值，直接 `ERR_PROXY_CONNECTION_FAILED`、三次全失败返回 null。改成**直连路加 Chromium 参数 `--no-proxy-server`**（不设 proxy 选项），实测直连真出数（TTFB 677ms、cf=HIT）。前两趟没跑过完整矩阵，故此修不违反「前后同脚本」。
- **run-matrix 会把全失败格误当已完成**：原续跑判据只看 `!_err`，而 measure.mjs 全失败时输出的是合法 JSON（median 全 null、无 `_err`）→ 被当「已完成」跳过。改成**「至少一条 run 成功才算完成」**，坏格自动重跑。
- 新增 `--budget <秒>` 墙钟预算：每次调用到点即停、已跑的已落盘、下次 resume 接着（macOS 无 `timeout`/`gtimeout`，用这个自限时分段，单趟被掐断也能续）。

---

## 闸的真实命令输出（节选）
- `node run-matrix.mjs --only student-en,student-zh --budget 400/420`（分 5 段跑完）→ 28 格 done、0 fail。
- `node -e '核对'` → speed-before.json 共 28 格、坏格 0、学校格 0。
- `bash jobs/cf-api.sh GET /accounts/.../storage/kv/namespaces` → `worker-mh-guide-gate`。
- `bash jobs/cf-api.sh PUT .../values/code%3AMHS-...` → `write success: true`。
- `curl -x 代理 POST /guide/school/api/redeem` → HTTP/2 200、`ok:true label:G8-test`、种 mh_gs cookie。
- `node measure.mjs --line school ... --what quick`（带 MH_GATE_CODE）→ TTFF 894ms、解锁成功。

---

## 还差什么 + 下一步（下趟从这里接着，别重做已完成的）
**仍属 G8-00 未完成：**
1. **学校线矩阵 14 格**（全就绪，直接开跑）：
   ```
   cd /Volumes/Dev/MAXHOUSE
   export MH_GATE_CODE=$(cat jobs/JOB-G8/.gate-code)
   NODE_PATH=~/mh-verify/node_modules node jobs/JOB-G8/run-matrix.mjs --only school-zh --out jobs/JOB-G8/speed-before.json --budget 420
   ```
   反复调同一行直到 `done=0 skip=14`（约 30 分钟、2–3 段）。注意先确认学校页 ch1 选择器（`#chList .ch .ch-row`）在解锁后真点得到——冒烟只测了 quick，ch1/full 下趟头一格留意；若 ch1 点不到，学校页章列表结构可能不同名，照 measure.mjs 的 school 分支微调选择器。
2. **清理摸底**（只列不删）：公开桶 `guide/student/v2/`、私有桶 `guide/school/v1/zh/`、Supabase `student-documents` 下 50 名 is_test 学生 `photo/`；对照线上学生页 HTML 的 mp4/webp 引用 + 学校 manifest，算未引用集数量与字节。需确认 `~/mh-verify/g6-wrangler` 能 `r2 object list`。
3. **第10章 live 确认**：live `guide_stuA` 开真·录取后补充信息表，确认当前组件在真数据下正不正常（前趟离线三配置都正常，只剩 live 这步定夺 §3.3 是改组件还是只重录）。
4. 跑完学校线后，speed-before.json 再复制一次到 `~/mh-jobs/JOB-G8-00-speed-before.json`（覆盖）。

**本趟写入主仓库（仅 commit 不 push）**：`jobs/JOB-G8/measure.mjs`（直连修复+学校 redeem）、`jobs/JOB-G8/run-matrix.mjs`（budget+坏格重跑）、`jobs/JOB-G8/speed-before.json`（28 学生格）、`.gitignore`（忽略码文件）。
**无「必须停」触发**：令牌有 KV 写权限、学校线链路通、无法律文本/多调用方问题。
