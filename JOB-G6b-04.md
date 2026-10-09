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
