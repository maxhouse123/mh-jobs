# JOB-14 · 学校端留痕改服务端 —— 设计（必须停，不动代码）

**合规项。** 学校对学生数据的四类行为，现在全在**学校那台电脑的浏览器里**（localStorage），平台方零记录：
1. 导出学生数据的历史（字段映射含护照号）
2. 已导出名单
3. 材料下载日志
4. 看过哪些学生

一旦学校电脑清缓存 / 换电脑，记录全丢；平台无法追溯谁在什么时候导出/下载了谁的敏感数据。改为**服务端留痕**。

## 建表方案

> **建表迁移必须显式 `revoke` 再 `grant`** —— 本项目新建对象会自动拿到 anon/authenticated 全套权限，容器里测不出来，必须手动收紧。

### 表 1：`school_access_log`（统一行为日志，一表四类）
```
create table public.school_access_log (
  id            uuid primary key default gen_random_uuid(),
  school_id     uuid not null references public.schools(id),
  actor_uid     uuid not null,                 -- 操作的学校成员
  action        text not null,                 -- 'export' | 'download' | 'view_student' | 'export_list'
  student_id    uuid references public.students(id),   -- 针对单个学生的行为(view/download)可填
  detail        jsonb,                         -- 导出字段映射快照 / 文件名 / 导出名单 id 列表 等
  created_at    timestamptz not null default now()
);
create index idx_sal_school on public.school_access_log (school_id, created_at desc);
create index idx_sal_student on public.school_access_log (student_id);

-- 权限：新建对象先收紧再按需放行
revoke all on public.school_access_log from public, anon, authenticated;
alter table public.school_access_log enable row level security;
-- 写入只走 SECURITY DEFINER RPC(下)，故 authenticated 不给直接 insert
grant select on public.school_access_log to service_role;
-- 管理员只读策略
create policy admin_read_school_access_log on public.school_access_log
  for select using ( public.is_admin(auth.uid()) );
-- (可选)学校只读自己那部分 —— 见末尾问题
```

### 写入 RPC（学校端每次行为调一次，SECURITY DEFINER 绕 RLS 只插自己那条）
```
create function public.log_school_access(p_action text, p_student_id uuid, p_detail jsonb)
  returns void language plpgsql security definer as $$
begin
  insert into public.school_access_log(school_id, actor_uid, action, student_id, detail)
  values ( /* 由 caller 的 school 成员身份解析 school_id */ , auth.uid(), p_action, p_student_id, p_detail );
end $$;
revoke execute on function public.log_school_access(text,uuid,jsonb) from public;
grant execute on function public.log_school_access(text,uuid,jsonb) to authenticated;
```

## 四类行为各写什么
| 行为 | action | student_id | detail 里放什么 |
|---|---|---|---|
| 导出学生数据 | `export` | null | 字段映射快照（含是否含护照号）、导出行数、筛选条件 |
| 已导出名单 | `export_list` | null | 本次导出的学生 id 列表 |
| 材料下载 | `download` | 该学生 | 文件名 / doc_type / 下载时间 |
| 看过哪些学生 | `view_student` | 该学生 | 打开来源（列表/任务/候选池）|

## 管理端日志页长什么样
- 侧栏加「学校行为日志」页（只读，复用 wf-hero + queue-row + 筛选 chip，照 JOB-10 招生任务页同款）。
- 顶部筛选：按学校 / 按行为类型 / 按时间。
- 每行：🏫 学校 · 👤 成员 · 行为(导出/下载/查看) · 🎓 涉及学生 · 🕒 时间。
- 导出行可展开看字段映射快照（是否含护照号一眼可见）。
- 学生抽屉里也可加一小段「谁看过/下载过我的材料」（合规透明）。

## 学校端改动（施工卡阶段）
- 导出/下载/打开学生详情三处，各加一行 `log_school_access(...)` 调用（学校端 v-file +1）。
- 这是**唯一要动学校端**的地方（其余全在管理端 + 迁移）。

---

## 请你回答一个问题

**这条记录要不要对学校可见？**
- 不可见（默认）：只有平台管理员能看，学校无感——纯合规留痕。
- 可见：学校能看到「自己导出/下载过什么」（自我审计），也让学生能看到「哪些学校看过我」（双盲下只显匿名计数还是显校名，需再定）。
- 👉 你要哪种？（决定要不要加「学校只读自己」的 RLS 策略 + 学校端一个日志页）

**本卡零代码、零 SQL 执行。** 你答完，我按裁决开施工卡（迁移建表+RPC+管理端日志页+学校端三处埋点，各随卡自验）。
