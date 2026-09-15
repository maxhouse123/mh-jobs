# JOB-13 · 学校层级链 —— 设计（必须停）
**结果：只做设计、不动代码。完整设计见 `jobs/JOB-13/design.md`。**
探针实锤两件事让原方案不成立：①`schools.tier` 实存 A/B/C/空（12 所 8 所空），与界面青铜/白银/黄金、与学校端 trial/standard/advanced/enterprise **三套词互不相干**；②`quota_requests` 只有 partner_id、没有 school_id，学校写不进提额。design.md 给了三套词映射（建议以四档为真值+空值回填 trial）、提额入库两方案（A 加列 / B 新表，建议 B）、管理端改层级写库 RPC、学校端名额联动。
## 等你拍板两个问题
1. 层级**统一用哪套词**？（建议底层 trial/standard/advanced/enterprise，界面映射中文；并确认旧 A/B/C 各对应哪档）
2. **每档给多少名额**？（现写死 试用5/标准20/高级100/旗舰500，沿用还是改）
