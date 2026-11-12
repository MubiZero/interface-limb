# Contexts — the same rules, weighted by where the product is used

The workflow is the same everywhere; what "good" means shifts with the context. Decide which context each screen is
in during discovery ([discovery.md](discovery.md)), then apply the weights below.

## Contents
- Operations: tills, kiosks, dispatch, warehouse, field
- Back office and admin
- B2B SaaS and dashboards
- Consumer apps
- Marketing pages
- Large screens and kitchen displays
- Native desktop shells
- Trust: money, data, consent

## Operations: tills, kiosks, dispatch, warehouse, field

People in a queue, standing, often trained on the job, on a shared device, with interruptions.

- **Speed and recovery beat discoverability:** the frequent action is one tap and big; accelerators (search by number,
  scanners, gestures) for the trained; every mistake reversible in place.
- **Glanceable:** status by color + word + position, readable at arm's length; numbers large and tabular.
- **Interruptions are normal:** parallel drafts (tabs), nothing lost when a call comes, incoming events as cards on every
  screen ([states.md](states.md)).
- **Offline is a working state,** not an error: what continues, what waits, a visible queue.
- **Shared device:** fast switch of person by PIN, auto-lock, no personal data left on screen.
- **Money is exact:** consequences shown while typing, final actions named, refunds as separate actions with reasons,
  every cash movement attributable to a person and an order ([input.md](input.md)).
- **Hardware:** printers, scanners, card readers, cash drawers each have a status icon and a recovery path.

## Back office and admin

Infrequent but consequential: clarity and safety over speed. Tables with search, filters and bulk actions; forms with
validation and drafts; audit trail for changes; destructive actions confirmed with their scope; roles visible
(«only the owner can change prices»).

## B2B SaaS and dashboards

Dense, scannable, keyboard-friendly. A dashboard answers a question («are we on track today?») — numbers with
comparison and trend, not KPIs repeated across pages; drill-down from every number; empty and first-run states that
teach setup. Charts follow a data-visualization method (a separate skill if available).

## Consumer apps

Delight and trust; onboarding by doing; one task per screen; generous spacing; motion that guides; permission
priming; personalization by defaults, not settings.

## Marketing pages

A page that must convince a stranger: [marketing-landing.md](marketing-landing.md).

## Large screens and kitchen displays

Read from meters away: very large type, high contrast, few words, color-coded age (fresh → late), no small touch
targets; bump/complete by large areas; sound for new items.

## Native desktop shells

When the app is a desktop shell around a web view (Electron, Tauri, WebView2):

- Cursors and selection match the OS (`cursor: default` on buttons, UI text not selectable, inputs selectable).
- A custom titlebar ships the full set (minimize, maximize/restore, close) and an OS drag region.
- Window drag through the OS, not a JavaScript mouse-move.
- No browser context menu or shortcuts that reveal the web (Reload, Inspect); map or intercept them.
- Local content never shows a network spinner.

## Trust: money, data, consent

- **No dark patterns:** no pre-ticked consent, no hidden costs revealed at the end, no confirmshaming, no fake scarcity
  or fake progress, no roach-motel cancellation (cancelling is as easy as subscribing).
- **Prices honest and complete** before the final step; fees named.
- **Consent is specific and refusable**; the privacy-preserving option is as easy as the other.
- **Destructive and money actions** name their scope and consequences; receipts and histories exist for what moved
  money.
- **Security without friction:** passkeys and OTP autofill, PIN on trusted shared devices, sensible session lengths;
  explain why something is asked.
