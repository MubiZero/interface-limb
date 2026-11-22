// interface-limb · dead_buttons.js — press every visible button of a page and report what each press did.
//
// Paste into the browser console of an interactive mock or a running web app (or load it from a test driver), then:
//
//   await deadButtons()                                   // all visible buttons, from the page as it is
//   await deadButtons({ home: () => resetToStart(), from: 0, count: 20, wait: 200 })
//
// For each button: ok   — something outside the pressed button changed (a sheet opened, a list changed, a toast, or a real href navigation was intercepted);
//                  SELF — only the button itself changed (its class, its aria): fine for a toggle, a fake otherwise;
//                  DEAD — nothing changed.
// Disambiguates duplicate labels (e.g., multiple "Delete" rows) by occurrence rank (#1, #2, ...) and intercepts
// real <a href> navigations so a link click does not unload the page mid-audit.
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
  const baseLabel = (e) => (e.getAttribute('aria-label') || e.innerText || e.id || e.className || e.tagName)
    .replace(/\s+/g, ' ').replace(/\d+/g, '#').trim().slice(0, 48);
  const listWithKeys = () => {
    const counts = new Map();
    return [...document.querySelectorAll(selector)]
      .filter((b) => !b.disabled && b.getAttribute('aria-disabled') !== 'true' && visible(b) && !(skip && b.closest(skip)))
      .map((el) => {
        const lbl = baseLabel(el);
        const n = (counts.get(lbl) || 0) + 1;
        counts.set(lbl, n);
        return { el, key: n === 1 ? lbl : `${lbl} [${n}]` };
      });
  };
  if (home) { await home(); await sleep(wait); }
  const keys = listWithKeys().map((x) => x.key);
  const out = [];
  for (let i = from; i < Math.min(keys.length, from + count); i++) {
    if (home) { await home(); await sleep(wait); }
    const hit = listWithKeys().find((x) => x.key === keys[i]);
    const b = hit && hit.el;
    if (!b) { out.push('gone ' + keys[i] + '  (its label changed or it left the screen: check by hand)'); continue; }
    let outside = 0, self = 0, navIntercepted = 0;
    const onNav = (ev) => {
      const a = ev.target.closest && ev.target.closest('a[href]');
      if (!a) return;
      const href = (a.getAttribute('href') || '').trim();
      if (href && href !== '#' && !href.startsWith('javascript:')) {
        ev.preventDefault();
        navIntercepted++;
      }
    };
    document.addEventListener('click', onNav, true);
    const mo = new MutationObserver((m) => m.forEach((r) => (b.contains(r.target) ? self++ : outside++)));
    mo.observe(document.body, { subtree: true, childList: true, attributes: true, characterData: true });
    b.click();
    await sleep(wait);
    mo.disconnect();
    document.removeEventListener('click', onNav, true);
    out.push(((outside || navIntercepted) ? 'ok   ' : self ? 'SELF ' : 'DEAD ') + keys[i]);
  }
  return { total: keys.length, out, problems: out.filter((x) => !x.startsWith('ok')) };
};
