PUSH_OK=yes

# 第二十五轮 收官总账（SUMMARY-25）

> 主题 A：学生一次最多选 3 个学历层次、每层最多 3 个专业，但只有第一个层次和它的第一个专业上了云，导致学校 / 管理 / 中介三端只看到一个层次一个专业。本轮把**全部层次与专业**贯通到库、到三端显示、到候选池匹配。
> 主题 B：只要学生传过**证件照（人脸照）**，学校端与管理端在列表和档案里就**直接显示照片、不等审核**；没传的才用首字母。其它材料仍等审核后才显示。
>
> 本轮七包全部完成、七层自验全绿、零移除、无 STOP。前端代码可推（对"迁移 / 云函数还没贴 / 还没部署"一律容错，贴不贴都不报错、不白屏）。SQL 手贴与云函数部署是**业主收官后的动作**，下面写清楚了命令与验法。

---

## 一、PUSH_OK 判定

**PUSH_OK=yes**（顶格已写在第一行）。

- 七包（25-00 ~ 25-06）主仓库各一笔提交，全部**已 commit、未 push**（等业主用卡 1187 推）。
- 每包随卡无头测试全绿；零移除；secret-scan 干净；无 `~/mh-verify/r25-STOP.txt`（本轮无"必须停"）。
- 前端三端（student v402 / school v236·v237 / admin v233·v234 / partner v171）对**迁移 0217 / 0218 未贴、云函数 v37 未部署**全部容错——所以先推前端、后贴 SQL / 部署 EF，顺序安全，中间态不报错。

---

## 二、版本 / md5 账

| 端 | 版本 | md5 | 说明 |
|---|---|---|---|
| student | v402 | `b8b87c535afab0cf66f88ef1a3da3446` | 主题 A：多层次多专业落库 / 回填 / 匹配 |
| school | v236 | `6de0966bc777ffcd2e83da51c226ad46` | 主题 A：全部层次专业显示 + 候选池按数组匹配 |
| school | v237 | `af8fa97ff007e98cc9fee941c7f5ce25` | 主题 B：人脸照即时显示（列表/搜索/候选卡/档案头像） |
| admin | v233 | `8af0c1782b023eb92fe2862e862e8a94` | 主题 A：全部层次专业显示（列表/抽屉/导出） |
| admin | v234 | `c81fc57928849b49a9376a060c369882` | 主题 B：人脸照即时显示（列表 + 抽屉） |
| partner | v171 | `790f03221da55e34a4d25272b3a18367` | 主题 A：学生卡显示全部层次 |
| EF watermark-doc | v37（源码，未部署） | `a27eebe5a6c5e090e9f493e3dced5db0` | +人脸小图分支 `kind:'avatar'`（160px、不打字、旧客户端零回归） |

> 五端"连云前基线"未受影响；本轮只加不删。

---

## 三、七包一句话

| 包 | 提交 | 一句话 |
|---|---|---|
| 25-00 | `94b51f1` | 开工：家底核对 + 四端 N1 基线 + 6 名多层次/证件照桩 + R1–R5 旧病先红（零报错） |
| 25-01 | `9f44481` | 迁移 0217（只写文件）+ student v402：全部层次专业落库 / 回填 / 匹配 |
| 25-02 | `f871f9c` | school v236：学生全部层次专业显示 + 候选池按数组匹配 |
| 25-03 | `fa1f534` | admin v233 + partner v171：全部层次专业显示 |
| 25-04 | `a3b95dd` | 迁移 0218（只写文件）+ EF watermark-doc v37（只改源码不部署）：人脸照取用通道 |
| 25-05 | `65c567e` | school v237：人脸证件照即时显示（不等审核） |
| 25-06 | `4b30e9e` | admin v234：人脸证件照即时显示（学生列表 + 抽屉，不等审核） |

---

## 四、闸账

- **R1–R5 旧病 先红→后绿**：25-00 把五处旧病复现为红（学生端 payload 无 target_programs / 学校档案只显一层一专业 / 学校全局列表与未审核照片显首字母 / 管理端头像全首字母且层次只显一个 / 中介端只显一个层次）；25-01~25-06 逐一转绿，随卡无头测试见各 `jobs/JOB-25-0X/green-0X.mjs`。
- **N1 零移除**：每包用 `jobs/JOB-25-00/inventory/gen.mjs` 抽 ids / handlers / functions，新版 ⊇ 旧版基线，任一消失即闸红。七包全过（均为"只增函数"，零丢失）。
- **P3 随卡断言入仓**：每包随卡 jsdom / Playwright 断言脚本入 `jobs/JOB-25-0X/`，施工后全绿方 commit。
- **闸8 无头真渲染中英各一遍**：各端在本地 `file://` 无头浏览器里真调渲染函数（`window.sb` / `fetch` 全 stub 受控数据）；主题 B 两包（25-05 school 34 过 / 25-06 admin 35 过）中英文各跑一遍。
- **闸9 视觉零新增**：头像显示复用各端既有类（学校 LOGO 同款 `overflow:hidden;padding:0` + `object-fit:cover` + onerror 回退首字母），**零新 CSS 色 / 字号 / 样式类**。
- **secret-scan**：七包改动文件里无密钥 / 密码 / 连接串（唯一命中是历史头注里作说明文字的 "service_role" 与早已存在的 LOGO 图片 base64，均非本轮新增、非密钥）。
- **线上真登冒烟**：**本轮未做**。原因：`~/mh-verify/accounts.json` 虽在，但本轮新版**尚未 push / 未部署**，线上跑的是旧版；对旧版做真登冒烟验不出本轮新功能，反而多碰生产。全程以本地无头 + stub 为主。**真·线上验收留业主在推送 + 贴 SQL + 部署 EF 之后做**（见第七节）。

---

## 五、待业主手贴 SQL（0217 / 0218 全文附录 + 验证法）

**做法**：整段各贴入 Supabase SQL Editor（maxhouse_main）运行一次。两段各自 `begin … commit`，一次跑完。CC 全程未连库执行，只在本地跑过 `begin…rollback` 探针（`jobs/JOB-25-01/probe-0217.sql`、`jobs/JOB-25-04/probe-0218.sql`）。

### 5.1 迁移 0217（多层次多专业）验证法
贴完后在 SQL Editor 单跑这三条只读自检：
1. **列存在**：`select column_name, data_type, column_default from information_schema.columns where table_name='students' and column_name='target_programs';` → 期望 `jsonb`、默认 `'[]'::jsonb`。
2. **三个读 RPC 多回该列**：`select proname, pg_get_function_result(oid) like '%target_programs%' as has_tp from pg_proc where proname in ('search_students_global','search_students_blind','get_task_candidates');` → 三行 `has_tp = true`。
3. **层次数组匹配**：对一名两层桩生按第二个层次能查得到（探针见 `jobs/JOB-25-01/probe-0217.sql`）。

### 5.2 迁移 0218（人脸照取用通道）验证法
贴完后单跑：
1. **两个函数在、返回类型对**：`select proname, pg_get_function_result(oid) from pg_proc where proname in ('get_student_photo','_mh_school_can_see_student');` → `get_student_photo` 返回含 `doc_id text` / `file_name text` / `uploaded_at timestamp with time zone`；`_mh_school_can_see_student` 返回 `boolean`。
2. **取件逻辑**（对桩生取最新未审核照片、软删排除、不可见学校取不到）：探针 `jobs/JOB-25-04/probe-0218.sql`。
3. **端到端 auth.uid() 三分支**（管理员取到 / 学校成员取到 / 陌生人取空）：psql 会话里 `auth.uid()` 恒空、外键难伪造 → **留业主贴库后用真实测试账号在浏览器里验一次**。

> ⚠ 提醒：0218 的 `get_student_photo` 返回的是 **`doc_id text`**（不是卡里笔误的 uuid）——`documents.doc_id` 真列是 text 主键，与姊妹函数 `get_candidate_documents` 镜像一致。

**两段 SQL 全文见文末【附录 A / 附录 B】**（逐字节即库内 `supabase/migrations/0217_target_programs.sql` / `0218_student_photo.sql`）。

---

## 六、EF 部署（watermark-doc v37）

云函数**只改了源码、未部署**。业主贴完 0218 后部署：

```
# 仓库根，挂代理
cd /Volumes/Dev/MAXHOUSE
supabase functions deploy watermark-doc --project-ref <maxhouse_main 的 project-ref>
```

- **预期版本**：部署后该函数为 **v37**（源码头注 `JOB-25-04 (2026-09-27, v36→v37)`；新增可选请求体 `kind:'avatar'` 分支）。
- **部署后应看到的变化**：学校端学生列表 / 档案头像里，传过证件照的学生的头像，会**从原来的"水印大图缩放显示"变成 160px 的人脸小图**（不打水印字、按 `kind:'avatar'` 走小图分支）。
- **回归红线**：不传 `kind` 的旧调用（reviewer 取原件、admin 取原件）行为与 v36 **逐字一致**（静态断言 `tests/job25-04-ef-avatar.mjs`）。
- **管理端 v234 不依赖 EF**：管理员是直接读桶签名（createSignedUrls），贴不贴 0218、部不部署 v37，管理端照样显示照片。EF v37 只影响**学校端**的小图效果。

---

## 七、未放行清单 / 要业主亲眼看的条目

**未放行（等业主动作）**：
1. **主仓库七笔提交未 push** —— 用卡 1187 推（那张卡认本文件 `PUSH_OK=yes`）。
2. **迁移 0217 / 0218 未贴库** —— 见第五节，业主 SQL Editor 手贴 + 自检。
3. **云函数 watermark-doc v37 未部署** —— 见第六节。

**要业主亲眼看的条目（推 + 贴 SQL + 部署 EF 之后，在浏览器里验收）**：
1. **主题 A**：一名选了"语言生 + 硕士"两个层次的学生 —— 学校端档案、管理端列表 / 抽屉 / 导出、中介端学生卡，**都应显示全部层次与全部专业**（不再只显"硕士 · 一个专业"）。
2. **主题 B（学校端）**：学校端学生列表里，**传过证件照的学生一律显示照片**（含刚上传还没审核的），没传的显示首字母；点开档案头像也是照片。（依赖 0218 + EF v37）
3. **主题 B（管理端）**：管理端学生页 + 学生抽屉顶部，传过证件照的显示照片。（只依赖推送，不依赖 0218 / EF）
4. **线上真登冒烟**：本轮未做（新版未部署）；推送 + Cloudflare Pages 自动部署后，建议业主用测试账号登一次 student / school / admin / partner 各端，确认无控制台报错、页面正常。

---

## 八、第二十六轮建议包

1. **中介代填多层次写入** —— 0217 本轮只放开"学生本人自填"列 grant 与"学校侧读 / 匹配"；中介端代填多层次（`submit_referral` / `student_agent_application` 加 `p_target_programs`）留第二十六轮。**（必含）**
2. **数据洞察真版** —— 管理端数据洞察 / 统计面板接云端真值（现状部分为演示 / 派生）。**（必含）**
3. **范例库云端版** —— 材料范例库（offer-samples 等）从本地 / 演示改云端真源。**（必含）**
4. **门禁页横幅** —— 门禁 / 登录页公告横幅（多语、可后台配）。**（必含）**
5. **审计筛选记忆** —— 审计事件 / 行为日志页的筛选条件持久化记忆（刷新不丢）。**（必含）**
6. **付款月报** —— 付款流水月度汇总报表 / 导出。**（必含）**
7. （可选）配额云化、offer 演示车道收敛、REJ-1 拒绝类别选择器等历史 backlog 择期收编。

---

## 九、STOP 声明

`~/mh-verify/r25-STOP.txt` **不存在**（本轮无"必须停"，七包顺畅收官）。

---

# 附录 A · 迁移 0217 全文（supabase/migrations/0217_target_programs.sql）

```sql
-- 【迁移 0217】学生多层次 / 多专业落库 —— target_programs jsonb 数组贯通到库与学校侧匹配。
--
-- 背景（第二十五轮 25-01）：students 只有 target_program(单值·CHECK 六值) + major(首个专业)，
--   学生一次可选最多 3 个学历层次、每层最多 3 个专业，但只有 programs[0] 与其首专业上了云 →
--   学校端 / 管理端 / 中介端只看到一个层次一个专业。本迁移新增 target_programs(jsonb 数组，
--   元素 {value, majors})，并把学校侧按层次过滤 / 匹配的 RPC 放开为「单值 或 数组含该层次」。
--
-- 房规遵守（铁律9 新增式）：本迁移只 ADD COLUMN、加列 grant、CREATE OR REPLACE 函数体，
--   read-RPC 因返回类型变化（多回一列 target_programs）须先 drop 同签名再重建（与 0180/0036 同法，
--   同一事务内无中间窗口）。不删数据、不改已有列语义、不动 target_program / major 的写入含义。
-- 手贴执行：整段贴入 Supabase SQL Editor 运行一次。CC 不自主连库执行；本地只跑 begin…rollback 探针。
--
-- ⚠ 中介代填写入（第二十六轮）：本轮只放开【学生本人自填】列 grant 与【学校侧读/匹配】。
--   中介代填多层次写入（submit_referral / student_agent_application 加 p_target_programs）留第二十六轮。

begin;

-- ── ① 新列：target_programs jsonb 数组（元素 {value, majors}）──
alter table public.students
  add column if not exists target_programs jsonb not null default '[]'::jsonb;

-- 约束：必须是 jsonb 数组（值域 = target_program 的 CHECK 六值，由前端保证；此处只锁数组形态）
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'students_target_programs_is_array'
  ) then
    alter table public.students
      add constraint students_target_programs_is_array
      check (jsonb_typeof(target_programs) = 'array');
  end if;
end $$;

-- ── ② 列级写权：学生本人自填（照 0023 / 0030 现行写法）──
grant insert (target_programs) on public.students to authenticated;
grant update (target_programs) on public.students to authenticated;

-- ── ③ search_students_global：多回一列 target_programs + 层次过滤放开为「单值 或 数组含」──
--    返回类型变化 → 先 drop 同签名再重建（0180 已示范）。函数体逐字保留，仅两处改动。
drop function if exists public.search_students_global(uuid, text, numeric, integer, text, text, integer, integer, integer, text, boolean, text, text[]);
CREATE OR REPLACE FUNCTION public.search_students_global(uid uuid, p_program_level text DEFAULT NULL::text, p_gpa_min numeric DEFAULT NULL::numeric, p_hsk_min integer DEFAULT NULL::integer, p_major text DEFAULT NULL::text, p_nationality text DEFAULT NULL::text, p_age_min integer DEFAULT NULL::integer, p_age_max integer DEFAULT NULL::integer, p_limit integer DEFAULT 200, p_gender text DEFAULT NULL::text, p_in_china boolean DEFAULT NULL::boolean, p_funding text DEFAULT NULL::text, p_countries text[] DEFAULT NULL::text[])
 RETURNS TABLE(student_id uuid, surname text, given_name text, nationality text, country_iso text, city text, age integer, gender text, major text, target_program text, target_programs jsonb, semester text, gpa numeric, hsk text, csca text, in_china boolean, birth_date date, passport_no text, funding jsonb, statement text, app_no text)
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select
    s.id, s.surname, s.given_name, s.nationality, s.country_iso, s.city,
    s.age, s.gender, s.major, s.target_program, s.target_programs, s.semester,   -- 0217: 多回 target_programs
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
    -- 0217: 层次过滤放开为「单值 或 数组含该层次」
    and (p_program_level is null
         or s.target_program = p_program_level
         or s.target_programs @> jsonb_build_array(jsonb_build_object('value', p_program_level)))
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

-- ── ④ search_students_blind：同理多回 target_programs + 层次过滤放开。返回列集其余逐字不变（双盲红线）──
drop function if exists public.search_students_blind(uuid, text, text, numeric, int, text, text, int, int, int, text, boolean, text, text[]);
create or replace function public.search_students_blind(
  uid            uuid,
  p_task_code    text,
  p_program_level text default null,
  p_gpa_min      numeric default null,
  p_hsk_min      int default null,
  p_major        text default null,
  p_nationality  text default null,
  p_age_min      int default null,
  p_age_max      int default null,
  p_limit        int default 200,
  p_gender       text default null,
  p_in_china     boolean default null,
  p_funding      text default null,
  p_countries    text[] default null
)
returns table (
  student_id     uuid,
  surname        text,
  given_name     text,
  nationality    text,
  country_iso    text,
  city           text,
  age            int,
  gender         text,
  major          text,
  target_program text,
  target_programs jsonb,      -- 0217 新增（非联系方式，双盲边界不动）
  semester       text,
  gpa            numeric,
  hsk            text,
  csca           text,
  in_china       boolean,
  birth_date     date,
  passport_no    text,
  funding        jsonb,
  statement      text,
  in_pool        boolean
)
language sql security definer stable set search_path = public as $fn$
  select
    s.id, s.surname, s.given_name, s.nationality, s.country_iso, s.city,
    s.age, s.gender, s.major, s.target_program, s.target_programs, s.semester,   -- 0217
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
    and (p_program_level is null
         or s.target_program = p_program_level
         or s.target_programs @> jsonb_build_array(jsonb_build_object('value', p_program_level)))   -- 0217
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
$fn$;
grant execute on function public.search_students_blind(uuid, text, text, numeric, int, text, text, int, int, int, text, boolean, text, text[]) to authenticated;

-- ── ⑤ get_task_candidates：无层次过滤，只多回一列 target_programs（供学校端分组显示）──
drop function if exists public.get_task_candidates(uuid, text);
CREATE FUNCTION public.get_task_candidates(uid uuid, p_task_code text)
 RETURNS TABLE(student_id uuid, surname text, given_name text, nationality text, country_iso text, city text, age integer, gender text, major text, target_program text, target_programs jsonb, semester text, gpa numeric, hsk text, csca text, in_china boolean, birth_date date, passport_no text, funding jsonb, statement text, applied_at timestamp with time zone, app_no text)
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select
    s.id,
    s.surname, s.given_name, s.nationality, s.country_iso, s.city,
    s.age, s.gender, s.major, s.target_program, s.target_programs, s.semester,   -- 0217
    s.gpa, s.hsk, s.csca, s.in_china,
    s.birth_date, s.passport_no, s.funding, s.statement,
    tc.applied_at,
    s.app_no
  from task_candidates tc
  join students s on s.id = tc.student_id
  where tc.task_code = p_task_code
    and uid = auth.uid()
    and exists (
      select 1
      from admission_tasks at
      join school_members sm on sm.school_id = at.school_id
      where at.task_code = p_task_code and sm.user_id = uid
    )
  order by tc.applied_at asc;
$function$;
grant execute on function public.get_task_candidates(uuid, text) to authenticated;

-- ── ⑥ match_task_candidates：一键匹配的层次判定放开为「单值 或 数组含」（函数体改，签名不变）──
--    add_task_candidate 无层次过滤（只校验任务 active + 学生已提交），本轮不动。
create or replace function public.match_task_candidates(uid uuid, p_task_code text)
returns int
language plpgsql security definer set search_path = public as $fn$
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
      and (_level  is null
           or s.target_program = _level
           or s.target_programs @> jsonb_build_array(jsonb_build_object('value', _level)))   -- 0217
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
$fn$;
grant execute on function public.match_task_candidates(uuid, text) to authenticated;

commit;

-- ═══════════════════════════════════════════════════════════════════
-- 自检（只读）：
--   1) 列存在且为 jsonb 数组默认 '[]'：
--      select column_name, data_type, column_default from information_schema.columns
--       where table_name='students' and column_name='target_programs';
--   2) 三个读 RPC 返回列集含 target_programs：
--      select proname, pg_get_function_result(oid) like '%target_programs%' as has_tp
--        from pg_proc where proname in ('search_students_global','search_students_blind','get_task_candidates');
--   3) 层次数组匹配（对一名两层桩生按第二层次查得到）：见 jobs/JOB-25-01/probe-0217.sql
-- ═══════════════════════════════════════════════════════════════════
-- 0217 完。新增 target_programs 列 + 学生自写列 grant + 三读 RPC 多回该列 + 层次过滤/匹配放开数组含。
```

---

# 附录 B · 迁移 0218 全文（supabase/migrations/0218_student_photo.sql）

```sql
-- 【迁移 0218】人脸证件照的取用通道 —— get_student_photo + _mh_school_can_see_student。
--
-- 背景（第二十五轮 25-04，主题 B）：学校端 / 管理端头像现在只能走 get_candidate_documents
--   （0207：要任务号、且 review_verdicts.status='approved' 才回、且 deleted_at is null），
--   于是「不在任何任务候选池的学生」「照片还没被审核员审核的学生」都只能显示首字母。
--   业主新规则：只要学生上传了证件照，学校端与管理端在列表和档案里就直接显示照片，
--   人脸照片不等审核；其它材料仍等审核后才显示。本迁移新建一条【只回人脸照片、不看审核状态】的取用通道。
--
-- 房规遵守（铁律9 新增式）：本迁移只 CREATE OR REPLACE 两个新函数 + 授予 execute，
--   不新增/删除任何表或列、不改任何已有函数、不动其它 doc_type 的可见规则、不动 search_students_global 行为。
--   _mh_school_can_see_student 只是把 search_students_global 现行 WHERE 里
--   「哪些学生对任一在营学校可见」那段谓词【原样抽成】一个可复用函数，search_students_global 本身一字不改。
-- 手贴执行：整段贴入 Supabase SQL Editor 运行一次。CC 不自主连库执行；本地只跑 begin…rollback 探针
--   （见 jobs/JOB-25-04/probe-0218.sql）。
--
-- ⚠ doc_id 类型（图纸微调，回执已醒目标注）：25-04 卡里写 get_student_photo 返回 doc_id uuid，
--   但 documents.doc_id 实为 text 主键（0003:35），姊妹函数 get_candidate_documents（0207）返回的也是 doc_id text。
--   uuid 是笔误、且与真实列类型冲突（返回 uuid 需强转/伪造，不可行）。本迁移照现行真列与姊妹函数镜像为 doc_id text。

begin;

-- ── ① 学校可见性谓词抽取：_mh_school_can_see_student(p_school_uid, p_student_id) → boolean ──
--    = search_students_global（0217 行 54-61）WHERE 里【非本函数参数过滤】的那三段合取：
--      (a) 调用者是某在营(active)学校的成员；
--      (b) 该学生已提交(_student_submitted + submitted_at 非空)；
--      (c) 该学生曝光级别 <> 'blocked'。
--    search_students_global 是【全局池】搜索（任一在营学校成员可见任一已提交、未屏蔽学生），
--    故本谓词不含「本校专属归属」条件——与现行 search_students_global 行为一致，不收紧不放宽。
create or replace function public._mh_school_can_see_student(p_school_uid uuid, p_student_id uuid)
returns boolean
language sql
stable
security definer
set search_path to 'public'
as $fn$
  select
    exists (
      select 1
      from school_members sm
      join schools sc on sc.id = sm.school_id
      where sm.user_id = p_school_uid and sc.status = 'active'
    )
    and exists (
      select 1
      from students s
      where s.id = p_student_id
        and _student_submitted(s.given_name, s.age)
        and s.submitted_at is not null
        and public.student_exposure_level(s.id) <> 'blocked'
    );
$fn$;
grant execute on function public._mh_school_can_see_student(uuid, uuid) to authenticated;

-- ── ② get_student_photo(uid, p_student_id)：只回该生最新一份 doc_type='photo'，不看审核状态 ──
--    鉴权（uid 必须 = auth.uid()，防冒用他人 uid）：
--      • 管理员(is_admin) → 放行；
--      • 学校账号 → 仅当 _mh_school_can_see_student(uid, p_student_id) 为真才放行；
--      • 其它调用者 → 两个分支均假 → 空结果集。
--    只回 doc_type='photo'、deleted_at is null 的行，按 uploaded_at / version 取最新一份。
--    【关键·不看审核】：不 join review_verdicts —— 与 get_candidate_documents 的 approved 门相反，人脸照片即传即显。
--    doc_id 为 text（见抬头说明），供前端拿去 POST 水印函数 watermark-doc {doc_id, kind:'avatar'} 取 160px 小图。
create or replace function public.get_student_photo(uid uuid, p_student_id uuid)
returns table(doc_id text, file_name text, uploaded_at timestamptz)
language sql
stable
security definer
set search_path to 'public'
as $fn$
  select d.doc_id, d.file_name, d.uploaded_at
  from documents d
  where d.student_id = p_student_id
    and d.doc_type = 'photo'
    and d.deleted_at is null
    and uid = auth.uid()
    and (
      public.is_admin(uid)
      or public._mh_school_can_see_student(uid, p_student_id)
    )
  order by d.uploaded_at desc, d.version desc
  limit 1;
$fn$;
grant execute on function public.get_student_photo(uuid, uuid) to authenticated;

commit;

-- ═══════════════════════════════════════════════════════════════════
-- 自检（只读；可贴入 SQL Editor 单跑）：
--   1) 两个函数在、返回类型对：
--      select proname, pg_get_function_result(oid)
--        from pg_proc where proname in ('get_student_photo','_mh_school_can_see_student');
--      期望 get_student_photo 返回含 'doc_id text'、'file_name text'、'uploaded_at timestamp with time zone'；
--           _mh_school_can_see_student 返回 boolean。
--   2) 谓词/取件逻辑（对桩生取最新未审核照片、软删排除、不可见学校取不到）：
--      见 jobs/JOB-25-04/probe-0218.sql（begin…rollback 探针，本地 bash jobs/db-run.sh 跑）。
--   3) 端到端 auth.uid() 分支（管理员取到 / 学校成员取到 / 陌生人取空）：
--      psql 会话内 auth.uid() 恒空、且 school_members.user_id / app_roles.user_id 外键 auth.users
--      难在探针内伪造 → 与 0217 同例，留业主贴库后用真实测试账号验一次（回执已写验法）。
-- ═══════════════════════════════════════════════════════════════════
-- 0218 完。新增 _mh_school_can_see_student（谓词抽取，只读）+ get_student_photo（人脸照片即传即显，不看审核）。
```
