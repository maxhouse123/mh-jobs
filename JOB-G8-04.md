# JOB-G8-04 —— §5 页面双档收口 + 传桶（cycle=2 推送点，本趟做完立即结束）

日期 2026-10-10　机器 Mac mini　本趟代号 G8-04（收口，照 g8-04-page-blueprint.md 一次做完）。大白话。

## 一句话
把「高清/流畅双档」装进学生页和学校页：用户能手动切高清或流畅，网慢时自动切流畅并提示；
流畅版的「整片」是一章接一章自动串着播。两线所有流畅小视频（121 个）和学校目录文件都传上了云、
逐个核对过字节。本地用无头浏览器把两页的核心路径走了 32 条断言，**全过**。
**到 cycle=2 推送点**——等业主在原生终端挂代理推送。

## 二、本趟做掉的（都已 commit，未推）

### 1. 学生页 guide/student/index.html
- **数据改**：BUILD `g7b`→`g8-2026-10-10`；OVERRIDE 四语 c07/c10/c12 → `-g8`、整片 `full-g8`、速览 `quick-g8`；
  第 10 章四语新章名（录取后的补充信息表 + 在华学生专项／英俄法）；c07(zh60/ru61/fr57)、c10(四语33~36)、c12(ru89) 新时长；totals.full 四语(569/737/705/678)。时长全部本机 ffprobe 实测，与施工图 §0.1 逐值吻合。
- **双档功能**：画质状态机 auto/hd/lite（存 localStorage `mh_guide_q`）；播放器旁加「高清/流畅」开关；
  弱网自动判（navigator.connection：saveData / 2g·3g / downlink<1.5 → 流畅）；
  自动降档（高清播放首次 playing 起 30s 内 waiting≥2 → 切流畅、同位续播、2s 提示）；
  流畅「整片」= 串播 c01…c13-lite + 片尾卡，播完自动下一段，带「第 N/13 章」小标 + 上/下一章；
  高清↔流畅互切按累计章时长换算全片位置；速览流畅用 quick-lite-g8；高清侧逻辑一字未动。
  四语新键 qHd/qLite/qSwitched/chOfN 全走 D.T[LANG]（零裸键）。

### 2. 学校页 guide/school/index.html + manifest
- 构建串 `gs7`→`gs8-20261010`（注释 + #buildStr + BUILD 变量 3 处）。
- manifest（canonical `guide/school/v1/manifest.json` + dist 版 gitignored 本地也同步）加顶层 `lite`：14 章 + quick + intro + endcard（file/seconds/v=srcMd5前8）；**hd 侧 chapters/full/quick 一字未动**（线上已验：full-g7 不变）。
- 双档 JS（横版）：同款状态机/开关/自动判/降档；流畅整片 = intro-lite + c01…c14-lite + endcard-lite 串播，播完自动下一段**保持全屏**（沿用 GS-5 enterFs）；lite 走 mediaUrl(file,v) 带 ?v。en/zh 加键 qHd/qLite/qSwitched/chofn。
- 媒体函数**没改**（施工图 §0.3 已读：鉴权后前缀内任意 key 放流，content-type 含 .mp4，上传即可取，鉴权一字不动）。

### 3. 缩略图（§3.1）
- 学生四语 thumbs/c07-g8/c10-g8/c12-g8.webp 从 posters 缩到 216×384（线上同规格），cwebp 出，3~6KB。

### 4. 传桶（§5.3）—— 121 对象 + manifest 全传全验
- **学生公开桶** media.maxhouses.net/guide/student/v2/<lang>/（走 r2-put.sh，wrangler 模式）：
  每语 26 个 = HD(c07-g8/c10-g8/c12-g8/full-g8/quick-g8) + posters×3 + thumbs×3 + lite×15；**四语 104/104 全 206、上传时逐个 readback 核字节**；另 curl 独立抽验 5 个线上字节==本机 ✅。
- **学校私有桶** maxhouse-media-private，正确键前缀 **guide/school/v1/zh/**（走 r2-private-put.sh 逐文件显式键）：17 个 lite（c01~c14 + quick + intro + endcard）+ manifest.json；**17/17 + manifest 全 readback 核字节**；独立 wrangler get 复核 manifest(线上 lite 14 章、hd full-g7 不动) + c14-lite(字节==本机) ✅。

### 5. 本地三层自验（铁律11，全过，报告 docs/self-test-report-g8-04-page.md）
- ① 四语/双语键 grep 实证齐（学生各 4、学校各 2），零裸键，新按钮各有真处理器；页面 40KB/36KB ≤60KB、零外部脚本、无新增第三方域名。
- ② Playwright file://（学生，函数全局直接驱动）+ 全 route 桩本地（学校，脚本在 IIFE 里靠真点击+观测 DOM）：**PASS=32 FAIL=0**。覆盖：开关切换、aria-current、lite/hd URL 解析、流畅速览、流畅整片串播跨段(ended→下一段)、章/段标签、高清↔流畅互切位置换算、自动降档(派发 playing+2×waiting→切 lite+toast)、学校全屏串播、hd 不动。
- ③ 报告入 docs/，终端已打印要点。
- 真鉴权播放 / CDP 真限速降档 / 学校私有桶鉴权取 lite 留 G8-05 线上真验（本地无法触达真库真限速）。

## 三、还差什么 + 下一步（G8-05）
- 本趟是 **cycle=2 推送点**，已写 jobs/JOB-G8/NEED_PUSH.txt（首行 cycle=2）。
- 下一趟开工：看 jobs/JOB-G8/PUSHED-*.txt 最新首行是不是 cycle=2 → 是就轮询线上构建串 g8-2026-10-10 / gs8-20261010 到位（每 60s，最多 20 分钟，带浏览器 UA 或 Playwright）→ 进 G8-05 上线真验(A1~A13)+全矩阵复测(after)+删 G8-test 码。

## 四、需清理的垃圾对象（我造的，记给 G8-06）
- 第一次用私有脚本**目录模式**传学校时，脚本把键拼成了绝对路径（`guide/school/zh//tmp/g8up/school/zh/*.mp4`），
  产生 **约 17 个错键孤儿对象**（前缀 `guide/school/zh/`，无 v1/，manifest 不引用、函数永不会按这路径取，无害）。
  已改逐文件显式键重传到正确前缀 `guide/school/v1/zh/`（正式对象全部正确在位）。
  私有脚本无删除能力——**这批孤儿请在 G8-06 清理**（扩 cleanup.sh 扫 `guide/school/zh/` 下 `/tmp/` 字样的错键一并删；真对象在 guide/school/v1/zh/ 不受影响）。

## 五、未决/跳过
- CF §2 第 3 条（http3/0rtt/early_hints/tiered cache）：令牌仍 9109 无 Zone Settings 权（本趟未再测，沿 G8-04c 结论），跳过不停工，待业主补 `Zone.Zone Settings:Read+Edit`、`Zone.Cache Settings:Edit`。

## 六、安全
- 全程无账号密码/钥匙/PII 进回执、截图、仓库；私有桶上传走脚本（脚本自读 .env，CC 不读不打印钥匙）；
  画面无邮箱、无测试名单外真学生；产品 HTML 只改 §5 双档相关，未顺手改别的。

## 七、本趟写入/提交
- 主仓库（**仅 commit 未推**，等 cycle=2 业主推）：`0513a8b JOB-G8-04:` —— guide/student/index.html + guide/school/index.html + guide/school/v1/manifest.json + docs/self-test-report-g8-04-page.md + jobs/JOB-G8/g8-04-walk.mjs。dist 版 manifest gitignored 本地已同步不入库。
- 待推累计 6 笔（全 JOB-G8）：0513a8b / 2a3c589 / f1829f3 / 1284468 / 07e791a / 1e2d674。
- ~/mh-jobs：本回执，push。
