# 第三轮队列 · 总回执（2026-09-15）

> 大白话总账。全程未推主仓库（本地 6 个提交等你验收后自己挂代理推）；日志仓库 `~/mh-jobs` 已实时推送。

## 1. 七包结果一览（全部落地）

| 包 | 结果 | 一句话 |
|---|---|---|
| JOB-3-01 | ✅ 全闸过 | 残留清扫七件：本月改当月 / [VER] 探针补课 / 删三块死代码 / 筛选条状态·层级小标 / 草稿同名区分 / 空邀请码破折号 / 旧表取件标签（admin v193 + school v228）|
| JOB-3-02 | ✅ 全闸过 | 事件时间线词表扩到覆盖全部种类 + 兜底「其他·kind」，英文原始代码清零（admin v194）|
| JOB-3-03 | ✅ 全闸过 | 材料四类闸门药丸+总标 / 学生邮箱验证徽章 / 学生中介标记可跳转（admin v195）|
| JOB-3-04 | ✅ 全闸过 | 中介委托邀请+代付款两段 + 三个半对收口（操作历史补撤回/学生曝光暂停申请/学校任务移出计数）（admin v196）|
| JOB-3-05 | ✅ 全闸过 | 学生抽屉分享记录+所在地变更两段（迁移+admin v197）|
| JOB-3-06 | ✅ 全闸过 | 学校/中介邮箱验证徽章（迁移 admin_email_verified + admin v198）|
| JOB-3-07 | ✅ 探完 | 只探不改；AI 预检两表 + 草稿链探清（见第 4 节）|

**7 包全部落地：6 包做实全闸过（含 2 条迁移我自己经 db-run.sh 跑通）+ 1 包探针完成。**

## 2. 第三轮硬规矩执行情况（[VER] 探针）
每个新版本三处版本号同步：文件头注 + **console.info('[VER] …')** + index.html。闸5 加了断言：产物里 `[VER] admin portal vN` / `[VER] school portal vN` 必须 = 本版号，否则闸不过。**六个新版本全部通过该断言**（admin v193→v198 逐版改 console 探针；school v228 从 v225 补课）。

## 3. 我自己跑通的迁移（跑前跑后差值）
| 迁移 | 做了什么 | 差值 |
|---|---|---|
| JOB-3-05 | media_shares + location_change_requests 各加 admin 只读策略 | 策略各 +1；数据 media_shares 12 行 / location_change_requests 5 行 |
| JOB-3-06 | admin_email_verified(uuid) 函数（读 auth.users.email_confirmed_at, is_admin 门） | 函数 0→1；auth.users 已验证账号 57 |

两条均 `DB-RUN OK`。

## 4. 删的三块死代码（JOB-3-01，都先证零调用）
- 管理端 `setSchoolTier` + `_v22SchoolTierSection`（旧青铜/白银/黄金+本机缓存；层级段 v191 起走 _v191SchoolTierSection，零调用）→ 闸6 报这两个消失（故意删）。
- 学校端 `scheduleMockQuotaReview` + `OFFER_QUOTA_REVIEW_DELAY`（10 秒假审核；提额 v226 起走真表，零调用）→ 闸6 报 scheduleMockQuotaReview 消失（故意删）。

## 5. JOB-3-02 探出的事件种类全表
admin_events 21 种 + notifications 23 种（去重约 40），全部进了词表。完整清单见 `jobs/JOB-3-02/report.md`（含每种计数）。

## 6. JOB-3-07 三条探针结论（第四轮用）
1. **AI 预检**：`ai_precheck_shadow`(65 行, 键 doc_id+student_id) / `ai_precheck_draft`(35 行, 键 doc_id+uid)，警告在 `issues(jsonb)`；两表 RLS 开·0 策略 → 需各加 admin 只读策略；材料行按 doc_id 显 verdict+issues（主表取 shadow 建议，待你确认）。
2. **草稿函数**：save_my_draft / get_my_draft 都读写 **application_drafts** 表（已定位）。
3. **草稿表**：`application_drafts`（18 行：student 15/school 2/partner 1；键 user_id+portal，payload jsonb），RLS 开·0 策略 → 需 admin 只读策略或 admin_list_drafts RPC；展示 payload 需按双盲脱敏。

## 7. 五端最终版本 + md5
| 端 | 版本 | md5 |
|---|---|---|
| **admin** | **v198** | `76e88477cf5a3894f7cd812ff1cc3f2f` |
| **school** | **v228** | `745c914b8ef4cf5ac6d9a014904084c7` |
| student | v379 | 未动 |
| reviewer | v31 | 未动 |
| partner | v147 | 未动 |

链式基底：admin `5e7229(v192)→1b870a(v193)→c723a6(v194)→c0a679(v195)→ef0dd0(v196)→e32b19(v197)→76e884(v198)`；school `5b8e95(v227)→745c91(v228)`。index 均已指向最新版。

## 8. 我发现的、指令没写到的问题
1. **旧 school_access_log 不区分 view/download**（只有 file_kind/outcome），故「取件」标保留 + 补文件类型（JOB-3-01 item7 诚实结论）。
2. **真写库/真登录态的验收**（材料闸门是纯派生可本地看；但邮箱验证徽章、曝光暂停申请、admin_email_verified 等走 is_admin/RPC 的真值）需你线上登录管理员看——容器无登录态，本地一律用受控桩验证接线。
3. **exposure_requests / 草稿相关**：exposure_requests 库里 0 条（暂停申请通道已通、无数据）；application_drafts 有 18 条草稿但管理员暂无策略读（第四轮）。
4. **Python 3.9.6 tokenizer**：含大量中文长行的补丁脚本需显式 `# -*- coding: utf-8 -*-`（JOB-3-04 起已加），否则报假的「Non-UTF-8」。

---
**下一步在你**：①本地开 admin v198 / school v228 验收 → 满意就挂代理推主仓库（本轮 6 个本地提交）；②第四轮据第 6 节开（AI 预检 + 草稿清单，各需 admin 只读策略；两个口径待你定）。**主仓库本轮全部未推。**
