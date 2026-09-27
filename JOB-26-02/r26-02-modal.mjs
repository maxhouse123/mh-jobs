import { serve, launch, newPage, stub } from '/Volumes/Dev/MAXHOUSE/jobs/JOB-16-00/lib/realpage.mjs';
const { origin, close } = await serve();
const { browser } = await launch('chromium');
const { page, ctx } = await newPage(browser, origin);
await stub(page, {});
await page.goto(origin + '/school-portal/maxhouse-school-portal-v238.html', { waitUntil: 'domcontentloaded' });
await page.waitForFunction(() => typeof autoMatchStudentsCloud === 'function' && typeof state !== 'undefined', null, { timeout: 30000 });
const out = await page.evaluate(async () => {
  state.admissionTasks = [{ code:'ZZ-LANG', programLevel:'lang', criteria:{ageMin:'18',ageMax:'60'}, majors:[], title:'汉语言项目' }];
  window._schoolAuthUid = async () => 'u1';
  const stubRow = { student_id:'s1', surname:'W', given_name:'Zhang', nationality:'US', age:26, gender:'F', major:'', target_program:'master', target_programs:[{value:'master',majors:['CS']},{value:'chinese_lang',majors:[]}], gpa:3.5, hsk:'5', csca:'B', in_china:true, in_pool:false };
  window.sb.rpc = async (fn) => (fn==='search_students_blind' ? {data:[stubRow], error:null} : {data:[], error:null});
  await window.autoMatchStudentsCloud('ZZ-LANG');
  const html = document.body.innerHTML;
  return { htmlHasZhang: html.indexOf('Zhang')>=0, htmlHasLangLabel: html.indexOf('汉语言')>=0, htmlLen: html.length };
});
console.log(JSON.stringify(out));
console.log('pageerrors', JSON.stringify(page._mhErrors));
await ctx.close(); await browser.close(); await close();
