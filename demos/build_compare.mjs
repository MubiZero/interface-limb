// Builds the two side-by-side compare pages (without | with the skill) as single portable files.
// Usage: node demos/build_compare.mjs   (or: bun demos/build_compare.mjs)
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const root = dirname(fileURLToPath(import.meta.url));
const demos = [
  ["A_pricing", "Demo A: a SaaS “Pro” pricing card"],
  ["B_empty", "Demo B: an empty “Projects” list screen"],
  ["C_billing", "Demo C: a billing settings page (open the two files in C_billing/ for the full desktop view)"],
];

const esc = (s) => s.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;");

const page = (title, without, withSkill) => `<!doctype html>
<html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title}</title>
<style>
  :root { color-scheme: light; }
  * { box-sizing: border-box; }
  body { margin: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; background: #f4f5f7; color: #16181d; }
  header { padding: 20px 24px 8px; }
  h1 { font-size: 18px; margin: 0 0 4px; letter-spacing: -0.01em; }
  p.sub { margin: 0; color: #6b7280; font-size: 13px; }
  .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; padding: 16px 24px 28px; }
  @media (max-width: 860px) { .grid { grid-template-columns: 1fr; } }
  .panel { background: #fff; border: 1px solid rgba(0,0,0,0.08); border-radius: 14px; overflow: hidden; box-shadow: 0 1px 2px rgba(0,0,0,.04), 0 6px 16px rgba(0,0,0,.05); }
  .panel .label { display: flex; align-items: center; gap: 8px; padding: 10px 14px; font-size: 13px; font-weight: 600; border-bottom: 1px solid rgba(0,0,0,0.06); }
  .dot { width: 8px; height: 8px; border-radius: 50%; }
  .without .dot { background: #9ca3af; }
  .with .dot { background: #10b981; }
  .label .tag { margin-left: auto; font-weight: 500; color: #9ca3af; font-size: 12px; }
  iframe { width: 100%; height: 660px; border: 0; display: block; background: #fff; }
</style></head>
<body>
  <header>
    <h1>${title}</h1>
    <p class="sub">Left: a plain Claude answer. Right: Claude with the <b>interface-limb</b> skill. Both were generated from the same prompt. Hover, press and tab through the elements; the states are real.</p>
  </header>
  <div class="grid">
    <div class="panel without">
      <div class="label"><span class="dot"></span>Without the skill<span class="tag">baseline</span></div>
      <iframe srcdoc="${without}" title="without skill"></iframe>
    </div>
    <div class="panel with">
      <div class="label"><span class="dot"></span>With the skill<span class="tag">interface-limb</span></div>
      <iframe srcdoc="${withSkill}" title="with skill"></iframe>
    </div>
  </div>
</body></html>
`;

for (const [folder, title] of demos) {
  const read = (f) => esc(readFileSync(join(root, folder, f), "utf8"));
  const out = join(root, `compare_${folder}.html`);
  writeFileSync(out, page(title, read("without.html"), read("with.html")));
  console.log("wrote", out);
}
