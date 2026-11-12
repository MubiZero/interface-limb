# Interaction — what each touch, click and key does, and the way back

Screens are judged on how they behave as much as on how they look. Most "it feels cheap / broken" remarks about a
built UI are behavioral: a tap that does nothing, a sheet that will not go away, a gesture nobody can find, an action
that cannot be undone, a list that does not show what was just added. This file is the grammar.

## Contents
- One grammar of gestures for the whole product
- Every action has its way back
- Compound elements are one target
- Taps that land the first time
- Sheets, panels and dialogs: open and close
- Scroll and focus are part of the action
- Keyboard and pointer
- Status icons act
- Checks

## One grammar of gestures for the whole product

Write it down once (a table in the design system) and keep it everywhere. A typical grammar:

| Gesture | Means | Never means |
|---|---|---|
| Tap | the quick, obvious action (add, open, select) | something destructive |
| Long press (400–500 ms) | open the choices for this thing (options, size, details) — a preview, not an action | doing the action |
| Swipe a row left | remove / archive, shown under the row as it moves, with «Undo» | a hidden only-way to do it |
| Swipe a row right | the row's main next step (one more, mark done, accept) | something different on every screen |
| Drag down on a sheet | close it | — |
| Pull down on a list top | refresh | — |
| Double tap | nothing, unless zoom on media | an action (too easy to trigger by accident) |

Rules that go with it:

- **Every gesture has a visible alternative** (WCAG 2.5.1 Pointer Gestures, 2.5.7 Dragging Movements): the swipe that
  removes a row is also the «−» at 1 or a «Remove» in the row's menu; the drag that reorders is also «Move up/down».
  Gestures are accelerators for the trained, never the only way for the new.
- **What a gesture will do shows while it happens:** the row slides and the word «Remove» on red is revealed under it;
  past a threshold (about a third of the width) it commits; released before, it springs back.
- **A long press that would do the action is a trap:** people hold out of hesitation. Long press opens the choices; the
  choice confirms.
- **A drag that starts on a scrolling list is a scroll,** not a press: cancel the press after ~10 px of movement
  (the platform's touch slop).
- **Haptics follow meaning** (light for a selection, medium for a success, a double for a refusal) — one map, used
  everywhere ([mobile.md](mobile.md)).

## Every action has its way back

Classify every action before drawing its button. The class decides the button's words, whether it asks, and what
comes after.

| Class | Examples | Way back |
|---|---|---|
| **Reversible** | remove a line, archive, assign someone, mark done, move | Do it at once, then a toast «Done · Undo» (6 s; 8 s when money or someone else is affected). No confirm dialog. |
| **Created** | a tab, a draft, a filter, a row | Removable the same way it was made (a «×» on it, a swipe); an **empty** one goes by itself when left; «New» never stacks empty ones — it goes to the empty one there is. |
| **Final** | take a payment, send a message, print a fiscal receipt, submit a tax form, accept an order a customer is told about | Named as final on the button («Charge 142.00», «Send to 3 people»). No «Undo» toast — that would lie. Its other side is a **separate action** with its own rules: a refund with a reason, a correction, a cancellation with a reason. |
| **Destructive and final** | delete an account, wipe a device | A confirm that names what goes («Delete 214 photos? This cannot be undone»), with the destructive button in danger color and not the default; for the worst, type the name. |
| **Opened** | a sheet, a panel, a menu, a search | Closes by the way it came: drag down, the scrim, Esc, back, the same button again. |

- **Undo restores the object it was taken from,** not "the current one": remove a dish from tab A, switch to tab B,
  press «Undo» — the dish returns to A. Keep a reference to the list or record, not to a global "current".
- **Toasts with an action do not kill each other.** A second toast stacks above the first (up to three); a plain one may
  replace a plain one.
- **Leaving with unsaved work:** an empty draft goes silently; a draft with content stays (a tab, "Draft" in the list),
  not a "Discard changes?" dialog on every back.

## Compound elements are one target

A row and its expanded options, a card and its footer, a chip group and its label are one thing to the finger.

- **The whole row toggles it, not only its title.** Tapping the empty space beside the chips of an open row folds it,
  as a tap on the title does. Its own buttons (− +, a chip) do their own thing and stop the event.
- **An open row looks like one block** (one tinted surface spanning the row and its options), so the eye sees parent
  and child together.
- **A tap outside the open thing folds it**; a tap on another row moves the opening there.
- **Icon buttons have a 44–48 px hit area** even when the glyph is 18–28 px (an invisible inset, `::after{inset:-8px}`
  or `minimumSize` in Flutter). The «×» on a tab is the classic miss.

## Taps that land the first time

- **Use the platform's tap, not pointerdown:** a click/tap fires after the finger is up and only if it did not move
  beyond the slop. A sheet opened on pointerdown receives the same touch's pointerup and closes or presses something.
- **The opening touch never closes what it opened:** ignore scrim taps for ~300 ms after opening.
- **Press feedback within 100 ms** (a scale to ~0.97, a fill change) so the finger knows it landed — then the action.
- **Nothing important within 16 px of a screen edge** that the OS uses for its own gestures (back, home, notifications).

## Sheets, panels and dialogs: open and close

- **On a phone, a sheet follows the finger down from anywhere on it** — the handle, a row, the total — once its list
  is scrolled to the top (further pull scrolls the list instead); it closes past a quarter of its height or on a fast
  flick. A sideways drag stays the row's swipe.
- **On a wide screen, the chosen item belongs in a column, not a sheet over an empty column.** A list with details is
  a master–detail split from ~900 px up: the list stays usable, the detail sits at the right, and steps inside it
  («Assign a courier» → pick → back) replace its content with a back arrow.
- **Every sheet has one clear exit and one primary action;** a sheet that is a step in a process says where it returns.
- **A sheet taller than a short screen scrolls,** and its primary action is sticky at the bottom. Test at 360×640.
- **Esc closes the topmost modal**; focus returns to the control that opened it.

## Scroll and focus are part of the action

- **After adding, the new thing comes into view** (`scrollIntoView({block:'nearest'})`) with a brief highlight.
- **After a refusal, show the reason on the thing:** «Choose a size» scrolls to the line without a size and opens it,
  rather than only a toast.
- **The active tab of a scrolling tab row scrolls into view.** The start action («+ New») is never inside the
  scrolling row — it stands still beside it.
- **A field that opens a keyboard is scrolled above the keyboard** ([mobile.md](mobile.md)).
- **Lists keep their scroll position** when you come back from a detail.

## Keyboard and pointer

- **Every action reachable by keyboard**, in visual order, with a visible `:focus-visible` ring; rows that open are
  `role="button"` with Enter/Space.
- **Shortcuts for the frequent:** `/` or Ctrl/Cmd+K for search, Enter to add the first search result, Esc to close,
  digits on a keypad screen. Show them in tooltips, not in a manual.
- **Hover is a hint, never the only way** (touch has no hover); right-click menus mirror a visible «⋯».
- **Hardware the job uses:** barcode scanners type into the focused field and end with Enter — keep a field focused
  where scanning happens; number pads map to the on-screen keypad.

## Status icons act

An icon that shows a state (network, sync, printer, update, notifications) does the obvious thing on a tap — refresh
now, retry, open the queue, install — and says how it went in a toast. An icon that only opens an explanation of what
it already shows wastes the tap.

## Checks

- Press every visible control and confirm something **other than the control itself** changed
  ([prototype.md](prototype.md) has the script).
- For each action, name its class (reversible / created / final / destructive / opened) and check its way back exists.
- Try each gesture's alternative without the gesture.
- Try the first tap on each control on a real touch device or emulator.
