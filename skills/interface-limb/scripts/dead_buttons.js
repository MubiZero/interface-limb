// interface-limb · dead_buttons.js — press every visible button of a page and report what each press did.
//
// Paste into the browser console of an interactive mock or a running web app (or load it from a test driver), then:
//
//   await deadButtons()                                   // all visible buttons, from the page as it is
//   await deadButtons({ home: () => resetToStart(), from: 0, count: 20, wait: 200 })
//
// For each button: ok   — something outside the pressed button changed (a sheet opened, a list changed, a toast);
//                  SELF — only the button itself changed (its class, its aria): fine for a toggle, a fake otherwise;
//                  DEAD — nothing changed.
// "Visible" means a finger could press it: inside the viewport, not inside a hidden, display:none, transparent
// (opacity < 0.05) or pointer-events:none ancestor (closed panels are often only faded out).
//
// home: a function that brings the page back to the same start before each press (close sheets, go to the screen).
// Without it, presses run in sequence from wherever the previous one left the page.
// Run it in a visible tab: in a hidden or background tab transitions and requestAnimationFrame do not run.
window.deadButtons = async function ({ home = null, selector = 'button, [role="button"], a[href]', skip = '', from = 0, count = 40, wait = 200 } = {}) {
  const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
  const visible = (e) => {
    const r = e.getBoundingClientRect();
    if (!r.width || !r.height) return false;
    if (r.bottom <= 0 || r.top >= innerHeight || r.right <= 0 || r.left >= innerWidth) return false;
    for (let p = e; p; p = p.parentElement) {
      if (p.hidden) return false;
      const cs = getComputedStyle(p);
      if (cs.display === 'none' || cs.visibility === 'hidden' || +cs.opacity < 0.05 || cs.pointerEvents === 'none') return false;
    }
    return true;
  };
  const label = (e) => (e.getAttribute('aria-label') || e.innerText || e.id || e.className || e.tagName)
    .replace(/\s+/g, ' ').replace(/\d+/g, '#').trim().slice(0, 48);
  const list = () => [...document.querySelectorAll(selector)]
    .filter((b) => !b.disabled && b.getAttribute('aria-disabled') !== 'true' && visible(b) && !(skip && b.closest(skip)));
  if (home) { await home(); await sleep(wait); }
  const names = list().map(label);
  const out = [];
  for (let i = from; i < Math.min(names.length, from + count); i++) {
    if (home) { await home(); await sleep(wait); }
    const b = list().find((x) => label(x) === names[i]);
    if (!b) { out.push('gone ' + names[i] + '  (its label changed or it left the screen: check by hand)'); continue; }
    let outside = 0, self = 0;
    const mo = new MutationObserver((m) => m.forEach((r) => (b.contains(r.target) ? self++ : outside++)));
    mo.observe(document.body, { subtree: true, childList: true, attributes: true, characterData: true });
    b.click();
    await sleep(wait);
    mo.disconnect();
    out.push((outside ? 'ok   ' : self ? 'SELF ' : 'DEAD ') + names[i]);
  }
  return { total: names.length, out, problems: out.filter((x) => !x.startsWith('ok')) };
};
