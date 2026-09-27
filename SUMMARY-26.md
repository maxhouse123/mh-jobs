PUSH_OK=yes

# SUMMARY-26 · 第二十六轮（快车道）收官

主题一句话：学生端把「语言生」存成 chinese_lang、把「短期/交换」存成 short_term，学校端把同两样存成 lang、exchange，两端拼法不同，害得学校端「一键匹配」永远搜不到语言生/交换生。本轮**两端存值都不动，只在比对时归一**，把这条修通。快车道只出 school v238 + 一份只写不执行的迁移 0219，其余四端、云函数一律没碰。

## 版本 / md5 账
| 端 | 版本 | md5 | 本轮 |
|---|---|---|---|
| school | **v238** | `ce2cb39437e044383227949423188023` | 升（层次归一） |
| admin | v234 | `c81fc57928849b49a9376a060c369882` | 未动 |
| student | v402 | `b8b87c535afab0cf66f88ef1a3da3446` | 未动 |
| partner | v171 | `790f03221da55e34a4d25272b3a18367` | 未动 |
| reviewer | v46 | `2d4269e9c570481b99b95d70a3691082` | 未动 |

迁移：新写 `supabase/migrations/0219_level_aliases.sql`（**只写文件、未执行到线上**，等业主手贴，全文见附录）。

## 三包各一句话
- **26-00**（只读）：核对基线全对；把病用证据先「照红」——学校端前端打分器、库端三个 RPC、静态 grep 三层全红，对照组绿，证明病确实在、桩没写错。
- **26-01**（库端）：写迁移 0219——新增同义表函数 `_mh_level_aliases`，把库里三个带层次条件的函数（`search_students_global` / `search_students_blind` / `match_task_candidates`＝一键匹配本体）的等值比较改成「在同义组内」；本地 begin…rollback 验六组＋负例全绿，线上库一行没动。
- **26-02**（前端）：出 school v238——新增 `_v238LevelAliases` / `_v238LevelIs`，把 `_v236MatchLevel` 和六处层次比对全部改走同义组；无头真渲染「一键匹配」中英各一遍，语言生端到端被搜到、层次标签中英都真、零裸键、零 pageerror、零改皮。

## 闸账（每包回执有逐条证据）
- **旧病 R1→绿**：chinese_lang 生配 lang 任务、short_term 生配 exchange 任务，26-00 返回 null（红）→ 26-02 返回 matched（绿）；master 对照恒绿、doctor 负例恒不串。
- **旧病 R2→绿**：库端 lang 任务命中 chinese_lang 桩生，26-00 命中 0（红）→ 0219 探针命中 ≥1（绿）；exchange↔short_term 同；master 对照绿、doctor 负例 0。
- **旧病 R3→绿**：v237 三处裸 `programLevel === 'chinese_lang'`（红）→ v238 全部改走 `_v238LevelIs`，操作代码里裸层次比对 = 0。
- **N1 零消失**：v237↔v238 函数/id/onclick 只增不减（仅 +2 函数）；库端只加 `_mh_level_aliases` + 改三函数体，签名/返回列不变、无 drop。
- **P3 静态断言**：三库函数体均含 `_mh_level_aliases`；前端裸比对清零。
- **闸8 无头真渲染**：一键匹配全链中英各一遍通过。
- **闸9 视觉零新增**：class 计数 v237=v238=2394，未加任何样式/组件。
- **secret-scan**：过（无密钥/JWT/密码；service_role 仅既有架构注释）。
- **STOP**：`~/mh-verify/r26-STOP.txt` 不存在（无「必须停」触发）。

## 主仓库推送状态（待业主用卡1200 推）
本地 main 领先 origin/main **2 笔**，全为本轮：
- `dcccf3e` JOB-26-01 迁移0219（只写不执行）
- `04e6517` JOB-26-02 school v238
CC 未 push（铁律4）。PUSH_OK=yes（CC 自验全过）。

## 待业主手贴的 SQL：迁移 0219（全文 + 验证法）
**怎么贴**：整段附录贴进 Supabase SQL Editor 跑一次（它自带 begin…commit）。
**验证法**：贴完后在学校端打开升级后的 v238，对 ADM-100003 点「一键匹配」，应能看到 sa12 / sa13。也可在 SQL Editor 只读自检：
```
select proname, pg_get_functiondef(oid) like '%_mh_level_aliases%' as uses_alias
  from pg_proc where proname in ('search_students_global','search_students_blind','match_task_candidates');
-- 三行 uses_alias 都应为 t
```

### 附录 A · 0219_level_aliases.sql 全文
```sql
-- 【迁移 0219】层次同义归一（库端）—— 汉语言 {lang, chinese_lang}、短期/交换 {exchange, short_term}。
--
-- 背景（第二十六轮 26-01）：学生端把「语言生」存 chinese_lang、「短期/交换」存 short_term；
--   学校端建任务把同两样存 lang、exchange。0217 三处层次过滤用「相等比较」
--   （target_program = X or target_programs @> [{value:X}]），所以 lang 任务永远配不上 chinese_lang 学生，
--   exchange 配不上 short_term（本科/硕士/博士/专科两端拼法相同，未暴露）。
--   修法：两端存值都不改，比对时归一——新增 _mh_level_aliases(p) 返回同义组，
--   三个带层次条件的函数把等值比较改为「在同义组内」。
--
-- 房规遵守（铁律9 新增式）：本迁移只 CREATE OR REPLACE 函数体、只加新函数 _mh_level_aliases，
--   返回类型 / 签名 / 其余行为一字不改（无需 drop）。不删数据、不改任何列、不动 target_program / major
--   的写入含义、不动 get_task_candidates（它本就不按层次过滤）、不动 add_task_candidate（无层次筛）。
--
-- ⚠ 卡 26-01 正文点名「search_students_global / search_students_blind / get_task_candidates」三读函数，
--   但经 CC 复核 0217 原文：get_task_candidates 本身无层次条件（只读候选池），无处可改；
--   真正带 `target_program = X or target_programs @> …` 层次条件的是三个——
--   search_students_global、search_students_blind、match_task_candidates（「一键匹配」RPC 本体）。
--   按卡「凡 0217 写的该条件…改为…」的全称口径，本迁移把三处一并归一；get_task_candidates 不动。
--
-- 手贴执行：整段贴入 Supabase SQL Editor 运行一次。CC 不自主连库执行；本地只跑 begin…rollback 探针
--   （见 jobs/JOB-26-01/probe-0219.sql，在事务内建函数+插桩+校验后 rollback，绝不落库）。

begin;

-- ── ① 新助手：层次同义组（§0.5 唯一定义）──
--    lang↔chinese_lang、exchange↔short_term 互为同义；associate/bachelor/master/doctor 同名；
--    未知值返回 array[p]；null 返回空数组。immutable 纯函数。
create or replace function public._mh_level_aliases(p text)
returns text[]
language sql immutable
set search_path to 'public'
as $fn$
  select case
    when p is null then array[]::text[]
    when p in ('lang','chinese_lang')  then array['lang','chinese_lang']
    when p in ('exchange','short_term') then array['exchange','short_term']
    else array[p]
  end;
$fn$;
grant execute on function public._mh_level_aliases(text) to authenticated;

-- ── ② search_students_global：层次过滤改走同义组（其余行一字不改）──
CREATE OR REPLACE FUNCTION public.search_students_global(uid uuid, p_program_level text DEFAULT NULL::text, p_gpa_min numeric DEFAULT NULL::numeric, p_hsk_min integer DEFAULT NULL::integer, p_major text DEFAULT NULL::text, p_nationality text DEFAULT NULL::text, p_age_min integer DEFAULT NULL::integer, p_age_max integer DEFAULT NULL::integer, p_limit integer DEFAULT 200, p_gender text DEFAULT NULL::text, p_in_china boolean DEFAULT NULL::boolean, p_funding text DEFAULT NULL::text, p_countries text[] DEFAULT NULL::text[])
 RETURNS TABLE(student_id uuid, surname text, given_name text, nationality text, country_iso text, city text, age integer, gender text, major text, target_program text, target_programs jsonb, semester text, gpa numeric, hsk text, csca text, in_china boolean, birth_date date, passport_no text, funding jsonb, statement text, app_no text)
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select
    s.id, s.surname, s.given_name, s.nationality, s.country_iso, s.city,
    s.age, s.gender, s.major, s.target_program, s.target_programs, s.semester,
    s.gpa, s.hsk, s.csca, s.in_china,
    s.birth_date, s.passport_no, s.funding, s.statement,
    s.app_no
  from students s
  where uid = auth.uid()
    and exists (
      select 1 from school_members sm
      join schools sc on sc.id = sm.school_id
      where sm.user_id = uid and sc.status = 'active'
    )
    and _student_submitted(s.given_name, s.age) and s.submitted_at is not null
    and public.student_exposure_level(s.id) <> 'blocked'
    -- 0219: 层次过滤归一为「单值∈同义组 或 数组任一层次∈同义组」
    and (p_program_level is null
         or s.target_program = any(public._mh_level_aliases(p_program_level))
         or exists (select 1 from jsonb_array_elements(coalesce(s.target_programs,'[]'::jsonb)) e
                    where e->>'value' = any(public._mh_level_aliases(p_program_level))))
    and (p_gpa_min is null or coalesce(s.gpa, -1) >= p_gpa_min)
    and (p_hsk_min is null or coalesce(nullif(regexp_replace(coalesce(s.hsk,''),'[^0-9]','','g'),'')::int, -1) >= p_hsk_min)
    and (p_major is null or s.major ilike ('%'||p_major||'%'))
    and (p_nationality is null or s.nationality ilike ('%'||p_nationality||'%'))
    and (p_age_min is null or coalesce(s.age, -1) >= p_age_min)
    and (p_age_max is null or coalesce(s.age, 999) <= p_age_max)
    and (p_gender is null or s.gender = p_gender)
    and (p_in_china is null or s.in_china = p_in_china)
    and (p_countries is null or s.nationality = any(p_countries))
    and (p_funding is null
         or (p_funding = 'self'       and coalesce(s.funding, '[]'::jsonb) ? 'self_funded')
         or (p_funding = 'government' and coalesce(s.funding, '[]'::jsonb) ? 'government'))
  order by s.given_name asc
  limit greatest(1, least(coalesce(p_limit, 200), 500));
$function$;
grant execute on function public.search_students_global(uuid, text, numeric, integer, text, text, integer, integer, integer, text, boolean, text, text[]) to authenticated;

-- ── ③ search_students_blind：层次过滤改走同义组（返回列集/双盲边界一字不改）──
CREATE OR REPLACE FUNCTION public.search_students_blind(uid uuid, p_task_code text, p_program_level text DEFAULT NULL::text, p_gpa_min numeric DEFAULT NULL::numeric, p_hsk_min integer DEFAULT NULL::integer, p_major text DEFAULT NULL::text, p_nationality text DEFAULT NULL::text, p_age_min integer DEFAULT NULL::integer, p_age_max integer DEFAULT NULL::integer, p_limit integer DEFAULT 200, p_gender text DEFAULT NULL::text, p_in_china boolean DEFAULT NULL::boolean, p_funding text DEFAULT NULL::text, p_countries text[] DEFAULT NULL::text[])
 RETURNS TABLE(student_id uuid, surname text, given_name text, nationality text, country_iso text, city text, age integer, gender text, major text, target_program text, target_programs jsonb, semester text, gpa numeric, hsk text, csca text, in_china boolean, birth_date date, passport_no text, funding jsonb, statement text, in_pool boolean)
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select
    s.id, s.surname, s.given_name, s.nationality, s.country_iso, s.city,
    s.age, s.gender, s.major, s.target_program, s.target_programs, s.semester,
    s.gpa, s.hsk, s.csca, s.in_china,
    s.birth_date, s.passport_no, s.funding, s.statement,
    exists (select 1 from task_candidates tc where tc.task_code = p_task_code and tc.student_id = s.id) as in_pool
  from students s
  where uid = auth.uid()
    and exists (
      select 1 from admission_tasks at
      join school_members sm on sm.school_id = at.school_id
      where at.task_code = p_task_code and sm.user_id = uid
    )
    and _student_submitted(s.given_name, s.age)
    -- 0219: 层次过滤归一为「单值∈同义组 或 数组任一层次∈同义组」
    and (p_program_level is null
         or s.target_program = any(public._mh_level_aliases(p_program_level))
         or exists (select 1 from jsonb_array_elements(coalesce(s.target_programs,'[]'::jsonb)) e
                    where e->>'value' = any(public._mh_level_aliases(p_program_level))))
    and (p_gpa_min is null or coalesce(s.gpa, -1) >= p_gpa_min)
    and (p_hsk_min is null or coalesce(nullif(regexp_replace(coalesce(s.hsk,''),'[^0-9]','','g'),'')::int, -1) >= p_hsk_min)
    and (p_major is null or s.major ilike ('%'||p_major||'%'))
    and (p_nationality is null or s.nationality ilike ('%'||p_nationality||'%'))
    and (p_age_min is null or coalesce(s.age, -1) >= p_age_min)
    and (p_age_max is null or coalesce(s.age, 999) <= p_age_max)
    and (p_gender is null or s.gender = p_gender)
    and (p_in_china is null or s.in_china = p_in_china)
    and (p_countries is null or s.nationality = any(p_countries))
    and (p_funding is null
         or (p_funding = 'self'       and coalesce(s.funding, '[]'::jsonb) ? 'self_funded')
         or (p_funding = 'government' and coalesce(s.funding, '[]'::jsonb) ? 'government'))
  order by s.given_name asc
  limit greatest(1, least(coalesce(p_limit, 200), 500));
$function$;
grant execute on function public.search_students_blind(uuid, text, text, numeric, integer, text, text, integer, integer, integer, text, boolean, text, text[]) to authenticated;

-- ── ④ match_task_candidates：一键匹配的层次判定改走同义组（函数体其余一字不改）──
CREATE OR REPLACE FUNCTION public.match_task_candidates(uid uuid, p_task_code text)
 RETURNS integer
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
declare
  _ok      boolean;
  _d       jsonb;
  _level   text;
  _gpa     numeric;
  _hsk     int;
  _agemin  int;
  _agemax  int;
  _csca    text;
  _n       int;
begin
  if uid is null or uid <> auth.uid() then
    raise exception 'match_task_candidates: caller mismatch';
  end if;
  select exists (
    select 1 from admission_tasks at
    join school_members sm on sm.school_id = at.school_id
    where at.task_code = p_task_code and sm.user_id = uid and at.status = 'active'
  ) into _ok;
  if not _ok then
    raise exception 'match_task_candidates: task not found / not yours / not active';
  end if;

  select detail into _d from admission_tasks where task_code = p_task_code;
  _level  := nullif(_d->>'programLevel','');
  _gpa    := nullif(_d->'criteria'->>'gpa','')::numeric;
  _hsk    := nullif(regexp_replace(coalesce(_d->'criteria'->>'hsk',''),'[^0-9]','','g'),'')::int;
  _agemin := nullif(_d->'criteria'->>'ageMin','')::int;
  _agemax := nullif(_d->'criteria'->>'ageMax','')::int;
  _csca   := nullif(_d->'criteria'->>'csca','');

  with ins as (
    insert into task_candidates (task_code, student_id)
    select p_task_code, s.id
    from students s
    where _student_submitted(s.given_name, s.age)
      -- 0219: 层次判定归一为「单值∈同义组 或 数组任一层次∈同义组」
      and (_level  is null
           or s.target_program = any(public._mh_level_aliases(_level))
           or exists (select 1 from jsonb_array_elements(coalesce(s.target_programs,'[]'::jsonb)) e
                      where e->>'value' = any(public._mh_level_aliases(_level))))
      and (_gpa    is null or coalesce(s.gpa, -1) >= _gpa)
      and (_hsk    is null or coalesce(nullif(regexp_replace(coalesce(s.hsk,''),'[^0-9]','','g'),'')::int, -1) >= _hsk)
      and (_agemin is null or coalesce(s.age, -1) >= _agemin)
      and (_agemax is null or coalesce(s.age, 999) <= _agemax)
      and (_csca   is null or
           coalesce(array_position(array['D','C','B','A'], upper(nullif(s.csca,''))), -1)
             >= array_position(array['D','C','B','A'], upper(_csca)))
    on conflict (task_code, student_id) do nothing
    returning 1
  )
  select count(*)::int into _n from ins;

  return coalesce(_n, 0);
end;
$function$;
grant execute on function public.match_task_candidates(uuid, text) to authenticated;

commit;

-- ═══════════════════════════════════════════════════════════════════
-- 验证（另跑，begin/rollback，绝不落库）—— 见 jobs/JOB-26-01/probe-0219.sql。
--   桩：lang 任务 + chinese_lang 学生、exchange 任务 + short_term 学生、master 任务 + master 学生。
--   期望：lang 查到 chinese_lang 桩生、exchange 查到 short_term、master 查到 master、doctor 查不到 master。
-- 静态自检（只读）：
--   select proname, pg_get_functiondef(oid) like '%_mh_level_aliases%' as uses_alias
--     from pg_proc where proname in
--     ('search_students_global','search_students_blind','match_task_candidates');
-- ═══════════════════════════════════════════════════════════════════
-- 0219 完。新增 _mh_level_aliases + 三个带层次条件函数归一（same signature, body-only）。
```

## 需业主一句话拍板 / 未放行清单
1. **0219 是否把 `match_task_candidates` 一并纳入归一**（CC 已纳入）：卡 26-01 正文点名的第三个函数是 `get_task_candidates`，但 CC 复核 0217 原文发现它本身不按层次过滤（只读候选池），无处可改；真正带层次条件的第三个是 `match_task_candidates`（＝「一键匹配」RPC 本体）。CC 按卡「凡…改为…」全称口径把它一并归一了。若不认可，请一句话示下，下一趟改回。
2. **0219 未落线上**——等业主手贴（附录 A）。未贴前：学校端 v238 前端已归一，但库端「筛选添加」「服务端 match」两条路仍按旧拼法；一键匹配主路径（前端筛）在 v238 上线后即通，其余两路待 0219 贴后通。
3. **v238 未推送**——待卡1200。

## 要业主亲眼看的（线上验收，需先推 v238 + 贴 0219）
- 学校端 ADM-100003 →「一键匹配」→ 应出现 sa12 / sa13（本轮核心验收点）。
- 顺带看语言/交换任务的「发送 offer」按钮、「决定录取专业」模块对 lang/exchange 任务行为正常（v238 三处发送分支已双拼）。

## 第二十七轮建议包（图纸见 QUEUE-26 文末附录，原样搬用）
- **27-A** · admin v235 + partner v172：管理端/中介端**层次显示与比对归一**（任务审批卡/详情/学生列表/抽屉/导出的层次映射同认 lang→汉语言、exchange→短期；按层次比对处走 `_v235LevelIs` / `_v172LevelIs`）。四件套（管理端中英、中介端四语）。
- **27-B** · EF `admin-reset-student-password`（只写不部署）+ admin v236「重置密码」按钮：管理员给收不到重置邮件的学生生成一次性临时密码（服务端校 is_admin、`updateUserById` 设随机 12 位、写 admin_events 永不写密码、返回体只回 temp_password）；admin 抽屉加按钮 + 确认框 + 复制。EF 只跑本地 deno 语法检查、不部署。
- **补充建议**（业主此前列过，一并排期）：
  - 中介代填**多层次写入**（submit_referral / student_agent_application 加 p_target_programs，把 0217 放开的多层次落到代填链）。
  - **自定义 SMTP 配置单**（邮件通道自管，替当前默认发信）。
  - **数据洞察真版**（admin 数据面板从 mock/演示改真库聚合）。
  - **范例库云端版**（材料范例/驳回样例从前端内置改云端可维护）。

—— 第二十六轮完。
