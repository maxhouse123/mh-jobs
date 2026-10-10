# JOB-G8-06 —— 清理旧对象（§7）· 第一段：R2 两桶（计划 + 执行）

日期 2026-10-10 晚（北京）　机器 Mac mini　大白话。这是 G8 收官前的清理包。
**本段只清 R2 两个视频桶的旧版文件**；Supabase 学生照片那一小块（见文末）留第二段 G8-06b 单独做。

## 一句话
线上学生页 + 学校 manifest 现在真正引用的文件我一个一个列了出来（学生公开桶 230 个、学校私有桶 49 个），
拿它跟桶里实际存着的文件对账：**凡是页面/manifest 已经不引用、且不是最近 24 小时上传的旧版本**，
一共 **460 个、约 1295 MB**，就是要删的。对账**零断链**（页面引用的每个文件桶里都真实存在），
删除清单里**没有一个带 -g8 / -lite-g8 的现役文件**，当前四语所有在播的章/整片/速览/海报/缩略图都安然不动。

## 零、开工先摸清两件「变了的事」（重要，影响后面所有步骤）
1. **公开桶真名是 `maxhouse-media`，不是之前几趟脚本里写的 `maxhouse-media-public`。** 之前的清理摸底
   （G8-00 的 r2-pub-v2.txt 等）桶名用错，数字不可靠，本趟**全部重新对账**，不沿用旧摸底。
2. **`.env` 里那把 R2 的 S3 钥匙已经失效**（现在 HEAD/LIST 一律回 403；G8-00/G8-05b 时还能用）。
   我没读 `.env`（规矩），是用脚本探出来的。所以列桶、删文件都**改走别的通道**：
   - 列桶：走 Cloudflare REST API（`cf-api.sh` 的 `CLOUDFLARE_API_TOKEN`，分页取全）——新写 `jobs/JOB-G8/r2-list-cfapi.sh`。
   - 删文件：走 `wrangler r2 object delete`（wrangler 用它自己的 CF 登录令牌，和那把失效 S3 钥匙无关）。
   - 核验：公开桶用浏览器 UA curl 打 `media.maxhouses.net`（公网域名，不需 S3 钥匙）；私有桶用 `wrangler r2 object get`。
   以上通道**都已实测可用**（见下）。

## 一、引用集怎么建的（照线上页面/ manifest 的真实取数逻辑，不是猜）
- **学生公开桶**（`guide/student/v2/`）：抓线上 `www.maxhouses.net/guide/student/`（构建串 `g8-2026-10-10`，已是 G8 新版），
  解析页面里的 `D` 对象，**逐语(en/zh/ru/fr)逐章**照页面函数 `chFile/posFile/thumbFile/liteUrl/totFile` 算出每个 URL：
  13 章的高清 mp4 + 流畅 `cNN-lite-g8.mp4` + 海报 webp + 缩略图 webp，加 `full-g8` / `quick-g8` / `quick-lite-g8` /
  `endcard-lite-g8` / `cover.webp`，再加页面里写死的 `v2/brand-300.png`、`v2/og.png`。共 **230 个键**。
- **学校私有桶**（`guide/school/v1/zh/`）：用 wrangler 取线上私有 `guide/school/v1/manifest.json`，
  把里面出现的每一个 `zh/….(mp4|jpg|…)` 路径都算成键（高清 14 章 + full-g7 + quick-g7 + 各章缩略图/海报 +
  流畅 `cNN-lite-g8` + `intro-lite-g8` + `endcard-lite-g8` + `quick-lite-g8`）+ manifest 自身。共 **49 个键**。
- **再叠两重保护**：① 上传时间在 24 小时内的对象一律不删；② 删除脚本在真删前**重新建一次引用集对账**，
  任一待删键命中引用集或断链不为 0 → 整单中止。

## 二、对账结果（dry-run，未删任何东西）
| 项 | 数 |
|---|---|
| 引用集（学生公开 / 学校私有） | 230 / 49 键 |
| **断链（页面引用了但桶里没有）** | **public 0 / private 0** ← 关键：引用集与桶完全对得上，无取不全 |
| 24h 内上传的保护项 | public 0 / private 0（本轮 g8/lite 新对象都在引用集里，天然已保护） |
| 桶内实际对象（公开 v2/ 全量 / 私有 v1/全量） | 643 / 96 个 |
| **删除合计** | **460 个，约 1295.5 MB（1,358,477,685 字节）** |
| ├ 公开桶 maxhouse-media | 413 个，1089.5 MB |
| └ 私有桶 maxhouse-media-private（仅 zh/ 下） | 47 个，206.1 MB |

**删除清单按版本族归类**（都是被新版顶替的旧片）：
- 无后缀最初版 211 个、g6 旧版 131、g6b 旧版 64、g7 旧版 44、g7b 旧版 8、`_prev-20261008` 备份目录 2。

**安全自检（都过）**：
- 删除集里含 `-g8`/`-lite-g8`（现役）的 = **0**。
- 抽样 22 个现役关键键（含四语 c01、c07-g8、c10-g8、c12-g8、full-g8、quick-g8、quick-lite、endcard-lite、c01-lite、cover、顶层 og.png / brand-300.png、学校 c01/full-g7/quick-g7/c14-g7/c01-lite/intro-lite/endcard-lite/manifest.json）误入删除集的 = **0**。
- 当前海报/缩略图（posters/c01、posters/c04-g7、thumbs/c07-g8…）误入删除集的 = **0**；删的全是旧版海报/缩略图。
- `v2/zh/og.png`（各语旧 og）在删除集——对的：页面 og 用的是顶层 `v2/og.png`，各语 og 是没人用的旧物。
- 核验通道实测：现役 `en/c01.mp4`/`c07-g8`/`full-g8`/`c01-lite-g8` 公网 HEAD 全 200；待删 `en/c04.mp4`/`full-g7b.mp4` 现在 200（删后应 404）；私有 `zh/c01.mp4` wrangler get 回 1,560,676 字节 OK。

## 三、怎么删（本段执行）
`bash jobs/JOB-G8/cleanup.sh --apply`：删前**重新**抓页面/manifest + 列桶 + 建引用集对账（守卫：断链≠0 或前缀非法即中止），
再按 `cleanup-plan.json` 逐键 `wrangler r2 object delete`。删完抽验：现役键仍 200 / 待删键变 404。
**执行结果见本文件「五、执行回填」。**

## 四、§0.6「必须停」检查 —— 不触发
- 引用集**建得出且零断链**（不是取不全）→ 可以删。
- 删除通道（wrangler delete + CF API list）**实测可用** → 不卡。
- S3 钥匙失效属工具层问题、已绕开，不影响清理正确性 → 不停工，记录在案（建议业主有空在 Cloudflare 重发一把 R2 S3 token 以便日后 S3 直连；非阻塞）。

## 文末 · 第二段 G8-06b 待办（Supabase 学生照片，本趟未做，原因写明）
§7.2 第三条：`student-documents` 桶里 **50 名 is_test 学生** `photo/` 下、未被 `documents` 行引用的对象。
- **已摸清数（db-run 只读 begin/rollback 查 storage.objects ⋈ students.is_test ⋈ documents）**：
  is_test 学生 photo 对象 **133 个 / 11 MB**，其中**未被 documents 引用 = 81 个 / 8.8 MB** = 待删。真学生照片一个不碰。
- **为什么这段留到 G8-06b 单独做**：删 Supabase 存储对象要走 Storage API（service-role 钥匙），
  现有工具箱里没有这把「存储删除」刀——得新写一把**只认 `<is_test-uuid>/photo/` 前缀、删前校验 uuid 属 is_test** 的带守卫脚本；
  且这是**真学生资料桶**旁边的操作，风险最高的一小块（虽只 8.8 MB）。按铁律「一步一动 + 单趟收尾可续」，
  不把它和 460 个 R2 删除挤在同一趟、同一时间压力下做，降误删风险。**这不是 §0.6 的停**（集合建得出、数清楚了），
  是刻意分步。G8-06b 做法：新写 `jobs/JOB-G8/cleanup-photos.sh`（dry-run 出 81 键清单 → 回执 → apply 走 Storage API DELETE → 复验 documents 引用的照片仍在、81 个已 404）。
- **因此 G8（§8 收官 G8-07）还不能收**：须等 G8-06b 做完。

## 下一步（本趟接着做）
1. 推本回执到 ~/mh-jobs（记录计划）。
2. `cleanup.sh --apply` 删 460 个 R2 旧对象 → 抽验 → 回填本文件「五、执行回填」→ 再推。
3. 主仓库只 commit 新脚本（r2-list-cfapi.sh / build-refset.mjs / cleanup.sh / cleanup-plan.json），不 push。

## 五、执行回填
（apply 后填：删了几个、释放多少字节、复验几条。）
