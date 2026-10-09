# JOB-G7-01 · 学生线：文案 + 遮蔽层 + 剪第 10 章（源级，**半成品**）

时间：2026-10-09（本趟做了源码改动，**还没重录视频**）。

## 这一趟真正改了什么（都在主仓库，已 commit 未 push）
1. **字幕底稿 `jobs/G1/captions-v2.json`**（§2 定稿）：
   - **4-10** 改成新句（见下）。
   - **8-5** 把「学校看不出你付过费」那截四语整个删掉，只留「付费曝光让你排前面，十/二十/三十天」。
   - **第 10 章章名** 改成「在华学生专项 / Students in China」，并**删掉 10-4、10-5、10-6 三镜**（补充信息表那段）。章现在只剩 10-1~10-3。
2. **录制骨架 `jobs/JOB-G1/rec/harness.mjs`** 加了两样（这是本轮的「邮箱遮蔽层」基础设施）：
   - **邮箱遮蔽**：每镜画面里形如 `maxhouseapp+别名@gmail.com` 的，自动换成演示邮箱（见映射）；任何残余 `*@gmail.com` 兜底成 `demo@example.com`。靠 MutationObserver + 每 250 毫秒扫一遍，应用每次重渲后仍被遮住。连输入框的值、占位符一起换。**画面里从此不会出现 gmail（含业主别名邮箱）。**
   - **gmail 审计**：录制全程每 500 毫秒扫一次画面里残余 gmail 个数，取峰值写进每章的 `domaudit.json`（`gmailMax`）。遮蔽生效的话这个数应当是 **0**——这就是「证明 0 个 gmail」的凭证。
3. **`jobs/JOB-G1/rec/c10.mjs`**：删掉 10-4~10-6 三镜的录制步骤，录到 10-3 就结束。
4. **随卡回归** `jobs/JOB-G7/test-email-mask.mjs`：遮蔽映射的单元测试，13 例**全过**（命令：`node jobs/JOB-G7/test-email-mask.mjs` → `ALL PASS (13 cases)`）。

## §2 文案定稿落地 + 俄法翻译与回译（业主可核）
**4-10**（可选材料）
- EN：`Optional documents raise your chances — the more complete your file, the easier it is for schools to assess you.`
- 中：`可选材料能提高机会——材料越全，学校越容易评估你。`
- RU：`Дополнительные документы повышают шансы — чем полнее ваше досье, тем легче вузам вас оценить.`
  - 回译：`可选材料提高机会——你的档案越完整，学校越容易评估你。`（与中文一致）
- FR：`Les documents facultatifs augmentent vos chances — plus votre dossier est complet, plus il est facile pour les écoles de vous évaluer.`
  - 回译：`可选材料增加你的机会——你的档案越完整，学校评估你就越容易。`（与中文一致）

**8-5**（付费曝光，只删不加）
- EN：`Exposure boost puts you first in the recommendation pool for ten, twenty or thirty days.`
- 中：`付费曝光让你在推荐池里排前面，十、二十或三十天。`
- RU：`Exposure boost выводит вас вперёд в рекомендациях на 10, 20 или 30 дней.`
  - 回译：`付费曝光把你推到推荐前面，10、20 或 30 天。`（删掉了「学校不知情」那截，与定稿一致）
- FR：`Exposure boost vous place en tête des recommandations 10, 20 ou 30 jours.`
  - 回译：`付费曝光把你放到推荐榜首，10、20 或 30 天。`（同上，已删）

**第 10 章章名**
- EN：`Students in China` ／ 中：`在华学生专项`
- RU：`Студенты в Китае`（回译：在中国的学生）
- FR：`Étudiants en Chine`（回译：在中国的学生）

## 邮箱遮蔽映射（§0.3）
stuA→lina.demo@example.com；stuB→omar.demo@example.com；agent→agent.demo@example.com；agentFresh→fresh.demo@example.com；ref1→ravi.demo@example.com；ref2→nour.demo@example.com；ref3→amal.demo@example.com；学校 sch2/sch3→office@demo-university.example；其它 gmail 兜底→demo@example.com。

## 还差什么（下一趟 G7-01 续做，都要真跑）
1. **重配音**这几句四语：4-10、8-5（第 10 章章名若有配音也要重配；章名卡多为渲染，先核对本机 `jobs/JOB-G1/audio/<lang>/` 有没有章名音轨）。用 `say`（Samantha/Tingting/Milena/Amélie），只配改了字的句子，其余复用。
2. **重渲字幕叠层**：新 4-10 句子较长，要确认叠层 ≤ 3 行（`overlays.mjs`，「超 3 行 = 0」闸）。
3. **重录 c07 / c10 / c12 × 四语**：`bash jobs/JOB-G1b/rec-chapters.sh <lang> 7 7`、`10 10`、`12 12`；c12 的 **12-10 要真输优惠码点 Apply 停在 ¥0**（照 c07 已有的做法，先红帧里已看到 c07 会走到 ¥0.00）。
4. **c04 / c08 用现有帧重拼**（四语都有帧，不必重录），带新字幕/配音。
5. **跑闸**：四语 c07/c10/c12 断言全过；每章 `domaudit.json` 的 `gmailMax == 0`；c10 新时长 ≈ 10-1~10-3 之和（约 14 秒 + 片头/片尾，先红实测 10-1=4.50 10-2=4.90 10-3=4.71）；`gates.mjs` 全闸过。
6. 证据裁切放 `shots/G7/student/`（c07 付款单 Applicant 行、c10 设置面板 Email 行、c12 两行 + 12-10 的 ¥0、c04/c08 新字幕帧）——注意这些帧遮蔽后应显示演示邮箱、无 gmail，可入仓。

## 为什么没一口气录完
重录 3 章 × 4 语 + 重拼 2 章 + 重配音是本包最耗时的部分（要真开浏览器跑付款/设置流程、每章还要前置状态 SQL），单趟 90 分钟放不下且无人值守录制有风险。本趟先把**安全、可逆、确定性**的源码改动做完并单测，recording 留下一趟按上面 6 步照做即可。源改动已 commit（未 push，主仓库推送由业主循环替做；但本包属半成品，**先不写 NEED_PUSH**，等 G7-01 录完或整条学生线齐了再上线）。

## 闸的真实命令输出（摘）
- `node jobs/JOB-G7/test-email-mask.mjs` → `ALL PASS (13 cases)`
- `node --check jobs/JOB-G1/rec/harness.mjs` → OK；`node --check jobs/JOB-G1/rec/c10.mjs` → OK
- captions 校验：ch10 title.en=`Students in China`，shots=`10-1,10-2,10-3`
