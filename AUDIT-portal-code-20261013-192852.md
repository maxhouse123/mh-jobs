# AUDIT-portal-code · 主仓库五端、共用组件、迁移的改动记录（2026-10-04 起，业主卡 1382 自动生成）

生成时间 2026-10-13 19:28:54；本机 HEAD eb3da7d；线上 origin/main 0eb0c78

## 1. 2026-10-04 起改动过这些目录的提交（只列提交说明与路径，不含内容）

f9bf056 2026-10-12 20:17:52 +0800 JOB-GP1-PF 中介端工作台录取漏斗/人均offer修复 partner v184→v185 (业主裁决RULING-20261012d选A:先修产品再录)

M	partner-portal/index.html
A	partner-portal/maxhouse-partner-portal-v185.html

e7e40f8 2026-10-10 17:22:17 +0800 JOB-G8-03d: ch10 补充信息表表头手机排版修（业主裁决A·真修表）——出共用组件 v1-7(仅末尾追加表头 CSS: flex-wrap:wrap+标题 min-width:12ch+琥珀/按钮 white-space:normal+手机≤640px 标题独占行/右组下移左对齐/× 绝对定位；JS/文案/字段/REQUIRED(55)一字不动)、student v413 与 partner v184 均只换组件引用+版本四件套；取证对上裁决第五节四判据(head flex/nowrap、标题 clientWidth=16<120、右组 scrollWidth=414>视口390、琥珀 nowrap)，改后四语两宽度 file:// 验收全 PASS(标题≤2行/零溢出/首字段顶≤496px)。铁律15 已提交未推，待业主本地肉眼终验

A	assets/mh-filing-form-v1-7.js
M	partner-portal/index.html
A	partner-portal/maxhouse-partner-portal-v184.html
M	student-portal/index.html
A	student-portal/maxhouse_student_portal_v413.html

729521b 2026-10-10 13:34:37 +0800 JOB-G8-02(§3.1): 付款单改名「录取通知书解锁费 / Admission Letter Unlock Fee」四语三端——student v411→v412(EN内联词典+内联HTML默认改, ZH/RU/FR外部i18n v360→v412三新文件, i18n引用行同步)/partner v182→v183(EN+ZH内联改, RU/FR外部i18n v126→v183两新文件)/admin v249→v250(优惠码banner+提示+面包屑精确费名改; 仪表盘会计简称中介费/标识符INTERMEDIARY_FEE刻意保留非付款单名); 逐键精确替payment.title/amountLabel/amountDesc/serviceFee.lead/coupon.banner100/unlock.payDesc/detail.serviceName/timelinePaid/privacyDesc, 泛指服务费/service fee/concierge/审核费一律不动; RU/FR CC手译(回译见回执); 云函数ai-translate术语表同步改源(不部署, 留业主); 四件套齐(名/头注或[VER]/MH_PORTAL_VER/index重定向); 旧精确费名残留全0; 随卡回归tests/g8-02-fee-rename.mjs 62/0绿; 像素验收留业主(铁律15闸二); §3.3第10章排版offline无bug需业主live(不算停)

M	admin-portal/index.html
A	admin-portal/maxhouse-admin-portal-v250.html
M	partner-portal/index.html
A	partner-portal/maxhouse-partner-i18n-v183-fr.js
A	partner-portal/maxhouse-partner-i18n-v183-ru.js
A	partner-portal/maxhouse-partner-portal-v183.html
M	student-portal/index.html
A	student-portal/maxhouse_student_i18n_v412_fr.js
A	student-portal/maxhouse_student_i18n_v412_ru.js
A	student-portal/maxhouse_student_i18n_v412_zh.js
A	student-portal/maxhouse_student_portal_v412.html

7803748 2026-10-10 13:07:18 +0800 JOB-G8-02(§3.2): 演示校三接口按 is_test 过滤——迁移0226重建 search_students_blind/match_task_candidates/get_task_candidates,各加「students.is_test = 任务所属学校 is_test」过滤(演示校只见测试生/真校只见真学生);签名/返回列/SECURITY DEFINER/search_path 不变,CREATE OR REPLACE 保留GRANT(authenticated在),RLS不动;已 db-run 应用maxhouse_main;探针(jwt模拟)验:测试校ADM-100000 search48/0非测试泄漏 match+2 pool9/0泄漏,真校ADM-100006 search10/0测试泄漏 pool4/0泄漏——全0

A	supabase/migrations/0226_demo_school_is_test_filter.sql

950dc21 2026-10-04 07:18:17 -0700 JOB-42-01 缩略图到期稳健重签: student v411 + partner v182

M	partner-portal/index.html
R099	partner-portal/maxhouse-partner-portal-v181.html	partner-portal/maxhouse-partner-portal-v182.html
M	student-portal/index.html
R099	student-portal/maxhouse_student_portal_v410.html	student-portal/maxhouse_student_portal_v411.html

## 2. 本机工作区里这些目录现在有没有未提交的改动（空＝没有）

## 3. 本机与线上 origin/main 在这些目录的差异（空＝一致）

## 4. 各端入口现在指向的版本
student-portal: maxhouse_student_portal_v413 
school-portal: maxhouse-school-portal-v245 
partner-portal: maxhouse-partner-portal-v185 
admin-portal: maxhouse-admin-portal-v250 
reviewer-portal: maxhouse-reviewer-portal-v46 
