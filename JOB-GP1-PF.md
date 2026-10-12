# JOB-GP1-PF · 中介端工作台「录取漏斗 / 人均 offer」修复（partner v184 → v185）

业主裁决 **RULING-20261012d-funnel**（2026-10-12 选 A：先修产品，再录定版）。本回执＝裁决「二、闸」第 4 条要求的交付物。
第 27 趟（2026-10-12，Mac mini 无人值守）。

---

## 一句话（给看不懂代码的人）

合作伙伴（中介）工作台顶上那块「您的推荐业绩」里，**录取漏斗**（已提交 → 已发通知书 → 已付款 → 已录取）和下面那行**「累计收到 N 个 offer · 人均 X.X 个」**，之前对云端推荐生**一律显示 0**——明明学生卡上已经能看到有人拿了 offer、有人付了款、有人入学了，漏斗却全是 0，自相矛盾。这是中介端代码里一处算错。本次把它改对了：漏斗和 offer 数字改成**读学生卡本来就已经加载的真 offer 数据**来算。其它什么都没动。

---

## 二、病根（业主请示单二·2.1 已指出，这里复核落实）

`_getPartnerStats()` 云端推荐生分支（v184 原 L6074–6079）：

```js
if(stu._cloud){
  // S5-5: 云端推荐生无 admissions 数据 → 按 stage 律映射…
  const st = stu.status || stu.stage;          // ← stu.status = r.stage||'pending'；云端 students.stage 恒 NULL → 恒 'pending'
  if(st === 'admitted' || st === 'enrolled') stats.gotLetter++;   // 永不命中
  if(st === 'enrolled') stats.enrolled++;                          // 永不命中
  return;                                                          // ← 直接 return：totalOffers / paid 一次都没加
}
```

两个毛病：
1. 读的是**废弃列 `students.stage`**——全库 migration + 五端口 JS 对该列**零写入**，云端推荐生该列恒 NULL（真实阶段现算在 `student_global_stage()`）。`stu.status` 回落 `'pending'` → `gotLetter` / `enrolled` 永远加不上。
2. 这个分支**在计 offer / 付款之前就 return 了**，所以 `totalOffers`、`paid` 对云端生恒 0 → 漏斗「已付款」「人均 offer」全 0。

只读探针复核（`jobs/JOB-GP1/rec/_probe-rework-stats.sql`，E 节）：`students.stage` 列对 9 名演示推荐生全部 NULL，确证该列不被业务流维护。

> 注：`TOTAL PAYMENTS PROCESSED`（`stats.totalPaid`）与「Invested on this student」**按裁决 §一.3 不改**——它们统计真实过账金额，¥0 优惠码付款本来就是 ¥0，与「学生不交平台费」一致。本次一字未动，前后都显示 ¥0。

---

## 三、改法（裁决 §一.4 路径 a＝只改前端，第一条即行得通）

学生卡 / 事件流本来就已经把每个云端推荐生的**真 offer 数据**加载进了 `stu._offers`
（`_loadMyReferralsCloud` → `get_agent_student_offers` RPC，v184 原 L7312–7319，与卡面同源）。
所以**不新增迁移、不新发请求**，直接拿 `stu._offers` 按卡面同口径算：

| 漏斗 / 指标 | 字段依据（与卡面同源） | 卡面出处 |
|---|---|---|
| offer 份数 | `stu._offers.length` | 学生卡 offer 行 |
| 已发通知书 gotLetter | 该生任一 offer 有 `letter_uploaded_at` | `_v101CrossPortalEventsFor` / `_cloudOfferHero` |
| 已付款 paid | 该生任一 offer 有 `letter_paid_at` | 同上 |
| 已录取 enrolled | 该生任一 offer 有 `completed_at` | `_cloudOfferHero` NEXT STEPS 第 4 步「Enrollment」（原 L5234 `st=[…, !!o.completed_at]`） |
| 人均 offer | `totalOffers / submitted`，`toFixed(1)` | — |

`submitted`（已提交）本来就 = `state.referredStudents.length`，无需改。

### 改动的代码（diff，v184 → v185）

**① `_getPartnerStats` 云端分支**（原 L6074–6079 → 新实现）：

```js
    if(stu._cloud){
      // JOB-GP1-PF(v185 漏斗修复, 业主裁决 RULING-20261012d §一.2 · 路径 a=只改前端):
      //   旧代码读废弃列 students.stage(stu.status||stu.stage) 判漏斗 —— 云端推荐生该列恒 NULL(全库零写入,
      //   真实 stage 现算在 student_global_stage()), 且从不计 offer/付款 → 漏斗全 0、offer 恒 0、与卡面矛盾。
      //   改读页面已加载的真 offer 数据 stu._offers(get_agent_student_offers RPC, 与学生卡/事件流同源)。
      //   口径同卡面(_cloudOfferHero NEXT STEPS / _v101CrossPortalEventsFor):
      //     offer 份数 = offer 行数; 拿通知书 = 有 letter_uploaded_at; 已付 = 有 letter_paid_at;
      //     录取完成/已入学 = 有 completed_at(卡面「Enrollment」第 4 步同字段 L5234)。
      //   TOTAL PAYMENTS PROCESSED(totalPaid/paidAdmissions)不动 —— ¥0 优惠码付款本就 ¥0(裁决 §一.3)。
      const offs = Array.isArray(stu._offers) ? stu._offers : [];
      stats.totalOffers += offs.length;
      let cLetter = false, cPaid = false, cEnrolled = false;
      offs.forEach(function(o){
        if(o.letter_uploaded_at) cLetter = true;
        if(o.letter_paid_at)     cPaid = true;
        if(o.completed_at)       cEnrolled = true;
      });
      if(cLetter)   stats.gotLetter++;
      if(cPaid)     stats.paid++;
      if(cEnrolled) stats.enrolled++;
      return;
    }
```

**② 人均 offer 零学生兜底**（闸 3「学生为 0 时…人均显示 0.0」）：

```diff
-  stats.avgOffersPerStudent = stats.submitted > 0 ? (stats.totalOffers / stats.submitted).toFixed(1) : '0';
+  stats.avgOffersPerStudent = stats.submitted > 0 ? (stats.totalOffers / stats.submitted).toFixed(1) : '0.0';
```

**③ 版本串**（四件套②③）：`[VER] partner portal v184 → v185`（加本次修复说明）；`MH_PORTAL_VER = 184 → 185`。

> 以上即 v184 → v185 **全部** 代码差异（`diff` 实测仅这 4 处逻辑块，无其它改动）——所有界面/文案/样式/逻辑一字未动。

### 改了哪些文件
- `partner-portal/maxhouse-partner-portal-v185.html` （新建带版本号文件，自 v184 cp 后改上述 4 处）
- `partner-portal/index.html` （入口重定向 v184 → v185，共 4 处引用：location.replace / meta refresh / canonical / `<a>`）

> 四件套：①新文件名 v185 ✅ ②头注/[VER] 探针 ✅ ③`MH_PORTAL_VER=185` ✅ ④index.html 重定向 ✅。
> 不改学生端/学校端/管理端/审核端，不改首页（裁决 §一.1）。

---

## 四、闸（裁决「二」逐条）

### 闸 1 · 期望值（只读探针从 offer_decisions 算，Demo Agency 9 名云端推荐生）
`bash jobs/db-run.sh jobs/JOB-GP1/rec/_probe-rework-stats.sql`（只读）实测：

| 漏斗阶段 | 字段依据 | 实测期望值 |
|---|---|---|
| 已提交 submitted | 9 名云端推荐生 | **9** |
| 已发通知书 gotLetter | `letter_uploaded_at`（pt-07/08/09） | **3** |
| 已付款 paid | `letter_paid_at`（pt-08/09） | **2** |
| 已录取 enrolled | `completed_at`（pt-09） | **1** |
| offer 总数 | offer 行数（pt-06×2、07、08、09） | **5** |
| 人均 | 5 ÷ 9 = 0.56 | **0.6** |

与裁决给的估计值（9→3→2→1，offer 5，人均 0.6）完全一致。

### 闸 2 · v185 登录 guide_partner 四界面语言截图，漏斗 / offer 与期望值一致
本机 Playwright 真登录 guide_partner（走代理、真库），四语各读工作台并截图
（`jobs/JOB-GP1/rec/_probe-funnel-v185.mjs`，只读浏览）：

| 语言 | 漏斗（提交/通知书/付款/入学） | 转化率 | offer · 人均 | 结果 |
|---|---|---|---|---|
| EN | 9 / 3 / 2 / 1 | 33% / 67% / 50% | 5 · 0.6 | ✅ |
| ZH | 9 / 3 / 2 / 1 | 33% / 67% / 50% | 累计 5 · 人均 0.6 | ✅ |
| RU | 9 / 3 / 2 / 1 | 33% / 67% / 50% | 5 · 0.6 | ✅ |
| FR | 9 / 3 / 2 / 1 | 33% / 67% / 50% | 5 · 0.6 | ✅ |

截图：`shots/GP1/funnel/v185-funnel-{en,zh,ru,fr}.png`（面板为**聚合数字**，无任何学生 PII）。
> RU/FR 的「offer · 人均」那行显示英文——这是中介端对 ru/fr 无该键词典的**既有英文回退**（D-18-4 已记），非本次引入；**数字正确**，即裁决所要求的。漏斗 4 个标签（Submitted/已提交…）在各语言按现有词典本地化。

### 闸 3 · 回归
- **除漏斗与 offer 数字外，工作台其余文字与 v184 逐字一致**：
  `diff` v184↔v185 仅 4 处逻辑块（上 §三）；四语面板 DOM 文本把数字遮罩后比对，**标签/标题/模板串全部逐字相同**，唯一差异就是漏斗计数与转化率格（v184 前序为 0 时转化率显「—」，v185 显真实 %）——皆属漏斗本身，在改范围内。前后对比见 `shots/GP1/funnel/v184-funnel-*.png`（before：9/0/0/0、0 offers、avg 0.0）↔ `v185-funnel-*.png`（after：9/3/2/1、5 offers、avg 0.6）。
- **页面零报错**：唯一一条 console.error＝`Fetch API cannot load file:///…/partner-portal/index.html. URL scheme "file" is not supported`——这是**本机 `file://` 协议**下某启动期 fetch 的产物，**v184 完全相同地存在**（已对跑实证），非本次引入；线上 https 环境该 fetch 正常。除此之外零报错。
- **0 学生态无 NaN、人均 0.0**：只读内存检查（`_probe-funnel-zero.mjs`，临时把 `state.referredStudents=[]` 调 `_getPartnerStats`/`renderPartnerStatsPanel`，不写库）实测：`submitted=0, totalOffers=0, avg="0.0", gotLetter/paid/enrolled=0, anyNaN=false, panel=""`（0 生时面板整块返空串 L6112，不渲染，更无 NaN）。

### 闸 4 · 本回执即交付物（代码 diff + 前后截图 + 文件清单 + 期望值来源），齐。

---

## 五、DB / 推送

- **全程零 DB 写入**（探针只读 / 内存态临时置换不落库）。开工 verify **17/17 PASS 0 FAIL**，收工 verify **17/17 PASS 0 FAIL**。
- 主仓库：`git add` 点名 `partner-portal/maxhouse-partner-portal-v185.html`、`partner-portal/index.html`、`jobs/JOB-GP1`，提交说明以 `JOB-GP1-PF` 开头。**本机不推**（裁决 §二.5 / §三.2：Claude 审过后由业主用卡推送上线）。
- 下一步：写 `jobs/JOB-GP1/NEEDS_OWNER_DECISION.md`（标题「v185 漏斗修复已就绪，请 Claude 审核后由业主推送上线」），复制推 mh-jobs，本趟结束等审（停下情形④）。v185 上线、线上确认后循环重开，再做 review1 里被缺陷 2 卡住的定版重录部分。
