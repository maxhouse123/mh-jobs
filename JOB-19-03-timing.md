# JOB-19-03 · watermark-doc v34 线上计时（reviewer1 队列前 30 份）

> 由 jobs/JOB-19-03/wm-timing-probe.mjs 于业主部署 v34 后产出。段落取自响应头 x-mh-wm-timing。

## 逐份

| # | doc8 | 类型 | http | client总(ms) | auth | cache | fetch | render | upload | server总 | boot_age | served |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | faf67595 | jpg | 200 | 9123 | 7ms | 176ms | 492ms | 947ms | 1ms | 1623ms | 2s | rendered |
| 2 | 8e6d71f4 | jpg | 200 | 7628 | 6ms | 163ms | 345ms | 501ms | 0ms | 1016ms | 1s | rendered |
| 3 | 92b727b0 | jpg | 200 | 8080 | 7ms | 124ms | 370ms | 534ms | 0ms | 1036ms | 1s | rendered |
| 4 | 3ed17166 | jpg | 200 | 4253 | 7ms | 160ms | 366ms | 372ms | 1ms | 906ms | 1s | rendered |
| 5 | 35f5e7c9 | jpg | 200 | 8322 | 5ms | 199ms | 363ms | 711ms | 0ms | 1278ms | 1s | rendered |
| 6 | 922021f4 | jpg | 200 | 5630 | 6ms | 211ms | 305ms | 384ms | 0ms | 907ms | 1s | rendered |
| 7 | 9ff6f6f6 | jpg | 200 | 8976 | 6ms | 186ms | 367ms | 550ms | 1ms | 1110ms | 1s | rendered |
| 8 | 378632b6 | pdf | 200 | 5092 | 6ms | 177ms | 368ms | 255ms | 49ms | 855ms | 1s | rendered |
| 9 | 23f0f3af | pdf | 422 | 4191 | 6ms | 0ms | - | - | - | 116ms | 0s | denied |
| 10 | 0b1220ec | jpg | 200 | 6534 | 5ms | 200ms | 394ms | 576ms | 0ms | 1175ms | 1s | rendered |
| 11 | a14cd60f | jpg | 200 | 5052 | 4ms | 128ms | 756ms | 463ms | 1ms | 1352ms | 1s | rendered |
| 12 | 64545979 | jpg | 200 | 5688 | 7ms | 172ms | 359ms | 357ms | 1ms | 896ms | 1s | rendered |
| 13 | bdda2c6b | jpg | 200 | 8480 | 6ms | 138ms | 439ms | 509ms | 1ms | 1093ms | 1s | rendered |
| 14 | c34be5c9 | jpg | 200 | 7406 | 6ms | 120ms | 327ms | 363ms | 0ms | 816ms | 1s | rendered |
| 15 | c4e8877f | jpg | 200 | 9006 | 7ms | 702ms | 378ms | 388ms | 1ms | 1476ms | 1s | rendered |
| 16 | 7dca651b | mp4 | 415 | 4067 | 6ms | 0ms | - | - | - | 428ms | 0s | denied |
| 17 | 8b6653bf | jpg | 200 | 6738 | 7ms | 502ms | 431ms | 582ms | 0ms | 1523ms | 2s | rendered |
| 18 | bf1f753a | jpg | 200 | 6833 | 7ms | 164ms | 315ms | 401ms | 0ms | 888ms | 1s | rendered |
| 19 | 8e152fe2 | jpg | 200 | 4661 | 7ms | 226ms | 305ms | 774ms | 0ms | 1313ms | 1s | rendered |
| 20 | a60ef89d | jpg | 200 | 5525 | 6ms | 123ms | 327ms | 377ms | 1ms | 834ms | 1s | rendered |
| 21 | 1d29cff0 | jpg | 200 | 4967 | 8ms | 168ms | 348ms | 776ms | 0ms | 1300ms | 1s | rendered |
| 22 | 19f096bc | jpg | 200 | 7737 | 6ms | 143ms | 350ms | 385ms | 0ms | 885ms | 1s | rendered |
| 23 | 67258351 | mp4 | 415 | 5235 | 4ms | 0ms | - | - | - | 126ms | 0s | denied |
| 24 | 006d9cef | jpg | 200 | 5532 | 6ms | 106ms | 1633ms | 318ms | 0ms | 2064ms | 2s | rendered |
| 25 | 265273be | jpg | 200 | 8945 | 6ms | 193ms | 354ms | 751ms | 0ms | 1305ms | 1s | rendered |
| 26 | aadaca6f | jpg | 200 | 7106 | 6ms | 215ms | 351ms | 385ms | 1ms | 958ms | 1s | rendered |
| 27 | d24033a1 | jpg | 200 | 8541 | 5ms | 154ms | 462ms | 329ms | 1ms | 951ms | 1s | rendered |
| 28 | 2470f515 | jpg | 200 | 4992 | 4ms | 248ms | 323ms | 572ms | 0ms | 1147ms | 1s | rendered |
| 29 | d3294af7 | jpg | 200 | 5407 | 6ms | 137ms | 366ms | 735ms | 0ms | 1245ms | 1s | rendered |
| 30 | 6dfb8d50 | jpg | 200 | 4742 | 7ms | 112ms | 314ms | 356ms | 1ms | 790ms | 1s | rendered |

## 按「慢在哪一段」分组

- 有效计时件：27 份；server 总耗时中位 1093ms（range 0–2064ms）。
- 冷启动件（boot_age ≤ 3s）：27 份。

| 最慢段 | 含义 | 份数 | 该段中位(ms) | 这些件 total 中位(ms) |
|---|---|---|---|---|
| cache | 权限门+缓存索引 | 1 | 702 | 1476 |
| fetch | 取原件(下载) | 5 | 462 | 951 |
| render | 烧录水印 | 21 | 534 | 1093 |

## 结论（自动初判，人工复核）

- 冷启动占比不小（27/27）→ 主因偏 EF 冷启动/常驻。按 QUEUE-19 §0.10：只写保温建议、不加保温定时任务。
- 多数件慢在 render(烧录水印)（21/27）→ 成本在服务端渲染，与带宽/缓存无关（印证 18-00③）。
- 角色门并行(修 a)已在 v34 生效：reviewer 命中路 cache 段应显著小于旧版四级串行最坏情形。

（生成时间由业主终端 date 记录；本脚本不取系统随机/时间以保证可复跑。）
