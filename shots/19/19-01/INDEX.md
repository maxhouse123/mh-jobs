# 19-01 截图（新版绿·partner v167）

对照 19-00 的旧版红（`shots/19/19-00/`：A 学校账号进注册 RED、B Q1 红底垫片 RED）。

| 文件 | 哪一端·哪一版 | 点了什么 | 红/绿 |
|---|---|---|---|
| gate-schX-rejected-GREEN.png | 中介端 v167 | 用学校账号 schX 真登中介端 → 停在登录页、显示「该账号无中介权限」、会话已清、无机构内容、控制台无 partner_bootstrap | 绿（角色门 deny，学校账号被挡） |
| gate-stuA-rejected-GREEN.png | 中介端 v167 | 用学生账号 stuA 真登中介端 → 同上被挡 | 绿（角色门 deny，学生账号被挡） |
| gate-reviewer1-rejected-GREEN.png | 中介端 v167 | 用审核账号 reviewer1 真登中介端 → 同上被挡 | 绿（角色门 deny，审核账号被挡） |
| sessionrestore-schX-ejected-GREEN.png | 中介端 v167 | 把一份真实 schX 会话种进中介端自己的 storage（mh-partner-auth / sessionStorage）再打开页面 → 会话恢复门把它登出并提示「该账号无中介权限」，无 partner_bootstrap | 绿（会话恢复也过门） |
| card-q1-amber-GREEN.png | 中介端 v167 | 在真页面上按 Q1「可能会被打回」调用点原样触发温和提醒 → 白底琥珀 ⚠ 卡片、标题加粗、文件名行、两条问题逐条分行、右上 × | 绿（showFormWarning 走真卡片：背景 rgb(255,247,237)=#FFF7ED、字色 rgb(154,52,18)=#9A3412、第 1 秒/第 4 秒均可见、不被随后 showToast 顶掉、× 可关） |

说明：
- 三张拒绝测试都是**真填账号密码真登**；被拒的账号是现成测试账号，登录后被角色门当场 `signOut()` 登出（只清会话、不改角色、不写任何业务表）。登录框邮箱已打码；被拒页为空登录门，无真实学生文字。
- card 截图为**元素级**（只截卡片本体），用的是合成文件名与两条通用提示文案，无真实学生 PII。
- N7 计量（第 1 秒/第 4 秒可见、计算后颜色、不被顶掉、× 关）由脚本量出，见回执 `JOB-19-01.md`。
