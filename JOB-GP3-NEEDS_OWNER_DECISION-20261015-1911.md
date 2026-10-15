# 停点二乙 · GP3-02 成片已备好：传 v5 + 推页面，请业主执行 + 裁 4 处残疑

日期：2026-10-15　归属：GP3-02 修成片（RULING-20261015e §六 停点二乙）
一句话：**80 章全部重做 + 整片/分段/流畅版/海报/清单/页面全部备齐，全闸过，只差「上传 v5 到桶」和「推页面」这两步线上动作（规矩只能业主做）。另有 4 处小残疑请你一句话拍板。**

---

## 一、这趟把什么做完了（大白话）
1. **全闸过**（第 11 趟，回执 JOB-GP3-02-gates.md）：
   - 剪头/定格：408 镜，动作 408/408 都保住（剪掉的只是开头死等），12 张最差对比图。
   - 字幕带：48 帧抽样，带高/不透明/白字全对（0 挂）。竖版部分 3 行（见残疑②）。
   - 跟随框：80 章 384 镜全部 ≤0.3 秒（0 超标）。橙测另有 1 处残疑（见残疑①）。
   - 禁用词/隐私：276 条烧入文字全干净，无测试词/负数/真邮箱电话。
   - 片尾二维码：8 条整片全扫得出正确网址。
   - 联络表：80 张缩略图供你一眼扫（~/mh-jobs/shots/GP3/contact/）。
2. **海报/缩略/封面**（第 12 趟）：按新成片重出 176 张 webp（章海报随新字幕带更新；速览海报仍用 v4）。
3. **清单**：guide/partner/m/<lang>/ 的 manifest.json + lite-manifest.json 已重建——章/整片/分段/流畅/海报指向新的 **v5/** 对象（带新 md5），速览仍指 **v4/**（不动）。页面播放器代码一行没改（清单结构兼容）。
4. **页面 §四两处**：①静音按钮从彩色 emoji 改成单色 SVG 图标（和播放/全屏同风格，有声/静音两态）；②查清「默认静音」是截图工装所致、**页面本身点章就有声**（源码里零 muted、零 autoplay），无需改。版本串 bump 到 **gp2-20261015b**。页面回归自测两例全绿（静音键是 SVG、控制条不盖字幕带、零报错）。

---

## 二、请业主执行的两步线上动作（**顺序不能错**）

> ⚠ 清单已指向 v5 对象。**必须先传 v5 到桶、确认在线，再推页面**；顺序反了线上会 404。

### 第 1 步：传 v5 对象到 R2（原生终端，挂代理）
```
cd /Volumes/Dev/MAXHOUSE && export https_proxy=http://127.0.0.1:10808 http_proxy=http://127.0.0.1:10808 all_proxy=http://127.0.0.1:10808
bash jobs/JOB-GP3/gp3-upload.sh
```
- **要传：431 个对象，合计 379.8 MB，全部新建**（dry-run 实测：0 个已在、0 个覆盖——v5 前缀与 v4 零碰撞，**不动 v4 任何对象**）。
- 桶键命名（全部在 `guide/partner/v5/<lang>/<land|port>/` 下）：

  | 类别 | 个数 | 大小 | 键样例 |
  |------|------|------|--------|
  | 章 HD | 80 | 109.9 MB | v5/en/land/ch3.mp4 |
  | 章 lite | 80 | 56.3 MB | v5/en/land/ch3-lite.mp4 |
  | 整片 HD | 8 | 137.0 MB | v5/en/land/full.mp4 |
  | 分段 lite | 87 | 71.4 MB | v5/en/land/segments/full-seg01.mp4 |
  | 章海报 | 88 | 3.9 MB | v5/en/land/posters/ch3.webp |
  | 章缩略 | 80 | 1.2 MB | v5/en/land/thumbs/ch3.webp |
  | 封面 | 8 | 0.2 MB | v5/en/land/cover.webp |

- 脚本自带幂等（已在且字节一致则跳过）+ 逐个读回核验（HEAD 200 + Range 206 + 字节对上）。失败会列明细。

### 第 2 步：推页面提交（CC 已点名提交、未推；业主在原生终端挂代理推）
CC 本机已 commit（未 push）这些文件到主仓库：
- `guide/partner/index.html`（§四：静音 SVG + 版本串 gp2-20261015b）
- `guide/partner/m/{en,zh,ru,fr}/manifest.json` + `lite-manifest.json`（8 份，指向 v5）
- `jobs/JOB-GP3/`（本线工装/闸/决定账/请示单）

推送（四段式，承 CLAUDE.md P5·推后即验）：
```
cd /Volumes/Dev/MAXHOUSE
git log origin/main..HEAD --oneline        # 推前过目本次提交
export https_proxy=http://127.0.0.1:10808 http_proxy=http://127.0.0.1:10808
git push origin main
git log origin/main..HEAD --oneline        # 推后必须空
git fetch && git diff origin/main --stat    # 必须空
```
- 推后 ~1-2 分钟 Cloudflare Pages 自动部署。页面 HTML 有边缘缓存规则（guide-partner-html-cache），如旧版不散可在 CF 清该页缓存（这步 CC 不碰，业主定）。清单走 `?v=gp2-20261015b` 会自动绕过同源缓存。

---

## 三、请业主一句话拍板的 4 处残疑

① **fr-land 第 6 章 6-1 镜，橙框晚亮 ~1 秒**（橙色像素法测得 onDelay 1.0s）。该镜暗罩法（权威口径）判过、全 384 镜就这一处橙测偏大；en/zh/ru 同镜暗罩已过未橙测。**选项**：A 收下（边际，整体 0 超标）/ B 下次全量重录时一并修（本轮不单修）。CC 建议 **B**。

② **字幕带竖版部分 3 行**。RULING 字面「最多两行」；竖版窄、长字幕本就折 3 行（抽样 24 中 15 为 3 行），**且字幕文本沿用 v4 没改**＝不是这轮新造的问题。横版全 ≤2 行。**选项**：A 收下（同 v4 口径，横≤2/竖≤3）/ B 要求竖版压到 2 行（须改字幕断行、属新工作）。CC 建议 **A**。

③ **字幕带「长得对不对」最终肉眼**（铁律15）。新规格＝不透明紫 #3F3494 + 白字加粗 + 字号带高·0.26 + 竖 224/横 140，已烧进成片、像素层量全对。请你本地 file:// 开 ~/mh-jobs/shots/GP3/subband/ 的证据帧肉眼确认一致（样例已核：band-ch3-port-zh 不透明紫带白字加粗居中两行）。

④ **两处码率/海报边际**（都不阻塞，知会即可）：ru 竖版 full-seg05-lite 223kbps（上限 220，超 1.3%）；ru 竖版 1 张章海报 61.3KB（海报无硬上限）。

---

## 四、线上怎么验（第 2 步推完后，CC 做 GP3-03）
真浏览器打 https://www.maxhouses.net/guide/partner/?lang=zh 与 ?lang=en，四语 × 横竖 × 手机/电脑：①底部字幕带可见（新不透明带）②跟随框每章抽 2 处对得上口播 ③静音键是单色图标、点章有声 ④速览仍能放（指 v4）⑤页脚版本 gp2-20261015b。全绿写 SUMMARY-GP3 收官。

## 五、怎么退（出事回滚）
页面：`git revert` 该次提交并推——清单立刻回指 v4，页面恢复旧版（v4 对象一直在、没动）。v5 对象留桶不影响（无引用）。无需删桶。

---
**本停点＝任务书两停点之一。CC 到此停，等业主卡装 -done 裁决后循环重启接 GP3-03。**
附：回执 ~/mh-jobs/JOB-GP3-02-gates.md、决定账 JOB-GP3-decisions.md（D-GP3-11/12）、证据图 ~/mh-jobs/shots/GP3/{trimfreeze,subband,contact,page-v5}/。
