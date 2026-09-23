# JOB-20-00 · Repro B (partner v167) · 公开元素级截图索引

真页面真点，元素级截图，真实文字已 mask（账号邮箱打码；StuB 为测试推荐生别名，非真实 PII）。调试期不推送，最后干净后随回执推。

| filename | portal+version | what was clicked / staged | red/green |
|----------|----------------|---------------------------|-----------|
| bug1-roster-missing-after-verdict-RED.png | partner v167 | partner1 真登 → 真点 StuB 卡进弹窗 → 护照槽真选合成无-MRZ护照(暂存不提交) → verdict 出后 ~1s 量名单块 | RED（名单块不存在） |
| bug2-roster-persists-after-delete-RED.png | partner v167 | 同上，名单块画出后 → 真点缩略图红 × 删暂存件 → 量名单块 | RED（名单块仍在，缩略图=0） |
| bug3-en-fullwidth-colon-RED.png | partner v167 | EN 界面 partner1 真登 → StuB 护照槽真选合成护照 → R-2「Passport check」卡标题 | RED（英文标题含全角冒号「：」） |
| bug4-cardstack-overlap-1280w-RED.png | partner v167 | 1280px 宽，暂存护照弹 #_v167CardStack → 量与下方内容矩形重叠 | RED（重叠 34840 px²） |
| bug4-cardstack-overlap-390w-RED.png | partner v167 | 390px 宽，同上 | RED（重叠 7424 px²） |
