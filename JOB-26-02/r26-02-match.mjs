import { serve, launch, newPage, stub } from '/Volumes/Dev/MAXHOUSE/jobs/JOB-16-00/lib/realpage.mjs';
const FILE = '/school-portal/maxhouse-school-portal-v238.html';
const { origin, close } = await serve();
const { browser } = await launch('chromium');

async function run(lang){
  const { page, ctx } = await newPage(browser, origin);
  await stub(page, {});
  await page.goto(origin + FILE, { waitUntil: 'domcontentloaded' });
  await page.waitForFunction(() => typeof autoMatchStudentsCloud === 'function' && typeof state !== 'undefined', null, { timeout: 30000 });
  await page.evaluate(l => { if(typeof setLang==='function') setLang(l); }, lang);
  const out = await page.evaluate(async () => {
    state.admissionTasks = [{ code:'ZZ-LANG', programLevel:'lang', criteria:{ageMin:'18',ageMax:'60'}, majors:[], title:'汉语言项目' }];
    window._schoolAuthUid = async () => 'aaaaaaaa-0000-0000-0000-000000000001';
    const stubRow = { student_id:'s1', surname:'W', given_name:'Zhang', nationality:'US', age:26, gender:'F',
      major:'', target_program:'master',
      target_programs:[{value:'master',majors:['CS','BA','IT']},{value:'chinese_lang',majors:[]}],
      gpa:3.5, hsk:'5', csca:'B', in_china:true, in_pool:false };
    window.sb.rpc = async (fn) => (fn==='search_students_blind' ? {data:[stubRow], error:null} : {data:[], error:null});
    await window.autoMatchStudentsCloud('ZZ-LANG');
    const bodyTxt = document.body.innerText || '';
    return {
      curLang: (typeof currentLang!=='undefined'? currentLang : '?'),
      matchCount: (state._matchCloudMatches||[]).length,
      matchedIds: (state._matchCloudMatches||[]).map(m=>m.student && m.student.id),
      modalHasZhang: bodyTxt.indexOf('Zhang') >= 0,
      modalHasLangLabel: bodyTxt.indexOf('汉语言') >= 0 || bodyTxt.indexOf('Chinese Language') >= 0,
      langLabel: window._v236LevelLabel('lang'),
      chips: window._v236CardChips({targetProgram:'master', targetPrograms:[{value:'master',majors:['CS']},{value:'chinese_lang',majors:[]}]}),
      hasBareKey: /prog\.(lang|master|associate|bachelor|doctor|exchange)/.test(bodyTxt),
    };
  });
  out.pageerrors = page._mhErrors; out.lang = lang;
  await ctx.close();
  return out;
}
console.log('ZH', JSON.stringify(await run('zh')));
console.log('EN', JSON.stringify(await run('en')));
await browser.close(); await close();
