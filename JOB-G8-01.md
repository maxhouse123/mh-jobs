# JOB-G8-01 · 边缘与连接层（零成片改动）

日期 2026-10-10　机器 Mac mini　本轮代号 G8-01

## 一句话（大白话）
不碰任何视频，只在 Cloudflare 的"门口"和页面的头里做提速。做完 4 件里的 3 件，1 件卡在令牌权限（已写明缺哪个权限、不停工）：
1. ✅ 新建了学生引导页 HTML 的边缘缓存规则 `guide-student-html-cache`，验证第 2 次访问直连+代理都 HIT（页面秒开）。
2. ✅ 媒体（media.maxhouses.net）本来就已经第 2 次 HIT，不用新建规则。
3. ⚠ 想开的四个 Zone 开关（http3 / 0rtt / early_hints / brotli）和分层缓存（tiered cache smart topology）——**令牌没有编辑权**，连读都读不到前四个；写明缺的权限名，没停工（§2.3 允许）。
4. ✅ 给 `_headers` 的 `/guide/student/*` 加了一行到 media.maxhouses.net 的 preconnect（跨源预连接，配合 Early Hints 降 TTFF），学校页媒体同源不加。

---

## 逐条做了什么（真命令输出）

### 1) 新建 Cache Rule `guide-student-html-cache` —— 成功，已验证
- 改前把整份缓存 ruleset GET 下来留底 → `jobs/JOB-G8/cf-rules-before.json`（3 条规则）。
- 用 `bash jobs/cf-api.sh POST /zones/<zone>/rulesets/<rs>/rules`（令牌有 Cache Rules 写权）追加一条**新规则到末尾**：
  - 名字：`guide-student-html-cache`
  - 表达式：`(http.host eq "www.maxhouses.net" and starts_with(http.request.uri.path, "/guide/student"))`
  - 动作：cache 可缓存 + edge TTL = respect_origin + browser TTL = respect_origin
  - 规则 id = `5db0f613729a4469b057109f757af1c5`
- **没碰已有的三条**（portal versioned html / guide-student-html / guide-html-cache 一字不动）。新规则排在最后，比旧的 `guide-student-html`（edge=bypass_by_default）更具体且靠后，于是学生页 HTML 明确变成边缘可缓存。
- 改后 ruleset 留底 → `jobs/JOB-G8/cf-rules-after.json`（现 4 条规则）。
- **验证**（curl 带浏览器 UA，直连清代理 env、代理走 127.0.0.1:10808，各 3 次）：
  - 直连 `https://www.maxhouses.net/guide/student/`：第1次 UPDATING（边缘已有副本、stale-while-revalidate 后台刷新中、仍从边缘秒回）→ 第2、3次 **HIT**。
  - 代理 同 URL：第1次 UPDATING → 第2、3次 **HIT**。
  - → §2.1 的闸"第 2 次 cf-cache-status=HIT（直连 + 代理）"**通过**。

### 2) 媒体缓存 —— 不用新建，已是 HIT
- 代理路 Range 探两个真对象（键取自线上页真实命名）：
  - `media.maxhouses.net/guide/student/v2/en/c01.mp4` → 第1、2次都 HIT。
  - `.../en/c07-g7.mp4` → 第1、2次都 HIT。
- media.maxhouses.net 是 R2 自定义域，默认就长缓存并命中。按 §2.2"已是 HIT 就不建"，**不新建 `guide-media-cache`**。

### 3) Zone 设置 + 分层缓存 —— 令牌权限不足，写明继续（§2.3）
- `tiered_cache_smart_topology_enable`：**读得到**（当前 value=`off`，editable 字段报 true），但 **PATCH 成 on 失败**（code 10000 Authentication error）→ 令牌能读 cache、不能改 tiered cache。
- `http3` / `0rtt` / `early_hints`：GET 直接 9109 Unauthorized（连当前值都读不到）。
- `brotli`：GET 10000 Authentication error。
- **缺的权限名（请业主在 Cloudflare 后台给令牌补，或手工在面板开启）**：
  - `Zone.Zone Settings:Read` + `Zone.Zone Settings:Edit` —— 读/改 http3、0-RTT、Early Hints、Brotli。
  - `Zone.Cache Settings:Edit`（分层缓存/Tiered Cache 编辑权）—— PATCH tiered cache smart topology。
- 留底：`jobs/JOB-G8/cf-settings-before.json` / `cf-settings-after.json`（after 写明本轮一个都没改成、全因无 Edit 权）。
- **建议业主手工在 CF 面板一键开启**（Speed→Optimization 开 HTTP/3、0-RTT、Early Hints；Caching→Tiered Cache 选 Smart Topology；Brotli 多半已默认开）——这几项对弱网首帧/首屏有肉眼可见帮助，且 Early Hints 正是第 4 条 preconnect 生效的前提。

### 4) `_headers` 加 preconnect —— 已改（仅一行）
- 在 `/guide/student/*` 块里加：`Link: <https://media.maxhouses.net>; rel=preconnect`
- 理由：学生引导页的视频在 **media.maxhouses.net（跨源）**，preconnect 让浏览器/CF Early Hints(103) 提前把到媒体域的连接建好，降第一帧前握手耗时。
- **只加这一行**，Cache-Control 那行不动；学校页媒体**同源**（走 /guide/school/media/）故不加（照 §2.4）。
- ⚠ 这是 preconnect（不是 preload/as），不会触发历史上 v5 修过的"preloaded but not used"告警；且页面必放 media 视频，连接必被用到。
- ⚠ 此改**要 push + Pages 部署后才线上生效**；按 §2.5 本包只 commit，随 cycle=1（G8-02 末）一起推。Early Hints 的 103 还需上面第 3 条的 `early_hints` 开关为 on——目前读不到其值，待业主确认/开启。

---

## 闸与证据
- 缓存规则验证输出：直连/代理第2次均 HIT（见上，命令带浏览器 UA）。
- CF 前后对照文件：`cf-rules-before.json`（3 条）→ `cf-rules-after.json`（4 条，新增 guide-student-html-cache）。
- 本包 CF 都是 API 侧活改动（非文件），已留 before/after JSON 备查；`_headers` 是唯一代码文件改动。

## 写入主仓库（仅 commit 不 push，`JOB-G8-01:` 开头）
- `_headers`（加 preconnect 一行 + 一行说明注释）
- `jobs/JOB-G8/cf-rules-before.json`、`cf-rules-after.json`、`cf-rule-new.json`、`cf-rule-add-result.json`、`cf-settings-before.json`、`cf-settings-after.json`、`cf-smart-topology-on.json`

## 还差什么 + 下一步
- **本包无「必须停」触发**：令牌缺权限按 §2.3「写出权限名继续」处理，不停工。
- **下一趟 = G8-02**（产品侧三件事）：付款单改名（§3.1 定稿四语）、三接口按 is_test 过滤（§3.2 出迁移）、第 10 章补充信息表排版（§3.3，开头先做 G8-00 留下的 ch10 live 确认，需业主登录态协助）。G8-02 末写 `NEED_PUSH.txt` cycle=1 并结束本趟（含本 G8-01 的 `_headers`）。
- **给业主的一句话**：引导页"门口缓存"已装好，第二次打开会更快；另有 4 个边缘开关因令牌没权限我开不了，建议你登 Cloudflare 面板手工开 HTTP/3、0-RTT、Early Hints、分层缓存（Smart Topology），对弱网首屏有帮助。

**钥匙安全**：CF 令牌只由 cf-api.sh 从 .env 取、从不打印；回执无任何密钥/密码/gmail。
