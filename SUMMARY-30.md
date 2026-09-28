PUSH_OK=yes

# 第三十轮 收官总结 · 学校报名系统对接一期

> PUSH_OK=yes 的含义：本轮六包全部做完、每包三层闸全过、无「必须停」、`~/mh-verify/r30-STOP.txt` 不存在；主仓库已按「每包一笔 commit、不 push」备好，业主可用卡1231 推送。**推送前请先按下方「一、待业主手贴的 SQL」把 0222 贴进 SQL Editor**（前端已全程容错：0222 没贴也不报错，只是学校报名建档这套功能整体隐身）。

---

## 〇、本轮产出（版本 / md5 账）
| 端 / 资产 | 版本 | md5 |
|---|---|---|
| school-portal/maxhouse-school-portal-v242.html | v242 | `0a4c4aef7fa297fe97750fcaa4a6eb1b` |
| student-portal/maxhouse_student_portal_v403.html | v403 | `5d1ea2770ad256de2053c5ddae57608c` |
| partner-portal/maxhouse-partner-portal-v173.html | v173 | `a4f3518b9bed678c9c7de803aab04f64` |
| admin-portal/maxhouse-admin-portal-v239.html | v239 | `35eed4531310d9296dc4b33cfd60a70e` |
| assets/mh-filing-form-v1.js（新共用组件） | v1 | `fa84e1299159c8c9ed7bb3e4050bb0a3` |
| reviewer-portal（本轮不动） | v46 | 未改 |

迁移：**0222_school_filing.sql**（只写文件 + begin…rollback 探针，**未真执行**，等业主手贴；镜像同文已落 `docs/supabase 文件/`）。

## 一、六包一句话
- **30-00**：只读侦查——库探针 P1–P7 证实两条真链（uid→学校 = `school_members`；task_code→学校 = `offer_decisions.task_code → admission_tasks.school_id`）+ 抄下 17gz 14 个下拉的英文选项原文 + 四端 N1 基线 + R1–R4 先红（red=8 pageerror=0）。
- **30-01**：写迁移 0222——schools+7 filing 列 / 新表 `student_filing_profiles` + `filing_tasks`（先 revoke 再 grant）/ 3 触发器（进表·补完转待办·首次发 OFFER 闸）/ 9 RPC；begin…rollback 探针 5 断言全过、回滚后表消失、零 drop/truncate/delete。
- **30-02**：school v242——设置页「录取办理方式」区块（`school_set_filing` 五参）+ 首次发 OFFER 闸（两入口 + 服务端 filing_unset 两处兜底）+ OFFER 卡「平台建档」状态行；0222 未贴 42703/42P01 → 隐藏且放行。P3 31 / 闸8 15 全过。
- **30-03**：共用组件 `mh-filing-form-v1.js`（自带四语词典 + 17gz 下拉选项 + 37 项必填清单）+ student v403 + partner v173——学生/中介的「补充信息表」入口、存草稿/提交走 `save_my_filing` / `agent_save_filing`；盲态守住。P3 68 / 闸8 24 全过。
- **30-04**：admin v239——「学校建档」页（`admin_list_filing_tasks` 七芯片 + 补充信息已齐/缺N项复用组件 REQUIRED + 记申请号/改状态）+ 导出建档包（浏览器内 canvas/pdf.js/pdf-lib 转换 + 自写 store-only zip + `admin_set_filing_status` 置已导出）+ 学校抽屉代设办理方式（`admin_set_school_filing` 六参）。P3 56 / 闸8 44 全过。
- **30-05**：建档包 ↔ gz17 机器人契约实测——`gz17-robot.mjs check` 打印 **PACK_OK** + 21 个下拉值 ∈ 17gz 选项零不命中；契约抓到并修了导出端一病（hsk_level 折算成 `HSK LEVEL N`）。

## 二、闸账（本轮汇总）
- **旧态先红 → 转绿**：R1（school 设置区块+发 OFFER 引导）/ R2（student 补充信息卡）/ R3（admin 学校建档页）/ R4（partner 补充信息按钮）——30-00 全红（red=8），30-02/03/04 逐条转绿。
- **N1 零移除**：四端任一 id/inline handler/function 一个没丢（school +id6/h2/fn9、student +h1/fn12、partner +fn8、admin +id14/h6/fn45，均新增）。
- **P3 静态断言**：四件套 + 函数就位 + i18n 各语齐 + 内嵌脚本零解析失败（school 31 / student+partner 68 / admin 56 全过）。
- **闸8 无头真渲染**：本地 file://→静态服 + stub window.sb，只碰 127.0.0.1；四语（学生/中介）/ 中英（学校/管理）各一遍；pageerror 全 0（school 15 / 学生中介 24 / admin 44）。
- **gz17 契约**：PACK_OK + 值∈选项 21/21。
- **secret-scan**：各端新增行零密钥。
- **shell-lint**：本轮无新增 shell 脚本（自验脚本均为 node .mjs）。
- **迁移安全**：0222 零 drop/truncate/delete，begin…rollback 探针回滚后库零改动。

## 三、待业主亲眼看的条目（**先贴 0222，再按此顺序看**）
1. **school 端（v242）**：设置页多出「录取办理方式」；某校 `filing_system` 为空时点「发送录取通知」会先弹「请先设置录取办理方式」（去设置/取消），设好后才发得出；学生接受 OFFER 后该生录取卡上出现「平台建档：待学生补充信息 / …」状态行。
2. **student 端（v403）+ partner 端（v173）**：学生接受某校 OFFER 且该校要求「出通知书前建档」→ 首页冒出橙色「请填写补充信息」卡（点开是那张七段大表，护照号等已有信息只读带入）；填完提交后卡下出现「补充信息已提交·迈克豪斯正在替你办理」。中介替推荐学生同一张表。**盲态**：卡片/表里只见盲态编码（如 SCH-1234），无校名/网址/中介账号名。
3. **admin 端（v239）**：左侧多出「🗂️ 学校建档」；stuA 提交补充信息后这一页出现她那行「已齐」；点「导出建档包」下载到一个 zip（解开有 `profile.json` + `files/`，护照是 jpg）；点「记申请号」填 2026080… 后状态变「已提交」；school 端该生 OFFER 卡同步显示「已提交（申请号 …）」；学校抽屉里可「代设」录取办理方式。

## 四、未放行清单（本轮不做 / 留后续）
- **0222 未真执行**：只写文件 + rollback 探针；真执行 = 业主卡1232 手贴（见附录）。
- **线上真登冒烟：本轮跳过**。理由：0222 未贴到真库，四端新功能线上一律容错隐藏（无可测面）；且铁律11 要求 CC 只点本地 file://、绝不碰生产。留业主贴完 0222 后按上「三、」线上验收。`~/mh-verify/accounts.json` 在，但据此不做线上写库动作。
- **通知**：0222 不主动发通知（§0.5 允许；学生端行动卡本身即提醒），未来要发用新 kind `filing_form_needed`（现不撞车）。
- **真网站实测**（机器人在武纺练习草稿上真跑）：属第三十一轮（见下）。
- **at0086 建档**：本轮只导出 4:3 证件照备用；at0086 填表机器人待窗口开放后摸底（R31）。

## 五、运营常量清单（`_v239PLATFORM`，admin v239 文件顶部一处，**请业主逐条核对后改**）
导出建档包时代填给学校的平台侧字段（推荐人 / 在华担保人 / 通知书接收人 / 联系方式），当前为**占位值**：
| 键 | 当前占位 | 用途 |
|---|---|---|
| name | Maxhouse Education | 推荐机构 / 在华担保机构名 |
| phone | +86-27-8000-0000 | 平台固话 |
| mobile | +86-138-0000-0000 | 平台手机 |
| email | apply@maxhouses.net | 平台邮箱（推荐人/联系/通知书接收） |
| address | Optics Valley Ave, Hongshan District, Wuhan | 平台地址 |
| city | Wuhan | 平台城市 |
| country | China | 国名英文 |
| zip | 430000 | 邮编 |
| contact_name | Maxhouse Admissions | 推荐人 / 通知书接收人姓名 |
| job_title | Admissions Coordinator | 推荐人职务 |
| relationship | Agency | 推荐人与学生关系 |

## 六、第三十一轮建议包
1. **at0086 填表机器人**（等武昌理工报名窗口开放后摸底选项原文，仿 gz17 机器人）。
2. **建档包真网站实测卡**（gz17 机器人吃管理端导出的包，在武纺练习草稿上真跑一遍到底）。
3. **桌面双击启动器**（`.command`，业主一键起本地静态服 + 打开四端）。
4. **AI 预检预填补充信息**（护照到期日 / 教育经历等由 AI 预填，学生只需确认）。
5. **`admin_decide_school_quota` 批准即加 N 张**（学校配额审批闭环）。
6. **27-A / 27-B / SMTP 配置单 / 数据洞察真版 / 材料范例库云端版**（历轮挂账项）。
7. **本轮观察项**：① `_v239PLATFORM` 占位值待业主填真；② student/partner 若查不到四语国家表时组件用英文国名（§0.5 已允许，未来若要四语国名再补；③ 学习计划中文正文走 canvas jpg 兜底（pdf-lib 标准字体画不了中文），未来若要中文 PDF 需嵌中文字体子集；④ 建档任务「补完转待办」依赖触发器，学生改一次补充信息即翻状态，运营侧感知节奏待线上观察。

---

## 附录 · 待业主手贴的 SQL（迁移 0222_school_filing.sql 全文）

**贴法**：Supabase → SQL Editor → 新建查询 → 把下面代码块**整段**粘进去 → Run。文件幂等（`create table if not exists` / `add column if not exists` / `create or replace`），重复贴不会报错、不破坏已有数据。**零 drop/truncate/delete**（本机实测计数 0）。

**贴完按这三条核行数**（文件末尾的 `\echo` + select 会在 SQL Editor 里逐段出结果）：
- **V1 新表 = 2 行**（`filing_tasks`、`student_filing_profiles`）
- **V2 schools 新列 = 7 行**（`filing_account` / `filing_note` / `filing_set_at` / `filing_set_by` / `filing_system` / `filing_timing` / `filing_url`）
- **V3 新函数 = 12 行**（9 个 RPC + 3 个触发器函数 `trg_filing_task_on_offer` / `trg_filing_profile_completed` / `trg_filing_gate`）

> 注：SQL Editor 不认 psql 的 `\echo` 元命令，若报 `\echo` 语法错，把三行 `\echo '...'` 删掉再跑三条 select 即可（select 本体不受影响）。

```sql
-- 0222_school_filing.sql · 第三十轮 · 学校报名系统对接一期
-- 内容：schools 加 7 个 filing 列 + 2 张新表(student_filing_profiles / filing_tasks)
--       + 4 个触发器(自动进表 / 补完转待办 / 首次发OFFER闸) + 9 个 RPC。
-- 全文幂等（if not exists / create or replace / DO 守卫）；只增不删；每张新表先 revoke 默认权再 grant。
-- 真链（30-00 P1/P2 证实）：uid→学校 = school_members(user_id→school_id)；
--   task_code→学校 = offer_decisions.task_code→admission_tasks.task_code→admission_tasks.school_id；
--   offer_decisions.sent_by 直接外键 schools(id)。
-- ⚠ 本文件只写、不真执行；由 bash jobs/db-run.sh 跑 begin…rollback 探针；业主收官后 SQL Editor 手贴。

-- ============================================================ 1) schools 加 filing 列
alter table public.schools add column if not exists filing_system  text;
alter table public.schools add column if not exists filing_timing  text default 'before_letter';
alter table public.schools add column if not exists filing_url     text;
alter table public.schools add column if not exists filing_account text;
alter table public.schools add column if not exists filing_note    text;
alter table public.schools add column if not exists filing_set_at  timestamptz;
alter table public.schools add column if not exists filing_set_by  uuid;

do $$ begin
  if not exists (select 1 from pg_constraint where conname='schools_filing_system_chk') then
    alter table public.schools add constraint schools_filing_system_chk
      check (filing_system is null or filing_system in ('none','gz17','at0086','own','form'));
  end if;
  if not exists (select 1 from pg_constraint where conname='schools_filing_timing_chk') then
    alter table public.schools add constraint schools_filing_timing_chk
      check (filing_timing is null or filing_timing in ('before_letter','after_payment'));
  end if;
end $$;

-- ============================================================ 2) student_filing_profiles（补充信息表存储）
create table if not exists public.student_filing_profiles (
  student_id   uuid primary key references public.students(id) on delete cascade,
  data         jsonb not null default '{}'::jsonb,
  completed_at timestamptz,
  updated_at   timestamptz not null default now(),
  updated_by   uuid,
  updated_role text
);
do $$ begin
  if not exists (select 1 from pg_constraint where conname='sfp_updated_role_chk') then
    alter table public.student_filing_profiles add constraint sfp_updated_role_chk
      check (updated_role is null or updated_role in ('student','agent','admin'));
  end if;
end $$;

alter table public.student_filing_profiles enable row level security;
revoke all on public.student_filing_profiles from anon, authenticated;
grant select, insert, update on public.student_filing_profiles to authenticated;

do $$ begin
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='student_filing_profiles' and policyname='sfp_self_rw') then
    create policy sfp_self_rw on public.student_filing_profiles
      for all using (student_id = auth.uid()) with check (student_id = auth.uid());
  end if;
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='student_filing_profiles' and policyname='sfp_agent_rw') then
    create policy sfp_agent_rw on public.student_filing_profiles
      for all using (public.partner_owns_student(student_id)) with check (public.partner_owns_student(student_id));
  end if;
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='student_filing_profiles' and policyname='sfp_admin_all') then
    create policy sfp_admin_all on public.student_filing_profiles
      for all using (public.is_admin(auth.uid())) with check (public.is_admin(auth.uid()));
  end if;
end $$;

-- ============================================================ 3) filing_tasks（哪份 offer 该建档、办到哪一步）
create table if not exists public.filing_tasks (
  id           uuid primary key default gen_random_uuid(),
  offer_id     uuid not null unique references public.offer_decisions(id) on delete cascade,
  student_id   uuid not null,
  school_id    uuid not null,
  system       text,
  timing       text,
  status       text not null default 'pending',
  school_app_no text,
  note         text,
  exported_at  timestamptz,
  submitted_at timestamptz,
  decided_at   timestamptz,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now(),
  updated_by   uuid
);
do $$ begin
  if not exists (select 1 from pg_constraint where conname='filing_tasks_status_chk') then
    alter table public.filing_tasks add constraint filing_tasks_status_chk
      check (status in ('waiting_student','pending','exported','submitted','approved','rejected','cancelled'));
  end if;
end $$;
create index if not exists filing_tasks_student_idx on public.filing_tasks(student_id);
create index if not exists filing_tasks_school_idx  on public.filing_tasks(school_id);
create index if not exists filing_tasks_status_idx  on public.filing_tasks(status);

alter table public.filing_tasks enable row level security;
revoke all on public.filing_tasks from anon, authenticated;
grant select on public.filing_tasks to authenticated;   -- 写只走 RPC / 触发器(security definer)

do $$ begin
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='filing_tasks' and policyname='ft_admin_all') then
    create policy ft_admin_all on public.filing_tasks
      for all using (public.is_admin(auth.uid())) with check (public.is_admin(auth.uid()));
  end if;
  -- 学校看本校行：登录用户经 school_members 属于该 school_id
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='filing_tasks' and policyname='ft_school_select') then
    create policy ft_school_select on public.filing_tasks
      for select using (exists (
        select 1 from public.school_members m where m.user_id = auth.uid() and m.school_id = filing_tasks.school_id
      ));
  end if;
  -- 学生看本人行
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='filing_tasks' and policyname='ft_student_select') then
    create policy ft_student_select on public.filing_tasks
      for select using (student_id = auth.uid());
  end if;
  -- 推荐方看推荐学生的行
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='filing_tasks' and policyname='ft_agent_select') then
    create policy ft_agent_select on public.filing_tasks
      for select using (public.partner_owns_student(student_id));
  end if;
end $$;

-- ============================================================ 4) 触发器：自动进表
create or replace function public.trg_filing_task_on_offer()
returns trigger language plpgsql security definer set search_path to 'public' as $function$
declare
  v_school_id uuid;
  v_system text; v_timing text;
  v_status text;
  v_hit boolean := false;
begin
  -- 找学校：优先 sent_by(直接是学校 id)，退而用 task_code → admission_tasks.school_id
  v_school_id := coalesce(NEW.sent_by, (select t.school_id from public.admission_tasks t where t.task_code = NEW.task_code));
  if v_school_id is null then return NEW; end if;
  select s.filing_system, s.filing_timing into v_system, v_timing from public.schools s where s.id = v_school_id;
  if v_system is null or v_system not in ('gz17','at0086','own','form') then return NEW; end if;

  -- 路径一：接受 offer 且已发出专业，且学校要「出通知书前」建档
  if NEW.student_response = 'accepted' and NEW.offered_program is not null and v_timing = 'before_letter' then
    v_hit := true;
  -- 路径二：付款到账，且学校要「付款后」建档
  elsif NEW.letter_paid_at is not null and v_timing = 'after_payment' then
    v_hit := true;
  end if;
  if not v_hit then return NEW; end if;

  v_status := case when exists (
      select 1 from public.student_filing_profiles p where p.student_id = NEW.student_id and p.completed_at is not null
    ) then 'pending' else 'waiting_student' end;

  insert into public.filing_tasks (offer_id, student_id, school_id, system, timing, status)
  values (NEW.id, NEW.student_id, v_school_id, v_system, v_timing, v_status)
  on conflict (offer_id) do nothing;
  return NEW;
end $function$;

create or replace trigger trg_filing_task_on_offer
  after update of student_response, letter_paid_at on public.offer_decisions
  for each row execute function public.trg_filing_task_on_offer();

-- ============================================================ 5) 触发器：补完即转待办
create or replace function public.trg_filing_profile_completed()
returns trigger language plpgsql security definer set search_path to 'public' as $function$
begin
  if NEW.completed_at is not null then
    update public.filing_tasks set status = 'pending', updated_at = now()
     where student_id = NEW.student_id and status = 'waiting_student';
  end if;
  return NEW;
end $function$;

create or replace trigger trg_filing_profile_completed
  after insert or update of completed_at on public.student_filing_profiles
  for each row execute function public.trg_filing_profile_completed();

-- ============================================================ 6) 触发器：首次发 OFFER 闸
create or replace function public.trg_filing_gate()
returns trigger language plpgsql security definer set search_path to 'public' as $function$
declare v_school_id uuid; v_system text; v_sending boolean;
begin
  -- 只在「发出新 offer」这一下动作：INSERT 带专业，或 UPDATE 由空变非空
  if TG_OP = 'INSERT' then
    v_sending := NEW.offered_program is not null;
  else
    v_sending := (OLD.offered_program is null and NEW.offered_program is not null);
  end if;
  if not v_sending then return NEW; end if;

  v_school_id := coalesce(NEW.sent_by, (select t.school_id from public.admission_tasks t where t.task_code = NEW.task_code));
  if v_school_id is null then return NEW; end if;   -- 找不到学校（管理员合成等）→ 放行
  select s.filing_system into v_system from public.schools s where s.id = v_school_id;
  if v_system is null then raise exception 'filing_unset'; end if;
  return NEW;
end $function$;

create or replace trigger trg_filing_gate
  before insert or update of offered_program on public.offer_decisions
  for each row execute function public.trg_filing_gate();

-- ============================================================ 7) RPC
-- 7.1 school_set_filing —— 学校自己设办理方式
create or replace function public.school_set_filing(
  p_system text, p_timing text, p_url text, p_account text, p_note text)
returns jsonb language plpgsql security definer set search_path to 'public' as $function$
declare v_uid uuid := auth.uid(); v_school_id uuid;
begin
  if not public.is_school(v_uid) then raise exception 'not a school account'; end if;
  if p_system is null or p_system not in ('none','gz17','at0086','own','form') then raise exception 'bad filing_system'; end if;
  if p_timing is not null and p_timing not in ('before_letter','after_payment') then raise exception 'bad filing_timing'; end if;
  select school_id into v_school_id from public.school_members where user_id = v_uid order by created_at asc nulls last, id asc limit 1;
  if v_school_id is null then raise exception 'no school bound to this account'; end if;
  update public.schools set
    filing_system  = p_system,
    filing_timing  = coalesce(p_timing, 'before_letter'),
    filing_url     = p_url,
    filing_account = p_account,
    filing_note    = p_note,
    filing_set_at  = now(),
    filing_set_by  = v_uid,
    updated_at     = now()
   where id = v_school_id;
  insert into public.admin_events (event_type, actor_uid, school_id, detail)
  values ('school_filing_set', v_uid, v_school_id, jsonb_build_object('system',p_system,'timing',p_timing));
  return jsonb_build_object('ok', true);
end $function$;

-- 7.2 admin_set_school_filing —— 管理员代设
create or replace function public.admin_set_school_filing(
  p_school_id uuid, p_system text, p_timing text, p_url text, p_account text, p_note text)
returns jsonb language plpgsql security definer set search_path to 'public' as $function$
declare v_uid uuid := auth.uid();
begin
  if not public.is_admin(v_uid) then raise exception 'admin only'; end if;
  if p_system is null or p_system not in ('none','gz17','at0086','own','form') then raise exception 'bad filing_system'; end if;
  if p_timing is not null and p_timing not in ('before_letter','after_payment') then raise exception 'bad filing_timing'; end if;
  if not exists (select 1 from public.schools where id = p_school_id) then raise exception 'school not found'; end if;
  update public.schools set
    filing_system  = p_system,
    filing_timing  = coalesce(p_timing, 'before_letter'),
    filing_url     = p_url,
    filing_account = p_account,
    filing_note    = p_note,
    filing_set_at  = now(),
    filing_set_by  = v_uid,
    updated_at     = now()
   where id = p_school_id;
  insert into public.admin_events (event_type, actor_uid, school_id, detail)
  values ('school_filing_set', v_uid, p_school_id, jsonb_build_object('system',p_system,'timing',p_timing,'by','admin'));
  return jsonb_build_object('ok', true);
end $function$;

-- 7.3 get_my_filing —— 学生本人读
create or replace function public.get_my_filing()
returns jsonb language sql stable security definer set search_path to 'public' as $function$
  select jsonb_build_object(
    'profile', (select to_jsonb(x) from (
        select p.data, p.completed_at, p.updated_at
          from public.student_filing_profiles p where p.student_id = auth.uid()) x),
    'tasks', coalesce((
        select jsonb_agg(jsonb_build_object(
            'offer_id', f.offer_id, 'status', f.status, 'timing', f.timing,
            'system', f.system, 'school_app_no', f.school_app_no, 'created_at', f.created_at)
          order by f.created_at desc)
          from public.filing_tasks f where f.student_id = auth.uid()), '[]'::jsonb)
  );
$function$;

-- 7.4 get_agent_filing —— 推荐方读
create or replace function public.get_agent_filing(p_sid uuid)
returns jsonb language plpgsql stable security definer set search_path to 'public' as $function$
begin
  if not public.partner_owns_student(p_sid) then raise exception 'not your referred student'; end if;
  return jsonb_build_object(
    'profile', (select to_jsonb(x) from (
        select p.data, p.completed_at, p.updated_at
          from public.student_filing_profiles p where p.student_id = p_sid) x),
    'tasks', coalesce((
        select jsonb_agg(jsonb_build_object(
            'offer_id', f.offer_id, 'status', f.status, 'timing', f.timing,
            'system', f.system, 'school_app_no', f.school_app_no, 'created_at', f.created_at)
          order by f.created_at desc)
          from public.filing_tasks f where f.student_id = p_sid), '[]'::jsonb)
  );
end $function$;

-- 7.5 save_my_filing —— 学生本人存/交
create or replace function public.save_my_filing(p_data jsonb, p_complete boolean)
returns jsonb language plpgsql security definer set search_path to 'public' as $function$
declare v_uid uuid := auth.uid();
begin
  if v_uid is null then raise exception 'not signed in'; end if;
  insert into public.student_filing_profiles (student_id, data, completed_at, updated_at, updated_by, updated_role)
  values (v_uid, coalesce(p_data,'{}'::jsonb), case when p_complete then now() else null end, now(), v_uid, 'student')
  on conflict (student_id) do update set
    data = coalesce(excluded.data, public.student_filing_profiles.data),
    completed_at = case when p_complete then now() else public.student_filing_profiles.completed_at end,
    updated_at = now(), updated_by = v_uid, updated_role = 'student';
  return jsonb_build_object('ok', true);
end $function$;

-- 7.6 agent_save_filing —— 推荐方存/交
create or replace function public.agent_save_filing(p_sid uuid, p_data jsonb, p_complete boolean)
returns jsonb language plpgsql security definer set search_path to 'public' as $function$
declare v_uid uuid := auth.uid();
begin
  if not public.partner_owns_student(p_sid) then raise exception 'not your referred student'; end if;
  insert into public.student_filing_profiles (student_id, data, completed_at, updated_at, updated_by, updated_role)
  values (p_sid, coalesce(p_data,'{}'::jsonb), case when p_complete then now() else null end, now(), v_uid, 'agent')
  on conflict (student_id) do update set
    data = coalesce(excluded.data, public.student_filing_profiles.data),
    completed_at = case when p_complete then now() else public.student_filing_profiles.completed_at end,
    updated_at = now(), updated_by = v_uid, updated_role = 'agent';
  return jsonb_build_object('ok', true);
end $function$;

-- 7.7 admin_list_filing_tasks —— 管理端列表
create or replace function public.admin_list_filing_tasks(p_status text default null)
returns table (
  offer_id uuid, task_status text, school_app_no text, note text,
  system text, timing text, created_at timestamptz, exported_at timestamptz,
  submitted_at timestamptz, decided_at timestamptz,
  student_id uuid, display_code text, app_no text, surname text, given_name text, email text,
  school_id uuid, school_name_zh text, school_name_en text, school_display_code text,
  school_filing_system text, school_filing_timing text, school_filing_url text, school_filing_account text,
  offered_program text, task_code text, letter_uploaded_at timestamptz, profile_completed_at timestamptz
) language sql stable security definer set search_path to 'public' as $function$
  select f.offer_id, f.status, f.school_app_no, f.note,
         f.system, f.timing, f.created_at, f.exported_at, f.submitted_at, f.decided_at,
         f.student_id, s.display_code, s.app_no, s.surname, s.given_name, s.email,
         f.school_id, sc.name_zh, sc.name_en, sc.display_code,
         sc.filing_system, sc.filing_timing, sc.filing_url, sc.filing_account,
         od.offered_program, od.task_code, od.letter_uploaded_at, p.completed_at
    from public.filing_tasks f
    left join public.students s   on s.id  = f.student_id
    left join public.schools  sc  on sc.id = f.school_id
    left join public.offer_decisions od on od.id = f.offer_id
    left join public.student_filing_profiles p on p.student_id = f.student_id
   where public.is_admin(auth.uid())
     and (p_status is null or f.status = p_status)
   order by f.created_at desc;
$function$;

-- 7.8 admin_set_filing_status —— 改状态 / 记申请号
create or replace function public.admin_set_filing_status(
  p_offer_id uuid, p_status text, p_school_app_no text, p_note text)
returns jsonb language plpgsql security definer set search_path to 'public' as $function$
declare v_uid uuid := auth.uid();
begin
  if not public.is_admin(v_uid) then raise exception 'admin only'; end if;
  if p_status not in ('waiting_student','pending','exported','submitted','approved','rejected','cancelled') then
    raise exception 'bad status'; end if;
  update public.filing_tasks set
    status = p_status,
    school_app_no = coalesce(p_school_app_no, school_app_no),
    note = coalesce(p_note, note),
    exported_at  = case when p_status = 'exported'  then now() else exported_at  end,
    submitted_at = case when p_status = 'submitted' then now() else submitted_at end,
    decided_at   = case when p_status in ('approved','rejected') then now() else decided_at end,
    updated_at = now(), updated_by = v_uid
   where offer_id = p_offer_id;
  if not found then raise exception 'filing task not found'; end if;
  insert into public.admin_events (event_type, actor_uid, detail)
  values ('filing_status_set', v_uid, jsonb_build_object('offer_id',p_offer_id,'status',p_status,'app_no',p_school_app_no));
  return jsonb_build_object('ok', true);
end $function$;

-- 7.9 admin_get_filing_pack —— 导出建档包用
create or replace function public.admin_get_filing_pack(p_offer_id uuid)
returns jsonb language plpgsql stable security definer set search_path to 'public' as $function$
declare v_sid uuid; v_school_id uuid; v_result jsonb;
begin
  if not public.is_admin(auth.uid()) then raise exception 'admin only'; end if;
  select student_id, school_id into v_sid, v_school_id from public.filing_tasks where offer_id = p_offer_id;
  if v_sid is null then raise exception 'filing task not found'; end if;
  select jsonb_build_object(
    'student', (select jsonb_build_object(
        'surname', s.surname, 'given_name', s.given_name, 'chinese_name', s.chinese_name,
        'gender', s.gender, 'nationality', s.nationality, 'country_iso', s.country_iso,
        'birth_date', s.birth_date, 'passport_no', s.passport_no, 'religion', s.religion,
        'in_china', s.in_china, 'hsk', s.hsk, 'statement', s.statement,
        'home_address', s.home_address, 'city', s.city, 'app_no', s.app_no, 'display_code', s.display_code)
      from public.students s where s.id = v_sid),
    'filing', (select p.data from public.student_filing_profiles p where p.student_id = v_sid),
    'documents', coalesce((
        select jsonb_agg(jsonb_build_object(
            'doc_id', d.doc_id, 'doc_type', d.doc_type, 'file_path', d.file_path,
            'file_name', d.file_name, 'size_kb', d.size_kb, 'uploaded_at', d.uploaded_at)
          order by d.uploaded_at desc)
        from (
          select distinct on (doc_type) doc_id, doc_type, file_path, file_name, size_kb, uploaded_at
            from public.documents
           where student_id = v_sid and deleted_at is null
           order by doc_type, uploaded_at desc
        ) d), '[]'::jsonb),
    'offer', (select jsonb_build_object('offered_program', od.offered_program, 'task_code', od.task_code, 'offer_details', od.offer_details)
        from public.offer_decisions od where od.id = p_offer_id),
    'school', (select jsonb_build_object('display_code', sc.display_code, 'name_en', sc.name_en,
        'filing_system', sc.filing_system, 'filing_timing', sc.filing_timing)
        from public.schools sc where sc.id = v_school_id)
  ) into v_result;
  return v_result;
end $function$;

-- RPC 授权：先收公众/匿名，再放给登录用户
revoke execute on function
  public.school_set_filing(text,text,text,text,text),
  public.admin_set_school_filing(uuid,text,text,text,text,text),
  public.get_my_filing(),
  public.get_agent_filing(uuid),
  public.save_my_filing(jsonb,boolean),
  public.agent_save_filing(uuid,jsonb,boolean),
  public.admin_list_filing_tasks(text),
  public.admin_set_filing_status(uuid,text,text,text),
  public.admin_get_filing_pack(uuid)
from public, anon;
grant execute on function
  public.school_set_filing(text,text,text,text,text),
  public.admin_set_school_filing(uuid,text,text,text,text,text),
  public.get_my_filing(),
  public.get_agent_filing(uuid),
  public.save_my_filing(jsonb,boolean),
  public.agent_save_filing(uuid,jsonb,boolean),
  public.admin_list_filing_tasks(text),
  public.admin_set_filing_status(uuid,text,text,text),
  public.admin_get_filing_pack(uuid)
to authenticated;

-- ============================================================ 8) 刷新 PostgREST + 验证 select
notify pgrst, 'reload schema';

-- 验证：期望 2 张新表 + 7 个新列 + 11 个新函数(9 RPC + 2 触发器函数… 共 12 含 gate)。
-- 卡1232 贴完按下面三条核行数。
\echo '=== V1 新表(期望 2 行) ==='
select table_name from information_schema.tables
 where table_schema='public' and table_name in ('student_filing_profiles','filing_tasks') order by table_name;
\echo '=== V2 schools 新列(期望 7 行) ==='
select column_name from information_schema.columns
 where table_schema='public' and table_name='schools'
   and column_name in ('filing_system','filing_timing','filing_url','filing_account','filing_note','filing_set_at','filing_set_by')
 order by column_name;
\echo '=== V3 新函数(期望 12 行: 9 RPC + 3 触发器函数) ==='
select proname from pg_proc p join pg_namespace n on n.oid=p.pronamespace
 where n.nspname='public' and proname in (
   'school_set_filing','admin_set_school_filing','get_my_filing','get_agent_filing',
   'save_my_filing','agent_save_filing','admin_list_filing_tasks','admin_set_filing_status','admin_get_filing_pack',
   'trg_filing_task_on_offer','trg_filing_profile_completed','trg_filing_gate')
 order by proname;

```
