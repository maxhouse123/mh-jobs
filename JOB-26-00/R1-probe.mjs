import { serve, launch, newPage, stub } from '/Volumes/Dev/MAXHOUSE/jobs/JOB-16-00/lib/realpage.mjs';
const FILE = '/school-portal/maxhouse-school-portal-v237.html';
const { origin, close } = await serve();
const { browser } = await launch('chromium');
const { page } = await newPage(browser, origin);
await stub(page, {});
await page.goto(origin + FILE, { waitUntil: 'domcontentloaded' });
await page.waitForFunction(() => typeof window.calculateStudentMatchScore === 'function', null, { timeout: 30000 });
const res = await page.evaluate(() => {
  const A = { targetProgram:'master', targetPrograms:[{value:'master',majors:['CS','BA','IT']},{value:'chinese_lang',majors:[]}], age:26 };
  const B = { targetProgram:'short_term', targetPrograms:[{value:'short_term',majors:[]}], age:22 };
  const C = { targetProgram:'master', targetPrograms:[{value:'master',majors:['CS']}], age:28 };
  const langTask = { programLevel:'lang', criteria:{ageMin:'18',ageMax:'60'} };
  const exchTask = { programLevel:'exchange', criteria:{ageMin:'18',ageMax:'60'} };
  const mastTask = { programLevel:'master', criteria:{ageMin:'18',ageMax:'60'} };
  const s = window.calculateStudentMatchScore;
  return {
    langVsChineseLang: s(A, langTask),      // expect null (RED)
    exchVsShortTerm:   s(B, exchTask),      // expect null (RED)
    mastVsMaster:      s(C, mastTask) ? 'matched' : null,  // expect matched (control GREEN)
  };
});
console.log('R1 RESULT', JSON.stringify(res));
console.log('pageerrors', JSON.stringify(page._mhErrors));
await browser.close(); await close();
