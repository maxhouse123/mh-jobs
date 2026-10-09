# JOB-G7-01c · 学生线续做：12-10 代付真到 ¥0 修好 + 四语 c07/c10/c12 全录完（仍半成品）

时间：2026-10-10 凌晨续跑。接上一份 JOB-G7-01b 的两个遗留（A：12-10 停在 ¥3,000 且印成 Amal；B：ru/zh/fr 没录）。
这趟把 12-10 的病彻底查清修好、顺手修了一个挡住俄文录制的登录 bug，四语的 c07/c10/c12 全部录完并逐项核过。主仓库已 commit（未 push，推送由业主循环替做）；**学生线还差 c04/c08 重拼 + 合全片 + 跑总闸，所以仍是半成品，没写 NEED_PUSH。**

## 一句话结论
业主最在意的「第 12 章代学生付款走到 0 元」现在真做到了：付款单金额 **¥0.00**（划掉 ¥3,000、MAXHOUSE 优惠码 −¥3,000），申请人是对的那个学生 **Nour**（不再错印成 Amal），画面里一个 gmail 都没有。英文和俄文两种语言我都亲眼看了成片帧确认。四种语言的第 7、10、12 章全录完，每章画面里都是 0 个 gmail，第 10 章坏画面（10-4~10-6）已剪短到 14~16 秒。

---

## 这趟真正做了什么

### 1. 查清 12-10「代付到 0 元」的真病根（先用真库证明后端没问题）
用 `jobs/db-run.sh` 只读查真库，证明**后端数据全是对的**：
- Nour（被荐生 ref2）名下就一份 offer：已接受(accepted)、有通知书(letter)、未解锁、优惠码核销 0 次。
- 代付接口 `get_agent_student_offers` 查 Nour 返回这份 accepted offer（查 Amal 返回一份 pending）。
- 优惠码预览 `coupon_preview('MAXHOUSE', Nour, 她的offer)` 当场返回**最终价 0 元**。
→ 所以病不在库、在**录制脚本 c12.mjs 的 12-10 这一镜**。

### 2. 修好 12-10 的三处竞态（都在 `jobs/JOB-G1/rec/c12.mjs`）
加了临时诊断把浏览器里的真实状态打出来定位，修完**诊断已全部删除**：
- **病①上下文残留**：12-9 开的是 Amal 的 offer，会把「当前 offer 指针」留在 Amal 身上。12-10 切到 Nour 时如果云端 offer 还没加载完，开窗函数会「静默早退」不改指针，付款就拿着 Amal 的旧指针走 → 显示 Amal。
  **修法**：开 Nour 之前先把指针清空，按邮箱重新定位 Nour，硬等到指针确认切到 Nour 名下那份 offer 才付款。
- **病②申请人印错**：付款单「Applicant（申请人）」那一行读的是另一个指针（viewingStudentIdx），它还停在 Amal 身上 → 结果 offer 是 Nour 的、申请人却印成 Amal。
  **修法**：开 Nour 时显式把这个指针也钉到 Nour。
- **病③优惠码 not_found（这是停 ¥3,000 的直接原因）**：开付款窗时后台会异步去拉「公示码/专属码」，拉回来会把弹窗重渲一遍，**把刚填进输入框的 MAXHOUSE 清空**；清空后点「应用」读到空串 → 报 not_found → 金额停在 ¥3,000。
  **修法**：开窗后等 1.5 秒让这些异步重渲先落定，再把「填码」和「点应用」放进同一步执行（中间不隔异步、躲开清空），外面再套最多 6 次重试，任一次到 ¥0 即停。

**英文实测**：12-10 付款单 TOTAL DUE **¥0.00**（划掉 ¥3,000.00 · MAXHOUSE −¥3,000.00）、Applicant=**nour.demo@example.com**、Application ID=MH-SGS69V、Admission=**SCH-8E561C**（都是 Nour 的）、Paid by=agent.demo@example.com、Partner Agent=PA-A2D3EB01、gmailMax=0、11/11 镜全过。
（提交号 a80ab69）

### 3. 修好一个挡住俄文录制的登录 bug（`jobs/JOB-G0/flows/login.mjs`）
录 ru/zh 时报「请输入邮箱和密码」登录失败（ru 每次必败、zh/fr 偶发、en 从不出错）。
**病根**：浏览器记住的界面语言（mh_lang，比如 ru）会在登录门第一次渲染后再重渲一次，把脚本刚填好的邮箱/密码**清空**；提交时就成了空表单。en 是默认语言不触发这次重渲，所以从没暴露。
**修法**：填完邮箱密码后等 250 毫秒给重渲一个窗口，校验两栏确实还留着值，被清空就重填，最多 5 轮，确认非空才点提交。这是**共享录制工具**，只加健壮性、不改任何断言或语义。
**实测**：c12 ru 由「两轮都败」→「一次过」。随后 c07/c10 的 ru/zh/fr 六次录制**全程零登录失败**。
（提交号 4082410）

### 4. 四语 c07/c10/c12 全部录完 + 逐项核过
所有录制产物（帧/音频/字幕）按 .gitignore 不入库。核验结果：
- **gmailMax 全 0**：en/zh/ru/fr 的 c07、c10、c12 共 12 份 domaudit.json，`gmailMax` 全部是 **0**（这是「画面里 0 个 gmail」的硬证据，符合 §0.3 要求）。
- **第 10 章剪短**：c10 时长 en=14.1s / zh=14.0s / ru=15.9s / fr=14.7s（原约 30 秒，10-4~10-6 三镜已剪掉）。
- **12-10 到 ¥0 跨语言确认**：英文、俄文两语的成片帧都亲眼看了——金额 ¥0.00、申请人 Nour、付款人 agent.demo、全 UI 对应语言、无 gmail。

## 主仓库这趟提交了什么（已 commit，未 push）
- `a80ab69` 改 `jobs/JOB-G1/rec/c12.mjs`（12-10 三处竞态修复）
- `4082410` 改 `jobs/JOB-G0/flows/login.mjs`（登录被语言重渲清空的健壮性修复）
- 都以 `JOB-G7-01` 开头；音频/字幕/帧不入库（本地构建产物）。

## 还差什么（下一趟接着做，都要真跑）
学生线剩下的是**合片 + 跑总闸**，不用再重录（帧都在）：
1. **S4 c04/c08 重拼**：4-10、8-5 的新配音+新字幕叠层 01b 已重做；c04/c08 四语的帧都在（已核在盘）。只需 `node jobs/JOB-G1/rec/assemble.mjs --lang <l> --chapter 4` 和 `--chapter 8`（四语）带新音频/字幕重合成。
2. **合全片**：四语 `assemble.mjs --lang <l> --all` 出 full/quick/海报（第 10 章短了、速览若含 10-4~10-6 要确认已去掉）。
3. **跑总闸**：`node jobs/JOB-G1/rec/gates.mjs`（四语断言全过）；四语片尾帧解码 == `https://www.maxhouses.net/`。
4. **证据裁切**：按 §G7-01 要求放 `shots/G7/student/`（c07 付款单 Applicant 行、c10 设置面板 Email 行、c12 两行+12-10 的 ¥0、c04/c08 新字幕帧）——遮蔽后都是演示邮箱、可入仓。
5. 以上齐了就是 **G7-02**：四语 `-g7` 新名传桶 + 改 `guide/student/index.html`（改了的章指 -g7、第 10 章四语章名、时长、构建串 `g7-2026-10-10`）。
6. 学生线整条齐了再考虑写 NEED_PUSH 上线（或与学校线 G7-03/04 一起上）。

## 没触发「必须停」的红线
- 没改五个产品端口 HTML（只读 student v411 源码是为了查 12-10 的函数链，未改一字）。
- 没动业主自用码；没删真实用户数据（只读真库 + 既有 reset-ref2-coupon 同模式授权）；没 push。

## 闸的真实命令输出（摘）
- 真库：Nour offer=accepted+letter、核销 0；`get_agent_student_offers` Nour=1(accepted)/Amal=1(pending)；`coupon_preview('MAXHOUSE',Nour,offer)` → `{"ok":true,"final":0,"discount":3000,...}`。
- `node --check` c12.mjs / login.mjs → OK。
- c12：en/zh/ru/fr 全 `shots=11 ok=11`，domaudit `gmailMax:0`。
- c07：en/zh/ru/fr 全 `shots=6 ok=6`，`gmailMax:0`。
- c10：en/zh/ru/fr 全 `shots=3 ok=3`，`gmailMax:0`，时长 14~16s。
- 登录修复后 c07/c10 六次录制零登录失败。
