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
type a number) is solved by a new dialog each time. Polishing screens one by one does not fix
that. Version 2 of the skill works on the layer that does:

1. **Read the design system** (tokens, components, patterns) and measure adherence with
   `scripts/ds_audit.sh` before touching a screen.
2. **Decide what "premium" means to this buyer,** with real references and one signature decision.
3. **Build only from the system;** a missing piece is added to the system, a duplicate surface is merged.
4. **Compose with the seven things every good UI has:** one focal point, spacing that groups,
   hierarchy by weight and color, one accent, real content, matching details, motion from the origin.
5. **Render and look,** then measure again.

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
    SKILL.md            the workflow: system -> direction -> build -> compose -> look -> measure
    scripts/
      ds_audit.sh          literal values vs tokens, type overrides, weights, surface counts
    references/         progressive-disclosure detail
      design-system.md     the three layers, maturity scale, pattern catalog, consolidating surfaces
      review-by-eye.md     render protocol, the seven questions, checks for lists, filters, pricing
      libraries.md         foundations, specialists, designed components; Flutter and RN equivalents
      craft.md             type, color and dark theme, motion, loading/empty, wizards, framing
      direction.md         pick a deliberate aesthetic; what "premium" means to the buyer
      web.md               React / Tailwind / CSS tokens
      angular-primeng.md   Angular + PrimeNG styled-mode presets, [dt]/[pt], @defer
      mobile.md            Flutter / React Native, haptics, keyboard handling
      marketing-landing.md hero, social proof, conversion CTAs, scan patterns
      standards.md         the cited cheat-sheet of exact numbers and sources
      anti-slop.md         the bans, with reasons
      ux-writing.md        copy as UI
    evals/              test prompts used to develop and verify the skill
demos/                  the two showcase screens, with/without and a live compare page
dist/                   interface-limb.skill, the packaged bundle
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

**From the bundle:** download [`dist/interface-limb.skill`](dist/interface-limb.skill) (a zip with an
`interface-limb/` folder inside) and unzip it into `~/.claude/skills/`.

Any of the three, then restart Claude Code. The skill announces itself when it triggers on UI work.

## How it was built

Developed with the `skill-creator` workflow: write a draft, run real prompts through it with and
without the skill, compare the outputs, and tighten. One lesson is baked into the skill itself, a
more-specific CSS reset (`.card p { margin: 0 }`) silently zeroing a `margin-top` set for
separation. The skill now tells Claude to verify the *computed* gap, not just the declaration,
because that single trap is the most common reason intended whitespace quietly vanishes.

## License

[MIT](LICENSE) © 2026 MubiZero
