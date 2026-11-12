# Motion — one module, a real spring, from where the user acted

"All the animations should come from one place, and feel premium" is the brief behind this file. Motion that each
screen picks for itself (a 180 ms ease here, a 300 ms bounce there) reads as cheap even when every piece is fine on
its own. Motion is a system layer like color: tokens, a few named moves, one module that every screen calls.

## Contents
- The motion module
- The named moves
- Durations, curves, the spring
- Where motion comes from
- Gestures and motion
- What not to animate
- Reduced motion
- Verifying motion

## The motion module

One home in the code (`Motion` in the theme, `motion.ts`, a `MotionTokens` extension), exporting:

- **Duration tokens:** instant (~100 ms, press feedback), fast (~150 ms, small state changes), normal (~250 ms, most
  transitions), slow (~400 ms, large surfaces). Exits ≈ 0.6–0.7 × the entrance.
- **Curve tokens:** enter (decelerate / ease-out), exit (accelerate / ease-in), move (standard ease-in-out for
  something that travels on screen), emphasis (a slight overshoot, used rarely).
- **One spring** for everything that arrives: sheets, panels, toasts, a tile let go. A damped spring with a slight
  settle and no wobble (for example stiffness ≈ 380, damping ≈ 30, mass 1 → ~400–450 ms). On the web sample it into
  CSS `linear()` so the browser runs it as an easing; in Flutter `SpringDescription`; in SwiftUI `.spring(response:
  dampingFraction:)`; in Compose `spring(dampingRatio, stiffness)`.
- **The named moves below** as functions. Screens call `Motion.enter(el)`, `Motion.stagger(rows)`; they never write a
  curve or a duration.

A guard test (search the code for literal durations and curves outside the module) keeps it that way —
[design-system.md](design-system.md) on guard tests.

## The named moves

| Move | What it does | Used for |
|---|---|---|
| **Press** | scale to ~0.97 within 100 ms, spring back | every pressable surface |
| **Enter** | rise 8 px and fade in, spring | anything that appears: a card, a section, a toast |
| **Stagger** | Enter for a list's items, 25–35 ms apart, capped at ~12 | a list or a sheet's contents after it opens |
| **Swap** | the old sinks 4 px and fades (fast, ease-in), the new rises (spring) | an icon or label that becomes another (wifi → offline cloud, logo → update arrow) |
| **Count** | a number counts to its new value over ~300 ms, tabular figures | totals, change due, counters |
| **Collapse** | height to 0 and fade, then remove | a removed row (the only place height animates) |
| **Fly** | a copy of the item travels from where it was tapped to where it went | add to cart/order: you see where it went |
| **Glow** | a brief accent tint that fades over ~1.5 s | the row just added or just changed |
| **Shake** | 3 short horizontal moves | a refused input (wrong PIN) — with a haptic and a message |

Fewer moves used consistently beat many moves used once.

## Durations, curves, the spring

- Feedback must start within **100 ms**; routine transitions **150–300 ms**; large surfaces up to **~450 ms**. Past
  ~500 ms motion drags (numbers and sources in [standards.md](standards.md)).
- **Enter decelerates, exit accelerates**, and exits are faster than entrances.
- **Springs for things that arrive and things the finger lets go** (they carry velocity naturally); curves for
  everything else. One spring for the whole product.
- **No linear easing** except for progress that represents time (a countdown bar).

## Where motion comes from

- **From the origin:** a menu grows from its button, a panel from the tile that was held, a toast rises from the bottom
  edge near the action, a sheet slides from the edge it lives on. Set `transform-origin` to the trigger.
- **Shared elements** connect two states of the same thing (a thumbnail that becomes the header image). Use them for
  navigation within one object, not as decoration.
- **Choreography:** the container arrives first, its contents follow (stagger); on exit everything leaves together,
  faster.

## Gestures and motion

- A dragged thing follows the finger 1:1 (no easing while held), then a spring takes over with the release velocity.
- Past the commit threshold it continues off; before it, it springs back — that spring-back is the "no" a user feels.
- While dragging, show the consequence (the red «Remove» under a row, the scrim lightening as a sheet goes down).

## What not to animate

- **Only `transform` and `opacity`** (and `filter` sparingly). Animating width, height, top, left, margins causes layout
  on every frame; the one accepted exception is collapsing a removed row. A progress bar is `scaleX`, not `width`.
- **Never `transition: all`.**
- **No motion for its own sake** on working screens: no parallax, no looping attention animations except a real
  "waiting for you" signal (a pinging badge on an order nobody answered).
- **Do not animate what the user is reading** (text that moves while it is read).

## Reduced motion

- Honor `prefers-reduced-motion` / `MediaQuery.disableAnimations` / iOS Reduce Motion **live**, not only at load: the
  module listens for changes. Moves become a plain change or a short fade; essential indicators (a spinner, progress)
  stay.
- One switch in the module, not a check in every screen.

## Verifying motion

- Motion does not run in a hidden or background browser tab (requestAnimationFrame and CSS transitions pause):
  a screenshot from such a tab shows the start state and lies. Check state through the DOM, or render in a visible
  headless browser ([prototype.md](prototype.md)).
- Record a short screen capture of the key moves at real speed and at 0.25×; jank and double-moves show at 0.25×.
- On a mid-range Android phone, 60 fps for list scroll and sheet drag.
