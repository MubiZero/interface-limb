# Anti-slop — the refuse-and-rewrite list

AI tends to produce a recognizable "default" interface: safe, templated, and instantly
identifiable as machine-made. Good fundamentals aren't enough — you also have to *avoid the
tells*. Treat the items below as bans: if you're about to ship one, stop and rewrite. Each
has a reason, because the point isn't ritual avoidance — it's understanding why the pattern
reads as generic so you can make a better choice.

## The "obviously AI" tells (fix these first)

- **Fake product UI built from divs.** The #1 tell. Don't hand-build a fake terminal, dashboard,
  chat, or task-list out of `<div>`s to fill a hero. Use a real screenshot, a generated image, or
  `https://picsum.photos/seed/{slug}/{w}/{h}` — never a broken Unsplash hotlink.
- **Em-dashes (—) anywhere.** The single strongest LLM signature in copy. Use commas, colons,
  semicolons, or parentheses instead. Scan *all* strings including alt text, captions, and buttons.
  Only the hyphen `-` (ranges, compounds) and minus sign are allowed.
- **Default Inter + purple/blue glow gradient + nested cards.** The 2025–26 "AI SaaS" uniform.
  Avoid Inter as the *default* (see fonts below); ban purple/blue radial "glow" gradients; never
  nest a card inside a card.
- **Buzzword copy.** "Elevate, Seamless, Unleash, Supercharge, Leverage, Streamline, World-class,
  Enterprise-grade, Next-gen, Game-changer, Mission-critical." Write what the thing actually does.
- **Lorem ipsum / "John Doe" / "Acme Inc" / round fake numbers.** Use realistic content: real-ish
  names, organic figures (`47.2%`, not `99.99%`), varied dates, unique avatars. Placeholder content
  reads as unfinished.

## Behavior tells (the product does not do what it shows)

- **Dead or fake controls.** A button that does nothing, a search field that is a picture of a field, a language switch
  that only lights itself up. Every control acts, or says honestly that its screen is not there yet.
- **A toast instead of a process.** «Courier assigned» after one tap with no choice of courier; «Paid» with no payment
  screen. A button that stands for a process opens the process.
- **Undo on something final.** «Payment taken · Undo». Final actions are named and have a separate inverse (refund).
- **Things that pile up with no way to remove them** (empty tabs, drafts, filters).
- **A sheet that only closes by its tiny «×»** (no drag, no scrim, no Esc).
- **Events that wait for a person shown only as a badge.**
- **Objects that vanish between screens** (paid on one screen, missing from the list on the next).
- **Mock furniture inside the product** («What to try», explanations of design decisions in the UI copy).

## Tells from vibe-coded products (seen across many AI-built apps)

- **Emoji as icons.** Swap them for one interface icon set (Phosphor, Tabler, Radix) at one size and
  stroke. A few products use emoji as their voice on purpose; that is a decision, not a default.
- **The model picked the colors.** Bright, unrelated hues on buttons, badges and icons. Decide the
  palette yourself (neutral base, one accent, status colors), and let charts carry color.
- **The model picked the layout.** Repeated KPI rows (the same four numbers on three pages), a sidebar
  full of counts nobody needs there, every card the same size and weight.
- **Gradient circles with initials** as the account avatar. Use a real photo, a quiet monogram in the
  product's tokens, or an account card. (Initials on a person's row are fine; the gradient is the tell.)
- **Cards that do nothing** — a decorative "summary" with no action or new information. Delete it.
- **Two equal buttons side by side** ("Get started" / "Learn more" in the same weight). One leads.
- **Everything colored and everything moving.** When every element has the accent or an animation,
  nothing stands out.
- **Default component-library look** (stock shadcn radius, gray and font) — restyle with the tokens.
- **Shouting actions:** all-caps buttons, oversized CTAs, badges with an icon plus "20 % off discount".
- **Placeholder plans and features:** five pricing tiers, the cheaper one listed after the dearer one,
  vague feature bullets.

## Layout / composition bans

- **No nested cards.** A card inside a card is almost always wrong — flatten, or use spacing/dividers.
- **No identical card grids.** Rows of same-size icon + heading + text cards. Vary size/role, or use
  a different component entirely.
- **Long lists (>5 items) need a different component** — not a longer `<ul>`. Reach for a 2-column
  grouped list, card grid, tabs/accordion, or scroll-snap pills.
- **No "eyebrow" on every section** (tiny uppercase tracked "ABOUT / PRICING" above each heading) and
  no "01· / 02·" numbered section markers as a reflex. Cap eyebrows at ~one per three sections.
- **Cap consecutive image+text "zigzag" splits at 2.** A third alternating split in a row is monotony.
- **Diversify layout families.** Across ~8 sections use ≥4 different layout shapes; don't repeat one.
- **No decorative side-stripes** (`border-left` >1px as an accent), **no diagonal stripe backgrounds**
  (`repeating-linear-gradient`), **no hand-drawn/doodle SVGs.** Ship real assets or nothing. The one
  exception is a stripe that *encodes state* as part of the product's status language (an order that is
  late, a menu category) and is also said in words or a badge — never color alone.

## Color bans

- **No gradient text** (`background-clip: text` over a gradient) as decoration.
- **No "ghost card":** don't combine a `1px` border *and* a soft `box-shadow` (blur ≥16px) on the same
  element — pick one way to define the edge.
- **No decorative glassmorphism.** Blur/glass only when there's a functional reason (content behind it),
  never as default flair — and verify ≥4.5:1 text contrast over the blur.
- **Avoid the AI-cream / premium-consumer palette by default:** warm beige/sand backgrounds with
  brass/clay/oxblood accents are now a reflexive AI look. Use a deliberate palette instead — a neutral
  base (Zinc / Slate / Stone) plus one committed high-contrast accent (Emerald, Electric Blue, Deep
  Rose, Burnt Orange), and rotate so it isn't the same accent every project.
- **Prefer OKLCH** for new color work (perceptually even lightness). Tint neutrals only slightly toward
  the brand hue (≈0.005–0.015 chroma), not a generic warm/cool drift.

## Typography bans

- **Don't default to Inter / Roboto / Open Sans.** Reach for Geist, Outfit, Cabinet Grotesk, Satoshi,
  Plus Jakarta Sans, Space Grotesk. (Inter is *fine when chosen*; the problem is reflexive default.)
- **Avoid Lucide / Feather as the reflexive icon set** — Phosphor, Tabler, Radix, HugeIcons read fresher.
  Never hand-roll SVG icons.
- **Hero text ceiling ~6rem (96px).** Bigger reads as shouting. **Display tracking floor −0.04em** —
  tighter and letters touch.
- **Never mix two fonts in one headline.** Emphasize with italic/bold of the *same* family. Pair on a
  contrast axis (serif + sans) or use one family across weights; max 3 families.
- **No all-caps body text.** Uppercase only for ≤4-word labels/badges.
- Use `text-wrap: balance` on h1–h3, `text-wrap: pretty` on long prose, `font-variant-numeric:
  tabular-nums` on numbers in tables/dashboards.

## Motion bans

- **No bounce/elastic easing.** Use ease-out (quart/quint/expo) — see standards.md durations/curves.
- **Don't `transform: scale` an `<img>` on hover.** Animate the card's background/border/shadow instead.
- **Don't gate an element's visibility on a scroll/class-triggered transition** (it can get stuck hidden
  on background tabs). Reveal animations enhance an already-visible default.
- **Don't attach `window` scroll listeners in React** — use IntersectionObserver / `useScroll` / CSS
  scroll-driven animation, and clean up effects.

## Per-context: the same choice can be right or wrong by industry

Context flips many of these. The clearest example: **AI-purple `#6366F1` is correct for an AI/chatbot
product but reads as untrustworthy in fintech, legal, healthcare, or government** — those want a
restrained navy/trust-blue palette, AAA contrast, and visible security/credibility signals. Always
check the choice against the product's vertical (see [direction.md](direction.md)).
