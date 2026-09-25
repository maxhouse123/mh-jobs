# JOB-21-01 · watermark-doc v36 线上计时（reviewer1 队列 30 份 + 复用探针 + 写回断言）

> 由 jobs/JOB-21-01/wm-timing-probe.mjs 于业主部署 v36 后产出。v36 计时头已删 mem 段（本环境恒不可读）。

## 计时头 mem 段删除核验

- 逐份响应头是否仍出现 mem 段：**否 ✓（v36 已删）**。

## 段1 逐份（无 mem 列）

| # | doc8 | 类型 | http | client总(ms) | auth | cache | fetch | render | upload | server总 | seq | boot_age | served |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | faf67595 | jpg | 200 | 5369 | 8ms | 143ms | 423ms | 4559ms | 1ms | 5135ms | 1 | 5s | rendered |
| 2 | 8e6d71f4 | jpg | 200 | 8088 | 6ms | 136ms | 235ms | 7190ms | 1ms | 7569ms | 1 | 8s | rendered |
| 3 | 92b727b0 | jpg | 200 | 7151 | 5ms | 166ms | 1269ms | 5296ms | 0ms | 6739ms | 1 | 7s | rendered |
| 4 | 3ed17166 | jpg | 200 | 6053 | 8ms | 121ms | 227ms | 5071ms | 1ms | 5429ms | 1 | 5s | rendered |
| 5 | 35f5e7c9 | jpg | 200 | 4815 | 7ms | 135ms | 254ms | 3918ms | 1ms | 4316ms | 1 | 4s | rendered |
| 6 | 922021f4 | jpg | 200 | 6581 | 7ms | 110ms | 252ms | 5814ms | 1ms | 6185ms | 1 | 6s | rendered |
| 7 | 9ff6f6f6 | jpg | 200 | 5325 | 7ms | 121ms | 608ms | 4092ms | 1ms | 4830ms | 1 | 5s | rendered |
| 8 | 378632b6 | pdf | 200 | 3971 | 6ms | 113ms | 246ms | 3099ms | 89ms | 3554ms | 1 | 4s | rendered |
| 9 | 23f0f3af | pdf | 422 | 498 | 7ms | 0ms | - | - | - | 106ms | 1 | 0s | denied |
| 10 | 0b1220ec | jpg | 200 | 3925 | 6ms | 147ms | 235ms | 3288ms | 1ms | 3678ms | 1 | 4s | rendered |
| 11 | a14cd60f | jpg | 200 | 6074 | 7ms | 182ms | 221ms | 5239ms | 1ms | 5651ms | 1 | 6s | rendered |
| 12 | 64545979 | jpg | 200 | 6891 | 7ms | 182ms | 242ms | 5977ms | 0ms | 6409ms | 1 | 6s | rendered |
| 13 | bdda2c6b | jpg | 200 | 4053 | 7ms | 97ms | 236ms | 3240ms | 1ms | 3582ms | 1 | 4s | rendered |
| 14 | c34be5c9 | jpg | 200 | 6121 | 7ms | 146ms | 224ms | 5374ms | 1ms | 5753ms | 1 | 6s | rendered |
| 15 | c4e8877f | jpg | 200 | 8208 | 9ms | 80ms | 226ms | 7308ms | 1ms | 7625ms | 1 | 8s | rendered |
| 16 | 7dca651b | mp4 | 415 | 519 | 8ms | 0ms | - | - | - | 65ms | 1 | 0s | denied |
| 17 | 8b6653bf | jpg | 200 | 5968 | 8ms | 110ms | 244ms | 5364ms | 0ms | 5728ms | 1 | 6s | rendered |
| 18 | bf1f753a | jpg | 200 | 3759 | 7ms | 134ms | 258ms | 2891ms | 1ms | 3292ms | 1 | 3s | rendered |
| 19 | 8e152fe2 | jpg | 200 | 4669 | 7ms | 104ms | 270ms | 4070ms | 0ms | 4452ms | 1 | 4s | rendered |
| 20 | a60ef89d | jpg | 200 | 4009 | 8ms | 116ms | 405ms | 3049ms | 0ms | 3580ms | 1 | 4s | rendered |
| 21 | 1d29cff0 | jpg | 200 | 7542 | 7ms | 126ms | 222ms | 6691ms | 1ms | 7048ms | 1 | 7s | rendered |
| 22 | 19f096bc | jpg | 200 | 3685 | 7ms | 103ms | 241ms | 2867ms | 1ms | 3220ms | 1 | 3s | rendered |
| 23 | 67258351 | mp4 | 415 | 391 | 17ms | 0ms | - | - | - | 94ms | 1 | 0s | denied |
| 24 | 006d9cef | jpg | 200 | 3385 | 7ms | 122ms | 200ms | 2822ms | 1ms | 3153ms | 1 | 3s | rendered |
| 25 | 265273be | jpg | 200 | 5915 | 7ms | 122ms | 227ms | 5321ms | 1ms | 5679ms | 1 | 6s | rendered |
| 26 | aadaca6f | jpg | 200 | 5888 | 5ms | 82ms | 225ms | 5184ms | 0ms | 5497ms | 1 | 6s | rendered |
| 27 | d24033a1 | jpg | 200 | 4225 | 5ms | 141ms | 239ms | 3373ms | 1ms | 3760ms | 1 | 4s | rendered |
| 28 | 2470f515 | jpg | 200 | 7013 | 9ms | 117ms | 224ms | 6132ms | 1ms | 6485ms | 1 | 6s | rendered |
| 29 | d3294af7 | jpg | 200 | 7046 | 10ms | 94ms | 234ms | 6159ms | 2ms | 6500ms | 1 | 7s | rendered |
| 30 | 6dfb8d50 | jpg | 200 | 6676 | 7ms | 115ms | 287ms | 5819ms | 1ms | 6230ms | 1 | 6s | rendered |

- 有效计时件：27 份；client 总耗时中位 5915ms；server 总中位 5497ms。
- 冷启动件（boot_age ≤ 3s）：3/27。

## 段2 实例复用 / 冷启动

### Probe A — 同一件 signed_url ×12（前6 @0.3s, 后6 @8s）

| # | http | client(ms) | seq | boot_age | served |
|---|---|---|---|---|---|
| A1 | 200 | 742 | 1 | 0s | cached |
| A2 | 200 | 419 | 1 | 0s | cached |
| A3 | 200 | 339 | 1 | 0s | cached |
| A4 | 200 | 752 | 1 | 0s | cached |
| A5 | 200 | 515 | 1 | 0s | cached |
| A6 | 200 | 713 | 1 | 0s | cached |
| A7 | 200 | 818 | 1 | 0s | cached |
| A8 | 200 | 575 | 1 | 0s | cached |
| A9 | 200 | 671 | 1 | 0s | cached |
| A10 | 200 | 648 | 1 | 0s | cached |
| A11 | 200 | 699 | 1 | 0s | cached |
| A12 | 200 | 598 | 1 | 0s | cached |

### Probe B — 3 件现场渲染各 ×2

| doc8 | call | http | client(ms) | seq | render | boot_age | served |
|---|---|---|---|---|---|---|---|
| faf67595 | c1 | 200 | 6646 | 1 | 5708ms | 6s | rendered |
| faf67595 | c2 | 200 | 7602 | 1 | 6983ms | 7s | rendered |
| 8e6d71f4 | c1 | 200 | 4813 | 1 | 3841ms | 4s | rendered |
| 8e6d71f4 | c2 | 200 | 6557 | 1 | 5949ms | 6s | rendered |
| 92b727b0 | c1 | 200 | 4195 | 1 | 3320ms | 4s | rendered |
| 92b727b0 | c2 | 200 | 5811 | 1 | 5196ms | 5s | rendered |

## 段3 写回断言（v36）

- 目标件 doc8=faf67595。
- 强制现场渲染：http=200 served=rendered → 走渲染/命中 ✓
- 紧接 signed_url 再问缓存：http=200 served=cached → **命中=YES ✓（渲染→回写→命中 整链通）**
- 注：reviewer1 缓存已近满（探针①96/104），本断言证「渲染后可命中」；要隔离「写回填空槽」，对刚派未预热件跑，或用 db-run 看 wm_cache_index.rendered_at 前移。

## 结论（自动初判，人工复核）

- v36 只加「现场渲染回写」+ 删 mem；鉴权/派单/缓存语义不变。
- seq 序列(Probe A) = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1] → 每请求即冷（与 v35 同环境特性）。
- 写回断言 通过：现场渲染后同件立即经 signed_url 命中缓存。

（生成时间由业主终端 date 记录；本脚本不取系统随机/时间以保证可复跑。）
