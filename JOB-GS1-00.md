# JOB-GS1-00 回执 · 探针 + 建两样云资源 + 写三个密钥 + 顺带查两件事

日期 2026-10-06 ｜ 无人值守会话 ｜ 全程只读为主，唯一「写」= 建两样授权的云资源 + 写三个 Pages 密钥。

## 做了什么（大白话）

### 1. 看懂了现有的 Pages 函数怎么写
现有只有一个 `functions/share/[[path]].js`（分享链接函数）。它的写法：用 `export async function onRequest(context)`，从 `context.request` 拿请求、`context.next` 拿下一步、`context.env` 拿环境变量，最后 `return new Response(...)`。GS1-01 的闸门函数照这个风格写。

### 2. 建了两样云资源（业主授权的那两样，别的没碰）
- **KV 命名空间**（存访问码和事件记录的小仓库）：名字 `worker-mh-guide-gate`，id `6e695240ccda4902b0383453bb0da6b0`。
- **私有桶**（锁起来的视频仓库）：名字 `maxhouse-media-private`，标准存储，**没开公开访问**。
- 建完各列了一遍清单，两样都在；老媒体桶 `maxhouse-media` 原样没动。

### 3. 写了三个 Pages 生产密钥（值都没外泄、没进仓库、没进日志）
- `GATE_SECRET`：现场随机生成的 48 位长串（给通行证签名用），只喂进了 Cloudflare，没显示出来。
- `GATE_EDU_TEST_EMAILS` = `maxhouseapp@gmail.com`（测试例外邮箱）。
- `ACCESS_TEAM_DOMAIN` = `maxhouseapp.cloudflareaccess.com`（后台登录门的域名）。
- 列了一遍密钥名字，三个都在（只看得到名字，看不到值）。`RESEND_API_KEY`（发信钥匙）留给业主自己写。

### 4. 写好了业主操作单
`jobs/JOB-GS1/BINDINGS.md`：一步步教业主在 Cloudflare 面板点三件事 —— 把 KV 绑成 `GATE_KV`、把私有桶绑成 `PRIVATE_MEDIA`、给后台页 `/guide/school/admin/` 挡一道 Access 登录门（只许 `maxhouseapp@gmail.com`）；外加可选的 Resend 发信钥匙怎么写。这三件只有业主能在面板点，CC 点不了。

## 5. 顺带查清的两件事（只读，没动任何数据）

### 甲 · 录取通知书「有效期」到底在哪
1. **学校端上传弹窗有没有有效期选项？—— 有。** 学校端 v245 第 60 行（v149 改动）：上传录取通知书的弹窗里有「学生决定截止日」单选组，四选一：7 / 14 / 21 / 30 天；更早的 v145（第 63–66 行）是「有效期至」日期框（默认今天 +90 天）。选完换算成一个到期时间点，随上传 RPC 的 `p_expires` 参数提交。JW202 那条不加有效期。
2. **`offer_decisions` 表有没有有效期的列？—— 有 `letter_expires_at`（一个时间点），没有 `letter_valid_days`。** 天数是在前端换算成到期时间点后存进 `letter_expires_at` 的（源码第 73、75–76 行说明；列在迁移 0001/0026/0034 里就有）。所以表里存的是「到期到哪天」，不是「有效几天」。
3. **学生端 v411 的倒计时 `whatsNext.letterDescDays` 读哪一列？—— 读 `letter_expires_at`。** 第 26220 行：拿 `letter_expires_at` 减当前时间、除以一天，算出「还剩几天」。第 22097、22348 行也都读这一列。

> 一句话：有效期这条链是通的——学校选天数 → 存成 `letter_expires_at` 到期时间点 → 学生端读这列倒计时。

### 乙 · guide_sch2（第二所演示校）为什么卡在学校端邮箱验证门
**根因找到了。** 学校端进站要过一道「邮箱验证门」，它调数据库函数 `is_my_email_verified()` 判断。这个函数只认两种「已验证」：
- (a) `email_verifications` 表里有这个用户、且那条记录的 `used_at` 有值（也就是真走过 app 自己的「发验证邮件 → 点邮件里的链接」流程）；或
- (b) 这个用户在 `students`（学生表）里、且 `email_verified = true`。

而 guide_sch2 是**学校账号，不是学生**，也从没走过 app 自己那套「发验证邮件 + 点链接」流程（它当初是在 Supabase 后台把邮箱直接确认了——数据库里查到 `auth_confirmed = 真`、元数据 `email_verified = true`，但**这俩函数根本不看**）。于是两条都不满足 → 函数返回「未验证」→ 门一直关着，登录后进不了仪表盘。

- 核销函数 `confirm_email_verification_v2(p_token)` 要的是：`email_verifications` 表里一条 token 匹配、`used_at` 为空、没过期的记录；核销时把它的 `used_at` 设为现在，并把 `students.email_verified` 设真。它也只服务「点邮件链接」这条路，对学校账号同样没用。

**一键解法（只写方案，本轮没动数据——留给 GS-2 执行）：**
往 `email_verifications` 表**新增一行**（这是「新增型」操作，不删不改旧数据），把 guide_sch2 标成已验证即可：

```sql
insert into email_verifications (user_id, email, used_at)
values ('4aeca4a0-6005-45a2-9464-72420d7f596d', 'maxhouseapp+guide-sch2@gmail.com', now());
```

（`email_verifications` 的列是 token / user_id / email / created_at / expires_at / used_at，token 和时间都有默认值，只要填 user_id、email、used_at 三样。）插这一行后 `is_my_email_verified()` 的第 (a) 条就满足，门就开了。
另一条路（不改数据库）：以 guide_sch2 真登录 → 门弹出时点「发送验证邮件」→ 去邮箱点链接；但那要能收那个邮箱的信，没插一行省事。

## 闸判据对账
- ① 两资源 list 可见：✅ KV `worker-mh-guide-gate`(…da6b0) + R2 `maxhouse-media-private` 都列到了。
- ② secret list 有三个名字：✅ `GATE_SECRET` / `GATE_EDU_TEST_EMAILS` / `ACCESS_TEAM_DOMAIN`。
- ③ BINDINGS.md 写好：✅ `jobs/JOB-GS1/BINDINGS.md`。
- ④ 两件事各有结论并指到行号/列名：✅ 见上「甲」「乙」。

## 边界遵守
只建了 §0.1 授权的两样；没改任何 Pages/Access 设置（绑定留业主点）；没动任何数据库数据（两个探针都是 begin…rollback 只读）。

下一步：GS1-01 写闸门函数 + 本地仿真自测。
