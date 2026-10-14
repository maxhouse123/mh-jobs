> 本趟待推提交：**7de43e7**（git log origin/main..HEAD 应只此一笔）。

# 请示单 · 引导页线上有阻断缺陷（十章不加载），CORS 修复已备好并本机实证，请审核后由业主卡推送

**停下原因**：RULING-20261012-gp1 §2.6 第④种——修复要推主仓库才能上线（本线不推）。

## 一、卡在哪（一句话）
线上 `https://www.maxhouses.net/guide/partner/` **打开后十章永远加载不出、停在「Could not load」**——因为页面用跨源 `fetch()` 去 `media.maxhouses.net` 取章节清单（manifest.json），而那个域名**不发 CORS 允许头**，浏览器把清单请求挡了。没有清单，整个目录、点章、速览、整片全失效。
（页面外壳、邀请码、分享图、robots 都正常——只有"从 R2 读清单 JSON"这一步被挡。视频本身没问题。）

## 二、为什么之前没发现
- 本地闸和业主卡都"擦肩而过"：本地闸把清单当本机文件喂进去（绕过了 CORS）；业主卡只 `curl HEAD` 看 200，HEAD 不触发 CORS，也没用浏览器真打开看十章。
- 线上**学生页没这毛病**，因为它不跨源 fetch 清单——章节数据直接写死在页面里、视频当 `<video>` 元素加载（元素加载跨源不需要 CORS）。伙伴页是新写的"运行时取清单"结构，才第一次踩到这个坑。
- 证据：`~/mh-jobs/shots/GP2/online/gp2-04-BROKEN-en.png` / `-zh.png`（线上截图，满屏"Could not load"）；控制台原文见回执 `~/mh-jobs/JOB-GP2-04.md` 第一节。

## 三、我已经备好的修法（推荐 · Option 2：同源清单，不碰任何基建）
把 4 语共 8 个清单文件（manifest.json + lite-manifest.json，合计 64KB）**放进页面同目录** `guide/partner/m/<lang>/`，由 Cloudflare Pages **同源**提供；页面取清单从跨源 `media.maxhouses.net/...` 改成同源 `m/<lang>/...`（改一行）。清单里的视频地址仍指向 R2，视频照旧从 R2 加载（视频是元素、不需要 CORS）。版本串 `gp2-20261014`→`gp2-20261014b`。
- **不动** R2、不动 Cloudflare、不重传任何视频、不动 _headers。只改页面一行 + 新增 8 个小 JSON。
- **本机已 E2E 实证修好**（这次用真模式，不再只跑假 stub）：
  - 本地闸 8 场景 × 14 项仍全过。
  - 新增真验：`wrangler pages dev` 本机起站（同源提供清单）+ **真实 R2 视频经代理加载**：四语各加载 10 章、真 R2 视频首帧 0.9~1.4 秒、**CORS 错误 0**。全过 ✅。

### 请业主卡做（Option 2）——四段式推送
推前先 `export` 代理（v2rayN TUIC，mixed port 10808），然后：
1. `cd /Volumes/Dev/MAXHOUSE && git log origin/main..HEAD --oneline`（应看到本趟这 1 笔 `JOB-GP2-04 ...`，过目）
2. `git push origin main`
3. `git log origin/main..HEAD --oneline`（**应空输出**）
4. `git fetch && git diff origin/main --stat`（**应空**）+ `git status`（clean）
5. 等 Pages 部署（≤10 分钟），然后验收（下一节）。
6. 装 `jobs/JOB-GP2/RULING-<日期>-gp2-04-fix-live.md`（或你习惯的命名），重启循环——我下趟会续做 GP2-04 线上真验（应全绿）+ 测速 → GP2-05 收官。

### 推送后怎么验（线上）
- 浏览器打开 `https://www.maxhouses.net/guide/partner/?lang=en`（zh/ru/fr 各一遍），**十章目录应出现、点任一章 2~3 秒内出画面、速览/整片能播**。
- 查版本串：页面源码里 `BUILD` 应是 `gp2-20261014b`（旧的是 `gp2-20261014`，用来确认新版已上）。
- 控制台（F12）应**无 CORS / ERR_FAILED** 报错。
- 若还看旧版：等部署，或 `?v=` 换个数强刷。

### 万一不对怎么退
`git revert <本笔hash>` 或 `git reset --hard 1c1adfd` 回到当前线上版本（页面会退回"十章不加载"的现状，不会更坏）。清单是新增文件，删掉即回退。

## 四、备选（Option 1：给 R2 桶加 CORS）——我没选，供你定夺
给公开桶 `maxhouse-media` 加一条 CORS 规则（允许 `https://www.maxhouses.net` GET），页面一行都不用改、现有线上版立刻就能用。
- 我没走这条：它要动 Cloudflare/R2（本线红线不碰）、影响整个媒体桶（blast radius）、且本机无法自验。
- 若你更想走这条：告诉我，我把具体的桶 CORS 配置和改前改后比对法写成业主卡；但同源清单（Option 2）更自包含、风险更小、合仓库"同源优先"的一贯做法，**我推荐 Option 2**。

## 五、顺带两张 GP2-06 业主卡（都不急、本轮不对外前做都行）
1. **缓存规则**（RULING-20261014d 第1条已核）：`jobs/JOB-GP2/cf/apply-cache-rule.sh`（幂等、只增不改不删、`--dry-run` 纯 GET）给 `/guide/partner` 加 `guide-partner-html-cache`（克隆线上真正生效的 `guide-student-html-cache`，边缘真缓存）。我已 `--dry-run` 跑过（规则未存在、ruleset 解析正常）。真加由你去掉 `--dry-run` 跑。**不是上线前提**，HTML 走 `?v=` 运行时取，留 GP2-06 一并处理。
2. **G-9 收尾**：`jobs/JOB-G9/cleanup-apply.sh` 原用 `mapfile`（需 bash4），macOS 自带 bash 3.2 跑不了，前两趟因此跳过。我已把它改成 bash 3.2 兼容（`read` 循环读数组），`/bin/bash --dry-run` 自证 `GUARD_OK delete=34 (pub=28 priv=6)`、未执行删除。这个改动**留在工作区没提交**（它不在 GP2 提交白名单内）。你的 G-9 收尾卡可以直接用它：`git add jobs/JOB-G9/cleanup-apply.sh` 单独提交后，dry-run 确认 GUARD_OK 再 `--apply`。

## 六、本趟其它（都只读、未碰线上）
- 裸地址 `/jobs/QUEUE-G8.md` 实测仍 `HTTP/2 404 x-mh-block:1`，挡法有效。
- 回执 `~/mh-jobs/JOB-GP2-04.md`；决定账 D-GP2-6-1~6-4。
- 本趟主仓库攒 1 笔（未推），只含 `guide/partner/**` 与 `jobs/JOB-GP2/**`。
