# JOB-19-04 公开截图索引 · 学生端 v398 材料名引号按语言

真页面：stuA 真登录学生端（只读，零写库）。每张为元素级截图（琥珀提示条内渲染 `_v706HumanizeIssue` 的输出行）。
判词样本：`Please re-upload a clear full page of '<criminal>'.`（无犯罪证明栏那条判词，内部代码 `criminal`）。
无 PII（仅材料类型名，无账号邮箱/护照/手机号）。

| 文件 | 版本 | 语言 | 期望包裹引号 | 实测 |
|------|------|------|--------------|------|
| red-zh.png   | v397（红） | 中文 | 「」 | 「无犯罪记录证明」 |
| red-en.png   | v397（红） | English | 应为 "" 但恒 「」 | 「Police clearance certificate」 |
| red-ru.png   | v397（红） | Русский | 应为 «» 但恒 「」 | 「Справка об отсутствии судимости」 |
| red-fr.png   | v397（红） | Français | 应为 « » 但恒 「」 | 「Extrait de casier judiciaire」 |
| green-zh.png | v398（绿） | 中文 | 「」 | 「无犯罪记录证明」（不变） |
| green-en.png | v398（绿） | English | "" | "Police clearance certificate" |
| green-ru.png | v398（绿） | Русский | «» | «Справка об отсутствии судимости» |
| green-fr.png | v398（绿） | Français | « » | « Extrait de casier judiciaire » |

结论：旧版四语都「」（红）→ 新版切英/俄/法引号随语言（绿）；中文仍「」。逐语 ok=true，OVERALL PASS。
机读判定见 `jobs/JOB-19-04/redgreen-results.json`。
