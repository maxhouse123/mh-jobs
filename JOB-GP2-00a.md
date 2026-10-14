# JOB-GP2-00a 回执 · 补 GP-1 两笔小账（本机，不停）

日期：2026-10-14（第 1 趟）。零 DB 写。

## 开工核对
- 五端口 `git diff origin/main --stat -- student-portal school-portal partner-portal admin-portal reviewer-portal` 为空、无未跟踪文件 —— PASS。
- GP-1 成片齐：`~/guide/dist/partner/` ch1~10 / OP / ED / full / trailer / segments，四语 × 横竖 —— PASS。

## 1. 改过字幕的章 · 章联络表重出（覆盖旧图，文件名不变）
工具 `jobs/JOB-GP1/rec/gp1-finish.mjs --stage contact --lang <L> --chapter <N>`（每次出该章 land+port 两张，从最终成片抽镜中点帧拼图）。每张图标注对应成片 md5 前 8 位（源片 `~/guide/dist/partner/ch<N>-<orient>-<L>.mp4`）。

| 联络表图（~/mh-jobs/shots/GP1/<L>/） | 源成片 | md5(前8) |
|---|---|---|
| en/ch2-contact-land-en.png | ch2-land-en.mp4 | 2ff4d679 |
| en/ch2-contact-port-en.png | ch2-port-en.mp4 | 249d3a3d |
| ru/ch2-contact-land-ru.png | ch2-land-ru.mp4 | 03675320 |
| ru/ch2-contact-port-ru.png | ch2-port-ru.mp4 | 8f649be5 |
| fr/ch2-contact-land-fr.png | ch2-land-fr.mp4 | d2dcf058 |
| fr/ch2-contact-port-fr.png | ch2-port-fr.mp4 | 49b9894d |
| ru/ch6-contact-port-ru.png（俄竖版，裁决点名） | ch6-port-ru.mp4 | f5174267 |
| ru/ch6-contact-land-ru.png（工具附带，同批重渲） | ch6-land-ru.mp4 | 1cb0b8cf |
| ru/ch9-contact-land-ru.png | ch9-land-ru.mp4 | 42d05b57 |
| ru/ch9-contact-port-ru.png | ch9-port-ru.mp4 | 476eb996 |

ch2 的 2-4 分段联络表（工具 `jobs/JOB-GP1/rec/_seg-strip-24.mjs`，从最终成片 ch2-<orient>-<L>.mp4 取 2-4 五段中点帧拼带；工具一次出四语，裁决点名英/俄/法——zh 第四轮未重烧，重渲得同名同内容图，纯覆盖，见 D-GP2-1-1）：

| 分段带图 | 源成片 | md5(前8) | 2-4 起点/时长 |
|---|---|---|---|
| en/ch2-2-4-segments-land-en.png | ch2-land-en.mp4 | 2ff4d679 | 15.79s / 13.73s |
| en/ch2-2-4-segments-port-en.png | ch2-port-en.mp4 | 249d3a3d | 15.81s / 13.72s |
| ru/ch2-2-4-segments-land-ru.png | ch2-land-ru.mp4 | 03675320 | 16.55s / 14.27s |
| ru/ch2-2-4-segments-port-ru.png | ch2-port-ru.mp4 | 8f649be5 | 16.51s / 14.24s |
| fr/ch2-2-4-segments-land-fr.png | ch2-land-fr.mp4 | d2dcf058 | 15.88s / 13.78s |
| fr/ch2-2-4-segments-port-fr.png | ch2-port-fr.mp4 | 49b9894d | 15.89s / 13.77s |
| zh/ch2-2-4-segments-land-zh.png（附带） | ch2-land-zh.mp4 | — | 17.18s / 14.45s |
| zh/ch2-2-4-segments-port-zh.png（附带） | ch2-port-zh.mp4 | — | 17.20s / 14.47s |

**亲验（抽看最危险的一张）**：`ru/ch2-2-4-segments-port-ru.png`（第四轮返工的核心——俄文竖版 2-4 曾排 5 行、底行被切）现为 3 行完整俄文字幕、无截断，round-4 修复成立。

## 2. 第 6 章横版新素材 §四.5 禁用词补扫
- 工具：`jobs/JOB-GP2/_scan-ch6-forbidden-gp2.mjs`（照裁决「每语只登录一次」改自 rec 原版：每语一个 context 只登录一次，land 扫完同页 setViewportSize→port 复跑，8 次登录→4 次）。扫描口径一字照原版（MASK @gmail→DEMO + HIDE .cloud-offer-unlock + BETA/NEG/REALMAIL in-frame）。
- **真病根（不是限流）**：登录账号本身是 gmail，原 MASK_INIT 作为 initScript 在登录前把邮箱框里的真 gmail 改成 DEMO → Supabase 返 Invalid credentials，表现得像卡登录/限流。修法：MASK/HIDE 改到登录解锁后再注入（见 D-GP2-1-2）。所以**无需等 30 分钟限流窗口**，一次跑通。
- **流程非空证实**：探针确认解锁后 viewReferredStudent(Bilal #4)→详情→openCloudAdmissionModal 真打开（body≈10052 字、hasAdmission=true），排除「模态没开=假 CLEAN」。
- **结果（4 语 × 2 视口，14:01）**：en/zh/ru/fr × land/port **全 CLEAN**，`SCAN_RESULT: ALL CLEAN`——beta/placeholder/test/内测/测试 0、负数金额 0、真邮箱 0。已写入 `~/mh-jobs/JOB-GP1-REVIEW-{en,zh,ru,fr}-shots.md` 末尾「第 6 章横版新素材 §四.5 复扫」一节。

## 账
- 决定：D-GP2-1-1、D-GP2-1-2（见 jobs/JOB-GP2/DECISIONS.md）。
- 未碰：线上 / R2 / Cloudflare / 主仓库推送 / 五端口代码 / DB 写。
- 工具落盘：主仓库 `jobs/JOB-GP2/_scan-ch6-forbidden-gp2.mjs`（本机留档，node_modules 为符号链不入 git）。
