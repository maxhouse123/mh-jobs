PUSH_OK=yes

# SUMMARY-G2 · G 线第二轮收官（大白话）

**结论：第 7、12 章两处毛病修好、四语成片全传上 R2、新手引导页做好并已上线，手机四语实测全部达标。链接可以发了。**

> PUSH_OK=yes 含义：主代码仓库已由我 `git push origin main`（只推了 JOB-G2-00/01/02 三笔，推后核对干净）、Cloudflare Pages 已部署出新页、线上四语真机验过。

## 线上地址
**https://www.maxhouses.net/guide/student/**（页脚构建串 `build g2-2026-10-06`，轮询第 3 次即 200 且含该串，确认已部署。）

## 四包都做了什么
- **G2-00**：第 7 章 7-5/7-6 真打开录取通知书查看器（通知书 + JW202 浮到屏幕最上层并高亮），第 12 章 Amal 学校备注改成自然英文。四语重录重合成，七格式闸全过，演示数据还原 R9 ALL_PASS。（回执 JOB-G2-00.md）
- **G2-01**：新建 `jobs/r2-put.sh` 上传工具（自己读 .env、只准写 guide/、拒删、自检），把四语成片全量 **123 个对象 271.4 MB** 传上 R2，随机抽验全 206、类型与缓存头正确。（回执 JOB-G2-01.md）
- **G2-02**：做成纯静态单文件引导页 `guide/student/index.html`（23.4 KB），四语、13 章目录、点开即播、分享/下载/二维码齐全，本地 8 闸全过。（回执 JOB-G2-02.md）
- **G2-03**：推送上线 + 线上四语真机验（本篇）。

## 线上真机实测（系统 Chrome + 代理 + CDP 4G 限速：下行 4 Mbps / RTT 150ms，手机 390×844 与桌面 1280 各一遍、四语各一遍）
| 指标 | 判据 | 实测 | 结论 |
|---|---|---|---|
| 首屏 DOMContentLoaded | ≤ 1.5 s | 手机 en 1.40s / zh 0.93s / ru 0.93s / fr 0.98s；桌面 en 1.03s / zh 1.00s / ru 0.92s / fr 1.11s | ✅ 全达标 |
| HTML 传输 | ≤ 60 KB | ~9.0 KB（CF 压缩后；源文件 23.4 KB）四语四宽一致 | ✅ |
| 点第 1 章 loadeddata | ≤ 2.5 s | 手机 en 1.46s | ✅ |
| 海报各 | ≤ 40 KB | 13 张 19–39 KB（最大 c11=39KB） | ✅ |
| `#c7` 深链 | 打开第 7 章 | open=true，源 …/en/c07.mp4 | ✅ |
| 四语切换 | 文案随语言 | EN/中/РУ/FR 分享文案、下载链接随语言正确 | ✅ |
| 分享链接 | 格式正确 | WhatsApp `wa.me/?text=`、Telegram `t.me/share/url?url=`、下载 `…full.mp4` 带 download | ✅ |
| 下载整片响应头 | download 生效 | `download` 属性在；full.mp4 返 200 + `accept-ranges: bytes` | ✅ |
| og 标签 | 齐全 | og:title/description/url、og:image=…/v1/og.png、twitter summary_large_image、theme-color #3F3494、preconnect media、hreflang×5(含 x-default) | ✅ |
| media mp4 | Accept-Ranges | c01.mp4 / full.mp4 / c12.mp4 均 `accept-ranges: bytes` | ✅ |

## 四语体积表（R2 上的成片）
| 语言 | 整片 full | 速览 quick | 该语目录合计 |
|---|---|---|---|
| en | 599s / 27.9MB | 135s / 6.3MB | 70 MB |
| zh | 736s / 29.3MB | 176s / 6.7MB | 75 MB |
| ru | 711s / 32.1MB | 175s / 7.2MB | 80 MB |
| fr | 702s / 32.0MB | 170s / 6.9MB | 77 MB |
R2 清单：`guide/student/v1/` 共 **123 个对象 / 271.4 MB**（四语 × [13 章 + full + quick + cover + 13 海报] + manifest.json + og.png）。

## 截图（四语手机宽）
已推 `~/mh-jobs/shots/G2/`：每语两张 = 首屏 `guide-<lang>-390-home.png` + 打开第 7 章播放中 `guide-<lang>-390-c7play.png`（zh/ru/fr/en 共 8 张；c7 截图里视频真解码播放，字幕烧录可见）。

## 给你的两件肉眼事（请你亲手看一下）
1. **手机微信/WhatsApp 里打开链接** `https://www.maxhouses.net/guide/student`：看页面排版、四语切换、点开某章能播；再点「微信扫码」看二维码能被微信识别跳回本页。
2. **把链接发到一个群**（微信群或 WhatsApp 群）：看弹出的卡片预览——标题、说明、那张 og 大图是否正常（og 图 = media 上的 v1/og.png）。

## 遗留 / 待办
1. **页脚联系邮箱**：我按任务书写了 `admin@maxhouses.net`；学生端 v411 实际用的是 `Service@maxhouses.net`。你定一句用哪个，改一行即可（`jobs/build-guide-page.mjs` 的 EMAIL 常量后重跑生成+重传 HTML 即可，或直接改 index.html）。
2. **第 10 章手机排版**：补充信息表组件在手机宽度下排版仍坏（G1b 既有遗留），组件修好后需重录第 10 章四语再重传。本轮未动第 10 章。
3. **成片更新流程**：以后任何章重录 → `assemble` 重合成 → `manifest` → `bash jobs/r2-put.sh guide/dist guide/student/v1` 覆盖重传（版本路径不变则浏览器仍吃旧缓存；如需强制刷新，换 v2 前缀并改页面 MEDIA 常量）。

## 红线自查
只碰演示账号与两所演示校、真实用户一行没碰；付款只 ¥0 或停付款凭证；R2 只往 guide/ 写、未删任何已有对象（只删了自建测试探针）；不读 .env、不打印密钥；主仓库只推 JOB-G2 三笔（推前逐条核对、推后 origin/main..HEAD 为空、diff 干净）；成片不入任何仓库；只演示数据截图进公开 shots/G2/；未改五端代码、未建迁移、未碰 Cloudflare 后台（部署靠推送触发）。
