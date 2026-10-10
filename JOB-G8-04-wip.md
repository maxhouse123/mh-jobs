# JOB-G8-04-wip —— 流畅版转码起步（§5 包 G8-04，半成品可续）

日期 2026-10-10　机器 Mac mini　本趟代号 G8-04(wip)。大白话。

## 一句话
§4（第 10 章修好后重录重拼）这趟已全部收口（见 JOB-G8-03e.md）。接着开了 G8-04「流畅版 + 页面双档 + 传桶」这个大包，
先把最没争议的一块做了：**本轮重录的三章（c07/c10/c12）+ 速览的「流畅版」四种语言全转码好、自检闸全过**。
G8-04 是个跨好几趟的大活（还要转非重录章、整条学校线、改两个指南网页、传云桶、第二次推送），这趟只开了头，
**没改任何产品网页、没传桶、没推送**，留了清楚的接续点。

## 一、G8-04 是什么（任务书 §5）
两件事：①每个视频除现在的「高清」外再出一个「流畅」小文件（手机竖 540×960、码率压到 300k 上下、体积约一半），
弱网自动用流畅、还能手动切；②两个指南网页加「高清/流畅」开关 + 弱网自动降档 + 流畅模式整片改成逐章串播；③新文件传云桶。
做完是第二次推送点（cycle=2）。

## 二、这趟做掉的（确定性、可验、已 commit）
- 新脚本 `jobs/JOB-G8/lite-transcode.mjs`，严格按任务书 §0.4 规格转码（学生竖 540:960；crf30 / maxrate300k / bufsize600k；关键帧 g=2×帧率、keyint=帧率（30fps→60/30）；音频 aac 64k 单声道 44100；moov 提到文件头 +faststart）。
- 源用本机重录成片（guide/dist/<lang>/，md5 自洽；本轮重录章就该用重录件）。
- **四语各转 c07 / c10 / c12 / quick 共 16 个 lite 文件，闸全过**（闸记录 `jobs/JOB-G8/lite-gate-student-{en,zh,ru,fr}.json`）：

| 文件 | 分辨率 | 时长差 | 码率 | 体积(占高清) | moov在前 |
|---|---|---|---|---|---|
| en c07/c10/c12/quick | 540x960 | ≤0.043s | 203~224k | 44~52% | ✓ |
| zh 同四件 | 540x960 | ≤0.043s | 172~210k | 47~57% | ✓ |
| ru 同四件 | 540x960 | ≤0.043s | 188~236k | 50~54% | ✓ |
| fr 同四件 | 540x960 | ≤0.043s | 188~232k | 50~58% | ✓ |

  闸判据（§0.4）：时长差≤0.1s ✓、moov 在 mdat 前 ✓、平均码率≤350k ✓、分辨率精确==540x960 ✓、体积≤高清60% ✓。
  （「无头真放3s无 error」这条留到 G8-04 的整包本地无头走查 §5.4 一起做；ffprobe 已证文件结构合法、moov 在头。）
- 成片 `*-lite-g8.mp4` 在 `guide/dist/<lang>/`（.gitignore，不入库，传桶留 §5.3）。

## 三、为下趟探好的路（de-risk，已实测）
- 非重录章的 lite 源按 §0.4 要「与线上高清对象字节一致」→ 下趟直接从线上下载现役高清对象再转码。
  实测线上可达（HTTP 200、cf-cache HIT、content-length 已读）：如 `media.maxhouses.net/guide/student/v2/en/c04-g7.mp4`(4197453B)、`c05-g6b.mp4`、`c13-g6b.mp4`、`zh/c10-g7.mp4` 等。
- 现役对象名（guide/student/index.html 的 OVERRIDE 映射，下趟按此下载非重录章）：
  c04-g7 / c05-g6b / c06-g6b / c07-g7 / c08-g7 / c09-g6b / c10-g7 / c11-g6b / c12-g7b / c13-g6b；c01~c03 用模式名（无 override）；full-g7b / quick-g7。
- 本轮重录章传桶新名应为 **c07-g8 / c10-g8 / c12-g8 + full-g8 + quick-g8**（+海报/小图），lite 为 `*-lite-g8`。

## 四、还差什么 + 下一步（G8-04 续，下趟从这接着，不重做）
1. 非重录章 lite：下载现役高清对象（上面列表）→ `lite-transcode.mjs --srcdir <下载目录>` 转 c01~c06/c08/c09/c11/c13 四语 + endcard-lite（每语一个，从 overlays/<lang>/endcard.png 出 540×960 短卡）。
2. 学校线全量：14 章 + quick + intro-lite + endcard-lite（横 960:540），源同理（学校私有桶对象，走 GS-5 地址）；跑 `--line school`。
3. `jobs/JOB-G8/lite-manifest.json`（源 md5 / 目标字节 / 时长 / 码率）。
4. 页面双档（guide/student + guide/school index，≤60KB、零外部脚本）：画质 auto/hd/lite 开关、navigator.connection 自动判、30秒内 waiting≥2 自动降档续播、流畅模式整片=逐章串播、互切位置换算、学校端全屏保持；构建串 §0.2；ch10 四语章名同步、OVERRIDE c10→c10-g8（c07→c07-g8、c12→c12-g8）、dur 更新 —— 与传桶**原子落地**。
5. 传桶（学生公开桶 -g8/-lite-g8；学校私有桶同理）→ 逐个 HEAD 核字节 → make-manifest。
6. 整包本地无头走查（§5.4）：四语切换、开关、自动判（CDP 模拟 connection 不行就 `?q=lite` 兜底）、串播跨章、互切换算、学校全屏、页面体积、零外部脚本、lite 真放无 error。
7. commit `JOB-G8-04:` → 写 `jobs/JOB-G8/NEED_PUSH.txt` 首行 `cycle=2` → 推回执 → **立刻结束本趟**（这才是 G8-04 收口 + 第二次推送点）。

## 五、本趟写入 / 推送
- 主仓库（**仅 commit 未推**，G8-04 未收口、非推送点）：
  `07e791a JOB-G8-04(wip):` —— lite-transcode.mjs + 四语闸记录 json。此前 `1e2d674 JOB-G8-03e:`（§4 收口）。两笔都 JOB-G8 开头，等 G8-04 收口随 cycle=2 一起推。
- ~/mh-jobs：本回执，push。
- 无「必须停」触发；§5 全可自动推进，只是量大分趟。

## 六、安全
- lite 转码纯本机 ffmpeg，无网无库无钥匙；成片不入库；产品 HTML 一行未改。
- 线上 HEAD 探测只读公开媒体对象，无账号无 PII。
