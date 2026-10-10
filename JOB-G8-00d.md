# JOB-G8-00d · 体检先红（只读）— 第 4 趟（跑完学校线矩阵 + 清理摸底三处）

日期 2026-10-10　机器 Mac mini　本趟代号 G8-00（第 4 趟续做，收尾）

## 一句话（大白话）
前三趟把学生线测速、媒体规格、三接口、CF 现状、脸、ch10 离线都做完了。本趟把 **G8-00 剩下的两大块做完**：①**学校线测速矩阵 14 格全跑完**（学校页 ch1 原来点不到——选择器用的是学生页的，已修，学校格首次产出不违反「前后同脚本」）；②**清理摸底三处全算完**（公开桶未引用 369 个/900.9MB、私有桶列不了 403、Supabase 测试生照片未引用 81 个/8.78MB）。**只剩一件**：第 10 章 live 确认（要连业主在跑的浏览器真登录态，unattended + 铁律11 下我不能自驱生产登录，留 G8-02 开头业主协助做，§0.6 第三条明说不算停）。G8-00 到此除这一件外全部做完。

---

## 本趟做完的（真数据）

### 1) 学校线测速矩阵 14 格全跑完 → `jobs/JOB-G8/speed-before.json`
**先修一个真 bug**：学校页章列表是 `#chapters .chap`、播放器是单个 `#vid`；measure.mjs 的 ch1 分支原来写死学生页的 `#chList .ch .ch-row` + `#c01 video`，在学校页点不到任何章 → TTFF 读成 null（冒烟发现）。改成**回退链**（学生选择器仍排第一、学生行为一字不变；学校页回退到 `.chap` / `#vid`）。学校格此前从没产出过，**此修不违反「前后同脚本」**（before/after 都用这份修后脚本、同一格同一口径）。

**speed-before.json 现在共 42 格**：学生 28（前趟）+ 学校 14（本趟），0 空、0 坏。已覆盖复制到 `~/mh-jobs/JOB-G8-00-speed-before.json`。

**学校线 zh 关键 TTFF（毫秒，3 次中位；测于 2026-10-10 约 11:48 当地）：**

| 场景 | 单章ch1 | 整片full | 速览quick | 判 |
|---|---|---|---|---|
| 直连·无限速 | 573 | 959 | 710 | 绿 |
| 代理·无限速 | 514 | 942 | 679 | 绿 |
| 代理·4G | 597 | **3435** | 912 | ch1/quick 绿、full 🟡 |
| 代理·3G | 1008 | **11593** | 2788 | ch1 绿、full 🔴、quick 🟡 |
| 代理·慢3G | **9571** | （矩阵不测full）| **17401** | 🔴🔴 ch1/quick 都爆 |

**60 秒真卡顿**（只有带 `--stall 60` 的单章 ch1 真观察 60 秒）：
- 直连/代理无限速、4G、3G 下 ch1 的「1–2 次」= 起播缓冲（stallMs≈TTFF），**播放中 0 次真卡顿**。
- **慢3G 的 ch1：7 次 / 累计 39.3 秒** → 这是真卡（学校 c01 是 40 秒章、文件比学生 c01 大，慢3G 扛不住）。

**学校线先红结论**：和学生线同一个病根——**弱网下大单文件（整片 full-g7 726s、速览 quick-g7 175s）出第一帧/播放都慢**；而且**学校 ch1 本身比学生 ch1 重**（慢3G ch1 9.6s vs 学生 3.8s）。→ G8-04 的 540p 流畅版（学校 960×540）+ 串播整片 + 弱网自动降档对两线都对症。

### 2) 清理摸底三处全算完（只列不删，§1.4 第 5 条 / §7）

**① 公开桶 `maxhouse-media` / `guide/student/v2/`**（可列，S3 令牌有权限）：
- 桶内 **539 个对象 / 1.24 GB**。
- 引用集 **170 条**（线上学生页 D 对象枚举：4 语 ×（13 章视频 + 海报 + 小图）+ full/quick + cover；脚本按页面真实命名函数 chFile/posFile/thumbFile/totFile 算，不手抄）。
- **断链 = 0**（引用集每一条桶里都在，线上不缺件，绿）。
- **未引用（可清理候选）= 369 个 / 900.9 MB**：全是旧版本成片——每语的 `c04..c13` 的 `无后缀/-g6/-g6b/-g7` 旧迭代、`full/full-g6/full-g6b/full-g7`、`quick/quick-g6/quick-g6b`、旧 `posters/`+`thumbs/`、写反层级的 `thumbs/<lang>/`、`og.png`、根 `manifest.json`。明细 → `jobs/JOB-G8/cleanup-unref-pub.txt`。
- ⚠ 注意 `c12-g7.mp4`（视频）未引用、但 `posters/c12-g7.webp`（海报）**在引用集**——脚本已正确区分，别误删海报。

**② 私有桶 `maxhouse-media-private`（学校媒体）**：**列不出来**。S3 令牌（`.env` 的 R2_ACCESS_KEY_ID）对私有桶的 HEAD/LIST 一律 **403**（实测 `maxhouse-media-private/*` 全 403；公开桶同令牌正常）→ **令牌作用域只含公开桶**。wrangler 3.x 又没有 `r2 object list`（只有 get/put/delete）、私有桶 put/get 走的是 Cloudflare API 令牌不是 S3。→ **私有桶孤儿清理这趟建不出桶清单**。按 §0.6「引用集/桶清单取不全 → 不删，回执写明；不算停」。**G8-06 真要清学校媒体孤儿，需业主给一个作用域含 `maxhouse-media-private` 的 R2 S3 令牌**（或业主自己在 Cloudflare 后台跑一次列举给我）。学校媒体引用集本身能建（线上 manifest.json 已下载，14 章 + full + quick + poster + thumb 的键都在里面）——只是缺「桶里实际有哪些」这一侧，故对不出孤儿。

**③ Supabase `student-documents` 桶 · 50 名 is_test 学生 `photo/`**（DB 查，只读 begin/rollback）：
- is_test 学生在该桶 photo/ 下共 **133 个对象 / 11 MB**。
- 其中**未被 `documents` 表 `file_path` 引用的 = 81 个 / 8.78 MB**（旧换脸残留 `g6b-face-*.jpg` 等）→ G8-06 可清理候选（真学生一个不碰，SQL 已 `s.is_test=true` 限定）。
- documents.file_path 存的就是 `<uuid>/photo/<文件>`，与 storage.objects.name 一字对得上，匹配可靠。

### 3) 第 10 章 live 确认 —— 这趟没做，原因与去向写清
- 要确认「真数据下补充信息表排版正不正常」，必须有 **guide_stuA 的生产登录态 + 一条真录取**才能打开那个表单。现成办法（`~/mh-verify/job10-login.mjs`）是 **CDP attach 到业主已在跑的 Chrome（127.0.0.1:9222）**——即业主在场、手工开好标签页那种；unattended 跑不起来。
- 自己新开浏览器去生产做真登录，会碰铁律11「自动走查绝不碰生产网址/连库、登录态/真解锁留用户验收」。→ **我不自驱生产登录态**。
- 00b 已出 ch10 **离线** before 图（独立 harness / 真 v411 未登录 / 真 v411 去 gate 三配置，均**横排、字段可见、组件正常**，唯一塌陷是未登录闸的 display:none 假象）。存 `~/mh-jobs/shots/G8/ch10-before-*.png`（6 张）。
- **去向**：ch10 live 确认挪到 **G8-02 §3.3 开头**做（00b/00c 已如此规划）：业主在场时用 guide_stuA 开真补充信息表，正常→§3.3 只重录 ch10、不改组件；不正常→按真 bug 在组件内修。**按 §0.6 第三条，此项不算停**。

---

## 本趟写的工具（都在 `jobs/JOB-G8/`，只读性质）
- `measure.mjs`（改：ch1 选择器加学校回退链）
- `r2-list-curl.sh` + `r2-head.sh`：curl `--aws-sigv4` 只读列举/探 R2（密钥由脚本从 .env 取、curl 不打印；因本机没装 @aws-sdk、wrangler 又无 list，改走 S3 兼容 API）
- `r2-list.mjs` + `r2-list.sh`：S3 SDK 版列举（本机无 aws-sdk，暂用不上，留档）
- `ref-diff.mjs`：按线上页真实命名函数建引用集、与桶列表对差
- `probe-photos*.sql`：Supabase photo 摸底
- 产物：`r2-pub-v2.txt`（539 对象）、`cleanup-unref-pub.txt`（369 未引用）、`live-student.html`（线上学生页快照）

## 闸的真实命令输出（节选）
- 学校 ch1 修后冒烟：`measure.mjs --line school ... --what ch1` → TTFF 690ms、真播 `c01.mp4`（修前 null）。
- `run-matrix.mjs --only school-zh`（3 段跑完）→ done=14 skip=0 fail=0；speed-before.json 共 42 格 0 空。
- `r2-list-curl.sh maxhouse-media guide/student/v2/` → count=539 bytes=1241472001。
- `r2-head.sh maxhouse-media-private v1/zh/c01.mp4` → **403**（私有桶令牌无权）；`maxhouse-media .../c01.mp4` → 404（学校媒体不在公开桶）。
- `ref-diff.mjs` → 引用集170、断链0、未引用369/900.9MB。
- `db-run.sh probe-photos3.sql` → is_test photo 133 个/11MB，未引用 81 个/8.78MB。

## 还差什么 + 下一步
**G8-00 只剩 1 件**：第 10 章 live 确认（G8-02 §3.3 开头、业主协助 guide_stuA 做；不算停）。其余 §1 全部完成。
**下一趟 = G8-01**（边缘与连接层，零成片改动）：按 §2 建 `guide-student-html-cache` 缓存规则、媒体缓存（G8-00 实测 2 次后已 HIT，可能不需新建、到时写明）、Zone 设置 http3/0rtt/early_hints/tiered_cache 该开的 PATCH（**注意 G8-00 实测令牌缺 `Zone.Zone Settings:Read/Edit`，很可能也缺 `Cache:Edit`——缺权限写出权限名继续不停**）、`_headers` 加 preconnect。G8-01 改动随 cycle=1（G8-02 末）一起推。

**本趟写入主仓库（仅 commit 不 push，JOB-G8-00d:）**：`jobs/JOB-G8/` 下 measure.mjs（改）、speed-before.json、r2-list-curl.sh、r2-head.sh、r2-list.mjs、r2-list.sh、ref-diff.mjs、probe-photos.sql、probe-photos2.sql、probe-photos3.sql、r2-pub-v2.txt、cleanup-unref-pub.txt、live-student.html、r2-priv-schoolzh.txt。
**无「必须停」触发**：矩阵全出数、清理摸底公开侧+Supabase 侧都算出、私有桶列不出按不算停处理、ch10 live 按 §0.6 第三条不算停。
**钥匙安全**：R2 密钥仅由脚本从 .env 取、curl 不打印；G8-test 码仍在 .gitignore（G8-05 验完删）；回执无任何密钥/密码/gmail 画面。
