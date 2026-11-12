# Critique and testing — judging the work, not the pictures

How to review a design (yours or someone else's), how to brief a critic, and how to learn from real people with little
time. A critic who only looks at pictures finds pixels; the owner finds that the work cannot be done.

## Contents
- Three passes
- Heuristics that catch the most
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
