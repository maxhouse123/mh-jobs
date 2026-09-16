# JOB-7-03b · 上传体验 · 断点续传（TUS，开关控制）— 回执

**结果：做完，学生端 v385、中介端 v153。本地 stub 走查 5/5 全过。真断网续传那一闸（要真账号+真后端）延后，见文末。一个重要偏差先说：库没走 cdnjs，改成自托管——理由在下面。**

## 大白话：解决了什么
真学生很多在移动网络差的地方，传到 60% 断网就得从头再来，这是最大的流失点。Supabase 支持 TUS「断点续传」协议：传一半断了，网一回来接着传，不用重选、不用从头。
- **大于 1MB 的文件走 TUS 续传**（6MB 一片、带自动重试），断网自动接上；**1MB 以内**仍走上一包（7-03a）的直传，够快没必要上续传。
- **总开关** `mh_upload_tus`（存在浏览器里，**默认开**）。万一 TUS 在某些网络下出问题，你在设置里一键关，立刻回到 7-03a 老路。
- **任何环节出错都逐层回落**：TUS 失败 → 回落 7-03a 签名直传 → 再回落到最原始的上传函数。三层保险，真学生的上传不会因为续传坏掉。

## ⚠️ 一个偏差（我没照队列的「cdnjs」做，改自托管）
队列写「引入 tus-js-client（cdnjs）」，但这跟 **CLAUDE.md 的自托管铁律冲突**——第三方 CDN 在国内被墙、且 Capacitor 打包的 App 也加载不了 CDN（字体、PDF.js、supabase.js 全都是因此自托管的）。
- 我按既有惯例**把 tus-js-client 4.1.0 下载下来放进 `assets/vendor/tus.min.js`**（85KB，和 pdf.min.js/supabase.js 同目录、同加载方式：本地懒加载，用到才载）。功能一样，但守住了「不碰第三方 CDN」这条铁律。
- 这不是自作主张改需求，是两条指令冲突时选了不违反安全铁律的那条。若你坚持要 cdnjs，说一声我改回，但**强烈建议维持自托管**（否则国内学生和 App 内都用不了）。

## 改了什么（版本 +1）
- **学生端 v384 → v385**、**中介端 v152 → v153**：在上一包的共享上传模块里加了 TUS 层——
  1. 懒加载 `assets/vendor/tus.min.js`（`tusReady`，加载失败 8 秒超时即回落，不永等）。
  2. `upload()` 顶部加判断：开关开 + 文件 >1MB → 走 `tusUpload`（endpoint `/storage/v1/upload/resumable`，6MB 分片，retryDelays 断网重试，`findPreviousUploads`+`resumeFromPreviousUpload` 接断点，onProgress 接上一包的进度条）。
  3. 成功即返回；**任何失败/异常/无会话 → 回落 7-03a**。
- 新增文件 `assets/vendor/tus.min.js`（自托管库）。

## 十道闸
- **闸 3 / 9（静态）**：两端各 `new tus.Upload` 1 处、6MB 分片 1 处、>1MB 闸 1 处、开关 `mh_upload_tus` 在册、`assets/vendor/tus.min.js` 本地加载、7-03a 回落路径仍在；**零 cdnjs / 零 jsdelivr 引用**；两端 JS 解析干净。
- **闸 8（真浏览器走查·stub 版）** `tests/job7-03b.mjs` **5/5**：自托管 tus.min.js 能从本地 `../assets/vendor` 加载且 `window.tus.Upload` 是函数 ✅；开关默认开 / 设 off 关 / 移除恢复开 ✅；≤1MB 跳过 TUS、>1MB 走 TUS ✅；**TUS 失败 → 回落 7-03a 签名直传并最终成功** ✅；无会话 token 时 `tusUpload` 返回 {ok:false} 不抛 ✅。

## ⚠️ 延后的一闸（等你）
队列闸 8 要求「传 3MB 图，中途 `setOffline(true)` 断 3 秒再恢复，断言最终成功且请求里出现 `Upload-Offset` 头」——这必须打到**真 Supabase 续传端点 + 真账号会话**（stuA），属真库变更，且密码你没带出来。我用 stub 把决策/回落/开关/尺寸闸全验了；**真续传那一下**等你：① 补 stuA 密码；② 部署到线上（本地 file:// 打不到真 resumable 端点）。到位后我十分钟内补跑追证。
- 另：真机上你可在浏览器控制台 `localStorage.setItem('mh_upload_tus','off')` 一键关续传做对照。

## 动过的文件
- 改：`student-portal/maxhouse_student_portal_v385.html` + index；`partner-portal/maxhouse-partner-portal-v153.html` + index
- 新增：`assets/vendor/tus.min.js`（自托管）、`tests/job7-03b.mjs`

**主仓库未推。本回执已推日志仓库。**
