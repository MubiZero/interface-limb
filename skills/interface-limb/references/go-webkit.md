# Go html/template + vanilla CSS & JS (`kit/webkit`)

Concrete ways to express the interface-limb principles on Go-rendered web pages (`html/template`, `embed.FS`, hashed static assets, vanilla CSS custom properties, and lightweight progressive-enhancement JS without a bundler or SPA framework).

## 1. Design tokens in one hashed CSS sheet

Keep all visual decisions in `:root` and `[data-theme="dark"]` (or `@media (prefers-color-scheme: dark)`) inside your shared base stylesheet (`tokens.css` / `kit.css`). Pages and templates never write inline hex colors, raw pixel spacing or ad-hoc transitions.

```css
:root {
  --space-1: 4px;  --space-2: 8px;  --space-3: 12px; --space-4: 16px;
  --space-6: 24px; --space-8: 32px; --space-12: 48px;
  --radius-sm: 6px; --radius-md: 10px; --radius-lg: 16px;

  --bg: #fafaf9; --surface: #ffffff; --surface-high: #f5f5f4;
  --text: #1c1917; --text-muted: #57534e;
  --border: rgba(28, 25, 23, 0.10);
  --color-brand: #0f766e;
  --color-success: #15803d; --color-warning: #b45309; --color-error: #b91c1c;

  --dur-short: 140ms; --dur-medium: 240ms; --dur-long: 400ms;
  --ease-standard: cubic-bezier(0.2, 0, 0, 1);
  --ease-enter: cubic-bezier(0.05, 0.7, 0.1, 1);
  --ease-exit: cubic-bezier(0.3, 0, 0.8, 0.15);
}
```

## 2. Shared components as template partials

Do not copy-paste markup across `.tmpl` / `.gohtml` files:
- Define shared partials (`{{define "ui/button"}}`, `{{define "ui/field"}}`, `{{define "ui/empty"}}`, `{{define "ui/dialog"}}`, `{{define "ui/toast-region"}}`) in the shared kit.
- Every interactive control renders its semantic element (`<button type="button">`, `<a href="...">`, `<dialog>`) with visible `:focus-visible`, `:active` (`transform: scale(0.98)`), and `[disabled]` / `[aria-busy="true"]` states styled in `kit.css`.
- For modals and sheets, use the native `<dialog>` element (`dialog.showModal()`, `dialog.close()`): it gives top-layer rendering, `Esc` to close, focus trapping and `::backdrop` without a JS bundle.

## 3. Fast first load (1–3 s interactive on 50 KB/s)

Go-rendered public pages exist so first-time visitors on slow mobile networks get an interactive screen immediately:
- Render the real initial state on the server — no blank shell + client fetch on initial load, and no layout jump after JS boots.
- Embed page data safely via `<script type="application/json" id="page-data">` (never string-interpolated inside executable JS).
- Hash asset URLs (`kit.a1b2c3.css`) and serve with `Cache-Control: public, max-age=31536000, immutable`.
- Self-host WOFF2 fonts with `font-display: swap` and size-adjusted system fallbacks so headlines do not shift when the font arrives.

## 4. i18n and formatting on the server

- All user-facing strings come from the Go localization catalog for the request's locale — never hardcoded in `.tmpl` or inline JS. When client JS needs a label (e.g., an «Undo» toast or error banner), pass it via `data-*` attributes or the page's JSON payload.
- Format money, dates and plural forms in Go template helpers using tabular numbers (`font-variant-numeric: tabular-nums`) in the CSS class for prices, counts and timestamps.

## 5. Verification in Go (`httptest` + `chromedp`)

- Render every template state (populated, empty, error, long strings, RTL/locale) through `httptest` and capture widths with `scripts/shoot_widths.sh` or `chromedp` at `360`, `390`, `768`, `1024`, `1366`, `1440`.
- Run `scripts/ds_audit.sh` across the template and CSS directories (`ds_audit.sh` scans `.tmpl`, `.gohtml`, `.html`, `.css` and `.js`).
