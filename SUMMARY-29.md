PUSH_OK=yes

# SUMMARY-29 · 第二十九轮收官（快车道：管理端派单台三处病 + 学校端提额数量九档）

> PUSH_OK=no 的意思：CC 全程不 push 主仓库（铁律4）。主仓库现有 4 笔 JOB-29-xx commit 在本地、未推。**推送请业主用卡1214**做（那张卡要先看这里的 PUSH_OK 与四段式推法）。~/mh-jobs 的四份回执 + 本 SUMMARY 已由 CC 逐包推送。`~/mh-verify/r29-STOP.txt` 不存在——本轮无「必须停」。

## 一、版本 / md5 账
| 端 | 版本 | md5 | 备注 |
|---|---|---|---|
| admin | **v237 → v238** | `333725531c9bde047c108088bf4bdc79` | 派单台三处病修 |
| school | **v240 → v241** | `ec9c9d2c052a34c312646b98bcade8a0` | 提额数量九档 |
| partner | v172（不动） | — | 未改 |
| student | v402（不动） | — | 未改 |
| reviewer | v46（不动） | — | 未改 |

迁移：**0221_admin_dispatch_docs.sql 只写文件、未真执行**（正本 `supabase/migrations/` + 镜像 `docs/supabase 文件/`，逐字节同）。全文见下方附录，业主收官后用卡1215 在 SQL Editor 手贴。

主仓库 4 笔待推 commit（`git log origin/main..HEAD`，本地实测）：
```
0c84a28 JOB-29-03 school v241 提额数量九档不按等级砍
85a3b42 JOB-29-02 admin v238 派单台三处病修
60896b0 JOB-29-01 迁移0221 admin_dispatch_docs 派单RPC(只写文件未执行)
606daae JOB-29-00 开工检查+库探针P1-P6+旧病先红
```

## 二、四包一句话
- **29-00**：开工核对（md5 全中、HEAD=origin）+ 库探针 P1–P6（拿到 reviewer_assignments 结构/约束/触发器、verdicts 词表、雷清单、学校侧配额表事实）+ 四条旧病先红（R1–R4 共 14 条全红、零 pageerror）。
- **29-01**：写迁移 0221 派单 RPC `admin_dispatch_docs`（撤销行 UPDATE 复用、不撞唯一约束）+ begin…rollback 探针实跑全过（recycled/skipped_active/skipped_deleted 各命中、101==101 回滚生效、not_admin 守卫 OK），**未真执行**。
- **29-02**：admin v238——派单台「全选/快捷键=当前列表单一真源」+「勾选只认当前列表(修剪)」+「池去软删/已裁决、加 .limit」+「确认派单走 0221 RPC，缺函数回退旧 insert 并在撞 23505 时点名学生+材料、可去掉重试」。闸3 中英 46 绿 0 err；P3 29 全过；N1 差集仅 §0.3 一项。
- **29-03**：school v241——提额数量九档 5/10/20/30/50/100/200/500/1000，不按等级砍，上限 1000；OFFER_QUOTA_TIERS 保留(N1)。闸3 中英 26 绿 0 err；P3 19 全过；N1 仅 +1 函数。

## 三、闸账（每条都过）
| 闸 | 29-00 | 29-01 | 29-02 | 29-03 |
|---|---|---|---|---|
| 旧病先红→绿 | R1–R4 全红(14) | — | R1/R2/R3 转绿 | R4 转绿 |
| P3 静态断言 | — | — | 29 全 PASS | 19 全 PASS |
| 无头真渲染(中英各一) | 红检 0 err | — | 46 绿 0 err | 26 绿 0 err |
| DB 探针 begin…rollback | P1–P6 只读 | 全过、101==101 | — | — |
| N1 授权移除对照 | 建基线 | — | 仅 §0.3(1 handler) | 仅 +1 函数、零移除 |
| 闸9 视觉零新增 | — | — | 零新 CSS、div 同基线 | 零新 CSS、div 同基线 |
| secret-scan | 净 | 净 | 净 | 净 |
| shell-lint | db-run.sh 未改 | 同 | — | — |

## 四、待业主亲眼看的条目（业主验收）
1. **管理端 v238 派单台**（贴 0221 前也可先看前半段）：开着「隐藏测试」、选好筛选 → 点「全选·当前 N 位 M 份」→ hero「已选 (N 份)」应 = 各卡「N 份待审」之和（不再虚高 20）→ 选审核员 → 确认派单 → 绿 toast。**贴 0221 后**，对一份撤销过的材料再派一次能成（走 recycle）。
2. **学校端 v241 提额页**：「申请增加 Offer 配额」应有 **5 / 10 / 20 / 30 / 50 / 100 / 200 / 500 / 1000 九个按钮**，点哪个填哪个，手填 1–1000 都行；上方小提示不再写「当前等级…最多 10 张」。

## 五、未放行 / 未做清单
- **0221 未真执行**：前端（29-02）已对「函数还没有」容错——RPC 报 42883/PGRST202 时自动回退旧 insert 路径（曾撤销的材料先派其余、撞 23505 会点名+可去掉重试）。贴上 0221 后撤销件才能真正 recycle 重派。
- **watermark / 审核端 / 中介端 / 学生端**：本轮全未动。
- **配额云化**：`admin_decide_school_quota` 仍是「后台审批翻状态」那道闸，本轮未改；提额只是前端放开数量档，写入 `school_quota_requests`（requested_quota 无 CHECK 上限，库不拦）。
- 主仓库 4 笔 commit **未 push**（等业主卡1214）。

## 六、29-00 探针查出的「雷清单」（贴 0221 前这些材料派不出去）
reviewer_assignments 总 101 行 / 撤销 1 / 在途 100。**唯一一颗雷**：
| doc_id | 材料 | display_code | 是否测试 | 撤销时间 |
|---|---|---|---|---|
| `259f456a-3f2b-4440-b2c6-70c4af910ae6` | bank | （空） | **是（is_test）** | 2026-09-17 05:10:35+00 |
它 doc 存在、未软删、无终审裁决、无在途派单、属测试学生——正是线上「派了就撞 23505」的那份。旧路径下它被「隐藏测试」藏着却被旧「全选」勾进去，导致整批原子回滚。v238 已把它挡在勾选集外；贴 0221 后它可 recycle 重派。
另：documents 软删 10 份（全无在途派单，此前全混在可派池里，v238 已在查询层剔除）；有终审裁决但无在途派单的 doc 12 份（v238 已从可派池剔除）。

## 七、0221 全文附录（业主卡1215 在 SQL Editor 手贴）
贴完 SQL Editor 末尾那句验证 select 应回 **1 行**：`admin_dispatch_docs | p_doc_ids text[], p_reviewer_uid uuid`。

```sql
-- 0221_admin_dispatch_docs.sql
create or replace function public.admin_dispatch_docs(p_doc_ids text[], p_reviewer_uid uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $fn$
declare
  _did          text;
  _inserted     text[] := '{}';
  _recycled     text[] := '{}';
  _skipped_act  text[] := '{}';
  _skipped_ver  text[] := '{}';
  _skipped_del  text[] := '{}';
  _has_doc      boolean;
  _has_active   boolean;
  _has_revoked  boolean;
  _has_verdict  boolean;
begin
  if not public.is_admin(auth.uid()) then
    raise exception 'not_admin';
  end if;
  if p_reviewer_uid is null then
    raise exception 'reviewer_uid required';
  end if;

  for _did in select distinct x from unnest(coalesce(p_doc_ids, '{}'::text[])) as x loop
    select exists(select 1 from public.documents d where d.doc_id = _did and d.deleted_at is null)
      into _has_doc;
    if not _has_doc then
      _skipped_del := _skipped_del || _did;
      continue;
    end if;

    select exists(select 1 from public.review_verdicts rv where rv.doc_id = _did and rv.status in ('approved','rejected'))
      into _has_verdict;
    if _has_verdict then
      _skipped_ver := _skipped_ver || _did;
      continue;
    end if;

    select exists(select 1 from public.reviewer_assignments ra where ra.doc_id = _did and ra.revoked_at is null)
      into _has_active;
    if _has_active then
      _skipped_act := _skipped_act || _did;
      continue;
    end if;

    select exists(select 1 from public.reviewer_assignments ra where ra.doc_id = _did and ra.revoked_at is not null)
      into _has_revoked;
    if _has_revoked then
      update public.reviewer_assignments
         set reviewer_uid  = p_reviewer_uid,
             assigned_by   = auth.uid(),
             assigned_date = current_date,
             revoked_at    = null,
             revoked_by    = null,
             revoke_reason = null
       where doc_id = _did;
      _recycled := _recycled || _did;
      continue;
    end if;

    insert into public.reviewer_assignments (doc_id, reviewer_uid, assigned_by)
    values (_did, p_reviewer_uid, auth.uid());
    _inserted := _inserted || _did;
  end loop;

  return jsonb_build_object(
    'inserted',        to_jsonb(_inserted),
    'recycled',        to_jsonb(_recycled),
    'skipped_active',  to_jsonb(_skipped_act),
    'skipped_verdict', to_jsonb(_skipped_ver),
    'skipped_deleted', to_jsonb(_skipped_del),
    'reviewer_uid',    p_reviewer_uid
  );
end;
$fn$;

revoke execute on function public.admin_dispatch_docs(text[], uuid) from public, anon;
grant  execute on function public.admin_dispatch_docs(text[], uuid) to authenticated;

notify pgrst, 'reload schema';

-- 验证：函数应恰有 1 行
select proname, pg_get_function_identity_arguments(oid) as args
from pg_proc where proname = 'admin_dispatch_docs';
```

**验证法**：① 上面最后一句回 1 行 `admin_dispatch_docs | p_doc_ids text[], p_reviewer_uid uuid`；② 回到管理端 v238 派单台，对一份「撤销过派单」的材料（如雷清单那份的同类）重派 → 应绿 toast「已派 …（其中 N 份是撤销后重派）」，不再撞 23505。

## 八、第三十轮建议包（必含项 + 本轮观察项）
1. **27-A 管理端 / 中介端层次归一**：学历层次/专业的显示与筛选在两端口径统一（复用 admin _v233* 那套）。
2. **27-B 管理员重置学生密码**：admin 侧一键触发 Supabase Auth 重置（走 EF/Admin API，不落前端密钥）。
3. **自定义 SMTP 配置单**：把邮件发信从默认 Supabase SMTP 切自有域，配 SPF/DKIM（maxhouses.net）。
4. **中介代填多层次写入**：partner 代填资料支持 target_programs 数组多层次（配 0217），与学生端 v402 同源。
5. **数据洞察真版**：admin 数据洞察页从 mock 切真表聚合（学生/申请/offer/付款的真实分布）。
6. **范例库云端版**：文书/材料范例库从本地样本切云端表 + 版本管理。
7. **本轮观察项**：
   - **P4 策略**：reviewer_assignments 上 `admin_all_assignments`(ALL) + `reviewer_select_own`(SELECT) 已覆盖；若将来加多管理员/审计需要，复核 select 覆盖面。
   - **P6 审批加量口径**：`admin_decide_school_quota` 目前只翻 status、不在函数里加配额数字——若要「批准即自动加 N 到 allocated」，需另设计（本轮未动）。
   - **配额云化**：提额已放开九档写 `school_quota_requests`；quota 的真正扣减/发放口径仍散在前端，建议后续块统一到数据层。
   - 迁移账本：0219/0220 是否已贴以库为准；0221 待业主卡1215 手贴。

> 2026-09-27 Claude 判定：首行原写 PUSH_OK=no 是 CC 把字段理解成「CC 自己没推」；四包闸全绿，改判 PUSH_OK=yes，业主已用卡1217 推送主仓库。
