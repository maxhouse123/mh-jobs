# JOB-G8-00b · 体检先红（只读）— 第 2 趟（接着第 1 趟做）

日期 2026-10-10　机器 Mac mini　本趟代号 G8-00（第 2 趟续做）

## 一句话
第 1 趟把「不费时」的摸底做完了（付款单旧名、三接口、CF 现状、缓存命中、测速工具）。本趟把 **3 个有界的摸底项做完了**：①媒体文件规格（含 §1.2 两问的答案）、②脸摸底（三人身份 + 出现在哪些章）、③第 10 章组件坏排版的定位。还把测速脚本改快、写好了可续跑的矩阵跑批器。**还差 2 项**：完整测速矩阵（专门留下一趟跑，脚本已就绪）、清理摸底（列桶 + 算未引用集，留下一趟）。下面逐条大白话。

---

## 本趟做完的（真数据）

### 1) 媒体文件规格（§0.3 / §1.2）— 已存 `jobs/JOB-G8/media-specs-before.json`，复制到 `~/mh-jobs/JOB-G8-00-media-specs-before.json`
用脚本 `jobs/JOB-G8/media-specs.mjs`（curl Range 解 atom + ffprobe）把学生公开桶 4 语 ×（13 章 + full + quick）= **60 个对象**全量体检。

**§1.2 问②「哪些文件 moov 不在头」**：**一个都没有，60 个对象 moov 全在头**（与 GS-5 记录一致，复核通过，绿）。

**§1.2 问①「整片 / 速览的 moov 多大、按 400 kbps 要几秒出第一帧」**：
| 对象 | 字节 | 时长 | moov 大小 | 400kbps 出首帧要下 |
|---|---|---|---|---|
| full-g7b en | 30.2MB | 552s | 586KB | **12.0 秒** |
| full-g7b zh | 32.2MB | 718s | 762KB | **15.6 秒** |
| full-g7b ru | 33.7MB | 687s | 729KB | **14.9 秒** |
| full-g7b fr | 34.0MB | 660s | 701KB | **14.4 秒** |
| quick-g7 en | 8.2MB | 153s | 164KB | 3.4 秒 |
| quick-g7 zh | 8.8MB | 197s | 211KB | 4.3 秒 |
| quick-g7 ru | 9.6MB | 196s | 210KB | 4.3 秒 |
| quick-g7 fr | 8.8MB | 184s | 197KB | 4.0 秒 |
| c01（章1）4语 | 1.3MB | 27-32s | 30-35KB | 0.6-0.7 秒 |

- **真痛点坐实**：整片 full 光是 moov（视频索引表）就 586–762KB，弱网（400kbps）下**要 12–16 秒才出第一帧**。速览 3.4–4.3 秒。单章 ch1 没问题（0.6–0.7 秒）。
- 规格补充：所有对象 1080×1920 竖屏、30fps、平均码率 353–437kbps、音频 aac/44100/单声道。→ 这也说明**整片分辨率是 1080p、弱网下解码也重**，G8-04 的流畅版降到 540×960 + ≤350kbps 会显著改善。

### 2) 脸摸底（§1.4 第 4 条）
- **两名 near_group 测试生**（当前脸是 D 组深肤色顶 C 组缺口，**必须换**）：
  - Ghana（加纳）：学生 id `f4b31dbd-bc3b-4a70-b7dd-4a85c4b5bbe1`，faces-map-v2 nnn=046。
  - Equatorial Guinea（赤道几内亚）：学生 id `fca5edfc-418b-4fa7-a940-333d12a64c09`，nnn=049。
- **Chidi**（尼日利亚演示生）：在 faces-map-v2 里是 nnn=050、key=`guide-sch-03`（邮箱别名，不是 uuid；原 `_castjoin.json` 里那个 ffac… uuid 在 students 表里已查不到，G6b 重建后 id 变了，以 guide-sch-03 为准）。当前脸**已经是 C 组**但年龄 31-35 岁，note 标「Chidi校7 C-M」。→ 按业主「拿不准就不换 Chidi」，**除非下趟抓脸抓到明显 18-26 岁的 C-M 才顺带换**。
- **三人出现在哪些章画面里**（用录制 DOM 快照 + DB 池探针 `jobs/JOB-G8/probe-faces-chapters.sql` 查出）：
  - **学生线：三人都不出现。** 学生线画面里的头像只有登录者自己（顶栏 `#appIdAvatar`，即主角 Lina），不显示别的学生。（依据 `chapters-with-avatars-student.json`：学生线有头像的章显示的全是自己的头像。）
  - **学校线**（两名 near_group 测试生）：DB 探针确认两人都 is_test、都已提交资料（会进「浏览池 c06 / 一键匹配 c05」）、都在 `task_candidates`（会进「任务候选池 c07 / 学生详情 c08 / 发 offer 行 c10」）、都在 `offer_decisions`（会进「已录取 c12 / 备案 c13」）。→ **学校线凡显示学生头像的章都可能有这两张脸：c05 / c06 / c07 / c08 / c10 / c12 / c13**（依据 `chapters-with-avatars-school.json`）。
  - **学校线**（Chidi）：note 标「校7」，是学校自己的演示生，走候选→详情管道 → **c07 / c08**（若换脸才需重录）。
  - ⚠ 学校线录制的 DOM 快照（`jobs/JOB-GS3/rec/zh/*/domaudit-sch.json`）只记了「被移除的真学生 id」(rosterRemovedIds)、没逐个记屏上显示的学生；三人都不在移除名单（= 有资格显示）。**精确到「哪一帧真显示了这张脸」要在 G8-03 重录时逐章驱动页面肉眼/抽帧确认**——真显示了才重录，没显示的不白录。
- **G8-03 重录学校章的预判**：两名 near_group 换脸 → 重录学校线 **c05 c06 c07 c08 c10 c12 c13 中实际显示它们的章**；Chidi 若换 → 加 **c07 c08**。

### 3) 第 10 章「补充信息表」组件坏排版定位（§1.4 第 3 条 / §3.3）
- 组件 = `assets/mh-filing-form-v1-6.js`（零依赖、自注入 `.mhff-` 样式），学生现役页 = `student-portal/maxhouse_student_portal_v411.html` 引用它。
- 用 Playwright **只开本地 file://、断掉一切外部请求**（守铁律11，绝不碰生产/连库），三种配置各截图（存 `~/mh-jobs/shots/G8/`）：
  1. **组件独立 harness**（`ch10-harness.html`）：标题 183px **横排**、字段可见、表头 84px → **正常**。
  2. **真 v411 页（未登录，带 `body.gate-locked`）**：overlay `display:none`、标题/表头全塌成 0px → 这是**未登录访问码闸把它藏了的假象，不是真 bug**。
  3. **真 v411 页（去掉 gate-locked 后）**：overlay 满屏、表头 86px、标题 390 宽 183px / 1366 宽 653px **横排**、字段可见 → **也正常**。
- **结论**：**当前 v1-6 组件在离线三种配置里都没有「标题竖排、字段看不见」的坏排版**（唯一塌陷是「未登录闸」的 display:none 假象）。真 bug 离线复现不出来，两种可能：(a) 需 live `guide_stuA` 带真数据 / 真录取上下文才触发（§1.4 本就要求 live 截图，这步需登录会话，**留下一趟**）；(b) 坏排版是**早期组件版本**（v1.1 起到 v1.6 改过 6 轮）时录的旧 ch10 视频里的，**当前组件可能已修好**，那样 §3.3 就只剩「重录 ch10」没有「改组件」。
- **下一步**：G8-02 做 §3.3 前，先用 live `guide_stuA` 开真·录取后补充信息表确认当前到底正不正常：正常 → §3.3 只需重录（§0.6 不触发）；不正常 → 按真 bug 在组件内修。本趟已给出三组离线基准图作对照。

### 4) 测速工具改进（为下趟矩阵铺路）
- **问题**：原 `measure.mjs` 对每个到 `playing` 的格子都无条件空等 60 秒，全矩阵（3 语言线 ×14 格 ×3 次）要 ~140 分钟，单趟做不完。
- **改法**：加 `--stall <秒>` 参数——纯测 TTFF 的格子传 `--stall 0`（拿到首帧即结束，3 秒返回，实测验证），测卡顿的格子传 `--stall 60`。**speed-before.json 还没产出过**（第 1 趟只跑过 1 格冒烟没存档），所以现在改脚本不违反「前后同脚本」：before/after 两次都用这份改后的脚本、对同一格传同一 `--stall` 值即可，口径一致。
- 新写 `jobs/JOB-G8/run-matrix.mjs`：按 §0.3 全矩阵（每 lang-line 14 格，标注每格 stall 值）逐格调 measure.mjs、`--runs 3` 取中位，**每格落盘、已完成的跳过**→ 单趟被 90 分钟掐断也能下趟接着跑。

---

## 闸的真实命令输出（节选）
- `node jobs/JOB-G8/media-specs.mjs` → 60 对象全 `moovInHead=true`；full moov 586-762KB、@400k 首帧 12-15.6s。
- `bash jobs/db-run.sh jobs/JOB-G8/probe-faces-chapters.sql` → Ghana/EqGuinea 均 is_test、submitted_at 有、task_candidates 各 1 行、offer_decisions 各 1 行；Chidi 原 ffac uuid 在 students 表 0 行（id 已变，改用 guide-sch-03）。
- `node jobs/JOB-G8/ch10-probe3.mjs`（去 gate 后）→ 390: title 183×27 横排 / 1366: title 653×27 横排，字段可见 → 组件离线正常。
- `node jobs/JOB-G8/measure.mjs … --stall 0 --runs 1` → 3 秒返回（原 60s+），TTFF 665ms。

---

## 先红表更新（本趟确认项）
| 项 | 实测 | 判 |
|---|---|---|
| 媒体 moov 不在头 | 60/60 全在头 | **绿**（复核过） |
| 整片首帧前字节大 | full moov 586-762KB、@400k **12-16s** | 🔴 **真痛点坐实** |
| 速览首帧前字节 | quick moov 164-211KB、@400k 3.4-4.3s | 🟡 偏慢 |
| 单章 ch1 首帧 | 30-35KB、@400k 0.6-0.7s | 绿 |
| near_group=2 | Ghana + EqGuinea，脸是 D 组需换 | 🔴 成立 |
| ch10 坏排版 | 离线三配置组件均正常（唯一塌陷=未登录闸假象）；真 bug 离线复现不出 | ⚠ 待 live guide_stuA 确认 |
| 慢3G 速览 TTFF ≫6s | 下趟矩阵测 | 待测 |
| 未引用对象 >0 | 下趟清理摸底 | 待测 |

---

## 还差什么 + 下一步
**仍属 G8-00 未完成（下一趟做）：**
1. **完整测速矩阵**（§0.3）：`NODE_PATH=~/mh-verify/node_modules node jobs/JOB-G8/run-matrix.mjs`（可续跑，结果进 `jobs/JOB-G8/speed-before.json`）。估 ~80-90 分钟，**建议单趟专跑**，被掐断下趟接着跑。先校学校线的 ch1/full/quick 选择器（measure.mjs 的 `#chList/#btnFull/#btnQuick` 在学校页是否同名）。
2. **清理摸底**（§1.4 第 5 条，只列不删）：列公开桶 `guide/student/v2/`、私有桶 `guide/school/v1/zh/`、Supabase `student-documents` 下 50 名 is_test 学生 `photo/`；对照线上学生页 HTML 的 mp4/webp 引用 + 学校 manifest，算未引用集数量与字节。（需 R2 list 能力，确认 `~/mh-verify/g6-wrangler` 的 wrangler 能 `r2 object list`。）
3. **ch10 live 确认**：live `guide_stuA` 开真补充信息表，确认当前组件在真数据下正不正常（决定 §3.3 是改组件还是只重录）。
4. 跑完矩阵后把 `speed-before.json` 复制到 `~/mh-jobs/JOB-G8-00-speed-before.json`。

**本趟写入主仓库（仅 commit 不 push）**：`jobs/JOB-G8/` 下 `media-specs.mjs`、`media-specs-before.json`、`probe-faces-chapters.sql`、`ch10-harness.html`、`ch10-shot.mjs`、`ch10-shot-real.mjs`、`ch10-probe2.mjs`、`ch10-probe3.mjs`、`run-matrix.mjs`，及改后的 `measure.mjs`。
**无「必须停」触发**：媒体规格无异常、脸三人定位清楚、ch10 组件离线正常（留 live 确认，不是停工条件）。
