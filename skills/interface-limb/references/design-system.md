# Design system — find it, judge it, extend it, keep to it

A design system is not a Figma file or a color list. It is the shared layer that makes the
hundredth screen look and behave like the first without anyone trying. It has three layers, and a
product can be strong in one and empty in another.

## Contents
1. The three layers
2. Finding what exists, by stack
3. Judging it: the maturity scale and the audit
4. The pattern catalog: one surface per job
5. Extending a thin system without a rewrite
6. Consolidating duplicate surfaces
7. Keeping it: rules that stop drift

## 1. The three layers

| Layer | What it is | Typical size | What its absence looks like |
|---|---|---|---|
| **Tokens** | Named values: color roles (surface, on-surface, muted, primary, success, warning, danger), type roles (5–7 sizes, 2 weights), spacing scale (4/8-pt), radii (3–4), elevation, motion durations and curves | 30–60 names | Hex codes and pixel values in screens; three grays that are almost the same |
| **Components** | Shared widgets built from tokens, with all their states: button (primary/secondary/quiet/danger), field, list row, chip, card/section, sheet, dialog shell, empty state, status badge, avatar | 15–30 | Every screen styles its own button; hundreds of per-call style overrides |
| **Patterns** | One shared surface per *job*: confirm (with reason, with a second person's approval), pick one of a list, type a number, type one word, a detail panel, a filter sheet, a list screen (search, filter chips, list, detail), a wizard step | 8–12 | Each feature writes its own dialog; dozens of slightly different "pick one" sheets; several sign-in screens |

Tokens are where most products stop. Patterns are where quality is decided, because patterns
fix *behavior*: the same job always takes the same taps, looks the same, says the same words.

## 2. Finding what exists, by stack

- **Flutter:** `ThemeData` / `ColorScheme.fromSeed`, `ThemeExtension` subclasses (semantic colors),
  classes like `Space`, `Radii`, `Motion` with `static const`, a `widgets/` or `kit/` folder, shared
  `show…` helpers (`showAppSheet`, `confirmDanger`, `promptText`). Search: `extends ThemeExtension`,
  `static const double`, `Future<.*> show[A-Z]`, `Future<.*> pick[A-Z]`.
- **Web:** `:root` CSS variables, `tailwind.config` theme, `components/ui/` (shadcn copies), a
  `tokens.json`/Style Dictionary, Storybook stories. Search: `--color-`, `theme.extend`, `cva(`.
- **Angular/PrimeNG:** the preset (`definePreset`), `[dt]` overrides, shared components module.
- **Several apps in one repo:** check whether they share one theme package or each have their own.
  Two token files with two palettes are two design systems, even if both are "good".

Also look for documentation (a design-system doc, a component gallery, golden tests). No docs and
no gallery usually means the components exist only by convention, and new code will not find them.

## 3. Judging it

### Maturity scale (say the number and why)

| Level | Means |
|---|---|
| 0 | No tokens. Values typed in screens. |
| 1 | Tokens exist (colors, spacing, type), used inconsistently; components ad hoc. |
| 2 | Tokens used by most screens; a handful of shared components; no shared patterns. |
| 3 | Tokens + a component kit with states as variants + shared patterns for the common jobs; most screens built from them. |
| 4 | Level 3 plus documentation or a gallery, a check that blocks new literals, one system across every app of the product. |

### The audit

Run `scripts/ds_audit.sh <dir> [<dir>…]` from the skill folder (bash, no dependencies). It counts,
per directory, literal values against token use and the number of dialog/sheet openings. Read it as
ratios, and compare apps with each other:

- **Literal share** = literals / (literals + token uses), per kind (padding, gaps, radii, durations,
  colors). Under ~10 % is healthy; 20 %+ means the scale is missing values screens need, or the
  tokens are not discoverable.
- **Type overrides** (`copyWith(fontWeight/fontSize…)` on a text role, or `text-[15px] font-[650]`):
  many of them mean the type scale is wrong for the product (e.g. no "number" or "label" role), so
  every screen patches it. Fix the scale, then remove the patches.
- **Weight spread:** count distinct weights in use. More than 3 (e.g. 400/500/600/700/800) means
  hierarchy is being made by weight drift instead of roles.
- **Button/style overrides** (`styleFrom`, inline `className` piles): missing component variants.
- **Surface count** (dialogs + sheets + pages pushed): divide by distinct jobs (section 4). A ratio far
  above 1 means duplicate surfaces.

Numbers point; the rendered screens decide. Always confirm the top findings by looking at them.

## 4. The pattern catalog: one surface per job

Classify every dialog, sheet and pushed page by the job it does. Most products have these, and each
should exist **once**, as a shared function or component that takes data and returns a result:

| Job | Shared surface | Inside | Typical duplicates it replaces |
|---|---|---|---|
| Confirm something risky | `confirm(title, message, action, {reason, reasons, approval})` | What will happen in words, ready reasons as chips + own words, red action, a second person's approval when policy says | "Delete?", "Cancel order", "Remove member", "Refund" each with its own dialog |
| Pick one of a few | `pickOne(title, message, options)` | Rows with optional icon and subline, current marked and not offered, search from ~9 rows | Payment-method pickers, "which account", "which team", "photo source" |
| Type a number | `numberEntry(title, parse, shown, chips, confirm)` | Big value, its meaning under it, usual values as chips, the shared keypad, one button that says what it does, hardware keyboard | Amount, quantity, weight, tip, refund amount |
| Type one word | `prompt(title, label, validator, helper)` | One field, validation in place, a verb on the button | "Rename", "IP address", "note", "code" |
| Who are you / PIN | `whoAndPin(mode)` | Who (faces or number), the shared PIN field | Sign-in, lock, change user, manager approval, first PIN |
| Detail of a thing | `detailPanel(entity)` | Header, lines, actions grid, one primary action | Order or invoice card, a side panel, a preview sheet |
| A list of things | `listScreen(search, filterChips, rows, detail)` | Search that finds old items too, filter chips not tabs, sections by state, history below a line in the same row style | Tabs "active / history", separate boards per type |
| Filter a large set | `filterSheet` | Over the results (keep context), all criteria in one scroll, result count on the button ("Show 41 homes") | Filter wizards, one page per criterion |
| A form | `formSheet` / page with shared fields | Labels outside, validation on blur, primary at the bottom | Fine to have many; they share fields and layout |
| A multi-step flow | `wizard` | One question per step, back keeps answers | Dense two-column setup pages |

The **controls** inside follow the same logic: chips for choosing a known value (3 bedrooms), a
stepper for nudging a value you already have (quantity), a slider plus inputs for a range, a
segmented control for 2–4 exclusive modes, a switch for on/off that applies at once.

## 5. Extending a thin system without a rewrite

1. Fill the **token** gaps the audit showed (the missing type role, the missing spacing step) and
   point the patches at the new token.
2. Promote the **best existing implementation** of each component into the shared layer instead of
   inventing a new one; delete the copies as you touch them.
3. Add **patterns** one job at a time, each with its first two or three real users moved onto it in
   the same change, so it is proven and not dead code. A pattern without a user is speculation; build
   it with the screen that needs it.
4. Keep flows unchanged while migrating to a pattern (same steps, same taps); change the flow only in
   a separate, approved redesign. When unifying does change behavior (one tap becomes chip + confirm),
   say so and update the tests that relied on the old one.

## 6. Consolidating duplicate surfaces

1. **Inventory**: list every surface-opening call with file, function, title and what is inside
   (fields, chips, keypad, list). A small script over the source does this in minutes; reading files
   one by one does not scale past ~50 surfaces.
2. **Classify by job** (section 4), not by how it looks. Two dialogs that look different but both
   "pick one payment" are duplicates; a dialog with a name field and a seat stepper is a form, not
   "type one word".
3. **Verify before claiming**: check whether the low-level piece is already shared (a keypad, a PIN
   field) before reporting "eight keypads". The duplication is often one level up, in the window
   around it.
4. **Merge by class, one class per change**, with the shared surface and its migrated users together.
5. Count again; report "46 own pickers → 1 shared + 37 left, here is why".

## 7. Keeping it

- **No literal without a reason.** A new color, size or duration goes into tokens or gets a comment.
- **New job → new pattern, not a new dialog.** Before writing `showDialog`, name the job.
- **One system per product.** A second app gets the shared theme package, not its own palette.
- **Make it visible**: a short design-system doc (what each token, component and pattern is for),
  ideally a gallery screen or golden tests that render every component in every state.
- **Rerun the audit** before shipping a UI change; a rising literal count is a regression.
- **Guard tests in the build** turn the rules into failures instead of reminders: no spacing literal outside the
  scale, no color hex outside the theme, no duration or curve outside the motion module, no haptic call outside the
  feel module, every string key used and present in every language. A rule a test checks stays kept.
- **Behavior is part of the system:** the gesture grammar, the action classes and their way back, the feedback
  patterns and the attention ladder are written down next to the tokens ([interaction.md](interaction.md),
  [states.md](states.md)) and implemented once (a `SwipeAction`, an `Undo` toast, a `Pressable`, a `Feel` haptics map).
- **Handoff:** each component's spec lists its anatomy, sizes from tokens, all states, behavior (gestures, keyboard),
  accessibility (role, name), and the content extremes it was drawn with ([components.md](components.md)).
- **Versioning:** a change to a token or component says what it changes on screen; deprecations keep the old name
  working for a release and the audit counts remaining uses.
