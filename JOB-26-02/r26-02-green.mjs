import { serve, launch, newPage, stub } from '/Volumes/Dev/MAXHOUSE/jobs/JOB-16-00/lib/realpage.mjs';
const FILE = '/school-portal/maxhouse-school-portal-v238.html';
const { origin, close } = await serve();
const { browser } = await launch('chromium');
const { page } = await newPage(browser, origin);
await stub(page, {});
await page.goto(origin + FILE, { waitUntil: 'domcontentloaded' });
await page.waitForFunction(() => typeof window.calculateStudentMatchScore === 'function' && typeof window._v238LevelIs === 'function', null, { timeout: 30000 });
const res = await page.evaluate(() => {
  const A = { targetProgram:'master', targetPrograms:[{value:'master',majors:['CS','BA','IT']},{value:'chinese_lang',majors:[]}], age:26 };
  const B = { targetProgram:'short_term', targetPrograms:[{value:'short_term',majors:[]}], age:22 };
  const C = { targetProgram:'master', targetPrograms:[{value:'master',majors:['CS']}], age:28 };
  const s = window.calculateStudentMatchScore;
  const lang={programLevel:'lang',criteria:{ageMin:'18',ageMax:'60'}}, exch={programLevel:'exchange',criteria:{ageMin:'18',ageMax:'60'}}, doc={programLevel:'doctor',criteria:{ageMin:'18',ageMax:'60'}}, mast={programLevel:'master',criteria:{ageMin:'18',ageMax:'60'}};
  return {
    // R1 转绿
    langVsChineseLang: s(A, lang) ? 'matched' : null,   // expect matched
    exchVsShortTerm:   s(B, exch) ? 'matched' : null,   // expect matched
    mastVsMaster:      s(C, mast) ? 'matched' : null,   // expect matched (control)
    docVsMaster:       s(C, doc)  ? 'matched' : null,   // expect null (negative)
    // 单元: _v238LevelIs
    is_cl_lang: window._v238LevelIs('chinese_lang','lang'),   // true
    is_lang_cl: window._v238LevelIs('lang','chinese_lang'),   // true
    is_st_exch: window._v238LevelIs('short_term','exchange'), // true
    is_master_lang: window._v238LevelIs('master','lang'),     // false
    is_doctor_master: window._v238LevelIs('doctor','master'), // false
    is_master_master: window._v238LevelIs('master','master'), // true
    aliases_lang: window._v238LevelAliases('lang'),
    aliases_master: window._v238LevelAliases('master'),
    aliases_null: window._v238LevelAliases(null),
    // 标签不显裸键
    label_lang: window._v236LevelLabel ? window._v236LevelLabel('lang') : '(nofn)',
    label_chinese_lang: window._v236LevelLabel ? window._v236LevelLabel('chinese_lang') : '(nofn)',
    label_short_term: window._v236LevelLabel ? window._v236LevelLabel('short_term') : '(nofn)',
  };
});
console.log(JSON.stringify(res,null,1));
console.log('pageerrors', JSON.stringify(page._mhErrors));
await browser.close(); await close();
