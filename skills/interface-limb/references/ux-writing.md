# UX writing — the words are part of the interface

Copy is UI. Vague labels, blaming errors, and generic microcopy cheapen an interface as fast as bad
spacing. Keep the voice plain, specific, and human.

## Buttons and links

- **Label = verb + object, named for the outcome.** Replace generic labels:
  - `OK` → "Save changes" · `Submit` → "Create account" · `Yes` → "Delete message"
  - `Cancel` → "Keep editing" (say what cancelling *does*) · "Click here" → "Download PDF"
- **Destructive buttons name the object and count:** "Delete 5 items", "Delete 'Project Alpha'".
- **Links must make sense out of context** (screen-reader users tab through them): "View pricing
  plans", never "Click here" / "Learn more" alone.

## Errors — never blame the user

Every message answers three questions: **what happened, why, and what to do next.** Templates:

- Validation: `"[Field] needs to be [format]. Example: [example]"` →
  "Email addresses need an @ symbol. Try: name@example.com" (not "You entered an invalid email").
- Permission: "You don't have access to [thing]. [what to do instead]."
- Network: "We couldn't reach [thing]. Check your connection and try again."
- Server: "Something went wrong on our end. We're looking into it. [alternative action]."

Place errors **inline, next to the field** (not one summary at the top), and mark them with
`role="alert"` / `aria-live` so they're announced. Active voice; no "Oops!"; no exclamation marks
in error or success states.

## Confirmations and destructive actions

- Prefer an **undo toast** over a confirmation dialog for most destructive actions ("Message deleted
  · Undo"). Reserve confirm dialogs for irreversible or batch operations.
- When you do confirm, name the object and the irreversibility: "Delete 'Project Alpha'? This can't be
  undone." Buttons: "Delete project" / "Keep project" — not "Yes" / "No".

## Loading and empty copy

- Loading copy is **specific and time-boxed:** "Analyzing your data… this usually takes 30–60 seconds",
  not "Loading…". For long AI responses, **stream tokens** instead of showing a spinner.
- Empty-state and no-results copy **suggests a next step:** "No results for 'foo'. Try a broader
  search." not a bare "0 results". (See the three jobs of an empty state in [states.md](states.md).)

## Consistency and tone

- **Terminology lock:** one word per concept across the whole product. Pick *Delete* (not
  Delete/Remove/Trash), *Sign in* (not Log in/Enter), *Create* (not Add/New) — and never vary it.
- **No em-dashes (—)** anywhere (the strongest AI tell) — use commas, colons, or parentheses.
- **No buzzwords:** streamline, empower, supercharge, leverage, seamless, world-class,
  enterprise-grade, next-generation, game-changer, mission-critical. Say what the thing does.
- No humor in error states. Keep success quiet and factual.

## Localization budget

If the UI may be translated, leave room: German/Finnish text runs ~30–40% longer than English, CJK
~30% shorter. Don't pack text to the pixel, and keep numbers/dates as separate formatted strings
(thousands separators, `1.2K`, locale-aware or relative dates — avoid ambiguous `01/02/03`).

## Localization integrity — unify the string, translate for real

- **Don't fragment a sentence into glued pieces.** "{count} signals for {period}" is **one** message with
  placeholders and a plural block, not a number + a manually-pluralized word + string concatenation in the
  component. Hand-rolled plural helpers (`pluralRu([...])`) are per-language and silently wrong in every
  other locale.
- **Use ICU MessageFormat for anything with a count or variable.** `{count, plural, one {# signal} other
  {# signals}}` lets each locale carry its own correct grammar (Russian one/few/many, English one/other,
  Tajik its own). A `t()` with no interpolation/plural support is itself a flag — upgrade the engine, don't
  pour more fragmented strings into it.
- **Never fake a translation to satisfy a catalog.** When a catalog enforces that every locale has every
  key, fill them with **real** translations, not copies of the source language. A copied value passes the
  parity check while lying that it's localized: a false "done" worse than an explicit, tracked gap.
  Translate for real, or make the missing-locale gap visible and tracked — green on fake data is a false
  signal.
