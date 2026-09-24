# JOB-20-01 · watermark-doc v35 线上计时（reviewer1 队列 30 份 + 复用探针）

> 由 jobs/JOB-20-01/wm-timing-probe.mjs 于业主部署 v35 后产出。段落取自响应头 x-mh-wm-timing（v35 新增 seq/mem/cpu）。

## 段1 逐份

| # | doc8 | 类型 | http | client总(ms) | auth | cache | fetch | render | upload | server总 | seq | mem | boot_age | served |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | faf67595 | jpg | 200 | 5394 | 7ms | 259ms | 428ms | 4390ms | 1ms | 5085ms | 1 | 0/0MB | 5s | rendered |
| 2 | 8e6d71f4 | jpg | 200 | 6597 | 7ms | 133ms | 329ms | 5415ms | 0ms | 5885ms | 1 | 0/0MB | 6s | rendered |
| 3 | 92b727b0 | jpg | 200 | 5006 | 7ms | 147ms | 311ms | 4123ms | 2ms | 4590ms | 1 | 0/0MB | 5s | rendered |
| 4 | 3ed17166 | jpg | 200 | 5048 | 8ms | 126ms | 657ms | 3766ms | 1ms | 4558ms | 1 | 0/0MB | 5s | rendered |
| 5 | 35f5e7c9 | jpg | 200 | 5886 | 6ms | 119ms | 239ms | 5071ms | 1ms | 5436ms | 1 | 0/0MB | 5s | rendered |
| 6 | 922021f4 | jpg | 200 | 4450 | 7ms | 159ms | 273ms | 3520ms | 1ms | 3960ms | 1 | 0/0MB | 4s | rendered |
| 7 | 9ff6f6f6 | jpg | 200 | 4759 | 8ms | 113ms | 262ms | 3963ms | 1ms | 4347ms | 1 | 0/0MB | 4s | rendered |
| 8 | 378632b6 | pdf | 200 | 4058 | 5ms | 224ms | 263ms | 3082ms | 37ms | 3612ms | 1 | 0/0MB | 4s | rendered |
| 9 | 23f0f3af | pdf | 422 | 475 | 7ms | 0ms | - | - | - | 75ms | 1 | 0MB | 0s | denied |
| 10 | 0b1220ec | jpg | 200 | 4978 | 6ms | 139ms | 262ms | 4341ms | 1ms | 4749ms | 1 | 0/0MB | 5s | rendered |
| 11 | a14cd60f | jpg | 200 | 4630 | 7ms | 260ms | 255ms | 3659ms | 1ms | 4182ms | 1 | 0/0MB | 4s | rendered |
| 12 | 64545979 | jpg | 200 | 4879 | 7ms | 124ms | 340ms | 3750ms | 0ms | 4222ms | 1 | 0/0MB | 4s | rendered |
| 13 | bdda2c6b | jpg | 200 | 5910 | 5ms | 148ms | 385ms | 4604ms | 0ms | 5143ms | 1 | 0/0MB | 5s | rendered |
| 14 | c34be5c9 | jpg | 200 | 4279 | 6ms | 103ms | 244ms | 3384ms | 1ms | 3738ms | 1 | 0/0MB | 4s | rendered |
| 15 | c4e8877f | jpg | 200 | 5139 | 6ms | 127ms | 283ms | 4160ms | 1ms | 4577ms | 1 | 0/0MB | 5s | rendered |
| 16 | 7dca651b | mp4 | 415 | 521 | 7ms | 0ms | - | - | - | 67ms | 1 | 0MB | 0s | denied |
| 17 | 8b6653bf | jpg | 200 | 4592 | 7ms | 195ms | 198ms | 3977ms | 1ms | 4378ms | 1 | 0/0MB | 4s | rendered |
| 18 | bf1f753a | jpg | 200 | 4703 | 7ms | 124ms | 199ms | 3526ms | 1ms | 3858ms | 1 | 0/0MB | 4s | rendered |
| 19 | 8e152fe2 | jpg | 200 | 5718 | 7ms | 107ms | 218ms | 4749ms | 1ms | 5083ms | 1 | 0/0MB | 5s | rendered |
| 20 | a60ef89d | jpg | 200 | 4647 | 7ms | 159ms | 246ms | 3777ms | 0ms | 4190ms | 1 | 0/0MB | 4s | rendered |
| 21 | 1d29cff0 | jpg | 200 | 4801 | 7ms | 167ms | 235ms | 3877ms | 1ms | 4287ms | 1 | 0/0MB | 4s | rendered |
| 22 | 19f096bc | jpg | 200 | 4973 | 7ms | 149ms | 223ms | 4201ms | 1ms | 4581ms | 1 | 0/0MB | 5s | rendered |
| 23 | 67258351 | mp4 | 415 | 499 | 5ms | 0ms | - | - | - | 60ms | 1 | 0MB | 0s | denied |
| 24 | 006d9cef | jpg | 200 | 4973 | 7ms | 109ms | 230ms | 4181ms | 0ms | 4529ms | 1 | 0/0MB | 5s | rendered |
| 25 | 265273be | jpg | 200 | 5804 | 7ms | 95ms | 516ms | 4684ms | 1ms | 5303ms | 1 | 0/0MB | 5s | rendered |
| 26 | aadaca6f | jpg | 200 | 4928 | 5ms | 125ms | 480ms | 3772ms | 4ms | 4387ms | 1 | 0/0MB | 4s | rendered |
| 27 | d24033a1 | jpg | 200 | 4808 | 7ms | 176ms | 258ms | 3757ms | 1ms | 4199ms | 1 | 0/0MB | 4s | rendered |
| 28 | 2470f515 | jpg | 200 | 6915 | 7ms | 96ms | 231ms | 6025ms | 1ms | 6360ms | 1 | 0/0MB | 6s | rendered |
| 29 | d3294af7 | jpg | 200 | 5497 | 6ms | 113ms | 223ms | 4732ms | 1ms | 5076ms | 1 | 0/0MB | 5s | rendered |
| 30 | 6dfb8d50 | jpg | 200 | 4667 | 7ms | 99ms | 321ms | 3820ms | 0ms | 4248ms | 1 | 0/0MB | 4s | rendered |

- 有效计时件：27 份；client 总耗时中位 4973ms；server 总中位 4529ms。
- 冷启动件（boot_age ≤ 3s）：0/27。

## 段2 实例复用 / 冷启动

### Probe A — 同一件 signed_url ×12（前6 @0.3s, 后6 @8s）

| # | http | client(ms) | seq | boot_age | served |
|---|---|---|---|---|---|
| A1 | 200 | 1320 | 1 | 1s | cached |
| A2 | 200 | 513 | 1 | 0s | cached |
| A3 | 200 | 517 | 1 | 0s | cached |
| A4 | 200 | 635 | 2 | 21s | cached |
| A5 | 200 | 812 | 1 | 0s | cached |
| A6 | 200 | 411 | 1 | 0s | cached |
| A7 | 200 | 916 | 1 | 0s | cached |
| A8 | 200 | 774 | 1 | 0s | cached |
| A9 | 200 | 685 | 1 | 0s | cached |
| A10 | 200 | 840 | 1 | 0s | cached |
| A11 | 200 | 671 | 1 | 0s | cached |
| A12 | 200 | 834 | 1 | 0s | cached |

### Probe B — 3 件现场渲染各 ×2（含 mem）

| doc8 | call | http | client(ms) | seq | mem | render | boot_age |
|---|---|---|---|---|---|---|---|
| faf67595 | c1 | 200 | 4593 | 1 | 0/0MB | 3725ms | 4s |
| faf67595 | c2 | 200 | 6533 | 1 | 0/0MB | 5758ms | 6s |
| 8e6d71f4 | c1 | 200 | 4297 | 1 | 0/0MB | 3324ms | 4s |
| 8e6d71f4 | c2 | 200 | 4196 | 1 | 0/0MB | 3377ms | 4s |
| 92b727b0 | c1 | 200 | 5074 | 1 | 0/0MB | 4273ms | 5s |
| 92b727b0 | c2 | 200 | 4666 | 1 | 0/0MB | 3776ms | 4s |

### 三问结论

- (a) 连续请求是否落同一实例？seq 序列 = [1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1] → 有复用(seq 出现 >1)。
- (b) 渲染后下一请求是否必冷？见 Probe B 各件 c2 的 seq/boot_age（seq=1 且 boot_age 小 = 新冷实例）。
- (c) signed_url 路 0.3s vs 8s 是否保持热？前6 seq=[1,1,1,2,1,1] 后6 seq=[1,1,1,1,1,1]。

## 结论（自动初判，人工复核）

- v35 瘦身目标：boot 期不再解析 285 KB base64 + 不再解码 214 KB + imagescript 按需 → 冷启动路径更短。
- 与 19-03 对比基准：client 中位 6.7s（4.3–9.1s）。本次 client 中位 4973ms。差值即 v35 瘦身对墙钟的实际影响（人工填结论）。
- 若仍 client 中位 ≥ 3s：冷启动仍是大头；保温仅在「实例因空闲被回收」时有意义，本环境为每请求即冷 → 保温 ping 救不了下一次新实例（见 20-00①）。

（生成时间由业主终端 date 记录；本脚本不取系统随机/时间以保证可复跑。）
