# JOB-G2-03 回执 · 上线 + 线上真验

**一句话结论：主仓库已推、页面已部署、线上四语真机实测全部达标。详情与指标见 SUMMARY-G2.md。**

## 做了什么
1. **推送**：推前 `git log origin/main..HEAD` 逐条核对 = 恰好三笔 JOB-G2-00/01/02（无别的提交混入，符合例外 0.2）；`git push origin main`（`71020d7..9f4738d`）；推后 `git log origin/main..HEAD` 为空、`git diff origin/main --stat` 干净。
2. **部署确认**：轮询 `https://www.maxhouses.net/guide/student/`，第 3 次（约 50 秒）即返 200 且页脚含构建串 `build g2-2026-10-06` → Cloudflare Pages 已出新页。
3. **线上真验**（系统 Chrome + 代理 + CDP 4G 限速；手机 390 与桌面 1280 × 四语）：首屏 DCL、HTML 传输、第1章 loadeddata、海报大小、#c7 深链、四语切换、分享链接、下载头、og 标签、mp4 Accept-Ranges——**逐项达标，数字见 SUMMARY-G2 表**。
4. **截图**：四语手机宽首屏 + 打开第 7 章播放中，共 8 张 → `shots/G2/`。

## 闸判据（全过）
① 线上页面含构建标记 ✅　② 指标全部达标（无未达项）✅　③ 四语截图齐 ✅

## 红线自查
主仓库只推 JOB-G2 三笔；不碰 Cloudflare 后台（部署靠推送触发）；线上验证只读页面、不连库不登录；截图仅演示数据。
