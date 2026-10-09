# JOB-G6b-04 回执（第一趟）· 学生端：四语有头像章（c05–c13）全部重录完毕，等下一趟拼片+传桶+改页面

日期 2026-10-09 ｜ 无人值守 ｜ 本机 Mac mini（真卷 /Volumes/Dev/MAXHOUSE）

## 一句话
学生端操作视频里**有头像的 9 章（c05～c13）× 四种语言（英/中/俄/法）= 36 个章节这趟全部重录了一遍**，录出来的新片子里学生头像**全是 G6b 重新配对后的 AI 人脸**（主角 Lina = 新换的「非洲裔年轻不戴眼镜」女性脸）。**36 个录制每一镜的画面断言都过了**。**还没做的**：把录好的帧拼成成片（叠字幕/片尾卡→合成章→整片/速览/海报/小图）、按 `-g6b` 新名传公开桶、改视频页构建串 `g6b-2026-10-09`——这是 G6b-04 后半段，下一趟接着做。录制帧都在本机（`jobs/JOB-G1/rec/<语言>/`，git 忽略、持久留盘）。

## 这趟具体做了什么（大白话）

### 一、先确认录制地基对（只读/幂等核验）
1. **脸全装好**：跑 `assign-faces-g6b.sh`（幂等、按邮箱别名认当前身份号）→ `resolved 50/50`、`uploaded=0 skipped(exists)=50`、库里 **`pointing_g6b=50 / cast_total=50`**（50 名演示/测试生个个指向 G6b 新脸）。
2. **Lina 顶栏是真脸**：闸 H 学生端（真登 guide_stuA）→ `hasImg:true / hasSvgFallback:false` → `GATE_H_STUDENT: has-image`（不是首字母回落，是 AI 人脸图）。
3. **第 5 章换脸素材已是新脸**：c05 的「新生 Lina」头像来自录制生 guide-rec-* 自上传的素材 `jobs/JOB-G0/assets/lina/photo.jpg`——这张在 **G6b-02（commit 18a752d）已换成 Lina 的 G6b 新脸**（md5 `ecf75758`，512²），原 G6 脸留底 `jobs/JOB-G6b/photo-asset-before-g6b.jpg`。本趟无需再换。

### 二、四语 c05–c13 逐章重录（复用配音，只换画面）
用正规驱动 `bash jobs/JOB-G1b/rec-chapters.sh <语言> 5 13`（每章录前自动跑该章前置 SQL，把演示数据摆到该章需要的状态）。配音全复用、字幕/高亮/画面断言逐镜校验。结果：

| 语言 | c05 | c06 | c07 | c08 | c09 | c10 | c11 | c12 | c13 | 结论 |
|---|---|---|---|---|---|---|---|---|---|---|
| en | 8/8 | 7/7 | 6/6 | 6/6 | 5/5 | 6/6 | 5/5 | 11/11 | 3/3 | 全过 |
| zh | 8/8 | 6/6 | 6/6 | 6/6 | 5/5 | 6/6 | 5/5 | 11/11 | 3/3 | 全过 |
| ru | 8/8 | 7/7 | 6/6 | 6/6 | 5/5 | 6/6 | 5/5 | 11/11 | 3/3 | 全过 |
| fr | 8/8 | 7/7 | 6/6 | 6/6 | 5/5 | 6/6 | 5/5 | 11/11 | 3/3 | 全过 |

- 一共 **9 章 × 4 语 = 36 个录制，每一镜画面断言都过**（`ok=` 等于 `shots=`，无 `XX`/重试失败）。
- 帧与时间线落在 `jobs/JOB-G1/rec/<语言>/cNN/{frames,timeline.json,framestamps.json}`（timeline.json mtime 实测 en 21:13 / zh 21:24 / ru 21:36 / fr 21:47，全是本趟新录）。

## 闸 / 命令的真实输出
- `assign-faces-g6b.sh`：`resolved 50/50`、`skipped(exists)=50 failed=0`、`pointing_g6b=50 / cast_total=50`。
- 闸 H 学生端：`login ok=true`、`{"found":true,"hasImg":true,"hasSvgFallback":false}` → `GATE_H_STUDENT: has-image`。
- 录制：四语 c05–c13 全部 `ok == shots`（见上表），无一镜失败、无章级重试失败。

## 还没做的 / 下一趟从哪接（G6b-04 后半段）
> 录制帧已全部在本机（git 忽略、持久）。下一趟是「拼片 + 传桶 + 改页面」，照 G6-05 第三趟整段做，只把 `-g6` 换成 `-g6b`、构建串换 `g6b-2026-10-09`。

1. **重渲叠层（含片尾卡二维码）**：`cd jobs/JOB-G1 && node overlays.mjs`（二维码源头 `CONTACT.guideUrl='https://www.maxhouses.net/'` 已对，重渲即带新码）。
2. **四语合成**：对 en/zh/ru/fr 各跑 `node jobs/JOB-G1/rec/assemble.mjs --lang <l> --all`（出 `guide/dist/<l>/cNN.mp4` + full + quick + posters）。小图：`node jobs/JOB-G1/g5-make-thumbs.mjs`（或 G6-05 同款）。
3. **片尾二维码闸**：四语片尾卡 PNG + 四语整片末帧解码，必须都 == `https://www.maxhouses.net/`（解码器 `jobs/JOB-G6/gates/_decode-png.mjs`）。
4. **起 `-g6b` 名 + 传公开桶**：改了的 9 章视频 `cNN-g6b.mp4` + `full-g6b.mp4` + `quick-g6b.mp4` + 海报 `posters/cNN-g6b.webp` + 小图 `thumbs/cNN-g6b.webp`，每语 29 个 × 4 语 = **116 个对象**，用 `bash jobs/r2-put.sh <本地> guide/student/v2/<l>/...` 只新增传（逐个 HEAD 核字节、不覆盖不删旧 `-g6`/沿用章 c01-04）。
5. **改视频页 `guide/student/index.html`**：OVERRIDE 四语 c05–c13 由 `-g6` → **`-g6b`**（视频/海报/小图/full/quick 都切）、改了的章时长按新片、四语总时长更新；构建串 `g6-2026-10-09` → **`g6b-2026-10-09`**；仍 ≤60 KB、零外部脚本；沿用章 c01–c04 地址/版本一字不动。
6. **commit `JOB-G6b-04:`（不推）**；之后进 **G6b-05**（两线一起上线、线上真验、收官）。

## 这趟改了哪些文件
- 主仓库：**本趟 0 改动、0 commit**（录制帧/成片都在 git 忽略目录；G6b-04 对主仓库的改动只在上面第 5 步「改页面」那一笔，是下一趟的活）。
- `jobs/JOB-G6b/avatars-before-g6b.json` 是 `assign-faces-g6b.sh` 每次跑都会重写的备份文件（开工前已是 M、非本趟逻辑改动），**未 stage、未提交**。
- 本机不入 git：`jobs/JOB-G1/rec/<en|zh|ru|fr>/cNN/` 的四语录制帧与 timeline（下一趟拼片用）。
- 回执仓库 `~/mh-jobs`：本回执。
- 钥匙/令牌/业主码/演示密码：一律没进回执、没进仓库；DB/装脸/闸都是脚本自读 .env，CC 没读 .env、没打印。

## 现状提醒（给下一趟/主审）
- **学校线 G6b-03 已全做完**（commit `0704001`：16 个 `-g6b` 对象进私有桶 + 目录重出 + 构建串 `gs6b-20261009`）。
- **学生线 G6b-04 这趟录完四语帧**，**尚未拼片/传桶/改页面**，**尚未到上线步、未写 `NEED_PUSH.txt`**。
- 主仓库 `git log origin/main..HEAD` 现有若干 `JOB-G6b-*` 提交全压本机未推，等 G6b-05 开头按 §0.6 走推送。


---

# JOB-G6b-04 回执（第二趟 · 后半段）· 学生端：四语拼片 + 片尾二维码真解码 + 116 个 -g6b 对象传公开桶 + 改视频页（学生线收工，等 G6b-05 上线）

日期 2026-10-09 ｜ 无人值守 ｜ 本机 Mac mini（真卷 /Volumes/Dev/MAXHOUSE）

## 一句话
上一趟把四语有头像的 9 章（c05–c13）录完帧。这趟把它们**拼成成片、重渲片尾卡（二维码指官网首页）、四语片尾真解码过、把 116 个带 `-g6b` 新名的文件传上公开桶并逐个回读核字节、最后把视频页改好（构建串升 `g6b-2026-10-09`、改了的章全指 `-g6b`、时长按新片）**。学生线到此全部做完，和早先做完的学校线（G6b-03）一起，**就差推送上线**——但按规矩推送是 G6b-05 的活，这趟只到「已提交未推」，不写 NEED_PUSH、不结束本轮（本趟是 G6b-04 收尾，不是上线步）。

## 这趟具体做了什么（大白话）

### 1. 重渲叠层（含片尾卡新二维码）
- 跑 `node jobs/JOB-G1/overlays.mjs` → 四语全 `done`；片尾卡 `endcards=4`、章名条 56、字幕层齐，超 3 行 0（闸①过）。片尾卡二维码源头早已指官网首页，重渲即带新码。

### 2. 四语拼片 + 全闸自检
- `node jobs/JOB-G1/rec/assemble.mjs --lang <L> --all` 四语各拼：13 章 + 速览 + 整片 + 13 张海报 + 封面 + og。
- 新片时长（秒，ffprobe 实测四舍五入）：整片 en 576 / zh 736 / ru 704 / fr 684；速览 en 153 / zh 197 / ru 196 / fr 184。
- `node jobs/JOB-G1/rec/gates.mjs` → **`=== FAILS === (none) 全闸通过`**（字幕 0 失败、时长对账、音频起点误差都在范围内）。

### 3. 片尾二维码真解码（两道都过）
- 四语**片尾卡 PNG** 解码：全部 `"https://www.maxhouses.net/"` ✅
- 四语**真拼好的整片末帧**抽帧解码：也全部 `"https://www.maxhouses.net/"` ✅（最硬证据——成片里扫出来就是官网首页）。
- 解码器 `jobs/JOB-G6/gates/_decode-png.mjs` 依赖 pngjs/jsQR 在 `~/mh-verify/g6-qr/node_modules`，故拷到该目录跑（和 G6 一样）。

### 4. 头像确认是 AI 人脸（证据裁切在 shots/G6b/student/）
- **c05 英雄卡**：从 1080×1920 全分辨率帧裁出申请编号 `MH-NV4WH4` 旁的头像 → **一张 AI 合成的非洲裔年轻女性脸（Lina，不戴眼镜、微笑），头像约 270 像素高** → `~/mh-jobs/shots/G6b/student/c05-avatars.jpg`。
- **c06 顶栏/仪表盘顶**：同一张 Lina AI 脸出现在仪表盘顶的英雄卡（`MH-GEZ6TX` 旁），头像约 200 像素高，同帧还含顶栏 Logo/通知/设置 → `c06-avatars.jpg`。这张脸就是贯穿 c05–c13 所有登录态页面的 `#appIdAvatar`。
- **c12 中介端被荐生列表**：被荐生名册卡（`#2 DEMO RAVI` / 其申请号 `MH-GTKQET`）→ `c12-referred-list.jpg`。**实测说明**：中介看被荐生走的是**双盲名册卡（系统编号 + 姓名 + 勾选/编号图标，没有脸缩图）**；被荐生的个人信息面板也只有姓名/生日/护照号、无照片栏。所以 c12 这一章没有「被荐生的脸」可裁——这是产品双盲设计使然，不是漏录。c12 里真正的 AI 脸是**中介本人**的 `#appIdAvatar`（与 c05/c06 同一套 cast 脸）。
- c07–c11、c13 这几章登录态页面顶部同样是这张 `#appIdAvatar`（与 c05/c06 完全同一元素同一张脸，已证），但这些章画面以弹窗/表单/分享屏为主、头像不在镜头焦点；未逐章再裁独立证据图（时间所限，且与 c05/c06 同脸无新信息）。**如主审要逐章独立裁切，下趟可补。**

### 5. 本地起 -g6b 名 + 传公开桶（只新增、不覆盖不删）
- 写 `jobs/JOB-G1/g6b-stage.mjs`：把拼好的成片按 `-g6b` 新名摆进 `/tmp/g6b-stage/<语言>/`，并用 sharp 本地把新海报下采样成列表小图（216×384 webp，≤8KB；实测最大 5030B 合规）。
- `STAGED objects=116`（每语 29 个：9 章 `cNN-g6b.mp4` + `full-g6b.mp4` + `quick-g6b.mp4` + 9 张 `posters/cNN-g6b.webp` + 9 张 `thumbs/cNN-g6b.webp`）。
- `bash jobs/r2-put.sh /tmp/g6b-stage/<L>/ guide/student/v2/<L>/`（模式=wrangler）四语各 **`完成: 29/29 OK`**，**逐个用公开地址 HEAD 回读 http=206 + 字节对得上**（en 57.7MB / zh 62.0MB / ru 64.3MB / fr 63.9MB）。旧 `-g6`/沿用章 c01–c04 对象**一个没动**。

### 6. 改视频页 `guide/student/index.html`
- 构建串：`g6-2026-10-09` → **`g6b-2026-10-09`**。
- OVERRIDE 四语 c05–c13 的视频/海报/full/quick 全由 `-g6` → **`-g6b`**（小图跟海报同基名自动变 `-g6b`）；沿用章 c01–c04 地址/版本一字未动（它们本就无 override）。
- 改了的章时长按新片更新（如 ru c05 56→59、zh c06 73→71、ru c06 70→74、zh c11 77→78、en c13 15→16 等）；四语整片/速览总时长更新为上面第 2 条的新值。
- 页面自检（node 真解析）：`PARSE OK. BUILD: g6b-2026-10-09`；**32544 字节（≤60KB）**；**外部脚本 none**；四语 OVERRIDE 各 9 章、full/quick=`-g6b`；`-g6`(非b) 残留 0 / `-g6b` 共 80 / `g6-2026` 残留 0。

## 闸 / 命令的真实输出（摘录）
- overlays：`endcards=4 (expect 4)`、`topbars=56`、`chapcards=56`、超3行=0。
- assemble：四语各 `posters=13 + cover + og`，章时长 Δ 全 ≤0.03s。
- gates：`=== FAILS ===` → `(none) 全闸通过`。
- 片尾解码：四语片尾卡 PNG + 四语整片末帧 = 8 处全部 `"https://www.maxhouses.net/"`。
- 传桶：en/zh/ru/fr 各 `完成: 29/29 OK`，HEAD 全 206、字节一致。
- 页面：`PARSE OK. BUILD: g6b-2026-10-09`，32544 字节，外部脚本 none，四语各 9 章 override 到 `-g6b`。

## 这趟改了哪些文件
- 主仓库（**只 commit 未推**，本趟 1 笔 `JOB-G6b-04:` 开头）：
  - 改 `guide/student/index.html`（构建串 + 四语 -g6b 覆盖 + 时长 + 总时长）。
  - 新增 `jobs/JOB-G1/g6b-stage.mjs`（本地起 -g6b 名 + 生成小图的脚本，可复跑）。
- **未提交**：`jobs/JOB-G6b/avatars-before-g6b.json`（开工前就是 M，是 assign-faces 每跑必重写的副产品，非本趟逻辑改动，照前几趟惯例不 stage）。
- 本机不入 git：四语录制帧（jobs/JOB-G1/rec/*）、四语成片（guide/dist/*）、叠层 PNG（jobs/JOB-G1/overlays/*）、/tmp/g6b-stage、/tmp 各抽帧。
- 回执仓库 `~/mh-jobs`：本回执（追加本节）+ `shots/G6b/student/` 三张证据裁切（c05/c06/c12，均 guide 演示内容、可公开）。
- 钥匙/密码/业主码：没进回执、没进仓库；DB/R2/wrangler 都是脚本自读 .env，CC 没读 .env、没打印。

## 现在的状态（重要）
- **学校线 G6b-03**：早已做完（commit `0704001`，私有桶 16 个 `-g6b` 对象 + 页面 `gs6b-20261009`）。
- **学生线 G6b-04**：这趟全做完（页面 commit 待打，公开桶 116 个 `-g6b` 对象已传 + 页面 `g6b-2026-10-09`）。
- 本机 `git log origin/main..HEAD` 全部 `JOB-G6b-*` 前缀。**本趟是 G6b-04 收尾，不是上线步，没写 NEED_PUSH.txt。**

## 下一趟从哪接（G6b-05 上线、真验、收官）
1. 按 QUEUE-G6 §0.6 开头：先 `git --no-pager log origin/main..HEAD --format=%s` 确认每笔都 `JOB-G6b` 前缀 → 写 `jobs/JOB-G6b/NEED_PUSH.txt` 一行原因 → 推本趟回执上 `~/mh-jobs` → **立刻结束本趟**（不等推送）。
2. 再下一趟看 `jobs/JOB-G6b/PUSHED-*.txt`：有就前台轮询线上两个构建串（学生 `g6b-2026-10-09` / 学校 `gs6b-20261009`，每 60 秒一次、最多 20 分钟，curl 带浏览器 UA 或用 Playwright）→ 出新构建串再做线上真验。
3. 线上真验（照 §G6b-05）：学生页四语首屏、三条 ✓、点章出画面、速览/整片能播、13 章 HEAD 200、改了的章地址带 `-g6b`、沿用章地址不变、分享二维码指引导页、页脚邮箱；学校页用自造 `G6b-test` 测试码（验完只删它、删前列清单、业主自用码不动）。从线上新片抽帧（两线有头像时间点 + 片尾帧）确认人脸 + 片尾扫码=官网首页。
4. 收官 `~/mh-jobs/SUMMARY-G6b.md`，首行 `PUSH_OK=yes|no`。
