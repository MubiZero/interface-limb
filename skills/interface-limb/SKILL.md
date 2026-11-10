---
name: interface-limb
description: >-
  Design intelligence for application interfaces, system first: before drawing a screen, find
  (or set up) the product's design system — tokens, shared components, and one shared surface per
  kind of job — build only from it, render the result and judge it by eye, and measure how well the
  code keeps to it. Use it whenever you plan, build, review, refine, redesign or fix any UI for a web,
  mobile or desktop app (screens, components, forms, dialogs, sheets, navigation, dashboards,
  onboarding, settings, checkout, POS/till screens, landing pages, empty/loading/error states), and
  whenever someone asks "do we have a design system", "why does this look AI-made / vibe-coded",
  "make it look professional / premium", "unify these screens", "too many dialogs", or "audit the UI",
  even if they never say the word design. Grounded in cited standards (WCAG contrast and targets,
  Material/Apple motion and dark theme, modular type scales). Covers React/Tailwind/CSS,
  Angular/PrimeNG, Flutter and React Native.
---

# Interface Limb

Good interfaces are not made screen by screen. They come from a small system — a few tokens, a
few components, one way to do each kind of job — applied everywhere, and from someone who looks at
the rendered result and is honest about it. AI-built UI fails in the opposite way: it builds every
component from scratch, picks its own colors and layout, gives every element the same weight, fills
it with placeholders, and never looks at what it drew. Each screen can be "fine"; the product still
reads as vibe-coded, because nothing is shared and nobody decided anything.

This skill is a workflow, not a list of tips. The tips live in the reference files; the workflow
makes sure they are applied in the right order and to the right layer.

**Size the workflow to the change.** A one-property fix (a gap, a color, a word, a missing state on one
control) skips steps 0, 1 and 4: make it with the existing tokens and say so. Steps 0–5 in full are for a
new screen, a redesign, a review, or any question about the design system. When the person iterates with
you on a feature and has said not to rebuild or screenshot until they say "done", their rule wins: render
in step 4 only when they ask, and say what you could not check.

## The workflow

Work through these steps in order. Step 0 and step 4 are the ones most often skipped, and they are
the ones that make the difference.

### 0. Read the product's design system before touching a screen

Find out what already exists, in three layers ([references/design-system.md](references/design-system.md)):

1. **Tokens** — color roles, type scale, spacing scale, radii, elevation, motion. Where: CSS
   variables, Tailwind config, `ThemeData` / `ThemeExtension`, a `tokens.json`.
2. **Components** — the shared widgets everyone should use: buttons, fields, rows, chips, cards,
   sheets, empty states. Where: `components/`, `widgets/`, a `kit`, an installed library.
3. **Patterns** — one shared surface per kind of job: confirm with a reason, pick one of a list,
   type a number, type one word, a detail panel, a list row, a filter sheet. These are usually the
   missing layer, and their absence is why a product grows 300 dialogs that all look slightly different.

Then **measure** how well the code keeps to it: run `scripts/ds_audit.sh <src-dir>` (literal colors,
font sizes, weights, paddings, radii and durations vs. token use; count of dialogs and sheets). Read
the numbers as a symptom map, not a grade: 300 `copyWith(fontWeight:)` overrides mean the type
scale does not cover what screens need; a second app with its own token file means two design systems.

Say what you found in two or three lines ("Tokens: yes, 4-pt spacing, two fonts. Components: 10,
no button or card. Patterns: none. Adherence: 18 % of paddings are literals; guest app has its own
theme."). If the user asks "do we have a design system and how good is it", this is the answer;
use the maturity scale in design-system.md.

**If a system exists, match it — never start a second one.** If it is thin, extend it (step 2) as
you go instead of styling the screen locally.

### 1. Decide direction, and what "premium" means to this product's buyer

"Make it pop" and "make it premium" leave the model to guess, and the guess is the AI default.
Decide before building ([references/direction.md](references/direction.md)):

- **Who judges this, and what reads as care to them?** Calm and warm (health), sharp and dense
  (trading, an operations console), playful (consumer). This is a decision, not an adjective.
- **Real references, not adjectives:** 2–4 real screens from shipped products solving the same
  problem (Mobbin, the category leaders) plus one anti-reference. Copy their *reasons*, not their pixels.
- **One decision only this product would make** — its own icon set, type, an illustration language, a
  status color system. "Fine" is the floor now; the signature is what says someone cared.
- Set the three dials (variance, motion, density) and say where this sits.

For a restructure — new navigation, merged screens, a new main screen, a new flow — **draw a mock
in the product's own tokens first and get approval of one area at a time.** Code written before
agreement on the shape gets written twice.

### 2. Build from the system, never around it

- **Use the component; if it is missing, add it to the system, not to the screen.** A screen that
  needs a styled list row gets the shared row, extended if necessary. One-off styling is how drift starts.
- **Use the pattern for the job.** Before writing a dialog or sheet, ask which job it is (confirm,
  pick one, number, word, detail, form, wizard) and use that shared surface. If the same job appears
  twice with different code, merge them — that is a behavioral consolidation, and it is usually worth
  more than any visual polish. Catalog and migration method in design-system.md.
- **Don't hand-build the hard interactive components.** Toasts that stack, drawers you can drag,
  command menus that work from the keyboard, animated numbers: use the specialist library or the
  platform's own component, then style it with your tokens ([references/libraries.md](references/libraries.md)).
  Default library styling is its own AI look — change radius, color and type so it looks like this product.
- Spacing, type, color, radius and motion come **only from tokens**. A literal (`13px`, `Color(0xFF…)`,
  `fontSize: 15`, `Duration(milliseconds: 180)`) needs a reason, or it goes into the tokens.

### 3. Compose the screen: the seven things every good UI has

Same components, very different results — the difference is these seven
([references/review-by-eye.md](references/review-by-eye.md) has the before/after detail):

1. **One focal point.** What is the screen for? Make that the biggest, highest-contrast thing and turn
   everything else down — usually by removing, not adding. One primary button; the second becomes
   secondary or a link.
2. **Spacing on a scale that groups.** 4/8-pt values only; a label sits closer to its input than
   groups sit to each other. Evenly spread padding is the AI tell: nothing looks grouped.
3. **Hierarchy from weight and color first, size second.** A title can be only a little bigger but
   heavier and darker; secondary text is quieter, not smaller-and-smaller. Few sizes per card.
4. **Color mostly neutral, one accent where it matters** — the primary action, focus, links, status.
   When everything is colored nothing stands out. Color that carries information (a chart, a status)
   beats color as decoration. Don't let the model pick the palette.
5. **Real content.** Real names, prices, counts, copy for this product. Placeholder content makes a
   finished design look like a template.
6. **The details match everywhere.** One radius family (nested radius ≤ parent), hairline borders,
   soft layered shadows (or lightening in dark theme), one icon set at one size and stroke, aligned
   edges on one grid.
7. **Motion comes from where the user acted.** A menu grows from its button, a sheet follows the
   finger, exits are faster than entrances, ease-out, short. No motion and same-fade-for-everything
   both read cheap.

Also **design for the content you can't see**: a card must work with a dark photo and a bright one,
a long name and a short one, 3 items and 300. Put text off the photo, give icons over images their
own plate, ellipsize, and test the extremes.

### 4. Render it and look — then judge it like a stranger

Never call UI done from the code. Render it at the real sizes (phone ~390, tablet ~820, desktop
1366–1440; dark theme if the product has one) with realistic data, open the image yourself, and
check:

- The seven questions above, answered yes one by one.
- The AI tells in [references/anti-slop.md](references/anti-slop.md) (emoji icons, gradient letter
  avatars, KPIs repeated across pages, cards that do nothing, purple glow, twin equal buttons…).
- Clipping, overlap, text running under a button, an empty column, a scroll inside a scroll.
- Every state: empty, loading, error, long list, one item, disabled, offline.

Fix what you see and look again. A screenshot of the problem pasted back is the fastest bug report;
use it on yourself.

### 5. Measure and bake it in

Rerun `scripts/ds_audit.sh` and compare: no new literals, fewer one-off surfaces. Encode what you
added as tokens, component variants and patterns so the next screen gets it for free. Fix drift in
the shared layer (one fix, many screens), not screen by screen. One class of problem is one change.

## The accessibility floor is part of the craft

Text contrast ≥ 4.5:1 (≥ 3:1 large text and non-text UI: borders, icons, focus rings); touch targets
≥ 44 pt iOS / 48 dp Android / 24 px web (pad invisibly if the visual is smaller); a visible keyboard
focus indicator on everything focusable; honor reduced motion. Exact values and sources:
[references/standards.md](references/standards.md). A beautiful screen that fails these is broken.

## Interaction states: every state, every element — including the quiet ones

Default, hover (pointer), pressed, focus (`:focus-visible`), disabled, loading (inside the element,
no layout jump), error (inline, with a way out). Spend them on the structural controls too — tabs,
rows, chips, icon buttons, search — that is where "dead UI" hides. A control that looks actionable
must act or be visibly disabled. Forms: labels outside the field, validate on blur, errors next to
the field, don't pre-disable submit. Encode states as component variants (step 2), never per screen.

## Reference map — read what the task needs

| Read | When |
|---|---|
| [design-system.md](references/design-system.md) | Always at step 0; when asked about the design system; before merging screens |
| [direction.md](references/direction.md) | New product, redesign, "make it premium", choosing fonts and palette |
| [review-by-eye.md](references/review-by-eye.md) | Step 3–4; any review or "why does this look off"; lists, cards, filters, pricing |
| [anti-slop.md](references/anti-slop.md) | Step 4, every time |
| [libraries.md](references/libraries.md) | Toasts, drawers, command menus, animated numbers, picking a component library |
| [craft.md](references/craft.md) | Type, color and dark theme, motion, loading/empty, wizards, desktop shells, framing a decision |
| [standards.md](references/standards.md) | Any number: contrast, targets, durations, type ratio, dark-theme overlays |
| [web.md](references/web.md) | React, Tailwind, CSS variables, shadcn-style tokens, responsive |
| [angular-primeng.md](references/angular-primeng.md) | Angular with PrimeNG presets and tokens |
| [mobile.md](references/mobile.md) | Flutter / React Native: theme, haptics, keyboard, permissions |
| [marketing-landing.md](references/marketing-landing.md) | A page that must convince a stranger |
| [ux-writing.md](references/ux-writing.md) | Buttons, errors, empty states, one language per locale |

Multi-step flows: one question per screen, keep answers when going back, adapt the next step to the
last answer. Native desktop shells: platform cursors and selection, full titlebar set, OS drag.
Decisions: smart defaults, progress that never starts at 0 %, value before the ask, honest stakes.
Details for all three in [references/craft.md](references/craft.md).

## Pre-flight: before you call it done

- **System:** built only from tokens, components and patterns; anything new was added to the system,
  not the screen; the audit shows no new literals or one-off dialogs.
- **Seven things:** one focal point; spacing on the scale and grouped; hierarchy by weight/color;
  one accent; real content; details match; motion from the origin.
- **Rendered and looked at** at real sizes, both themes, with extreme content; no clipping.
- **States:** every interactive element and every data view, including empty/loading/error.
- **Accessibility floor** met.
- **Anti-slop scan** clean.
- **Restructure?** It was mocked and approved first.

## Review output format

When reviewing rather than building:

```
## Interface review
### Design system (step 0)
Tokens / components / patterns: <found, gaps>; adherence: <numbers from ds_audit>; maturity <0–4>.
### Strengths
- <what already works>
### Findings (ordered by impact; a class of problem, not a single place)
1. [Pattern] <issue> → <fix in the shared layer> — <why it matters to the person using it>
2. [Hierarchy] …
### Quick wins
- <1–3 small changes with outsized payoff>
```

Tags: System, Pattern, Direction, Focal point, Spacing, Typography, Color, Content, Details, Motion,
States, Accessibility, Anti-slop, Copy, Responsive. Lead with the highest-impact class, pair every
problem with a concrete fix, and prefer fixes that land in the shared layer.
