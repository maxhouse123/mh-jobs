# JOB-G3-02 回执 · 英文重录 13 章 →「必须停」

日期 2026-10-05（笔记本自动会话）｜ 依据 QUEUE-G3 包 G3-02

## 一句话
英文 13 章用新高亮引擎全部重录完成，86 镜 / 84 高亮镜，**每个框 IoU=1.00、边差 0px**；七道格式闸全过；第 7 章已去 PayPal/半价/1,500（录制时遮蔽，详见下）。两套审查图已推，**现已停在审看检查点**，等您回「英文过」。

## 闸判据自评
① 86 镜 expect/forbid 全过 —— ✅（13 章 0 错）
② 高亮闸全过（IoU≥0.90、边差≤6px） —— ✅（84/84 全 IoU=1.00、0px）
③ 格式七闸对英文全过 —— ✅（gates.mjs：全闸通过）
④ 两种表都已推 —— ✅（shots/G3/cNN.jpg ×14、hl-cNN.jpg ×13）

## 详细审看说明见 `SUMMARY-G3-A.md`（首行 REVIEW=yes）
里面有：每镜 IoU 结论、static 镜清单与替代办法、**三件需您确认的事**（①第7章付款单 PayPal/半价的"录制时遮蔽"请您拍板 ②镜数实为 86 非 88 ③解锁后显示 Demo University 但城市仍 Wuhan）、过程中修好的录制问题。

## 动了哪些文件（主仓库，暂不推，G3-03 闸全过后统一推）
- `jobs/JOB-G1/rec/harness.mjs`：_resolve 优先可见元素 + 隐藏触发器爬可见祖先 + findText 上限 140→300
- `jobs/JOB-G1/rec/c02.mjs`：2-5 清邀请态再录登录门
- `jobs/JOB-G1/rec/c06.mjs`：6-6 改用已接受卡容器定位
- `jobs/JOB-G1/rec/c07.mjs`：红线遮蔽守卫（隐藏 PayPal/半价）
- `jobs/JOB-G1/rec/c08.mjs`：8-2 等升级弹窗就位再高亮
- `jobs/JOB-G1/rec/c12.mjs`：12-10 改 MAXHOUSE 0 元代解锁 + 红线遮蔽守卫
- `jobs/JOB-G1b/contact-sheets-g3.mjs`：联络表输出改 shots/G3（新）
- 成片(guide/dist/en)、录制帧、音频、PNG 均不入库

## 停工点
已写 `~/mh-verify/rG3-STOP.txt` = `WAIT_REVIEW`。等 `~/mh-verify/rG3-REVIEW-OK.txt` 出现后做 G3-03。
