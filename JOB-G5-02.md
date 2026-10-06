# JOB-G5-02 · 界面与代码修整（只修 G5-00 列出的问题）+ 三层自验

日期 2026-10-06 ｜ 包 G5-02 ｜ 页面：guide/student/index.html（构建串 g4→**g5-2026-10-06**）、_headers

> 说明：铁律11③要求把自验报告写进 docs/self-test-report-*.md，但本轮任务书 §0.4 明确限定"只碰 guide/student/index.html、_headers、jobs/JOB-G1、jobs/JOB-G2"，docs/ 不在授权内。为两全，**本 G5-02 回执即自验报告全文**（逐条路径×断言×结果×证据），不新建 docs/ 文件。

## 一句话结论
按 G5-00 清单把标"本轮修"的 10 条全修了：切语言网页描述会跟着变了、语言按钮加大到好点了、加了 iPhone 刘海/底栏安全区、视频加载失败/超时会提示"点此重试"、看完一章会冒出"下一章"、刷新后顶部会显示"继续看第 N 章"、微信/QQ 里加了防强制全屏属性、顶部放了一张 300×300 的 MAXHOUSE 标志图当微信分享缩略图。全部本地自验通过（无头走查 66/66 + 本地 8 闸 ALL_PASS），页面仍是单文件、零外部脚本样式，体积 30.8KB（< 60KB）。

## 改了哪些（对应 G5-00 问题号）
| G5-00 问题 | 改法 | 证据 |
|---|---|---|
| ②切语言描述不变 | setMeta() 增一行同步 `<meta name=description>`=该语言 ogDesc | 走查：四语 metaDesc==ogDesc 且本地化 ✅ |
| ③语言按钮太小 | `.langs button` 加 min-height:44px + inline-flex 居中（宽不变不挤 320） | 走查：四语两宽 langBtn 40×44 ✅ |
| ④无安全区 | header 加 `padding-top/left/right: env(safe-area-inset-*)`；.wrap 加 `padding-bottom/left/right: env(...)` | grep safe-area-inset ✅；截图 /tmp/g5-hero-en.png |
| ⑤视频失败无提示 | 新增 guardVideo()：error 或 play 后 8s 无首帧 → 显示"点此重试"(.vmsg)，点一下 v.load()+play() | 走查：dispatch error → 显示"Slow network — tap to retry" ✅ |
| ⑥无下一章 | guardVideo() 监听 ended → 冒"下一章 ▶"(.nextch)，点击 goChapter(n+1) 展开+滚动**不自动播**；末章无 | 走查：ended→按钮现→点击 c02 open ✅ |
| ⑦不记上次章 | saveLast() 存 localStorage『mh_guide_last』(try/catch)；renderResume() 顶部"继续看第 N 章"横幅，点击回到该章；有#深链或该章已开则不显 | 走查：存=2→重访横幅现→点击开章→横幅隐 ✅；截图 /tmp/g5-resume-zh.png |
| ⑧微信强制全屏 | 章视频 + 顶部播放器加 `webkit-playsinline`+`x5-playsinline`+`x5-video-player-type=h5-page` | 走查：topPlayer & 章视频 X5 属性在 ✅ |
| ⑨微信缩略图 | 顶部 hero 放 56px 显示的品牌图，文件 300×300（media/guide/student/v2/brand-300.png，已上线206），是页面第一张 ≥300×300 图 → 微信取它当缩略图 | 走查：heroLogo 是第一张 img、src=brand-300.png ✅；缩略图肉眼 /tmp/g5-hero-en.png |
| ⑩缓存头 | （G5-01 已改 _headers swr，本包不重复） | 见 JOB-G5-01 |
| 新串 | D.BUILD g4→g5-2026-10-06 | grep BUILD ✅ |

新增的 UI 元素（.resume/.nextch/.vmsg/.heroLogo）**全部复用本页既有设计变量**（--p/--o/--card/--line、既有圆角/药丸按钮风格），无自造新色；本页是独立引导页（非 admin/student/school/reviewer 四端），不受四端 UI 基线约束，属本页自身样式扩展。

## 三层自验

### ① UI 对照 / 零裸键 / 零死按钮
- **零裸 i18n 键**：新键 nextCh/retry/resume 各在 en/zh/ru/fr 四词典齐全（grep 各=4）；本地 8 闸「四语切换无裸键 + 每条 UI 串匹配词典」PASS。
- **零死按钮**：新按钮 resume▶ / nextch / vmsg(retry) 均有真 onclick → 已定义函数（goChapter/v.load），走查实际触发全部生效。
- **字段对照**：本页非表单端，无 PII 字段；新增均为导航/提示类，不涉脱敏。

### ② 无头走查（Playwright file://；media 仅渲染校验用，本地 8 闸则 abort media 纯本地）
脚本 jobs/JOB-G1/g5-walk.mjs，**66/66 PASS**。覆盖路径×断言：
- 四语 × (320/390 宽)：html-lang 对、标题本地化、metaDesc==本地化 ogDesc、语言按钮≥44px、无横向溢出、无 JS 错误 —— 48 条全绿。
- 行为（en 390）：heroLogo 第一张且 300-src/56 显示、顶部播放器 X5 属性、章视频 X5 属性 + vmsg 守卫元素、ended→下一章按钮现、点下一章开 c02、error→retry 提示现、开章存 last、重访横幅现、点横幅开章且横幅隐、#c7 深链开 c07、有#深链时横幅隐、切 ru 后 html-lang+metaDesc 同步、全程 0 JS 错误 —— 18 条全绿。
- **红线遵守**：只开 `file://`，不碰生产网址、不连库；localStorage 真读写（本地），无账号密码硬编码。

### ③ 本地 8 闸（canonical：jobs/verify-guide-page.mjs，abort media.maxhouses.net 纯本地）
**ALL_PASS（10/10）**：HTML≤60KB(30.8KB)、无外部脚本(0)、无外部样式(0)、四语无裸键、13章与manifest一致、390无横滚、分享链接格式对、二维码解回同址、#c7深链挂载c07、本地http服务渲染13章+中文切换。

## 代码检查（复核仍合格）
- 文件 31488 字节（30.8KB，< 60KB）✓；0 console/debugger/alert ✓；无重复 id ✓。
- localStorage 共 4 处（pickLang getItem / setLang setItem / saveLast setItem / renderResume getItem）**全在 try/catch** ✓。
- 事件无重复绑定（guardVideo 对 topPlayer 只 init 一次；章视频每次 render 重建新元素，vmsg/nextch 用 querySelector 防重复 append）✓。
- 脚本仍在 `</body>` 前、不阻塞首屏 ✓；零外部脚本样式 ✓。

## 待上线 / 下一步
- 本包主仓库改动 = guide/student/index.html + _headers（两文件），以「JOB-G5-02」提交并推主仓库（推前核对只 JOB-G5 提交）。
- 线上四语手机宽真验 + 两档限速重测 0.1 全部指标 → 放 G5-03（需页面先上线、轮询到 g5-2026-10-06 构建串后再测）。
