# shots/17/walk · JOB-17-07 线上走查截图

## 为什么本目录目前为空（CC 对现役线上跑）
本包（17-07）CC 只对**现役线上**（第十六轮版本：student v396 / partner v163 / school v233 /
admin v215 / reviewer v40）跑一遍走查。第十七轮的可见新功能（中介端 Copy link 提示条、英文界面
AI 提醒改语言）**尚未上线**（要等卡1135 推送 → 卡1136 部署），故现役线上这些点客观上都是红，
没有「绿」可截；能截的只有两类，均不宜进公开目录：

1. **中介端 Sent invites 列表 / Copy link**：列表行含**真实学生邮箱、姓名**（PII，铁律6 零信任）。
   本地私版截图（含 mask）留在 `~/mh-verify/shots/JOB-17/17-07/`，**不进公开目录**。
2. **学生端 studyPlan 上传卡**：真页面上该卡位于折叠区，`boundingBox` 为空、无法元素级截图；
   全页截图会带进 stuA 档案头信息，也不宜公开。

## 真「红→绿」截图在哪出
在**业主卡1136**（推送后新版上线 + precheck-ai v23 部署）里再跑一次
`bash jobs/JOB-17-07/online-walk.sh`（不带 MH_WALK_NO_WAIT，轮询等新版），
届时元素级红→绿（Copy link 提示条、英文 AI 提醒非中文）自然产出到本目录。

## 现役线上走查的证据（本包）
- 逐步红绿：`~/mh-jobs/JOB-17-07-online.md`（脚本自动写）。
- 真上传 / 进度卡 / 刷新持久 / 收尾软删 = 绿，且以 **带身份 SQL 探针**证明 stuA 的 studyPlan
  测试件收尾后 `alive=0`（见 `~/mh-jobs/JOB-17-07.md` 第五节）。
