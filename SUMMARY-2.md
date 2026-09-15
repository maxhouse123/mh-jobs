# 第二轮队列 · 总回执（2026-09-15）

> 给业主看的大白话总账。全程未推主仓库（10 个本地提交等你验收后自己挂代理推）；日志仓库 `~/mh-jobs` 已实时推送。

## 1. 十四包结果一览

| 包 | 结果 | 一句话 |
|---|---|---|
| JOB-2-01 | ⛔ **FAIL·无数据** | 你以为造好的测试数据其实没进库——seed 里付款方式写了 `wechat/alipay`，违反库的 CHECK 约束（只认 paypal_manual/offline/stripe/flutterwave），整笔回滚，五样全 0。**未擅自跑/改 seed。** |
| JOB-2-02 | ✅ 全闸过 | 驾驶舱已录取/转化率 + 合作伙伴累计推荐 换真派生（v183） |
| JOB-2-03 | ✅ 全闸过 | 撤掉学校「收入」字段（列/页头/抽屉KPI）（v184） |
| JOB-2-04 | ✅ 全闸过 | 签证有效期 / 委托代录徽章 / 中介推荐草稿 / offer 范例 四项（v185） |
| JOB-2-05 | ✅ 全闸过 | 学校抽屉补「招生任务」+「成员账号」两段（v186） |
| JOB-2-06 | ✅ 全闸过 | 证件核验绿标批量装载器（改读云端，假种子不再亮）（v187） |
| JOB-2-07 | ✅ 全闸过 | 材料软删 + 解锁材料槽 + 管理操作历史（迁移+v188） |
| JOB-2-08 | ✅ 全闸过 | 替换通知书 + 撤销派单（软撤销回可派池）（迁移+v189） |
| JOB-2-09 | ✅ 全闸过 | 停用学校 + 改学校档案（每行可改带审计）+ 操作历史（迁移+v190） |
| JOB-2-10 | ✅ 全闸过 | 层级链A：tier 四档统一 + 名额配置表 + 学校提额审批（迁移+v191） |
| JOB-2-11 | ✅ 全闸过 | 层级链B 学校端：读真名额 + 提额写真表（学校 v226） |
| JOB-2-12 | ⛔ **停·表名撞车** | 要建的 `school_access_log` 被库里一张 666 行的 EF 日志表占了（schema 完全不同）；迁移已备好（改名 `school_action_log`）**未执行**，等你一句确认表名 |
| JOB-2-13 | ⏸ **暂缓** | 学校端留痕埋点，依赖 JOB-2-12 的表/函数，等表名定了一起做 |
| JOB-2-14 | ✅ 探完 | 只探不改；七条数据源全探清（见第 4 节 + 该包回执） |

**成果：11 包做实全闸过（含 4 条迁移我自己经 db-run.sh 跑通），1 包因缺数据 FAIL，2 包因表名撞车暂缓，1 包探针完成。**

## 2. 我自己跑通的迁移（跑前跑后差值）

| 包 | 迁移做了什么 | 跑前 → 跑后 |
|---|---|---|
| JOB-2-07 | documents +4 列（软删三列+解锁标记）+ 2 函数 | 列 14→18；本卡函数 0→2 |
| JOB-2-08 | reviewer_assignments +3 列（软撤销）+ 2 函数 + offer-letters 桶 admin 上传策略 | 列 5→8；函数 0→2；策略 +1 |
| JOB-2-09 | schools +3 列（停用）+ 3 函数 | 列 24→27；函数 0→3 |
| JOB-2-10 | tier_quota 配置表(4行) + schools.tier 值域统一(12行) + school_quota_requests 表 + 2 函数 + tier check | tier 空8/A1/B2/C1 → trial9/standard2/advanced1/enterprise0；+2 表；函数 +2 |
| JOB-2-12 | school_action_log 表 + log_school_access 函数 | **未执行**（表名撞车，等确认） |

四条迁移（07/08/09/10）均 `DB-RUN OK`，跑前跑后计数写进各自回执。

## 3. 五端最终版本 + md5

| 端 | 版本 | md5 | 说明 |
|---|---|---|---|
| **admin** | **v191** | `8b65a15c3d9def1faffed2460fd618d4` | 本轮 v182→v191（9 版）；index 已指 v191 |
| **school** | **v226** | `ce8c2a9a624a4a5cdac7c6b514fc9451` | 本轮 v225→v226；index 已指 v226 |
| student | v379 | 未动 | 本轮未动 |
| reviewer | v31 | 未动 | 本轮未动 |
| partner | v147 | 未动 | 本轮未动 |

链式基底逐版相扣：admin `93b7f4(v182)→0c4125(v183)→18e07a(v184)→a4caef(v185)→919af0(v186)→65b5ee(v187)→9bb020(v188)→3d0f8b(v189)→85eb3c(v190)→8b65a1(v191)`；school `23928e(v225)→ce8c2a(v226)`。

## 4. JOB-2-14 七条探针结论（拿去开第三轮）
1. **材料闸门**：管理员可自算（documents+review_verdicts+school_doc_reviews 已加载），无需策略。→ 直接做
2. **邮箱验证**：学生走 `students.email_verified`（已可读）；学校/中介需一个 admin 函数读 auth.users。
3. **AI 预检**：不在 documents（无 jsonb 列），在 `ai_precheck_shadow`/`ai_precheck_draft` 表——第三轮先补结构探针。
4. **分享记录**：表 `media_shares`，**无 admin 策略**→需加 admin 只读策略。
5. **所在地变更**：表 `location_change_requests`，**无 admin 策略**→需加 admin 只读策略。
6. **委托邀请+代付**：named_invites + payment_orders(lane=agent) 策略齐→直接做。
7. **学生中介标记**：partners(kind=student_agent,6行)与学生同 uid，策略齐→直接做。

## 5. 四个「必须停/暂缓」要你回答/确认的
- **JOB-2-01**：要不要我把 seed 的 method 从 `wechat/alipay` 改成库允许的值（如 `offline`）后重跑，好让那五条验收能做？（在那之前五条验不了）
- **JOB-2-12**：留痕表用 `school_action_log`（推荐，零风险，我下轮直接跑）还是坚持 `school_access_log`（需先处置现有 666 行 EF 日志表，属破坏性，须你拍板）？
- **JOB-2-13**：随 JOB-2-12 一起，表名定了就做。
- **JOB-2-14**：七条按第 4 节排第三轮（1/6/7 能直接做，4/5 各一条策略迁移，2 校/中介需函数，3 先探结构）。

## 6. 我发现的、指令没写到的问题（你该知道）
1. **测试数据没落地**（JOB-2-01）：seed 的 method 值违反 CHECK 约束，"数据已造好"与实测不符。
2. **`school_access_log` 名字被占**（JOB-2-12）：库里已有一张 666 行的同名 EF 水印日志表，与 JOB-14 设计的 schema 完全不同。CLAUDE.md 其实记过"三张 access_log 表在库"，此处正是撞上其一。
3. **多处"回可派池/停用/删除"因红线禁 DELETE + db-run 禁 drop，改用非破坏性标记**：撤销派单=软撤销(revoked_at)、停用学校=suspended_at 标记(status CHECK 不含 suspended)、删材料=软删(deleted_at)。均达成目的且可回滚。观察项：审核员端"我的待审"若也按 reviewer_assignments 判断，需同样过滤 revoked_at（reviewer 端后续）；"停用只挡新动作"的实际拦截需相关 RPC 检查 suspended_at（后续）。
4. **tier 回填不可逆**：A/B/C/空 已并入四档，原区分丢失（裁决6 明授权）。
5. **提额批准≠自动加名额**：admin_decide_school_quota 只改状态；真加名额靠管理员升层级（两端一致，已在回执说明）。
6. **`admin_delete_document` 等参数按真实列类型用 text**（doc_id 实为 text，非 QUEUE 写的 uuid）。
7. **真写入类操作（删/解锁/替换/停用/改档/设层级/提额）的端到端**留你线上登录验收——psql 无管理员 auth 上下文，is_admin 门会拒，容器内跑不通真写入；本地一律用受控桩验证接线。
8. **管理端仅中英**（无俄法），本轮所有 admin 包的"四语"=中英齐全零裸键；学校端四语，JOB-2-11 新增文案已四语。

---
**下一步在你**：①本地开 admin v191 / school v226 验收 → 满意就挂代理推主仓库；②回答第 5 节四问，我开第三轮。**主仓库本轮全部未推。**
