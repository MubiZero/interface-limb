# interface-limb

A system-first design layer for [Claude Code](https://claude.com/claude-code). Before drawing a
screen it finds (or sets up) the product's design system: tokens, shared components, and one
shared surface per kind of job. It builds only from that system, renders the result and judges it
by eye, and measures how well the code keeps to it. Every rule is backed by a cited standard
instead of taste alone.

Reach for it on any frontend work, building a screen from scratch or elevating one that already
exists. You do not have to say "design": prompts like *"build the login screen"*, *"make a
dashboard"*, or *"improve how this looks"* are enough to trigger it.

## What it produces

Two screens, each built by Claude with the skill active. Same models, same frameworks, the
difference is entirely in the handling of hierarchy, spacing, states, and the quiet details.

## Why system first

AI-built UI looks vibe-coded for the same few reasons everywhere: every component is built from
scratch, the model picks the colors and the layout, every element gets the same weight, the
content is placeholder, nobody looks at the rendered result, and the same job (confirm, pick one,
type a number) is solved by a new dialog each time. And it *behaves* vibe-coded: buttons that do nothing or only
pretend (a toast where a process should be), things that pile up with no way to remove them, an «Undo» on a payment, a
sheet that will not close, an order that vanishes between two screens. Polishing screens one by one does not fix that.
Version 3 of the skill works on the layers that do:

1. **Read the design system** (tokens, components, patterns, and the behavior layer: gestures, the way back, feedback)
   and measure adherence with `scripts/ds_audit.sh` before touching a screen.
2. **Learn the people and their jobs:** roles and conditions, jobs as steps, the inventory of what exists, variants.
3. **Decide what "premium" means to this buyer,** with real references and one signature decision.
4. **Build only from the system;** a missing piece is added to the system, a duplicate surface is merged.
5. **Compose with seven things** (focal point, spacing, hierarchy, one accent, real content, matching details, repeated
   elements measured on the data) **and design the behavior with seven questions** (every control acts, every action
   has its way back, one gesture grammar, consequences before commit, one pattern per message, scroll and focus follow
   the action, motion from one module).
6. **Render every width, press every control, walk every job end to end,** then measure again.

## Why a skill, not a prompt

Great app UI does not come from technical complexity. It comes from dozens of small, non-obvious
decisions applied consistently. The skill makes those decisions explicit and grounds them in
concrete values rather than vibes:

- **Accessibility floor as craft:** contrast `≥ 4.5:1`, touch targets `≥ 44pt / 48dp / 24px`,
  a visible keyboard focus indicator on everything focusable.
- **Six interaction microstates** on every interactive element, including the structural controls
  (breadcrumbs, nav, tabs, icon buttons, search, list rows) where "dead UI" usually hides.
- **Dark theme as its own discipline,** not an inverted light theme.
- **Motion that confirms, never performs:** durations by scale, exits faster than entrances, only
  `transform` and `opacity` animated, reduced-motion respected.
- **An anti-slop pass** that bans the tells of machine-generated UI (default Inter plus purple glow,
  nested cards, fake div-built product shots, em-dashes in copy).

Cited throughout: WCAG, Material Design 3, Apple HIG, NN/g, and the Vercel Web Interface Guidelines.

## What is inside

```
.claude-plugin/         plugin + marketplace manifests (install via /plugin)
  marketplace.json
  plugin.json
skills/
  interface-limb/       the skill itself
    SKILL.md            the workflow: system -> people and jobs -> direction -> build -> look -> behave -> render, press -> bake in
    scripts/
      ds_audit.sh          literal values vs tokens, type overrides, weights, surface counts
      dead_buttons.js      presses every visible control; ok / SELF (only itself changed) / DEAD
      shoot_widths.sh      renders desktop, tablet and phone widths (phones through iframes) to PNGs
    references/         progressive-disclosure detail
      design-system.md     the layers (tokens, components, patterns, behavior), maturity, guard tests, handoff
      discovery.md         roles and conditions, jobs as steps, inventory, variants, navigation
      contexts.md          operations/POS/kiosk, admin, SaaS, consumer, large screens, desktop shells, trust
      direction.md         a deliberate aesthetic; what "premium" means to the buyer
      redesign.md          one area at a time; rules while drawing; the remarks register
      prototype.md         interactive mocks that are alive, and how to verify them
      layout.md            grids, density, repeated elements measured on data, master-detail, thumb half
      visual.md            type, color and dark theme, icons, photos
      components.md        which control for which job; anatomy and states
      patterns.md          search, tables, drafts, sign-in, checkout, assigning people, wizards, decisions
      interaction.md       gesture grammar, the way back, compound targets, sheets, scroll and focus, keyboard
      motion.md            one motion module, named moves, a real spring, reduced motion
      states.md            feedback patterns, attention ladder, toasts, loading/empty/error/offline
      input.md             forms, numbers and money, codes and PINs, required choices
      ux-writing.md        copy as UI
      i18n.md              plurals, names in sentences, expansion, RTL, formats
      accessibility.md     beyond the floor: semantics, focus, gestures, time, reflow
      performance.md       response and frame budgets, layout shift
      critique.md          heuristics, briefing critics, testing with people
      review-by-eye.md     render protocol, the seven questions, checks
      anti-slop.md         visual and behavior tells, with reasons
      libraries.md         foundations, specialists; Flutter and RN equivalents
      standards.md         the cited numbers: contrast, targets, motion, springs, gestures, WCAG 2.2
      web.md               React / Tailwind / CSS tokens
      angular-primeng.md   Angular + PrimeNG presets
      mobile.md            Flutter / React Native, haptics, keyboard
      marketing-landing.md hero, proof, conversion
    evals/              test prompts used to develop and verify the skill
demos/                  the two showcase screens, with/without and a live compare page
assets/                 the screenshots above
```

## Install

**Recommended — as a plugin via the marketplace.** This is the modern path and keeps the skill
updatable with `/plugin`:

```
/plugin marketplace add MubiZero/interface-limb
/plugin install interface-limb@mubizero-skills
```

Or from the CLI:

```bash
claude plugin marketplace add MubiZero/interface-limb
claude plugin install interface-limb@mubizero-skills
```

**Manual — copy the skill folder** into your Claude Code skills directory:

```bash
git clone https://github.com/MubiZero/interface-limb.git
cp -r interface-limb/skills/interface-limb ~/.claude/skills/interface-limb
```

Either way, then restart Claude Code. The skill announces itself when it triggers on UI work.

## How it was built

Developed with the `skill-creator` workflow: write a draft, run real prompts through it with and
without the skill, compare the outputs, and tighten. One lesson is baked into the skill itself, a
more-specific CSS reset (`.card p { margin: 0 }`) silently zeroing a `margin-top` set for
separation. The skill now tells Claude to verify the *computed* gap, not just the declaration,
because that single trap is the most common reason intended whitespace quietly vanishes.

## License

[MIT](LICENSE) © 2026 MubiZero
