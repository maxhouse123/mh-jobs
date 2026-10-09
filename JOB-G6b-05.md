# JOB-G6b-05 回执（第一趟 · 上线步开头）· 两线全做完，已写 NEED_PUSH，等业主在原生终端推送

日期 2026-10-09 ｜ 无人值守 ｜ 本机 Mac mini（真卷 /Volumes/Dev/MAXHOUSE）

## 一句话
G-6b 两条线（学校线 + 学生线）的「配脸→重录→拼片→传桶→改页面」**全部做完并 commit 到本机主仓库**了。按规矩 CC 自己不 push，这趟只做上线步的开头动作：**核对未推提交账 + 写 `jobs/JOB-G6b/NEED_PUSH.txt`**，然后立刻结束，等业主在原生终端挂代理后 `git push`。线上真验是业主推完、Pages 部署后的下一趟才做。

## 这趟做了什么
1. **核对主仓库未推提交账**：`git --no-pager log origin/main..HEAD` = **9 笔，全部 `JOB-G6b` 前缀，0 例外**（G6b-00×2 / 01 / 01b / 02 / 03 / 03后半段 / 04后半段）。
2. **写 `jobs/JOB-G6b/NEED_PUSH.txt`**（留在主仓库工作区给业主看，一行原因：两线全做完待上线，请挂代理 push origin main，推完建 PUSHED 标记）。

## 现在两线的最终状态（都已 commit、都未推）
| 线 | 做完内容 | 新对象 | 页面构建串 |
|---|---|---|---|
| 学校线 G6b-03 | 7 章重录带新脸 + full/quick 重拼 + 片尾二维码=官网首页 | 私有桶 16 个 `-g6b` | `gs6b-20261009` |
| 学生线 G6b-04 | 四语 9 章(c05–c13)重录 + 四语拼片 + 片尾8处解码全=官网首页 | 公开桶 116 个 `-g6b` | `g6b-2026-10-09` |

- 换脸人数、非洲籍用近似组人数（0 近似组用于非洲籍女/南亚；仅 2 名非洲男因数据集到 2400 上限仍缺、照 R4 用近似组 D 并已标 near_group）、Lina 新脸编号等细节见 G6b-00~02 回执。

## 业主该做什么（照做）
1. 打开**原生终端**（不是 CC）。
2. 先挂代理：`export https_proxy=http://127.0.0.1:10808 http_proxy=http://127.0.0.1:10808 all_proxy=http://127.0.0.1:10808`
3. 进仓库推送：`cd /Volumes/Dev/MAXHOUSE && git push origin main`
4. 推完四段式核对：`git --no-pager log origin/main..HEAD --oneline`（应空）+ `git status`（应 clean）。
5. 建个标记让 CC 下趟知道已推：`echo "pushed $(date)" > jobs/JOB-G6b/PUSHED-$(date +%H%M%S).txt`

## 下一趟 CC 从哪接（等 PUSHED 后做线上真验）
- 看到 `jobs/JOB-G6b/PUSHED-*.txt` → 前台轮询线上两个构建串（学生 `g6b-2026-10-09` / 学校 `gs6b-20261009`，每 60 秒一次、最多 20 分钟，curl 带浏览器 UA 或用 Playwright）→ 出新构建串再做真验。
- 真验照 QUEUE-G6b §G6b-05：学生页四语首屏/点章出画面/速览整片能播/13 章 HEAD 200/改了的章带 `-g6b`/沿用章不变/分享码指引导页/页脚邮箱；学校页用自造 `G6b-test` 测试码（验完只删它、删前列清单、业主自用码不动）；从线上新片抽帧确认人脸 + 片尾扫码=官网首页。
- 收官 `~/mh-jobs/SUMMARY-G6b.md`，首行 `PUSH_OK=yes|no`。

## 没动的 / 零信任
- CC 没 push、没读 .env、没打印任何钥匙/令牌/业主码/演示密码。
- 主仓库 `NEED_PUSH.txt` 是留给业主的工作区信号文件，未 commit（下趟按惯例清理）。
