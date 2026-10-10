# JOB-G8-06b —— 清理旧对象（§7）· 第二段：Supabase 学生照片桶

日期 2026-10-10 晚（北京）　机器 Mac mini　大白话。这是 G8-06 的续段（G8-06 清了 R2 两个视频桶，这段清 Supabase 照片桶）。

## 一句话
Supabase 的 `student-documents` 桶里，50 名**测试学生**自己 `photo/` 文件夹下、**没有被任何资料行（documents 表）用到**的旧照片，一共 **81 个、约 8.8 MB**，这趟删掉了。**真学生（is_test=false）的照片一张没碰**（删前删后都还是 11 张）。被资料行引用着的测试照片（52 个）也一个没动。

## 二、删了哪些、怎么保证只删对的
- **删除集怎么算**（只读 DB 探针 `photos-plan.sql`，begin/rollback 不改库）：
  `storage.objects` 里桶=`student-documents`、前缀 uuid 属 is_test 学生、路径含 `/photo/`、且 `documents.file_path` 里查不到这个对象 → 就是孤儿照片，待删。**81 个**。
- **三道硬守卫**（任一不过整单中止、一个不删，`cleanup-photos.sh` 里）：
  ① 每个待删键的前缀 uuid 必须在「is_test 学生 id 集」里（50 个）——保证绝不碰真学生；
  ② 每个待删键必须含 `/photo/`——保证只碰照片，不碰别的资料；
  ③ 待删集和「被引用集(52 个)」交集必须为空——保证不误删还在用的照片。
  dry-run 实测：`delete=81 keep=52 istest=50`，`GUARD_OK`（bad_prefix=0 / bad_photo=0 / overlap=0）。

## 三、删除通道
- 走 **Supabase Storage 批量删除 API**：`DELETE /storage/v1/object/student-documents`，body `{"prefixes":[...]}`，分块 40 个/次。
- 密钥：**只从仓库根 `.env` 读 `SUPABASE_URL` / `SUPABASE_SERVICE_ROLE_KEY`**（§7 授权清理可读 .env），脚本不打印、不写回执、不进库。（R2 那段因 S3 token 失效才绕道；这段照片桶的 service-role key 有效，直接用。）

## 四、执行结果（已执行 2026-10-10 晚）
```
== 批量删除（Storage API，分块 40/次）==
  OK 本块删 40 个
  OK 本块删 40 个
  OK 本块删 1 个
== 删除完成: 成功对象=81 失败块=0 ==
```
**删后复验**（都过）：
| 复验项 | 命令来源 | 删前 | 删后 | 判定 |
|---|---|---|---|---|
| is_test 孤儿 photo 剩余 | DB 重查 photos-plan.sql | 81 | **0** | ✅ 全删干净 |
| 被引用的 is_test photo（绝不能删） | DB 重查 | 52 | **52** | ✅ 一个没动 |
| **真学生 photo 对象（绝不许碰）** | DB postverify | 11 | **11** | ✅ **一张没碰** |
| 抽样 KEEP 头 3 个 Storage info | curl info | — | **200 / 200 / 200** | ✅ 现役照片仍在 |
| 抽样 DEL 头 3 个 Storage info | curl info | — | **400 / 400 / 400**（对象不存在） | ✅ 确已删除 |

（DEL 抽样回 400 = Supabase Storage info 对不存在对象的返回；以 DB 重查「孤儿剩余=0」为删除真相的权威判据。）

## 五、§0.6「必须停」检查 —— 不触发
- 删除集**建得出、数清楚**（81 个），不是取不全 → 可以删，不停。
- 守卫三道全过，只碰 is_test 学生的孤儿照片 → 风险可控。

## 六、本段产物与提交
- 主仓库（**只 commit 不 push**，`JOB-G8-06b:` 开头，git add 只写具体文件名）：
  `jobs/JOB-G8/cleanup-photos.sh`、`photos-plan.sql`、`photos-postverify.sql`、`cleanup-photos-plan.json`、`cleanup-photos-apply-result.json`。
  （临时文件 `photos-plan.raw` / `_photos-chunks.txt` / `_verify-sample.txt` 不入库。）
- ~/mh-jobs：本回执。
- 证据：全是命令输出，已贴本回执，无截图。

## 七、G8 收官状态
- **G8-06（R2 两桶）+ G8-06b（Supabase 照片桶）清理全部完成**。清理合计：R2 460 个（~1295 MB）+ 照片 81 个（~8.8 MB）= **541 个对象、约 1304 MB**。
- 下一步：**G8-07 收官**——写 `~/mh-jobs/SUMMARY-G8.md`（首行 `PUSH_OK=yes`，内容按 §8 八条）。本趟接着做。
