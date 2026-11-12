# Review by eye — render, look, fix the class

Code review does not see what a person sees in a second: two buttons of equal weight, the same KPI
on three pages, an icon that vanishes on a bright photo, a card that does nothing. Those live in
the pixels. This file is the protocol for looking, and the checks that catch the most.

## 1. Render protocol

- Render the real screen, not a component in isolation: phone ~390×844, tablet ~820×1180, desktop
  1366×768 and 1440×900; dark theme if the product has one; the product's second language if any.
- Use a realistic day of data: dozens of records dated today and yesterday, long names, one overdue,
  one cancelled, one failed, one with a missing photo. Plus one "first day" run on empty data.
- Open every image yourself. A mock or screenshot that "should look right" often has clipped text,
  overlapping blocks or an empty column.
- For a whole product, keep a screenshot harness in the repo (headless browser for web, golden tests
  or a web build for Flutter, simulator/emulator captures for native) so the same set can be retaken
  after changes and compared before/after.

- **Every width after every change** (360, 390, 412, 768, 1024, 1366, 1440): a fix at one breaks another. Phone
  widths in headless Chrome only through iframes (`scripts/shoot_widths.sh`); a hidden browser tab does not run
  transitions, so its screenshots lie.
- **Behavior is part of looking:** after the pictures, press every control (`scripts/dead_buttons.js`) and walk each
  job end to end ([prototype.md](prototype.md), [interaction.md](interaction.md)).

## 2. The seven questions (ask each, answer yes or fix)

1. **What is the one thing this screen is for — and is it the most obvious thing on it?** Look for:
   a badge, a gradient headline, two equal buttons, a stat bar and three cards all competing. Fix by
   removing and demoting: one primary action, the second as secondary or a link, the stat bar gone if
   it repeats another page. In settings, the action people came for goes first.
2. **Is every gap on the scale, and does spacing show what belongs together?** Look for even padding
   everywhere (nothing grouped) and random gaps. Inside a group < between groups; label close to its
   field. Grouping by space beats boxes and lines.
3. **Does hierarchy come from weight and color, not only size?** Look for five sizes on one card, or
   a name 13 px and everything else 11.5 px in one gray line. Name steps up, the key number takes
   weight, the rest drops back in a quieter color.
4. **Is the accent used only where it matters?** Look for the brand color on backgrounds, headings,
   badges and buttons at once. Neutrals tinted slightly toward the brand, one accent for the primary
   action, focus and links; status colors only for status.
5. **Is every piece of content real?** Look for John Doe, round numbers, "Feature one", lorem, a
   generic plan name. Replace with this product's real names, prices and words.
6. **Do the details match?** Radius family (one shape language: not 4 px corners next to circles
   unless on purpose), nested radius ≤ parent, hairline borders that don't shout, soft layered
   shadows, icons from one set with one size and stroke, everything on the same edges.
7. **Does motion come from where the user acted?** Menus grow from their trigger, sheets follow the
   finger and settle, notifications slide in from an edge and stack, close faster than open, ease-out.

## 3. Checks that catch the most

### Content you don't control
- **Icons or text over a photo** must survive a bright photo, a dark one and a busy one: give them a
  plate or put the text off the image. Cards whose name and numbers sit *under* the photo look the same
  whatever the merchant uploads.
- **Catalog images** need one visual system (background, lighting, framing) or the grid looks messy,
  even if each photo is good alone.
- **Long strings:** ellipsis, wrap rules, the button never covers the list it acts on.

### Lists and cards
- Image size has a job: small identifies, large creates appetite. Don't shrink images just to fit
  more above the fold — everyone scrolls; what matters is whether the first thing seen is worth
  continuing for.
- When no default fits everyone (big photos to want, a compact list to compare), offer the switch.
- Trust signals sit next to what they vouch for: the rating by the product name, not three blocks down.
- Remove redundant labels ("Price:" before a number with a currency) — but be consistent: if one field
  is labeled, label its neighbours too.
- Don't encode a variable in a title ("Strawberries 1 kg" next to a quantity selector).

### Filters and choices
- Filters visible as chips for the common ones, a "Filters" button for the rest, sort beside it.
- A filter sheet over the results keeps context; one page per criterion loses it and costs taps.
- The apply button says the result: "Show 41 homes", not "Show".
- Chips for picking a known value; steppers only for nudging; slider + inputs for ranges.

### Dashboards and SaaS
- The same four KPIs on several pages is a tell; each page shows what only it can.
- Color through information (micro charts, status) instead of colored buttons and icons.
- Busy cards: collapse secondary actions into a ⋯ menu, turn chips into icons with labels on hover,
  put the key number where the eye lands.
- Cards that do nothing go. Sparse flyouts with lots of space may be better as a modal, with advanced
  options collapsed.

### Pricing
- At most 3–4 plans; the price is bigger than the plan name (people care about the price); show the
  actual discount; show what the next plan adds; order tiers deliberately.

### Text and buttons
- Headlines attract, paragraphs support: body line-height ~1.5 and slightly lower contrast.
- Small uppercase labels need a little letter-spacing; badges say one thing ("−20 %"), no icon + two words.
- The primary action should be the most important element without shouting: no all-caps, not
  oversized, not the only saturated thing fighting a saturated page.
- Divider lines are quiet; heavy dark dividers cut the page into harsh blocks.

## 4. From finding to fix

Every visual finding is either a **fix** (a state, a word, a gap, an order — goes straight into the
shared component or token) or a **redesign** (navigation, merged screens, a new flow — mock first,
approval per area). Report findings as classes ("every list card puts the rating far from the
name"), fix them in the shared layer, and retake the screenshots to show before/after.
