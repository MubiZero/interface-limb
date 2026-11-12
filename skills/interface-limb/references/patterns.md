# Product patterns — flows people already know

[design-system.md](design-system.md) has the catalog of shared *surfaces* (confirm, pick one, type a number…). This
file is the next level up: the flows a product is made of, with the decisions each one needs. Use the known shape;
invent only where the job is new.

## Contents
- Search, filter, sort
- Tables and bulk actions
- Lists with details (master–detail)
- Create, edit, delete
- Drafts and parallel work (tabs)
- Sign-in, PIN, switching person
- Onboarding and first run
- Settings
- Checkout and payment
- Assigning work to people
- Notifications and inbox
- Import, export, print
- Help and discoverability
- Multi-step flows (wizards)
- Framing a decision

## Search, filter, sort

- Search where the things are, always visible on wide screens, an icon that opens a field on phones. It searches
  names, numbers and phones (whatever people say aloud), tolerates case and partial input, shows results as you type,
  Enter takes the first. Empty result: say what was searched and offer to clear.
- Filters as chips with counts in a row above the list; the active ones visible; one tap to clear all.
- Sort only when users need another order than the natural one (urgent first, newest first).

## Tables and bulk actions

Sticky header, aligned numbers (tabular, right-aligned), row hover and selection, a checkbox column only when bulk
actions exist; the bulk bar appears with the count selected and the actions; destructive bulk actions confirm with the
count. Wide tables scroll horizontally inside their container with the first column pinned; on phones, rows become
cards.

## Lists with details (master–detail)

A tap on a row opens the item; on wide screens in a right column ([layout.md](layout.md)); the row's main action works
from the row too (a button, a swipe). Details show the object first (what, who, how much, state), its steps as the
primary button, secondary actions as small buttons, history at the bottom.

## Create, edit, delete

Create where the list is («+ New» in sight); edit in place for one field, in a form for many; save explicitly for
forms with consequences, autosave for notes and drafts; delete as reversible (archive + undo) unless it truly must be
final ([interaction.md](interaction.md)).

## Drafts and parallel work (tabs)

When work is interrupted (a call comes while an order is half built), keep parallel drafts as tabs: each with its own
content and a short label with its sum; «+ New» outside the scrolling row; the active tab scrolled into view; empty ones
vanish when left; «×» on the active one, with «Undo» when it had content; at least one always remains.

## Sign-in, PIN, switching person

Phone or email with a one-time code that fills itself; passkeys where available; on shared devices a PIN pad in the
thumb half that goes in on its last digit; «Switch person» and «Lock» in the profile; the language picker on the
sign-in screen, near the action, not centered as decoration.

## Onboarding and first run

Learn by doing: the first empty state teaches the first action; sample data only if clearly marked; progress that
starts partway (account created counts); value before any ask (signup after a first result).

## Settings

Grouped by what the person is trying to do, the frequent first; each setting says its effect; changes apply at once
(with undo) unless they affect others; dangerous ones at the bottom, separated. Device settings (printer, language,
theme) apart from account and business settings.

## Checkout and payment

All the ways to pay on one screen (cash, card, transfer, split); the amount large; cash typed with change or shortfall
live; split computed («100 cash + 42 card»); short cash offers «Rest by card» in place; card and transfer need the
link and say so offline; the result screen shows the number and the change first, pauses on touch, and leads to the
next order. Refund is a separate, reasoned action on a closed order.

## Assigning work to people

A list of people sorted by who can take it now, each with their state and the reason («free», «on the road», «holds
cash — hands in first», «off shift — Call»); assigning notifies them; changing frees the previous one; the work's
next step («Hand over · change 9.00») and the person's state move together.

## Notifications and inbox

Events that wait for someone use the attention ladder ([states.md](states.md)); an inbox lists them with read/unread
and an action on each; push notifications only for what the person would want to be interrupted for, each with a
deep link to the object.

## Import, export, print

Import with a preview and a report of what failed per row; export in the format the next tool needs (CSV, PDF);
printing has a status, a retry, and a «print again» on the object (receipts, kitchen tickets, labels).

## Help and discoverability

Teach in empty states and first use; tooltips for icon-only controls and shortcuts; a «What's new» only when
something changes how a job is done; help that opens on the current screen's topic; a diagnostics send from the
profile.

## Multi-step flows (wizards)

One question per screen; a stepper for where you are; the next step adapts to the last answer; back keeps the
answers; two short steps beat one dense screen.

## Framing a decision

Smart defaults (the most likely choice pre-selected, override obvious); progress never starts at 0 %; value before the
ask; let people build before they commit; honest loss framing with real stakes; anchor prices deliberately. The line
is honesty: a fabricated number is a dark pattern, not craft ([contexts.md](contexts.md) on trust).
