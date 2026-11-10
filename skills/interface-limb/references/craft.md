# Craft — the detailed rules behind the seven things

The workflow in SKILL.md decides *where* care goes (the system first, then the screen). This file is
the detail for the screen itself: type, color and depth, motion, loading and empty moments, multi-step
flows, native desktop shells, and how a choice is framed. Exact numbers are in [standards.md](standards.md).

## Contents
- Typography
- Color and depth (including dark theme)
- Micro-interactions and motion
- Loading and empty states
- Multi-step flows
- Native shells
- Behavioral psychology

## Typography: one font, tuned well

You don't need a fancy type system. One quality sans-serif, used with care, looks more
professional than three fonts thrown together.

- **Type carries the brand's emotion before a word is read.** The face *is* a message: the
  same headline set wrong can turn a serious, well-funded product into a discount flyer, or a
  playful app into a tax form. Choose the family for the feeling the vertical needs (mood and
  vertical pairings in [references/direction.md](direction.md)) — then tune it.
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

## Color and depth

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

## Micro-interactions and motion

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
  already play, and sync the tick to the visual change. See [references/mobile.md](mobile.md).
- **Pick durations by scale, and make exits faster than entrances.** Micro-feedback (toggle,
  hover) **100–150ms**; standard transitions (dropdown, tooltip) **200–300ms**; large/modal
  **400–500ms**. Never exceed ~500ms for routine motion — past that it drags. Use **ease-out**
  for elements *entering* and **ease-in** for elements *leaving* (an exit can be ~30% shorter,
  since the user no longer needs to track it). Avoid linear easing; animate only `transform`
  and `opacity`, never `transition: all`.
- **Respect reduced-motion.** Honor the OS/browser "reduce motion" setting — replace large
  translation/scale/parallax with a near-instant opacity fade, but keep *essential* motion
  (like a loading spinner). Make it one global switch, not per-component.

## Loading and empty states: the moments most people skip

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

## Multi-step flows: one screen, one question

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

## Native shells: meet platform expectations, don't ship web defaults

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

## Behavioral psychology: shape the decision, not just the screen

Users don't evaluate a screen field by field — they react to how a choice is framed. These
are default-shaping techniques worth applying anywhere a user makes a decision: onboarding,
forms, pricing, upgrade/downgrade prompts.

- **Smart defaults, not blank slates.** An empty form asks the user to make N decisions from
  nothing; a pre-filled one asks them to confirm or edit — far less friction, and a default
  reads as a recommendation. Default to the most likely choice (last used value, most common
  plan, inferred locale/timezone) and make the override obvious. Never default to something
  reversible-but-costly (a paid tier, a destructive toggle) without that override being visible.
- **Never start progress at 0%.** A bar or checklist that starts empty demotivates before the
  user begins; one that starts partway ("Profile 20% complete") triggers the goal-gradient
  effect — motivation to finish rises as the visible distance to the goal shrinks. Give credit
  for steps already taken (account created, email verified) as real progress, not an empty
  checklist, and keep that indicator visible through the whole flow. This is the progress
  layer on top of the onboarding-as-empty-state guidance in «Loading and empty states» above.
- **Give value before asking for anything.** Reciprocity: let the user experience a real result
  (a free calculation, an unlocked preview, a working demo) before a paywall or signup wall.
  Asking for an email or a card *first* forces a trust decision before any value has been shown;
  the same ask placed right after value lands converts far better — sequence beats wording.
- **Let the user build something before they commit.** People value what they've put effort
  into (the IKEA effect) — a workspace they've named, a dashboard they've arranged, a first
  project they've created feels *theirs*, and walking away now feels like abandoning something,
  not just skipping a signup. Where the flow allows it, let setup/customization happen before
  registration, and place the account-creation step right after something has been built.
- **Frame around loss, not just gain.** "You'll lose access to 12 saved projects" moves people
  more than "Upgrade for more storage" — loss aversion means the fear of losing what you have
  outweighs the appeal of gaining something new. Keep this honest: show concrete, real stakes
  (real counts, real items at risk) when a trial ends or a downgrade is chosen — this is the
  same "concrete beats generic" principle from the typography section, applied to retention copy.
- **Anchor before you price.** The first number a user sees recalibrates what "expensive" means
  for everything shown after it (the contrast effect) — leading with the highest tier makes the
  middle tier look reasonable by comparison, and a struck-through original price makes a
  discount register instantly. Order pricing tiers and comparisons deliberately, not just
  left-to-right by build convenience. Pairs with [marketing-landing.md](marketing-landing.md)'s landing-page persuasion rules
  when the pricing lives on a marketing page.

The line these sit on top of is honesty, not manipulation: real progress, real value, real
stakes, real prices. A fabricated progress bar or an invented "only 2 left" erodes exactly the
trust [anti-slop.md](anti-slop.md)'s anti-slop rules protect — a psychology trick built on a fake fact is a dark
pattern, not craft.
