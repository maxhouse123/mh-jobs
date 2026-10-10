# JOB-G7b-02 · 传桶 + 改页面（等业主替推，下一趟线上真验）

日期 2026-10-10。本机 Mac mini，代理已挂。本趟没碰五个产品端口 HTML、没碰数据库、没动桶里任何旧对象、CC 没推主仓库。

## 这趟干了啥（大白话）
G7b-01 把学生端第 12 章第 12-10 这一镜（中介替被荐生 Nour 付解锁费、输 MAXHOUSE 优惠码到 0 元）重录好、拼好、过了闸，成片只在本机。
本趟把变了的四语成片传上网，并改了视频引导页，让它去放新片。做完只提交、没推，等业主在原生终端替推。

## 上线前先亲眼看了证据图（符合业主裁决）
打开本机 `shots/G7b/student/12-10-en-zero-highlight.jpg` 肉眼确认，完全是业主要的样子：
- 画面是那张付款单「Intermediary Service Fee」（不是旧版填错的统计卡）。
- 大字 **¥0.00**，橙色高亮框**正框住大字 ¥0 本身**（不是框下面小字）。
- ¥0 下面那行：`¥3,000.00 · MAXHOUSE −¥3,000.00`。
- 申请人 nour.demo@example.com、付款人 agent.demo@example.com——都是演示邮箱，无 gmail、无名单外真学生。

## 传了哪些（只传变了的，旧对象一个没动）
只有两样内容变了：**c12 这一章**（含重录的 12-10）和 **full 整片**（里面含 c12）。
**quick 速览没变**（它的镜单 QUICK_SHOTS 最远只到 11-1，根本不含第 12 章任何镜），所以 quick 不重传、页面仍指旧的 `quick-g7`。
海报/小图也没变（章封面取自该章开头，不是 12-10），仍指旧的 `posters/c12-g7`。

传到公开桶 `maxhouse-media` 的 `guide/student/v2/<语言>/`，一律 `-g7b` 新名，走 wrangler，逐个传完当场公开域名核验：

| 对象 | 大小 | 核验 |
|---|---|---|
| en/c12-g7b.mp4 | 4022KB | http=206 ct=video/mp4 字节一致 OK |
| zh/c12-g7b.mp4 | 3833KB | 206 OK |
| ru/c12-g7b.mp4 | 4172KB | 206 OK |
| fr/c12-g7b.mp4 | 4312KB | 206 OK |
| en/full-g7b.mp4 | 29475KB | 206 OK |
| zh/full-g7b.mp4 | 31493KB | 206 OK |
| ru/full-g7b.mp4 | 32864KB | 206 OK |
| fr/full-g7b.mp4 | 33252KB | 206 OK |

8 个新对象全部 `1/1 OK`（脚本每传一个都用公开域名 Range 请求回读，核对总字节 = 本地大小）。现有对象零覆盖、零删除。

## 改了页面哪几处（`guide/student/index.html`，一个文件）
1. 第 12 章视频：`c12-g7` → **`c12-g7b`**（四语 OVERRIDE 都改）。
2. 整片：`full-g7` → **`full-g7b`**（四语都改）。
3. 第 12 章时长：en 63→**65**、zh 81→**82**、ru 88→**90**、fr 83→**85**（按新片 ffprobe 四舍五入，和页面原有取整规则一致）。
4. 整片总时长：en 550→**552**、zh 716→**718**、ru 685→**687**、fr 658→**660**。
5. 构建串：`g7-2026-10-10` → **`g7b-2026-10-10`**。
6. 海报 `posters/c12-g7`、速览 `quick-g7` **一字未动**（内容没变）。

## 页面自检（都过）
- 计数：`g7b-2026-10-10`=1、`c12-g7b`=4、`full-g7b`=4、`quick-g7`=4(不变)、`posters/c12-g7`=4(不变)；旧名 `"c12-g7"`/`"full-g7"`/旧构建串残留均=0。
- 无外部 js/css（grep 只命中 media.maxhouses.net 媒体域，零第三方脚本样式）。
- 文件 31.8 KB（32543 字节）≤ 60 KB。
- 用 node 把内联的 D 数据对象 JSON.parse 跑通，四语 ch12 都指 c12-g7b、full 都指 full-g7b、海报/quick 不变——解析 OK。

## 提交情况（只 commit，CC 未推）
- 本趟主仓库只改并提交一个文件：`guide/student/index.html`，提交信息 `JOB-G7b-02(...)` 开头。
- `git --no-pager log origin/main..HEAD --format=%s` 共 4 笔，**全部 JOB-G7b 开头**（G7b-00 两笔 + 01 + 02）。
- 已写 `jobs/JOB-G7b/NEED_PUSH.txt`（一行原因，给业主推送循环看；此文件是本机信号文件，不进主仓库，历轮 PUSHED-*.txt 同理）。

## 还差什么 / 下一步
**等业主在原生终端挂代理 `git push origin main`**（推完循环会把 NEED_PUSH.txt 改名成 `jobs/JOB-G7b/PUSHED-<时间>.txt`）。
下一趟开工：
1. 看到 `PUSHED-*.txt` → 前台轮询线上构建串 `g7b-2026-10-10`（每 60 秒一次、最多 20 分钟，curl 带浏览器 UA 或用 Playwright）。
2. 出现新构建串后做四语线上真验：c12-g7b/full-g7b 全 206、quick-g7 仍在、页面时长与新片一致、从线上 c12-g7b 抽 12-10 帧确认付款单 ¥0 + MAXHOUSE 码可见 + 橙框对准 ¥0、无 gmail、片尾解码 = maxhouses.net。
3. 写 `SUMMARY-G7b.md`（首行 PUSH_OK）+ 按裁决书写「勘误」并追加到 `SUMMARY-G7.md` 末尾。

## 守规矩情况
- 只改一个页面文件；没碰五端 HTML、数据库、桶里旧对象、缓存。
- 只往 `guide/` 前缀新增 `-g7b` 新对象，零覆盖零删除。
- 钥匙/令牌/自用码没碰、没进回执、没进截图。画面只有演示邮箱、无名单外真学生。
- CC 不推主仓库；本趟只 commit + 写 NEED_PUSH + 推本回执。
