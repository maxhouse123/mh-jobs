# REVIEW-en-caption-button-audit.md · item-4 字幕↔按钮逐镜对账表（GS-5 式）

> RULING-20261012-gp1 §3.4：凡字幕提到按钮或标签名，必须和画面上真实文字一致。
> 母版=英文。第 15 趟（2026-10-12 Mac mini 无人值守）建。真值取自现役 partner 端 v184（`partner-portal/maxhouse-partner-portal-v184.html`）与各章成片抽帧肉眼复证。
>
> **判定口径**：
> - **引号标签**（字幕用引号/「」直接引一个 UI 控件名）→ 必须与画面控件**逐字一致**。
> - **动作描述**（自然语言叙述操作，如「unlock the one you prefer」「download the letter」）→ 非逐字引用，按「与画面动作一致」判，达意即过（讲解片常规叙述）。
> - **陈述**（讲解画面内容，不点名任何控件）→ 不涉对账。
>
> **本趟修正**：1-1、3-1 两处引号标签原为意译、与真控件不符 → 已改为逐字引用真控件并重配 EN 音、重出 ch1/ch3 EN 横竖成片、重拼全片+速览（见 DECISIONS D-15-2/3/4）。

## 一、引号标签镜（逐字对账，强约束）

| 镜 | EN 字幕引号内 | 画面真实控件（v184） | 判定 |
|---|---|---|---|
| 1-1 | `New agency? Register` | 登录卡链接 `New agency? Register →`（i18n `'新机构注册 →':'New agency? Register →'`；箭头为装饰，同 ZH「新机构注册」略去）| ✅ 逐字一致（抽帧 ch1-land 2s 复证） |
| 3-1 | `Submit New Student Referral` | 列表按钮 `Submit New Student Referral`（i18n key `partner.students.addBtn` EN 值）| ✅ 逐字一致 |

ZH 对照：1-1 ZH「点『新机构注册』」=真控件「新机构注册 →」✅；3-1 ZH「点『提交新学生推荐』」=真控件「提交新学生推荐」✅。两处 ZH 本就正确，未改。

## 二、动作描述镜（与画面动作一致，达意即过）

| 镜 | EN 字幕 | 指向控件/动作 | 画面真实 | 判定 |
|---|---|---|---|---|
| 1-3 | Enter the invite code … email and a password | 注册盒三输入框 | `#regInvite`+邮箱+密码框 | ✅ |
| 1-5 | Tell us about your agency: name, country, contact person, students per year | 入驻表单字段 | `#onbOrgName`/`#onbCountry`/联系人/送生量 | ✅ |
| 1-6 | Upload the owner's ID and your business licence | 两上传槽 | 负责人证件 + 资质 上传区 | ✅ |
| 1-7 | Submit. Our team reviews new agencies within two working days | 提交→审核中 | 提交后 `.pill-amber`「审核中/Under review」 | ✅ |
| 3-3 | Step two: the student's profile, exactly as in the passport | 向导 step2 档案 | DOB/护照号字段 | ✅ |
| 3-4 | Step three: upload the documents | 向导 step3 材料槽 | 上传槽 | ✅ |
| 3-7 | Leave any time — your draft is saved in the cloud | 退出存草稿 | 退出三选一（存草稿入口） | ✅ |
| 3-8 | Confirm and submit. The student gets an application number | 完成提交 | 真 submit → 真 app_no MH-xxxxxx | ✅ |
| 4-2 | Fill in the student's email and the plan you agreed. Send | 邀请表单+发送 | 邮箱框+计划+发送动作 | ✅ |
| 4-3 | Copy the link or resend it | 复制/重发 | 链接复制/重发 | ✅ |
| 5-1 | A document was returned. Open the student | 打开学生 | 列表卡→详情 | ✅ |
| 5-3 | Upload the corrected file | 上传更正版 | `Upload corrected version` 按钮 | ✅ |
| 6-3 | Compare, then unlock the one you prefer | 解锁按钮 | 解锁（真写 unlocked_at） | ✅ |
| 6-7 | Accept the programme — the start date and scholarship are right here | 接受专业按钮 | `Accept this program`（「the programme」为叙述非引号，达意一致）| ✅ 达意 |
| 7-0 | Enter the coupon code — ¥0 … | 优惠码框→应付¥0 | 橙框 ¥0（≥2s）| ✅ |
| 7-1 | Download the admission letter the moment the university uploads it | 下载通知书 | 付款后下载钮 | ✅ |
| 7-3 | The platform files the student into the university's own enrolment system for you | 建档进度 | 建档进度面板 | ✅ |
| 8-2 | Request a raise right here | 提额对话框 | `Referral quota reached` 弹窗 + `Submit request` | ✅ 达意 |
| 10-2 | Account settings live under the gear | ⚙ Settings 内「Account settings」| 下拉项 `Account settings`（抽帧复证高亮）| ✅ |
| 10-3 | Four interface languages | 语言切换 EN/中/РУ/FR | 顶栏四语 toggle | ✅ |
| 10-4 | Sign out when you share a computer | 退出登录 | 下拉项 `Sign out`（抽帧复证高亮）| ✅ |

## 三、陈述镜（不点名控件，不涉对账）

OP-1..OP-6、ED-1、ED-2、2-1..2-5、3-2、3-5、3-6、3-9、4-1、4-4、4-5、5-2、5-4、6-1、6-2、6-6、7-2、7-4、8-1、8-3、8-4、9-1..9-4 —— 皆为讲解画面内容/流程的陈述句，未引用任一 UI 控件名，无对账对象。（其中 4-5「The submit button stays with you」泛指"提交按钮"概念、非引号控件名，归此类。）

## 结论
全部镜通过：两处引号标签逐字一致（已修），动作描述与画面动作一致，陈述镜不涉对账。**item-4 ✅**。

> 遗留（RU/FR 录制时清）：
> - 1-1 RU/FR 真控件存在（`Новое агентство? Регистрация →` / `Nouvelle agence ? Inscription →`），captions-v1.json 已同步改为逐字引用。
> - 3-1 的 `partner.students.addBtn` **仅 EN/ZH 两键**，RU/FR 无键→产品回退渲染（大概率回退 EN 字面「Submit New Student Referral」）。RU/FR 录制时须抽帧确认真实渲染文字，再定 RU/FR 3-1 引号内容（captions-v1.json 现 RU/FR 3-1 暂留意译，录制时 item-4 复核时改）。
