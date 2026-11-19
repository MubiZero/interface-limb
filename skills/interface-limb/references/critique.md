# Critique and testing — judging the work, not the pictures

How to review a design (yours or someone else's), how to brief a critic, and how to learn from real people with little
time. A critic who only looks at pictures finds pixels; the owner finds that the work cannot be done.

## Contents
- Three passes
- Heuristics that catch the most
- Severity of a finding
- Orientation test (Krug)
- Why a control fails (Norman)
- Release gate review (verdict, cut list)
- Briefing a critic (a person or an agent)
- Testing with people
- After release
- Writing findings

## Three passes

1. **Defects:** things that are broken — dead controls, clipped text, a flow that loses data, a number that does not add
   up, a contrast failure, a target under 44 px.
2. **Friction:** things that work but cost the user — an extra step, a hidden action, a confirm that adds nothing, a
   choice asked too late, a list without search, an action with no way back.
3. **Design:** things that work and are easy but read cheap or inconsistent — hierarchy, spacing, the seven things,
   the anti-slop list.

Do them in that order; a polished screen with a dead button is a dead screen.

## Heuristics that catch the most

Nielsen's ten, phrased as checks:

1. **Status visible** — does the person always know what is happening (sending, offline, waiting for whom)?
2. **Their words** — would the person at the counter say this label?
3. **Control and freedom** — is there a way back from every action ([interaction.md](interaction.md))?
4. **Consistency** — one gesture grammar, one feedback pattern, one name for one thing.
5. **Error prevention** — are wrong inputs impossible or caught before they cost (required choices asked before)?
6. **Recognition over recall** — are options visible rather than remembered (a known customer's name shown)?
7. **Flexibility** — accelerators (gestures, shortcuts, search by number) for the trained, visible paths for the new.
8. **Minimal** — does every element earn its place on this screen?
9. **Errors explained** — what happened and what to do, in place.
10. **Help in context** — empty states and first use teach; no manual needed.

Plus the **cognitive walkthrough** for each job: at each step, will the user know what to do, see the control, connect
it to their goal, and understand the feedback?

**Scoring over time (optional):** when the same surface gets re-reviewed across sessions, score each applicable
heuristic 0–4 (0 absent, 4 excellent; most real interfaces land 2–3) instead of pass/fail, and track the total out of
4× the number scored (some heuristics — flexibility, help in context — can be n/a on a landing page; renormalize the
denominator when they are). A single review does not need the number; a trend across rounds does, and it is honest
only when "4" means genuinely excellent, not "good enough for now."

## Severity of a finding

Rate every finding 0–4 (Nielsen) so the list is a triage, not a mood: **0** not a problem · **1** cosmetic · **2**
minor (a detour, recoverable) · **3** major (people fail or give up on a job, or lose work) · **4** catastrophic (a
core job cannot be done, money or data is lost). Weigh three things together: how often it happens, how much it costs
when it does, whether it keeps happening to the same person (a trick learned once is cheaper than a trap that stays).
Order the report by severity, then by how many places the class touches. A 4 outranks any number of 1s.

## Orientation test (Krug)

On any screen, a stranger should answer in a few seconds, without thinking: **where am I** (title, active tab), **what
are my options** (the primary action and the ways out are visible), **how did I get here and how do I go back** (back
goes to the exact place, [discovery.md](discovery.md)). Run it on the screens people land on from outside: a deep
link, a notification, a restored session, the first screen after sign-in. Two clicks that need no thought beat one
that needs a pause; the number of taps matters less than the number of questions the person has to ask.

## Why a control fails (Norman)

Name the failure before proposing the fix; it picks the fix.

- **Gulf of execution** — "how do I do what I want?" Missing or false **signifier** (a thing that looks pressable and
  is not, a pressable thing that looks like text), no visible constraint, a mapping that does not match the thing it
  moves (the control order differs from the order on screen). Fix: make the affordance visible, constrain the wrong
  inputs out, put controls where what they affect is.
- **Gulf of evaluation** — "what happened?" Silent success that makes people repeat the action, a state change that
  shows nowhere, a result far from the cause. Fix: feedback at the place of action within 100 ms, the changed object
  visible ([states.md](states.md)).
- **Slip vs mistake.** A *slip* is the right goal with the wrong hand (a mis-tap, a double submit, the wrong row):
  answer with constraints, forcing functions and a way back ([interaction.md](interaction.md): undo beats a confirm
  the person dismisses by reflex). A *mistake* is a wrong model of the system (they expect "Save" to publish): answer
  with a clearer model, in the words of the person ([ux-writing.md](ux-writing.md)). Blaming "user error" for
  something the interface makes easy is itself the finding.
- **Error message check:** says what went wrong; says what to do; does not blame; keeps what the person typed; offers
  another way when this one is closed.

## Release gate review (verdict, cut list)

For "is this ready to ship?" on a working build (staging, a clickable prototype; never on a document or slides):

1. Use it cold, on the real device, with real data volume, as the person who does the job.
2. Name **the one thing** the screen or release is for. If you cannot, that is finding one.
3. **Back of the fence:** the parts nobody demos get the same bar as the home screen: empty, error, offline, loading,
   settings, the 404, the emails and push texts, the first run, cancelling and deleting. Review the slowest and worst
   moment, not the happy path.
4. Count **steps to first value** (sign up to the first useful result); each step must earn its place.
5. Judge subtraction as hard as addition: list what to **cut** (a control, a screen, a message) before what to fix.
   Fixing by adding is the default failure; for every addition name what it replaces.
6. Verdict: **ship** or **not done**, with the ranked fix list. "Good enough" is not a verdict; no consensus verdicts.

This is the opposite of a design-by-committee round: one reviewer, a blunt verdict, a short list.

## Quick self-check before real people are available

Five archetypes to walk the job through yourself when no round of real users is scheduled yet — a cheap filter before
a showing, not a replacement for "Testing with people" below. Pick 2–3 that fit the surface, name the exact element
that fails them, not a generic worry:

- **The impatient expert** — skips onboarding, hunts for a shortcut or bulk action immediately. Fails on forced
  tutorials, no keyboard path, one-at-a-time flows where batch is natural.
- **The first-timer** — reads every label, hesitates before anything unfamiliar. Fails on icon-only nav, jargon, no
  confirmation that an action worked.
- **The person on a screen reader or keyboard only** — tabs linearly, can't see hover-only state. Fails on invisible
  focus, meaning carried by color alone, a control a screen reader cannot name.
- **The one who pokes at the edges** — empty list, 1 item, 1000 items, a very long name, a refresh mid-flow. Fails on
  silent breakage, lost state, an empty state with no next step.
- **The distracted phone user** — one thumb, interrupted mid-task, patchy signal. Fails on primary actions out of
  thumb reach, lost progress on interruption, a tap target under 44 px.

## Briefing a critic (a person or an agent)

Give them the work, not only the images:

- the roles and the conditions; the jobs as steps; the inventory of what must be there (today + approved); the variants;
  the earlier remarks register;
- the devices and exact sizes (1366×768, 412×900, 360×640);
- the instruction to **do each job on each device** and to **measure** — target sizes, sheet heights on a short screen,
  the width of a growing row at 5 items, contrast from the tokens — and to list what the mock does not show;
- the format: findings ordered by impact as classes of problem with a fix in the shared layer, then the owner's
  earlier remarks that are not fully done, then the inventory gaps, then lessons for the process.

An agent critic should be read-only and should say for each finding whether it was checked live or read from the code.
Verify a sample of its findings before acting: a report is not proof.

## Testing with people

- **Five people per round** find most of the problems a round can find; three rounds of five beat one of fifteen.
- **Give a job, not a tour:** «A customer calls and wants a large pizza delivered, paying cash from 200 — take the
  order.» Watch; do not help; note where they hesitate, mis-tap, or ask.
- **Measure:** completion, time on task, errors, and one question at the end (single ease question, or SUS for a whole
  product).
- **Hallway tests** with someone who has never seen it catch the labels and the hidden actions in ten minutes.
- **Test in the conditions:** standing, with a queue, on the real device, in the real light.

## After release

Instrument the jobs (started, finished, abandoned, time), watch support questions and crash reports, and read them as
design input: a repeated question is a label or a missing state.

## A fresh pass before every showing

The owner's first glance finds what the builder no longer sees. Before showing a round, take a deliberately fresh pass
yourself on the phone size: read every toast and label aloud as the person at the counter would say it, ask of every
list «is it obvious what to tap and what it will do», of every object «what can I do with it now, and how do I undo
it», and look at every screen in both themes. Fix those, then show.

## Writing findings

- One finding is a **class** of problem («tab rows overflow at 3+ tabs on every width»), with where it shows, why it
  matters to the person, and the fix in the shared layer.
- Say what was checked live and what was read in code.
- End with what was not checked (real device touch, sound, large text) — a review that claims everything checked is
  not believed.
