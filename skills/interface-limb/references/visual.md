# Visual craft — type, color, depth, icons and images

The workflow decides *where* care goes (the system first, then the screen). This file is the detail of how a screen
looks: type, color and depth, icons, photos and illustration. Layout and repeated elements are in
[layout.md](layout.md), motion in [motion.md](motion.md), states in [states.md](states.md). Exact numbers are in
[standards.md](standards.md).

## Contents
- Typography
- Color and depth (including dark theme)
- Icons
- Photos, illustration, avatars
- Text over images

## Typography: one font, tuned well

One quality sans-serif, used with care, looks more professional than three fonts thrown together.

- **Type carries the brand's feeling before a word is read.** Choose the family for what the vertical needs (pairings
  in [direction.md](direction.md)), then tune it. **Readability outranks novelty:** a clever font nobody can read is
  worse than a plain one. At most two families (a display face for numbers and headings, a text face).
- **A modular scale, not picked sizes:** `size = base × ratio^n`, ratio 1.2–1.333. Few sizes per screen (4–5).
- **Two well-separated weights** (400/700 or 500/700), not three close ones. Hierarchy comes from weight and color
  first, size second; secondary text is quieter (color), not smaller and smaller.
- **Tracking:** slightly negative on large headings (−0.01 to −0.03 em), 0 on body; small caps labels +0.04–0.08 em.
- **Line height:** body ~1.4–1.5, headings 1.1–1.2. Default browser line heights are a tell.
- **Measure:** ~45–75 characters for reading text (`max-width: 66ch`).
- **Numbers that are compared or that change are tabular** (`font-variant-numeric: tabular-nums`, Flutter
  `FontFeature.tabularFigures()`): prices in a column, a total that counts up, a timer, a PIN. Proportional digits make
  a column ragged and a changing number jitter.
- **Names that do not fit:** decide per role — ellipsis (one line, a list row), clamp to two lines (a tile), wrap with
  hyphenation (`hyphens: auto` plus a `lang`) — never cut a word mid-glyph at a hard edge.
- **The user's text size is part of the design.** Test at 200 % / the largest Dynamic Type / Android font scale 2.0:
  fixed heights clip, prices collide with names. Size containers by content, not by pixels.
- **Icon size matches the line height** of the text beside it and sits on its optical center.

## Color and depth

- **Roles, not colors.** Surface tiers (lowest → highest), text (primary, secondary), outline, primary and its
  container, and the status set (success, warning, danger, info) each with an "on" color. Screens use roles; nobody
  picks a hex in a widget.
- **Mostly neutral, one accent.** ~60 % neutral background, ~30 % secondary surfaces, ~10 % accent. The accent marks
  the primary action, the selection, focus, links. When everything is colored, nothing is.
- **Restrained is the floor, not the goal.** "Mostly neutral" stops a screen from shouting; it does not give it a
  face. With no brand supplied, commit to a hue chosen for the product ([direction.md](direction.md), the card) and
  tint every neutral toward it (OKLCH chroma 0.005-0.015 on the same hue). Cold pure gray plus default blue reads as
  unfinished next to a warm paper background with a deep brand green.
- **Status colors carry meaning everywhere the same way** (red = needs you now, amber = in progress or a warning,
  green = done, blue/brand = in motion or informational) and never alone: a word, an icon or a position goes with them
  (8 % of men do not see red/green apart).
- **A disabled control keeps its words readable.** Opacity 0.4 on a button whose label says *why* it is disabled
  («Short by 7.00») drops it to ~2:1. Change the fill to a neutral surface and keep the text at ≥ 4.5:1.
- **Light theme shadows: soft, layered, faint** — 2–3 layers (ambient + key), low opacity, blur grows with elevation.
- **Dark theme is not inverted light:** base dark gray (not #000), elevation by *lighter* surfaces not shadows, text at
  ~87 / 60 / 38 % white, desaturated accents, hairline borders. Check every status pair (`warn` on `warnContainer`) in
  both themes; dark containers are where contrast silently fails.
- **High contrast and forced colors** (Windows High Contrast, `prefers-contrast: more`): borders appear where fills
  carried meaning; do not rely on background color alone to show selection.
- **Color for information beats color for decoration** — a status, a category the user filters by, a chart series.

## Icons

- **One set, one size per role, one stroke.** Mixing outline and filled, 1.5 and 2 px strokes, or two libraries is
  visible at once. Size 20–24 in controls, 16–18 inline with text.
- **An icon alone is a guess.** Icon-only buttons are for the universal few (close, back, search, more, add) and
  always carry an accessible name; everything else gets a word. In a navigation bar every icon has a label.
- **State changes the icon, not a caption:** a link icon that becomes a crossed cloud, a bell with a count. Swap with
  the motion module, never a hard cut.
- **Emoji are not icons** (anti-slop): they render differently per platform and read as unfinished.

## What reads as designed, not defaulted

The details a professional adds without being asked. Check each against the screen before calling it done:

- **A brand mark with a shape,** not a letter in a black square: a simple geometric glyph in the accent, drawn inline
  as SVG; the same mark as favicon and in empty states.
- **Icons where the eye scans:** every navigation item and every row that has a type (invoice, member, project)
  carries one icon from one set, one stroke, labelled. A nav of bare words next to a nav of icons-with-words reads
  as the cheaper one.
- **Cards are not all equal.** One hero surface (larger, with the decisive number set big in tabular figures), the
  rest quieter. Two columns of same-weight cards is a grid of boxes, not a page.
- **No dead regions.** A column or corner more than ~30 % empty inside a card means the layout is wrong: rebalance,
  move the key figure there, or shrink the card to its content.
- **Data gets its own treatment:** a usage bar shows its limit and a warning threshold, changes hue near it, and says
  in words what happens past it; a chart or sparkline beats three numbers when a trend matters.
- **Objects look like what they are:** a payment card shows brand and last digits on a small card face; a person has
  an avatar; a file has a type icon. A gray pill that says "VISA" is a placeholder.
- **Two depth levels at most:** page, raised surface. Borders hairline, shadows faint; depth is not a decoration
  budget.
- **The product speaks in one voice:** concrete numbers and dates in the copy ("On pace to pass the limit around
  Nov 25"), never generic reassurance.

## Photos, illustration, avatars

- **Every image in a repeated element has the same frame:** one aspect ratio, one fit (`contain` for cut-out products
  on a plate color, `cover` for scenes), one corner radius. Mixed frames make a grid look broken however good each
  photo is.
- **Plan for missing images.** A product without a photo gets the category's icon on the same plate, never a broken
  image or a gray box with a filename. Generated letter-avatars in random gradients are an AI tell; use initials on one
  neutral container color, or a real photo.
- **Illustration is a language, not clip art:** one style, one stroke, the palette's colors, used for empty states and
  onboarding, never decoration on working screens.
- **Images never carry text the UI needs** (prices, names): text is text, so it can be translated, read aloud, and
  stays sharp.

## Text over images

Avoid it on working screens: put the name and price under the photo. When it is unavoidable (a hero, a banner), use a
gradient or a progressive blur toward the text, not a flat dark scrim, and test with the brightest and the darkest
image you have. Icons over images get their own plate.
