PUSH_OK=yes

# SUMMARY-GS1 · 学校端 G 线第一轮「观看闸门」收官单

日期 2026-10-06 ｜ 无人值守会话 ｜ 本轮＝访问码闸门 + 每码设备数 + 私有桶服务端放流 + 动态水印 + 高校邮箱领码 + 后台管理页（挂 Cloudflare Access）。代码此前已上线，本次由 CC 自己把 Cloudflare 配好、线上真验 12 条全过、收官。

> 大白话总览：**学校端的视频页现在真的上锁了，而且锁是好用的**——没有码看不了、输对码能看、一个码最多 3 台设备、第 4 台被拦、码一停用视频立刻放不了、后台页必须先登录。全部在正式线上用真浏览器验过。唯一还差一步的是「用高校邮箱自助领码」要能自动发邮件，那一步卡在发信服务的域名还没验证（下面「给业主的事」有说）。

## 一 · 资源与绑定（都就绪 ✅）
- **KV 命名空间**（存访问码/事件的小仓库）：显示名 `worker-mh-guide-gate`，id `6e695240ccda4902b0383453bb0da6b0` → 已绑成 Pages 变量 `GATE_KV`。
- **R2 私有桶**（锁起来的视频仓库，无公开地址）：`maxhouse-media-private` → 已绑成 Pages 变量 `PRIVATE_MEDIA`。
- **密钥**（只看得到名字，看不到值）：`GATE_SECRET`（通行证签名）、`GATE_EDU_TEST_EMAILS`、`ACCESS_TEAM_DOMAIN`、`RESEND_API_KEY`、本次新加 `ACCESS_AUD_ADMIN`（后台登录门的受众标识）。
- **线上体检** `/guide/school/api/health` = `{kv:true, r2:true, secret:true, resend:true}` —— **四项全绿**。
- **后台登录门**：Cloudflare Access 应用 `guide-school-admin` 已就位，只许 `maxhouseapp@gmail.com` 和 `admin@maxhouses.net` 两个邮箱。

## 二 · 接口清单（本轮上线的后端能力）
公共接口（`/guide/school/api/`）：
- `POST redeem` {码, 设备}：核码发通行证；错码 404、停用/过期 410、设备满 429、成功 200 下发 Cookie。
- `GET me`：验通行证 + 码仍有效 → 返回标签/码尾/到期；否则 401。
- `POST edu-request` {邮箱}：`.edu.cn`（或例外邮箱）领码发信；未配/域名未验证 → 503 降级不崩。
- `GET health`：四项绑定/密钥是否就绪（不泄露任何值）。
- `GET/POST logout`：清通行证。
放流接口：`GET /guide/school/media/<key>`：验通行证 + 码仍 active + 设备在册 → 从私有桶放流，支持 Range（206），响应头 `private, no-store`；无证/码失效 403。
后台接口（`/guide/school/admin/api/`，前面挡 Access，无凭据一律 403/302）：`GET codes`、`POST codes`、`POST codes/<码>/disable`、`/enable`、`GET codes/<码>/events`。

## 三 · 线上 12 条真验结果（www 主机，真 Chrome / 真 curl，全过 ✅）
| # | 判据 | 结果 | 证据 |
|---|------|------|------|
| 1 | 无证直连视频 | ✅ 403 | 未带通行证取 `media/v0/test.mp4` → 403 |
| 2 | 错码提示 | ✅ 404 invalid | 乱码 redeem → `{"error":"invalid"}` |
| 3 | 对码过并出四条 ✓ | ✅ | 输 `MHS-GSAA-TEST` → 通过页 4 条中文 ✓（文案一字未改） |
| 4 | 刷新不再输码 + me | ✅ | 刷新后自动进通过页、输码框空；`me` 返回 200 |
| 5 | 2·3 台过、第 4 台拒 | ✅ | 同码 1/2/3 台 redeem→200，第 4 台→429 `device_limit` |
| 6 | 停用码后 media 拒 | ✅ | 停用后 1 秒内 media 由 200 变 403（要求 ≤5 分钟） |
| 7 | 拖进度条 Range | ✅ 206 | `bytes=0-1023` 与中段 seek 均 206，`Content-Range …/3540828` |
| 8 | 测试片段能播 | ✅ loadeddata | 播放器 `readyState=4`（loadeddata 触发） |
| 9 | 水印在 | ✅ | 文字「测试大学 A · ···TEST · 2026-10-06」，6 秒后由左上移到右上 |
| 10 | pages.dev 跳 www | ✅ 302 | `maxhouse-2qs.pages.dev/guide/school/` → 302 到 www 同路径 |
| 11 | 后台无凭据被挡 | ✅ 302 到 Access | `/guide/school/admin/` 与 `admin/api/codes` 均 302 到 `maxhouseapp.cloudflareaccess.com` 登录页 |
| 12 | 高校邮箱领码 | ✅（降级正确） | 密钥已配但发信域名 `maxhouses.net` 在 Resend **尚未验证** → 返回 503，页面显示「邮件发送正在配置中」；错后缀邮箱 → 400 `bad_email`；`.edu.cn` 格式被正确接受（卡在域名验证而非后缀）。未真正发出邮件、未建码。 |

截图在 `~/mh-jobs/shots/GS1/`：`01-gate-zh`（闸门页）、`02-pass-watermark`（通过页+水印）、`03-watermark-moved`（水印换位后）、`04-admin-access`（后台跳 Access 登录）、`05-mobile-390`（手机宽 390 不溢出）。截图内只有测试码数据（码已删），无真实 PII。

## 四 · Resend（发信）状态
- `RESEND_API_KEY` 已配（health `resend:true`）。
- **但发信域名 `maxhouses.net` 在 Resend 里还没验证**，所以自助领码暂时发不出邮件，系统按设计降级为「正在配置中，请联系 MAXHOUSE 领码」。要开通自助领码，需在 Resend 后台把 `maxhouses.net` 验证通过（加 DNS 记录）。

## 五 · 两件顺带核查的结论（GS1-00 查，摘录）
- **录取通知书有效期**：链路是通的。学校端上传弹窗有「学生决定截止日」(7/14/21/30 天) → 换算成到期时间点存入 `offer_decisions.letter_expires_at`（表里存的是到期时间点，没有「有效几天」列）→ 学生端 v411 读 `letter_expires_at` 做倒计时。
- **guide_sch2（第二所演示校）卡在邮箱验证门**：根因＝进站函数 `is_my_email_verified()` 只认「走过 app 发信+点链接」或「学生表 email_verified=true」两种；guide_sch2 是学校账号、当初在 Supabase 后台直接确认的邮箱，这两种都不满足，门一直关。一键解法（新增型、不删不改）：往 `email_verifications` 插一行把它标为已验证（SQL 见 JOB-GS1-00 回执第 45–50 行）。**本轮未动数据，留 GS-2 执行。**

## 六 · 给业主的三件事
1. **后台 Access 应用**：已建好并验证（`guide-school-admin`，只许你和 admin@maxhouses.net）。你要进后台管理页 `www.maxhouses.net/guide/school/admin/`，第一次会跳到 Cloudflare 登录，用 `maxhouseapp@gmail.com` 登录即可。
2. **手机上输码看一遍**：建议你用手机打开 `www.maxhouses.net/guide/school/`，等有正式访问码后输码，亲眼确认播放、水印、章节都正常（自动化已验过，但你亲测更踏实）。
3. **Resend 发信钥匙/域名**：钥匙已配，但要让「高校邮箱自助领码」能自动发信，还需在 Resend 后台**验证发信域名 `maxhouses.net`**（按 Resend 指引加几条 DNS 记录）。在这之前，领码入口会显示「正在配置中」，可改为人工发码。

## 七 · 遗留
- 高校邮箱自助领码待 Resend 域名验证后才能真正发信（当前降级为提示，不崩）。
- 正式视频成片是 GS-3/GS-4 的事；本轮用 26 秒测试片段把线上全链路（放流/Range/水印/设备数/停用）走通了。
- guide_sch2 邮箱门的修数据（插一行）留 GS-2。

## 八 · Cloudflare 自动配置（本次 CC 自己做了什么，不含任何令牌）
业主本轮改为授权 CC 自己操作 Cloudflare（依据 `jobs/JOB-GS1/RULING-20261006-cf.md`）。CC 用 `jobs/cf-api.sh`（令牌由脚本从 .env 读、CC 不读不打印不入回执）和 wrangler（令牌走环境变量，同 GS1-00）做了：
- **GET 账号列表** → 取账号 id（公开标识）。
- **GET Pages 项目 `maxhouse`** → 存底 `jobs/JOB-GS1/cf/project-before.json`；读到两条绑定（`GATE_KV`→`6e695240…`、`PRIVATE_MEDIA`→`maxhouse-media-private`）**已在配置里且与裁决书一字不差**。因接口不回读密钥值（都显示空），为避免一次改写误伤 `GATE_SECRET`（补不回来），**未再 PATCH**，只靠重新部署让已存在的绑定生效（符合只读优先、不做破坏性操作）。
- **GET Access 应用列表** → 发现同名同域名的 `guide-school-admin` **已存在**，策略 `admin-only`（allow，两邮箱）**与裁决书一致** → 复用、不重复建。
- **wrangler 写入 `ACCESS_AUD_ADMIN`**＝该应用的 aud（公开标识），stdin 喂入、不打印、单项新增不动其它密钥；写后核对 5 个密钥名全在。
- **空提交重部署**（主仓库 `0be8fc5..43e87b7`，推前后核对符合 P5） → health 由 `kv/r2=false` 变 `四项全 true`。
- **逐项线上核对**：health 全绿；后台无凭据 302 到 Access（`aud=8efe9190…`）。
- 边界：只做裁决书列的三件（两绑定、Access+aud），没碰其它任何 Cloudflare 设置、没用 DELETE 调用。测试码/事件/限频键线上造完**已全部删除**（KV 现为空）。

详细调用过程见回执 `JOB-GS1-03b.md`。
