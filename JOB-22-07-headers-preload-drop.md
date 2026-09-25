# JOB-22-07 · _headers 预加载项删除（Claude 出卡、业主执行，非 CC 包）

- 日期：2026-09-25 11:03
- 改动：五端十条 Link 只保留 rel=preconnect（Supabase），删除全部 rel=preload（vendor/supabase.js、manrope 字体）。
- 原因：第二十二轮 22-01 把 Link 只挂网页后，业主线上仍见「preloaded using link preload but not used」（中介端 vendor ×2，学生端/学校端 字体 ×2 + vendor ×1），判定为预加载本身与实际加载方式不匹配；预加载对本站收益极小，删除最干净。
- 主仓库提交：976e426 JOB-22-07 _headers: drop rel=preload entries (keep preconnect) — browser reported them unused on all portals
