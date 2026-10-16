# photo-writers.md · 全仓「谁会写学生照片行」清单（F2-00 取证）

扫描范围：`jobs/`、`scripts/`、`tools/`、`supabase/functions/`，外加生产库里所有 public 函数正文
（`pg_get_functiondef` 扫含 `documents` 且含 `photo`/`file_path` 的）、`pg_cron` 任务。
判定口径：对 `documents` 表 `doc_type='photo'` 的行做 **INSERT**，或 **UPDATE 到 `file_path`/`file_name`**。

---

## 一、产品正道（学生/中介登录后，带 JWT，`auth.uid()` 非空）

| 入口 | 文件/位置 | 动作 | 身份 |
|---|---|---|---|
| 学生本人上传照片 | `student-portal/maxhouse_student_portal_v413.html:11323` | `sb.from('documents').insert({...doc_type:'photo', file_path...})` | 登录学生 JWT（`student_id = auth.uid()`） |
| 学生注册首建档上传 | `student-portal/...v413.html:20647` | 同上，`student_id = newId`（= 新学生 = 本人 uid） | 登录学生 JWT |
| 中介代传被荐生照片 | `student-portal/...v413.html:20894` | 同上，`student_id = s._sid`（其名下学生） | 登录中介 JWT（`partner_owns_student` 成立） |
| 中介端口径同源 | `partner-portal/maxhouse-partner-portal-v185.html`（经学生端组件） | 代填/代传走同表同策略 | 登录中介 JWT |

> 这三条都是浏览器经 PostgREST 直插 `documents`，RLS 策略 `documents_self_insert`
> （`student_id = auth.uid()`）/ `documents_partner_insert`
> （`student_id in (select id from students where referred_by_partner = auth.uid())`）放行，
> **写时必带登录身份**。F2-01 触发器正是放行这两类、拦掉其余。

### 产品里**不写**照片行的云函数 / RPC（只读或只碰豁免列，已逐一核验）
- **云函数**：`student-avatars`（service_role 只对已查到的路径 `createSignedUrls` 签名，**不碰 documents 表**）；
  `watermark-doc`（多处 `.from('documents').select(...)` 全是读；写只落 `wm_cache_index`/各 access_log）；
  `precheck-ai`（读 documents，写 `ai_precheck_shadow`/草稿表；cron 路同样只读 documents）；
  `filing-prefill`（读 documents，写 `ai_prefill_log`/`student_filing_profiles`）；
  `admin-doc`（读 documents，写 `admin_access_log`）。**没有一个云函数 INSERT 照片或改 file_path。**
- **数据库函数（6 个会写 documents 的 DEFINER RPC，全部只碰豁免列，无一碰 file_path/file_name/doc_type/student_id）**：
  `admin_delete_document`（软删：set deleted_at/deleted_by/delete_reason）、
  `admin_reopen_doc_slot`（set slot_reopened_at）、
  `set_doc_slim`（set slim_*）、
  `lock_visa_valid_until`（set valid_until_locked_at）、
  `set_visa_valid_until` / `request_location_change`（仅对 `doc_type='visa'` set valid_until）。
  这 6 个都 DEFINER，但都由登录用户经 PostgREST 调用，`auth.uid()` 非空。
- **pg_cron**：扩展已装，但 command 含 `documents`/`photo` 的定时任务 = **0 条**。

---

## 二、脚本旁道（service_role / postgres 直写，`auth.uid()` 为空）—— F2 要关掉的

### 2a. 「自动装脸」脚本（本轮已停用 + 从流水线摘钩）
| 文件 | 动作 | F2-00 处理 |
|---|---|---|
| `jobs/JOB-G6/assign-faces.mjs` | 上传 g6-face 对象 + emit SQL 改 photo 行 file_path | 开头加 `exit 1` 停用 ✅ |
| `jobs/JOB-G6/assign-faces.sh` | 跑上面 + db-run `_assign-resolved.sql` | 开头加 `exit 1` 停用 ✅ |
| `jobs/JOB-G6/assign-faces.sql` / `_assign-resolved.sql` / `_rehearse-assign.sql` | UPDATE 最新 photo 行 file_path / INSERT photo 行 | 由 .sh 驱动；.sh 已停用（SQL 文件留档不删） |
| `jobs/JOB-G6b/assign-faces-g6b.mjs` | 同 G6（re-pair v2 脸） | 开头加 `exit 1` 停用 ✅ |
| `jobs/JOB-G6b/assign-faces-g6b.sh` / `_assign-resolved-g6b.sql` | 同上 | .sh 已停用 ✅（SQL 留档） |
| `jobs/JOB-GP1/rec/assign-faces-gp1.mjs` | 给 9 被荐生装脸、改 photo file_path | 开头加 `exit 1` 停用 ✅ |
| `jobs/JOB-GP1/states/faces.gen.sql` | UPDATE photo 行 file_path 指向 gp1-face | 由 rebuild-partner.sh 步骤5驱动；该步已摘（SQL 留档） |

### 2b. rebuild / 复位流水线末尾的「装脸钩子」（本轮已摘）
| 文件 | 原钩子 | F2-00 处理 |
|---|---|---|
| `jobs/JOB-G0/rebuild.sh` | 末尾 `bash .../assign-faces-g6b.sh` | 改成注释 + 「照片只许学生自己上传」提示 ✅ |
| `jobs/JOB-GS2/rebuild-school.sh` | 末尾 `bash .../assign-faces-g6b.sh` | 同上 ✅ |
| `jobs/JOB-GP1/rebuild-partner.sh` | 步骤 5/6 `assign-faces-gp1.mjs` + `faces.gen.sql` | 整步摘成注释 ✅ |

闸：三条 rebuild `bash -n` 语法通过；**非注释行里 `assign-faces`/`faces.gen.sql` 计数 = 0/0/0**；
5 个被停用脚本空跑均 `rc=1` 打印 `DISABLED by owner ruling 2026-10-16`。

### 2c. 演示生「建档」种子脚本里顺带插的 photo 占位行（**本轮不改**，但 0227 会拦）
这些不是「装脸」脚本，是 rebuild 建演示生时按 `['passport','education','transcript','photo']` 循环各插一条
占位 doc 行（photo 行 file_path = SPECIMEN 占位，之后才由装脸脚本改真脸）：

| 文件 | 插 photo 占位行的位置 |
|---|---|
| `jobs/JOB-G0/g0-04-backstage.sql` | L62 / L69（中介两被荐生四材料含 photo） |
| `jobs/JOB-GS2/gs2-03-students.sql` | L62（8 演示生四材料含 photo） |
| `jobs/JOB-GP1/states/build-core.sql` | L61（8 SQL 生四材料含 photo；注释明说「photo 之后由脸脚本改 file_path」） |
| `jobs/JOB-GP1/states/st-pt04-docs-full.sql`、`pt04-reg.gen.sql`、`jobs/JOB-G1b/seed-amal.sql`、`jobs/JOB-GP1/rec/mk-accounts.mjs` | 同类演示建档插 photo 占位 |

> **⚠ 后果（已向业主交代，见 JOB-F2-00/JOB-F2-01 回执）**：这些种子脚本用 postgres/service_role 直插、
> `auth.uid()` 为空 → **迁移 0227 上线后，它们那条 photo 占位行 INSERT 会被触发器拒掉**，
> 于是演示 rebuild 的「建档」步会在 photo 那一轮报 `photo_student_only`。
> 这**正是业主 §0① 的本意**（系统/脚本一律不许写照片），只是连带到了演示生建档：
> 今后演示生的照片要像真学生一样**用该演示账号登端口自己上传**。
> 这些种子 SQL **不在 F2 §0 允许改动的文件清单内**，故本轮不动它们，仅在此登记 + 回执醒目标注，留业主定后续卡
> （要么接受演示 rebuild 的 photo 步报错、要么另开卡把 'photo' 从种子数组里摘掉）。

### 2d. 只读探针（不算真写手，列出备查）
`jobs/JOB-25-04/probe-0218.sql`、`jobs/JOB-27-01/probe-0220.sql`：回归探针，begin/rollback 式验证，不落库。

---

## 结论
- **产品正道写照片 = 必带登录身份**（学生本人 / 其中介），无一条用 service_role/无身份写照片 → F2-01 可安全上触发器，**无需 NEEDS_OWNER_DECISION**。
- **脚本旁道**：装脸族已全停用 + 摘钩（2a/2b）；演示建档种子的 photo 占位插入（2c）本轮不改、由 0227 从数据层兜底拦截并已醒目登记。
