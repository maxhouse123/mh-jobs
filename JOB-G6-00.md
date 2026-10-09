# JOB-G6-00 回执 · 摸底 + 先红（头像机制 / 演员名单 / 二维码现状 / 14-1 源头）

日期 2026-10-09 ｜ 无人值守 ｜ 本机 Mac mini（真卷 /Volumes/Dev/MAXHOUSE）

## 一句话
摸清了「头像到底存在哪、怎么显示」，证明了两道新闸现在都是「红」的（头像=首字母/占位、片尾二维码=指向引导页），该查的清单都查了。本包**零改动产品**、零写数据库，只在 `jobs/JOB-G6/` 下建了侦查文件。**没推主仓库**（按规矩本包只 commit）。

---

## 1. 环境核对（都是真命令跑出来的）
- ffmpeg / ffprobe = **9.0.2**，在。
- 脚本都在：`jobs/r2-put.sh`、`jobs/r2-private-put.sh`、`jobs/JOB-GS5c/make-manifest.sh`、`jobs/db-run.sh`、`jobs/cf-api.sh`、`jobs/JOB-G0/rebuild.sh`、`jobs/JOB-GS2/rebuild-school.sh`。
- Playwright（无头浏览器）+ Supabase CLI 在 `jobs/JOB-G1b/node_modules/.bin`；Playwright 的浏览器包也在 `jobs/JOB-G0/node_modules`。**本机实测能跑**：用它真登了一次学生端（见第 6 条），说明录制那套在这台 Mac mini 上能动。
- `~/mh-verify/accounts.json` 里有这些键（只报有无，不碰密码）：guide_stuA、guide_stuB、guide_agent、guide_agentFresh、guide_sch2、guide_sch3、guide_rec_en、guide_rec_zh、student。**没有** guide_sch_01~08 的单独登录键（演示生是后台建的数据，不是登录账号，正常）。
- `guide/dist/` 两条线成片都在：学生端 en/zh/ru/fr 各 c01~c13 + full + quick + 封面；学校端 `school/zh/` c00-intro、c01~c14、c99-ending、full、quick、14 张缩略图。
- **⚠ 三个要装的东西（后面上传/写头像的包开工前必须先装，现在都没有）**：
  1. **wrangler 没装**（`jobs/JOB-G1b/node_modules/.bin/wrangler` 不存在了，npx 也没缓存）→ **R2 上传（G6-04/05 传视频）现在不能跑**。
  2. **@aws-sdk 没装** → R2 的 s3 上传模式也不可用（`bash jobs/r2-put.sh --check` 实测：`s3 可用=false  wrangler 可用=false`）。
  3. **@supabase/supabase-js 没装** → **写头像（G6-02 往 Supabase 存储桶传脸）现在没有上传通道**（`jobs/db-run.sh` 只会跑 SQL，不能传文件）。
  - 这三样都能用 npm 走代理装（本包已这样装好了 jsqr/pngjs 二维码解码器，证明代理+npm 正常）。不是红线，是开工前的准备活，装了就行；装不动再按 0.4 停。

## 2. 头像机制（已用数据库探针坐实）—— 详见 `jobs/JOB-G6/avatar-mechanism.md`
**一句话**：产品**没有单独的「头像列」**。头像 = 学生上传的「个人照片 photo」材料。
往存储桶 **`student-documents`** 的 `<学生id>/photo/xxx.jpg` 放一张脸 + 把 `documents` 表里该生 `doc_type='photo'` 那条的 `file_path` 指向它，三端（学生/学校/中介）显示的就是这张脸；不改就回落成首字母圈。
- 探针 `jobs/JOB-G6/probe-01-avatar-mech.sql` 真跑输出证明：`documents` 表有 `file_path/file_name/doc_type/student_id/deleted_at` 等 23 列；`students` 表**没有**任何 avatar/photo/image 列（返回 0 行）；存储桶 `student-documents` 存在（私有桶）。
- 这正好对上任务书 §0.2(a) 的「头像来自证件照/个人照片材料槽」那条路。

## 3. 演员名单 `jobs/JOB-G6/cast-avatars.json`
- 库里 **is_test=true 学生 = 50 人**（命令输出），名单正好 **50 行**。
- 分组：**其它测试生 35 + guide 学校演示生 8 + guide 其它演示 7**。
- 现头像状态：**占位(specimen) 8 ｜ 没有 photo 文档 10 ｜ 有自定义图 32**。
  - → 8+10 = **18 人现在一定是首字母/勾回落**（学校端看就是首字母圈）＝ 这就是「红」。
  - → 32 人是**真上传的照片**（文件名里带真实姓名、像真人自拍/证件照），视频里会露真人脸，有隐私风险，也要换成 AI 脸。
- **隐私处理**：提交进仓库的 `cast-avatars.json` 已**抹掉文件路径与真实文件名**（只留状态 none/placeholder/custom）；非 guide 测试生**不写姓名**。带真实路径的完整版只留在本机 `~/mh-verify/g6-local/cast-avatars-FULL.json`（不进仓库），G6-02 写头像时现查数据库拿准确路径即可。
- 需要几张脸（草稿 `jobs/JOB-G6/face-demand.json`，按「外貌组×性别」，G6-01/02 再细化）：A南亚男4女1、B东亚东南亚男1女1、C非洲男10女4、D中东北非女2、E拉美男1女2、F欧洲中亚男5女6，另有 6 人国籍空、若干人性别空需随机/补判。合计 **50 张**（一人一张，不复用）。未归组的国籍：赤道几内亚/刚果共和国→归非洲C、"美国"→归F。

## 4. 片尾二维码现状（闸 Q = 红，已真解码）
用 jsqr 解码器（装在 `~/mh-verify/g6-qr`）从**已上线的成片**抽片尾帧真解码：
```
/tmp/g6qr/gateQ-school.png  -> "https://www.maxhouses.net/guide/school"
/tmp/g6qr/gateQ-student.png -> "https://www.maxhouses.net/guide/student"
```
两张都 ≠ `https://www.maxhouses.net/` → **红**。
源头落点（G6-03 改这两处）：
- 学生线：`jobs/JOB-G1/rec/manifest.mjs:36` → `qrTarget: 'https://www.maxhouses.net/guide/student'`
- 学校线：`jobs/JOB-GS3/rec/overlays-sch.mjs:18`（`guideUrl`）+ `:131`（`QRCode.toDataURL(CONTACT.guideUrl…)`）
重复跑的脚本：`bash jobs/JOB-G6/gates/gate-Q.sh`。

## 5. 14-1 源头核对 → **源头已齐，不用改**
学校端第 14 章第 1 镜的旁白源头 `jobs/JOB-GS3/rec/shots-zh.json`（id "14-1"）中英文都已列齐六类：
「面试确认、面试拒绝、付款、学生回应、平台对申请的决定、任务审核结果」。GS-5b 的修正早已回灌到源头，不是只在成片上动的刀。**本包不动任何文案**。

## 6. 闸 H（头像）现状
- **数据层已坐实红**：18/50 学生无真图（占位8+无图10）→ 学校端浏览池/候选池一定是首字母回落。
- **本机真登一次（证明录制套件能跑）**：真登学生端 guide_stuA（405px 手机宽）成功，顶栏 `#appIdAvatar` **已有一张图**（不是回落）——说明 guide_stuA 这个学生账号本身传过照片。所以学生端顶栏「自己头像」不一定红，**真正红在学校端那一池学生的首字母圈**（18 人）。
- 脚本 `jobs/JOB-G6/gates/gate-H-student.mjs`（只读、真登、不写库）。

---

## 还差什么（下一趟 G6-00 收尾）
1. **闸 H 学校端活取**：真登学校端 guide_sch3，走到浏览池/候选池，用 `.student-avatar` 选择器数「首字母回落个数 / 非人脸图个数」（现状应 >0）。中介端 guide_agent 被荐生列表确认是**编号圈 #N、根本没有人脸头像**（侦查已知，待活取确认）。
2. **`chapters-with-avatars.json`（两线各一份）**：用现成录制骨架**空跑**两条线，逐镜在 DOM 里查头像元素，记每章「有/无」头像——定出哪些章要重录。这步要跑完整录制骨架（学校端第2章、学生端英文第1章先各空跑一章，兑现 §0.8「本机第一次跑先各空跑一章」）。
3. 上面两步做完，G6-00 的闸3判据才算全齐。

## 下一步（给下一趟的我）
- 先 `git status`、读本回执；装 wrangler / @aws-sdk / @supabase/supabase-js（走代理）；
- 跑学校端空跑一章 + 学生端英文空跑一章（§0.8）；出 `chapters-with-avatars.json`；
- 补闸 H 学校端活取数字；齐了就进 G6-01 造脸。

## 本包产出文件（已 commit 到主仓库本机，未推）
`jobs/JOB-G6/avatar-mechanism.md`、`probe-01-avatar-mech.sql`、`probe-02-cast.sql`、`cast-avatars.json`（已脱敏）、`face-demand.json`、`gates/gate-Q.sh`、`gates/gate-H-student.mjs`。
本机工具（不进仓库）：`~/mh-verify/g6-qr/`（jsqr 解码器）、`~/mh-verify/g6-local/cast-avatars-FULL.json`（带路径完整名单）。

---

# JOB-G6-00 续跑补完（第二趟，2026-10-09 下午）

上一趟 G6-00 列的「还差什么」三项，这趟全做完了，G6-00 正式收口。

## A. 本机能录能合成（§0.8 兑现）
- **录**：两条线各真跑一章（存帧），都成了：
  - 学校端第 2 章：`[c02/zh] shots=5 ok=5 lens=40.682s frames=402`
  - 学生端英文第 1 章：`[c01/en] shots=4 ok=4 lens=24.9s frames=230`
- **配音语音齐**：`say -v '?'` 实测四种需要的语音都在 → Samantha(en) / Tingting(zh) / Milena(ru) / Amélie(fr_CA)。文字没变的镜复用现成配音，只有变的镜才新配（本轮二维码不碰口播，预计无需新配）。
- **ffmpeg/ffprobe 9.0.2 在**（合成用，历轮已验流水线，首次真合成在 G6-04/G6-05 时顺带坐实）。
- **⚠ 本机第一次跑踩到的坑（已修好，记录备查）**：录制依赖 `pngjs`（两线）和 `qrcode`（学校线片尾二维码）在本机从没装过（历轮都在笔记本跑的）。这些 recorder 目录的 `node_modules` 其实是**软链接**，都指向中央仓库 `~/mh-verify/node_modules`。处理时一度把三个软链接(`JOB-G0`/`JOB-G1`/`JOB-GS3/rec`)覆盖成了实目录，已全部**还原成指向 `~/mh-verify/node_modules` 的软链接**，并把 `pngjs`+`qrcode` 装进中央仓库；现三处软链接都能解析到 playwright+pngjs+qrcode。node_modules 不进 git，无仓库影响。

## B. 哪些章有头像（两份清单已出，DOM 探针实测，不靠猜）
用「空跑录制骨架、每镜落定后在真 DOM 里数头像元素」的办法逐章测（任务书第6步的正法），脚本与原始数据都入仓：
- `jobs/JOB-G6/gates/probe-avatars-student.mjs` + `_probe-student-raw.json`
- `jobs/JOB-G6/gates/probe-avatars-sch.mjs` + `_probe-sch-raw.json`
- 结论清单：`jobs/JOB-G6/chapters-with-avatars-student.json` / `-school.json`

**学生线（顶栏 #appIdAvatar）** 要重录的章 = **c05 c06 c07 c08 c09 c10 c11 c12 c13（9 章）**；沿用现成的 = c01 c02 **c03 c04** c14。
- 意外发现（幸好真测了）：**c03/c04（新生 fresh 状态）探针测到 0 个在屏头像**——新生还在"建档/传材料"的向导页，主壳顶栏没出来，所以顶栏头像不在屏。原先"登录后每页都有顶栏头像"的假设不成立。c03/c04 列为"录制时抽帧复核"，真有顶栏头像再补录。

**学校线（.student-avatar 池卡 + #detailAvatar 详情大图）** 要重录的章 = **c05 c06 c07 c08 c10 c12 c13（7 章）**；沿用现成 = c00-intro c01 c02 **c03** c04 c09 **c11** c14。
- c03/c11 探针测 0，但静态看脚本疑有候选池片段 → 列"录制时抽帧复核"，宁可多录一章不漏脸。

## C. 闸 H 学校端活取（现状 = 红，真命令输出）
脚本 `jobs/JOB-G6/gates/gate-H-school.mjs`（真 guide 登录 + 本地页，只读不写库），跑浏览池/候选池/详情三章，数同屏头像元素里「有人脸图 / 首字母回落」：
```
c06: total=95  有face图=29  首字母回落=66
c07: total=8   有face图=0   首字母回落=8
c08: total=8   有face图=0   首字母回落=8
合计: total=111  有face图=29  首字母回落=82   (AI 脸=0)
```
两种"红"都在：**82 个头像是首字母圈（这些学生没传照片）**，**29 个是真人照片（有隐私，也要换成 AI 脸）**。AI 脸 0 个 → **闸 H 现状 = 红**，坐实。

## D. G6-00 闸3判据逐条
- ✅ avatar-mechanism.md 一句话结论 + 探针原文（上一趟已出）。
- ✅ cast-avatars.json 50 行 = 库里 is_test 学生 50 人（上一趟）。
- ✅ 两张片尾卡解码原文（上一趟：学生→.../guide/student，学校→.../guide/school，都≠首页）。
- ✅ 闸 H 红（本趟 C）/ 闸 Q 红（上一趟）命令输出都在。
- ✅ 两份 chapters-with-avatars 清单（本趟 B）。

## 下一步（给下一趟：进 G6-01 造脸）
- G6-01 造 AI 人脸库：先试 `thispersondoesnotexist.com`（带浏览器 UA；上一趟 curl 该域名回的是 HTML 不是图，**要用 Playwright 打开再存**，或换接口）。按 `face-demand.json` 需求数×1.3、每组男女各≥3 张。
- 需求数回顾：50 人一人一张（占位8+无图10+真照片32 全换 AI 脸）。
- 造完 G6-02 装脸（通道：Supabase 存储桶 student-documents，需 @supabase/supabase-js——**G6-02 开工前要装**，连同 wrangler+@aws-sdk 一起，都走代理 npm，装进中央仓库 ~/mh-verify/node_modules 再软链接）。
