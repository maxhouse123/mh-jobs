# 引导页与上传已就绪，请 Claude 审核后由业主用卡上传、加缓存规则、推送（GP2-03 停点二）

趟：第 5 趟（2026-10-14）。GP2-03 做完＝本任务书写明的第二个停点。CC 到此停下，等业主卡装 `RULING-<日期>-gp2-03-live.md` 后循环重启、接 GP2-04。

## 一、CC 这趟做了什么（都在本机，未推主仓库、未传桶、未改 Cloudflare）
1. **引导页 `guide/partner/index.html`**（新文件，单文件 44.6KB ≤ 60KB，零第三方 `<script src>`）：
   - 四语 EN/中/РУ/FR（`?lang=` → localStorage → 浏览器语言 → 默认英文；切语言同步 html lang/title/description/og）；
   - **画幅自动**：手机(窄屏/触屏)默认竖、电脑默认横，右上角可切，记 localStorage（读写 try/catch）；
   - **四条橙✓**：英中照 storyboard §一 原文、俄法用 captions-v1.json keypoints（整句四语俱全，见 D-GP2-5-2）；
   - **播放**：速览(招募片)+整片两大按钮 + 十章目录(缩略图懒加载)；HD 走单 master、Lite 走分段双缓冲串播、弱网自动降档；下一章/续看照学生页；
   - **注册区**：一行「2 个工作日内审核」(与分镜 1-7 口播一致，四语) + **公开显示邀请码 `MAXHOUSE-PARTNER-2026`**(页面顶部常量，换码改一行) + 复制钮；「注册你的机构」按钮链 `/partner-portal/?src=guide-<lang>`。**发布前 db-run.sh 只读探针实证**：`partner_code = 'MAXHOUSE-PARTNER-2026'` 为真、`partner_enabled`、全局 `enabled` 皆真；
   - **分享**：WhatsApp/Telegram/复制链接/微信二维码(QR 编码页面 URL)；og:title/description/image 按语言(og:image = 同源 `/guide/partner/share-<lang>.jpg`)；顶部品牌图复用线上 `brand-300.png`(HEAD 实测 200)作微信缩略图；
   - **去下载**：所有 video 加 `controlsList=nodownload` + `disablePictureInPicture` + 禁右键；保留分享；
   - **先上线不对外**：head 有 `<meta name=robots content=noindex,nofollow>`；不挂首页、不发链接（对外＝GP2-06 去这一行）；
   - 页脚：`Service@maxhouses.net` + 构建串 `build gp2-20261014`；
   - 清单**运行时 fetch**：`{media}/guide/partner/v4/<lang>/manifest.json?v=<BUILD>` + `lite-manifest.json?v=<BUILD>`（换片＝重传成片+重出清单+改页面 BUILD 一行，见 D-GP2-5-1）。
2. **四语分享图**入页目录：`guide/partner/share-{en,zh,ru,fr}.jpg`（og:image 同源服务；jpg 不入桶，见 D-GP2-4-1）。
3. **`_headers` 新增 `/guide/partner/*` 段**（照 `/guide/student/*`：`max-age=300, stale-while-revalidate=86400` + 到 media 的 preconnect Link），**只 +5 行，上方一字未动**（git diff 已核）。
4. **缓存规则 JSON** `jobs/JOB-GP2/cf/guide-partner-html-cache-rule.json`（逐字段克隆线上 `guide-student-html`：`edge_ttl=bypass_by_default`、`browser_ttl=respect_origin`、`cache=true`，expression 换 `/guide/partner`）。CC 不执行。
5. **本地闸全过**：`jobs/JOB-GP2/gp2-03-gate.mjs`（playwright 全站 route 截流到本机成片，绝不碰生产）——四语 × 手机405/电脑1440 = 8 context × 14 项断言 **ALL PASS**（零裸键/四✓/十章/邀请码/noindex/og本语言/无横向溢出/可点区≥44px/画幅自动/开章出海报/播放首帧 82~164ms ≤2.5s/nodownload/切画幅/切语言）；lite 分段串播单测另过（速览段 550ms 出帧、seqNext 进段、零报错）。截图 8 张在 `~/mh-jobs/shots/GP2/local/gp2-03-<lang>-<view>.png`。

主仓库本趟提交 **`ffadae3`**（仅上列 1~5 的文件 + DECISIONS/tooling；点名提交，未碰别线）。

## 二、要业主的卡做什么（逐条）
**顺序：先上传 → 再加缓存规则 → 最后推页面。**

1. **上传成片到公开桶**（CC 已 --dry-run 实测 v4/ 空、528 对象 / 558.0 MB 全新）：
   ```
   cd /Volumes/Dev/MAXHOUSE && bash jobs/JOB-GP2/gp2-upload.sh
   ```
   期望：上传 528 个、总 558.0 MB；每个经 `media.maxhouses.net` 读回 HEAD 200 + 视频 Range 206 + 字节对上；可重复跑(已在且一致跳过)。

2. **加 CF 缓存规则**（用 `bash jobs/cf-api.sh`）：把 `jobs/JOB-GP2/cf/guide-partner-html-cache-rule.json` 作为**新增**规则入缓存 ruleset；**改前改后各 GET 一次 ruleset**，比对**原有规则逐字段不变**，只多出 `guide-partner-html` 一条。

3. **推页面**（四段式 P5）：
   - 要推的提交（共 **4 笔**，`git log origin/main..HEAD` 应列出）：`b0dfba9`(GP2-01 工装)、`b4d976d`(GP2-02 工装)、`ffadae3`(GP2-03 页面＝本趟)，外加本趟稍后那笔"装请示单"的小提交。
   - `ffadae3` 改的文件应只有：`guide/partner/index.html`、`guide/partner/share-{en,zh,ru,fr}.jpg`、`_headers`(+5行)、`jobs/JOB-GP2/*`(cf JSON/gate/qr/probe/DECISIONS/gitignore/package*)。
   - 临时工作区从 origin/main 起、挂代理 `git push origin main`；推后 `git log origin/main..HEAD` 空、`git status` clean、`git diff origin/main --stat` 空。

## 三、上线后怎么验（给 curl / 浏览器，逐条）
- 页面 200：`curl -sL -o /dev/null -w "%{http_code}\n" https://www.maxhouses.net/guide/partner/` → `200`。
- robots noindex 在：`curl -sL https://www.maxhouses.net/guide/partner/ | grep -i 'name="robots"'` → `content="noindex,nofollow"`。
- og 本语言：`curl -sL 'https://www.maxhouses.net/guide/partner/?lang=zh'`（页面 JS 渲染，用无头看）→ og:image 结尾 `/share-zh.jpg`；`curl -sI https://www.maxhouses.net/guide/partner/share-en.jpg` → 200 `image/jpeg`。
- 清单可取：`curl -sI https://media.maxhouses.net/guide/partner/v4/en/manifest.json` → 200；章视频 `.../v4/en/port/ch1.mp4` → HEAD 200、Range 206。
- 浏览器(手机+电脑)：四条✓在、十章目录、点章 2.5s 内出画面、速览分段串播接缝不卡、邀请码显示且可复制、注册按钮带 `?src=guide-<lang>`、无下载入口、无横向溢出、切语言/切画幅正常。
- 缓存：第 2 次访问页面 `cf-cache-status` 命中(HIT/REVALIDATED)。

## 四、万一不对怎么退
- 上传：`gp2-upload.sh` 只新增不删，重跑即补；要撤只删 `guide/partner/v4/**` 新对象(旧版本桶键 v1~v3 未动)。
- 缓存规则：加错 → 删掉 `guide-partner-html` 这一条即回原状(改前 GET 的 ruleset 为准)。
- 页面：`git revert ffadae3`(或从 origin 回退该四笔)即下线；页面带 `robots noindex`、未挂首页、未发链接，即便上线也不对外。

## 五、推完后
业主卡装 `jobs/JOB-GP2/RULING-<日期>-gp2-03-live.md`，重启循环；CC 接 GP2-04（线上真验 + 测速，只读）。
