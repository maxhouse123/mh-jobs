# JOB-GP1-04 回执 · 修正 + 中俄法（横版 + 竖版）

状态：**完成**（EN 自审代替停审 → ZH → RU → FR 全部录制+合成+对账）。
闸3（四语 × 两版 × 分段齐；四语对账 0 缺；真播 PASS；rebuild/复位断言全过）：**全过**。

## 完成口径（RULING-20261012-gp1 覆盖原 GP1-04 前提）
- 原前提「jobs/JOB-GP1/REVIEW-en.md 存在」被 RULING 改为「REVIEW-en-self.md 存在且九项全过」→ 第 15 趟已达成（见 JOB-GP1-REVIEW-en-self.md）。
- 修正表：EN 自审修正（1-1/3-1 引号标签等，D-15-2/3/4）已落；中俄法据英文重译、受影响镜重配音（ch5-2 退回理由等）。

## 四语产出（本机 ~/guide/dist/partner/，不入 git）
| 语言 | 十章横竖 | OP/ED | full 横竖 | trailer 横竖 | full 时长(land) | item-7 | item-8 QR |
|---|---|---|---|---|---|---|---|
| EN | 20 | 4 | 2 | 2 | 443s | PASS | ?src=video-en |
| ZH | 20 | 4 | 2 | 2 | 459s | PASS | ?src=video-zh |
| RU | 20 | 4 | 2 | 2 | 467s | PASS(74串0命中) | ?src=video-ru |
| FR | 20 | 4 | 2 | 2 | 460s | PASS(74串0命中) | ?src=video-fr |

- 分段：full en/zh/fr 各 26(13×2)、ru 28(14×2)；trailer 各 12(6×2)。四语对账 **0 缺**。
- 联络表：~/mh-jobs/shots/GP1/{en,zh,ru,fr}/ 各 20 张(en 21)，逐张亲验画面=字幕、脱敏。
- 真 Chrome 播放：四语 full/trailer/分段 land+port 全 readyState4、seek 近尾、pageErr=0。

## DB（照 §0.3/§0.4 + RULING §二.3）
- 每章 verify 16/16 → 置态 → 录横竖 → scoped 复位 → verify 16/16。置态章(ch3/4/6/7)用语言无关 scoped SQL（st-ch3-cleanup / st-pt04-* / st-pt06-reset / st-pt07-*·st-pt08-jw202 / st-pt0708-reset-cleanup）。
- 真写库镜（ch3 真 submit、ch4 submitted_at、ch6 unlocked_at、ch7 ¥0 真付）均录后复位，**全程 baseline 16/16 守住**；未跑全量 rebuild（本机脸库缺口，scoped 复位替代）。

决定账见 JOB-GP1-decisions.md（D-11~D-19）；逐趟细节见 JOB-GP1-03-PROGRESS.md。
