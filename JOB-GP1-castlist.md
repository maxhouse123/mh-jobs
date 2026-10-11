# GP1-01 演员表（castlist）· Demo Agency 名下十名被荐生 + 注册演示号

生成于 2026-10-11（Mac mini 无人值守）。全部 **is_test**，挂在 **Demo Agency**（guide_partner，Pakistan）名下。
本表**不含邮箱全名与密码**（密码只在 ~/mh-verify/accounts.json，键名 guide_pt04 / guide_ptReg）。
演员角色键 `pt-NN` 稳定；`display_code（STU-xxxxxx）`每次 rebuild 重随机（本列为本次构建值，仅供核对）。

## 一、十名被荐生（pt-01 为云草稿，不占名额；pt-02～10 为 9 名在库学生）

| 角色 | 国籍 | 性别 | 姓名（虚构） | 年龄 | 专业 | 状态（stage） | 对应章 | 备注 |
|---|---|---|---|---|---|---|---|---|
| pt-01 | 巴基斯坦 | 女 | Ayesha Malik | — | Computer Science | **草稿**（referral_drafts，向导第二步） | 第3章 | 不是 students 行、不占名额；录制时从草稿接着填到提交 |
| pt-02 | 尼日利亚 | 男 | Emeka Okoye | 24 | Computer Science | 审核中 in_review | 第2章 | 已提交、材料未出结论 |
| pt-03 | 孟加拉 | 男 | Rahim Islam | 23 | Software Engineering | 材料待修正（成绩单退回） | 第5章 | 成绩单 review_verdicts=rejected，英文理由；余三样通过 |
| pt-04 | 哈萨克斯坦 | 女 | Aizhan Serikova | 23 | Finance | 委托邀请·已注册·材料 3/6 | 第4章 | **有真 auth 账号**（students.id=auth uid）；named_invites=claimed；待中介提交 |
| pt-05 | 喀麦隆 | 男 | Junior Mbarga | 25 | Civil Engineering | 可发录取 offerable | 第2章 | 四样双审通过、在 ADM-100005 候选池 |
| pt-06 | 巴基斯坦 | 男 | Bilal Hussain | 24 | Computer Science | 在途录取（2 份盲 offer） | 第6章 | Demo University 奖学金(ADM-100005) + Demo University 2 自费(ADM-100036)，均盲态待解锁 |
| pt-07 | 乌兹别克斯坦 | 女 | Nilufar Karimova | 23 | Business Administration | 已解锁(¥0)·已接受·待通知书 | 第7章 | MAXHOUSE 优惠码 ¥0 付款单在；录制时 st-pt07-letter.sql 传通知书 SPECIMEN |
| pt-08 | 加纳 | 女 | Abena Mensah | 24 | International Trade | 已付款·通知书已发·待 JW202·建档已录入 | 第7章 | filing=submitted（已录入学校系统 gz17）；录制时 st-pt08-jw202.sql 传 JW202 |
| pt-09 | 俄罗斯 | 男 | Dmitri Volkov | 26 | Mechanical Engineering | 已入学 enrolled | 第2/7/10章 | 通知书+JW202 已发、filing=approved、enrolled/completed |
| pt-10 | 塞内加尔 | 女 | Fatou Diop | 23 | Data Science and Big Data | 已提交（可发录取） | 第9章 | 增值服务入口可见 |

头像：九名在库学生各装 1 张 AI 虚拟脸（脸库 jobs/JOB-G6，按国籍×性别配组 G-6b 规则）：
C-非洲(pt-02/05/08/10) / A-南亚(pt-03/06) / F-欧洲中亚(pt-04/07/09)；九张互不相同；存桶 `<uuid>/photo/gp1-face-<code>.jpg`。

## 二、注册演示号

| 角色 | 机构名 | 国家 | 状态 | 用途 |
|---|---|---|---|---|
| reg | Demo Agency Reg | Pakistan | pending（审核中） | **有真 auth 账号**（partners.id=auth uid）；只用于第1章「从零注册 / 审核中」画面；录完由 reset-pt.sh 删除。资质样件 2 份（demo-agency-licence.pdf / demo-officer-passport.jpg，kind=proof/passport） |

## 三、Demo Agency 名额与申请

- 名额 **10**，已用 **9**（pt-01 草稿不占；pt-02～10 共 9 名在库学生占席）。
- 提额申请一条：请求 **30**（+20），状态 **pending（待审）**；ch8-4 录制时 `st-quota-approve.sql` 批准 → 名额 30。
- 通知 ≥4（offer 发出触发 + 手工：材料退回 gp1-note-pt03；提额已批 gp1-note-quota 在批准脚本里）。

## 四、演示校（只用 Demo University 系列）

| 校 | schools.id | 账号 uid | 建档 |
|---|---|---|---|
| Demo University | 7584a295-…（SCH-1AD6C8） | db568ff7-… | filing_system=gz17 / before_letter |
| Demo University 2 | 72969fa6-…（SCH-8E561C） | 4aeca4a0-… | filing_system=none（自费 offer，不建档） |

## 五、复位 / 重建

- `jobs/JOB-GP1/rebuild-partner.sh`：清0 → build-core → auth(pt-04+reg) → 脸 → 自检（16 断言全过）。两遍关键计数一致。
- `jobs/JOB-GP1/states/reset-pt.sh`：业务行 cleanup + 删 pt-04/reg 两个 auth.users（清回 0 学生）。
- 录制态脚本：`st-pt07-letter.sql` / `st-pt08-jw202.sql` / `st-quota-approve.sql`。
