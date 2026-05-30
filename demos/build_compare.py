#!/usr/bin/env python3
"""Assemble two side-by-side compare pages (without | with skill) using iframe srcdoc
so each is a single portable file with no cross-file loading."""
import html
from pathlib import Path

ROOT = Path(r"C:\Users\mubin\.claude\skills\interface-limb-demos")

DEMOS = [
    ("A_pricing", "Демо A — карточка тарифа SaaS «Pro»"),
    ("B_empty",   "Демо B — пустой экран списка «Projects»"),
]

PAGE = """<!doctype html>
<html lang="ru"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{title}</title>
<style>
  :root {{ color-scheme: light; }}
  * {{ box-sizing: border-box; }}
  body {{ margin: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
          background: #f4f5f7; color: #16181d; }}
  header {{ padding: 20px 24px 8px; }}
  h1 {{ font-size: 18px; margin: 0 0 4px; letter-spacing: -0.01em; }}
  p.sub {{ margin: 0; color: #6b7280; font-size: 13px; }}
  .grid {{ display: grid; grid-template-columns: 1fr 1fr; gap: 16px; padding: 16px 24px 28px; }}
  @media (max-width: 860px) {{ .grid {{ grid-template-columns: 1fr; }} }}
  .panel {{ background: #fff; border: 1px solid rgba(0,0,0,0.08); border-radius: 14px; overflow: hidden;
            box-shadow: 0 1px 2px rgba(0,0,0,.04), 0 6px 16px rgba(0,0,0,.05); }}
  .panel .label {{ display: flex; align-items: center; gap: 8px; padding: 10px 14px; font-size: 13px;
                   font-weight: 600; border-bottom: 1px solid rgba(0,0,0,0.06); }}
  .dot {{ width: 8px; height: 8px; border-radius: 50%; }}
  .without .dot {{ background: #9ca3af; }}
  .with .dot {{ background: #10b981; }}
  .label .tag {{ margin-left: auto; font-weight: 500; color: #9ca3af; font-size: 12px; }}
  iframe {{ width: 100%; height: 660px; border: 0; display: block; background: #fff; }}
</style></head>
<body>
  <header>
    <h1>{title}</h1>
    <p class="sub">Слева — обычный ответ Claude. Справа — Claude со скиллом <b>interface-limb</b>. Обе версии сгенерированы независимыми агентами по одинаковому запросу. Наведи/нажми/потабай по элементам — состояния настоящие.</p>
  </header>
  <div class="grid">
    <div class="panel without">
      <div class="label"><span class="dot"></span>Без скилла<span class="tag">baseline</span></div>
      <iframe srcdoc="{without}" title="without skill"></iframe>
    </div>
    <div class="panel with">
      <div class="label"><span class="dot"></span>Со скиллом<span class="tag">interface-limb</span></div>
      <iframe srcdoc="{with_}" title="with skill"></iframe>
    </div>
  </div>
</body></html>
"""

for folder, title in DEMOS:
    d = ROOT / folder
    without = html.escape((d / "without.html").read_text(encoding="utf-8"), quote=True)
    with_ = html.escape((d / "with.html").read_text(encoding="utf-8"), quote=True)
    out = ROOT / f"compare_{folder}.html"
    out.write_text(PAGE.format(title=title, without=without, with_=with_), encoding="utf-8")
    print(f"wrote {out}")
print("done")
