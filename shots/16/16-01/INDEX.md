# JOB-16-01 / 16-01b 放大缩小 公开截图（合成成绩单换图版，元素级 .mhv2，无真实数据）

每张：文件名｜哪端哪版｜这一步做了什么｜红/绿
- reviewer-v38-OLD-red.png｜审核端 v38（旧）｜v1 查看器打开合成图，工具条点了不放大｜红
- reviewer-v39-1-open.png ~ -7-fitpage.png｜审核端 v39（新）｜打开/放大/适宽/1:1/拖到边/旋转/回整页｜绿
- admin-v213-OLD-red.png｜管理端 v213（旧）｜v1 查看器打开合成图，＋点两下图不变大｜红
- admin-v214-1-open.png ~ -7-fitpage.png｜管理端 v214（新）｜同上七态｜绿
- school-v232-OLD-red.png｜学校端 v232（旧）｜v1 查看器＋点了不放大｜红
- school-v233-1-open.png ~ -7-fitpage.png｜学校端 v233（新）｜同上七态｜绿

说明：绿图由真页面（本地服务）+ 真登录/或 stub 会话打开该端真预览弹窗，网络层把要显示的图片字节换成工具箱合成成绩单，只截 .mhv2 组件本身。checkViewer 真鼠标 28 判全过（chromium+webkit）见 JOB-16-01b.md。
