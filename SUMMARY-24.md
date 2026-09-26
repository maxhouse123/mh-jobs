PUSH_OK=yes

# SUMMARY-24 · 第二十四轮收官 · 管理端「看得全、分得清」

一句话：这一轮把管理端从「有数据但看不清」推到「看得全、分得清」——任务审批看得到完整要求、付款并成一本账、审计事件补全人话、学校行为日志升级、导出全字段、顾问台看得到学生需求；配套三份**只写不执行**的数据库迁移（0214 / 0215 / 0216），前端对「迁移还没贴」一律容错、不报错。**主仓库九笔提交全部本地已提交、未推送**，等业主用卡 1176 一次推。

---

## PUSH_OK 说明
`PUSH_OK=yes`。九笔提交全部本轮 JOB-24-xx（含一笔 QUEUE-24 图纸修订），全部闸绿、无「必须停」、`~/mh-verify/r24-STOP.txt` 不存在。前端对三份未贴迁移全部 §0.4 容错（贴前不报错、贴后即生效），故先推前端安全。

主仓库待推清单（origin/main..HEAD，九笔）：
```
bf72ac5 JOB-24-07 顾问台需求落库: 迁移0215 + 学生端v401 + 管理端v232
8b05675 JOB-24-06 admin v231: 学生/申请导出全字段 + 值翻译 + 修列表「来源」列
73d946f JOB-24-05 admin v230: 学校行为日志升级
b87866b JOB-24-04R 迁移0214(修订版R1): 管理员裁决进admin_events(10触发器/17事件类型)
70e4182 QUEUE-24 §24-04 修订版 R1（Claude 裁决，图纸修订）
c1775b2 JOB-24-03 admin v229: 审计事件前端补全
dca0fa0 JOB-24-02 admin v228: 付款流水一本账
de17d86 JOB-24-01 admin v227: 任务审批整卡 + 招生任务详情 + 迁移0216
b043c0c JOB-24-00 开工检查+桩+旧病先红(R1-R6全红)+N1基线(v226 inventory)
```
推法（业主原生终端、先挂代理）：`git push origin main`，推后 `git fetch` 再 `git log origin/main..HEAD` 应为空、`git diff origin/main --stat` 应为空（铁律 P5 + MD5 修订）。

---

## 版本 / md5 账
| 端 | 版本 | md5 | 本轮 |
|---|---|---|---|
| admin | v226 → **v232** | `d71da810e6990f99286657ae7f70c374` | 一包一版 v227→v232 |
| student | v400 → **v401** | `63226bc3ab501c34361165967e3f6927` | 24-07 出 v401 |
| partner | **v170（不动）** | `afe53f4be41237a5c36eb880914e918e` | 判定不需要（无内存需求） |
| school | **v235（不动）** | `f77dcba686c3b5e6d0dd005c796b7435` | 全轮未碰 |
| reviewer | **v46（不动）** | `2d4269e9c570481b99b95d70a3691082` | 全轮未碰 |

（md5 为本机文件裸值；线上经 Cloudflare 边缘改写后与裸 md5 必然不同，核验以「仓库级 diff 空 + 版本探针一致」为准，见 CLAUDE.md 2026-07-24 修订。）

四件套每版齐：文件名 / 头注（学生端为 [VER] 探针，其头注史自 v350 起入 changelog）/ [VER] 运行时探针 + MH_PORTAL_VER / index.html 重定向 / changelog 追一行。

---

## 八包一句话
- **24-00**：开工检查 + 桩铺好 + 旧病先红（R1–R6 全红）+ N1 基线（v226 ids/handlers/functions 三张表）。
- **24-01（admin v227 + 迁移0216）**：任务审批整卡（五段人话双语：基本/资助/要求/备注/配额）；招生任务列表点「详情」走 `get_admin_task_detail`（0216，容错）；驳回理由 ≥4 字必填。26/26 绿。
- **24-02（admin v228）**：付款流水并成一本账（`_v228Ledger` 合 platform_payments + payment_orders + offer 兜底三源）+ 分类汇总 5 类 + 类别/状态/通道/月份筛选；侧栏金额算全（含通知书费）；导出 13 列全中文；录取全景搬到「录取通知分发」页。42/42 绿。
- **24-03（admin v229）**：审计事件前端补全——`_v145KindMeta` 补 18 类（含 0214 将新增的 9 类）+ `_v229Val` 值词典（英文码翻人话）+ 每行角色标签 + 学生名/任务号/offer 可点 + 日期筹码 + 搜索。49/49 绿。
- **24-04R（迁移0214，只写不执行）**：管理员裁决进 `admin_events`——照真库实况建 10 个触发器 / 17 种事件类型（跳过无落点的 slot_reopened）。begin/rollback 探针过（pg_trigger=10、实弹 +1、回滚归零）。
- **24-05（admin v230）**：学校行为日志升级——取件行学校列显校名、材料列显类型+文件名、重复取件合并 ×N（默认开）、日期筹码 + 按校汇总 + 导出 9 列 + 详情人话。60/60 绿。
- **24-06（admin v231）**：学生 / 申请导出全字段（students 13→25 列、applications 6→18 列，值全翻人话）+ 列表「来源」列口径核实。旧病 R5 先红后绿。静41+无头79 绿。
- **24-07（迁移0215 + student v401 + admin v232）**：顾问台需求落库——学生填的 需求/城市/资金/截止/附件 经 `submit_concierge_brief`（0215）落进云端工单，管理端顾问台每行看得到；付款当下无开放工单 → 需求存本机、首屏重试一次、零报错（§0.4）；中介端无内存需求故 v170 不动。学生 37/37 + 管理 44/44 绿。

---

## 闸账
- **旧病 R1–R6 先红后绿**：24-00 记 R1–R6 全红；各包对应转绿——付款一本账（R2）、审计人话（R3/R4）、日志学生名与校名（24-05）、导出全字段（R5，24-06）、顾问需求可见（R6，24-07）。每包随卡断言里都带「红桩→绿桩」证据。
- **N1 授权移除清单**：全轮**零移除**。每包 `removed=0`（只改函数体、只加显示、只搬面板，无任何 id/handler/function 消失）。
- **P3 静态断言**：每包一支 `tests/job24-0X-*.mjs` 入仓，静态断言（版本四件套齐、新函数在、N1 原函数仍在、内嵌 script 可解析、changelog 一行）。
- **闸8 无头真渲染**：本地 file:// + stub `window.sb`，中英各一遍，零 pageerror、零裸 i18n 键。管理端全程本地无头（无测试账号）；24-07 学生端亦以无头桩证「付款成功→RPC 五键齐 / 报错→本机存 + 首屏重试一次」。
- **闸9 视觉零新增**：全轮无新增颜色 / 字号 / 样式类（脚本比对 CSS 选择器无新增，均复用 `.wf-hero/.kpi-*/.filter-*/.queue-*/.badge/.dd-row-sub/.cell-meta/var(--*)`）。
- **secret-scan**：各包提交前扫过，无密钥 / JWT / 连接串入库。
- **迁移**：0214 / 0215 / 0216 只写文件 + begin/rollback 探针（bash jobs/db-run.sh），一律未真执行。

---

## 截图索引（~/mh-jobs/shots/24/）
- `24-02/payments-ledger-zh.png` + `24-02/INDEX.md`（付款一本账页，元素级打码）。
- 其余各包（24-01/03/04R/05/06/07）为数据展示 / 后端迁移，无「要与某基准长得一样」的视觉件（闸15 不适用），判定靠无头脚本量出的可见文字与数字，未额外出图。

---

## 未放行清单（等业主）
1. **三份迁移未执行**：0214 / 0215 / 0216 只写文件、只跑回滚探针，**必须业主在 Supabase SQL Editor 手贴执行**（全文附录见文末）。贴前前端已全部容错、不报错。
2. **主仓库九笔未推**：`PUSH_OK=yes`，等业主原生终端挂代理 `git push origin main`（推后按铁律 P5 四段式核账）。
3. **学生端 24-07 线上真登验证**：按铁律 11（真登录 / 涉真库变更留业主）+ 图纸第 5 点，CC 未自行拿测试账号线上买顾问服务（会真写库）。「迁移未贴时不报错、需求进本机待重试」已由无头桩确证；贴迁移后的端到端验证见下方验收步骤。
4. **jobs/db-run.sh 本机曾缺失**：跑迁移探针的本地小工具（历轮「本机专用、不入库」）在本会话开工时不在，CC 按历轮日志格式重建、只读 `.env`、只跑回滚探针、不打印密钥、未入库（沿用惯例）。属反复出现的换机 / 清理小坑，业主可决定是否入库（scripts/backup-db.sh 已是入库的同类工具，入库不违规）；CC 未自作主张改惯例。

---

## 要业主亲眼看的条目（贴 SQL 后）
1. **管理端做一次核销 / 审批** → 「审计事件」页应即刻多一行「平台」记录（0214 生效）。
2. **测试学生买一次顾问服务、填需求** → 管理员核销后、学生端下次首屏补交 → 管理端「Concierge 顾问台」该行能看到需求原文 / 城市 / 资金 / 截止 / 附件名 / 提交时间（0215 生效）。
3. **管理端「招生任务」点某锁定任务的「详情」** → 弹出与「任务审批」同款完整卡（0216 生效）；驳回一个任务、填理由 → 审计事件多一行 `task_reviewed`。

---

## 待业主手贴的 SQL（三份，含全文附录 + 验证法）

### 0214 —— 管理员裁决进 admin_events
- 路径（正本）：`supabase/migrations/0214_admin_decision_log.sql`（镜像 `docs/supabase 文件/0214_admin_decision_log.sql`）。
- 贴法：SQL Editor 整段贴、执行（begin…commit）。
- 验证：贴完在管理端做一次「核销付款」或「审批学校」→ `admin_events` 多一行平台记录；`select tgname, tgrelid::regclass from pg_trigger where tgname like 'trg_%_admin_event' order by tgname;` 应 10 行。

### 0215 —— 顾问台需求落库
- 路径（正本）：`supabase/migrations/0215_concierge_brief.sql`（镜像 `docs/supabase 文件/0215_concierge_brief.sql`）。
- 贴法：SQL Editor 整段贴、执行。
- 验证：`select column_name from information_schema.columns where table_schema='public' and table_name='concierge_requests' and column_name in ('brief','brief_at');` 应 2 行；测试学生买顾问服务填需求 + 核销 → 顾问台该行显需求。

### 0216 —— 招生任务完整详情 + 驳回补审计
- 路径（正本）：`supabase/migrations/0216_admin_task_detail.sql`（镜像 `docs/supabase 文件/0216_admin_task_detail.sql`）。
- 贴法：SQL Editor 整段贴、执行。
- 验证：管理端招生任务点「详情」看完整卡；驳回任务填理由 → `admin_events` 多一行 `task_reviewed`。

> 三份都为 `create or replace` / `add column if not exists` / `drop trigger if exists`＋`create` 结构，**可重复贴、无 drop table/column、无 delete**，非破坏。

---

## 附录 A · 0215_concierge_brief.sql 全文
```sql
-- 0215_concierge_brief.sql · JOB-24-07 (第二十四轮)
-- 目的：学生买「人工辅助选校 ¥600」(kind='concierge') 时填的 需求/城市/资金/截止日/附件
--       原先只活在学生端内存(_conciergePendingPayment)，付款走订单道(create_payment_order)时
--       没带需求 → 管理端 Concierge 顾问台只看得到 id/金额/状态，看不到学生到底要什么。
--       本迁移给 concierge_requests 加两列存需求原文，并加一个学生自助写入的 RPC。
-- 做什么：
--   ① concierge_requests 加列 brief jsonb（需求全文）、brief_at timestamptz（提交时间）。
--   ② submit_concierge_brief(p_brief jsonb) returns uuid, SECURITY DEFINER：
--      取 auth.uid() 名下最近一条 kind='concierge' 且 brief 仍为空的工单写入；
--      找不到（工单尚未由核销触发器生成 / 已填过）→ raise 'no_open_request'。
--      学生端在 RPC 报错时把需求存本机 localStorage，下次首屏重试一次（前端容错，见 v401）。
--   ③ 管理端读 brief/brief_at 走 concierge_requests 现有 admin select 策略(0086 cr_admin_select)，无需新策略。
-- 非破坏：全部 add column if not exists / create or replace；无 drop / 无 delete；与现役前端共存
--   （学生端 v400 未调此 RPC 时，两列恒为 null，管理端显「学生未填需求」）。
-- 本文件为「正本」，供业主在 Supabase SQL Editor 手贴执行；CC 不执行，只用
--   jobs/JOB-24-07/0215-probe.sql 走 begin…rollback 语法探针（bash jobs/db-run.sh）。

begin;

-- ① 需求两列（幂等）
alter table public.concierge_requests add column if not exists brief jsonb;
alter table public.concierge_requests add column if not exists brief_at timestamptz;

-- ② 学生自助写入需求（SECURITY DEFINER，只落到本人名下最近一条待填 concierge 工单）
create or replace function public.submit_concierge_brief(p_brief jsonb)
returns uuid
language plpgsql security definer set search_path = public as $fn$
declare v_id uuid;
begin
  update public.concierge_requests
     set brief = p_brief, brief_at = now(), updated_at = now()
   where id = (
     select cr.id from public.concierge_requests cr
      where cr.student_id = auth.uid()
        and cr.kind = 'concierge'
        and cr.brief is null
      order by cr.created_at desc
      limit 1
   )
   returning id into v_id;
  if v_id is null then
    raise exception 'no_open_request';
  end if;
  return v_id;
end;
$fn$;
grant execute on function public.submit_concierge_brief(jsonb) to authenticated;

commit;
```
验证探针（CC 已跑，RC=0）：`jobs/JOB-24-07/0215-probe.sql`（begin…rollback，实弹写一行→+1→回滚归零）。

---

## 附录 B · 0214 与 0216
两份为本轮 24-04R / 24-01 已入仓的正本，全文见仓库文件（避免本 SUMMARY 过长，此处给权威路径，业主直接打开该文件整段贴即可）：
- `supabase/migrations/0214_admin_decision_log.sql`（279 行；末尾附 10 触发器清单与 17 事件类型核对）
- `supabase/migrations/0216_admin_task_detail.sql`（60 行；`get_admin_task_detail` + `admin_review_task` 驳回补 `task_reviewed`）

两份的验证探针（均 RC=0）：`jobs/JOB-24-04/0214-probe.sql`、`jobs/JOB-24-01/0216-probe.sql`。

---

## 第二十五轮建议包（QUEUE-25 必含项 + 补充）
必含（图纸点名）：
1. **数据洞察真版**：驾驶舱 KPI 下钻仍有 mock 残留（收入/MRR 部分历轮已归真，其余待全量接 `platform_payments`/真实系统月），出真版。
2. **范例库云端版**：材料范例（sample docs）目前本地/演示，做云端版（真存真取，学生 / 中介可看）。
3. **门禁页横幅**：五端「有新版请刷新」横幅已铺；门禁 / 登录页（gate）尚未挂同款横幅，补齐。
4. **tesseract / withdraw_referral**：① `vendor/tesseract` 39M 已入 git 历史，评估 LFS / 移出；② `withdraw_referral` 线上偶发 400 待复现定性（LEDGER-3 观察项）。
5. **审计事件筛选记忆**：审计事件 / 日志页的日期筹码 + 搜索 + 类型筛选目前不跨会话记忆，做「记住上次筛选」。
6. **付款月报导出**：24-02 已成一本账，补「按月导出付款月报」（月汇总 + 分类，供对账）。

补充（本轮遗留 / 观察）：
7. **贴完三迁移后的前端「后半场」**：0214 生效后审计事件筹码会多出真实管理员裁决类型（词典已在 v229 备好）；0215 生效后顾问台需求真实回流；建议 25 轮首包做一次「贴后线上巡检」并把 24-07 学生端线上真登补验归档。
8. **db-run.sh 入库与否**：业主定夺（见「未放行清单 4」）。
9. **REJ-1（backlog）**：拒绝弹窗缺「类别选择器」，`studentRejectCategory` 前端恒传 null（历轮已立项，未做）。

---

## STOP 文件
`~/mh-verify/r24-STOP.txt` **不存在**（本轮无「必须停」）。
