PUSH_OK=no

# SUMMARY-F2 · 学生照片只许学生自己传 + 学校端 v246 修复（2026-10-16）

> **PUSH_OK=no 的原因**：本轮产出里含**学校端 v246（产品 HTML）**，而推 main = Cloudflare Pages 自动部署上线；
> 业主 F2-02 明令「只 commit 不推不上线，上线与线上真验等业主卡」。故主仓库三笔 F2 提交**先停在本地未推**，
> 由业主决定 v246 何时上线后再推。**迁移 0227 已直接应用到生产库**（不依赖推 main，见下）。

## 三包结论

### F2-00 摘掉所有「自动装脸」+ 查清照片写入点 —— 完成
- 取证（`photo-writers.md`）：**产品正道写照片只有一条**——学生端/中介端浏览器直插 `documents`，**必带登录身份**；
  **没有任何**云函数 / 数据库函数（6 个会写 documents 的只碰软删/瘦身/有效期列）/ pg_cron 用服务钥匙或无身份写照片。
- 5 个装脸脚本加 `exit 1` 停用；3 条 rebuild 流水线摘掉装脸钩子（非注释行 `assign-faces` 计数 = 0/0/0）。
- 连带登记：演示生建档的种子脚本里也有「脚本直插 photo 占位行」，上 0227 后那一步会被同样拦下（= 业主本意），
  这些种子 SQL 不在允许改动清单，本轮未动、只醒目登记，后续是否摘 'photo' 等业主一句话。

### F2-01 数据库上锁：照片行只能由登录用户写（迁移 0227）—— 完成，**0227 已应用到生产库**
- 取证结论：产品正道无 service_role/无身份写照片 → **无需 NEEDS_OWNER_DECISION**。
- 迁移 0227 建 `documents` BEFORE INSERT OR UPDATE 触发器 `photo_rows_student_only`：照片行的新插 / 改到
  file_path·file_name·student_id·doc_type（含同值空改）要求登录身份 = 本人或其中介，否则报 `photo_student_only`；
  软删 / slim_* / 有效期 / 非照片行一律放行。
- 四闸全过：①仿真先红后绿（rollback 不落库）；②生产库应用后真打一行 is_test photo 的 file_path(同值)→被拒；
  ③`pg_trigger` 查到触发器 enabled；④真浏览器登 guide_stuA 上传测试照片**成功**、非本人被拒，收尾软删 + 删测试对象
  （guide_stuA 原照片一字未动）。
- **0227 是否已应用：是**（线上 `pg_trigger` 实测 `photo_rows_student_only` 存在且 enabled = 1 行）。
  回滚文件 `0227_..._rollback.sql` 已备（业主需要时原生终端手跑）。

### F2-02 学校端 v245 → v246（账户设置两 bug）—— 完成，**只 commit 未推未上线**
- 修 ①发 Offer 闸永远拦（办理方式落 `state.account`、闸改读 account，'none' 放行）；
  ②「去设置」/操作记录返回走 `openSettingsView()` 从 account 抄齐联系字段（不再白屏）；
  ③`renderSettingsView` 空盒补齐 + `saveSettings` 守卫拒存不清真值；④`_v242SaveFiling` 存完同步 account。
- 闸全过：node 语法 0 错 / N1 差集 0（无 UI 移除）/ 无头七态 a–g 中英各一遍全 PASS / 390 宽不横溢；
  随卡回归 `tests/cardV246.test.js` 28 项全绿。
- diff 在 `~/mh-jobs/JOB-F2-02-diff.patch`；截图在 `~/mh-jobs/shots/F2/`。
- **v246 md5 = `d823d0744eb6e16600a00ad2bb15b5fd`**；v245 原样保留（md5 `6851ea1a…`）可回滚。

## 主仓库未推提交（三笔，按 §0 只 commit 不推；由业主卡推）
- `7ff651e` JOB-F2-00（摘装脸 + 取证）
- `c60608c` JOB-F2-01（迁移 0227 + 四闸）
- `86a707b` JOB-F2-02（学校端 v246）

> 推送注意：这三笔在 main 上是连续的；`86a707b` 含 v246，推它即上线 v246。若业主想先放行 F2-00/01、
> 暂缓 v246，可只推到 `c60608c`（`git push origin c60608c:main`），待 v246 线上真验后再推 `86a707b`。

## 各包回执与截图
- 回执：`jobs/JOB-F2/JOB-F2-00.md` / `JOB-F2-01.md` / `JOB-F2-02.md`（均已推 `~/mh-jobs`）
- 清单/探针：`photo-writers.md`、`_probe-*.sql`、`_sim-0227.sql`、`_verify-0227-prod.sql` 等
- 截图（`~/mh-jobs/shots/F2/`）：`gate4-01-loggedin.png`、`gate3-settings-zh.png`、`gate3-settings-en.png`
