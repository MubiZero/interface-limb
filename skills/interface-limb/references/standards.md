# Standards cheat-sheet — the numbers, with sources

Concrete, citable values behind the principles in SKILL.md. When you apply a rule, you
can trust these figures — they're pulled from primary sources (W3C/WCAG, Apple HIG,
Material Design, Nielsen Norman Group, Vercel). Use them instead of guessing.

## Contrast (WCAG)

| What | Minimum | Level |
|------|---------|-------|
| Body / normal text | **4.5:1** | AA (1.4.3) |
| Large text (≥18pt, or ≥14pt bold) | **3:1** | AA (1.4.3) |
| Non-text UI (borders, icons, input outlines, focus rings, chart marks) | **3:1** | AA (1.4.11) |
| Body text (enhanced) | **7:1** | AAA (1.4.6) |

Treat ratios as **thresholds, not targets** — 2.99:1 fails 3:1. Verify in *both* light and
dark themes. Sources: W3C WCAG 1.4.3 / 1.4.11 / 1.4.6 — https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html ,
https://www.w3.org/WAI/WCAG21/Understanding/non-text-contrast.html

## Touch / tap targets

| Platform | Minimum | Source |
|----------|---------|--------|
| iOS (Apple HIG) | **44 × 44 pt** | https://developer.apple.com/design/tips/ |
| Android (Material) | **48 × 48 dp**, with **8 dp** spacing | https://support.google.com/accessibility/android/answer/7101858 |
| Web (WCAG AA) | **24 × 24 CSS px** (2.5.8) | https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum.html |
| Web (WCAG AAA) | **44 × 44 CSS px** (2.5.5) | https://www.w3.org/WAI/WCAG21/Understanding/target-size.html |

A 24dp icon still needs transparent padding out to the full 44/48 target.

## Focus indicators

- Never `outline: none` without a replacement — that's WCAG failure **F78** (2.4.7 Focus Visible, AA).
- A visible focus indicator should be **≥ a 2 CSS px thick perimeter** with **≥ 3:1 contrast**
  between focused/unfocused states (2.4.13 Focus Appearance, AAA). A solid **2px outline** satisfies it.
- Use `:focus-visible` (keyboard) rather than `:focus`, so pointer users don't get rings on click.
- Source: https://www.w3.org/WAI/WCAG22/Understanding/focus-visible.html , https://www.w3.org/WAI/WCAG22/Understanding/focus-appearance.html

## Text measure & scaling

- Line length: comfortable **45–75 characters**; WCAG hard cap **80 (40 for CJK)** (1.4.8 AAA).
  Implement as `max-width: 66ch` on text containers.
- Text must scale to **200%** without clipping or horizontal scroll (1.4.4 Resize Text, AA) — prefer rem/em.
- Source: https://www.w3.org/WAI/WCAG21/Understanding/visual-presentation.html

## Motion — duration & easing

Response-time perception budget (NN/g — https://www.nngroup.com/articles/response-times-3-important-limits/):
- **0.1 s (100 ms)** — feels instantaneous; press/hover/selection feedback must start within this.
- **1 s** — upper limit of uninterrupted flow; past it, show a loading indicator.
- **10 s** — attention limit; past it, show determinate progress.

Durations (Material 3 tokens — https://m3.material.io/styles/motion/easing-and-duration/tokens-specs ;
NN/g — https://www.nngroup.com/articles/animation-duration/):
- Micro-feedback (toggle, hover, ripple): **100–150 ms**
- Standard transitions (dropdown, tooltip, small panel): **200–300 ms**
- Large / full-screen / modal: **400–500 ms**
- **Never exceed ~500 ms** for routine UI motion — past that it "feels like a real drag."
- **Exits ~30% faster than entrances** (e.g. 250ms in / 200ms out) — the user no longer needs to track an exiting element.

Easing (Material 3 — same source):
- Default on-screen (begins+ends visible): **Emphasized** `cubic-bezier(0.2, 0, 0, 1)`
- Entering (ease-out / decelerate): `cubic-bezier(0.05, 0.7, 0.1, 1)`
- Exiting (ease-in / accelerate): `cubic-bezier(0.3, 0, 0.8, 0.15)`
- Avoid linear easing for spatial motion. Animate only `transform`/`opacity`; never `transition: all`.

Reduced motion: honor `prefers-reduced-motion: reduce` (MDN — https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-reduced-motion).
Replace large translation/scale/parallax with a near-instant opacity fade, but keep *essential* motion (e.g. a loading spinner).

## Haptics

iOS (UIFeedbackGenerator — https://developer.apple.com/design/human-interface-guidelines/playing-haptics):
- `UISelectionFeedbackGenerator` — selection change (picker/segment tick).
- `UIImpactFeedbackGenerator` — snap/drop; styles **light / medium / heavy** (+ soft/rigid), matched to event "mass."
- `UINotificationFeedbackGenerator` — task outcome: **success / warning / error**.

Android (https://developer.android.com/develop/ui/views/haptics/haptics-principles): prefer action
constants (`CONFIRM`, `REJECT`, `LONG_PRESS`, `KEYBOARD_TAP`). High-frequency events (scroll, drag)
"should be very subtle"; important events stronger.

Rules: **less is more** (overuse trains users to disable haptics); **don't duplicate** the system
haptics already played by switches/sliders/pickers; **sync** the tactile tick to the same frame as the
visual change.

## Dark theme — surfaces, elevation, text

- Base surface = **`#121212`** (dark gray), *not* `#000` — improves shadow visibility and reduces strain.
- Elevated surfaces get **lighter** via a white overlay scaled to elevation (Material — https://github.com/material-components/material-components-android/blob/master/docs/theming/Dark.md):

| dp | overlay | dp | overlay |
|----|---------|----|---------|
| 1 | 5% | 8 | 12% |
| 2 | 7% | 12 | 14% |
| 3 | 8% | 16 | 15% |
| 4 | 9% | 24 | 16% |
| 6 | 11% | | |

- On-surface text by emphasis: **87% / 60% / 38%** opacity (primary / secondary / disabled) over near-white — never pure `#fff` body text (it visually vibrates).
- **Desaturate brand colors** in dark mode (shift toward lighter, less-saturated tones) to stop vibration.
- Apple parallel: base vs. **elevated** system grays; semantic `label`/`secondaryLabel`/… auto-adapt.
- Source: https://m2.material.io/design/color/dark-theme.html , https://developer.apple.com/design/human-interface-guidelines/dark-mode

## Light theme — shadows

- Realistic elevation = **key light** (sharper, offset) + **ambient light** (soft, omnidirectional) →
  stack **2–3 box-shadow layers**, not one blur. Material opacities are low: ambient ~**0.12**, key ~**0.14–0.20**.
- Increase **blur/spread** with elevation, not opacity. Example:
  `0 1px 2px rgba(0,0,0,.12), 0 4px 12px rgba(0,0,0,.08)`.
- Source: https://m1.material.io/material-design/environment.html

## Typography

- **Modular scale**: `size = base × ratio^n`. Common ratios **1.25** (Major Third) or **1.333** (Perfect Fourth).
- Line-height: **body 1.5**, **headings ~1.1–1.2**.
- Letter-spacing: slight **negative tracking (−0.01 to −0.03em)** on large headings (≥32px); body normal.
- Weights: one family, **two well-separated weights** (e.g. 400 body / 700 heading — avoid the weak 400/600 pairing); max two families.
- Color palette: **60-30-10** (≈60% neutral background / 30% secondary surface / 10% accent).
- Source: Refactoring UI typography notes; WCAG 1.4.12 Text Spacing — https://www.w3.org/WAI/WCAG22/Understanding/text-spacing.html

## Loading & empty states

- **Pick the indicator by duration** (NN/g — https://www.nngroup.com/articles/skeleton-screens/):
  nothing under ~1s · spinner (single module) or skeleton (full page) for ~2–10s · progress bar for 10s+.
- **Skeletons must mirror the final layout** exactly (no layout shift). Add a **~150–300ms show-delay** and
  **~300–500ms minimum visible time** so indicators don't flash (Vercel — https://vercel.com/design/guidelines).
- **Empty states do three jobs** (NN/g — https://www.nngroup.com/articles/empty-state-interface-design/):
  (1) communicate status, (2) teach in context ("Star items to see them here"), (3) offer a direct primary
  action. Phrase titles **positively** ("Start by adding…", not "You have no…"). First-use empties beat forced tutorials.

## Forms

- **Validate on blur, not per keystroke**; never block typing; surface errors inline next to the field (Vercel).
- **Persistent labels outside the field.** Placeholder-as-label is harmful — it disappears on focus, strains memory,
  and often fails contrast (NN/g — https://www.nngroup.com/articles/form-design-placeholders/). Floating labels only when space-constrained.
- **Don't pre-disable submit** — allow submit so validation surfaces; disable only during the in-flight request.
- Enter submits a single-input form; ⌘/⌃+Enter submits from a textarea. Every control has an associated `<label>`.

## Permission priming

- Asking **just-in-time with a benefit-framed reason** lifts grant rates ~**12%**, and a strong rationale up to ~**81%**
  vs. a weak one (NN/g — https://www.nngroup.com/articles/permission-requests/).
- Never request at launch. Trigger after the user taps the feature. On denial, explain the cost and link to Settings.

## What makes Linear / Vercel / Stripe feel premium (recurring techniques)

- **Six microstates** on every interactive element — default, hover, focus, active, disabled, loading — audited before ship.
- **Keyboard-first**, visible `:focus-visible` rings, full WAI-ARIA operability.
- **Optimistic UI**: update immediately, reconcile on response, roll back / offer Undo on failure.
- **Restrained palette**: monochrome base + one accent that "does all the work"; color = meaning, not decoration.
- **One type family** as brand anchor (Inter / Geist / Söhne); tight geometric type reads as craft.
- **Designed motion**, never defaulted: defined curves + durations, reused.
- **Concentric radii**: child border-radius ≤ parent's, so curves align.
- Persist state in the **URL** so refresh/back/share work.
- Sources: Vercel Web Interface Guidelines — https://vercel.com/design/guidelines ; "How Stripe, Linear, and Vercel Ship Premium UI."
