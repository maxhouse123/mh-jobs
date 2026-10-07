PUSH_OK=yes

# SUMMARY-GS4 · 学校端 G 线第四轮：上线 收官

日期 2026-10-07 ｜ 无人值守会话（rGS34-loop）｜ 业主已定：只做中文，不做英文

## 一句话（大白话）
**学校端的教学视频真的上线了，而且锁好了。** 老师拿到访问码，手机或电脑打开 `www.maxhouses.net/guide/school/`，输码就能看：开头四条卖点 → 「整片 12:10 / 速览 2:56」两个大按钮 → 14 章带缩略图的目录，点开就播、播完出「下一章」、下次来还能「继续看第 N 章」。视频锁在私有仓库里、带动态水印、不能下载、没码看不了。线上 10 条真验全过。您自己的访问码已单独生成，只放在本机 `~/mh-verify/gs4-owner-code.txt`（没进任何回执/截图/仓库）。

## 线上地址与构建串
- 地址：https://www.maxhouses.net/guide/school/ （后台：/guide/school/admin/）
- 构建串：**gs4-20261007**（线上已核到，轮询第 3 次出现）
- pages.dev（maxhouse-2qs.pages.dev）访问 → 302 跳回 www ✅

## 成片清单（zh，已传私有桶 maxhouse-media-private 前缀 guide/school/v1/zh/）
- 14 章 c01～c14.mp4 + 开场 c00-intro.mp4 + 片尾 c99-ending.mp4
- 整片 full.mp4 **12:10**、速览 quick.mp4 **2:56**
- 海报 poster.jpg（1920×1080）+ 章节缩略图 thumb-c01～c14.jpg（480×270）
- 清单文件 guide/school/v1/manifest.json（语言 zh、14 章序号/中英标题/时长/文件/缩略图/简述、整片、速览、海报、构建串）
- 上传核对：33 个媒体对象 + 1 个 manifest 逐个回读字节数一致（full.mp4 单独回读 34,835,870=34,835,870 ✅）；不含任何公开桶路径。

## 线上 10 条真验（www 主机，真 curl + 真 Chrome，全过 ✅）
| # | 判据 | 结果 |
|---|------|------|
| 1 | 无证取 media（manifest） | ✅ 403 |
| 2 | 错码 redeem | ✅ 404 {"error":"invalid"} |
| 3 | 对码过 → 四条 ✓ + 14 章 + 两大按钮 | ✅ feats=4, chapters=14 |
| 4 | 第 1 章 loadeddata | ✅ readyState=4 |
| 5 | 整片 Range seek（带证） | ✅ 206 |
| 6 | 速览能播 | ✅ loadeddata readyState=4 |
| 7 | 水印在且 6 秒后换位 | ✅ 「标签·码尾·日期」且位置变 |
| 8 | 刷新不再输码 | ✅ 仍在目录页 |
| 9 | 第 4 台设备 | ✅ 429 device_limit（max 3） |
| 10 | pages.dev → www | ✅ 302 |
| + | admin 无凭据 | ✅ 302 到 Cloudflare Access 登录 |
- 截图（码号已打码）推 `shots/GS4/`：gs4-01-gate（闸门页）、gs4-02-catalog（目录页）、gs4-03-playing-watermark（播放中带水印）、gs4-04-mobile390（手机宽 390）；均 zh、390/430 宽不溢出、页面零外链无私有桶直链、无 JS 报错。

## 清尾清单（§0.4）
**已清（私有桶，先列后删、删后复核）：**
- `guide/school/v0/test.mp4`（3,540,828b，GS-1 的 26 秒测试片）→ 已删 ✅
- `guide/school/v0/manifest.json`（138b，v0 测试清单）→ 已删 ✅

**未能清（需业主处理，无害）：**
- `offer-letters` / `school-onboarding-docs` 两桶里 GS-3 录制期的 SPECIMEN 演示样件。**原因**：本机 R2 的 S3 密钥只授权了公开桶 `maxhouse-media`，对这两个私有业务桶 403；wrangler 令牌虽能逐个删、但**无法列目录**，而这些样件在库里的引用已被 rebuild 清掉（school_documents / offer_decisions 里查不到 guide_sch/SPECIMEN 路径），**对象键无从枚举**，盲删会误伤库里现存真 offer 通知书（形如 `<offer_id>/letter.pdf`，不含 guide_sch/SPECIMEN，**不是清尾目标、绝不能碰**）。这些 SPECIMEN 样件带水印、无真实个人信息、upsert 覆盖占位极小，**留着无害**。建议：业主在 Cloudflare 后台按 `guide_sch`/`SPECIMEN` 过滤删除，或给一枚可列这两桶的 S3 密钥，CC 下轮一次清净。
- `guide/school/manifest.json`（私有桶根，138b，v0 旧清单）未删——不在 §0.4 列的 `guide/school/v0/` 范围内，按「其它对象一律不碰」保留；新页面读 v1/，不再引用它。

## 码管理说明（给业主）
- 后台页：https://www.maxhouses.net/guide/school/admin/ （先过 Cloudflare Access 登录门，仅许 `maxhouseapp@gmail.com` / `admin@maxhouses.net`）
- 新建码：后台「新建」填标签 + 设备数 + 有效期（天）；或用高校邮箱在 www 页「用 .edu.cn 领码」自助（发信待 Resend 域名验证，见遗留）。
- 停用码：后台点该码「停用」，≤ 5 分钟线上即放不了视频（含正在看的）。
- 设备数：每码默认 3 台，建码时可改；满了第 N+1 台被拦，可停用旧设备或换码。
- **业主自用码**：已造（标签「业主自用」·5 台·180 天·有效期至 2027-04-05），**只在本机 `~/mh-verify/gs4-owner-code.txt`**，不在任何回执/截图/仓库。

## 主仓库推送（PUSH_OK=yes）
- 页面提交 `79eaa71 JOB-GS4-01 学校端观看目录页`（guide/school/index.html + jobs/QUEUE-GS4.md，§0.7 范围）已推：`87c046e..79eaa71`，推后 origin/main..HEAD 为空、工作树干净。
- 闸门函数 functions/guide/school/** **未改**（本轮只改页面），GS-1 的 12 条闸不受影响、无需重跑。

## 遗留
- **Resend 发信域名**未验证 → 高校邮箱自助领码仍降级（页面提示联系平台领码），待业主在 Resend + DNS 加 TXT/CNAME 验证 maxhouses.net 发信域名。
- **英文版**不做（业主已定）；页面 EN 界面播同套中文片、章标英文名 +「中文配音」徽章，章节简述暂沿用中文（可后续补英文简述）。
- **两桶 SPECIMEN 清尾**见上「清尾清单·未能清」。
- **GS-5 可选**：Cloudflare 缓存规则（private 媒体不缓存已设 no-store，可加边缘规则细化）、720p 低流量版、admin 后台码管理 UI 打磨。
