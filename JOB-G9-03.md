# JOB-G9-03 · 页面改分段串播 + 新对象传桶 + 待推送

日期 2026-10-10。把两条线的 guide 页面「流畅模式的速览」从一整条改成分段串播（复用 G-8 的串播播放器），并把学生端第 10 章指向新的长名对象（c10-g9 / full-g9 / quick-g9 / c10-lite-g9 + 新海报），学校 manifest 加分段清单。新对象已逐个传桶核字节。页面已 commit（未推），等循环推送。

## 一、页面改了什么（两页都仍 ≤60KB、零外部脚本）
### 学生页 guide/student/index.html（构建串 g8→**g9-2026-10-10**）
- 数据：第10章 `c10-g8→c10-g9`、海报 `posters/c10-g8→posters/c10-g9`、整片 `full-g8→full-g9`、速览 `quick-g8→quick-g9`（四语同改）；总时长 full 更新（zh 737→738、fr 678→679，en/ru 不变）。
- 新增流畅章例外表 `LITE:{c10:c10-lite-g9}`（只有第10章的流畅文件换了 -g9，其余 12 章 + 片尾仍 -lite-g8 不动）。
- 新增速览分段元数据 `QSEG`(段数 en7/zh7/ru8/fr7) + `QSEGDUR`(各段时长，供高清↔分段互切按累计段时长换算位置)。
- 播放器：流畅模式点「速览」= 分段串播（`quick-lite-g9-01…NN.mp4`），顶部导航显示「速览 第 i / N 段」(四语词条 segOfN)，可上一段/下一段、段内可拖；播完一段自动下一段；高清速览与分段流畅之间按累计段时长互切；弱网自动降档在速览里同样生效（高清速览卡2次→切分段流畅、位置续播）。整片逐章串播与第10章流畅取数照旧（第10章取 c10-lite-g9）。

### 学校页 guide/school/index.html（构建串 gs8→**gs9-20261010**）
- 复用已有的 full 流畅串播机制，给「速览」加了平行的一套：新增 `quickSeq()/playSeg(kind,…)/seqKind`，把原来只认整片的 `seqIdx` 串播推广到 full/quick 两种。
- 流畅模式点「速览」= 分段串播（manifest 的 `lite.quickSegs`，6 段），正在播显示「速览 第 i / N 段」；播完自动下一段、末段退出；高清速览(quick-g7，不动)与分段流畅互切按累计段时长换算；整片流畅串播(intro+14章+片尾)回归不破。
- manifest（`jobs/JOB-G9/manifest-g9.json`）：build→gs9，`lite.quickSegs` 加 6 段(file/seconds/v=md5前8位)；full/quick/章/intro/片尾全不动（学校线本轮只动速览）。

## 二、第 10 章海报/小图随新顶栏重出
- 查实：线上 c10 视频 23:08 已是 G9-01 新长名重拼，但海报(posters/c10.webp)还是旧帧(17:34 旧短名)。海报本身就是章名卡（1080×1920，经比对旧线上海报=旧短名章名卡）。
- 从 G9-01 重渲的新章名卡 PNG 出 `posters/c10-g9.webp`(1080×1920)+`thumbs/c10-g9.webp`(216×384) 四语，都是长名（脚本 g9-03-c10-poster.mjs）。
- 另转码 `c10-lite-g9.mp4` 四语（新 c10 的流畅版，540×960、217~240kbps、Δdur=0、moov在头）。

## 三、本地无头走查（铁律11②，只本地不碰生产/库）—— **26 项全过 0 失败**
脚本 `jobs/JOB-G9/g9-03-walk.mjs`：
- 学生逻辑走查（媒体 abort）：BUILD=g9；第10章页面章名=长名；高清第10章=c10-g9.mp4、海报=posters/c10-g9.webp；流畅第10章=c10-lite-g9.mp4、第1章仍 c01-lite-g8（别处没误改）；流畅速览起=quick-lite-g9-01、导航「速览 第 1/7 段」；ended→seg02、Next 到末段 07 且禁用；高清速览=quick-g9 单文件、导航隐藏；速览自动降档→分段流畅；四语 ru 速览 8 段。
- 学校逻辑走查（route 桩）：build=gs9；流畅速览起=quick-lite-g9-01、「速览 第 1/6 段」；ended→seg02「第 2/6 段」；切高清速览=quick-g7(不动)；流畅整片仍=intro-lite-g8(回归不破)。
- **真跨段间隔**（服本地 dist 文件、seek 到段尾触发 ended 测到下一段 playing）：学生 zh 速览 3 次跨段 = **38.8 / 38.5 / 41.3 ms**，最大 41.3ms ≪ 600ms 阈值 → 跨段无缝。

## 四、传桶（逐个核字节）
脚本 `jobs/JOB-G9/g9-03-upload.sh`（只传本轮新对象、不镜像整树；公桶 r2-put 自验、私桶回读核字节）—— **共 60 个对象，全 OK、0 失败**：
- **学生公桶 guide/student/v2/<lang>/（53 个）**：四语各 = c10-g9.mp4 + full-g9.mp4 + quick-g9.mp4 + c10-lite-g9.mp4 + posters/c10-g9.webp + thumbs/c10-g9.webp + 速览分段(zh7/en7/fr7/ru8)。
- **学校私桶 guide/school/v1/（7 个）**：zh/quick-lite-g9-01…06.mp4（6 段）+ manifest.json（新 build gs9 + quickSegs）。
- 另抽查 4 个公桶对象线上 HEAD：`zh/full-g9.mp4`(32940248)、`fr/quick-lite-g9-07.mp4`(683845)、`ru/posters/c10-g9.webp`(31292)、`en/c10-lite-g9.mp4`(957020) 均 **HTTP 200 且线上字节==本机**。
- 说明：新对象传上去但线上旧页面还没换（页面要等 push+部署），旧页面不引用新对象、也不受新 manifest 影响（旧页 JS 不认 quickSegs，忽略之）——不破线上。

## 五、还差什么 / 下一步
- 本包已 commit（`JOB-G9-03:`，**未推**），写了 `jobs/JOB-G9/NEED_PUSH.txt`(cycle=1)。回执已推 ~/mh-jobs。
- 下一步 **G9-04**（下一趟）：见 `PUSHED-*.txt` → 轮询构建串 g9-2026-10-10 / gs9-20261010 → 线上真验（新对象全 206/字节==本机、分段串播跨段≤0.6s、第10章线上抽帧顶栏==页面章名四语、片尾解码、无 gmail）→ 复测 4 格 after（流畅速览 3G TTFF≤2.5s、慢3G≤4s）→ 清理被顶替旧对象(c10-g8/full-g8/quick-g8/c10-lite-g8/quick-lite-g8 四语 + 学校 quick-lite-g8)。
