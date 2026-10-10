# JOB-G8-04b —— 学生线「流畅版」全量转码收口（§5 包 G8-04 续，半成品可续）

日期 2026-10-10　机器 Mac mini　本趟代号 G8-04b。大白话。

## 一句话
把 G8-04-wip 只开了头的「流畅版转码」做到**学生线全收口**：四语（中/英/俄/法）每语 13 章 + 速览 + 片尾卡 = **15 个小文件，四语共 60 个，全部通过 §0.4 的五道闸**。
**没改任何产品网页、没传桶、没推送**——学校线、页面双档开关、传桶、第二次推送（cycle=2）全部留下趟，接续点写在第四节。

## 二、这趟实际做掉的（都可验、已 commit）
1. **非重录章的源直接从线上下载**（§0.4 要求源与线上高清对象字节一致）。新脚本 `jobs/JOB-G8/lite-fetch-src.sh`：
   把 c01~c06 / c08 / c09 / c11 / c13 十章四语的现役高清对象从 `media.maxhouses.net/guide/student/v2/<lang>/` 下到 `jobs/JOB-G8/lite-src/<lang>/`（40 个，字节数回执里都打了；下载实测 76 秒）。
   线上对象名用的是学生指南页里的 OVERRIDE 映射：c04-g7 / c05-g6b / c06-g6b / c08-g7 / c09-g6b / c11-g6b / c13-g6b；c01~c03 无 override 用原名。
2. **重录章 c07 / c10 / c12 + 速览 quick** 用本机重录重拼成片（`guide/dist/<lang>/`）转——这几章线上还是老脸，必须用本机重录件，不能下线上。
3. **片尾卡** `endcard-lite-g8.mp4` 每语一个：新脚本 `jobs/JOB-G8/lite-endcard.mjs`，从 `jobs/JOB-G1/overlays/<lang>/endcard.png`（1080×1920 静图）出 15 秒、540×960（和 full 片尾卡同款 15s/30fps）。
4. **转码脚本升级** `jobs/JOB-G8/lite-transcode.mjs`：①闸记录改成**按章名合并**写入（不再整文件覆盖，所以重录章和非重录章分两次跑也不会互相抹掉）；②每条记录多存了**源文件 md5 和目标字节数**（给下趟的 lite-manifest.json 用）。
5. **无头真放闸** `jobs/JOB-G8/lite-play-all.mjs`：本地**进程内 http 小服务 + 系统 Chrome**（Playwright 自带的开源 Chromium 没有 H.264 解码器，任何 mp4 都放不了，所以必须走系统 Chrome），每个文件真放 3 秒、监听 error 事件。**学生线 60/60 PLAY-OK**。
   —— 这一条把 §0.4 原本说「用 Playwright 无头 Chromium 真放」里的坑踩平了：坑=自带 Chromium 无 H.264；兜底=系统 Chrome，结论一致，已在脚本注释和此处写明。

## 三、五道闸的结果（四语每语 15 个文件，全过）
闸判据（§0.4）与结果：
- 分辨率精确 == 540×960　✅ 全过
- moov 在 mdat 前（+faststart，秒开关键）　✅ 全过
- 平均码率 ≤ 350 kbps　✅ 全过（实测多在 139~256k）
- 时长与高清差 ≤ 0.1s　✅ 全过（多为 0，速览 0.043s）
- 无头真放 3s 无 error　✅ 60/60 PLAY-OK
- 体积 ≤ 高清 60%（超了不算红）　实测 36.5%~59.3%，全部 ≤60%
闸原始记录：`jobs/JOB-G8/lite-gate-student-{en,zh,ru,fr}.json`（每个 15 条，字段含 src/srcMd5/dstBytes/res/kbps/durDelta/moovBeforeMdat/pass/playOk）。

## 四、还差什么 + 下一步（G8-04 续，下趟从这接着，不重做）
**学生线 lite 已全好，下趟不用再碰学生线转码。** 剩下按 §5 顺序：

1. **学校线 lite（zh 一种语言）**——14 章 + 速览 + 开场卡 intro-lite-g8 + 片尾卡 endcard-lite-g8，**横版 960×540**。
   - 本机源在 `guide/dist/school/zh/`（已有 c01~c14 各版本、c00-intro、c99-ending、full-g7 等）。
   - ⚠ 关键差异：学校视频在**私有桶**，不能像学生线那样直接 curl 公开 URL；要么(a)核对本机 `guide/dist/school/zh/<对象>.mp4` 的 md5 与线上私有对象一致后直接转，要么(b)走 GS-5 鉴权地址 / 自造 `G8-test` 码（max_devices=5、2 天过期）下载。**先读 `guide/school/index.html` 的 var D 取当前 OVERRIDE 真实对象名**（本趟没展开读）。
   - 哪些学校章是本轮重录的：见 `jobs/JOB-G8/g8-03-rerecord-plan.txt` 与 JOB-G8-03* 回执；重录章用本机重录件，非重录章对齐线上。
   - 开场卡 intro：学校线 assemble 脚本 `jobs/JOB-GS3/rec/assemble-sch.mjs` 里有 intro/endcard 构建逻辑（横版），仿 `lite-endcard.mjs` 加一个 `lite-endcard.mjs --line school` 或新写 intro 生成。
   - 跑法：`node jobs/JOB-G8/lite-transcode.mjs --line school --lang zh --srcdir <源目录> --names c01,...,c14,quick`（脚本已支持 `--line school` → 960:540）。再跑 `lite-play-all.mjs --line school --langs zh`。
2. **lite-manifest.json**（§5.1）：源 md5 / 目标字节 / 时长 / 码率——gate json 里字段已齐，汇总成一个 `jobs/JOB-G8/lite-manifest.json` 即可。
3. **页面双档**（`guide/student/index.html` + `guide/school/index.html`，≤60KB、零外部脚本）：画质 auto/hd/lite 开关、navigator.connection 自动判、首个 playing 后 30s 内 waiting≥2 自动降档续播+2s 提示、流畅模式整片=逐章串播（学生 c01…c13+endcard-lite；学校 intro-lite+c01…c14+endcard-lite）、高清↔流畅按累计章时长换算位置互切、学校端全屏保持、流畅文件 preload=none 选中才设 src、学校 manifest 加 lite/intro/endcard 条目、媒体函数路径白名单放行 `*-lite-g8.mp4`/`intro-lite-g8.mp4`/`endcard-lite-g8.mp4`（鉴权一字不改）、构建串 §0.2、ch10 四语章名已在 v413、OVERRIDE c07→c07-g8/c10→c10-g8/c12→c12-g8 且 dur 更新——**与传桶原子落地**。
4. **传桶**：学生公开桶 `-g8`（重录章 c07/c10/c12 + full + quick + 海报/小图）与 `-lite-g8`（全部 15×4）；学校私有桶同理；逐个 HEAD 核字节；make-manifest。走 `jobs/r2-put.sh` / `jobs/r2-private-put.sh`。
5. **整包本地无头走查**（§5.4）：四语切换、开关、自动判（CDP 模拟 connection 不行就 `?q=lite` 兜底并写明）、串播跨章、互切换算、学校全屏、页面体积、零外部脚本。
6. commit `JOB-G8-04:` → 写 `jobs/JOB-G8/NEED_PUSH.txt` 首行 `cycle=2` → 推回执 → **立刻结束本趟**（这才是 G8-04 收口 + 第二次推送点）。

## 五、本趟写入 / 推送
- 主仓库（**仅 commit 未推**，G8-04 未收口、非推送点）：
  `1284468 JOB-G8-04(wip):` —— lite-transcode.mjs(改) + lite-endcard.mjs + lite-fetch-src.sh + lite-play-all.mjs + lite-play-check.mjs + 四语 gate json。
  目前待推 3 笔（全部 JOB-G8 开头）：1284468(本趟) / 07e791a(G8-04 wip 起步) / 1e2d674(G8-03e §4 收口)。等 G8-04 收口随 cycle=2 一起推。
- 成片（`guide/dist/<lang>/*-lite-g8.mp4`）与下载源（`jobs/JOB-G8/lite-src/`）均 .gitignore，不入库，传桶在 §5.3。
- ~/mh-jobs：本回执，push。
- 无「必须停」触发；§5 全可自动推进，只是量大分趟。

## 六、安全
- 转码/真放纯本机，无账号、无 PII、无钥匙；下载只读公开学生媒体对象。
- 产品 HTML 一行未改；画面无邮箱、无测试名单外真学生。
