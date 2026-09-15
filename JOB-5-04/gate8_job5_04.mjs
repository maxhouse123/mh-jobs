import { chromium } from 'playwright';
const PIXEL_UA='Mozilla/5.0 (Linux; Android 14; Pixel 8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Mobile Safari/537.36';
const CASES=[
  {name:'student v380', file:'file:///Volumes/Dev/MAXHOUSE/student-portal/maxhouse_student_portal_v380.html', email:'gateEmail', pw:'gatePassword'},
  {name:'partner v148', file:'file:///Volumes/Dev/MAXHOUSE/partner-portal/maxhouse-partner-portal-v148.html', email:'emailInput', pw:'pwdInput'},
  {name:'school v229',  file:'file:///Volumes/Dev/MAXHOUSE/school-portal/maxhouse-school-portal-v229.html', email:'gateEmailInput', pw:'gatePasswordInput'},
];
const b=await chromium.launch();
let allOk=true;
for(const c of CASES){
  const ctx=await b.newContext({userAgent:PIXEL_UA, viewport:{width:390,height:800}, isMobile:true, hasTouch:true});
  const p=await ctx.newPage();
  await p.route('**', r => r.request().url().startsWith('file:')?r.continue():r.abort());
  p.on('pageerror',()=>{});
  // stub sb so any DOMContentLoaded session check doesn't hang
  await p.addInitScript(()=>{ window.sb={auth:{getSession:async()=>({data:{session:null}}), onAuthStateChange:()=>({data:{subscription:{unsubscribe(){}}}}), signInWithPassword:async()=>({error:{message:'stub'}})}}; });
  await p.goto(c.file,{waitUntil:'domcontentloaded'}).catch(()=>{});
  const res=await p.evaluate(async (c)=>{
    const out={};
    const em=document.getElementById(c.email), pw=document.getElementById(c.pw);
    out.emailExists=!!em; out.pwExists=!!pw;
    // 1 邮箱敲混合大小写, 值不变
    em.focus(); em.value=''; em.value='Test@Example.com'; em.dispatchEvent(new Event('input',{bubbles:true}));
    out.emailValue = em.value;
    out.emailValueOk = em.value==='Test@Example.com';
    // 2 computed text-transform = none
    out.emailTT = getComputedStyle(em).textTransform;
    out.pwTT = getComputedStyle(pw).textTransform;
    out.ttOk = out.emailTT==='none' && out.pwTT==='none';
    // 3 属性
    out.emailAutocap = em.getAttribute('autocapitalize');
    out.emailInputmode = em.getAttribute('inputmode');
    out.pwAutocap = pw.getAttribute('autocapitalize');
    out.pwAutocorr = pw.getAttribute('autocorrect');
    // 4 眼睛切换
    const eye=[...document.querySelectorAll('button[onclick*="TogglePw"]')].find(x=>x.closest('div')&&x.closest('div').querySelector('#'+CSS.escape(c.pw)));
    out.eyeExists=!!eye;
    out.pwTypeBefore=pw.type;
    if(eye){ eye.click(); out.pwTypeAfter1=pw.type; eye.click(); out.pwTypeAfter2=pw.type; }
    out.eyeToggleOk = eye && out.pwTypeBefore==='password' && out.pwTypeAfter1==='text' && out.pwTypeAfter2==='password';
    return out;
  }, c);
  await ctx.close();
  const ok = res.emailExists&&res.pwExists&&res.emailValueOk&&res.ttOk&&res.eyeToggleOk
             && res.emailAutocap==='none' && res.pwAutocap==='none' && res.pwAutocorr==='off';
  allOk=allOk&&ok;
  console.log('=== '+c.name+' === '+(ok?'PASS':'FAIL'));
  console.log(JSON.stringify(res));
}
await b.close();
console.log(allOk?'GATE8 PASS (三端登录门: 邮箱不变大写 + text-transform none + 眼睛切换)':'GATE8 FAIL');
process.exit(allOk?0:1);
