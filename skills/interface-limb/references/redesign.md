# Redesigns and mocks — the misses that cost a round

Read before any restructure (a new main screen, merged screens, a new flow) and before calling a mock ready. Every rule
here comes from real reviews in which careful mocks, already passed by several critics, came back with twenty remarks
from the person who owns the product. Discovery comes first ([discovery.md](discovery.md)); interactive mocks have their
own file ([prototype.md](prototype.md)).

## Contents
- The process: one area at a time
- While drawing
- The screen speaks to the user
- Keeping the record
- Before showing it

## The process: one area at a time

1. **Discovery lists** (roles and conditions, jobs as steps, inventory, variants).
2. **Static mock of one area** in the product's own tokens, at the real sizes (phone and desktop), with real content.
   Approval of its *shape* before code: code written before agreement is written twice.
3. **Interactive mock** of the approved area when behavior matters (gestures, flows, timing): every control alive.
4. **Critique** against the jobs, not the pictures ([critique.md](critique.md)); fix; show.
5. **The owner's remarks go into a register** (below) and become rules for the next areas.
6. Only then build, from the system ([design-system.md](design-system.md)).

## While drawing

- **Repeated components are measured, not eyeballed** ([layout.md](layout.md)): one anatomy, reserved by the real data,
  drawn with the shortest and the longest content.
- **What a beginner needs is visible.** A row's main controls (− N +, remove) show without a tap; hidden-until-tapped is
  for secondary actions; a long press is never the only way.
- **One feedback pattern for the whole product** ([states.md](states.md)): toasts for results, lines under fields,
  status icons that act, banners only when blocked, cards for events that wait for someone.
- **Show the objects, not counts of them.** «3 waiting, 2 cooking» is a dashboard; the orders themselves, urgent first,
  one tap to open, is a tool.
- **An optional choice is a default, not a button.** An empty field with a quiet «not chosen — can be set later».
- **A button that stands for a process opens that process** (pick a person from a list with their availability; count
  cash with a reason when short), never a toast that pretends it happened.
- **Verb + object on every action button** («Assign courier», «Charge 142.00», «Hand to courier · change 9.00»), not a
  noun («Courier»).
- **No confirm for what the input already completes** (a PIN, a full code, a pick-one list).
- **Compact beats complete for in-flow choices:** size and add-ons inside an order line are a segmented row and a row of
  chips, not a card with a title and a hint.
- **Order a result screen by what is needed first:** what the person must say or hand over (the number, the change),
  then the follow-ups by weight. No status prose the machine handles anyway («the receipt is printing»).
- **Every action has its way back** ([interaction.md](interaction.md)), and final actions are named as final.
- **The state of the app lives in the shell's fixed places:** an update in the brand slot (the logo becomes an arrow in
  a filling ring, the name becomes «Update · 45 %»), the link as an icon that refreshes on tap — not extra buttons in
  the header.

## The screen speaks to the user

No line that explains a design decision («the owner signs in without SMS here», «as many dots as digits typed»). If the
screen needs it, the screen is unclear — fix the screen. Explanations for reviewers live in the README, and mock
controls (variant switches, "what to try") live in a separate, visibly marked layer, never in the product's own
header or profile. Words are the user's, checked against the domain: read each label as the person at the counter
would say it.

## Keeping the record

A README next to the mocks with: the remarks of each round (quoted), what was done for each, the product requirements
that follow (mechanisms the mock assumes), and what is deliberately not drawn. Before each round, re-read it: a new
version must not regress an earlier remark.

## Before showing it

- The inventory checklist: every item present, moved, or dropped by a recorded decision.
- Each job walked end to end on each device, through all screens (not screen by screen).
- The variants switched one by one.
- Every control pressed ([prototype.md](prototype.md)); every width rendered ([layout.md](layout.md)).
- A critic briefed with the jobs and asked to measure.
