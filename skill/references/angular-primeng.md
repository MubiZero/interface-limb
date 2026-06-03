# Web reference — Angular / PrimeNG

Concrete ways to express the interface-limb principles in an Angular app built on PrimeNG.
Adapt to the project's actual stack; these are defaults, not mandates. The general web rules in
[web.md](web.md) still apply — this file covers what changes when a component library owns the
rendering.

**The mental shift:** in raw React/Tailwind you author every element, so the tokens live in CSS
variables you write. In PrimeNG the components are already built and already carry states — your
design system lives in a **theme preset** (styled mode), and your job is to *tune the tokens and
fill the gaps PrimeNG leaves*, not to re-style components from the outside. Reaching for
`::ng-deep` is the tell that you skipped the intended path; it is deprecated and removed in v20.

## Design tokens live in a preset, not loose CSS

PrimeNG styled mode is a design-token system in three tiers — **primitive** (raw palette:
`{blue.500}`), **semantic** (intent: `primary`, `surface`, `text.color`), **component**
(`button.*`, `card.*`). You customize by extending a built-in preset (Aura / Material / Lara /
Nora), not by overriding classes. This *is* interface-limb's "systematize via tokens" done the
PrimeNG way — one source of truth that propagates everywhere.

```typescript
// app.config.ts
import { providePrimeNG } from 'primeng/config';
import { definePreset } from '@primeuix/themes';
import Aura from '@primeuix/themes/aura';

const Preset = definePreset(Aura, {
  semantic: {
    primary: { 50: '{indigo.50}', 500: '{indigo.500}', 600: '{indigo.600}' /* … */ },
    borderRadius: { sm: '6px', md: '10px', lg: '16px' },   // concentric: child ≤ parent
    focusRing: { width: '2px', style: 'solid', color: '{primary.color}', offset: '2px' },
    colorScheme: {
      light: { surface: { 0: '#ffffff', 50: '#f8fafc', 100: '#f1f5f9' /* … */ } },
      dark:  { surface: { 0: '#1e1e1e', 50: '#242424', 950: '#121212' /* … */ } },
    },
  },
});

providePrimeNG({ theme: { preset: Preset, options: { darkModeSelector: '.dark', cssLayer: { name: 'primeng', order: 'theme, base, primeng' } } }, ripple: true });
```

- **Spacing/type/radius harmony** from the skill still holds — express the 4px scale and modular
  type scale in the preset's `borderRadius`/spacing tokens (and via Tailwind utilities below), so
  every component inherits them instead of carrying magic numbers.
- Aura already implements much of the dark-theme *discipline* (tiered surfaces, non-pure-black
  base). Tune its `surface` ramp to the values in [standards.md](standards.md) rather than
  re-deriving depth yourself.

## Dark theme: tune the surface ramp, don't invert

`darkModeSelector: '.dark'` tells PrimeNG to gate its dark tokens behind a class — toggle that
class on `<html>` (align it with Tailwind's `dark` class so both systems flip together):

```typescript
document.documentElement.classList.toggle('dark', isDark());  // signal-driven
```

PrimeNG's surface tokens are exactly the skill's "depth via lightening, not shadow" mechanism:
in the dark `colorScheme`, set the base to `#121212` (not `#000`) and make each higher surface a
*lighter* gray. Set text via the semantic `text.color` / `text.muted.color` tokens at tiered
opacity (≈87% / 60% / 38% — see [standards.md](standards.md)), and desaturate `primary` for dark.
Get this right in the preset and every `p-card`, `p-dialog`, and menu floats correctly for free.

## Tailwind for layout, PrimeNG for components

Install the official **`tailwindcss-primeui`** plugin and order the CSS cascade layers so Tailwind
utilities can safely override PrimeNG:

```css
/* styles.css */
@layer tailwind-base, primeng, tailwind-utilities;
```

This lets you keep the skill's spacing/hierarchy work in Tailwind utilities (`p-4`, `gap-2`,
`max-w-[66ch]`, `grid`, the 4px scale) while PrimeNG owns the interactive components — and the
plugin exposes the *semantic* tokens as utilities (`bg-primary`, `text-surface-500`,
`text-muted-color`, `dark:` variants) so even your hand-written layout stays token-driven and
theme-aware. PrimeFlex is legacy; prefer Tailwind for spacing/layout.

## Customizing one component: the escalation ladder

Go down this list only as far as you must; stop at the first level that works.

1. **Global design token** (preset `components.button.*`) — the right place for "all buttons
   should look like this." Propagates everywhere, survives upgrades.
2. **Scoped `[dt]`** — a per-instance token override, the clean replacement for `::ng-deep`:
   ```html
   <p-toggleswitch [(ngModel)]="on" [dt]="{ colorScheme: { light: { root: { checkedBackground: '{amber.500}' } } } }" />
   ```
3. **Pass-Through `[pt]`** — target a component's *internal* elements with classes/attributes
   (the "front door", replaces `::ng-deep`). Use Tailwind's `!` for a hard override:
   ```html
   <p-button label="Save" [pt]="{ root: '!px-4 !py-3', label: '!text-base' }" />
   ```
4. **Plain scoped CSS** — last resort, and only on *your* wrapper, never reaching into PrimeNG
   internals. If you typed `::ng-deep`, back up a level.

## Interaction states: PrimeNG ships them — your job is the gaps

PrimeNG components arrive with hover / focus / disabled / loading, so the "every state" rule is
half-done. The gaps you still own:

- **Press feedback** — keep ripple on (`providePrimeNG({ ripple: true })` + `pRipple` on custom
  interactive elements). For non-PrimeNG controls, add the `active:scale-[0.97]` press cue yourself.
- **Focus ring** — set the semantic `focusRing` token so `:focus-visible` clears **≥ 3:1**
  ([standards.md](standards.md)). Never strip it; PrimeNG's default ring is a starting point, not
  a license to remove.
- **Loading inside the control** — `<p-button [loading]="saving()">` puts the spinner *in* the
  button so layout doesn't jump; don't pre-disable, disable only in-flight.
- **Use `severity` / `variant`, not one-offs** — `severity="danger"`, `variant="outlined"` are the
  built-in variant system; reach for them before authoring a bespoke styled button.

**The "quiet controls" trap is sharper here.** PrimeNG's own `p-menu`, `p-tabs`, `p-table` headers,
`p-paginator` come fully stated — but any bare `<a>`, `<div>`, or icon you add *around* them does
not. Walk every structural control you authored (breadcrumbs you built, custom list rows, clickable
cards) and confirm each visibly responds. A `p-table` row that looks clickable must actually be
`selectionMode`-wired or carry a real hover+press, not just a cursor.

## Forms

Angular reactive forms + PrimeNG inputs. The skill's form rules map directly:

- **Label outside the field** via `<label [for]>`. `p-floatlabel` is fine — the label floats
  *above* on focus, it doesn't vanish like a placeholder, so it satisfies the persistent-label
  rule. Placeholder stays an example/format hint only.
- **Validate on blur:** `new FormControl('', { updateOn: 'blur', validators: [...] })` — not on
  every keystroke, and never block typing.
- **Inline error next to the field**, shown only after `touched`, wired for screen readers:
  ```html
  <input pInputText formControlName="email" [class.ng-invalid]="..." aria-describedby="email-err" />
  @if (form.controls.email.touched && form.controls.email.invalid) {
    <small id="email-err" class="text-red-500" role="alert">Email addresses need an @ symbol.</small>
  }
  ```
- **Don't pre-disable submit** — let it submit so validation surfaces; show the button spinner in
  flight. Use `p-password` `[toggleMask]="true"` for show/hide.

## Loading & empty states: Angular `@defer` + PrimeNG `p-skeleton`

Use the control-flow blocks to express the loading discipline declaratively, and `p-skeleton`
shaped to mirror the real layout so content swaps in without shifting:

```html
@defer (on viewport) {
  <app-report-panel [data]="report()" />
} @placeholder (minimum 300ms) {
  <p-skeleton height="8rem" styleClass="mb-3" />   <!-- mirror the final layout's boxes -->
} @loading (minimum 300ms) {
  <p-skeleton height="8rem" />
} @error {
  <app-error-state (retry)="reload()" />
}
```

- `minimum 300ms` is the anti-flicker floor from the skill — keeps the placeholder/skeleton from
  flashing on fast loads.
- **Empty states are a real component, not `emptyMessage="No data"`.** `p-table` exposes an
  `emptymessage` template — fill it with the skill's empty-state shape: icon + **positive** title
  ("Start by adding your first employee") + a single primary action. Same for any list/grid.
- Wrap the skeleton shimmer in `prefers-reduced-motion: no-preference` (PrimeNG's animation honors
  it; verify your custom shimmer does too).

## Motion & accessibility

- **Ripple** is PrimeNG's built-in press confirmation — leave it on. Angular animations drive
  overlays; keep durations within the [standards.md](standards.md) budget and animate
  `transform`/`opacity`. Honor reduced-motion as one global switch.
- **PrimeNG is ARIA-compliant, but icon-only and decorative-trigger components need help:** pass
  `ariaLabel` to icon-only `p-button`, `p-carousel` nav, `p-paginator`, and any control whose
  purpose is conveyed only by an icon. `p-dialog` traps focus and restores it on close (built-in) —
  don't reimplement it. Keep all user-facing strings translated (e.g. ngx-translate) including the
  ARIA labels.

## Systematize

- **The preset is the single source of truth** — the Angular/PrimeNG equivalent of Flutter's
  `ThemeData`. Color, surface, radius, focus ring, and component tokens all live there; change once,
  propagate everywhere. No per-screen color literals.
- **Concentric radii** via the `borderRadius` semantic tokens — a nested `p-card`'s radius ≤ its
  container's.
- **Variants over one-offs** — model new states as `severity`/`variant` or component tokens, not a
  parallel pile of custom classes.
- **Empty / loading / error are first-class** — express them with `@defer` blocks and dedicated
  state components, not happy-path-only templates.
- **Persist meaningful view state in the URL** (filters, tab, selection) via Angular Router query
  params, so refresh/back/share all work.
