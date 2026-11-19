# Web reference — React / Tailwind / CSS

Concrete ways to express the interface-limb principles on the web. Adapt to the
project's actual stack; these are defaults, not mandates.

## Design tokens (CSS variables)

Centralize the system so changes propagate. A typical setup:

```css
:root {
  /* spacing — 4px base scale */
  --space-1: 4px;  --space-2: 8px;  --space-3: 12px; --space-4: 16px;
  --space-6: 24px; --space-8: 32px; --space-12: 48px;

  /* radius */
  --radius-sm: 6px; --radius-md: 10px; --radius-lg: 16px;

  /* brand + semantic */
  --color-brand: #4f46e5;
  --color-success: #16a34a; --color-warning: #d97706;
  --color-error: #dc2626;   --color-info: #2563eb;

  /* light-theme surfaces & text */
  --bg: #ffffff; --surface: #ffffff; --text: #0f172a; --text-muted: #64748b;
  --border: rgba(15, 23, 42, 0.08);

  /* soft elevation — layered (ambient + key), low opacity, small offset */
  --shadow-sm: 0 1px 2px rgba(15,23,42,0.04), 0 1px 3px rgba(15,23,42,0.06);
  --shadow-md: 0 1px 2px rgba(15,23,42,0.06), 0 4px 12px rgba(15,23,42,0.08);
  --shadow-lg: 0 2px 4px rgba(15,23,42,0.06), 0 12px 32px rgba(15,23,42,0.10);

  /* motion tokens — name them, reuse them (Material 3 scale) */
  --dur-short: 150ms;   /* toggles, hover, ripple */
  --dur-medium: 250ms;  /* dropdowns, tooltips, small panels */
  --dur-long: 450ms;    /* large / modal / full-screen */
  --ease-standard: cubic-bezier(0.2, 0, 0, 1);   /* begins + ends on screen */
  --ease-enter: cubic-bezier(0.05, 0.7, 0.1, 1); /* decelerate (ease-out) */
  --ease-exit: cubic-bezier(0.3, 0, 0.8, 0.15);  /* accelerate (ease-in), make exits ~30% shorter */
}

.dark {
  /* dark theme: depth via lighter surfaces, NOT shadows */
  --bg: #121212;              /* dark gray base, NOT pure #000 */
  --surface: #1e1e1e;         /* elevated = lighter (≈ a 7–8% white overlay on base) */
  --surface-high: #242424;    /* higher elevation = lighter still */
  --text: rgba(255,255,255,0.87);       /* 87% — primary, never solid #fff */
  --text-muted: rgba(255,255,255,0.60); /* 60% — secondary */
  --text-disabled: rgba(255,255,255,0.38); /* 38% — disabled */
  --border: rgba(255,255,255,0.08);     /* faint hairline */
  /* keep shadows minimal in dark mode; let the lighter surface do the lifting */
  /* also desaturate brand: use a lighter, less-saturated --color-brand here */
}
```

In Tailwind, map these to `theme.extend` (colors, spacing, borderRadius, boxShadow) so
utilities like `bg-surface`, `shadow-md`, `p-4` stay token-driven.

## Typography

```css
body { font-family: 'Inter', system-ui, sans-serif; }
.h1 { font-size: 2rem; line-height: 1.15; letter-spacing: -0.02em; font-weight: 700; }
.h2 { font-size: 1.5rem; line-height: 1.2; letter-spacing: -0.015em; font-weight: 600; }
.body { font-size: 1rem; line-height: 1.5; letter-spacing: 0; }
.caption { font-size: 0.8125rem; line-height: 1.4; color: var(--text-muted); }
```
- Tighten tracking only on larger text; leave body at 0.
- Tailwind: `tracking-tight` on headings, `leading-relaxed` on body.

## Icon/text alignment

Match icon optical size to the line; align as one unit:

```jsx
<span className="inline-flex items-center gap-2 leading-6">
  <Icon className="h-5 w-5 shrink-0" aria-hidden />
  <span>Label</span>
</span>
```

## Interaction states (the core of premium feel)

Express every state. Example button with Tailwind:

```jsx
<button
  className="
    inline-flex items-center gap-2 rounded-[var(--radius-md)] px-4 py-2
    bg-[var(--color-brand)] text-white font-medium
    transition-[transform,background-color,box-shadow] duration-150 ease-out
    hover:brightness-110
    active:scale-[0.97]
    focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[var(--color-brand)] focus-visible:ring-offset-2
    disabled:opacity-50 disabled:pointer-events-none
  "
  disabled={loading}
>
  {loading && <Spinner className="h-4 w-4 animate-spin" />}
  {children}
</button>
```
- `active:scale-[0.97]` = press feedback.
- `focus-visible:ring-*` = real focus state; never bare `outline:none`.
- Loading lives *inside* the button so layout doesn't jump.

## Motion on the web

Durations, curves, the spring and the named moves live in one module ([motion.md](motion.md)); a screen never writes
its own. Web specifics: tokens as CSS variables (`--dur-fast`, `--ease-out`) consumed by Tailwind `duration-*` /
`ease-*` extensions, and a global reduced-motion fallback that shortens rather than kills feedback:

```css
@media (prefers-reduced-motion: reduce) {
  *, ::before, ::after { animation-duration: 0.01ms !important; transition-duration: 0.01ms !important; }
}
```
(or Tailwind's `motion-reduce:` variants for targeted control; keep spinners and progress running.)

## Shimmer skeletons (not spinners)

```css
.skeleton {
  background: linear-gradient(90deg,
    var(--surface) 25%, rgba(255,255,255,0.06) 37%, var(--surface) 63%);
  background-size: 400% 100%;
  animation: shimmer 1.4s ease infinite;
  border-radius: var(--radius-sm);
}
@keyframes shimmer { 0% { background-position: 100% 0 } 100% { background-position: 0 0 } }
```
When to show one, the mirrored layout and the anti-flicker timings: [states.md](states.md), numbers in
[standards.md](standards.md). Wrap the shimmer animation in `@media (prefers-reduced-motion: no-preference)` so
reduced-motion users get a static skeleton.

## Text over images

Use a gradient scrim, not a flat fill:

```css
.media-caption {
  background: linear-gradient(to top, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0) 60%);
}
```
For progressive blur, stack a `backdrop-filter: blur()` layer that fades via mask-image
toward the image, keeping the photo crisp where there's no text.

## Empty states

A component, not an afterthought; what it says and when ([states.md](states.md), [ux-writing.md](ux-writing.md)).
The shape:

```jsx
<EmptyState
  icon={<InboxIcon />}
  title="No projects yet"
  description="Create your first project to start tracking work."
  action={<Button onClick={onCreate}>New project</Button>}
/>
```

## Forms

- **Label outside the field, always present** — don't use the placeholder as the label (it
  vanishes on focus and often fails contrast). Placeholder = example/format hint only.
- **Validate on blur**, not on every keystroke; show the error inline next to the field with
  `aria-invalid` + `aria-describedby` pointing at the message.
- **Don't pre-disable submit** — let the user submit so validation surfaces; disable only while
  the request is in flight (and show the spinner in the button).
- Associate every control with a `<label>`; Enter submits a single-input form, ⌘/Ctrl+Enter
  from a textarea.
- Set `type` + `inputmode` (`email`/`tel`/`numeric`/`url`) so mobile shows the right keyboard, and
  correct `autocomplete` tokens (don't blanket `autocomplete="off"`).
- Per-field errors with `role="alert"` / `aria-live`, not one summary at the top.
- Password show/hide toggle; disable the submit button with a spinner in flight to prevent double submission.
  More on forms, money and codes: [input.md](input.md).

## Responsive & mobile-web

- **Content-driven breakpoints, not device sizes.** Expand until the layout breaks, then add a
  breakpoint; three usually suffice. For grids, prefer breakpoint-free
  `grid-template-columns: repeat(auto-fit, minmax(280px, 1fr))`, and **container queries** for
  components that need to adapt to their container rather than the viewport.
- **Detect input method separately from size:** `@media (pointer: coarse)` → larger touch targets;
  `@media (hover: hover)` → gate hover-only effects. Never make hover-only functionality essential.
- **`100vh` is broken on mobile** (browser chrome) — use `min-h-[100dvh]` / `dvh`, not `h-screen`.
- **Reserve space for async content** (`aspect-ratio` or fixed height on images/embeds) to prevent
  layout shift (CLS). Use `srcset`/`sizes` and `<picture>` for responsive images.
- **Honor safe areas:** `env(safe-area-inset-*)`, e.g. `padding-bottom: max(1rem, env(safe-area-inset-bottom))`,
  plus `viewport-fit=cover` in the viewport meta.
- Small touches: `touch-action: manipulation` (removes the 300ms tap delay),
  `overscroll-behavior: contain` (stops scroll chaining / accidental pull-to-refresh).
- **Semantic z-index scale** (e.g. dropdown 10 / sticky 20 / modal 30 / toast 40 / tooltip 50) — never
  `z-[9999]`. Remember transform/opacity/filter on a parent creates a new stacking context.

## Systematize

The layers and the guard tests are in [design-system.md](design-system.md). Web mapping: states as component variants
(`cva` / variant props), tokens as Tailwind theme + CSS variables, child `border-radius` ≤ parent's.
- Empty/loading/error → first-class props/states of data components.
