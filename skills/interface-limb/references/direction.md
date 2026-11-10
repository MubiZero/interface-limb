# Direction — read the brief, pick a deliberate aesthetic

Before tokens and components, decide *what this should be*. Skipping this is why AI UI defaults to
the same look. This file covers: (1) reading the brief and the existing codebase, (2) the three
intensity dials, (3) choosing a real aesthetic direction, (4) tailoring to the product's industry,
and (5) choosing a style and fonts with their tradeoffs visible.

## 1. Read the brief, and read the codebase first

**Infer the brief** from six signals: page kind, vibe words, reference signals (URLs/screenshots/
competitors), audience, existing brand assets, and quiet constraints (accessibility, regulated
industry, public sector). Then emit a one-line **Design Read** so your direction is explicit and
correctable:

> "Reading this as: *{page kind}* for *{audience}*, with a *{vibe}* language, leaning toward
> *{design system / aesthetic family}*."

Ask **at most one** clarifying question, and only when the read genuinely forks (e.g. "Linear-clean
or Awwwards-experimental?"). Don't dump a questionnaire.

**If a codebase already exists, match it — don't rewrite it.** Detect the existing design system
first: read CSS variables / Tailwind config, the installed component library, current fonts, spacing,
and radii. Use **one design system per project; never mix two.** New UI should look like it always
belonged. For a redesign, work **Scan → Diagnose → Fix**: scan the stack and existing patterns;
diagnose every generic pattern, weak spot, and *missing state*; fix with targeted upgrades that work
*with* the stack. Apply changes in max-impact order: **fonts → color → hover/active states → layout &
spacing → replace generic components → add loading/empty/error states → type-scale polish.**

## 2. The three dials

State these explicitly and justify them from the brief before generating. Each is 1–10; the value
maps to concrete output. (Baselines in parentheses are starting points, overridden per brief.)

- **DESIGN_VARIANCE** (≈6) — how far from a safe symmetric grid.
  - 1–3 *Predictable*: symmetric 12-col grid, equal columns/padding, centered.
  - 4–7 *Offset*: deliberate overlaps, varied aspect ratios, mixed alignment.
  - 8–10 *Asymmetric*: masonry, fractional grids, large intentional empty zones.
- **MOTION_INTENSITY** (≈5) — how much movement.
  - 1–3 *Static*: hover/active only, no auto animation.
  - 4–7 *Fluid*: load-in cascades, smooth transitions (see standards.md curves).
  - 8–10 *Choreographed*: scroll-triggered reveals, parallax, scroll-driven animation.
  - **Coupling rule:** if you set MOTION_INTENSITY > 4, the UI must *actually* animate (hero entry,
    reveals, hover feedback) — don't claim motion you didn't ship. Always include a reduced-motion path.
- **VISUAL_DENSITY** (≈4) — how tightly packed.
  - 1–3 *Spacious*: large whitespace, generous section gaps.
  - 4–7 *Standard app*: balanced padding.
  - 8–10 *Cockpit*: tight, data-dense, **dividers (1px lines) instead of card boxes.**

Match dials to context: a meditation app is low variance / low motion / low density; an analytics
cockpit is low-variance / low-motion / *high* density; a creative agency site is high on all three.

## 3. Choose a real direction (not adjectives)

- **Write a scene sentence:** one line of physical context — *who* uses this, *where*, *under what
  light/mood*. Specific enough to force a dark/light, calm/energetic choice. E.g. "A PM reviewing
  analytics in a dim office at 6 PM, anxious about tomorrow's launch" → dark, high-contrast, restrained
  motion.
- **Name anchor references, not adjectives.** "Stripe's dashboard," "a film-noir title sequence" — not
  "modern" or "clean." Also name an **anti-reference**: what it must *not* become.
- **Run the AI-slop test:** if you can guess the look from the product category alone, it's the
  reflexive default — push further. Pair the direction with a deliberate palette/type choice from
  [anti-slop.md](anti-slop.md), not the defaults.
- **Pick a color-commitment level** (you don't have to stay "restrained"): *Restrained* (neutrals + ≤10%
  accent) / *Committed* (one saturated hue across 30–60% of the surface) / *Full palette* (3–4 named
  roles) / *Drenched* (the surface itself is the color).

## 4. Tailor to the industry / trust level

The same component should be designed differently depending on the product's vertical. The governing
axis is **trust level**:

| Vertical | Palette / mood | Density & motion | Must-haves | Avoid |
|----------|----------------|------------------|-----------|-------|
| Fintech / banking / legal / gov / insurance | Navy + trust-blue + restrained accent; AAA contrast | Calm, low motion | Visible security/credibility signals, data legibility (tabular-nums, IBM Plex Sans-style) | **AI purple/pink gradients**, playful styles |
| Healthcare / senior / mental health | Calm blue + health green | Low motion, generous | **16px+ body (18px+ senior), WCAG AAA**, red reserved for alerts | Neon, dense data, motion-heavy |
| Analytics / dashboards | Dark (OLED) base + red/green semantic | High density, real-time number animation | High contrast, virtualized long lists, tabular-nums | Light-mode-by-default, decorative motion |
| Consumer e-commerce | Vibrant, urgency colors | Card hover-lift ~200ms | Fast scanning, social proof | (Luxury flips this →) |
| Luxury / premium | Minimal, premium palette | Slow 400–600ms reveals, lots of space | Restraint, large imagery | Vibrant/playful, urgency clutter |
| Creative agency / portfolio | Bold, expressive | High variance + motion | Distinctive type, real work shown | Corporate minimalism, hidden portfolio |
| AI / chatbot | Neutral + AI-purple `#6366F1` (here it's *right*) | Streaming text, typing indicators | Label AI content, thumbs-up/down + regenerate | A 10s spinner instead of streaming |
| Kids / education | Playful pastels, claymorphism | Gamified progress motion | Big targets, friendly tone | Finance/legal seriousness |

Decision flow: **classify the product → load its vertical defaults → use them to *bias* (not dictate)
style/palette/font choice → apply conditional overrides** (`if_luxury → slower reveals + premium
palette`, `if_low_performance → fall back to flat`, `if_light_mode_needed → ship a theme toggle`) →
**attach the vertical's anti-patterns** as guardrails.

## 5. Style & font selection, with tradeoffs visible

Choose an aesthetic style *with its costs in view*, not just for looks:

| Style | Best for | Do NOT use for |
|-------|----------|----------------|
| Minimalism / Flat | Almost anything; the safe, performant, AAA-friendly fallback | — |
| Glassmorphism | Modern SaaS, dashboards, modal overlays | Low-contrast backgrounds, a11y-critical, perf-limited |
| Neumorphism / Soft UI | Wellness, meditation, minimal | Data-heavy, high-contrast needs (low contrast is its weakness) |
| Brutalism | Portfolios, editorial, counter-culture | Corporate, conservative, professional customer-facing |
| Claymorphism | Kids, education, casual onboarding | Finance, legal, medical, anything serious |
| Bento grid | Dashboards, feature overviews, creator tools | Linear reading flows |
| Dark / OLED | Coding, analytics, entertainment, low-light | Print-first, color-accuracy-critical |
| Aurora / Liquid glass | Premium hero/creative sections | Data-heavy or content-heavy screens, perf-limited |

**Fonts** — pair on a role-contrast axis (distinctive display + legible body), or one family across
weights for restraint. Good, non-default pairings with rationale:

| Mood / vertical | Heading | Body | Why |
|-----------------|---------|------|-----|
| Tech / startup | Space Grotesk | DM Sans | distinctive + readable |
| SaaS / corporate | Poppins / Plus Jakarta Sans | Open Sans / Inter Tight | geometric + humanist |
| Luxury / editorial | Playfair Display / Fraunces | Inter / Montserrat | high contrast, elegant |
| Wellness / health | Lora | Raleway | organic serif + elegant sans |
| Dev tools / docs | JetBrains Mono | IBM Plex Sans | technical credibility |
| Finance / data | IBM Plex Sans (solo) | — | conveys trust, great for numbers |
| Accessibility-critical | Atkinson Hyperlegible / Lexend | Source Sans 3 | designed for legibility/dyslexia |

Display faces (Bebas Neue, Anton, Abril Fatface) are **headlines-only** — never body. For i18n/RTL
prefer Noto / Be Vietnam Pro families.

## Multi-page consistency

If the product has no design system yet (see [design-system.md](design-system.md), maturity 0–1), write one **`design-system/MASTER.md`** as the source of truth (tokens,
palette, type, key component CSS, the vertical's anti-patterns, the pre-flight checklist), and a
per-page file that records only *deviations*. Rule: check the page file first; if it specifies
something it overrides MASTER; otherwise MASTER governs. This keeps many screens coherent.


## 6. What "premium" means to this buyer — decide it before prompting

"Make it pop" and "make it premium" leave the model to guess, and the guess is the generic look.
Buyers read the look as a story about care: a look that came straight from a prompt says nobody here
cared, and that costs most with the customers who spend most and in high-trust fields (health,
finance, law), where a careless look makes people wonder what else was skipped.

- **Name the feeling for this buyer** in one line: calm and warm, sharp and fast, dense and exact,
  playful but serious. That line drives palette, type, density and motion.
- **Feed real references, not adjectives.** Two to four screens from shipped products that solve the
  same problem (Mobbin, the category leaders) and one anti-reference. Say what to take from each.
- **Give the model a designer's rules**, not taste words: this skill, the product's tokens, the pattern
  catalog.
- **Add one thing only this product would have**: its own icon set or illustration language, a type
  choice, a status color system, a signature interaction. "Fine" is what everyone ships now; the
  signature is the proof of care. Name it before release: "the one decision in this screen only we
  would have made is…".
- **The website is the first preview of the product.** Build it from the product's own parts (real
  screens, real components, real data) so moving from site to app feels like one experience.
- **Design first, then build.** For anything structural, a mock (in the product's tokens) and a short
  spec agreed before code; then build to it. Ask the questions you are unsure of before executing
  rather than guessing the gaps.
