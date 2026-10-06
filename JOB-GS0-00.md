# JOB-GS0-00 回执 · 学校端源码对照表 + 数据库只读探针

做完了，全程只看不改，没动任何数据、没发任何 offer、没建任何任务。下面用大白话说清楚查到了什么。

## 一、学校端现在是哪一版、几种语言
- **现役版本**：v245，文件 `maxhouse-school-portal-v245.html`（根目录 `school-portal/index.html` 这一版就跳到它）。
- **指纹 md5**：`6851ea1ae17f379a520951b8f4b4a5c9`；页面里版本探针 `MH_PORTAL_VER=245`，头注 `[VER] v244→v245` 都对得上。
- **语言**：学校端界面**只有两种语言——中文和英文**（右上角和登录页都只有「EN / 中」两个按钮）。
  - 俄文、法文只有少量零碎词条（各 63 条，主要是给学生写的内容做「本条无XX版本，以下为YY原文」的回落提示），**没有俄/法切换按钮，学校老师点不到**。中英则是**各 1600 多条词条、完整**。
  - 语言包是**写死在这个大 HTML 文件里的**（不是外挂的 js 文件）。页面只外链两个脚本：`vendor/supabase.js`（连数据库用）和 `assets/mh-viewer-v2-1-1.js`（图片/PDF 放大镜组件）。

## 二、对照表（画面 → 入口 → 控件 → 用到的后台 → 成功提示）
- 机器可读的完整版在 `jobs/JOB-GS0/school-map.json`，副本已推到公开仓库 `JOB-GS0-school-map.json`。
- 一共整理了 **34 个画面**（任务书要求 ≥20），每个都写清楚了：从哪进、关键按钮/输入框的代码定位（id/class/函数名）、会调哪些后台接口/表、成功后出什么提示。
- 覆盖到了任务书点名的全部环节：登录（含语言门、角色门、忘记密码、注册）、工作台首页六个统计卡+名额面板+三个大按钮、招生任务列表/新建表单（全部字段：中英文名、层次、入学季、专业、人数、截止、报到时间窗、自费/奖学金、附件；「第 3 个起需平台审批」的提示也在）、名额与九档提额申请、找学生①一键匹配、找学生②盲态筛选添加、候选池与学生五档状态、学生详情（解锁前看不到联系方式、材料列表、水印追溯码 SC-、双审结论、退回、放大查看器）、面试排期与记录、发 offer 表单、offer 列表与状态、学生接受后上传录取通知书/JW202、确认入学、联系方式互通、导出已录取名单、建档设定（录取办理方式）、账户设置、我的操作记录/审计日志、通知消息、收藏、语言切换。

## 三、后台接口/表 到底在不在（只读核对结果）
全部**在**，没有一个缺的：
- 源码里用到的 **35 个后台接口（RPC）全部存在**（add_task_candidate、create_admission_task、get_task_candidates、school_send_offer_after_interview、school_set_filing、search_students_blind、mark_student_enrolled、match_task_candidates…逐个核过）。
- 用到的 **16 张表/视图全部存在**（schools、students、admission_tasks、task_candidates、offer_decisions、school_quota_requests、filing_tasks、intake_terms、notifications、documents、school_access_log、school_members、tier_quota 等）。
- 用到的存储桶：`comm-attachments`、`offer-letters`、`offer-samples`、`school-onboarding-docs` **4 个都在**（源码里还有个 `schools`，那其实是一张表、不是桶）。
- 边缘云函数引用：`fetch-logo`、`send-verify-email`、`student-avatars`、`watermark-doc`。

## 四、两所演示学校现状（给后面演示数据轮用）
| 账号 | 校名 | 编号 | 状态 | 等级 | 等级名额 | 加成 | 总名额 | 已用 | 建档方式 | 任务数 | 候选人 | 发过offer | 已同意 | 已完成 | 提额申请 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **schX** | 演示大学 / Demo University | SCH-1AD6C8 | active | trial 试用 | 5 | 0 | 5 | 8 | form(自建表) | 8（全 active） | 9 | 8 | 7 | 4 | 0 |
| **guide_sch2** | 演示大学二号 / Demo University 2 | SCH-8E561C | active | 空(没设等级) | — | 0 | — | 2 | none(不建档) | 2（全 active） | 2 | 2 | 2 | 0 | 0 |

- schX 已用 8 > 总名额 5（演示数据本来就超额了），录制时注意这点可能会触发超额提示。
- guide_sch2 没有设等级（tier 空），名额算不出总数；是「空态/第二所校」的好样本。

## 五、演示学生现状
- 任务书说的「guide_* 五人」，实际库里 is_test 的 guide 学生里，**真正有资料的只有两个**：
  - guide_stuA：6 份材料、2 个 offer；guide_stub：7 份材料、1 个 offer。两人 stage 都是空、曝光 normal、都还没正式「提交」。
  - 其余 guide-agent / guide-agentfresh / guide-ref1~3 是代理/推荐类空壳账号，没有学生资料；guide-rec-en/zh（录制专用）在库里查不到 is_test 学生行（估计 G1-05 已回收）。**所以「五人」凑不齐，照实记录**。
- **整个演示池子有多厚**：is_test 学生共 **42 人**，其中 **25 人已提交**、**42 人都设了曝光级别**、**36 人有上传过材料**——浏览页能有四五十张卡，够录制用。

## 六、其它核过的事实
- **入学季**（intake_terms）：秋季2026（已关）、春季2027（开）、秋季2027（开）。
- **名额等级表**（tier_quota）：试用 5 / 标准 20 / 高级 100 / 旗舰 500。提额申请的九个档位（5/10/20/30/50/100/200/500/1000）写在前端。
- **「一所学校对一个学生只能有一份有效 offer」的唯一约束在**：索引 `uq_offer_live_per_school_student`（学校+学生，拒绝的不算）确实存在。
- **学校会收到的通知类型**（6 种）：面试已确认、面试被拒、通知书已付款、学生已回应 offer、平台对学校申请的决定、任务已审核。

## 闸门自查（任务书 GS0-00）
- ① 对照表 34 个画面（≥20），每个都有入口+至少一个控件定位 → 过。
- ② 每个接口/表/桶都有「在/不在」结论 → 全部「在」，过。
- ③ 探针 11 段每段都有输出 → 过（见 `jobs/JOB-GS0/probe-00.out`）。
- ④ `node -e` 能 JSON.parse 读 school-map.json → 过（34 screens）。

## 产出文件（都在本机 /Volumes/Dev/MAXHOUSE）
- `jobs/JOB-GS0/school-map.json`（对照表，公开仓库有副本 `JOB-GS0-school-map.json`）
- `jobs/JOB-GS0/probe-00.sql` + `probe-00.out`（只读探针与输出）
- 辅助脚本：extract.mjs / i18n.mjs / build-map.mjs / probe-cols*.sql（只读）

没有红线触发，没有停工。下一包 GS0-01（截图+试录+环境探针）继续。
