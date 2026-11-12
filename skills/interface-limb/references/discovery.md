# Discovery — people, jobs, context, variants, inventory

Read before any new screen, redesign or mock. A careful design that skips this passes critics and fails the owner:
the critics judge pictures, the people who use it judge the work. Every item here is a list you write down, not a
mood you hold.

## Contents
- Who, and in what conditions
- Jobs, walked step by step
- The inventory of what exists today
- The variants matrix
- Every device gets the same jobs
- Do not invent mechanisms
- Information architecture and navigation
- Output of discovery

## Who, and in what conditions

For each role (cashier, manager, owner, courier, customer, admin): what they hold in their hands, where they stand,
light, noise, gloves, a shared device or their own, how many seconds they have, how trained they are, how often they
do it (every minute vs once a month), what language they work in, what the costly mistake is. A cashier with a queue
and a phone ringing is a different user from an owner reviewing a report at night, even in the same app.

## Jobs, walked step by step

For each role write the jobs of a real day as steps (who, where, with what in hand, what triggers it, what "done"
means), including the unhappy ones:

- the main job (take an order and get paid; book an appointment; approve an expense);
- changing it halfway; two at once (a call comes while an order is half built); cancelling; correcting after the fact
  (refund, edit, re-send);
- handing over to someone else (to the kitchen, to a courier, to the next shift), and getting something back (the
  courier returns with cash);
- the network drops; the printer is out of paper; the card reader does not answer;
- the first day (empty data, nothing configured) and the busy day (hundreds of items).

Then draw **where each step happens.** A step drawn on a screen where it does not happen (taking a courier's cash inside
a new order) is a wrong screen however well drawn.

## The inventory of what exists today

Before redesigning a screen, list every control and state it has now, **including the quiet ones in the shell**:
refresh / update, profile and sign-out, sync status, language, theme, notifications, help, device settings. Also list
what was already **approved** in earlier rounds (each static mock screen, each owner remark). A redesign may move,
merge or drop items — never silently. The inventory is the checklist the mock is checked against before it is shown:
present / missing / dropped by decision.

## The variants matrix

Settings, roles, plans and conditions that change the screen. Typical axes:

- modules on/off (no kitchen display → «Pay», not «Pay and send to kitchen»; no delivery → no courier anything);
- role (staff PIN 4 digits, owner 6; who sees money, who can refund);
- plan or feature flags;
- online / offline / slow; first run / busy day;
- locale (language, currency, right-to-left);
- device class (phone, tablet, desktop, kiosk, a shared terminal).

Name each variant and draw the ones that change the layout or the words. In an interactive mock, each axis is a
switch ([prototype.md](prototype.md)).

## Every device gets the same jobs

For each job, check it can be done on each device the role uses. The phone is not a smaller desktop: it has its own
layout ([layout.md](layout.md)), but not fewer jobs. If the desktop has parallel drafts, sections, search and an order
type, the phone has them too.

## Do not invent mechanisms

A mock may not introduce in passing a new numbering scheme, a new money flow, a new state, a new message template, or
an undo for something that cannot be undone. If the product does not have it, either draw the existing mechanism or
ask, and if a new mechanism is agreed, write it as a product requirement next to the mock.

## Information architecture and navigation

- **Where things live** follows the jobs: what is done every minute is one tap from anywhere; what is done once a month
  can be two levels deep. Settings are not a junk drawer for features that had no home.
- **Navigation model by device:** bottom bar (phone, 3–5 destinations), side rail (tablet/desktop), sidebar with
  sections (admin with many areas), tabs for siblings within one area. The same destinations in the same order on
  every device.
- **Back goes back** to the exact place (scroll, filter, selection) — the platform back on Android, the back gesture on
  iOS, browser history on the web; deep links open the same state.
- **The shell carries the person and the device:** who is signed in, the venue or workspace, sync and update state —
  in fixed places ([interaction.md](interaction.md) on status icons).
- **Search is navigation** in any area with more than a screenful of things: by name, by number, by phone.

## Output of discovery

Four written lists before the first pixel: roles and conditions, jobs as steps (with the screen each step is on), the
inventory (today + approved), the variants matrix. Give them to critics together with the screens
([critique.md](critique.md)).
