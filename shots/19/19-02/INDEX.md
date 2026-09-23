# JOB-19-02 截图 · 审核端 v44 未登记类型入册

元素级截图（真页面 serve 本地 + 真调渲染函数 studentDocRow, sb 全 stub 不连库）。无真实学生 PII（合成 DOC-studyProof/DOC-studyPlan 测试行）。

- `v43-title-RED.png` — 旧版 v43：材料行标题走 `_v43SafeType` 兜底，显示英文代号 `studyProof` / `studyPlan`（红）。
- `v44-title-GREEN.png` — 新版 v44：入册后标题显示正式中文名 `在读证明` / `学习计划`（绿）。

判定（脚本量出的可见文字，见 jobs/JOB-19-02/render-redgreen.json）：
- v43: studyProof→"studyProof"、studyPlan→"studyPlan"、null→"未知类型 / Unknown type"
- v44: studyProof→"在读证明"、studyPlan→"学习计划"、null→"未知类型 / Unknown type"（兜底不回归）

19-02 定案选甲：审核端无语言切换器、`currentLang` 恒 'zh'，入册只写 zh；闸3① 断言按 P3a 由 Claude 授权改写为「入册后标题=正式中文名」，不再要求 en/ru/fr 截图。
