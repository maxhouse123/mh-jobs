# JOB-6-07 设计 · 审核端水印预渲染缓存（2026-09-16）· 只设计不改代码

> 目标：审核员每次「查看」不再冷启动边缘函数（现 2.7–3.7 秒，实测 TTFB ~5.4s）。改为**派单时就把该审核员专属的水印件渲染好、存进私有桶**，审核端查看时直接下载 → 1–2 秒。

## 0. 现状（读源码摸清）
- **watermark-doc EF**：`POST {doc_id}` + 审核员 Bearer JWT → 校验 is_reviewer → 归属门 `reviewer_assignments(doc_id, reviewer_uid)` → service_role 从私有桶 `student-documents` 下原件 → **按魔数加水印（image/pdf）→ 直接回水印后的字节**（Content-Type 如实）。审计写 `reviewer_access_log`。
- **水印是"每个审核员一份"的**：水印文字 `RV-XXXX = SHA-256(reviewer_uid) 前 4 位`。**所以缓存必须按审核员分目录，不能全员共享一份**。
- **审核端**：`openPreview` → `_wmFetch`（本次登录内存缓存，同一份只取一次）→ 悬停「查看」触发 `_wmPrefetch` → 登录 1.5s 后 `_wmPrefetchQueue` 后台逐份预取（300ms 间隔、最多 40 份、只 jpg/png/pdf）。**已有客户端缓存，但每次登录都从冷的重来**。
- **派单**：管理端把材料派给审核员 = INSERT `reviewer_assignments(doc_id, reviewer_uid)`；撤销派单 = `admin_revoke_dispatch` 置 `revoked_at`；材料软删 = documents.`deleted_at`。
- **既有可照抄的触发器范式**：`notify_email_fanout_fn()`（notifications AFTER INSERT）用 `net.http_post`（pg_net）打 EF，带 `x-mh-hook-secret` 暗号。

## 1. 私有桶 wm-cache 的目录结构与存储策略
- 新建**私有桶** `wm-cache`（不公开，仅 service_role 写、签名 URL 读）。
- 目录：**`<reviewer_uid>/<doc_id>.<ext>`**（ext 由魔数决定：pdf/jpg/png）。按审核员分目录是硬要求（水印含 RV 码，各人不同）。
- 存的内容：**EF 渲染后的水印字节**（与现在 EF 直接回给前端的完全一致）。
- 与原桶关系：原件仍只在 `student-documents`，**原件绝不出网、桶零改动**；wm-cache 只存"已打好水印的派生件"。双盲不破（水印件本就是给审核员看的那一份）。
- 生命周期：随派单在、随撤单/软删清（见 §5）。

## 2. EF 加 `prepare` 模式
- watermark-doc EF 新增分支：`POST {doc_id, reviewer_uid, mode:'prepare'}`，**认证走 hook 暗号（x-mh-hook-secret）而非用户 JWT**（因为是触发器/后台调，无用户会话）。
- 逻辑：复用现有"下原件 → 按魔数加水印"整段，**渲染后不回字节，改为 service_role 上传到 `wm-cache/<reviewer_uid>/<doc_id>.<ext>`（upsert）**，返回 `{ok:true, cached:true}`。
- 归属校验：prepare 模式下校验 `reviewer_assignments(doc_id, reviewer_uid)` 确有该行（防乱预渲染）。
- 审计：prepare 可写一条 `reviewer_access_log`（outcome=`prepared`）或不写（后台预渲染非"查看"，建议标 prepared 以区分）。
- **reviewer 现有 `POST {doc_id}` 路径逻辑零回归**（只加分支，不动原分支）。

## 3. 派单后怎么触发 EF 预渲染（pg_net vs cron）
- **首选：AFTER INSERT 触发器 on `reviewer_assignments`**，照抄 `notify_email_fanout_fn()`：`net.http_post(url=.../watermark-doc, headers={x-mh-hook-secret}, body={mode:'prepare', doc_id:new.doc_id, reviewer_uid:new.reviewer_uid}, timeout)`。
  - 只对可水印类型触发（jpg/jpeg/png/pdf）——可在触发器里 join documents 看 file_name 后缀，或干脆都打（EF 对不支持类型回 415，不落缓存，无害）。
  - 失败不回滚派单（pg_net 是异步 fire-and-forget，天然如此）。
- **补充：cron 扫兜底**（可选，二期）——一个 `pg_cron` 每 5 分钟扫「有 assignment 但 wm-cache 里没有对应对象」的组合补渲染，防 pg_net 偶发丢包。首版可先只上触发器，兜底 cron 记 backlog。

## 4. 审核端「查看」改：先试桶，失败再走 EF
- `_wmFetch(docId)` 改造：**第一步先向 `wm-cache/<myuid>/<docId>.<ext>` 要签名 URL 并 fetch**（需知道 ext——可让一个轻 RPC 或 EF `head` 返回，或前端按 doc 类型推；最稳是加一个 `wm_cache_signed_url(doc_id)` RPC，service_role 查 wm-cache 里该审核员目录下匹配 doc_id 的对象、返回签名 URL 或 null）。
  - 命中 → 直接下载水印件（1–2s，无 EF 冷启动）。
  - 未命中/签名失败/对象不存在 → **回落现有 `POST {doc_id}` 走 EF 实时渲染**（与今天完全一致，慢但保底）。
- `_wmPrefetch` / `_wmPrefetchQueue` 同样先试桶再回落。内存缓存层不变。
- **关键：桶是"加速层"，永远有 EF 实时兜底**——桶空了/没渲染到，功能照常，只是慢。真实用户不会因为缓存没命中就看不了。

## 5. 撤销派单 / 材料软删时的清理
- **撤销派单**（`admin_revoke_dispatch` 置 `revoked_at`）→ 删 `wm-cache/<该reviewer>/<doc_id>`（该审核员这一份）。
- **材料软删**（documents.`deleted_at`）→ 删 `wm-cache/*/<doc_id>`（**所有审核员**目录下这份 doc 的缓存都清）。
- 实现方式二选一：
  - a) AFTER UPDATE 触发器（revoked_at / deleted_at 由 null 变非 null 时）→ net.http_post 打 EF 一个 `cleanup` 模式（service_role 删桶对象）。
  - b) 上面那个兜底 cron 顺带清理"孤儿缓存"（assignment 已撤/doc 已软删但缓存还在）。
- 首版建议：**a) 触发器即时清**（撤单/软删是低频操作，即时清最干净）；cron 只做补漏。

## 6. 迁移内容清单
> ⚠ 队列写的"迁移 0174"是笔误——0174 早已用掉，本轮迁移已到 **0188**。本设计的迁移**施工时取下一个空号**（届时 0189 或更后），下称 `NNNN_wm_cache`。
`NNNN_wm_cache.sql` 内容：
1. `insert into storage.buckets (id, name, public) values ('wm-cache','wm-cache', false)`（私有桶）。
2. wm-cache 的 storage RLS 策略：**仅 service_role 写/删**；读走签名 URL（不给 authenticated 直读策略）。
3. AFTER INSERT 触发器 on `reviewer_assignments` → 调 EF prepare（pg_net）。
4. AFTER UPDATE 触发器 on `reviewer_assignments`（revoked_at）+ on `documents`（deleted_at）→ 调 EF cleanup。
5. 可选：`wm_cache_signed_url(doc_id)` RPC（SECURITY DEFINER，校验调用人是该 doc 的归属审核员，返回其目录下签名 URL）。
6. 可选（二期）：pg_cron 兜底扫描作业。
- **全部是新增型**（建桶/加策略/加触发器/加函数），无删除，可走 db-run.sh；EF 代码改动要业主手动 deploy。

## 7. 预期效果
- 首开：**2.7–3.7 秒 → 1–2 秒**（省掉 EF 冷启动 + 服务端渲染，只剩"下一个已渲染好的文件"）。
- 派单后台预渲染让"审核员第一次点开"就是热的；内存缓存 + 桶缓存双层，同一份二次查看仍 0 网络。
- 兜底不变：桶未命中自动走 EF，功能零风险。

## 交付边界
本包**只出设计，不动任何代码/EF/迁移**。等业主看过设计再开施工包。
