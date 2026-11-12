# Input — forms, numbers, money, choices

Input is where people make mistakes and where the product either catches them gently or lets them through. The rules
below cover general forms and the high-stakes inputs that most AI-built UI gets wrong: numbers, money, codes and
required choices.

## Contents
- Forms
- Show the consequence while typing
- Fix in place, not in a second round
- Numbers and money
- Codes, PINs, one-time passwords
- Required choices before the action
- Pickers: dates, times, quantities, people
- Phones, addresses, names
- Scanners and hardware keys

## Forms

- Labels outside the field, always visible; a placeholder is an example, not a label.
- One column; group related fields; the order of the paper or conversation the user knows.
- Validate on blur (or on submit), not on every keystroke; errors under the field in the user's words; do not
  pre-disable the submit button for an incomplete form — let it say what is missing on press.
- The keyboard fits the field: `inputmode="numeric" | "decimal" | "tel" | "email"`, `autocomplete` tokens so the OS
  fills names, addresses, one-time codes.
- Do not ask what you know (WCAG 3.3.7 Redundant Entry): carry forward what was entered earlier, pre-fill from a known
  customer, default to the last used value.
- Smart defaults: an optional choice is an empty field with a quiet «not chosen — can be set later», not a «Decide
  later» button.

## Show the consequence while typing

Whatever a number will cause, show it live next to it, before any confirm:

- cash given → «Change 58.00», or «Short 7.00» in danger color;
- a discount → «−14.00 · to pay 128.00»;
- an amount handed in by a courier/cashier → «Short 10.00» and a required reason;
- a quantity → the line total; a booking length → the end time and price.

The primary button states the result too: «Accept 200.00», «Short 7.00» (disabled, readable), «Charge 142.00 by
card».

## Fix in place, not in a second round

When the input cannot complete the action, offer the fix on the same screen rather than a process in two passes:

- cash short → «Rest by card» turns the same screen into a split payment with the cash already typed (not "accept
  cash, then start a second payment for the rest");
- a time already taken → the nearest free times as chips under the field;
- an address outside the zone → the zone's fee or the nearest pickup point.

## Numbers and money

- **A keypad for money on touch tills and kiosks** (big keys, 00, backspace), the amount large above it, keys in the
  thumb half. On desktop, a numeric field that accepts typing and arrow keys.
- **Typed from the left as written** («5», «50», «500») for whole currency units; for minor units use either a decimal
  key or the "cents shift" pattern, and say which.
- **Quick amounts only when they mean something** («Exact 145.00» when the expected sum is known). Unlabelled quick
  sums (207, 250) confuse more than they save; in cash handling the owner may want none at all.
- **Empty is not zero, and empty is not "the expected amount".** A blank field accepts nothing; 0 can be typed and means
  zero; never treat blank as the expected value silently.
- **Tabular figures, thousands separators in the locale's style, the currency where the locale puts it.**
- **Rounding rules visible** where cash rounds (to 0.50, to 1).

## Codes, PINs, one-time passwords

- **Complete by themselves:** a 6-digit code submits on the 6th digit; a PIN on its last digit. No extra «OK».
- **Unknown length:** if PINs of different lengths exist (staff 4, owner 6), try at 4 and continue to 6 — and make the
  rule that a 4-digit PIN cannot be the start of a 6-digit one in the same place.
- **Dots grow as typed;** a wrong code shakes, clears and says so (toast or line), with a haptic.
- **Paste and OS autofill work** (`autocomplete="one-time-code"`); no cognitive tests to sign in (WCAG 3.3.8).

## Required choices before the action

If a product cannot be ordered without a choice (size, variant, date), ask it **before** the item goes in, in one tap
(a sheet of big options with prices), at least on phones. Letting it in "unfinished" and blocking at checkout moves the
error to the worst moment. On a fast desktop till both can coexist: the tap adds and opens the line's choices, and
payment scrolls to and opens the line still missing one.

## Pickers: dates, times, quantities, people

- Relative choices first («As soon as possible», «in 30 min», «in 1 h»), then exact.
- Quantity: − N + always visible on a row; long press or a field for big numbers.
- People (a courier, an assignee): sorted by availability, each with the reason they are or are not a good pick
  («free», «on the road, back ~12 min», «holds cash — hands in first», «off shift — Call»).

## Phones, addresses, names

- A known phone number fills the name and the last address; show "Ruslan · 7 orders" so the person at the counter
  greets them.
- Addresses: free text with the zone or delivery fee computed beside it; a note line for the entrance or landmark.
- Names in messages are not declined or gendered by template: write «Daler handed in 145.00», not a sentence that
  needs the name in another grammatical case or gender ([i18n.md](i18n.md)).

## Scanners and hardware keys

Barcode scanners type and press Enter: keep a field focused where scanning happens and accept the scan as an add. Map
physical number pads to the on-screen keypad; Enter is the primary action; Esc goes back.
