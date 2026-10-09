# JOB-G7-00 · 摸底 + 先红（只读）

做的时间：2026-10-09。这一包只看、不改任何成片和产品代码；只在 `jobs/JOB-G7/` 下写了两份记录文件。

## 一句话结论
G-7 要修的毛病我全看见了、也都用真画面证实「现在确实是坏的」（先红）。两条流水线的工具和素材都在本机、都能接着用。下一步可以开 G7-01（学生线动手）。

---

## 1. 两条流水线的真实位置（都在、能用）
- 学生线录制：`jobs/JOB-G1b/rec-chapters.sh`（按章录）；每章脚本 `jobs/JOB-G1/rec/c01..c13.mjs`、片尾 `c14-end.mjs`；合成 `rec/assemble.mjs`、闸 `rec/gates.mjs`、叠字幕 `jobs/JOB-G1/overlays.mjs`、传桶改名 `jobs/JOB-G1/g6b-stage.mjs`。字幕底稿：`jobs/G1/captions-v2.json`。
- 学校线：`jobs/JOB-GS3/rec/`（`run-sch.mjs` 录、`assemble-sch.mjs` 合、`selfcheck-sch.mjs` 自检、`build-extras-sch.mjs` 出开场卡/全屏卡、`poster-thumbs-sch.mjs` 出海报缩略图）；录前状态 `jobs/JOB-GS3/states/st-base-sch.sh`；全片重建 `jobs/JOB-GS2/rebuild-school.sh`。
- 成片都在本机 `guide/dist/`：学生四语 `en/zh/ru/fr/` 各 c01–c13 + full/quick；学校 `school/zh/` c00-intro + c01–c14 + full/quick（还带着上一轮的 `-g6`、`-g6b` 新名版本）。
- 录制帧（每章一张张截图）都在：学生 `jobs/JOB-G1/rec/<语言>/cNN/frames/`，四语 c04/c07/c08/c10/c12 全有帧；学校 `jobs/JOB-GS3/rec/zh/cNN/frames/`，c01–c14 全有帧。**所以 c04/c08 只换字幕不必重录画面；c07/c10/c12 要重录是为了遮邮箱、12-10 走到 0 元。**

## 2. 当前版本号 / 构建串（改之前的底）
- 学校端现役 HTML：`maxhouse-school-portal-v245.html`；学生端现役：`maxhouse_student_portal_v411.html`（这两个产品端口本轮不碰）。
- 学生看片页构建串：`g6b-2026-10-09`（本轮要改成 `g7-2026-10-10`）。
- 学校看片页构建串：`gs6b-20261009`（本轮要改成 `gs7-20261010`）。

## 3. H2 真值：学校端「解锁前显不显示姓名」——三处都显示
写进了 `jobs/JOB-G7/name-visibility.md`（带代码行号）。白话：
- 匹配结果列表：显示「名 + 姓首字母」（像 John S.）。
- 候选池：显示全名。
- 学生档案：显示全名。
- 三处都没有「解锁前把姓名藏起来」这回事；打码只打联系方式（电话/微信/WhatsApp/邮箱）。

**据此定措辞（§2 的「显示」分支）**：
- 5-2 改成：`匹配结果显示学生编码、国籍、成绩与专业，联系方式要解锁后才看得到，护照号也打码——这是平台的双盲规则。`
- 14-3 第四条改成：`解锁后才见联系方式`。

## 4. H0 真学生隐私：有风险，录制层必须挡
- 库里 is_test 学生 50 名（测试名单）、**非 is_test 真学生 9 名**（命令实测）。
- 三个取学生的接口 `search_students_blind` / `match_task_candidates` / `get_task_candidates` **都不按 is_test 过滤**（pg_proc 实测，三个都不含 is_test）。意思是：演示学校去浏览/匹配/候选池，有可能把这 9 名真学生也捞出来显示。
- 所以 G7-03 录学校线第 5/6/7 章时，**录制层必须按名单把名单外的行从画面删掉**（§0.3）。50 人名单已存 `jobs/JOB-G7/roster-allowlist.json`（录制层用它当白名单；不在里头的学生行一律移除，并在回执报移除了几行）。

## 5. 先红（用真画面证实现在是坏的）
证据帧存在本机 `~/mh-verify/shots-local/G7/`（这些帧里有 gmail，按规矩**不进仓库、不进 ~/mh-jobs**）：
- **学生 c10 设置面板**：Email 行显示 `maxhouseapp+guide-…@gmail.com`（gmail，红）。→ `RED-student-c10-settings-email.jpg`
- **学生 c12 付款单**：Applicant 行 `maxhouseapp+guide-ref3@gmail.com`、Paid by 行 `maxhouseapp+guide-agent@gmail.com`（两个 gmail，红）；且总额停在 **¥3,000**（12-10 没走到 0 元，红）。→ `RED-student-c12-invoice-gmail.jpg`
- **学生 c07 付款单**：Applicant 行 `maxhouseapp+guide-stua@gmail.com`（gmail，红）。顺带发现：**c07 已经会把优惠码用到 ¥0**（画面是 ¥0.00、划掉 ¥3,000）——这正是 12-10 要照抄的做法。→ `RED-student-c07-invoice-gmail.jpg`
- **学生 c10 时长含 10-4~10-6**：c10 共 10-1..10-6 六镜；保留的 10-1~10-3 合计 14.12 秒，要砍的 10-4~10-6 合计 15.91 秒（10-4~10-6 是「接受 offer 后填补充信息表」那段，正是业主说的坏画面）。
- **学校 c14 审计弹窗三个数全是 0**：总下载次数 0 / 已发原件数 0 / 已标记异常 0，还写着「No download events recorded yet」（红）。→ `RED-school-c14-audit-zeros.jpg`

## 6. S5 俄/法界面语言：都已本地化（好消息）
真看了 ru、fr 的录制帧（c07 付款卡）：
- 俄文帧：界面全是俄文（「Оплатить и открыть」「ОСТАЛОСЬ 14 ДН.」等）。
- 法文帧：界面全是法文（「Payer et débloquer」「14 JOURS RESTANTS」等）。
- 结论：**俄/法界面不是英文，是真的俄文/法文**，没问题。证据 `~/mh-verify/shots-local/G7/S5-ru-ui.jpg`、`S5-fr-ui.jpg`（本地留）。

## 7. 顺手记下的字幕现状（给 G7-01 用）
- 4-10 现在：EN「…the more you upload, the more offers.」ZH「可选材料越多，机会越多。」→ 要换成 §2 定稿。
- 8-5 现在：EN 结尾有「— schools cannot tell you paid.」ZH 结尾有「，学校看不出你付过费。」→ 这截四语整个删掉。
- 第 10 章章名现在：EN「Supplementary form & students in China」ZH「录取后的补充信息表 + 在华学生专项」ru/fr 同为「补充信息表 + 在华学生」→ 砍掉「补充信息表」那半截，改成 EN「Students in China」/ 中「在华学生专项」/ ru「Студенты в Китае」/ fr「Étudiants en Chine」；页面 `guide/student/index.html` ch10 四语章名也要同步（现在页面显示的是「Students in China / 在华学生」，还差「专项」且需四语对齐）。

## 还差什么 / 下一步
- G7-00 完成。没有触发「必须停」的红线。
- 下一步 G7-01：改 `captions-v2.json`（4-10、8-5、ch10 章名，俄法翻+回译写回执）→ 四语重配这几句 → 录制层加「邮箱遮蔽 + 名单外移除」→ 重录 c07/c10/c12 四语（12-10 真到 ¥0）→ c04/c08 用现有帧重拼 → 跑闸。

## 闸的真实命令输出（摘）
- `students`：test 50 / real 9。
- `pg_proc` 三接口 mentions_is_test：全 f（都不过滤）。
- c10 shots：10-1=4.50s 10-2=4.90s 10-3=4.71s（保留合 14.12s）；10-4=5.31s 10-5=6.01s 10-6=4.60s（砍除合 15.91s）。
- 帧：学生四语 c04/c07/c08/c10/c12 全有 frames；学校 zh c01–c14 全有 frames。
