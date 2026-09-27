-- JOB-26-00 R2 旧病先红：0217 现行层次过滤，lang 任务查不到 chinese_lang 桩生。begin/rollback，绝不落库。
begin;
-- 桩 uid（假装某学校成员登录）
select set_config('request.jwt.claims', json_build_object('sub','aaaaaaaa-0000-0000-0000-000000000001')::text, true);

insert into auth.users(id) values ('aaaaaaaa-0000-0000-0000-000000000001');
-- 桩学校 + 成员
insert into schools(id, status, is_test) values ('bbbbbbbb-0000-0000-0000-000000000001','active', true);
insert into school_members(school_id, user_id) values ('bbbbbbbb-0000-0000-0000-000000000001','aaaaaaaa-0000-0000-0000-000000000001');

-- 桩任务：lang（照 ADM-100003 形状：programLevel=lang, age 18-60）+ exchange + master 对照
insert into admission_tasks(task_code, school_id, status, majors, detail) values
 ('ZZ-LANG','bbbbbbbb-0000-0000-0000-000000000001','active','[]'::jsonb,
   '{"programLevel":"lang","criteria":{"ageMin":"18","ageMax":"60"}}'::jsonb),
 ('ZZ-EXCH','bbbbbbbb-0000-0000-0000-000000000001','active','[]'::jsonb,
   '{"programLevel":"exchange","criteria":{"ageMin":"18","ageMax":"60"}}'::jsonb),
 ('ZZ-MAST','bbbbbbbb-0000-0000-0000-000000000001','active','[]'::jsonb,
   '{"programLevel":"master","criteria":{"ageMin":"18","ageMax":"60"}}'::jsonb);

-- 桩学生：①chinese_lang(照 sa12：target_program=master + 数组含 chinese_lang) ②short_term ③纯 master 对照
insert into students(id, email, given_name, surname, age, in_china, submitted_at, target_program, target_programs, exposure_level) values
 ('cccccccc-0000-0000-0000-000000000001','zz1@test.local','Zzlang','T',26,true, now(),'master',
   '[{"value":"master","majors":["CS","BA","IT"]},{"value":"chinese_lang","majors":[]}]'::jsonb,'normal'),
 ('cccccccc-0000-0000-0000-000000000002','zz2@test.local','Zzshort','T',22,false, now(),'short_term',
   '[{"value":"short_term","majors":[]}]'::jsonb,'normal'),
 ('cccccccc-0000-0000-0000-000000000003','zz3@test.local','Zzmast','T',28,true, now(),'master',
   '[{"value":"master","majors":["CS"]}]'::jsonb,'normal');

-- ── R2 判定 ──
select '一键匹配 match_task_candidates(lang) → chinese_lang 生命中数' as probe,
       public.match_task_candidates('aaaaaaaa-0000-0000-0000-000000000001','ZZ-LANG') as n_expect_RED_0;
select 'search_students_blind(lang) 命中 chinese_lang 桩生行数' as probe,
       count(*) as n_expect_RED_0
  from public.search_students_blind('aaaaaaaa-0000-0000-0000-000000000001','ZZ-LANG','lang')
  where student_id='cccccccc-0000-0000-0000-000000000001';
select 'search_students_global(lang) 命中 chinese_lang 桩生行数' as probe,
       count(*) as n_expect_RED_0
  from public.search_students_global('aaaaaaaa-0000-0000-0000-000000000001','lang')
  where student_id='cccccccc-0000-0000-0000-000000000001';
select 'match_task_candidates(exchange) → short_term 生命中数' as probe,
       public.match_task_candidates('aaaaaaaa-0000-0000-0000-000000000001','ZZ-EXCH') as n_expect_RED_0;
-- 对照：master 任务应能匹配 master 生（证明桩没写错）
select 'CONTROL match_task_candidates(master) → master 生命中数' as probe,
       public.match_task_candidates('aaaaaaaa-0000-0000-0000-000000000001','ZZ-MAST') as n_expect_GREEN_ge1;
rollback;
