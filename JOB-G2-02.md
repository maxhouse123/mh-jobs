# JOB-G2-02 回执 · 新手引导页 guide/student/index.html

**一句话结论：引导页做好了，一个干净的单文件网页，四种语言、13 章目录、点开即播、分享/下载/二维码齐全，本地 8 项自检全过。**

## 页面长什么样（本地截图已自看）
- 顶部紫条：**MAXHOUSE**（H 橙色）+ 右上角四语切换 **EN 中 РУ FR**。
- 大标题「MAXHOUSE Student Portal / How to use it」+ 一句话说明。
- 两个大按钮：「**3-min overview · 2 min 15 sec**」(橙) 和 「**Watch the full guide · 9 min 59 sec**」(紫)，点了在页顶播放速览/完整版。
- **章节目录 13 条**：每条有封面缩略图（懒加载）、章号章名、★重点/○辅助药丸、时长；点一条在它下面展开播放器，同一时间只播一个；`?...#c7` 这样的深链能直接打开并滚到第 7 章。
- **分享区**：WhatsApp、Telegram、复制链接、微信扫码（内联二维码，指向 www.maxhouses.net/guide/student）、系统原生分享（手机上有就显示）、下载整片（当前语言 full.mp4）。
- **页脚**：www.maxhouse**s**.net（s 橙色）、联系方式、二维码、「Based on student portal v411 · 2026-10 · build g2-2026-10-06」。

## 技术要点（对账用）
- **纯静态单文件 23.4 KB**（上限 60KB），零外部脚本、零外部样式、系统字体；不读数据库、不登录、无第三方统计；对外只请求 `media.maxhouses.net/guide/student/v1` 的视频/海报/og。
- 语言：`?lang=` → 记住(localStorage) → 浏览器语言 → 英文。章名/时长/界面文案四语全内联（数据取自 manifest）。
- `<head>`：viewport、theme-color #3F3494、og:title/description（随语言切换更新）、og:image 指 v1/og.png、og:url、twitter summary_large_image、preconnect media、hreflang×4(+x-default)。
- 仓库根 `_headers` 只新增一段 `/guide/student/* → Cache-Control: public, max-age=300`（不挂 Link），**其余各段逐字节未动**（git diff 仅此一处）。

## 本地无头验证（8 闸 ALL_PASS，file:// + 本地 http 两种）
1. HTML 体积 ≤ 60KB ✅（23.4KB）
2. 无外部脚本（`<script src>`=0）✅
3. 无外部样式（`<link stylesheet>`=0）✅
4. 四语切换无裸键 + 每条 UI 串匹配词典/manifest ✅
5. 目录 13 条与 manifest 一致 ✅
6. 390 宽无横向滚动 ✅
7. 分享链接格式正确（WhatsApp `wa.me/?text=` / Telegram `t.me/share/url?url=` / 下载 `…full.mp4` 带 download）✅
8. 二维码真解码回同一网址（node jsQR 解码 = https://www.maxhouses.net/guide/student）✅
   附加：#c7 深链真打开第 7 章并挂载播放器 ✅；本地 http 静态服务下渲染 13 章 + 中文切换 ✅。

## 一处请你定（小）
页脚联系邮箱我按任务书写了 **admin@maxhouses.net**；学生端 v411 里用的是 **Service@maxhouses.net**。两者取舍你定一句，我随时改（改一行即可）。

## 红线自查
不改五端任何文件；只新建 `guide/student/` 目录与两个 jobs 工具；本地验证只开 file:// 与本地 http，media 请求一律拦截（不碰生产、不连库）；qrcode/jsqr 本地装不入 git。

## 主代码仓库提交
`9f4738d JOB-G2-02 …`（index.html + 生成器 + 验证器 + _headers 一段）。主仓库 push 在 G2-03 闸全过后一并做。
