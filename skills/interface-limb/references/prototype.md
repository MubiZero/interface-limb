# Interactive prototypes — every control alive, verified by pressing

An interactive mock (an HTML page the owner taps on a phone, a Figma prototype, a throwaway Flutter build) is judged
like the product: by doing the work in it. A dead button, a toast that pretends a process happened, or a list that
loses what was just made ends the review on the spot. This file is how to build one that survives, and how to check it
before showing.

## Contents
- What "alive" means
- Built like the product
- The mock's own layer
- A walk through all the screens
- Verifying: press everything, render every width
- Scripts

## What "alive" means

- **Every visible control does what the product will do**, or is honestly not there. A control whose screen is not
  drawn says so («Split bill — its own screen, not drawn in this mock»); a control that only lights itself up (a
  language switch that switches nothing, a search field that is a picture of a field) is worse than none.
- **A process is a process:** «Assign courier» opens the list of couriers with availability, the assignment changes the
  order and the courier; «Take cash» counts and asks a reason when short; a payment has its methods and its change.
- **Objects persist across screens:** an order paid on the till appears in the orders list with its contents and
  payment, can be opened, moves through its states; a courier's cash grows when a cash delivery is done.
- **Lists grow:** check them at 1, 3, 5 and 15 items at the narrowest width (tabs, lines, toasts, cards).
- **Time passes where the product has time:** a waiting timer counts, a cooking order becomes ready, a toast expires.

## Built like the product

- **The product's tokens** (colors, type, spacing, radii, motion) as variables; both themes.
- **One motion module** with the named moves ([motion.md](motion.md)), reduced motion respected.
- **Real content:** the real menu, real names and prices, real numbers that add up.
- **State in objects, not in "current":** undo and async callbacks refer to the record they act on.
- **Platform taps:** the browser's click for taps (fires after the finger is up, only without movement), pointer
  events for press feedback and holds, touch events with `passive:false` where a sheet must hold back the scroll.

## The mock's own layer

Variant switches (online/offline, module on/off, role), "send an incoming order", "fill 15 lines", and the list of what
to try live in a **separate, visibly marked layer** — a dashed tag at the screen edge labelled MOCK that opens a panel —
never inside the product's own header, profile or menu. A query parameter (`?clean`) hides it for screenshots. Each
variant switch changes the whole screen consistently (offline: card and transfer unavailable with a reason, messages
"will go when online", a queue count on the link icon, no incoming web orders).

## A walk through all the screens

Before showing, do the main job of each role end to end, through every screen it touches, on each device: create →
change → pay or send → find it in the list → open it → move it through its states → close it → correct it (refund).
A broken link between screens (an order that disappears after payment, a phone where the orders list has no way in)
shows only on the whole path, never screen by screen.

## Verifying: press everything, render every width

- **Press every visible control** on every screen and inside every sheet, and require that something **other than the
  control itself** changed. A class change on the pressed button alone is "SELF" — check that it is the whole intended
  effect (a toggle) or fix it.
- **"Visible" means a finger could press it:** skip controls inside a hidden, transparent (opacity 0) or
  `pointer-events:none` ancestor — closed panels often are only faded out.
- **Do not trust screenshots from a hidden or background browser tab:** transitions and requestAnimationFrame do not run
  there, so the picture shows half-finished states. Verify state through the DOM, and take pictures in a visible
  headless browser.
- **Headless Chrome will not shrink its window below ~500 px:** phone widths rendered with `--window-size=360,640`
  silently lay out at ~500. Render phones inside an `<iframe>` of the exact width on a wider page.
- **Every width after every change** (360, 412, 768, 1024, 1366): a fix for one width breaks another.
- **Text at 200 %** and dark theme once per round.

## Scripts

- `scripts/dead_buttons.js` — paste into the page (or load it from a driver) and run
  `await deadButtons({scope, home, from, count})`; it presses each visible button, resets to a home state between
  presses, and reports `ok` / `SELF` / `DEAD` for each.
- `scripts/shoot_widths.sh <url> [out-dir]` — renders the page at desktop sizes directly and at phone sizes through
  iframes, in headless Chrome, so you can open the PNGs and look.
