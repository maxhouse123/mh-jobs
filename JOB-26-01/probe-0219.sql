-- JOB-26-01 probe-0219: 事务内建 0219 函数 + 插桩 + 校验四组 + 静态含 _mh_level_aliases，末尾 rollback。绝不落库。
begin;
select set_config('request.jwt.claims', json_build_object('sub','aaaaaaaa-0000-0000-0000-000000000001')::text, true);
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

-- ── 插桩（照 26-00 R2 同形状）──
insert into auth.users(id) values ('aaaaaaaa-0000-0000-0000-000000000001');
insert into schools(id, status, is_test) values ('bbbbbbbb-0000-0000-0000-000000000001','active', true);
insert into school_members(school_id, user_id) values ('bbbbbbbb-0000-0000-0000-000000000001','aaaaaaaa-0000-0000-0000-000000000001');
insert into admission_tasks(task_code, school_id, status, majors, detail) values
 ('ZZ-LANG','bbbbbbbb-0000-0000-0000-000000000001','active','[]'::jsonb,'{"programLevel":"lang","criteria":{"ageMin":"18","ageMax":"60"}}'::jsonb),
 ('ZZ-EXCH','bbbbbbbb-0000-0000-0000-000000000001','active','[]'::jsonb,'{"programLevel":"exchange","criteria":{"ageMin":"18","ageMax":"60"}}'::jsonb),
 ('ZZ-MAST','bbbbbbbb-0000-0000-0000-000000000001','active','[]'::jsonb,'{"programLevel":"master","criteria":{"ageMin":"18","ageMax":"60"}}'::jsonb),
 ('ZZ-DOC','bbbbbbbb-0000-0000-0000-000000000001','active','[]'::jsonb,'{"programLevel":"doctor","criteria":{"ageMin":"18","ageMax":"60"}}'::jsonb);
insert into students(id, email, given_name, surname, age, in_china, submitted_at, target_program, target_programs, exposure_level) values
 ('cccccccc-0000-0000-0000-000000000001','zz1@test.local','Zzlang','T',26,true, now(),'master','[{"value":"master","majors":["CS","BA","IT"]},{"value":"chinese_lang","majors":[]}]'::jsonb,'normal'),
 ('cccccccc-0000-0000-0000-000000000002','zz2@test.local','Zzshort','T',22,false, now(),'short_term','[{"value":"short_term","majors":[]}]'::jsonb,'normal'),
 ('cccccccc-0000-0000-0000-000000000003','zz3@test.local','Zzmast','T',28,true, now(),'master','[{"value":"master","majors":["CS"]}]'::jsonb,'normal');

-- ── 校验（期望绿）──
select 'G1 match(lang)→chinese_lang 桩生命中' as probe, public.match_task_candidates('aaaaaaaa-0000-0000-0000-000000000001','ZZ-LANG') as n_expect_GREEN_ge1;
select 'G2 blind(lang)→chinese_lang 桩生行数' as probe, count(*) as n_expect_GREEN_1
  from public.search_students_blind('aaaaaaaa-0000-0000-0000-000000000001','ZZ-LANG','lang') where student_id='cccccccc-0000-0000-0000-000000000001';
select 'G3 global(lang)→chinese_lang 桩生行数' as probe, count(*) as n_expect_GREEN_1
  from public.search_students_global('aaaaaaaa-0000-0000-0000-000000000001','lang') where student_id='cccccccc-0000-0000-0000-000000000001';
select 'G4 blind(exchange)→short_term 桩生行数' as probe, count(*) as n_expect_GREEN_1
  from public.search_students_blind('aaaaaaaa-0000-0000-0000-000000000001','ZZ-EXCH','exchange') where student_id='cccccccc-0000-0000-0000-000000000002';
select 'G5 blind(master)→master 桩生行数(对照)' as probe, count(*) as n_expect_GREEN_1
  from public.search_students_blind('aaaaaaaa-0000-0000-0000-000000000001','ZZ-MAST','master') where student_id='cccccccc-0000-0000-0000-000000000003';
select 'G6 blind(doctor)→master 桩生行数(负例应0)' as probe, count(*) as n_expect_0
  from public.search_students_blind('aaaaaaaa-0000-0000-0000-000000000001','ZZ-DOC','doctor') where student_id='cccccccc-0000-0000-0000-000000000003';
-- ── 静态：三函数体含 _mh_level_aliases ──
select proname, (pg_get_functiondef(oid) like '%_mh_level_aliases%') as uses_alias
  from pg_proc where proname in ('search_students_global','search_students_blind','match_task_candidates') order by proname;
rollback;
