# JOB-GS1-03b 回执 · CC 自己配 Cloudflare（续跑）

日期 2026-10-06 ｜ 无人值守会话 ｜ 依据 `jobs/JOB-GS1/RULING-20261006-cf.md`（业主授权 CC 自己操作 Cloudflare）

> 说明：令牌全程只经 `jobs/cf-api.sh` 和 wrangler 的环境变量使用，没读 `.env`、没打印、没进这份回执。下面所有 ID 都是公开标识（账号号、命名空间号、Access 应用号、aud），不是密钥。

## 开场体检（续跑前的现状）
- 线上体检 `/guide/school/api/health` = `{kv:false, r2:false, secret:true, resend:false}`（和上一轮停工时一样）。
- 一查发现：**业主其实已经在面板把三件事都点好了**——两条绑定和 Access 登录门都在，只是「还没重新部署」，所以线上旧版还没吃到。

## 一 · Pages 两条绑定（GET → 核对）
- GET 读 Pages 项目 `maxhouse`，把生产环境配置整段存底 `jobs/JOB-GS1/cf/project-before.json`。
- 读到两条绑定**已经在配置里**，且和裁决书要的一字不差：
  - `GATE_KV` → 命名空间 `6e695240ccda4902b0383453bb0da6b0`
  - `PRIVATE_MEDIA` → 私有桶 `maxhouse-media-private`
- 兼容日期 `2026-06-02`、各密钥（GATE_SECRET 等）都在，没有缺失。
- **没有再去 PATCH（改写）配置**：因为目标已经达到，且 Cloudflare 的接口**不会把密钥的值读回来**（都显示空），万一一次改写把密钥值冲掉是补不回来的。既然绑定已经对了，只差「重新部署」让它生效，就不冒这个险。（符合「只读侦察先行、不做破坏性操作」。）

## 二 · Access 应用 guide-school-admin（复用已有）
- GET 查 Access 应用列表，发现**同名同域名的应用已经存在**（裁决书要求「有则复用、不重复建」）：
  - 名称 `guide-school-admin`，域名 `www.maxhouses.net/guide/school/admin`，类型 self_hosted。
- 查它的策略：`admin-only`，放行（allow），只许两个邮箱 `maxhouseapp@gmail.com` 和 `admin@maxhouses.net`——和裁决书要求一致，**无需改**。
- 该应用的 aud（受众标识，公开的）已取得。
- **把 aud 写进 Pages 的 `ACCESS_AUD_ADMIN`**：用 wrangler 的「加单个密钥」方式（stdin 喂入、不打印），只新增这一项、不动其它密钥。
  - 写完核对密钥清单（只看名字）：`ACCESS_AUD_ADMIN / ACCESS_TEAM_DOMAIN / GATE_EDU_TEST_EMAILS / GATE_SECRET / RESEND_API_KEY` 五个都在，没冲掉任何一个。
  - 这一步让后台函数开始校验 aud（闸门更严）。

## 三 · 接下来
- 推一个空提交触发重新部署 → 查体检 kv/r2/secret 全 true → 不带凭据访问后台页应 302 到 Access。
- 然后造测试码、跑线上 12 条真验、推截图、清测试码、写 `SUMMARY-GS1.md`。

## 四 · 重新部署 + 体检（✅ 全绿）
- 主仓库推一个空提交触发重新部署：`0be8fc5..43e87b7  main -> main`（推前核对待推只有这一个 `JOB-GS1` 提交，推后 `origin/main..HEAD` 为空、无夹带，符合 P5）。
- 约 30 秒后新部署上线，线上体检 `/guide/school/api/health` 变成：
  - `{"kv":true, "r2":true, "secret":true, "resend":true}` —— **四项全 true**。
  - 比停工时多绿了两项（kv/r2 绑定生效）外加 resend=true（RESEND_API_KEY 已有值，发信已开通）。
- 后台门核对：不带凭据访问 `https://www.maxhouses.net/guide/school/admin/` → **302 跳到 `maxhouseapp.cloudflareaccess.com` 登录页**，且 `kid`/`aud` = `8efe9190…`（正是本应用的 aud，闸门生效）；后台接口 `/guide/school/admin/api/codes` 不带凭据同样 302。

**小结**：裁决书列的三件事（两条绑定、Access 应用+aud）全部到位并线上验证通过。绑定与 Access 门其实业主此前已在面板点好，CC 这次补上了「把 aud 写进 ACCESS_AUD_ADMIN」+「重新部署让一切生效」两步，并逐项线上核对。没动其它任何 Cloudflare 设置、没用 DELETE。

（下一步进入 GS1-03 第 3～6 条，结果写在 `SUMMARY-GS1.md`。）
