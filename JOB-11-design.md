# JOB-11 · 管理端补管理能力 —— 设计（必须停，不动代码）

管理端现在对学生材料只有 2 个写操作、对学校只有 4 个。这份文档设计**六件做不到的事**各需要什么，等你拍板三个问题后再开施工卡。

> 原则：全部走 **SECURITY DEFINER 服务端函数**（前端只调 RPC，绝不直接改表）；每个动作都写 `admin_events` 审计；破坏性动作一律软删/可回滚优先。

## 六件事 · 逐条设计

| # | 能力 | 服务端函数（建议名） | 动哪张表 | 审计 | 回滚 |
|---|------|------|------|------|------|
| 1 | 删错件 | `admin_delete_document(doc_id, reason)` | `documents`（软删加 `deleted_at`/`deleted_by`/`delete_reason` 三列；文件留桶）；相关 `review_verdicts` 不动 | `admin_events`: `doc_deleted` | 软删可 `deleted_at=null` 复原（**问题 1**） |
| 2 | 替换传错的通知书 | `admin_replace_offer_letter(offer_id, new_path, reason)` | `offer_decisions.letter_file_path`（旧路径写进 `admin_events.detail` 备查，旧文件留桶不删） | `letter_replaced` | 从审计里的旧路径改回 |
| 3 | 撤销派单 | `admin_revoke_dispatch(doc_id\|task_code, student_id, reason)` | 派单关系表（`review_verdicts`/派单表，需先确认派单落在哪张表）；把该件移出「审核员手上」 | `dispatch_revoked` | 视**问题 2** 决定回可派池还是终态 |
| 4 | 解锁材料槽 | `admin_reopen_doc_slot(student_id, doc_type, reason)` | `documents`：把该槽的最新裁决/锁状态清掉，让学生能重传（不删旧件，加一条「已解锁」标记） | `slot_reopened` | 重新加回锁状态 |
| 5 | 停用学校 | `admin_suspend_school(school_id, reason)` | `schools.status='suspended'`（+`suspended_at`/`suspended_by`/`suspend_reason`） | `school_suspended` | `status='active'` 复原；**已发 offer 见问题 3** |
| 6 | 改已批准学校档案 | `admin_update_school(school_id, patch_jsonb, reason)` | `schools`（白名单列：名称/联系人/城市/tier 等，不含 id/display_code） | `school_updated`（旧值进 detail） | 从审计旧值改回 |

## 建表 / 加列清单（都是新增型，可自主做；但**本卡只设计不建**）
- `documents` + `deleted_at timestamptz`, `deleted_by uuid`, `delete_reason text`（软删）
- `documents` + `slot_reopened_at`（或复用现有锁字段，需确认锁落在哪列）
- `offer_decisions`：替换通知书不需新列（旧路径进审计）
- `schools` + `suspended_at`, `suspended_by`, `suspend_reason`
- 六个函数 + 各自 `admin_events` 写入 + `is_admin(auth.uid())` 门禁 + `revoke execute from public; grant execute to authenticated`

## 前端（施工卡阶段，非本卡）
- 学生抽屉材料行：加「删除 / 解锁重传」按钮（走 1、4）
- 学生抽屉 OFFER 行：加「替换通知书」（走 2）
- 派单台/材料行：加「撤销派单」（走 3）
- 学校抽屉：加「停用 / 编辑档案」（走 5、6）
- 全部二次确认 + 必填理由（复用现成 `_poAsk`）

---

## 请你拍板三个问题（回答后我再开施工卡）

1. **删材料是软删还是硬删？**
   - 建议**软删**（标记 `deleted_at` + 从界面消失，文件留桶）——可复原、留审计、合规友好。
   - 硬删（连文件一起抹）不可逆，只在你明确要「彻底抹除」时用。
   - 👉 你选哪个？（默认软删）

2. **撤销派单后，材料回到可派池，还是标为「已撤销不再派」？**
   - 回可派池：撤销=重来，材料重新等待派给审核员。
   - 已撤销终态：撤销=作废，不再进入派单流。
   - 👉 你要哪种？

3. **停用一所学校，该校已发出的 offer 怎么办？**
   - 冻结：已发 offer 一并冻结（学生看不到/不能付款解锁）。
   - 照常：学校停用只挡新动作，已发 offer 继续走完。
   - 👉 你要哪种？

**本卡零代码、零 SQL 执行。** 你回答上面三问，我就按裁决开逐个施工卡（每个函数一卡，随卡建表+审计+回滚+前端按钮+三层自验）。
