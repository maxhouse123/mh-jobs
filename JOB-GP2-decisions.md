# JOB-GP2 决定账

CC 自己做的每个决定按 D-GP2-<趟>-<序> 记在这里；每趟结束复制到 ~/mh-jobs/JOB-GP2-decisions.md 推送。

## 第 1 趟（2026-10-14）

- **D-GP2-1-1** · GP2-00a 联络表重出 · ch2 的 2-4 分段联络表用现成 `rec/_seg-strip-24.mjs` 重跑，该工具一次循环四语。裁决只点名英/俄/法（zh ch2 第四轮未重烧），但工具对 zh 也从「当前最终成片」重渲一张同名图——内容与旧图一致、纯覆盖、无副作用，故不改工具、四语全出。理由：最省改动且结果自洽（覆盖口径＝「文件名与原来一致」）。改文件：~/mh-jobs/shots/GP1/{en,zh,ru,fr}/ch2-2-4-segments-*.png。
- **D-GP2-1-2** · GP2-00a 禁用词复扫 · 第 53 趟 ch6 横版复扫「登录限流」的真病根＝登录账号是 gmail，原 `_scan-ch6-forbidden.mjs` 的 MASK_INIT 作为 initScript 在登录前把 #emailInput 的真 gmail 改写成 DEMO → Supabase 返 Invalid credentials，被误判为限流。修法：①照裁决「每语只登录一次」把 8 次登录降到 4（每语一 context，land/port 共用会话）；②MASK/HIDE 改到登录解锁后再 page.evaluate 注入（扫描内容在注入后渲染，遮罩口径不变）。新工具 `jobs/JOB-GP2/_scan-ch6-forbidden-gp2.mjs`，原工具不动。结果四语横竖 ALL CLEAN。理由：定位到真因后，正确修比空等限流窗口更稳，且满足裁决的「每语一次登录」。
