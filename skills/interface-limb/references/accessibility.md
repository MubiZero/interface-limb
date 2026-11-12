# Accessibility — the whole of it, not only the floor

SKILL.md has the floor (contrast, targets, focus, reduced motion). This file is the rest, ordered by how often it is
missed in app UI. Numbers and sources in [standards.md](standards.md).

## Contents
- Semantics and screen readers
- Focus
- Gestures and pointers
- Time
- Motion and flashing
- Text size and reflow
- Color and contrast details
- Cognitive load
- Forms and authentication
- Testing

## Semantics and screen readers

- Use the platform's controls (button, link, checkbox, switch, tab) or give custom ones the role, name, state and value
  (`role`, `aria-*`; Flutter `Semantics`; iOS `accessibilityLabel/Traits`; Android `contentDescription`/roles).
- Every icon-only control has a name that says the action («Remove Cheeseburger», «Close», «Call +44 20 …»).
- Changing content announces itself: toasts and counters in a polite live region, errors and urgent events assertive;
  do not announce every keystroke.
- Headings structure each screen; lists are lists; a table is a table with headers.
- Images that carry meaning have alt text; decorative ones are hidden from readers.
- Reading order matches visual order.

## Focus

- Visible focus on everything focusable (`:focus-visible`, ≥ 3:1 against neighbors), not removed for looks.
- Opening a dialog or sheet moves focus into it and traps it there; closing returns focus to the opener; Esc closes.
- Focus is not hidden under sticky headers, toasts or keyboards (WCAG 2.4.11).
- After an action that removes the focused element (a row removed), focus goes to a sensible neighbor.

## Gestures and pointers

- Every multi-point or path gesture (swipe, pinch, drag) has a single-tap alternative (WCAG 2.5.1, 2.5.7).
- Actions fire on the up event and can be cancelled by moving away (2.5.2).
- Targets ≥ 44×44 pt (iOS) / 48×48 dp (Android); on the web ≥ 24×24 CSS px minimum (2.5.8), 44 recommended for touch.
- The visible label is part of the accessible name (2.5.3) so voice control works.

## Time

- Anything that times out can be paused, extended or turned off (2.2.1): auto-advancing result screens pause on touch;
  undo toasts last long enough to read and act (6–8 s), and the action is reachable by keyboard before it goes.
- Sessions warn before expiring and keep the data.

## Motion and flashing

- Honor reduced motion live ([motion.md](motion.md)); no flashing more than three times a second.

## Text size and reflow

- Text scales to 200 % without loss (1.4.4); content reflows at 320 CSS px wide without horizontal scroll (1.4.10).
- Text spacing overrides (line height 1.5, letter spacing 0.12 em) do not clip (1.4.12).
- On mobile, support Dynamic Type / font scale; test at the largest step.

## Color and contrast details

- Text ≥ 4.5:1 (large ≥ 3:1); icons, borders and focus rings ≥ 3:1 (1.4.11).
- Disabled controls that explain why they are disabled keep readable text.
- Meaning never by color alone (1.4.1): status pills carry a word, charts a pattern or a label.
- Check both themes and every status pair (text on its container).

## Cognitive load

- One primary action per screen; plain words; consistent placement; no memory tests (show the customer's name, the
  expected amount).
- Errors explain and keep the input; required steps asked once, carried forward (3.3.7).
- Long flows are split into steps with progress and a way back that keeps answers.

## Forms and authentication

- Labels and instructions visible, errors identified in text and linked to the field.
- No cognitive function tests to sign in (3.3.8): allow paste, password managers, OTP autofill, passkeys; PINs are
  acceptable for staff on a shared device.

## Testing

- Keyboard only: do every job.
- A screen reader (VoiceOver, TalkBack, NVDA) on the main job.
- 200 % text and 320 px reflow.
- Automated checks (axe, Lighthouse, Flutter `meetsGuideline`) catch ~30–40 %; they are the start, not the proof.
