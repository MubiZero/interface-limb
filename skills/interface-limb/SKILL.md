---
name: interface-limb
description: >-
  Design intelligence for application interfaces, system first and behavior included: before drawing a screen, find
  (or set up) the product's design system — tokens, shared components, one shared surface per kind of job, one grammar
  of gestures and feedback — learn who does which job in what conditions, build only from the system, then render the
  result at every width, press every control, and judge both how it looks and how it behaves. Use it whenever you
  plan, build, review, refine, redesign, mock or prototype any UI for a web, mobile or desktop app (screens, components,
  forms, dialogs, sheets, navigation, dashboards, onboarding, settings, checkout, POS/till and kiosk screens, admin
  panels, landing pages, empty/loading/error/offline states, gestures, animations, interactive mocks), and whenever
  someone asks "do we have a design system", "why does this look AI-made / vibe-coded", "make it premium", "add
  animations / swipes", "unify these screens", "too many dialogs", "review this mock", or "audit the UI", even if they
  never say the word design. Grounded in cited standards (WCAG 2.2, Material and Apple motion and targets, NN/g, Core
  Web Vitals). Covers React/Tailwind/CSS, Angular/PrimeNG, Flutter and React Native.
---

# Interface Limb

Good interfaces are not made screen by screen. They come from a small system — a few tokens, a few components, one way
to do each kind of job, one grammar of gestures and feedback — applied everywhere, from knowing who does what job in
which conditions, and from someone who looks at the rendered result, presses every control, and is honest about it.

AI-built UI fails in the opposite way. It builds every component from scratch, picks its own colors, gives every
element the same weight, fills it with placeholders, invents a new dialog for every job, leaves buttons that do
nothing or only pretend (a toast where a process should be), and never looks at what it drew. Each screen can be
"fine"; the product still reads as vibe-coded and behaves as if nobody used it.

This skill is a workflow, not a list of tips. The detail lives in the reference files; the workflow makes sure it is
applied in the right order and to the right layer.

**Size the workflow to the change.** A one-property fix (a gap, a color, a word, one missing state) skips steps 0, 1, 2
and 6: make it with the existing tokens and say so. The full loop is for a new screen, a redesign, a mock, a review, or
any question about the design system. When the person iterates with you and has said not to rebuild or screenshot
until they say "done", their rule wins: render and press in step 6 only when they ask, and say what you did not check.

## The workflow

### 0. Read the product's design system before touching a screen

Find out what exists, in four layers ([design-system.md](references/design-system.md)):

1. **Tokens** — color roles, type scale, spacing, radii, elevation, motion (durations, curves, one spring).
2. **Components** — the shared widgets: buttons, fields, rows, chips, tiles, sheets, toasts, empty states
   ([components.md](references/components.md)).
3. **Patterns** — one shared surface per job: confirm with a reason, pick one, type a number, a detail panel, a filter
   sheet. Usually the missing layer, and the reason a product grows 300 slightly different dialogs.
4. **Behavior** — the gesture grammar, the action classes and their way back, the feedback patterns and the attention
   ladder ([interaction.md](references/interaction.md), [states.md](references/states.md)). Usually not written down
   at all, which is why every screen behaves a little differently.

Measure adherence with `scripts/ds_audit.sh <src-dir>` (literals vs tokens, dialog counts) and read the numbers as a
symptom map. Say what you found in two or three lines. **If a system exists, match it; never start a second one.**

### 1. Learn the people and their jobs

Before a new screen, a redesign or a mock, write four lists ([discovery.md](references/discovery.md)):

- **Roles and conditions:** who, holding what, standing where, how hurried, on a shared device or their own, how
  trained, in which language.
- **Jobs as steps,** including the unhappy ones (change it halfway, two at once, correct it after, hand it over, the
  network drops, the first empty day, the busiest day) — and the screen each step happens on.
- **Inventory:** every control and state the screen has today (the shell's quiet ones too: update, profile, sync,
  language) plus everything approved in earlier rounds.
- **Variants:** modules off, roles, plans, offline, locales, devices.

Every device gets the same jobs. Do not invent mechanisms (a numbering, a money flow, an undo for something final) in
passing. Pick the context's weights ([contexts.md](references/contexts.md)): an operations till, an admin, a SaaS
dashboard and a consumer app value different things.

### 2. Decide direction, and what "premium" means to this buyer

Decide before building ([direction.md](references/direction.md)): who judges it and what reads as care to them; 2–4
real references from shipped products plus one anti-reference; one decision only this product would make; the dials
(variance, motion, density).

For a restructure — new navigation, merged screens, a new main screen, a new flow — **mock it in the product's own
tokens and get approval one area at a time** ([redesign.md](references/redesign.md)); when behavior matters, make the
mock interactive and alive ([prototype.md](references/prototype.md)). Code written before agreement is written twice.

### 3. Build from the system, never around it

- **Use the component; if it is missing, add it to the system, not to the screen.**
- **Use the pattern for the job** ([design-system.md](references/design-system.md),
  [patterns.md](references/patterns.md)); two surfaces for one job get merged.
- **Use the behavior layer:** the shared swipe row, undo toast, pressable, haptics map, motion module
  ([motion.md](references/motion.md)) — screens never pick their own curve, duration or haptic.
- **Don't hand-build the hard interactive components** (stacking toasts, draggable sheets, command menus): use the
  specialist library or the platform's own and style it with your tokens ([libraries.md](references/libraries.md)).
- Spacing, type, color, radius and motion come **only from tokens**; guard tests keep it so.

### 4. Compose the screen: seven things every good UI has

([review-by-eye.md](references/review-by-eye.md), [visual.md](references/visual.md),
[layout.md](references/layout.md))

1. **One focal point** — the screen's job is the biggest, highest-contrast thing; one primary action.
2. **Spacing on a scale that groups** — 4/8 values; related things closer than groups.
3. **Hierarchy from weight and color first, size second.**
4. **Color mostly neutral, one accent where it matters**; status colors with words.
5. **Real content** — real names, prices, counts, in the product's language.
6. **Details match everywhere** — one radius family, one icon set, tabular numbers, one image frame.
7. **Repeated elements measured on the data** — one anatomy, reserved by the real content, columns chosen by the text.

Design for the content you cannot see: a dark photo and a bright one, a short name and a long one, 1 item and 300, 200 %
text, the longest language.

### 5. Design the behavior: seven questions

([interaction.md](references/interaction.md), [states.md](references/states.md), [input.md](references/input.md),
[motion.md](references/motion.md))

1. **Does every visible control act** — and does a button that stands for a process open that process?
2. **Does every action have its way back,** by its class: reversible → «Undo»; created → removable, empty ones go by
   themselves; final → named as final with a separate inverse; opened → closes by drag, scrim, Esc, back?
3. **One gesture grammar,** each gesture with a visible alternative; long press opens choices, never acts.
4. **Is the consequence visible before the commit** (change due, shortfall, new total, end time), with the fix offered
   in place rather than in a second round?
5. **Does each message use the one pattern for its kind** — toast, field line, status icon that acts, blocking
   banner, or a card on every screen for an event that waits for someone?
6. **Do scroll and focus follow the action** — the new item comes into view, a refusal shows its reason on the item,
   the start action never scrolls away, a short screen scrolls with a sticky primary action?
7. **Does motion come from one module and from where the user acted** — a real spring for arrivals, exits faster,
   only transform and opacity, reduced motion honored live?

### 6. Render it, press it, judge it like a stranger

Never call UI done from the code.

- **Render every width you support** (360, 390–412, 768, 1024, 1366, 1440) and the dark theme, with a realistic day of
  data and an empty first day; open every image yourself (`scripts/shoot_widths.sh` — phones through iframes, because
  headless Chrome will not go below ~500 px; a hidden browser tab does not run transitions, so its screenshots lie).
- **Press every control** (`scripts/dead_buttons.js`): something other than the control itself must change.
- **Walk each job end to end** through all its screens on each device, and switch each variant.
- **Check** the seven things, the seven questions, the anti-slop list ([anti-slop.md](references/anti-slop.md)),
  clipping and overlap, every data state ([states.md](references/states.md)), the accessibility floor.
- For a review or a critic, brief with the jobs and ask to measure ([critique.md](references/critique.md)).

Fix what you find and look again. A fix at one width breaks another: re-render all of them.

### 7. Measure and bake it in

Rerun `scripts/ds_audit.sh`; encode what you added as tokens, component variants, patterns and behavior rules, with
guard tests, so the next screen gets it for free. Fix drift in the shared layer, not screen by screen. Keep the record
of the owner's remarks next to the mocks and re-read it before the next round.

## The accessibility floor is part of the craft

Text contrast ≥ 4.5:1 (≥ 3:1 large text, icons, borders, focus rings); touch targets ≥ 44 pt iOS / 48 dp Android /
24 px web minimum; a visible focus indicator on everything focusable; every gesture with a single-tap alternative;
anything timed can be paused; reduced motion honored; text to 200 %. The rest in
[accessibility.md](references/accessibility.md), numbers in [standards.md](references/standards.md).

## Interaction states: every state, every element

Default, hover, pressed (within 100 ms), focus-visible, disabled (with readable words that say why), loading (inside the
element, no layout jump), error (inline, with a way out) — on the structural controls too: tabs, rows, chips, icon
buttons, search. Encode them as component variants, never per screen.

## Reference map — read what the task needs

| Read | When |
|---|---|
| [design-system.md](references/design-system.md) | Step 0 always; questions about the system; merging screens; guard tests, handoff |
| [discovery.md](references/discovery.md) | Step 1: roles, jobs, inventory, variants; navigation and information architecture |
| [contexts.md](references/contexts.md) | Operations/POS/kiosk, admin, SaaS, consumer, large screens, desktop shells; trust and dark patterns |
| [direction.md](references/direction.md) | New product, redesign, "make it premium", fonts and palette |
| [redesign.md](references/redesign.md) | Any restructure or mock: the process, rules while drawing, the remarks register |
| [prototype.md](references/prototype.md) | Interactive mocks: alive controls, the mock layer, press-everything and width checks |
| [layout.md](references/layout.md) | Grids, density, tiles/rows/cards measured on data, master–detail, the thumb half |
| [visual.md](references/visual.md) | Type, color and dark theme, icons, photos, text over images |
| [components.md](references/components.md) | Which control for which job; anatomy and states of each |
| [patterns.md](references/patterns.md) | Search, tables, drafts/tabs, sign-in/PIN, checkout, assigning people, wizards, framing decisions |
| [interaction.md](references/interaction.md) | Gestures, the way back, compound targets, first-tap reliability, sheets, scroll/focus, keyboard |
| [motion.md](references/motion.md) | The motion module, named moves, the spring, reduced motion, verifying motion |
| [states.md](references/states.md) | Feedback patterns, attention ladder, toasts, loading/empty/error/offline, badges |
| [input.md](references/input.md) | Forms, numbers and money, codes and PINs, required choices, pickers, scanners |
| [ux-writing.md](references/ux-writing.md) | Buttons, errors, empty states, tone |
| [i18n.md](references/i18n.md) | Plurals, names in sentences, expansion, RTL, number/date/money formats |
| [accessibility.md](references/accessibility.md) | Beyond the floor: semantics, focus, gestures, time, reflow, cognitive load |
| [performance.md](references/performance.md) | Response and frame budgets, layout shift, slow devices |
| [critique.md](references/critique.md) | Reviews, heuristics, briefing critics and agents, testing with people |
| [review-by-eye.md](references/review-by-eye.md) | Steps 4 and 6: render protocol, the seven questions in detail, checks |
| [anti-slop.md](references/anti-slop.md) | Step 6, every time: visual and behavior tells |
| [libraries.md](references/libraries.md) | Toasts, drawers, command menus, animated numbers; picking a library |
| [standards.md](references/standards.md) | Any number: contrast, targets, durations, springs, gestures, WCAG 2.2 |
| [web.md](references/web.md) · [angular-primeng.md](references/angular-primeng.md) · [mobile.md](references/mobile.md) | Stack specifics |
| [marketing-landing.md](references/marketing-landing.md) | A page that must convince a stranger |

## Pre-flight: before you call it done

- **System:** built only from tokens, components, patterns and the behavior layer; anything new went into the system;
  the audit shows no new literals or one-off dialogs.
- **Discovery:** the four lists exist; every inventory item is present, moved or dropped by a recorded decision; every
  device has the same jobs; nothing invented in passing.
- **Look:** the seven things; real content; extremes of content; every width; both themes; 200 % text.
- **Behave:** the seven questions; every control pressed with an effect beyond itself; each job walked end to end
  through all its screens; each variant switched.
- **States:** every data view in all its states; every message in its pattern.
- **Accessibility floor** met; **anti-slop scan** clean (visual and behavior tells).
- **Restructure?** Mocked and approved one area at a time; remarks recorded; no earlier remark regressed.
- **Said what was not checked** (real device touch, sound, screen reader, slow device).

## Review output format

When reviewing rather than building:

```
## Interface review
### Design system (step 0)
Tokens / components / patterns / behavior: <found, gaps>; adherence: <ds_audit numbers>; maturity <0–4>.
### Jobs walked
<role · job · devices · where it broke>
### Strengths
- <what already works>
### Findings (ordered by impact; a class of problem, not a single place)
1. [Behavior] <issue> → <fix in the shared layer> — <why it matters to the person> — <checked live | read in code>
2. [Hierarchy] …
### Not checked
- <real device touch, sound, screen reader, …>
### Quick wins
- <1–3 small changes with outsized payoff>
```

Tags: System, Pattern, Behavior, Way back, Feedback, Input, Motion, States, Layout, Direction, Focal point, Spacing,
Typography, Color, Content, Details, Accessibility, Anti-slop, Copy, Responsive, Performance, Trust. Lead with the
highest-impact class, pair every problem with a concrete fix, prefer fixes in the shared layer.
