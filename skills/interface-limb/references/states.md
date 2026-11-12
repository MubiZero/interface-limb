# States, feedback and attention

Every screen is mostly states the designer did not draw: loading, empty, partial, failing, offline, waiting for the
user. And every product has to tell people things — that something worked, that something went wrong, that something
needs them now. This file is how to do both with one consistent set of patterns.

## Contents
- One feedback pattern per kind of message
- The attention ladder
- Toasts
- Data states: the full list
- Loading
- Empty states
- Errors
- Offline, sync and stale data
- Optimistic UI and long operations
- Badges and counts
- Permission priming

## One feedback pattern per kind of message

Pick once, use everywhere:

| Kind of message | Pattern |
|---|---|
| The result of an action the user just took | a **toast** near the action (with «Undo» when reversible) |
| A field's input is wrong | a line **under the field**, on blur or on submit, never a toast |
| A persistent condition (network, printer, sync, update) | an **icon that changes** in a fixed place; a tap acts ([interaction.md](interaction.md)) |
| Work is blocked until something is fixed | a **banner** at the top of the area it blocks, with the fix |
| An event that needs an answer (a new order, an incoming call, a request) | a **card** on every screen (the attention ladder below) |
| A decision that cannot be undone | a **dialog** that names the consequence |

No ad-hoc hint lines inside the layout ("First choose a size"), no alerts for success, no dialog for something a toast
can say.

## The attention ladder

Match the loudness to how soon a person must act, and climb only when they do not answer:

1. **Quiet:** a count or a dot on a navigation item (things waiting, nobody in a hurry).
2. **Visible:** the object itself in a strip or list the user is looking at (the orders themselves, urgent first), not
   a number about them — show objects, not counts of them.
3. **Card:** an event that needs an answer gets a card **on every screen** of that role, at a fixed place, saying where
   from, what, how much, and **how long it has waited** (a live timer); one tap answers it (Accept), another opens it.
   Two at once: the oldest first, «+1 more» beside.
4. **Sound and haptic** when it arrives; a soft repeat every 10–15 s while unanswered; the card escalates in color
   after a threshold (a minute). Sound respects the device's silent mode and a per-device setting.
5. **Block** only for what must stop everything (a shift cannot continue without a closed cash drawer).

Never let an event that waits for a person live only in a badge.

## Toasts

- **Where:** bottom center on phones (above the bottom bar and the primary action, never over them), bottom or near the
  action on wide screens. One stack.
- **What:** one short line in the user's words, the object named («Order 737 handed over»), optionally one action
  («Undo», «Open»). Never two actions, never a paragraph.
- **How long:** plain 3–4 s; with an action 6 s; money or someone else affected 8 s; never auto-dismiss something the
  user must read to act. Hover or touch pauses the timer. WCAG 2.2.1 (timing adjustable) applies to anything
  essential.
- **Stacking:** up to three; a toast with an action is not destroyed by the next one.
- **Accessible:** `role="status"` / live region polite; errors assertive.

## Data states: the full list

For each data view, design all of them (a table in the screen's spec):

- **Loading first time** · **refreshing with data shown** · **empty, first use** · **empty, filtered/searched** (with
  the query and a way to clear) · **one item** · **many** (hundreds; virtualized, with a count) · **partial** (some
  parts failed) · **error** (with retry) · **offline** (cached, with its age) · **stale** («updated 4 min ago») ·
  **no permission** (say who can grant it) · **being edited by someone else** (where it applies).

## Loading

- Under ~1 s show nothing; 1–10 s a skeleton that mirrors the final layout (or a spinner for one small module); past
  10 s determinate progress with what is happening.
- Show-delay ~150–300 ms and minimum visible time ~300–500 ms so indicators never flash.
- Loading happens **inside** the element that waits (a button shows its own spinner and keeps its width; the list
  keeps its old rows while refreshing).
- What is local (a bundled desktop shell, cached data) never shows a network spinner.

## Empty states

Three jobs: say what this place is for, why it is empty (first use, filtered, all done), and offer the one action that
fills it. Positive and specific («No orders waiting — new ones from the site appear here with a sound»), never "No
data". First-use empty states are the best onboarding surface.

## Errors

- **Say what happened, in the user's terms, and what to do now** («The card reader did not answer — try again or take
  cash»). Never blame, never show a code alone; log the code for support.
- **Keep what the user typed.** An error never clears a form.
- **Offer the way forward in place:** Retry, a different method, «Continue offline».
- **Distinguish** a problem the user can fix (a field) from one they cannot (the server) — the second gets reassurance
  and what the product will do («Saved on this device, will send when online»).

## Offline, sync and stale data

- **Decide what works offline before drawing:** which actions continue (taking cash, printing), which wait (card
  payments, SMS), which are impossible. Each disabled action says why («needs connection»), not just grays out.
- **A queue is visible:** an icon with the count of what waits to send, a tap retries now and says what happened.
- **When the link returns,** say what was sent («2 sales sent»), resolve conflicts with a rule the user can understand
  («the later change wins; the earlier is in history»).
- **Show the age of data** where acting on stale data costs money or safety.
- **Messages that will go later say so:** «SMS will go when the connection is back», not «SMS sent».

## Optimistic UI and long operations

- Update the UI at once when success is very likely; reconcile when the server answers; on failure roll back visibly
  with the reason and a retry — never silently.
- Operations longer than a few seconds run in the background with a place to watch them (a progress row, a
  notification), and the user can keep working.

## Badges and counts

A badge counts **what waits for this person's action**, not everything in the list. A count that does not go down when
the user acts trains them to ignore it. Zero shows nothing.

## Permission priming

Never fire a system permission prompt cold. Ask in context, when the feature is tapped, after a screen that says what
it is for; on denial explain the cost and offer the path to Settings.
