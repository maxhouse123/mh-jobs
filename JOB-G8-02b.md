# JOB-G8-02b —— 产品侧 §3.1 付款单改名（三端四语）＋ G8-02 收口（cycle=1 待推）

大白话：把全平台那笔 ¥3,000 的费用名字，从「中介服务费 / Intermediary Service Fee」正式改成
业主拍板的「**录取通知书解锁费 / Admission Letter Unlock Fee**」，中英俄法四种语言、学生端/中介端/管理端
三个端全部改到位；云端的翻译对照表也顺手把这条改了（只改源码、没上线，留业主）。改完跑了 62 条机器自检全绿。
这是 G8-02 这一包的最后一件代码活，现在到了「cycle=1 推送点」——我只提交没推，推送要业主在原生终端挂代理手动做。

---

## 一、这趟具体改了什么

### 1) 学生端 student v411 → **v412**（4 个新文件 + index 重定向）
- 旧版 v411 原样保留可回滚。新建：
  - `maxhouse_student_portal_v412.html`（主文件：英文词典 + 页面里内联的英文默认字 + 版本身份）
  - `maxhouse_student_i18n_v412_zh.js` / `_ru.js` / `_fr.js`（中/俄/法三本词典，各从 v360 复制后改）
  - 主文件里加载词典的那行从 v360 改指向 v412，老 v411 仍指 v360（互不影响，回滚干净）
- 改的键（四语都改）：付款单标题、金额标签、说明句、服务费说明引子、优惠码满减横幅、解锁说明、
  发票明细里的费用名、时间线「已付款」那条、隐私说明里「完成…费支付后解锁」那句。

### 2) 中介端 partner v182 → **v183**（3 个新文件 + index）
- 中介端英文和中文都在主文件里（内联），俄法在外部词典。新建：
  - `maxhouse-partner-portal-v183.html`、`maxhouse-partner-i18n-v183-ru.js`、`-fr.js`
- 键同学生端（中介端没有「解锁说明 unlock.payDesc」这个键，少改一条，正常）。

### 3) 管理端 admin v249 → **v250**（1 个新文件 + index；无外部词典）
- 管理端没有「付款单」本身（管理员不付款）。只改了**显示里出现本费名字**的三处：
  优惠码促销的面包屑、优惠码 100% 全免横幅、优惠码统计提示。中英都改。
- **刻意没改、并在此报备**（都不是付款单名字，怕误伤）：
  - 仪表盘那块会计统计用的简称「中介费 / Intermediary fees」——用的是简称「中介费」不是精确的「中介服务费」；
  - 代码里的变量名 `const INTERMEDIARY_FEE`、数据字段 `intermediaryFeePaid`——是程序内部标识符，不是给人看的字，改了有连带风险。
  - 优惠码按百分比满减那句「服务费立减 X% / X% off the service fee」——是通用「服务费」说法，和学生端留着的同款，没动。
  - 如果业主希望这几处也统一叫「解锁费」，一句话我下趟补（管理端属已批准可变端，但本条非付款单名、我先不自作主张）。

### 4) 云函数翻译对照表 `supabase/functions/ai-translate/index.ts`
- 对照表里 `["中介服务费", ...]` 这条改成新费名（含新俄法）。**只改了源码文件，没有部署上线**
  （CC 不自行部署生产云函数，跟不自行 push 主仓库一个道理，留业主决定要不要重新部署）。
- 说明：这张表是「开发时用 AI 批量翻界面文字」的辅助工具，**不在用户付款的运行链路里**；
  本次付款单的俄法译文是我手工译好直接写进 v412/v183 词典的，和这张表是否部署无关，不影响线上。

### 一刀切没碰的东西（防误伤，已逐一确认）
- 「中介」单独出现＝顾问/中介机构的意思（如「绑定中介」），**绝不动**；只精确替「中介服务费」整词。
- 另外两笔**不同的费**——¥1,500 审核费（Audit/Concierge service fee）、¥600 人工搜索费——
  以及退款政策、「您的服务费包含什么」标题、合作招募营销里的「全国最低服务费」等**通用服务费**字样，**全部保留不动**。
- 俄法里 `serviceFee.title`/`bannerPct`/退款条款/concierge/partner 的通用「сервисный сбор / frais de service」通用词**保留**。
- 唯一一处额外收拾：法语合作招募文案里 `partner.benefit3.desc` 原本用了旧发票词 `frais d'intermédiation`，
  把它统一成法语自己的通用词 `frais de service`（跟英文「service fee」、俄文「сервисную плату」对齐，**不是**改成新发票名）。

---

## 二、俄法译文 + 回译（spec §3.1 要求 CC 翻 + 回译）

| 键 | 俄文 → 回译中文 | 法文 → 回译中文 |
|---|---|---|
| 标题 payment.title | Плата за разблокировку письма о зачислении →「解锁录取通知书的费用」 | Frais de déverrouillage de la lettre d'admission →「解锁录取通知书的费用」 |
| 金额标签 amountLabel | ПЛАТА ЗА РАЗБЛОКИРОВКУ — ИТОГО К ОПЛАТЕ →「解锁费 — 应付总额」 | FRAIS DE DÉVERROUILLAGE — TOTAL DÛ →「解锁费 — 应付总额」 |
| 说明句 amountDesc | Разовая плата за разблокировку этого зачисления — открывает название вуза и ваше письмо о зачислении, а также покрывает оформление поступления. →「一次性解锁这笔录取的费用——可见校名与你的录取通知书，并含入学手续办理」 | Frais uniques pour déverrouiller cette admission — révèlent le nom de l'école et votre lettre d'admission, et couvrent les formalités d'inscription. →「一次性解锁这笔录取的费用——可见校名与你的录取通知书，并含入学手续办理」 |
| 发票明细名 detail.serviceName | Плата за разблокировку →「解锁费」 | Frais de déverrouillage →「解锁费」 |
| 优惠码全免 coupon.banner100 | Промокод {code}: Плата за разблокировку письма о зачислении отменена — ¥0 →「优惠码 {code}：录取通知书解锁费已免除 — ¥0」 | Code promo {code} : frais de déverrouillage de la lettre d'admission offerts — ¥0 →「优惠码 {code}：录取通知书解锁费免收 — ¥0」 |

（serviceFee.lead/timelinePaid/privacyDesc 同一费名替入，句式不变，不再逐条回译。）

---

## 三、闸的真实命令输出

- 替换脚本（逐键精确，每替换附命中计数，任一不足即 FAIL 停）：
  - `python3 jobs/JOB-G8/rename-fee.py` → 全 OK（student 四文件，含 EN×12处/zh 中介服务费×7/ru 9键/fr 9键）
  - `python3 jobs/JOB-G8/rename-fee-partner.py` → 全 OK（partner 三文件）
  - `python3 jobs/JOB-G8/rename-fee-admin.py` → 全 OK（admin 面包屑/优惠码共 9 处，每处 x1）
- **旧精确费名残留 = 0**（逐文件 grep `中介服务费 / intermediary service fee / Intermediary Fee / Посредническ / frais d'intermédiation` 等）：
  学生四文件 0/0/0/0、中介三文件 0/0/0、管理端 0。
- **i18n 引用切换**：student `i18n_v360` 引用 0 处（全转 v412）；partner `i18n-v126` 引用 0 处（全转 v183）。
- **泛指词保留**：student「Lowest service fee in China」在、zh「服务费立减」在、admin「Intermediary fees / % off the service fee / const INTERMEDIARY_FEE」在。
- **语法**：6 个外部 i18n JS 全部 `node --check` 通过；手工转义处核对无误（EN 单引号串 `school\'s`、法语单引号串 `d\'admission`）。
- **随卡回归**（铁律14 P3）：`node tests/g8-02-fee-rename.mjs` → **62 通过 / 0 失败**。
- **四件套**：三端 文件名 +1 / 头注或 [VER] 串改版 / MH_PORTAL_VER（412/183/250）/ index.html 重定向，均齐。

---

## 四、还差什么

1. **像素级肉眼验收**（铁律15 闸二）：付款单长相正确与否只有肉眼能判。guide_stuA/guide_agent 的截图需生产登录态
   （铁律11 留业主/线上）。CC 停在「已提交未推送」，请业主本地打开 v412/v183 切四语看付款单标题，或推上线后线上看。
   自检已证新词渲染（词典/内联默认均为新值、零旧词、零裸键）。
2. **§3.3 第 10 章「补充信息表」排版**：G8-00b 的离线 before 图结论＝去掉未登录闸后组件横排、字段可见、渲染正常，
   **疑似无真 bug**（唯一「塌陷」是未登录 display:none 假象）。最终确认需业主用生产登录态 + 一条真录取打开该表
   （铁律11 CC 不自驱生产登录/连库）。按 QUEUE-G8 §0.6 第三条，此项**不算停**——本趟未改组件、未出组件新版本。
   live 正常→§3.3 无需改组件，只在 G8-03 重录 ch10（§4 本就要重录）；live 不正常→下趟按真 bump 修组件。
3. **云函数 ai-translate 是否重新部署**：源码已改，留业主决定（对本次付款单改名线上无影响，见上）。

## 五、下一步（cycle=1 推送闭环）

- 已写 `jobs/JOB-G8/NEED_PUSH.txt`（cycle=1 + 原因 + 待推 7 笔清单）。
- 请业主在**原生终端**挂代理（127.0.0.1:10808）后 `git push origin main`（CC 不 push 主仓库）。
- 下一趟开工：看 `jobs/JOB-G8/PUSHED-*.txt` 最新首行是不是 cycle=1；是→前台轮询线上五端版本号到位
  （每 60s 一次、最多 20 分钟）→ 线上复验 §3.1 付款单四语新名截图 + §3.3 ch10 → 再进 G8-03（重录章节）。

## 六、安全
- 替换走本地脚本，不连网不连库；云函数只改源码未部署；DB 本趟未动。
- 回执/脚本/仓库无任何密钥、密码、gmail、演示账号。截图本趟未产出（像素验收留业主）。
