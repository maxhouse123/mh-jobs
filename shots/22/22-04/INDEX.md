# JOB-22-04 截图（元素级 · 无 PII）

- `REV-version-banner.png` — 审核端 v46「有新版请刷新」横幅（reviewer1 真登后触发，元素级裁切）；紫底、zh（审核端 zh-only）、点整条去根地址、绝不自动刷新、可关。

管理端 v219 无测试账号、且在 Cloudflare Access 后——本地无头登录门（gate）阶段 body 未起来横幅零尺寸，故不出截图；已用无头本地启动**零新报错** + 直接调 `_mhShowVersionBanner()` 功能核（元素生成、文案「有新版本，点此刷新」、`_mhCurrentPortalVer()=219`）+ P3 静态断言证明（见回执闸3/P3）。

调试期不推送；随收官（22-06）最后一次干净后过 secret-scan 再推。
