# JOB-G7-02 · 学生线收尾：c04/c08 重拼 + 四语合全片 + 跑闸 + 传 -g7 公桶 + 改页面（学生线整条齐了，未上线）

时间：2026-10-10 续跑。接 JOB-G7-01c（四语 c07/c10/c12 已录完、12-10 到 ¥0、gmail=0）。
这趟把学生线剩下的活全干完了：c04/c08 带新字幕重拼、四语合全片、跑总闸、出证据、起 -g7 新名传公开桶、改页面。**学生线到此整条齐活**，但按规矩没写 NEED_PUSH——等学校线（G7-03/04）也齐了一起上线，少折腾一次部署。

## 一句话结论
学生端的教学视频：第 4 章口播改成「材料越全越容易被评估」、第 8 章删掉了「学校看不出你付过费」那半句、第 10 章坏画面（10-4~10-6）剪掉只剩 16 秒、画面里付款都走到 ¥0、一个 gmail 邮箱都没有。四种语言全部合成好，视频已传到服务器（新名字带 -g7，旧的一个没动），网页也改好指向新视频了。线上验证留到学校线也做完一起上。

## 这趟真正做了什么

### 1. c04 / c08 带新字幕重拼（四语）✅
- 4-10、8-5 的新配音 + 新字幕叠层是 01b 做的；这趟用现成帧 + 新音频/字幕重新合成。
- `assemble.mjs --lang <l> --chapter 4` / `8` 四语全过，音画偏差 Δ 都 ≤0.03 秒。
- 亲眼核过成片帧：
  - c04 第 4-10 句字幕 =「Optional documents raise your chances — the more complete your file, the easier it is for schools to assess you.」（§2 定稿，一字不差）
  - c08 第 8-5 句字幕 =「Exposure boost puts you first in the recommendation pool for ten, twenty or thirty days.」（已删「schools cannot tell you paid」那截，符合 §2）

### 2. 四语合全片 ✅
- `assemble.mjs --lang <l> --all` 四语全出：13 单章 + full + quick + 海报。
- 第 10 章新时长：en 16s / zh 16s / ru 18s / fr 17s（原约 34s，三坏镜已剪）。速览(quick)也重拼，不含 10-4~10-6。

### 3. 跑总闸 ✅（全过）
- `node jobs/JOB-G1/rec/gates.mjs`：**52 章全过、字幕检查 332 条 0 失败、音频起点对齐误差 ≤12ms、FAILS=(none) 全闸通过**。
- 四语 full 末帧二维码解码：**4 语全部 = `https://www.maxhouses.net/`**（片尾卡沿用 G-6）。

### 4. 证据帧（已遮蔽、入仓）✅ → `shots/G7/student/`
6 张，都亲眼看过、画面无 gmail：
- `c07-payment-zero-applicant_en.jpg`：付款单 **¥0.00**（划掉¥3,000·MAXHOUSE−¥3,000）、Applicant=**lina.demo@example.com**
- `c10-settings-email_en.jpg`：设置面板 Email=**omar.demo@example.com**
- `c12-agent-pay-zero_en.jpg`：代付单 **¥0.00**、Applicant=**nour.demo@example.com**、Paid by=**agent.demo@example.com**
- `c12-agent-receipt_en.jpg`：代付单另一帧（¥3,000 原价态，证明两行信息）
- `c04-newcaption_en.jpg` / `c08-newcaption_en.jpg`：两句新字幕烧录帧

### 5. 起 -g7 名 + 传公开桶（68 对象，只新增）✅
- 新脚本 `jobs/JOB-G1/g7-stage.mjs`（仿 g6b-stage.mjs）：把变了的章按 -g7 名摆进 /tmp/g7-stage，sharp 本地生成列表小图。变了的章 = **c04/c07/c08/c10/c12**，每语 5章×(视频+海报+小图)=15 + full-g7 + quick-g7 = **17 个 ×4 语 = 68**；最大小图 5016B ≤8192 合规。
- `bash jobs/r2-put.sh /tmp/g7-stage/<l>/ guide/student/v2/<l>/` 四语各 **17/17 OK**（模式=wrangler）。
- 线上 HEAD 抽验字节对得上：en/c10-g7=1085977、en/c12-g7=3810564、en/full-g7=29875101、zh/c04-g7=5204026、fr/thumbs/c10-g7=3468，**全部 http=200 且 content-length 与暂存一致**。旧 -g6b / 沿用章 c01-c03 对象**一个没动**。

### 6. 改页面 `guide/student/index.html` ✅
- 构建串 `g6b-2026-10-09` → **`g7-2026-10-10`**。
- 第 10 章章名四语同步改：EN **Students in China** / 中 **在华学生专项** / РУ **Студенты в Китае** / FR **Étudiants en Chine**（源自 captions-v2.json，与 §2 一致）。
- 时长更新：ch10 16/16/18/17、ch7 en37 zh61、ch12 en63 zh81 fr83；full 总时长 en550/zh716/ru685/fr658。
- OVERRIDE 映射：新增 ch4→c04-g7，改 ch7/8/10/12→-g7，**保留** ch5/6/9/11/13 的 -g6b 不动，full/quick→-g7（四语同改）。
- 自验：提取 D 对象 `JSON.parse` 通过；大小 **32534 字节（≤60KB）**；无外部 JS/CSS（唯一 http 链接是 hreflang SEO 的 alternate link）。

## 主仓库这趟提交了什么（已 commit，未 push）
- `ff2ad87 JOB-G7-02`：改 `guide/student/index.html`、新增 `jobs/JOB-G1/g7-stage.mjs` + 6 张 `shots/G7/student/*.jpg`。
- 成片/帧/音频/叠层仍按 .gitignore 不入库（本地构建产物，已传 R2）。

## 还差什么（下一趟）
- **G7-03 学校线**：H0~H8 重录重拼（c05/c06/c11/c12/c14 重录、c02 重拼、c00-intro 与 14-3 卡重渲、thumb-c14-g7）。这是本轮剩下的大头。
- **G7-04 学校线传私有桶 + manifest + 页面**（构建串 gs7-20261010）。
- **G7-05 上线真验收官**：学生线 + 学校线一起写 NEED_PUSH 上线，线上真验。

## 没触发「必须停」的红线
- 没改五个产品端口 HTML（只读页面模板改的是 guide/student/index.html 教学页，非产品端口）。
- 没动业主自用码；R2 只新增 -g7、零删除零覆盖；没 push。

## 闸的真实命令输出（摘）
- `assemble --chapter 4/8` 四语：Δ≤0.03s，shots 12/6。
- `assemble --all` 四语：c10 shots=3 时长 16~18s；full parts=14；quick clips=25。
- `gates.mjs`：chapters=52、subtitle checked=332 failed=0、audioOnset errMs≤12、**FAILS=(none) 全闸通过**。
- 片尾解码：en/zh/ru/fr 全 `"https://www.maxhouses.net/"`。
- `r2-put.sh` 四语各 `完成: 17/17 OK`；线上 HEAD http=200 字节一致。
- 页面：`JSON parse OK`、32534 字节、BUILD=g7-2026-10-10。
