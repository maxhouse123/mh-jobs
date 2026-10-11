# JOB-21-02 公开截图（partner v169 卡片定位验收）

真页面 partner1 真登 → 打开推荐生详情弹窗 → 触发护照琥珀提醒卡（_r2SoftToast）。
弹窗标题条（含学生姓名）已 mask（品红覆盖）；MH-FG85YG / StuB 为测试账号推荐生的测试数据，非真实 PII。

- card-@390.png：手机窄档（390px）——卡片钉视口底通栏，让开顶部弹窗标题条与关闭按钮；× 在卡右上。
- card-@1280.png：桌面（1280px）——卡片钉右下角（弹窗 760px 居中，右上会压标题条，故改右下），让开标题条/关闭按钮/正文。

数字实证（jobs/JOB-21-02/probes/p-v169-console.txt）：两宽六项矩形零重叠 maxOv=0px²、inScreen=true。
