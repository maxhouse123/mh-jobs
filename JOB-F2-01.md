# JOB-F2-01 回执 · 数据库上锁：照片行只能由登录用户（学生本人或其中介）写

## 一句话结论
给数据库装了一道「门」（迁移 0227）：**凡是要往学生「照片」那条记录里写东西（新插一张照片、
或改照片的文件路径），都必须是本人或其代理中介登录着在操作；任何脚本/后台/服务钥匙偷偷写照片，
一律被挡下并报错 `photo_student_only`。** 而软删、瘦身、改签证有效期这些跟照片内容无关的动作照常放行，
不受影响。上线前仿真先红后绿、上线后真打了一发也被挡、真人登 guide_stuA 上传照片成功——全过。

## 先取证（为什么敢上这道门，不用停下请示）
F2-00 已把全仓 + 云函数 + 数据库函数 + 定时任务扫干净（见 `photo-writers.md`）：
- **产品里写照片的只有一条路**：学生端/中介端浏览器直插 `documents`，**必带登录身份**。
- **没有任何一个云函数 / 数据库函数 / 定时任务**用服务钥匙或无身份去插照片或改照片路径
  （6 个会动 documents 的函数只碰软删/瘦身/签证有效期那几列，都由登录用户点出来）。
- 所以不存在「产品正道靠无身份写照片」的情况 → **不需要写 NEEDS_OWNER_DECISION、不用停**。

## 这道门怎么判（迁移 0227，已归档 supabase/migrations/ 和 docs/supabase 文件/）
- 作用对象：只管 `doc_type='photo'` 的照片行。
- **拦**：新插一张照片，或 UPDATE 碰到了 `file_path`/`file_name`/`student_id`/`doc_type`
  四列中任意一列（连「改成同一个值的空改」也算碰）——此时要求登录身份 = 该照片学生本人
  （`students.id = auth.uid()`）或其代理中介（现成函数 `partner_owns_student` 判），否则报错拒绝。
- **放行**：软删（deleted_at 三列）、瘦身 slim_* 五列、签证有效期、slot_reopened 等任何
  「没碰那四列」的真实改动；以及所有非照片行。系统做这些照常，不受影响。
- 幂等、纯新增（建函数 + 建触发器），不动表结构、不动任何数据行。附回滚文件
  `0227_..._rollback.sql`（含删除语句，业主需要时在原生终端手跑；db-run 会故意拒绝它）。

## 四道闸（全过）
**闸① 仿真先红后绿**（`_sim-0227.sql`，建门→跑测→rollback 不落库）：
| 用例 | 预期 | 结果 |
|---|---|---|
| 无身份 INSERT photo 行 | 拒 | ✅ 被拒 photo_student_only |
| 无身份把 file_path 改成同值 | 拒 | ✅ 被拒 photo_student_only |
| 无身份改 slim_*（瘦身列） | 放行 | ✅ 放行 |
| 无身份改「非 photo 行」 | 放行 | ✅ 放行 |
| 带学生身份 INSERT 本人 photo 行 | 放行 | ✅ 放行 |
| 带学生身份 软删本人 photo 行 | 放行 | ✅ 放行 |

**闸② 生产库上线 + 真打一发**（`apply-0227.sql` 应用成功；`_verify-0227-prod.sql`）：
真碰一行 is_test 学生的 photo 行（doc 167e5672…），把 file_path 改成同值 →
**✅ 被拒 `photo_student_only`**（证明门真生效），探针 rollback 不留痕。

**闸③ 触发器在**：`pg_trigger` 查到 `photo_rows_student_only` 挂在 `documents` 上、状态 enabled。✅

**闸④ 真浏览器登 guide_stuA 线上自验**（业主已授权用测试账号；脚本 `~/mh-verify/f2-gate4-photo.mjs`，
密码运行时从 accounts.json 读、绝不落盘/不打印）：
- 登录成功（uid cef1640f…）；
- **带学生身份上传一张测试照片到 photo 槽 → 插入成功**（upErr/insErr 均空），读回确认行真落库 →
  **产品正道没被误伤** ✅；
- 反向：给一个非本人 student_id 插 photo 行 → **被挡 `photo_student_only`** ✅；
- 收尾：该测试照片行已**软删**（`_gate4-cleanup-softdelete.sql`，UPDATE 1、soft_deleted=t——
  顺带再证「无身份软删 photo 放行」）、上传的测试对象已删（`f2-gate4-rmobj.mjs`）。
  **guide_stuA 原有的那张照片一字未动**（只增删本次自建的 F2SELF 测试行/对象）。
- 截图：`~/mh-jobs/shots/F2/gate4-01-loggedin.png`。

## 产出
- 迁移：`supabase/migrations/0227_photo_rows_student_only.sql` + `_rollback.sql`
  （并归档到 `docs/supabase 文件/`，铁律16）
- 探针/验证（jobs/JOB-F2/，走 db-run）：`_sim-0227.sql`、`apply-0227.sql`、
  `_verify-0227-prod.sql`、`_gate4-cleanup-softdelete.sql`
- 线上自验脚本（本地 ~/mh-verify，不入 git，铁律11）：`f2-gate4-photo.mjs`、`f2-gate4-rmobj.mjs`

## 关联提醒（见 F2-00）
演示生建档的几个种子脚本里也有「脚本直插 photo 占位行」，上线这道门后那一步会被同样挡下
（= 业主本意），演示生照片今后要用演示账号登端口自己传。本轮未改那些种子脚本（不在允许清单）。
