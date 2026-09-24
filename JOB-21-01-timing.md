# JOB-21-01 · watermark-doc v36 线上计时（reviewer1 队列 30 份 + 复用探针 + 写回断言）

> 由 jobs/JOB-21-01/wm-timing-probe.mjs 于业主部署 v36 后产出。v36 计时头已删 mem 段（本环境恒不可读）。

## 计时头 mem 段删除核验

- 逐份响应头是否仍出现 mem 段：**否 ✓（v36 已删）**。

## 段1 逐份（无 mem 列）

| # | doc8 | 类型 | http | client总(ms) | auth | cache | fetch | render | upload | server总 | seq | boot_age | served |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | faf67595 | jpg | 200 | 4971 | 9ms | 238ms | 400ms | 3925ms | 1ms | 4575ms | 1 | 5s | rendered |
| 2 | 8e6d71f4 | jpg | 200 | 5107 | 5ms | 304ms | 279ms | 3922ms | 0ms | 4511ms | 1 | 5s | rendered |
| 3 | 92b727b0 | jpg | 200 | 3720 | 8ms | 147ms | 257ms | 2824ms | 1ms | 3239ms | 1 | 3s | rendered |
| 4 | 3ed17166 | jpg | 200 | 3551 | 7ms | 191ms | 214ms | 2853ms | 0ms | 3266ms | 1 | 3s | rendered |
| 5 | 35f5e7c9 | jpg | 200 | 4712 | 10ms | 162ms | 273ms | 3942ms | 9ms | 4397ms | 1 | 4s | rendered |
| 6 | 922021f4 | jpg | 200 | 981 | 1ms | 124ms | 237ms | 209ms | 0ms | 572ms | 2 | 13s | rendered |
| 7 | 9ff6f6f6 | jpg | 200 | 4345 | 7ms | 153ms | 257ms | 3688ms | 1ms | 4107ms | 1 | 4s | rendered |
| 8 | 378632b6 | pdf | 200 | 6585 | 10ms | 232ms | 262ms | 5536ms | 86ms | 6128ms | 1 | 6s | rendered |
| 9 | 23f0f3af | pdf | 422 | 528 | 7ms | 0ms | - | - | - | 130ms | 1 | 0s | denied |
| 10 | 0b1220ec | jpg | 200 | 4238 | 5ms | 163ms | 252ms | 3523ms | 0ms | 3945ms | 1 | 4s | rendered |
| 11 | a14cd60f | jpg | 200 | 4500 | 8ms | 194ms | 264ms | 3544ms | 1ms | 4012ms | 1 | 4s | rendered |
| 12 | 64545979 | jpg | 200 | 3980 | 7ms | 175ms | 261ms | 3032ms | 0ms | 3476ms | 1 | 3s | rendered |
| 13 | bdda2c6b | jpg | 200 | 3931 | 7ms | 158ms | 253ms | 3026ms | 1ms | 3446ms | 1 | 3s | rendered |
| 14 | c34be5c9 | jpg | 200 | 4254 | 6ms | 168ms | 302ms | 3325ms | 0ms | 3802ms | 1 | 4s | rendered |
| 15 | c4e8877f | jpg | 200 | 4198 | 7ms | 131ms | 705ms | 2932ms | 0ms | 3776ms | 1 | 4s | rendered |
| 16 | 7dca651b | mp4 | 415 | 567 | 6ms | 0ms | - | - | - | 154ms | 1 | 0s | denied |
| 17 | 8b6653bf | jpg | 200 | 4146 | 9ms | 151ms | 264ms | 3371ms | 0ms | 3797ms | 1 | 4s | rendered |
| 18 | bf1f753a | jpg | 200 | 4896 | 8ms | 194ms | 265ms | 3942ms | 0ms | 4411ms | 1 | 4s | rendered |
| 19 | 8e152fe2 | jpg | 200 | 4061 | 8ms | 181ms | 186ms | 3070ms | 0ms | 3447ms | 1 | 3s | rendered |
| 20 | a60ef89d | jpg | 200 | 4192 | 7ms | 143ms | 274ms | 3108ms | 0ms | 3534ms | 1 | 4s | rendered |
| 21 | 1d29cff0 | jpg | 200 | 4195 | 8ms | 143ms | 258ms | 3345ms | 1ms | 3756ms | 1 | 4s | rendered |
| 22 | 19f096bc | jpg | 200 | 5747 | 7ms | 153ms | 305ms | 4849ms | 1ms | 5316ms | 1 | 5s | rendered |
| 23 | 67258351 | mp4 | 415 | 524 | 7ms | 0ms | - | - | - | 79ms | 1 | 0s | denied |
| 24 | 006d9cef | jpg | 200 | 3475 | 6ms | 142ms | 220ms | 2821ms | 1ms | 3191ms | 1 | 3s | rendered |
| 25 | 265273be | jpg | 200 | 3902 | 10ms | 129ms | 243ms | 3082ms | 1ms | 3466ms | 1 | 3s | rendered |
| 26 | aadaca6f | jpg | 200 | 5532 | 6ms | 174ms | 252ms | 4607ms | 1ms | 5042ms | 1 | 5s | rendered |
| 27 | d24033a1 | jpg | 200 | 4019 | 7ms | 127ms | 263ms | 3226ms | 0ms | 3625ms | 1 | 4s | rendered |
| 28 | 2470f515 | jpg | 200 | 4361 | 7ms | 162ms | 269ms | 3495ms | 1ms | 3935ms | 1 | 4s | rendered |
| 29 | d3294af7 | jpg | 200 | 4012 | 7ms | 132ms | 243ms | 3228ms | 0ms | 3611ms | 1 | 4s | rendered |
| 30 | 6dfb8d50 | jpg | 200 | 3956 | 7ms | 139ms | 245ms | 3148ms | 0ms | 3541ms | 1 | 4s | rendered |

- 有效计时件：27 份；client 总耗时中位 4195ms；server 总中位 3776ms。
- 冷启动件（boot_age ≤ 3s）：7/27。

## 段2 实例复用 / 冷启动

### Probe A — 同一件 signed_url ×12（前6 @0.3s, 后6 @8s）

| # | http | client(ms) | seq | boot_age | served |
|---|---|---|---|---|---|
| A1 | 200 | 681 | 1 | 0s | cached |
| A2 | 200 | 442 | 1 | 0s | cached |
| A3 | 200 | 397 | 1 | 0s | cached |
| A4 | 200 | 423 | 1 | 0s | cached |
| A5 | 200 | 731 | 1 | 0s | cached |
| A6 | 200 | 412 | 1 | 0s | cached |
| A7 | 200 | 721 | 1 | 0s | cached |
| A8 | 200 | 682 | 1 | 0s | cached |
| A9 | 200 | 799 | 1 | 0s | cached |
| A10 | 200 | 1218 | 1 | 0s | cached |
| A11 | 200 | 2232 | 1 | 2s | cached |
| A12 | 200 | 681 | 1 | 0s | cached |

### Probe B — 3 件现场渲染各 ×2

| doc8 | call | http | client(ms) | seq | render | boot_age | served |
|---|---|---|---|---|---|---|---|
| faf67595 | c1 | 200 | 5542 | 1 | 4073ms | 5s | rendered |
| faf67595 | c2 | 200 | 1449 | 2 | 707ms | 124s | rendered |
| 8e6d71f4 | c1 | 200 | 3864 | 1 | 3232ms | 4s | rendered |
| 8e6d71f4 | c2 | 200 | 3778 | 1 | 3257ms | 3s | rendered |
| 92b727b0 | c1 | 200 | 3683 | 1 | 3020ms | 3s | rendered |
| 92b727b0 | c2 | 200 | 4139 | 1 | 3708ms | 4s | rendered |

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
