# JOB-13 · 学校层级链 —— 设计（必须停，不动代码）

这条链四个环节全断，而且探针查出两件事让原方案不成立：

- **库里 `schools.tier` 存的是 `A=1 / B=2 / C=1 / 空=8`** —— 既不是管理端界面显示的**青铜/白银/黄金**，也不是学校端配额表认的 **trial/standard/advanced/enterprise**。三套词互不相干，且 12 所里 8 所是空的。
- **`quota_requests` 表只有 `partner_id`，没有 `school_id`** —— 学校在结构上就写不进提额申请。

## 1. 三套词的映射方案（含 8 所空值回填）

现状三套词：
| 场景 | 词表 |
|---|---|
| 库 `schools.tier` 实存 | `A` / `B` / `C` / 空（12 所里 A=1、B=2、C=1、空=8）|
| 管理端界面显示 | 青铜 Bronze / 白银 Silver / 黄金 Gold |
| 学校端配额表认 | trial / standard / advanced / enterprise（试用/标准/高级/旗舰）|

**建议：以「学校端四档 trial/standard/advanced/enterprise」为唯一真值**（因为它直接决定名额，是业务后果所在），另两套只是显示皮：
- 库存值统一迁移成四档之一（`schools.tier` 值域改为 trial/standard/advanced/enterprise）。
- 管理端显示做一层映射：trial→试用、standard→标准(白银)、advanced→高级(黄金)、enterprise→旗舰(铂金)。青铜/白银/黄金三皮并入四档。
- **旧 A/B/C 映射（需你确认业务含义）**：A/B/C 大概率是内部评级，建议 A→advanced、B→standard、C→trial（**待你确认**）。
- **8 所空值回填**：空 tier 统一回填为 `trial`（最低档，最安全——不会误给高名额）；回填走一条 UPDATE 迁移（`update schools set tier='trial' where tier is null`）。

> 这套映射是**方案**；真正统一用哪套词是**问题 1**。

## 2. 学校提额申请怎么入库 —— 两方案代价

现状 `quota_requests` 只有 `partner_id`，学校写不进。

- **方案 A：给 `quota_requests` 加 `school_id` 列（可空）**
  - 代价：一列迁移；申请方二选一（partner_id 或 school_id 非空）；现有中介申请逻辑不动；管理端配额审批台要分「中介申请 / 学校申请」两类渲染。
  - 优点：改动小、一张表管两类申请。
  - 缺点：一张表塞两种主体，查询/策略要区分，长期略乱。
- **方案 B：新建 `school_quota_requests` 表（school_id + 申请额 + 理由 + 状态 + 时间）**
  - 代价：新表 + RLS + 审批 RPC + 管理端新审批区。
  - 优点：结构干净、与中介申请解耦、各自演进。
  - 缺点：多一张表 + 一套审批链。

**建议 B**（干净、可独立演进），除非你希望学校/中介申请合并在一个审批台。

## 3. 管理端改层级怎么写进库
现在管理端改 tier 只写**本机浏览器**（`_V22_TIER_LS`）。改为：
- 新 RPC `admin_set_school_tier(school_id, tier, reason)`（SECURITY DEFINER + is_admin 门 + 白名单四档值 + 写 `admin_events`）。
- 前端「调整层级」下拉从 LS 改调该 RPC；`schools.tier` 落真值。

## 4. 改完后学校端名额怎么跟着变
- 学校端名额来自 tier → 每档名额映射（学校端现写死：试用 5 / 标准 20 / 高级 100 / 旗舰 500）。
- tier 落真库后，学校端读 `schools.tier` → 查每档名额（**问题 2** 定每档给多少）→ 名额自动跟随。
- 建议每档名额也进库（一张 `tier_quota(tier, quota)` 小配置表或 RPC 常量），避免两端各写死。

---

## 请你拍板两个问题

1. **层级统一用哪套词？**
   - 建议：底层用 **trial / standard / advanced / enterprise**（决定名额），界面显示映射成中文（试用/标准/高级/旗舰）。青铜/白银/黄金并入。
   - 顺带确认：旧 `A/B/C` 分别对应哪档？（我暂拟 A→advanced、B→standard、C→trial）
   - 👉 你定。

2. **每档给多少名额？**
   - 学校端现写死：试用 5 / 标准 20 / 高级 100 / 旗舰 500。沿用还是改？
   - 👉 你定四个数。

**本卡零代码、零 SQL 执行。** 你答完两问 + 确认 A/B/C 含义，我再开施工卡（迁移：schools.tier 值域统一+空值回填+school_quota_requests 建表；RPC：admin_set_school_tier；前端：层级下拉接 RPC + 名额联动）。
