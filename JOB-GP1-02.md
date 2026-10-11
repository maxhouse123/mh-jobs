# JOB-GP1-02 回执 —— 字幕底稿 + 四语配音（**完成 · 闸3 全过**）

日期 2026-10-11｜Mac mini 无人值守（接 GP1-00 / GP1-01 之后同一轮续跑）｜本趟把 GP1-02 一口气做完：四语字幕底稿 captions-v1 + 四语配音 236 条音频 + 时长表 + 俄法压短清单。

## 一句话（给业主）
把视频里每一句话的**字幕和配音**都备好了。字幕分四种语言：英文和中文是从分镜脚本**一字不改**抄来的，俄文和法文由我从英文译出、再回译自检（金额、按钮名、学校/表单名这些**一个都没丢**）。配音用 Mac 自带的四个真人声音（英 Samantha / 中 婷婷 / 俄 Milena / 法 Amélie）逐句念出来，一共 **236 条**（59 句 × 4 语），音量都归一化到统一响度，长短都在正常范围。有三个纯动作镜头（点按钮那种）本来就没有旁白，所以不配音。下一步（GP1-03）就是把这些字幕和配音合到英文画面上，录成整片后停下来等你看。

---

## 闸3 对账（§2 GP1-02 判据）
| 判据 | 结果 | 证据 |
|---|---|---|
| 四语镜数相等 | ✅ 每语 **59** 条 | en/zh/ru/fr 各 59 个 m4a + durations.json |
| 每镜有音频 | ✅ 四语 durations.json **各覆盖同一 59 个镜 id、无缺无多** | 脚本校验 `all-4-cover-59-ids-exactly: true`；ffprobe 抽检 aac/mono 正常 |
| 回执附俄法压短清单 | ✅ **10 条**（ru 5 + fr 5） | 见下「俄法压短清单」+ captions-v1.json `compress[]` |

补充自检：
- **字幕完整性**：captions-v1.json 59 镜 × 4 语 = 236 单元格 **零空缺**（`missing-cells=0`）。
- **回译/专名保留**：金额 `¥0`、`JW202`、`MAXHOUSE`、`MH-`、`SCH-`、`Demo University` 在 EN 出现处，RU/FR **逐一保留**（`token-preservation-issues=0`）。`¥0` 见 OP-4/6-5；`JW202` 见 OP-5/7-2。
- **音频响度/时长**：loudnorm I=-16:TP=-1.5，全部 in-range（判据 0.6–24s，无越界）；极短句补尾静音到 ~1.05s（同 G1 做法）。

## 镜数与覆盖
- 旁白镜 **59**（62 镜表 − 3 个纯动作静默镜 `1-2`/`1-4`/`6-4`，这三镜 shots-v1.json capEN=null，不出音、不计入四语对账）。
- captions-v1.json 结构：`keypoints[4]`（四条重点 EN/中/RU/FR）+ `compress[10]`（俄法压短）+ `shots[59]`（每镜 id/ch/en/zh/ru/fr）。

## 四语配音时长表（秒；来源 voice/<lang>/durations.json）
| 镜 | en | zh | ru | fr |  | 镜 | en | zh | ru | fr |
|---|---|---|---|---|---|---|---|---|---|---|
| OP-1 | 1.9 | 3.4 | 2.4 | 2.0 | | 5-1 | 2.6 | 3.5 | 2.9 | 2.6 |
| OP-2 | 9.9 | 9.0 | 11.5 | 10.6 | | 5-2 | 3.3 | 3.8 | 4.2 | 3.7 |
| OP-3 | 15.1 | 15.5 | 15.0 | 14.9 | | 5-3 | 1.6 | 2.0 | 1.8 | 1.8 |
| OP-4 | 8.6 | 8.6 | 10.0 | 8.8 | | 5-4 | 3.5 | 2.9 | 3.7 | 3.4 |
| OP-5 | 14.0 | 17.5 | 15.5 | 14.7 | | 6-1 | 2.1 | 2.7 | 2.2 | 2.3 |
| OP-6 | 2.2 | 2.1 | 2.2 | 2.0 | | 6-2 | 6.9 | 7.3 | 7.6 | 6.9 |
| 1-1 | 4.0 | 4.6 | 6.3 | 4.8 | | 6-3 | 2.3 | 2.9 | 3.3 | 2.7 |
| 1-3 | 4.1 | 4.2 | 4.2 | 4.3 | | 6-5 | 5.2 | 5.4 | 5.3 | 4.9 |
| 1-5 | 5.4 | 5.7 | 6.1 | 4.9 | | 6-6 | 1.5 | 1.1 | 1.8 | 1.4 |
| 1-6 | 2.6 | 3.4 | 4.4 | 4.4 | | 6-7 | 3.2 | 3.6 | 3.2 | 3.4 |
| 1-7 | 3.8 | 3.9 | 5.1 | 3.7 | | 7-1 | 3.4 | 3.9 | 4.3 | 3.6 |
| 1-8 | 2.5 | 2.9 | 2.8 | 3.1 | | 7-2 | 2.9 | 3.1 | 3.3 | 3.2 |
| 2-1 | 3.7 | 3.7 | 4.8 | 4.4 | | 7-3 | 4.5 | 4.0 | 4.1 | 4.8 |
| 2-2 | 2.6 | 3.2 | 3.5 | 3.5 | | 7-4 | 1.2 | 1.6 | 1.6 | 1.5 |
| 2-3 | 2.5 | 3.4 | 3.2 | 2.4 | | 8-1 | 1.7 | 1.3 | 1.9 | 1.7 |
| 2-4 | 5.0 | 5.5 | 5.9 | 5.0 | | 8-2 | 1.4 | 1.7 | 2.3 | 2.0 |
| 2-5 | 3.2 | 2.7 | 3.8 | 3.1 | | 8-3 | 4.6 | 3.8 | 5.8 | 4.8 |
| 3-1 | 1.4 | 2.0 | 3.2 | 1.9 | | 8-4 | 2.6 | 2.4 | 3.4 | 2.8 |
| 3-2 | 4.7 | 6.3 | 6.3 | 5.3 | | 9-1 | 2.6 | 2.9 | 2.4 | 3.2 |
| 3-3 | 4.1 | 3.5 | 3.7 | 4.2 | | 9-2 | 2.7 | 2.8 | 3.8 | 3.5 |
| 3-4 | 2.2 | 2.1 | 2.4 | 2.4 | | 9-3 | 2.3 | 2.4 | 3.6 | 2.7 |
| 3-5 | 4.4 | 4.2 | 4.7 | 4.9 | | 9-4 | 4.8 | 4.5 | 5.7 | 5.6 |
| 3-6 | 3.5 | 3.6 | 4.1 | 4.4 | | 10-1 | 2.6 | 3.3 | 3.5 | 2.7 |
| 3-7 | 2.8 | 3.0 | 3.6 | 3.7 | | 10-2 | 1.8 | 1.8 | 3.2 | 2.3 |
| 3-8 | 3.5 | 3.5 | 3.7 | 3.6 | | 10-3 | 1.6 | 1.5 | 1.7 | 1.6 |
| 3-9 | 2.0 | 3.3 | 2.4 | 2.5 | | 10-4 | 1.8 | 2.0 | 3.1 | 2.4 |
| 4-1 | 3.4 | 3.8 | 3.9 | 3.5 | | ED-1 | 8.5 | 8.7 | 8.5 | 9.0 |
| 4-2 | 3.3 | 3.8 | 3.7 | 3.4 | | ED-2 | 3.5 | 2.9 | 5.2 | 3.9 |
| 4-3 | 1.5 | 2.8 | 2.6 | 1.5 | | 4-4 | 3.4 | 2.9 | 4.5 | 3.7 |
| 4-5 | 3.8 | 3.9 | 3.8 | 3.3 | |  |  |  |  |  |

**纯旁白总时长**（不含画面定格/快剪/叠层停留）：en **3.7min** / zh **4.0min** / ru **4.4min** / fr **4.0min**。
（整片目标 9～11min：旁白外还有开场四条重点卡定格、¥0 停 2s、章节条转场等视觉停留，GP1-03 合成时补足；纯旁白最长集中在 OP-2/3/4/5、ED-1 四条重点卡，属叠层卡长文案而非字幕带。）

## 俄法压短清单（§2 判据·超 3 行 48px 竖版字幕带的 ru/fr 句，烧入用 short，音频用 full）
> 口径：keypoints（OP-2/OP-3/OP-5、ED-1）是**叠层重点卡的长文案**、不走字幕带，不受 3 行限，不压短；以下只列**章内字幕带**镜中偏长的 ru/fr 句。GP1-03 竖版烧入用 short，横版与音频仍用 full。

| 镜 | 语 | full（完整·用于配音/横版） | short（压短·竖版字幕带烧入） |
|---|---|---|---|
| 3-5 | ru | ИИ-предпроверка выявляет проблемы ещё до того, как вуз увидит документ. | ИИ находит проблемы до того, как вуз увидит документ. |
| 3-5 | fr | La prévérification par IA signale les problèmes avant même qu'une université ne voie le dossier. | L'IA repère les problèmes avant que l'université ne voie le dossier. |
| 6-2 | ru | До разблокировки вы видите специальность, стоимость обучения и стипендию — указанные самим вузом — но не его название. | До разблокировки видны специальность, стоимость и стипендия — но не название вуза. |
| 6-2 | fr | Avant le déblocage, vous voyez le programme, les frais et la bourse — saisis par l'université elle-même — mais pas son nom. | Avant déblocage : programme, frais et bourse — écrits par l'université — mais pas son nom. |
| 7-3 | ru | Платформа сама заносит студента в систему регистрации вуза за вас. | Платформа сама заносит студента в систему вуза. |
| 7-3 | fr | La plateforme inscrit l'étudiant dans le système d'inscription de l'université à votre place. | La plateforme inscrit l'étudiant dans le système de l'université pour vous. |
| 8-3 | ru | Укажите, сколько ещё студентов вы ожидаете; мы рассмотрим запрос за два рабочих дня. | Укажите число студентов; ответ за два рабочих дня. |
| 8-3 | fr | Indiquez combien d'étudiants supplémentaires vous prévoyez ; nous l'examinons sous deux jours ouvrés. | Indiquez le nombre d'étudiants prévus ; réponse sous deux jours ouvrés. |
| 9-4 | ru | и платное продвижение, которое помещает студента в списки кандидатов большего числа вузов. | и платное продвижение — студент попадает в списки большего числа вузов. |
| 9-4 | fr | et une mise en avant payante, qui place l'étudiant dans les viviers de candidats de davantage d'universités. | et la mise en avant payante, qui place l'étudiant dans plus de viviers de candidats. |

## 怎么做的（技术账）
- **字幕**：`jobs/JOB-GP1/captions-v1.json`。EN/中 直接取 shots-v1.json 的 `capEN`/`capZH`（一字不改）；RU/FR 由 CC 从 EN 译，口语自然、保留金额/按钮引号/专名前缀；`glossary_keep_as_is` 固定不译词表写入 `_meta`。
- **配音**：`jobs/JOB-GP1/rec/tts-gp1.mjs`（照 `jobs/JOB-G1/tts.mjs` 做法，仅 import 其 `bin.mjs` 解析 ffmpeg，未改 G1 原文件）。流程 `say -v<voice> -r155 -f txt → aiff → ffmpeg loudnorm=I=-16:TP=-1.5:LRA=11 → aac 64k mono 44.1k`；并发 4；每语写 `voice/<lang>/durations.json`（按镜 id 键，供 GP1-03 harness 读真时长对齐字幕窗）。
- **四语音色就位实测**：`say -v '?'` → Samantha(en_US) / Tingting(zh_CN) / Milena(ru_RU) / Amélie(fr_CA) 全在。

## 产物与合规
- **主仓库 `jobs/JOB-GP1/`（点名提交 518f8ec，本轮不推主仓库）**：`captions-v1.json` + `rec/tts-gp1.mjs` + `rec/.gitignore`（新增忽略 `voice/`）。
- **不入 git**：`rec/voice/<lang>/*.m4a`（236 条音频）+ `voice/<lang>/durations.json`（node 可重出，已 .gitignore）。
- **`~/mh-jobs/`**：本回执 + `JOB-GP1-captions-v1.json`（字幕底稿副本）。
- **合规**：DB 本轮**零访问**（纯字幕/配音）；未改五端 HTML/JS/迁移；未碰 JOB-G*/JOB-GS*/JOB-GP0 原文件（仅 import G1/bin.mjs）；未碰 R2/CF；未起后台任务；只用本机 `say`、无在线 TTS；别的线（G8/G9/GP0）改动未碰未提交；states/*.gen.sql（GP1-01 的 node 生成件）保持未跟踪、未提交。

## 下一包 GP1-03（英文全片 → 停 WAIT_REVIEW）要点
按 shots-v1 录英文横/竖两版（开场+1~10章+片尾）；每章录前跑状态脚本、录后复位；第 1 章用注册演示号；画面层打码（演示生邮箱→firstname.demo@example.com、邀请码框、付款方式按钮遮蔽）。
**录前两个前置（GP1-01 回执已点明）**：① SPECIMEN 上桶（admission-letter / jw202-form / demo-agency-licence / demo-officer-passport，桶内 specimen/ 当前空，ch7 下载前需上桶）；② ch3 MRZ 合成护照（OCR 不触发则照 storyboard 预授权改静态高亮提示区并记因）。
录完写 JOB-GP1-03.md + SUMMARY-GP1-A.md（REVIEW=yes），写 ~/mh-verify/rGP1-STOP.txt=WAIT_REVIEW 停审。
