PUSH_OK=yes

# SUMMARY-27 · 第二十七轮（快车道）· 学校端 / 管理端学生头像秒开

一句话：学校端 v238 打开学生列表，头像先是首字母、过好几秒才陆续变照片。查明病根 = 逐行各一次取照 + 各一次服务端渲染 + 只放 2 个在途 + 只存内存（27-00 无头实测 20 人 = 36 次往返 / 4.2 秒、关掉重开再来一遍）。本轮改成「一次批量签名 + Supabase 缩放小图端点 + 本机缓存 50 分钟」，出 **school v239 + admin v237**，另写新云函数 `student-avatars` 与迁移 `0220`（只写、不部署、不执行，等业主收官后手动做）。

CC 自己的所有闸全过，故 **PUSH_OK=yes**。主仓库已按每包一笔提交、**未推**（推送由业主用卡1206 做）。

---

## 一、版本 / md5 账
| 文件 | 版本 | md5 |
|---|---|---|
| `school-portal/maxhouse-school-portal-v239.html` | v238→**v239** | `eb7b917915677574209dcf1fbf881e88` |
| `admin-portal/maxhouse-admin-portal-v237.html` | v234→**v237**（照 §0.2，跳版） | `07a5806e1d3c35fd9e0b2ee3cc22e127` |
| `supabase/migrations/0220_student_photos_batch.sql`（只写） | 0220 | `e38f1d5b127e952412d307422f996b2d` |
| `supabase/functions/student-avatars/index.ts`（只写） | 新函数 | `85a1dd177609d260700c195e7aed0b50` |

其余三端（student v402 / partner v171 / reviewer v46）一字未动。
四件套（文件名 / 头注 / [VER] / index 重定向 / changelog）两端各齐。

> 管理端版本从 v234 直跳 v237 是照 QUEUE-27 §0.2 明写（中间 v235/v236 未产出），不是漏版本——头注/[VER]/changelog 均注明。

## 二、四包一句话
- **27-00**：只读先量。学校端 v238 首开 20 人 = **RPC 20 + EF 16 = 36 次往返 / 4.2s**；关掉重开一模一样（无持久缓存）；管理端 v234 签的是**原图**地址、无 render 缩放端点。回执 JOB-27-00.md。
- **27-01**：写迁移 0220（批量取照 RPC `get_student_photos`）+ 新云函数 `student-avatars`（一次收整页 id、用户 JWT 调 RPC、服务密钥批量签名、改写 render 缩放小图 + fallback 原图、Cache-Control）。**只写不部署**。回执 JOB-27-01.md。
- **27-02**：school v239。`_v239LoadAvatars` 一次批量 POST EF + localStorage 缓存 50min（含无照片负缓存），四接入点 + 档案弹窗改走；EF 404/5xx/超时 3s 逐层退回旧 v237 路径。回执 JOB-27-02.md。
- **27-03**：admin v237。`_v237LoadAvatars/_v237Avatar` 签名后改写 render 缩放小图 + 本机缓存 50min（独立键，不与学校端共缓存），onerror 换原图；接入点切走，旧 `_v234*` 留兜底。回执 JOB-27-03.md。

## 三、闸账
### 提速前后对照（27-00 先量 vs 27-02/03 验后）
| 场景 | 旧（27-00） | 新（27-02/03 无头实测） |
|---|---|---|
| 学校端首开 20 人 | 36 次往返 / 4.2s | **EF 1 次 / ≤1s**，16 出图 4 首字母 |
| 学校端关掉重开 | 36 次（从零） | **EF 0 次**（走缓存）、即时；缓存过期再开 = 1 次 |
| 管理端 30 人 | 原图签名、无 render、重开不缓存 | 签名 **1 次**、src 含 `render/image` 160 q70；重开 **签名 0 次** |

### 容错（逐层退回，均已无头验证、零报错）
- 学校端：EF 404（没部署）→ 退回 v237 逐生旧路径仍 16 出图；render 端点桩坏 → `onerror` 换 fallback 仍出图。
- 管理端：render 端点桩坏 → `onerror` 换原图仍出图（管理端不经 EF、不依赖 0220，推了即生效）。

### 其余闸
- **N1 零消失**：两端旧函数（school `_v237*` 五个 / admin `_v234LoadAvatars`+`_v234Avatar`）全保留，静态断言逐一验过。
- **P3 静态随卡**（入 git）：`tests/job27-01-ef-migration-static.mjs`（32 过）、`tests/job27-02-school-v239-static.mjs`（35 过）、`tests/job27-03-admin-v237-static.mjs`（29 过）。
- **闸8 无头真渲染中英各一遍**：`~/mh-verify/r27-02-school.mjs`（10 条全过）、`~/mh-verify/r27-03-admin.mjs`（9 条全过），全部零 pageerror。
- **闸9 视觉零新增**：只复用既有 `.student-avatar`/`.avatar-fill`/`.avatar` 类 + 与旧代码同款内联样式，零新增颜色/字号/样式类/CSS 规则。
- **0220 探针**：`bash jobs/db-run.sh jobs/JOB-27-01/probe-0220.sql` 四组判定全对、末尾 ROLLBACK（不落数据）：可见学生取到最新未审核照片 / 无照片不返回 / 软删·错后缀·空路径排除 / 陌生人取不到 / 上限 100 截断。
- **deno check**：`student-avatars/index.ts` 通过（本机新装 deno 2.9.7）。
- **secret-scan**：两端新代码 + EF 零密钥（EF 用 `Deno.env`，前端用既有 publishable key）。
- **STOP**：`~/mh-verify/r27-STOP.txt` **不存在**（本轮无「必须停」）。

## 四、待业主手贴 SQL —— 迁移 0220（全文 + 验证法）
把下面整段贴进 Supabase → SQL Editor 跑一次（新增式，安全）：

```sql
-- 【迁移 0220】人脸证件照的【批量】取用通道 —— get_student_photos(uid, p_student_ids[])。
begin;

create or replace function public.get_student_photos(uid uuid, p_student_ids uuid[])
returns table(student_id uuid, doc_id text, file_path text, file_name text)
language sql
stable
security definer
set search_path to 'public'
as $fn$
  select distinct on (d.student_id)
    d.student_id, d.doc_id, d.file_path, d.file_name
  from documents d
  where d.student_id = any( (p_student_ids)[1:100] )   -- 上限 100，多传截断
    and d.doc_type = 'photo'
    and d.deleted_at is null
    and d.file_path is not null
    and d.file_name ~* '\.(jpe?g|png|webp)$'            -- 后缀白名单
    and uid = auth.uid()                                -- 防冒用他人 uid
    and (
      public.is_admin(uid)
      or public._mh_school_can_see_student(uid, d.student_id)
    )
  order by d.student_id, d.uploaded_at desc, d.version desc;
$fn$;
grant execute on function public.get_student_photos(uuid, uuid[]) to authenticated;

commit;
```

**贴完怎么验（只读）**：
1. 函数在、返回类型对：
   ```sql
   select proname, pg_get_function_result(oid) from pg_proc where proname = 'get_student_photos';
   ```
   期望结果含 `TABLE(student_id uuid, doc_id text, file_path text, file_name text)`。
2. 端到端（可选，用真实测试账号）：部署 EF 后打开学校端学生列表，看头像是否秒出；控制台无红字即通。

> 前置：0220 依赖 0218 已有的 `_mh_school_can_see_student` 与 `is_admin`（§0.1 说 0214–0218 已贴，满足）。若报「函数 _mh_school_can_see_student 不存在」，说明 0218 没贴，需先贴 0218。

## 五、EF 部署说明 —— student-avatars
源码已在 `supabase/functions/student-avatars/index.ts`（本轮只写、未部署）。业主在原生终端（挂代理）跑：

    supabase functions deploy student-avatars --project-ref uexgzwfambanvhdhxome

- 部署 + 贴 0220 后，学校端头像走新快通道（一次批量、并行拉小图）。
- **没部署也不会坏**：学校端 EF 404 会自动退回旧 v237 路径（慢但能出图）；管理端根本不经 EF（管理员直签），推了主仓库就生效。
- 缩放端点（render/image）本项目是否开启尚未线上验证；没开时前端 `onerror` 自动换原图签名，仍出图（只是稍大、不省流量）。若要开：Supabase → Storage → 打开 Image Transformation（Pro 计划应可用）。

## 六、未放行清单（须业主动手/亲验）
1. 手贴迁移 0220（见第四节）。
2. 部署 EF `student-avatars`（见第五节）。
3. **推主仓库**（卡1206 做；本轮 CC 已提交 3 笔 JOB-27-xx、未推）。
4. 线上亲验（贴 SQL + 部署 EF 后）：
   - 学校端 ⇧⌘R 打开学生列表 → 一秒内有照片的学生全是照片；关掉再开是即时的。
   - 管理端学生页 → 头像一秒出齐、重开即时。
5.（可选）Supabase 打开 Image Transformation，让缩放小图真正省流量（不开也能用，走 fallback 原图）。

## 七、要业主亲眼看的
- 学校端学生列表头像「秒开」+「重开即时」——这是本轮主诉求，务必亲验一次。
- 管理端学生页头像同上。
- 若发现头像比预期大/流量没省 → 多半是 Storage 没开 Image Transformation，按第五节开一下。

## 八、第二十八轮建议包（必含项 + 观察）
- **28-A（= QUEUE-26 附录 27-A）**：管理端 / 中介端「层次显示归一」——沿用学校端 v238 `_v238LevelIs` 同义组（lang↔chinese_lang / exchange↔short_term），把管理端 `_v233LevelLabel`、中介端层次显示统一，免两端拼法不一显岔。
- **28-B（= QUEUE-26 附录 27-B）**：管理员重置学生密码（admin 后台一键发重置 / 生成临时口令，走 Auth Admin API，零信任、不落明文）。
- **自定义 SMTP 配置单**：把系统邮件（验证 / 邀请 / 通知）从 Supabase 默认发信改成自有 SMTP（提高送达、避垃圾箱），产出配置清单 + 验证法。
- **中介代填多层次写入**：中介端代填学生资料时把 `target_programs` 多层次/多专业按 v402/school 同结构写云（现中介端可能仍单值），补齐两端一致。
- **数据洞察真版**：admin 端「数据洞察 / 看板」目前多为 mock/演示，接真库出真数（招生漏斗、各校转化、沉默天数等），替换演示车道。
- **范例库云端版**：offer 补充材料范例（offer-samples 桶）/ 材料范例库从演示走真云端，学校可上传、学生可下载。
- **观察项**（延续 LEDGER-3）：本轮已顺手把 admin `MH_PORTAL_VER` 从残留 233 归位 237；提醒后续每次 bump 四件套 + 探针同步，别再漏。
