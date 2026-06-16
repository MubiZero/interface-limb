---
name: interface-limb
description: >-
  Design intelligence for building and improving application interfaces — apply
  whenever you plan, design, build, implement, review, refine, or fix any UI for a
  web or mobile app: screens, components, forms, navigation, dashboards, onboarding,
  settings, modals, whole app shells, and marketing/landing pages (hero, social
  proof, conversion CTAs), including their empty/loading/error states.
  Turns generic, "developer-default" output into interfaces that feel considered and
  high-quality, grounded in concrete cited standards (WCAG contrast & target sizes,
  Material/Apple motion & dark-theme values, modular type scales, interaction states,
  haptics). Covers web (React/Tailwind/CSS, Angular/PrimeNG) and mobile (Flutter/React
  Native). Reach
  for this on ANY frontend/UI work — building from scratch or elevating existing
  screens — even when the user just says "build the login screen," "make a dashboard,"
  "design the settings page," or "improve how this looks," without naming design
  explicitly.
---

# Interface Limb

This is the design layer you bring to every interface you build — a natural extension
of how you write the UI, not a separate step. Great app UI doesn't come from technical
complexity; it comes from dozens of small, non-obvious decisions, applied consistently,
by someone who understands how people actually perceive and use a screen. The same
feature, built by a junior or a senior with the same framework, differs entirely in the
handling of hierarchy, spacing, states, motion, and the empty/loading moments. This skill
makes that handling explicit and backs it with cited standards — so the UI you ship feels
considered, not "developer-default."

Apply it whenever you touch an interface:
- **Building** a new screen or component — work the principles below in *as you go*, from
  the first layout decision, not as a cleanup pass bolted on afterward.
- **Improving / refining** existing UI — elevate screens that look generic, flat, or basic.
- **Reviewing** UI — audit against each section and report concrete fixes (format at the end).

The goal is never decoration for its own sake. Every principle here exists to make
the interface easier to understand and more pleasant to trust. When you apply one,
say *why* it helps, not just *what* to change.

## How to use this skill

The flow is **direction → build → pre-flight**, not "write code then maybe polish."

1. **Decide the direction first** (section 0, details in [references/direction.md](references/direction.md)).
   Read the brief *and the existing codebase*; pick a deliberate aesthetic instead of defaulting to
   the generic AI look. Skipping this is the #1 reason AI UI looks templated.
2. Identify the platform — web, mobile, or both — and read the matching reference file for concrete
   API/token guidance:
   - [references/web.md](references/web.md) — React, Tailwind, CSS variables, responsive, shadcn-style tokens.
   - [references/angular-primeng.md](references/angular-primeng.md) — Angular + PrimeNG styled-mode presets, design
     tokens, `[dt]`/`[pt]` overrides (not `::ng-deep`), `@defer` loading, dark mode. Read this when the stack is
     a component library, not hand-authored Tailwind — `web.md`'s general rules still apply on top.
   - [references/mobile.md](references/mobile.md) — Flutter / React Native, haptics, keyboard, permissions.
   - [references/marketing-landing.md](references/marketing-landing.md) — for landing / marketing pages: hero anatomy,
     social proof, conversion flow, scan patterns. Read this when the screen has to *convince a visitor*, not just
     serve a logged-in user — it sits on top of the platform rules above.
3. Keep [references/standards.md](references/standards.md) open — the cited cheat-sheet of the exact
   numbers (contrast ratios, target sizes, motion durations, dark-theme overlays, type scale). Use
   those figures instead of guessing; this file states the principle, that file gives the value and source.
4. Build through the principles below — foundations (hierarchy, spacing, type) first; depth and color
   next; then states, motion, and the empty/loading moments. As you go, avoid the tells in
   [references/anti-slop.md](references/anti-slop.md) and write copy per [references/ux-writing.md](references/ux-writing.md).
5. Bake the result into the component system, not one-off screens (section 9), then run the
   **Pre-flight checklist** before calling it done.

**The accessibility floor is part of the craft, not separate from it.** A beautiful UI that keyboard
users can't focus, or whose text fails contrast, isn't high-quality — it's broken with a nice coat of
paint. The non-negotiable minimums: text contrast **≥ 4.5:1** (≥ 3:1 for large text and non-text UI
like borders/icons/focus rings); touch targets **≥ 44pt (iOS) / 48dp (Android) / 24px (web)**; and a
visible keyboard focus indicator on everything focusable. Full values and sources in
[references/standards.md](references/standards.md).

---

## 0. Direction: decide what this should be

Before tokens and components, decide *what you're making* — otherwise you'll reach for the reflexive
default and the result will look machine-generated. Full method in [references/direction.md](references/direction.md);
the essentials:

- **Read the brief and the codebase.** Infer page kind, audience, vibe, and any hard constraints
  (regulated industry, accessibility). If a design system already exists (CSS vars, Tailwind config,
  component library, fonts), **match it — don't rewrite it.** State a one-line *Design Read* so your
  direction is explicit and correctable, and ask at most one clarifying question.
- **Set three dials to the brief:** DESIGN_VARIANCE (safe ↔ asymmetric), MOTION_INTENSITY (static ↔
  choreographed), VISUAL_DENSITY (spacious ↔ cockpit). A meditation app and an analytics cockpit sit at
  opposite ends; say where yours sits and why.
- **Pick a real aesthetic, not adjectives.** Write a one-sentence *scene* (who uses this, where, in what
  mood), name concrete anchor references and an anti-reference, then sanity-check: if you could guess the
  look from the product category alone, push further.
- **Tailor to the vertical.** The same component is designed differently for fintech vs. kids vs. a
  dashboard — palette, density, motion, and trust signals all shift. (Table in direction.md.)
- For a **redesign**, work **Scan → Diagnose → Fix**: read the stack, list every generic pattern and
  *missing state*, then upgrade in max-impact order (fonts → color → states → layout → components →
  loading/empty/error → type polish) — working *with* the existing stack, not replacing it.

---

## 1. Foundations: make it self-explanatory

A good interface tells you how it works without a manual. Two ideas do the heavy lifting:

- **Signifiers** — visible cues that an element is interactive: a button looks pressable,
  an input looks fillable, a row with a chevron looks tappable. If a thing does something,
  it should *look* like it does something.
- **Affordances** — the action the element actually allows. Keep signifier and affordance
  honest: nothing should look tappable but do nothing, and nothing interactive should look
  like dead text.

When you place an element, ask: "Would a first-time user know what this does and that they
can touch it?" If not, the fix is usually a clearer signifier (contrast, a border, an icon,
a shadow on press), not a tooltip.

## 2. Visual hierarchy: control the eye

Size, position, and color decide what the user looks at first. This is the backbone of
premium feel — without hierarchy, even beautiful components read as noise. The failure mode
to fear is **flatness: when every element shares the same size and weight, nothing stands
out, the user has no entry point, and "everything is important" collapses into "nothing is."**

You have three levers to direct the eye — use all three, not just size:

- **Size** — bigger = more important.
- **Contrast** — a brighter/heavier element pulls focus from quieter ones.
- **Negative space** — isolation is emphasis; an element with room around it reads as
  important even at the same size (see section 3).

Apply them like this:

- **Most important = bigger and higher.** Promote the primary value/action with size and
  top placement. Demote secondary info by making it smaller and quieter (lower contrast,
  muted color), not by hiding it.
- **Place key elements along the natural scan path.** The eye doesn't read a screen evenly.
  Text-dense pages get scanned in an **F-pattern** (two horizontal sweeps near the top, then a
  vertical skim down the left edge); sparse, visual pages — landing heroes, splash screens — get
  scanned in a **Z-pattern** (top-left → top-right, diagonal down, then bottom-right). Put the
  load-bearing elements *on* those lines instead of fighting them: logo top-left, primary nav or
  CTA top-right, the headline first in the flow, and the conversion action where the path ends.
  Aligning to the scan path is the cheapest way to control attention.
- **Use imagery as accents and scan anchors.** A well-placed product image, avatar, or
  thumbnail gives the eye a fixed point and makes a list scannable far faster than text
  alone — this is why marketplace apps (e.g. Uzum-style storefronts) lean on imagery.
  Use it deliberately, not as filler.
- **Contrast is a tool, not a default.** Reserve your strongest contrast for the one thing
  that matters most on the screen. If everything shouts, nothing is heard.

## 3. Spacing and layout: let it breathe

- **Whitespace beats rigid grids.** Don't obsess over snapping every element to a strict
  grid. The more impactful skill is using generous, intentional space to group related
  things and separate unrelated ones. Cramped is the #1 tell of an amateur layout.
- **Use a 4px spacing system.** Pick spacing values from a 4px scale (4, 8, 12, 16, 24,
  32, 48…). This isn't superstition — a shared base unit makes every gap relate to every
  other gap, producing a quiet mathematical harmony the user feels but can't name. Avoid
  arbitrary `13px` / `7px` values.
- **Group by proximity.** Elements that belong together sit close; a clear gap signals a
  new group — proximity communicates structure more cheaply than borders or boxes. Don't crowd
  a secondary or optional path (a quiet "Skip" / fine-print link) against the primary CTA;
  separate it with real whitespace. Prefer that gap to a divider line, which overshoots a
  centered, narrower element and reads as a stray rule.
- **Verify spacing renders — don't just declare it.** A more-specific descendant reset (the
  classic `.card p { margin: 0 }`) silently zeroes a `margin-top` you set on a child for
  separation, collapsing the gap back to nothing — and it's invisible in the source, so it
  survives review. When a deliberate gap "isn't showing up," suspect an override: scope your
  rule to win (`.card .alt`, not bare `.alt`) and confirm the *computed* gap, not just the
  declaration. This single trap is the most common reason intended whitespace vanishes.

## 4. Typography: one font, tuned well

You don't need a fancy type system. One quality sans-serif, used with care, looks more
professional than three fonts thrown together.

- **Type carries the brand's emotion before a word is read.** The face *is* a message: the
  same headline set wrong can turn a serious, well-funded product into a discount flyer, or a
  playful app into a tax form. Choose the family for the feeling the vertical needs (mood and
  vertical pairings in [references/direction.md](references/direction.md)) — then tune it.
  **Readability outranks novelty every time:** a clever font nobody can read is a worse choice
  than a plain one they can. Keep to a **"rule of two": at most 2 (occasionally 3) families** —
  fewer, used well, always beats more.
- **One good sans-serif is enough.** Establish a small type scale from that single family
  using weight and size. Generate the sizes from a **modular scale** (`size = base × ratio^n`)
  with a ratio of **1.25** or **1.333** rather than picking sizes arbitrarily — this is the same
  4px-style harmony applied to type.
- **Use two well-separated weights, not three close ones.** e.g. 400 body / 700 heading; the
  weak 400/600 pairing doesn't read as a hierarchy. Max two families total.
- **Tighten letter-spacing slightly on larger text.** Headings (≥~32px) look more refined with
  a touch of negative tracking (`-0.01em` to `-0.03em`). Body text stays at 0.
- **Tune line-height for readability.** Body copy wants ~`1.5`; headings tighter (`1.1–1.2`).
  Default browser line-heights are a giveaway of unconsidered type.
- **Keep the measure comfortable.** Cap text line length at ~**66 characters** (`max-width: 66ch`);
  past ~80 the eye loses its place returning to the next line.
- **Match icon size to the line height of adjacent text.** An icon next to a label should
  share its optical height and baseline so the pair reads as one unit. Mismatched icon/text
  sizing is a small thing that quietly cheapens a UI.

## 5. Color and depth

- **One brand color, plus a semantic set, in roughly 60-30-10 proportion.** A single primary
  brand color for identity and key actions; a small semantic palette — success, warning, error,
  info — for status. Allocate the screen ~60% neutral background / ~30% secondary surface /
  ~10% accent. Don't overload the brand color with meanings it shouldn't carry.
- **Light-theme shadows: soft, layered, faint.** Real elevation comes from two light sources —
  a soft ambient shadow plus a sharper offset key shadow — so stack **2–3 box-shadow layers**,
  not one blur. Keep opacities low (ambient ~12%, key ~14–20% black) and increase **blur/spread**
  (not opacity) with elevation. A single harsh dark drop shadow reads as dated — the user should
  sense depth, not see the shadow.
- **Dark theme is not "light theme inverted."** Three rules change:
  - **Base surface is dark gray `#121212`, not pure black.** Black kills shadow visibility and
    fatigues the eye under light text.
  - **Create depth by lightening, not by shadow.** On dark backgrounds shadows barely show.
    Make elevated surfaces *lighter* than what's behind them via a white overlay that scales with
    elevation (e.g. ~5% at 1dp up to ~16% at 24dp) — a card floats because it's a brighter shade.
  - **Dial down text and borders, and desaturate brand colors.** Never pure-white body text — it
    vibrates; use ~**87% / 60% / 38%** opacity for primary / secondary / disabled text over
    near-white. Use low-contrast hairline borders. Saturated brand hues also vibrate on dark —
    shift them to lighter, less-saturated tones.
- **Text over images: gradient or blur, not a flat scrim.** When text sits on a photo, avoid
  dumping a solid dark overlay that flattens the image. Use a linear gradient (transparent →
  dark toward the text) or a progressive/graduated blur so the photo stays attractive while
  the text stays legible.

## 6. Interaction states: every state, every element

This is where "premium" is won or lost. The teams behind Linear/Vercel/Stripe audit **six
microstates** on every interactive element before shipping it. Anything a user can touch must
visibly respond to each situation it can be in:

- **Default** — the resting look.
- **Hover** (pointer platforms) — a clear but subtle shift signaling "this is reachable."
- **Pressed / active** — immediate feedback at the moment of contact (see motion below).
- **Focus** — a visible keyboard focus indicator (`:focus-visible`, not `:focus`). Never
  `outline: none` with nothing in its place — that's an accessibility failure. A solid **2px
  outline at ≥ 3:1 contrast** against the unfocused state is the simplest thing that satisfies it.
- **Disabled** — obviously inert (reduced contrast), and not hoverable/pressable.
- **Loading** — the element shows it's working (spinner-in-button, skeleton, progress), with the
  indicator *inside* the element so layout doesn't jump.
- **Error** — for inputs and flows, a clear, specific error state with a path to recovery.

Hit two floors while you're here: every interactive element meets the **target-size minimum**
(44pt iOS / 48dp Android / ≥24px web — pad transparently if the visual is smaller), and every
state keeps **≥ 3:1 contrast** for its non-text cues (borders, icons, the focus ring itself).

**Form fields** have their own premium tells: validate **on blur, not on every keystroke** (and
never block typing); show errors **inline, next to the field**; use **persistent labels outside
the field** — placeholder-as-label is harmful because it vanishes on focus and often fails
contrast; and **don't pre-disable the submit button** — let the user submit so validation can
surface, disabling only during the in-flight request.

Skipping states is the most common reason a UI feels "unfinished" even when it functions.

**Spend the states on the quiet controls too, not just the hero button.** The trap is lavishing
six microstates on the primary CTA while every *structural* control stays dead: breadcrumbs, nav
items, tabs, icon buttons, search fields, list rows, avatars, chips, table headers. Those are
exactly where "dead UI" hides, because they look finished while doing nothing on hover/focus/press.
Before you call a screen done, point at each thing that *looks* touchable and confirm it visibly
responds — if it doesn't, it reads as a screenshot, not an app.

**A control that looks actionable must actually act** (or be visibly `disabled`). A Search button,
toggle, or menu trigger that does nothing when used is worse than not drawing it — it breaks the
trust the rest of the polish buys. Wire the core interaction (a search control expands to a focused
input, a toggle flips), or at minimum give a real focus/press response and a clear destination.

**Mobile keyboard handling** is a flagship tell of a high-class app: when the keyboard
appears, inputs should smoothly move into view and never be covered, with the surrounding
layout adapting gracefully. See [references/mobile.md](references/mobile.md).

## 7. Micro-interactions and motion

Subtlety is the rule. Animation should confirm and guide, never perform.

- **Respond within 100ms.** Press/hover/selection feedback must *begin* within ~100ms to feel
  instantaneous — that's the perception budget. If an action can take longer than ~1s, show a
  loading indicator; longer than ~10s, show determinate progress.
- **Press feedback.** A button should physically acknowledge the press — a slight scale-down
  (e.g. to ~0.96–0.98) and/or a brief color/elevation change — then spring back. This tiny
  cue confirms the user's intent landed.
- **Optimistic UI.** When success is very likely, update the UI immediately and reconcile when
  the server responds; on failure, roll back or offer Undo. Waiting on the network for every
  toggle feels sluggish; optimism feels premium.
- **Haptics (mobile).** A light vibration on a toggle flip, a successful submit, or a
  selection change creates physical trust in a digital action. Match weight to importance, use
  sparingly (overuse trains users to disable it), don't double up on haptics the OS controls
  already play, and sync the tick to the visual change. See [references/mobile.md](references/mobile.md).
- **Pick durations by scale, and make exits faster than entrances.** Micro-feedback (toggle,
  hover) **100–150ms**; standard transitions (dropdown, tooltip) **200–300ms**; large/modal
  **400–500ms**. Never exceed ~500ms for routine motion — past that it drags. Use **ease-out**
  for elements *entering* and **ease-in** for elements *leaving* (an exit can be ~30% shorter,
  since the user no longer needs to track it). Avoid linear easing; animate only `transform`
  and `opacity`, never `transition: all`.
- **Respect reduced-motion.** Honor the OS/browser "reduce motion" setting — replace large
  translation/scale/parallax with a near-instant opacity fade, but keep *essential* motion
  (like a loading spinner). Make it one global switch, not per-component.

## 8. Loading and empty states: the moments most people skip

These are exactly where premium products distinguish themselves, because most don't bother.

- **Match the loading indicator to the wait.** Under ~1s, show nothing. For ~2–10s, use a
  spinner for a single module or a **skeleton** for a full-page load. Past 10s, use a progress
  bar. Skeletons must **mirror the final layout exactly** so content swaps in without shifting.
  Add a small **show-delay (~150–300ms)** and a **minimum visible time (~300–500ms)** so the
  indicator never flashes. A shimmer sweep signals ongoing work and shortens the perceived wait
  (honor reduced-motion).
- **Empty states do three jobs:** communicate status (is it loading, errored, or genuinely
  empty?), teach in context ("Star items to see them here"), and offer a **direct primary
  action** to fill it. Phrase the title **positively** ("Start by adding your first project",
  not "You have no projects"). First-use empty states are your best onboarding surface — better
  than a forced upfront tutorial.
- **Prime permissions before requesting them.** Never fire a system permission dialog (camera,
  notifications, location) cold or at launch. First show a contextual screen that explains *why*
  and what the user gains, triggered **just-in-time** when they tap the feature — then call the
  system prompt. Giving a reason measurably raises grant rates (research shows ~12%, up to ~81%
  with a strong rationale). On denial, explain the cost and offer a path to Settings.

## 9. Systematize it

A premium feel only scales if it lives in the component system, not in scattered screens.

- Encode states (default/hover/pressed/focus/disabled/loading/error) as **component variants**,
  so every instance gets them for free.
- Encode spacing, color, radius, shadow, type, **motion durations and easing curves** as
  **design tokens** (CSS variables / Tailwind theme / Flutter ThemeData), so a change propagates
  everywhere and nothing drifts. Named motion tokens (`duration-short`, `ease-enter`) keep
  animation consistent instead of scattered magic numbers.
- Build empty, loading, and error states as **first-class states of the component**, not
  afterthoughts bolted on later.
- **Keep radii concentric** — a child's border-radius should be ≤ its parent's so nested curves
  stay parallel. And **persist meaningful view state in the URL** (filters, tabs, selection) so
  refresh, back, and share all work — a quiet but unmistakable sign of a considered product.

The platform reference files show concretely how to express these in React/Tailwind, in
Angular/PrimeNG, and in Flutter/React Native.

## 10. Avoid the AI-default look

Good fundamentals aren't enough — you also have to dodge the patterns that make a UI read as
machine-generated. These are *bans*: if you're about to ship one, rewrite. The worst offenders (full
list with reasons in [references/anti-slop.md](references/anti-slop.md)):

- **No fake product UI built from divs** (fake terminals/dashboards/chats to fill a hero) — use a real
  or generated image. This is the single biggest "obviously AI" tell.
- **No em-dashes (—) in copy** — the strongest text tell; use commas, colons, or parentheses.
- **No default Inter + purple/blue glow gradient + nested cards** — the AI-SaaS uniform. Pick a
  non-default font (Geist, Outfit, Satoshi…), a deliberate palette (neutral base + one committed
  accent, not AI-cream/beige), and never nest a card in a card.
- **No identical card grids, eyebrow-on-every-section, or >2 consecutive image/text zigzags** — vary
  the layout families across a page.
- **No buzzwords or Lorem/“John Doe”/round fake numbers** — write real copy and realistic content.
- **Context flips the rules:** AI-purple is right for a chatbot but wrong for fintech/health/legal,
  which want restraint and trust signals. Check the choice against the vertical.

## 11. Words are UI

Copy carries as much of the "considered" feeling as spacing does. Full library in
[references/ux-writing.md](references/ux-writing.md); the load-bearing rules:

- **Buttons = verb + object, named for the outcome:** "Save changes", "Create account", "Delete 5
  items" — not "OK" / "Submit" / "Yes". "Cancel" → "Keep editing" when that's clearer.
- **Make CTAs intent-driven, and never leave a dead end.** Name the button for the action the user
  is about to take — "Book a demo", "Start free trial" — not a vague "Contact us" or "Learn more".
  And the foot of every screen or flow should offer one obvious next step (the primary action
  repeated, or the logical follow-on), so the user is never stranded at the bottom wondering what to
  do next.
- **Errors never blame the user and answer what/why/next:** "Email addresses need an @ symbol. Try:
  name@example.com" — placed inline with `role="alert"`, active voice, no "Oops!".
- **Loading copy is specific and time-boxed** ("Analyzing… ~30–60s"); empty/no-results copy suggests a
  next step, not a bare "0 results".
- **Terminology lock:** one word per concept across the product (Delete, not Delete/Remove/Trash).
- **One language per locale.** Inside a single locale the UI speaks one language — no "Step 1 / Owner
  code / Update channel" stranded inside a Russian screen, no Russian words forgotten in English. This
  is about **mixing**, not about Latin script as such: for an en-locale Latin is correct, and brand
  names ("Stripe"), technical identifiers (slug, hostname, timezone) and established acronyms (PC, VIP,
  API) are fair-game exceptions in any locale. The rule is *don't half-localize.*
- **Strings are unified and really translated, not faked.** A phrase with a count or variable is one ICU
  message (`{count, plural, …}` / `{name}`), never number + hand-pluralized word + concatenation. And when
  a catalog forces every locale to carry every key, fill them with real translations — copying the source
  language passes the parity check while lying that it's localized (a false "done"). Full guidance in
  [references/ux-writing.md](references/ux-writing.md).

## 12. Multi-step flows: one screen, one question

When a task naturally splits into "pick this, then configure that," prefer a **wizard of small screens
over one dense screen.** Two short steps almost always beat one two-column layout with nested scrolls.

- **One question per screen.** If a screen is answering more than one thing, it's hiding a missing step.
  A role picker and a name + seat configurator are *two* questions — split them. Five simple steps beat
  one stacked, scroll-locked everything-page.
- **Stepper carries the context.** Use a top stepper for the "where am I" signal and put per-step
  context (org/branch/owner) in the eyebrow, not inside the subtitle paragraph — keep the eyebrow for
  *where we are*, the h1 for *what we ask*, the subtitle for *direction*. That eyebrow/h1/subtitle/body
  hierarchy is the load-bearing pattern of a clean wizard.
- **Adapt the next screen to the previous answer.** Don't show fields that don't apply because the
  earlier step ruled them out. A "seats on the floor map" section is irrelevant for a back-office role
  — drop it, narrow the screen, ship the simpler version.
- **Back must really go back.** Each step keeps the previous answers cached so going back never wipes
  what the user already typed. URL/state-restore parity matters here, not just on refresh.

## 13. Native shells: meet platform expectations, don't ship web defaults

When the app is a native desktop shell wrapping a web view (Electron, Tauri, WPF + WebView2, etc.),
the surrounding chrome must feel like the OS, not like a webpage that happens to be fullscreen.

- **Cursors and selection match the platform.** Buttons get `cursor: default`, not `cursor: pointer`.
  Non-input UI text is `user-select: none` so the wizard never lets the user blue-highlight a heading
  the way a webpage would. Inputs and content meant to be copied stay selectable.
- **Custom titlebar — finish the set.** If you replace the OS titlebar with a custom one, ship the
  *full* set: minimize, maximize/restore, close — plus native drag region on the empty header. Shipping
  only minimize + close is **half-finished**: users immediately spot the missing maximize and lose
  trust in the rest of the polish.
- **Drag with the OS, not with JavaScript.** Native window drag means `WM_NCLBUTTONDOWN + HTCAPTION`
  (Windows) or the platform equivalent, not a custom mouse-move listener that fights snapping and
  multi-monitor. Block drag on actual controls (buttons, inputs, focusable rows).
- **Right-click and keyboard behave like the OS.** No browser context menu on UI chrome (it reveals
  "Reload" / "Inspect" / "Save as" and breaks the illusion). Default browser shortcuts (Ctrl+F,
  Ctrl+P) either map to something meaningful in the app or are intercepted.
- **Bundle, don't lazy-load like a web page.** The shell loads from disk; show no network spinner for
  what is local. Reserve loading states for actual remote calls.

## 14. Marketing & landing pages: persuade, don't just present

An app screen *informs* someone who's already in. A landing page has a harder job: **convince a
stranger, in seconds, before they leave.** Everything above still applies, but persuasion adds its
own rules. Full playbook in [references/marketing-landing.md](references/marketing-landing.md); the
load-bearing ones:

- **The hero earns the scroll.** Above the fold, answer four questions fast: *who you are, what you
  offer, who it's for,* and *why it's worth it* (the USP). If a visitor can't tell what this is and
  why they should care without scrolling, the page has already failed — no amount of polish below
  rescues a hero that doesn't sell.
- **Social proof is woven through, not parked in the footer.** Logos are the weakest form; concrete
  **results and transformations** persuade — "grew revenue 40% in two weeks", not "trusted by teams."
  Place proof next to the claims and CTAs it backs, all along the page, where doubt actually
  surfaces — not in one graveyard row at the bottom that nobody reads.
- **One conversion goal, repeated.** Decide the single action the page exists to drive, and lead
  every section toward it. Repeat the primary CTA at natural decision points (after the hero, after
  the proof, at the foot) so the user never has to scroll back to act.
- **Let it breathe — crowding reads as cheap.** Generous negative space signals confidence and a
  premium product; a cramped, wall-to-wall page is read subconsciously as low-rent no matter how
  strong the copy. Space is a trust signal, not wasted screen.

## Pre-flight: before you call it done

A quick gate to catch the things that slip through. Don't claim completion until these pass:

- **States complete — including the quiet controls?** Every interactive element has
  default/hover/pressed/focus/disabled/loading — not just the hero button. Walk the *structural*
  controls (breadcrumbs, nav, tabs, icon buttons, search, list rows) and confirm each visibly
  responds. Every data view has loading + empty + error states (not just the happy path).
- **Nothing decorative-but-dead?** Every control that *looks* actionable actually does something
  (or is visibly `disabled`) — no Search button that ignores clicks, no toggle that won't flip.
- **Accessibility floor met?** Contrast ≥ 4.5:1 (3:1 large/non-text), targets ≥ 44pt/48dp/24px, visible
  focus on everything focusable, respects reduced-motion.
- **Anti-slop scan?** No em-dashes in copy, no fake-div product UI, no nested cards, no default-Inter +
  purple-glow, layout families varied, realistic content (no Lorem/round fakes).
- **Motion honest?** If you set MOTION_INTENSITY high, the UI actually animates; only `transform`/
  `opacity` animated; durations within the standards.md budget.
- **Consistent?** Spacing on the 4px scale, tokens (not magic numbers), one terminology per concept,
  concentric radii, matches the existing design system.
- **Mobile-web (if applicable):** `dvh` not `vh`, space reserved for async content (no layout shift),
  per-field errors, no double-submit. (Details in [references/web.md](references/web.md).)
- **Flow honest?** If the screen answers more than one question, it should be a wizard. No nested
  scrolls inside fixed columns when a vertical flow would do.
- **Native shell complete (if applicable)?** Custom titlebar has minimize + maximize + close, native
  drag works, cursors and selection match the OS, no browser context menu on chrome.
- **Marketing/landing page (if applicable)?** The hero answers who / what / for-whom / why above the
  fold; there's one clear conversion goal with the CTA repeated (not stranded at the bottom); social
  proof shows concrete results and sits along the journey, not only in the footer; key elements fall
  on the F/Z scan path.
- **One language per locale?** No stray Latin labels inside a Russian UI (or vice versa) — except
  brand names, identifiers, and established acronyms.
- **Content fits — no clipping?** Long names ellipsis cleanly, scroll containers don't cut off
  siblings, the submit button doesn't overlap the list it submits about. Cropped UI is a bug, not
  an "edge case the user will figure out."

---

## Review output format

When using this skill to **review** an interface (rather than build), structure findings as:

```
## Interface review
### Strengths
- <what already works, briefly>

### Findings (ordered by impact)
1. [States] <issue> → <concrete fix> — <why it matters>
2. [Anti-slop] <issue> → <concrete fix> — <why it matters>
...

### Quick wins
- <1–3 small changes with outsized payoff>
```

Tag each finding with the relevant area (Direction, Hierarchy, Spacing, Typography, Color/Depth,
States, Motion, Empty/Loading, Anti-slop, Copy, Responsive, Architecture, Hero, Social proof,
Conversion) so the user can see coverage at a glance. Pay special attention to **missing states** (loading/empty/error and the
interaction microstates) and **AI-default tells** — those are the most common gaps. Always pair the
problem with a specific, actionable fix and a one-line reason, and lead with the highest-impact issue.
