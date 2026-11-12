# Layout — grids, density, repeated elements

Layout is where "every screen is fine on its own" falls apart: a grid of tiles in which each tile is a slightly
different shape, a list whose rows waste half their height, a column that is empty while a sheet covers the screen.

## Contents
- Grid and breakpoints
- Density for the job
- Repeated elements: one anatomy, measured on the data
- Columns from the text, not from the screen
- Lists and rows
- Wide screens: master–detail
- Phones: the thumb half
- Checks at every width

## Grid and breakpoints

- Spacing on the 4/8 scale from tokens; a label closer to its input than groups are to each other.
- Breakpoints by layout change, not by device names: typically < 600 (one column, bottom navigation), 600–899 (two
  columns possible, still touch-first), ≥ 900 (side rail, master–detail), ≥ 1200 (a third column).
- Safe areas (notch, home indicator, rounded corners) are padding, not afterthoughts:
  `env(safe-area-inset-*)`, `SafeArea`.

## Density for the job

Operations screens (a till, a dispatcher, a trading desk) are dense and glanceable: more per screen, fewer scrolls,
large targets for the frequent actions. Consumer and reading screens breathe. Decide per screen (the density dial in
[direction.md](direction.md)); a dense screen still keeps targets ≥ 44–48 px.

## Repeated elements: one anatomy, measured on the data

A tile, card or row repeated 20 times is the most-seen design in the product. Specify its anatomy once:

- **One shape for every instance.** Same image frame, same caption height, same position for the price and the name.
  A tile that grows a line because its name is long breaks the row; tiles of different heights look broken.
- **Measure, don't eyeball:** what share of the area carries information (photo, name, price) vs padding and gaps;
  where the main fact sits (the price where the eye lands, not in a far corner); no dead band between name and price.
- **Reserve by the real data, once per grid:** if every name fits on one line beside its price, all tiles get one line;
  if one needs two, all get two. Compute it at runtime from the real names (a measuring pass on resize), not per tile,
  and not for an imaginary worst case that leaves every tile with an empty line.
- **Only what the decision needs:** name, price, photo, a variant hint («S·M·L»), a count already in the order. Internal
  numbers, SKUs and long descriptions belong to the detail.
- **Variants show their smallest price** («from 55») or the price of the default variant; a range («55–115») on the
  tile is noise.
- **Draw it with three contents** before using it 20 times: the shortest name, the longest, a missing photo; at the
  narrowest and widest width.

## Columns from the text, not from the screen

Choose the number of columns by the width the caption needs: name plus price in the chosen font size, plus padding.
If three columns on a 360 px phone leave ~100 px of text, the caption needs two lines with the name flowing around the
price (a float or a wrapping row), and a step down in font size under ~380 px — decided once, for every tile.

## Lists and rows

- **The row's title carries the identity** (number and name together: «737 · Delivery · Ann»), the line under it what
  it is, and the state and its one action share the bottom line. No column reserved for a number that leaves a band of
  empty space beside the button.
- **Every row of a list that opens, opens on a tap anywhere on it;** its action button is a separate target.
- **Sections by what each item waits for** («Waiting for you», «Cooking», «On the road», «Closed today · 38 · 4 210»),
  urgent first; filters as chips with counts; the closed collapsed into one line that expands.
- Hundreds of rows: virtualize, keep the count visible, keep the scroll position when returning.

## Wide screens: master–detail

From ~900 px a list with details is a split: the list at the left, the chosen item at the right, with its steps
replacing the detail's content (and a back arrow). A sheet over the whole screen while a column sits empty wastes the
wide screen and hides the list the user is working through.

## Phones: the thumb half

- Primary inputs and actions in the lower half; keypads at the bottom; content that needs no thumb (the amount, the
  title) above.
- A screen with little content centers toward the thumb (sign-in, PIN, a result), no void under a title at the top.
- The most frequent start action is visible at first sight, outside any scrolling row.
- The bottom navigation has 3–5 items, each with a label; the same jobs as on the desktop
  ([discovery.md](discovery.md)).

## Fixed things stay where they are

- **An action that stands at the right stays at the right** when its neighbors are hidden on another screen: keep the
  row's structure (the tabs stay, or their space does), do not let `display:none` on a sibling slide the buttons to the
  left.
- **Two layers in one slot are centered on the same axis:** a brand name and an update message stacked in one grid cell
  are each `align-self:center`, or the shorter one sits at the top of the taller one's box.
- **A state pill and its button share a line without wrapping:** the button never wraps (`white-space:nowrap`), the
  pill ellipsizes, and the pill's text is short enough for the narrowest width («no courier · 6 min»).

## Checks at every width

After **every** layout change, check the widths you support — not only the one you were fixing: 360, 390–412, 768,
1024, 1366, 1440+. A media query added for 380 px that closes the phone block early breaks 381–899 silently. No
horizontal scroll at any width; nothing clipped at 200 % text size. A rendering script that shoots all widths at once
is in [prototype.md](prototype.md).
