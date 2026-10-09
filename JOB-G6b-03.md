# JOB-G6b-03 · 学校端重录（**7 章已重录带新脸、full/quick 已重拼、二维码已验、证据已出；下一趟上传私有桶+改目录+改构建串**）

日期 2026-10-09 ｜ 无人值守 ｜ 本机 Mac mini（真卷 /Volumes/Dev/MAXHOUSE）

## 一句话
学校端操作视频里**凡出现学生头像的 7 章**（第 5/6/7/8/10/12/13 章）这趟**全部重录了一遍**，录出来的新片子里学生头像**全是 G6b 重新配对后的 AI 人脸**（非洲籍学生配非洲脸、国籍对脸）。7 章自检**全部通过**，整片/速览已按正确拼法重拼（728.6 秒 / 175.7 秒），片尾二维码解码仍是官网首页。**还没做的**：把 `-g6b` 新名成片传上私有桶、重出目录(manifest)、改页面构建串 `gs6b-20261009`——这是 G6b-03 后半段，下一趟接着做（成片已复制成 `-g6b` 名存在本机）。

## 这趟具体做了什么（大白话）

### 一、先把演示数据和脸对齐
- 录制脚本是按**邮箱别名**（固定不变）认 8 名演示学生的；但演示学生的内部身份号每次重建会换新。这趟开录前：
  1. 跑了演示数据复位脚本（`st-base-sch.sh`）—— 8 名演示生各就各位、演示校联系方式是演示值、任务名无真校名。✅
  2. 发现复位会把 8 名演示生换成新身份号，而 G6b-02 装的脸绑在旧身份号上（孤立了）。于是**重跑了装脸脚本**（`assign-faces-g6b.sh`，按邮箱别名认当前身份号、幂等）→ 当前 50 名演示/测试生**个个有 G6b 新脸**（数据库实测 `pointing_g6b=50 / 50`）。✅
  3. 录前取当前身份号写进临时变量（Rahim/Sara/Dewi/Aigerim/Ivan + Ivan 的 offer 号），注入录制脚本。身份号/钥匙都没进仓库、没打印。

### 二、7 章逐章重录（复用原配音，只换画面）
文字口播一个字没动，配音段全部复用。每章：真录 → 叠字幕/顶条/章名卡 → 合成 → 自检。

| 章 | 内容 | 自检 | 时长 |
|---|---|---|---|
| c05 | 一键匹配结果 | ✅ PASS | 36.8s |
| c06 | 浏览与筛选/盲搜 | ✅ PASS | 52.1s |
| c07 | 候选池与状态 | ✅ PASS | 42.0s |
| c08 | 学生档案与材料 | ✅ PASS | 42.7s |
| c10 | 发 Offer | ✅ PASS | 54.7s |
| c12 | 付款解锁后 | ✅ PASS | 40.4s |
| c13 | 建档状态 | ✅ PASS | 64.1s |

**自检真实输出**：7 章全部 `=== SELF-CHECK PASS ===`，`subFail=0 hlFail=0`（字幕零错、高亮零错）。

### 三、肉眼证实头像是「脸配国籍」的 AI 脸（证据图已存 `shots/G6b/school/`）
- **候选池（c07，放大看）**：Student 01 越南=东亚脸 ✓ / Student 02 孟加拉=南亚脸 ✓ / **Student 03 尼日利亚=深肤非洲男脸 ✓（业主点名那一例已修）** / 顶部 Hassan Demo Sara 埃及。
- **学生档案大头像（c08）**：Uddin Demo Rahim 孟加拉 23 岁男=南亚男脸 ✓。
- **浏览池（c06）**：Student 01 墨西哥 25 岁女=拉美女脸 ✓。
- 证据图：`c05/c06/c07/c08/c10/c12/c13-avatars.png` 已放 `~/mh-jobs/shots/G6b/school/`（c07 为放大候选池头像列、c08 为档案大头像、c06 为浏览池前排）。

### 四、整片/速览重拼 + 片尾二维码闸
- **用对脚本**：整片/速览要用 `build-extras-sch.mjs`（= 开场 + c01~c14 + 片尾），**不是** `assemble-sch.mjs`（后者只拼 c01~c14 + 12 秒片尾、不含开场，会短 50 秒——这趟先踩后纠正）。
- 结果：**full = 728.63 秒（16 段）** ✓、**quick = 175.73 秒** ✓（与 G6-04 的 728.9s/175.7s 一致）。
- **片尾二维码闸 Q**：full、quick、endcard 三处末帧解码**全部 = `https://www.maxhouses.net/`** ✅（重拼后又复验一次仍对）。

## 录制中遇到并解决的一件事（记清以便复看）
- **c10「发 Offer」的 10-2 镜头两趟测不到「决定录取专业」发送表单**：根因是我第一次录 c10 时 10-3 真发了 offer（Aigerim 这条 offer 变成「已发送」态），而复位脚本 `st-base` 用 coalesce 撤不回「已发送」，于是第二次录时 UI 只显示「已发送」、发送表单不出 → 高亮目标找不到。
  - **解法**：照已批准的 `gs3-ch12-reset.sql` 同款「录制态复位」模式，新增 **`gs3-ch10-reset.sql`**（把 Aigerim 的 ADM-100004 offer 从「已发送+面试通过」清回基线「面试已确认·未发·未判通过」，只碰 is_test 演示生 S8、幂等、保留 interview_confirmed_at）。复位后再 `gs3-ch10-ready`（重置面试通过）→ 重录 c10 → **5/5 全过**。
  - 录后又跑了 `gs3-ch10-reset` 与 `gs3-ch12-reset` 把 Aigerim/Ivan 复位干净。
  - 这是本趟唯一的主仓库源码改动（新增一个复位 SQL，照既有模式，没碰别的脚本）。

## 闸的真实结论（本趟）
- **自检闸**：7 章全 `SELF-CHECK PASS`、字幕零错、高亮零错。✅
- **闸 H（头像，只读活取）**：c07 候选池 8/8 有脸·0 回落、c08 档案 8/8 有脸·0 回落；c06 浏览池是大列表（峰值 97 元素里 56 个首字母是列表加载途中/非演示学生的半成品格子），**50 名演示生经数据库实测个个有脸（pointing_g6b=50）**，已按原尺寸裁「浏览池前排」肉眼复核。✅
- **闸 Q（片尾二维码）**：full/quick/endcard 三处 = 官网首页。✅
- 整片/速览时长闸：728.63s / 175.73s。✅

## 还差什么 / 下一趟从哪接（G6b-03 后半段）
1. **传私有桶**：把 `-g6b` 新名成片（已在本机 `guide/dist/school/zh/`：c05/06/07/08/10/12/13-g6b.mp4 + full-g6b.mp4 + quick-g6b.mp4）+ 变了的缩略图（thumb-cNN-g6b，需先用 `poster-thumbs-sch.mjs` 同款重出）一律**只新增**传进 `maxhouse-media-private/guide/school/v1/zh/`，逐个字节核对，旧对象不删不动。（走 `jobs/r2-private-put.sh`，脚本自读 .env 的 token，CC 不碰钥匙；先 `wrangler whoami` 确认走 3.x 真桶。）
2. **重出目录**：`jobs/JOB-G6/make-manifest-g6.sh` 或同款，改了的章（05/06/07/08/10/12/13 + full + quick + 变了的缩略图）指向 `-g6b` 新名新版本号、没改的章地址/版本号一字不动，前后 manifest diff 贴回执。
3. **页面构建串**：`guide/school/index.html` 从 `gs6-20261009` 改成 **`gs6b-20261009`**（3 处都改）。
4. commit `JOB-G6b-03:`（把 manifest.json + index.html + dist-manifest 记录一起提，**不推**）。
5. 之后进 **G6b-04**（学生端四语重录，第 5 章用换好的 Lina 新脸素材）→ **G6b-05**（上线真验收官）。

## 本趟产物
- 主仓库（**本趟只 commit 未推**，1 笔 `JOB-G6b-03:` 开头）：
  - 新增 `jobs/JOB-GS3/states/gs3-ch10-reset.sql`（c10 录制态复位脚本，照 gs3-ch12-reset 模式）
- 本机不入 git（guide/dist 本来就忽略）：`guide/dist/school/zh/` 的 7 章新成片 + c05..c13-g6b.mp4 + full/full-g6b.mp4 + quick/quick-g6b.mp4（下一趟传桶用）。
- 回执仓库 `~/mh-jobs`：本回执 + `shots/G6b/school/c05..c13-avatars.png`（画面是演示生/已改名 Student NN，可公开）。
- 钥匙/令牌/业主码/演示密码：一律没进回执、没进截图、没进仓库；DB 走 db-run.sh、装脸脚本自读 .env，CC 没读 .env。

## 可复跑备忘（给下一趟）
- env 身份号（当前库值，随下次重建会变，复用前先重取）：
  - Rahim=guide-sch-02 / Sara=guide-sch-04 / Dewi=guide-sch-05 / Ivan=guide-sch-07 / Aigerim=guide-sch-08；Ivan 的 offer 在 ADM-100005。
  - 取法：`select ... from students where email like 'maxhouseapp+guide-sch-%@gmail.com'` + 对应 offer_decisions。
- 录制三步：`node run-sch.mjs --chapter N --lang zh` → `node assemble-sch.mjs --lang zh --chapter N` → `node selfcheck-sch.mjs --lang zh --chapter N`。
- 整片/速览：`node build-extras-sch.mjs --lang zh --full` / `--quick`（**不要用 assemble-sch.mjs --full**）。
- 写库章顺序：c10 前先 `gs3-ch10-reset` + `gs3-ch10-ready`；c12 录后 `gs3-ch12-reset`；c10 录后 `gs3-ch10-reset` 复位干净。
- 二维码解码：帧 PNG → `~/mh-verify/g6-qr` 目录下 `node _decode.mjs <png>`（jsqr+pngjs 装在那）。

---

## 【续·第二趟 2026-10-09】G6b-03 后半段已全部完成（传私有桶 + 重出目录 + 改构建串 + commit）

上一趟 7 章录好并重拼了整片/速览，但没传桶、没改目录、没改页面构建串。这趟全做完了，学校端这一关（G6b-03）**整个结束**。

### 做了什么（大白话）
1. **重出变了的缩略图**：用 `poster-thumbs-sch.mjs` 从当前成片重抽一遍章缩略图。7 个重录章里 **6 个**（c05/06/07/08/10/12）代表帧里有学生头像、画面变了→裁成 `-g6b` 新名新图；**c13 的代表帧是「建档状态」界面、没有头像、画面一字没变**（md5 仍是 `e8e4528e`）→沿用旧 `thumb-c13.jpg`、不新传。肉眼看过 c07 缩略图：候选池四行学生各是不同 AI 脸、Student 03 尼日利亚是深肤非洲脸 ✓。
   - 顺带踩到并处理：没录的章里 c02/c14 的缩略图用 ffmpeg 重抽会有几字节抖动（抽帧非确定性），这两章本轮没动，已把它们和海报 poster.jpg **还原成线上原字节**，保证目录里没改的章版本号一字不动。
2. **传私有桶（只新增 `-g6b` 新名，绝不覆盖、绝不删旧对象）**：共 **16 个对象**传进 `maxhouse-media-private/guide/school/v1/zh/`，每个当场回读核对字节一致，最后又整体回读复验一遍 16/16 全 `OK`：
   - 7 个重录章：c05-g6b … c13-g6b.mp4
   - full-g6b.mp4、quick-g6b.mp4
   - 6 张变了的缩略图：thumb-c05-g6b … thumb-c12-g6b.jpg
   - 新目录 manifest.json（键 `guide/school/v1/manifest.json`，覆盖的是目录本身、这是应该的）
   - （传的过程中 c05 / quick / thumb-c08 / thumb-c12 各有一次回读瞬时失败，重传即过，最终全部核对一致。）
3. **目录（manifest）按老办法重出**：不从零重算（本机 c02.mp4 与线上字节有历史漂移、整体重算会误动没改的章），改为在**当前线上目录**上只改 **build + full + quick + 这 7 章** 指向 `-g6b` 新名新版本号；**没改的章（c01-04/09/11/14）地址和版本号一个字没动**（git diff 已逐行核对，确只动这几处）。
4. **页面构建串**：`guide/school/index.html` 从 `gs6-20261009` 改成 **`gs6b-20261009`**（注释/显示/JS 变量 3 处都改了）。
5. **dist-manifest-zh.json** 记入 `-g6b` 新对象（bytes+md5），与线上目录保持一致。

### 闸的真实输出
- **缩略图归属**：6 章缩略图变了→出 `-g6b`，c13 未变→沿用（md5 命令实测 `e8e4528e` 不变）。
- **上传回读核对**：16 个对象 `OK  … bytes`，整体复验 16/16 本地=远端字节一致 ✅
- **目录 diff**：只有 build + full/quick + 7 个重录章变成 `-g6b`，其余章地址/版本号一字未动（已贴 git diff 过目）✅
- **构建串**：index.html 3 处 = `gs6b-20261009` ✅

### 这趟改了哪些文件（主仓库，只 commit 未推，1 笔 `0704001`，JOB-G6b-03 开头）
- 改 `guide/school/index.html`（构建串）、`guide/school/v1/manifest.json`（新目录）、`jobs/JOB-GS3/dist-manifest-zh.json`（记入 -g6b 新对象）
- 新增 `jobs/JOB-G6/manifest-template-g6b.json`、`jobs/JOB-G6/make-manifest-g6b.sh`
- 本机不入 git：`guide/dist/school/zh/` 的 -g6b 成片与新缩略图；桶里只新增 16 个 -g6b/manifest 对象，旧对象一个没删没改。
- 钥匙/令牌/业主码：一律没进回执、没进仓库；wrangler 鉴权走环境变量 CLOUDFLARE_API_TOKEN、CC 没碰 .env、没打印。

### G6b-03 整体结论
学校端（中文）**有头像的 7 章全部换成 G6b 新脸并重录、整片/速览重拼、全部 `-g6b` 新名传进私有桶、目录重出、页面构建串升到 gs6b-20261009**。只差上线（push + Pages 部署）与线上真验——那是 G6b-05。

### 下一步
进 **G6b-04**（学生端四语重录，第 5 章用换好的 Lina 新脸素材）。第一件事先看学生线重建卡点（g0-02 向导）是否仍挡路——按 G6-05 的办法逐章前置 SQL 录。
