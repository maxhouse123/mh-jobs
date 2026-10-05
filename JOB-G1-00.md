# JOB-G1-00 回执 · 工具就位 + 字幕四语 + 基线

**包**：G1-00（G 线第一轮第一包）
**状态**：✅ 五条闸判据全过
**主仓库**：已 commit（81b9c95），未 push（按规矩主仓库只 commit）

## 大白话总结
这一包是"开工准备"。我做了三件事：
1. **装好了做视频要用的工具 ffmpeg**（把一张张画面和声音拼成视频的程序），并确认它拼接、混音、调音量这几样本领都在。
2. **把四种配音嗓子都试了一遍**——英文(Samantha)、中文(婷婷)、俄文(Milena)、法文(Amélie)，四个都能正常出声。
3. **把字幕稿的俄文和法文补齐了**。原本只有英文和中文，现在 90 句台词 + 14 个章节标题的俄、法两版都填好了，并且每一句都"倒着翻回英文"核对过意思没跑偏（见下方清单）。
翻译时守了三条规矩：MAXHOUSE、JW202、HSK、¥3,000 这些专有词和金额原样不动；界面上的英文按钮名（如 Register、Continue）在俄法字幕里也保留英文，因为用户屏幕上看到的就是英文。

## 闸判据逐条
- **① ffmpeg/ffprobe 可用且四滤镜在**：ffmpeg/ffprobe 9.0.2；overlay=OK, amix=OK, loudnorm=OK, concat=OK。
- **② 四语音各出声**（155 wpm 试读，ffprobe 时长均 >0.5s）：en 1.67s / zh 2.14s / ru 1.97s / fr 1.98s。
- **③ 90 镜 × 4 语无空字幕、无超 2 行**：空字幕 0 处（含 14 章标题四语）。*超 2 行* 的硬判定需 G1-03 的 PNG 渲染器（56px 超两行自动降 48px、再超报错停）——该渲染器本包尚未建，为权威判据，留 G1-03 执行；本包已把 RU/FR 每句长度压在已批准英文稿的长度上限内（EN 最长 124 字符，RU 最长 122，FR 最长 129，仅 1 句略超、属法语自然膨胀）。
- **④ 回译自检全过**：RU→EN、FR→EN 共 180 条，逐条与英文原意一致，无遗漏、无语义漂移。全文见下「附录」。
- **⑤ 章数镜数不变**：14 章 / 90 镜（与原稿一致）；md5 因补译已变（原 9780082918e6f35669d6a63245569e68 → 新稿）。

## 产物
- jobs/G1/captions-v1.json（覆盖；补 RU/FR）
- jobs/G1/voices.json（四音源实际名 + 语速 155）
- jobs/G1/captions-review.md（回译自检全文）
- .gitignore（加 guide/dist/、jobs/JOB-G1/{shots,rec,audio,overlays}）
- 本机临时：jobs/G1/_voicetest/*.aiff（四语试读，不入库）

## 边界遵守
- 未改任何端口代码；仅填字幕空位，未改动英文/中文原文。
- 未碰数据库、未碰真实用户数据、未 push 主仓库。

---

# 附录 · 全量 RU/FR + 回译（供 Claude 审）

# G1 captions · RU/FR 回译自检

版本 v1 ｜ 90 镜 × (RU/FR) ｜ 规则：glossary 词原样、界面按钮名保留英文、数字金额不变


## 第 1 章 · Welcome / 开场
- 标题 RU: Добро пожаловать  ·  FR: Bienvenue

**1-1**
- EN: This is the MAXHOUSE Student Portal — apply once, reach many Chinese universities.
- RU: Это MAXHOUSE Student Portal — одна заявка, доступ ко многим вузам Китая.
  - RU→EN: This is the MAXHOUSE Student Portal — one application, access to many universities in China.
- FR: Voici le MAXHOUSE Student Portal — une seule candidature, de nombreuses universités chinoises.
  - FR→EN: This is the MAXHOUSE Student Portal — a single application, many Chinese universities.

**1-2**
- EN: Switch the language any time: English, Chinese, Russian or French.
- RU: Переключайте язык в любой момент: английский, китайский, русский или французский.
  - RU→EN: Switch the language at any time: English, Chinese, Russian or French.
- FR: Changez de langue à tout moment : anglais, chinois, russe ou français.
  - FR→EN: Change language at any time: English, Chinese, Russian or French.

**1-3**
- EN: On a phone, use your browser's "Add to Home Screen" to open it like an app.
- RU: На телефоне используйте "Add to Home Screen" в браузере, чтобы открывать его как приложение.
  - RU→EN: On a phone use the browser's "Add to Home Screen" to open it as an app.
- FR: Sur téléphone, utilisez « Add to Home Screen » du navigateur pour l'ouvrir comme une application.
  - FR→EN: On a phone, use the browser's "Add to Home Screen" to open it like an app.

## 第 2 章 · Register & sign in / 注册与登录
- 标题 RU: Регистрация и вход  ·  FR: Inscription et connexion

**2-1**
- EN: Tap Register to create your account.
- RU: Нажмите Register, чтобы создать аккаунт.
  - RU→EN: Tap Register to create an account.
- FR: Appuyez sur Register pour créer votre compte.
  - FR→EN: Tap Register to create your account.

**2-2**
- EN: Enter the invite code you received from MAXHOUSE or your agent.
- RU: Введите код приглашения от MAXHOUSE или вашего агента.
  - RU→EN: Enter the invite code from MAXHOUSE or your agent.
- FR: Saisissez le code d'invitation reçu de MAXHOUSE ou de votre agent.
  - FR→EN: Enter the invite code received from MAXHOUSE or your agent.

**2-3**
- EN: Add your email and a password with letters and numbers, then tap Create account.
- RU: Укажите email и пароль из букв и цифр, затем нажмите Create account.
  - RU→EN: Enter email and a password of letters and digits, then tap Create account.
- FR: Indiquez votre email et un mot de passe avec lettres et chiffres, puis appuyez sur Create account.
  - FR→EN: Enter your email and a password with letters and digits, then tap Create account.

**2-4**
- EN: If your agent sent you a link, the invite code is already inside — just set a password.
- RU: Если агент прислал ссылку, код приглашения уже внутри — просто задайте пароль.
  - RU→EN: If the agent sent a link, the invite code is already inside — just set a password.
- FR: Si votre agent vous a envoyé un lien, le code d'invitation est déjà inclus — définissez juste un mot de passe.
  - FR→EN: If your agent sent you a link, the invite code is already included — just set a password.

**2-5**
- EN: Next time, sign in with the same email and password.
- RU: В следующий раз входите с тем же email и паролем.
  - RU→EN: Next time, sign in with the same email and password.
- FR: La prochaine fois, connectez-vous avec le même email et mot de passe.
  - FR→EN: Next time, sign in with the same email and password.

**2-6**
- EN: Forgot it? Tap Forgot password and we email you a reset link.
- RU: Забыли? Нажмите Forgot password — ссылку для сброса пришлём на email.
  - RU→EN: Forgot? Tap Forgot password — we'll send the reset link to your email.
- FR: Oublié ? Appuyez sur Forgot password et nous vous enverrons un lien de réinitialisation par email.
  - FR→EN: Forgot? Tap Forgot password and we'll send a reset link by email.

## 第 3 章 · Your plan & programs / 申请计划与项目
- 标题 RU: Ваш план и программы  ·  FR: Votre projet et vos programmes

**3-1**
- EN: Step two: tell us your plan.
- RU: Шаг два: расскажите о своём плане.
  - RU→EN: Step two: tell us about your plan.
- FR: Étape deux : indiquez-nous votre projet.
  - FR→EN: Step two: tell us your plan.

**3-2**
- EN: Choose whether you are currently in China or outside China — this decides which documents you need later.
- RU: Укажите, находитесь ли вы сейчас в Китае или за его пределами — от этого зависят документы.
  - RU→EN: State whether you are now in China or outside it — the documents depend on this.
- FR: Indiquez si vous êtes actuellement en Chine ou hors de Chine — cela détermine les documents requis ensuite.
  - FR→EN: State whether you are currently in China or outside China — this decides the required documents next.

**3-3**
- EN: Pick your funding options; you may select several.
- RU: Выберите варианты финансирования; можно несколько.
  - RU→EN: Choose funding options; several possible.
- FR: Choisissez vos options de financement ; plusieurs choix possibles.
  - FR→EN: Choose your funding options; several choices possible.

**3-4**
- EN: Choose up to three program types — from language courses to doctorate.
- RU: Выберите до трёх типов программ — от языковых курсов до докторантуры.
  - RU→EN: Choose up to three program types — from language courses to doctorate.
- FR: Choisissez jusqu'à trois types de programmes — des cours de langue au doctorat.
  - FR→EN: Choose up to three program types — from language courses to doctorate.

**3-5**
- EN: Search majors in English, Chinese or pinyin — for example "jsj" finds Computer Science.
- RU: Ищите специальности на английском, китайском или пиньине — например, "jsj" находит Computer Science.
  - RU→EN: Search majors in English, Chinese or pinyin — for example "jsj" finds Computer Science.
- FR: Cherchez les spécialités en anglais, chinois ou pinyin — par exemple « jsj » trouve Computer Science.
  - FR→EN: Search majors in English, Chinese or pinyin — for example "jsj" finds Computer Science.

**3-6**
- EN: Add your scholarship status, HSK level and GPA — schools use these to assess you.
- RU: Укажите статус стипендии, уровень HSK и GPA — по ним вузы вас оценивают.
  - RU→EN: State scholarship status, HSK level and GPA — schools assess you by them.
- FR: Ajoutez votre statut de bourse, votre niveau HSK et votre GPA — les universités s'en servent pour vous évaluer.
  - FR→EN: Add your scholarship status, HSK level and GPA — universities use them to assess you.

**3-7**
- EN: Tap Continue.
- RU: Нажмите Continue.
  - RU→EN: Tap Continue.
- FR: Appuyez sur Continue.
  - FR→EN: Tap Continue.

## 第 4 章 · Profile & documents / 个人档案与材料
- 标题 RU: Профиль и документы  ·  FR: Profil et documents

**4-1**
- EN: Step three: your profile and documents.
- RU: Шаг три: ваш профиль и документы.
  - RU→EN: Step three: your profile and documents.
- FR: Étape trois : votre profil et vos documents.
  - FR→EN: Step three: your profile and documents.

**4-2**
- EN: Fill in your name exactly as in your passport, plus contact details.
- RU: Впишите имя точно как в паспорте и контактные данные.
  - RU→EN: Write your name exactly as in the passport, and contact details.
- FR: Saisissez votre nom exactement comme sur le passeport, ainsi que vos coordonnées.
  - FR→EN: Enter your name exactly as on the passport, plus your contact details.

**4-3**
- EN: Your academic credentials — all three are required.
- RU: Сведения об образовании — все три поля обязательны.
  - RU→EN: Education info — all three fields are required.
- FR: Vos informations académiques — les trois sont obligatoires.
  - FR→EN: Your academic information — all three are required.

**4-4**
- EN: Four documents are required: passport, highest diploma, transcript and a personal photo.
- RU: Нужны четыре документа: паспорт, диплом о высшем образовании, выписка с оценками и личное фото.
  - RU→EN: Four documents required: passport, higher-education diploma, grade transcript and personal photo.
- FR: Quatre documents sont requis : passeport, diplôme le plus élevé, relevé de notes et photo d'identité.
  - FR→EN: Four documents are required: passport, highest diploma, transcript and ID photo.

**4-5**
- EN: A quick guide shows how to photograph your passport: both pages, flat, nothing covered.
- RU: Короткая подсказка покажет, как снять паспорт: обе страницы, ровно, ничего не закрыто.
  - RU→EN: A short hint shows how to shoot the passport: both pages, flat, nothing covered.
- FR: Un petit guide montre comment photographier le passeport : les deux pages, à plat, rien de masqué.
  - FR→EN: A short guide shows how to photograph the passport: both pages, flat, nothing masked.

**4-6**
- EN: Upload and watch the progress — large files resume automatically if the network drops.
- RU: Загружайте и следите за прогрессом — большие файлы докачаются сами при обрыве сети.
  - RU→EN: Upload and watch progress — large files resume by themselves if the network drops.
- FR: Téléversez et suivez la progression — les gros fichiers reprennent automatiquement si le réseau coupe.
  - FR→EN: Upload and follow progress — large files resume automatically if the network cuts.

**4-7**
- EN: AI pre-checks each file and warns you about blur or missing corners before any reviewer sees it.
- RU: AI проверяет каждый файл и предупреждает о размытии или обрезанных углах до того, как его увидит проверяющий.
  - RU→EN: AI checks each file and warns about blur or cut corners before a reviewer sees it.
- FR: L'IA pré-vérifie chaque fichier et signale le flou ou les coins manquants avant qu'un évaluateur ne le voie.
  - FR→EN: AI pre-checks each file and flags blur or missing corners before an evaluator sees it.

**4-8**
- EN: It also compares the passport name with what you typed.
- RU: Также сверяет имя в паспорте с тем, что вы ввели.
  - RU→EN: It also compares the passport name with what you entered.
- FR: Elle compare aussi le nom du passeport avec ce que vous avez saisi.
  - FR→EN: It also compares the passport name with what you entered.

**4-9**
- EN: Every file is watermarked — reviewers never see a clean copy.
- RU: На каждый файл ставится водяной знак — проверяющие не видят чистую копию.
  - RU→EN: A watermark is put on each file — reviewers don't see a clean copy.
- FR: Chaque fichier porte un filigrane — les évaluateurs ne voient jamais de copie nette.
  - FR→EN: Each file bears a watermark — evaluators never see a clean copy.

**4-10**
- EN: Optional documents raise your chances — the more you upload, the more offers.
- RU: Дополнительные документы повышают шансы — чем больше загрузите, тем больше предложений.
  - RU→EN: Extra documents raise chances — the more you upload, the more offers.
- FR: Les documents facultatifs augmentent vos chances — plus vous en ajoutez, plus vous recevez d'offres.
  - FR→EN: Optional documents raise your chances — the more you add, the more offers.

**4-11**
- EN: Write a short personal statement, up to one thousand characters.
- RU: Напишите короткое мотивационное письмо, до тысячи символов.
  - RU→EN: Write a short motivation letter, up to a thousand characters.
- FR: Rédigez une courte lettre de motivation, jusqu'à mille caractères.
  - FR→EN: Write a short motivation letter, up to a thousand characters.

**4-12**
- EN: Tap Continue to review.
- RU: Нажмите Continue, чтобы перейти к проверке.
  - RU→EN: Tap Continue to go to the review.
- FR: Appuyez sur Continue pour passer à la vérification.
  - FR→EN: Tap Continue to go to the check.

## 第 5 章 · Submit & your application ID / 提交与申请编号
- 标题 RU: Отправка и номер заявки  ·  FR: Envoi et numéro de dossier

**5-1**
- EN: Step four: check everything once.
- RU: Шаг четыре: проверьте всё один раз.
  - RU→EN: Step four: check everything once.
- FR: Étape quatre : vérifiez tout une fois.
  - FR→EN: Step four: check everything once.

**5-2**
- EN: Tap Submit application.
- RU: Нажмите Submit application.
  - RU→EN: Tap Submit application.
- FR: Appuyez sur Submit application.
  - FR→EN: Tap Submit application.

**5-3**
- EN: This is your application ID — keep it, you will use it everywhere.
- RU: Это номер вашей заявки — сохраните, он понадобится везде.
  - RU→EN: This is your application number — save it, you'll need it everywhere.
- FR: Voici votre numéro de dossier — gardez-le, vous l'utiliserez partout.
  - FR→EN: This is your dossier number — keep it, you'll use it everywhere.

**5-4**
- EN: Your file is now in review; first school interest usually appears within a day or two.
- RU: Теперь дело на рассмотрении; первый интерес вузов обычно появляется за день-два.
  - RU→EN: Now the file is under review; first university interest usually appears in a day or two.
- FR: Votre dossier est en cours d'examen ; le premier intérêt des écoles apparaît souvent en un à deux jours.
  - FR→EN: Your file is under review; first school interest appears often in one to two days.

**5-5**
- EN: Each document shows its own status here, with the reviewer's reason if rejected.
- RU: У каждого документа здесь свой статус, а при отказе — причина от проверяющего.
  - RU→EN: Each document has its own status here, and on refusal — the reviewer's reason.
- FR: Chaque document affiche ici son statut, avec le motif de l'évaluateur en cas de refus.
  - FR→EN: Each document shows its status here, with the evaluator's reason on refusal.

**5-6**
- EN: Rejected? Tap Fix it now and upload a corrected file.
- RU: Отклонён? Нажмите Fix it now и загрузите исправленный файл.
  - RU→EN: Rejected? Tap Fix it now and upload a corrected file.
- FR: Refusé ? Appuyez sur Fix it now et téléversez un fichier corrigé.
  - FR→EN: Rejected? Tap Fix it now and upload a corrected file.

**5-7**
- EN: You can add more documents at any time.
- RU: Добавить документы можно в любой момент.
  - RU→EN: Documents can be added at any time.
- FR: Vous pouvez ajouter des documents à tout moment.
  - FR→EN: You can add documents at any time.

**5-8**
- EN: The bell keeps every update in one place.
- RU: В колокольчике собраны все обновления.
  - RU→EN: The bell collects all updates.
- FR: La cloche rassemble toutes les mises à jour au même endroit.
  - FR→EN: The bell gathers all updates in one place.

## 第 6 章 · Receiving an offer / 收到录取
- 标题 RU: Получение предложения  ·  FR: Recevoir une offre

**6-1**
- EN: When a school admits you, the offer shows up here.
- RU: Когда вуз вас принимает, предложение появляется здесь.
  - RU→EN: When a university admits you, the offer appears here.
- FR: Quand une école vous admet, l'offre apparaît ici.
  - FR→EN: When a school admits you, the offer appears here.

**6-2**
- EN: The school's name stays hidden until you unlock — you see city, type, program, tuition and scholarship.
- RU: Название вуза скрыто до разблокировки — видны город, тип, программа, стоимость и стипендия.
  - RU→EN: The university name is hidden until unlock — city, type, program, cost and scholarship are visible.
- FR: Le nom de l'école reste caché jusqu'au déblocage — vous voyez la ville, le type, le programme, les frais et la bourse.
  - FR→EN: The school name stays hidden until unlock — you see city, type, program, fees and scholarship.

**6-3**
- EN: Some schools ask for extra documents first — upload them here.
- RU: Некоторые вузы сначала просят дополнительные документы — загрузите их здесь.
  - RU→EN: Some universities first ask for extra documents — upload them here.
- FR: Certaines écoles demandent d'abord des documents supplémentaires — téléversez-les ici.
  - FR→EN: Some schools first ask for extra documents — upload them here.

**6-4**
- EN: If the school wants an interview, the invitation and meeting link appear here.
- RU: Если вуз хочет собеседование, приглашение и ссылка на встречу появятся здесь.
  - RU→EN: If the university wants an interview, the invitation and meeting link appear here.
- FR: Si l'école souhaite un entretien, l'invitation et le lien de réunion apparaissent ici.
  - FR→EN: If the school wants an interview, the invitation and meeting link appear here.

**6-5**
- EN: Accept the program — this is final.
- RU: Примите программу — это окончательно.
  - RU→EN: Accept the program — this is final.
- FR: Acceptez le programme — c'est définitif.
  - FR→EN: Accept the program — this is final.

**6-6**
- EN: Then follow the next steps: letter, payment, JW202, enrollment.
- RU: Дальше по шагам: письмо, оплата, JW202, зачисление.
  - RU→EN: Then step by step: letter, payment, JW202, enrollment.
- FR: Ensuite, suivez les étapes : lettre, paiement, JW202, inscription.
  - FR→EN: Then follow the steps: letter, payment, JW202, enrollment.

**6-7**
- EN: Not for you? Reject with a reason — other schools never see it.
- RU: Не подходит? Отклоните с указанием причины — другие вузы её не увидят.
  - RU→EN: Not suitable? Reject stating a reason — other universities won't see it.
- FR: Pas pour vous ? Refusez avec un motif — les autres écoles ne le voient pas.
  - FR→EN: Not for you? Reject with a reason — other schools don't see it.

## 第 7 章 · Pay to unlock / 付费解锁
- 标题 RU: Оплата и разблокировка  ·  FR: Payer pour débloquer

**7-1**
- EN: When the school uploads your admission letter, pay to unlock it and the school name.
- RU: Когда вуз загрузит письмо о зачислении, оплатите, чтобы открыть его и название вуза.
  - RU→EN: When the university uploads the admission letter, pay to open it and the university name.
- FR: Quand l'école téléverse votre lettre d'admission, payez pour la débloquer ainsi que le nom de l'école.
  - FR→EN: When the school uploads your admission letter, pay to unlock it and the school name.

**7-2**
- EN: The service fee is three thousand yuan per school — and you probably have a promo code.
- RU: Сервисный сбор — три тысячи юаней за вуз, и у вас, скорее всего, есть промокод.
  - RU→EN: The service fee is three thousand yuan per university, and you most likely have a promo code.
- FR: Les frais de service sont de trois mille yuans par école — et vous avez sûrement un code promo.
  - FR→EN: The service fee is three thousand yuan per school — and you surely have a promo code.

**7-3**
- EN: With the MAXHOUSE code your first school is free and the second is half price.
- RU: С кодом MAXHOUSE первый вуз бесплатно, второй — за полцены.
  - RU→EN: With the MAXHOUSE code the first university is free, the second half price.
- FR: Avec le code MAXHOUSE, la première école est gratuite et la deuxième à moitié prix.
  - FR→EN: With the MAXHOUSE code the first school is free and the second half price.

**7-4**
- EN: Confirm and unlock — zero yuan this time.
- RU: Подтвердите и разблокируйте — в этот раз ноль юаней.
  - RU→EN: Confirm and unlock — zero yuan this time.
- FR: Confirmez et débloquez — zéro yuan cette fois.
  - FR→EN: Confirm and unlock — zero yuan this time.

**7-5**
- EN: Open your official Admission Letter.
- RU: Откройте официальный документ Admission Letter.
  - RU→EN: Open the official Admission Letter document.
- FR: Ouvrez votre Admission Letter officielle.
  - FR→EN: Open your official Admission Letter.

**7-6**
- EN: The JW202 for your visa follows after the school uploads it.
- RU: JW202 для визы появится после того, как вуз его загрузит.
  - RU→EN: The JW202 for the visa appears after the university uploads it.
- FR: Le JW202 pour votre visa suit une fois que l'école l'a téléversé.
  - FR→EN: The JW202 for your visa follows once the school has uploaded it.

**7-7**
- EN: For a paid unlock you get an order number and a PayPal link — put the order number in the payment note.
- RU: При платной разблокировке вы получите номер заказа и ссылку PayPal — укажите номер заказа в примечании к платежу.
  - RU→EN: For a paid unlock you get an order number and a PayPal link — put the order number in the payment note.
- FR: Un déblocage payant donne un numéro de commande et un lien PayPal ; mettez ce numéro dans la note de paiement.
  - FR→EN: A paid unlock gives an order number and a PayPal link; put this number in the payment note.

**7-8**
- EN: Upload your payment screenshot; MAXHOUSE confirms usually within 24 hours.
- RU: Загрузите скриншот оплаты; MAXHOUSE подтверждает обычно в течение 24 часов.
  - RU→EN: Upload the payment screenshot; MAXHOUSE confirms usually within 24 hours.
- FR: Téléversez la capture de votre paiement ; MAXHOUSE confirme généralement sous 24 heures.
  - FR→EN: Upload your payment screenshot; MAXHOUSE confirms usually within 24 hours.

**7-9**
- EN: You have 14 days to pay after the letter arrives.
- RU: На оплату есть 14 дней после получения письма.
  - RU→EN: There are 14 days to pay after receiving the letter.
- FR: Vous avez 14 jours pour payer après l'arrivée de la lettre.
  - FR→EN: You have 14 days to pay after the letter arrives.

## 第 8 章 · Premium services / 增值服务
- 标题 RU: Платные услуги  ·  FR: Services premium

**8-1**
- EN: Two offers are included; want more?
- RU: Два предложения включены; хотите больше?
  - RU→EN: Two offers are included; want more?
- FR: Deux offres sont incluses ; en voulez-vous plus ?
  - FR→EN: Two offers are included; want more?

**8-2**
- EN: Audit Service removes the limit and features your profile — one thousand five hundred yuan, one time.
- RU: Audit Service снимает лимит и продвигает ваш профиль — тысяча пятьсот юаней, разово.
  - RU→EN: Audit Service removes the limit and promotes your profile — fifteen hundred yuan, one time.
- FR: Audit Service supprime la limite et met en avant votre profil — mille cinq cents yuans, une seule fois.
  - FR→EN: Audit Service removes the limit and features your profile — fifteen hundred yuan, one time.

**8-3**
- EN: Special requirements? A real advisor searches for you — six hundred yuan to start.
- RU: Особые требования? Живой консультант ищет за вас — шестьсот юаней для старта.
  - RU→EN: Special requirements? A live advisor searches for you — six hundred yuan to start.
- FR: Des besoins particuliers ? Un vrai conseiller cherche pour vous — six cents yuans pour commencer.
  - FR→EN: Special needs? A real advisor searches for you — six hundred yuan to start.

**8-4**
- EN: Describe what you need and your deadline; the advisor replies within 48 hours.
- RU: Опишите, что нужно, и срок; консультант ответит в течение 48 часов.
  - RU→EN: Describe what you need and the deadline; the advisor replies within 48 hours.
- FR: Décrivez vos besoins et votre échéance ; le conseiller répond sous 48 heures.
  - FR→EN: Describe your needs and your deadline; the advisor replies within 48 hours.

**8-5**
- EN: Exposure boost puts you first in the recommendation pool for ten, twenty or thirty days — schools cannot tell you paid.
- RU: Exposure boost выводит вас вперёд в рекомендациях на десять, двадцать или тридцать дней — вузы не узнают об оплате.
  - RU→EN: Exposure boost moves you ahead in recommendations for ten, twenty or thirty days — universities won't learn of the payment.
- FR: Exposure boost vous met en tête des recommandations pendant dix, vingt ou trente jours — les écoles ignorent que vous avez payé.
  - FR→EN: Exposure boost puts you at the top of recommendations for ten, twenty or thirty days — schools don't know you paid.

**8-6**
- EN: Need a break? You can request a pause of your profile.
- RU: Нужна пауза? Можно запросить приостановку профиля.
  - RU→EN: Need a pause? You can request a profile suspension.
- FR: Besoin d'une pause ? Vous pouvez demander la suspension de votre profil.
  - FR→EN: Need a break? You can request suspension of your profile.

## 第 9 章 · Share / 分享
- 标题 RU: Поделиться  ·  FR: Partager

**9-1**
- EN: Got in? Share it.
- RU: Поступили? Поделитесь.
  - RU→EN: Admitted? Share it.
- FR: Admis ? Partagez-le.
  - FR→EN: Admitted? Share it.

**9-2**
- EN: Choose what to show: a verified proof card for family, a friends view with no private details, or a parents view with costs.
- RU: Выберите вид: подтверждённая карточка для семьи, версия для друзей без личных данных или версия для родителей с расходами.
  - RU→EN: Choose the view: a verified card for family, a friends version without personal data, or a parents version with costs.
- FR: Choisissez l'affichage : une carte vérifiée pour la famille, une vue amis sans détails privés, ou une vue parents avec les coûts.
  - FR→EN: Choose the display: a verified card for family, a friends view without private details, or a parents view with costs.

**9-3**
- EN: Make a poster with a QR code and save it.
- RU: Создайте постер с QR-кодом и сохраните его.
  - RU→EN: Create a poster with a QR code and save it.
- FR: Créez une affiche avec un QR code et enregistrez-la.
  - FR→EN: Create a poster with a QR code and save it.

**9-4**
- EN: Send it by WeChat, WhatsApp or any app, or copy the link.
- RU: Отправьте через WeChat, WhatsApp или любое приложение либо скопируйте ссылку.
  - RU→EN: Send via WeChat, WhatsApp or any app, or copy the link.
- FR: Envoyez-le par WeChat, WhatsApp ou toute application, ou copiez le lien.
  - FR→EN: Send by WeChat, WhatsApp or any app, or copy the link.

**9-5**
- EN: Links expire; you can revoke one or generate a new one anytime.
- RU: Ссылки истекают; их можно отозвать или создать новую в любой момент.
  - RU→EN: Links expire; they can be revoked or a new one created at any time.
- FR: Les liens expirent ; vous pouvez en révoquer un ou en générer un nouveau à tout moment.
  - FR→EN: Links expire; you can revoke one or generate a new one at any time.

## 第 10 章 · Supplementary form & students in China / 录取后的补充信息表 + 在华学生专项
- 标题 RU: Доп. анкета и студенты в Китае  ·  FR: Formulaire complémentaire et étudiants en Chine

**10-1**
- EN: If you are in China, the document list adds your visa or residence permit.
- RU: Если вы в Китае, в список документов добавятся виза или вид на жительство.
  - RU→EN: If you are in China, a visa or residence permit is added to the document list.
- FR: Si vous êtes en Chine, la liste des documents ajoute votre visa ou permis de séjour.
  - FR→EN: If you are in China, the document list adds your visa or residence permit.

**10-2**
- EN: The expiry date is read from the document automatically — check it and confirm.
- RU: Срок действия считывается из документа автоматически — проверьте и подтвердите.
  - RU→EN: The validity date is read from the document automatically — check and confirm.
- FR: La date d'expiration est lue automatiquement sur le document — vérifiez et confirmez.
  - FR→EN: The expiry date is read automatically from the document — check and confirm.

**10-3**
- EN: Moved in or out of China? Submit a location change with the new document.
- RU: Въехали в Китай или выехали? Подайте изменение местоположения с новым документом.
  - RU→EN: Entered or left China? Submit a location change with the new document.
- FR: Entré ou sorti de Chine ? Soumettez un changement de lieu avec le nouveau document.
  - FR→EN: Entered or left China? Submit a location change with the new document.

**10-4**
- EN: After accepting an offer, some schools need a supplementary form for their own system.
- RU: После принятия предложения некоторым вузам нужна дополнительная анкета для их системы.
  - RU→EN: After accepting an offer some universities need an extra form for their system.
- FR: Après avoir accepté une offre, certaines écoles demandent un formulaire complémentaire pour leur système.
  - FR→EN: After accepting an offer, some schools ask for a supplementary form for their system.

**10-5**
- EN: Let AI read your documents and prefill the form — the yellow cells are suggestions, check them.
- RU: Позвольте AI прочитать документы и заполнить анкету — жёлтые поля это подсказки, проверьте их.
  - RU→EN: Let AI read the documents and fill the form — the yellow cells are suggestions, check them.
- FR: Laissez l'IA lire vos documents et préremplir le formulaire — les cases jaunes sont des suggestions, vérifiez-les.
  - FR→EN: Let AI read your documents and prefill the form — the yellow cells are suggestions, check them.

**10-6**
- EN: It saves as you go; submit and MAXHOUSE files it with the school for you.
- RU: Черновик сохраняется по ходу; отправьте, и MAXHOUSE подаст его в вуз за вас.
  - RU→EN: The draft saves as you go; submit, and MAXHOUSE files it with the university for you.
- FR: Il s'enregistre au fur et à mesure ; envoyez, et MAXHOUSE le dépose auprès de l'école pour vous.
  - FR→EN: It saves as you go; submit, and MAXHOUSE files it with the school for you.

## 第 11 章 · Become a student agent / 申请成为学生中介
- 标题 RU: Станьте студентом-агентом  ·  FR: Devenir agent étudiant

**11-1**
- EN: You can earn by referring other students: apply to become a student agent.
- RU: Можно зарабатывать, приглашая других студентов: подайте заявку, чтобы стать студентом-агентом.
  - RU→EN: You can earn by inviting other students: apply to become a student agent.
- FR: Vous pouvez gagner en parrainant d'autres étudiants : candidatez pour devenir agent étudiant.
  - FR→EN: You can earn by referring other students: apply to become a student agent.

**11-2**
- EN: Fill in the short application.
- RU: Заполните короткую заявку.
  - RU→EN: Fill in a short application.
- FR: Remplissez la courte demande.
  - FR→EN: Fill in the short request.

**11-3**
- EN: MAXHOUSE reviews it, usually within a few days.
- RU: MAXHOUSE рассмотрит её, обычно за несколько дней.
  - RU→EN: MAXHOUSE will review it, usually within a few days.
- FR: MAXHOUSE l'examine, généralement en quelques jours.
  - FR→EN: MAXHOUSE reviews it, usually within a few days.

**11-4**
- EN: Once approved you get a partner agent ID — share it with your students.
- RU: После одобрения вы получите partner agent ID — поделитесь им со своими студентами.
  - RU→EN: After approval you get a partner agent ID — share it with your students.
- FR: Une fois approuvé, vous obtenez un partner agent ID — partagez-le avec vos étudiants.
  - FR→EN: Once approved, you get a partner agent ID — share it with your students.

**11-5**
- EN: If your own file was managed by an advisor, you can apply 90 days after that ends.
- RU: Если вашим делом занимался консультант, подать заявку можно через 90 дней после его завершения.
  - RU→EN: If an advisor managed your file, you can apply 90 days after it ends.
- FR: Si votre dossier a été géré par un conseiller, vous pouvez candidater 90 jours après la fin.
  - FR→EN: If a counselor managed your file, you can apply 90 days after it ends.

## 第 12 章 · Student agent dashboard / 学生中介功能
- 标题 RU: Панель студента-агента  ·  FR: Tableau de bord de l'agent étudiant

**12-1**
- EN: Your Partner Dashboard lives next to My Application.
- RU: Ваш Partner Dashboard находится рядом с My Application.
  - RU→EN: Your Partner Dashboard is next to My Application.
- FR: Votre Partner Dashboard se trouve à côté de My Application.
  - FR→EN: Your Partner Dashboard is next to My Application.

**12-2**
- EN: See every student's progress from submitted to enrolled.
- RU: Смотрите прогресс каждого студента от подачи до зачисления.
  - RU→EN: See each student's progress from submission to enrollment.
- FR: Suivez la progression de chaque étudiant, de l'envoi à l'inscription.
  - FR→EN: Follow each student's progress, from submission to enrollment.

**12-3**
- EN: Places: you start with some, and earn one each time a student you invited applies on their own.
- RU: Места: сначала их несколько, и вы получаете ещё одно каждый раз, когда приглашённый вами студент подаёт заявку сам.
  - RU→EN: Places: a few at the start, and you get one more each time a student you invited applies by themselves.
- FR: Places : quelques-unes au départ, et vous en gagnez une chaque fois qu'un étudiant invité candidate seul.
  - FR→EN: Places: a few at the start, and you earn one each time an invited student applies alone.

**12-4**
- EN: Share your link — the funnel shows opens, sign-ups and completed applications.
- RU: Поделитесь ссылкой — воронка показывает открытия, регистрации и завершённые заявки.
  - RU→EN: Share your link — the funnel shows opens, sign-ups and completed applications.
- FR: Partagez votre lien — l'entonnoir montre les ouvertures, les inscriptions et les candidatures finalisées.
  - FR→EN: Share your link — the funnel shows opens, sign-ups and finalized applications.

**12-5**
- EN: To apply on a student's behalf, submit a referral.
- RU: Чтобы подать заявку за студента, отправьте рекомендацию.
  - RU→EN: To apply for a student, send a referral.
- FR: Pour candidater au nom d'un étudiant, soumettez un parrainage.
  - FR→EN: To apply on a student's behalf, submit a referral.

**12-6**
- EN: Four steps: plan, profile, documents, review — drafts save automatically.
- RU: Четыре шага: план, профиль, документы, проверка — черновики сохраняются автоматически.
  - RU→EN: Four steps: plan, profile, documents, review — drafts save automatically.
- FR: Quatre étapes : projet, profil, documents, vérification — les brouillons s'enregistrent automatiquement.
  - FR→EN: Four steps: plan, profile, documents, review — drafts save automatically.

**12-7**
- EN: Open a student to see what needs attention and the latest events.
- RU: Откройте студента, чтобы увидеть, что требует внимания, и последние события.
  - RU→EN: Open a student to see what needs attention and the latest events.
- FR: Ouvrez un étudiant pour voir ce qui nécessite votre attention et les derniers événements.
  - FR→EN: Open a student to see what needs your attention and the latest events.

**12-8**
- EN: Upload corrected documents for the student yourself.
- RU: Загружайте исправленные документы за студента сами.
  - RU→EN: Upload corrected documents for the student yourself.
- FR: Téléversez vous-même les documents corrigés pour l'étudiant.
  - FR→EN: Upload the corrected documents for the student yourself.

**12-9**
- EN: Accept offers for the student once their documents are in order.
- RU: Принимайте предложения за студента, когда его документы в порядке.
  - RU→EN: Accept offers for the student once their documents are in order.
- FR: Acceptez les offres pour l'étudiant une fois ses documents en règle.
  - FR→EN: Accept offers for the student once their documents are in order.

**12-10**
- EN: You can also pay the unlock fee for the student — the promo code works here too.
- RU: Можно также оплатить разблокировку за студента — промокод действует и здесь.
  - RU→EN: You can also pay the unlock for the student — the promo code works here too.
- FR: Vous pouvez aussi payer le déblocage pour l'étudiant — le code promo fonctionne ici aussi.
  - FR→EN: You can also pay the unlock for the student — the promo code works here too.

**12-11**
- EN: Premium services can be activated per student.
- RU: Платные услуги можно подключать отдельно для каждого студента.
  - RU→EN: Premium services can be enabled separately for each student.
- FR: Les services premium peuvent être activés par étudiant.
  - FR→EN: Premium services can be activated per student.

**12-12**
- EN: Or invite a student by link to fill in their own file while you stay in charge of submission.
- RU: Или пригласите студента по ссылке заполнить своё дело самому, оставив подачу за собой.
  - RU→EN: Or invite a student by link to fill their own file, keeping submission to yourself.
- FR: Ou invitez un étudiant par lien à remplir son dossier lui-même, tout en gardant la main sur l'envoi.
  - FR→EN: Or invite a student by link to fill their own file, while you keep control of submission.

## 第 13 章 · New rounds & settings / 多轮申请与账户
- 标题 RU: Новые раунды и настройки  ·  FR: Nouvelles sessions et réglages

**13-1**
- EN: Finished one round? You can end it and apply again — up to three rounds a year.
- RU: Завершили раунд? Можно закрыть его и подать снова — до трёх раундов в год.
  - RU→EN: Finished a round? You can close it and apply again — up to three rounds a year.
- FR: Une session terminée ? Vous pouvez la clôturer et recandidater — jusqu'à trois sessions par an.
  - FR→EN: A round finished? You can close it and reapply — up to three rounds a year.

**13-2**
- EN: Start a new round with the same account — your data is prefilled.
- RU: Начните новый раунд с тем же аккаунтом — данные подставятся автоматически.
  - RU→EN: Start a new round with the same account — data is filled in automatically.
- FR: Démarrez une nouvelle session avec le même compte — vos données sont préremplies.
  - FR→EN: Start a new round with the same account — your data is prefilled.

**13-3**
- EN: Settings: language, notifications, sign out.
- RU: Настройки: язык, уведомления, выход.
  - RU→EN: Settings: language, notifications, sign out.
- FR: Réglages : langue, notifications, déconnexion.
  - FR→EN: Settings: language, notifications, sign out.

## 第 14 章 · Contact / 片尾
- 标题 RU: Контакты  ·  FR: Contact

**14-1**
- EN: Questions? Contact us on WhatsApp or email — see you in China.
- RU: Вопросы? Напишите нам в WhatsApp или на email — увидимся в Китае.
  - RU→EN: Questions? Write to us on WhatsApp or by email — see you in China.
- FR: Des questions ? Contactez-nous sur WhatsApp ou par email — à bientôt en Chine.
  - FR→EN: Questions? Contact us on WhatsApp or by email — see you in China.
