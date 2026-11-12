# Components — when to use which, their anatomy and states

The shared widgets of a product, each with its job, anatomy, states and the mistakes that make it look or behave
cheap. Build these once in the system ([design-system.md](design-system.md)); style libraries with your tokens
([libraries.md](libraries.md)). Every component has every state: default, hover, pressed, focus, disabled (with a
reason when it matters), loading, error.

## Contents
- Buttons
- Choice controls
- Text fields
- Tabs and segmented controls
- Rows, cards, tiles
- Sheets, dialogs, popovers, menus
- Toasts and banners
- Badges, pills, avatars
- Progress and skeletons
- Navigation bars and rails
- Steppers and keypads

## Buttons

- **Hierarchy:** one primary (filled, accent) per area; secondary (tonal or outlined); tertiary (text); danger
  (danger color, never the default). Two equal filled buttons side by side is an anti-slop tell.
- **Label = verb + object**, with the consequence when there is one («Charge 142.00», «Send to kitchen · table 4»);
  a secondary line for detail («3 items»).
- **Sizes from tokens:** wide (48–56), hero (64) for the one action of a screen, compact for rows; minimum target 44–48.
- **Loading inside** (spinner replaces the label, width kept); **disabled keeps readable words** that say why.
- **Press:** scale ~0.97 within 100 ms.

## Choice controls

- **One of few (2–5), visible:** segmented control. **One of many:** a list or a pick-one sheet (closes on tap).
  **Several:** chips (toggle) or checkboxes. **On/off with immediate effect:** switch. **On/off applied on save:**
  checkbox.
- A selected chip changes fill and weight, not only color; chips in one row share height.
- Do not hide a choice of 3 in a dropdown.

## Text fields

Label above, helper or error below, a clear button for search, the right keyboard and autocomplete
([input.md](input.md)). Height 48–56; focus ring in accent; error border in danger with the message, not color alone.

## Tabs and segmented controls

Tabs switch views of one area; the active one marked by more than color; scrollable when many, with the active one
scrolled into view; an «add» or «new» action outside the scrolling row.

## Rows, cards, tiles

- **Row:** leading (avatar/icon/number), title + subtitle, trailing (value, action); whole row tappable when it opens
  something; the main controls visible without a tap; swipe actions as accelerators.
- **Card:** a container for one object with its own actions; never a card that does nothing (anti-slop).
- **Tile:** an item to pick from a grid; one anatomy measured on the data ([layout.md](layout.md)); press feedback; a
  count badge when already chosen; long press for choices.

## Sheets, dialogs, popovers, menus

- **Bottom sheet (phone)** for a task tied to the current screen; drag to close; sticky primary action; scrolls on short
  screens.
- **Side panel (wide screens)** for details and steps; for a list's item, a docked column rather than a modal.
- **Dialog** only for a decision that cannot be undone or needs an answer before anything else.
- **Popover / panel from a trigger** for a few choices beside the thing (grows from it).
- **Menu («⋯»)** for secondary actions; destructive ones last and separated.
- All close by scrim, Esc, back, and return focus.

## Toasts and banners

Toast: a result of the user's action, short, one action at most, stacked, timed by weight. Banner: a condition that
blocks work, at the top of what it blocks, with the fix. Rules in [states.md](states.md).

## Badges, pills, avatars

- **Badge:** a count of what waits for this person; hidden at zero; a pulse only for something unanswered.
- **Pill:** a state in words with its status color («not paid · 31 min»), the same pill for the same state everywhere.
- **Avatar:** a photo or initials on one neutral container; never random gradients.

## Progress and skeletons

Skeletons mirror the layout; spinners for one small module; determinate progress for long work with what is
happening; a ring that fills for a background download in a fixed place (the update in the brand slot).

## Navigation bars and rails

3–5 destinations with icon and label; the active marked by an indicator, not only color; badges for waiting work; the
same order on every device; the person and the venue in fixed places (rail bottom / header).

## Steppers and keypads

− N + with 48 px buttons and the number between, tabular; long press repeats. Keypads: 3×4, keys ≥ 56 px tall on
phones (48 on short screens), 00 and backspace, in the thumb half, with the amount large above.
