# JOB-G0-03 回执 · 演示学生 B（Omar，在华）+ 补充信息表待填

日期 2026-10-05 ｜ 账号 guide_stuB（Omar Demo，Currently in China）

## 一句话
Omar 从真站走完在华生的申请（比 Lina 多传一张「签证/居留许可」并填了有效期），七份材料全批，收到一份录取、接受、学校发通知书、¥0 解锁、JW202 到手；学校把「需建档」打开后，Omar 的录取里出现了橙色「补充信息表」按钮（点开就是那张要填的表，带「让 AI 从材料里读」按钮）——按要求**没填、没点**。四条判据全过。

## 判据结果（真站以 Omar 登录断言 + 截图）
- ① Admissions 显示已确认 + 通知书与 JW202 两份文件可开：**过**（线上实测两文件 HTTP 200，85160 / 75643 字节）
- ② 学生端出现补充信息表橙色行动卡、点开有「让 AI 从材料里读」按钮：**过**。说明位置：这张橙色「📝 Supplementary form」按钮在**「打开那份录取详情」后**出现（因为 Omar 的录取已全部办完，工作台顶部的大卡显示「已就绪」，补充信息表按钮就落在录取详情里）。点它会打开补充信息表，表里有「让 AI 从材料里读」按钮——**我只核对到按钮在，没有打开填写、没有点 AI**。
- ③ 材料区有「签证/居留许可」一项且已批：**过**（visa:approve，有效期填到 2027-08-31）
- ④ 所在地变更入口可见：**过**（在材料页，签证那块有「Document valid until / 所在地切换申请」入口；**没有提交任何变更**）

截图：`jobs/JOB-G0/shots/g0-03-stuB-offer-modal.png`（橙色补充信息表按钮）、`g0-03-stuB-materials-visa.png`（签证+所在地入口）、`g0-03-stuB-dashboard.png`。

## 用的哪条路（同 G0-02 口径）
- 学生侧全走**真站真页面**（登录、第2步在华、第3步资料、传七份材料含签证、提交），复用 `flows/student-apply.mjs`（本包验证了在华「签证槽」分支）。
- 材料审核、建任务、发 offer、接受、付款、解锁、传通知书/JW202：**带身份调同一后台函数 + schX 真会话传 PDF**（同 G0-02）。
- 「需建档」打开：把 schX 的建档系统设为 **form + before_letter**（Omar 接受 offer 时系统自动建了一张「待学生填」的补充信息表任务，于是出现那个橙色按钮）。签证有效期：写到 Omar 的签证材料上。
- 写入表/桶：schools.filing_system、documents.valid_until、review_verdicts、admission_tasks(ADM-100013)、task_candidates、offer_decisions、coupon_redemptions、offer-letters 桶。

## 给 G-1 录制的一句提醒
如果录视频时想让「橙色补充信息表卡」出现在**工作台顶部的大提示位**（而不是录取详情里），录制时把 Omar 停在「已接受 offer、学校刚发通知书、**还没付款**」那一刻——那时顶部大卡就是橙色的补充信息表提示。一旦付款办完，顶部大卡会变成绿色「已就绪」，补充信息表按钮就移到录取详情里（本轮演示数据是办完的状态，所以按钮在详情里；两种状态都真实、都可录）。

## 产物
- `g0-03-run.mjs`（编排/可重建）、`g0-03-backstage.sql`、`probe-03.sql`、`make-docs` 的 omar 材料与通知书、`created-ids.json` 追加 G0-03。
- 主仓库：本包脚本已 git add + commit（未 push）。
