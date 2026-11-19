# Marketing & landing pages — persuade a stranger in seconds

App UI serves someone who already signed in; a landing page has to **convince a visitor who has
never heard of you, in the few seconds before they leave.** Everything in SKILL.md still
applies — hierarchy, spacing, type, states, anti-slop — but persuasion adds its own layer. This
file is that layer: (1) the hero, (2) reading flow and scan patterns, (3) social proof, (4)
conversion CTAs, (5) page structure, (6) the landing-specific anti-patterns.

The governing idea: **a landing page has one job — move the visitor toward a single action.**
Every section either advances that or it's clutter. Decide the conversion goal first; design
backwards from it.

## 1. The hero — it earns the scroll or the page fails

The first screen is the whole pitch in miniature. Most visitors decide whether to stay based on
it alone, so it must answer four questions *without scrolling*:

1. **Who you are** — the product/brand, identifiable at a glance.
2. **What you offer** — the thing, in plain words, not a slogan.
3. **Who it's for** — the visitor should recognize themselves.
4. **Why it's worth it** — the **USP**: the concrete benefit or outcome that makes you the choice.

If a visitor can't answer those four after one look, the hero has failed and nothing below saves
it. Test it ruthlessly: *don't make the user scroll to understand what this is.*

**Hero anatomy that works:**

- **Headline = the outcome, not the mechanism.** "Get paid 3 days faster" beats "Cloud-native
  invoicing platform." Lead with what the user gets, name the how underneath.
- **Subhead does the supporting work** — one sentence that sharpens *who it's for* and *why now*.
- **One primary CTA, intent-named** ("Start free trial", "Book a demo"), plus at most one quiet
  secondary path (e.g. "See how it works"). Don't offer five doors.
- **A real visual that shows the product or the result** — a genuine screenshot, a generated
  image, a short product shot. Never a fake UI hand-built from `<div>`s (the #1 AI tell — see
  [anti-slop.md](anti-slop.md)).
- **An early trust signal in or just under the hero** — a metric, a rating, or a recognizable
  result. Proof belongs at the top, where the first doubt forms (see §3), not only at the bottom.

A hero that merely looks pretty but doesn't *sell* is a failed hero. Polish below the fold can't
buy back a visitor who bounced at the top.

## 2. Reading flow and scan patterns

Visitors don't read landing pages; they scan them. Design the layout *to the scan*, not against it.

- **F-pattern** — for text-heavy sections (feature copy, long-form). The eye sweeps across the top,
  again a bit lower, then runs down the left edge. Front-load meaning: put the point at the start of
  each heading and the first words of each line; never bury the benefit on the right.
- **Z-pattern** — for sparse, visual screens (the hero, splash sections). The eye goes top-left →
  top-right → diagonally down → bottom-right. Map the load-bearing elements onto it: **logo
  top-left, primary nav/CTA top-right, headline first, conversion action at the bottom-right
  terminus.**

Either way: align the elements that carry the pitch to where the eye already goes. Fighting the
scan path wastes attention you can't get back.

## 3. Social proof — the engine of trust

Strangers don't trust your claims; they trust *other people's results*. Social proof is what turns
"sounds nice" into "this works." Two rules carry most of the weight.

**Rule 1 — results and transformations beat logos.** There's a hierarchy of persuasive strength:

1. **Quantified outcomes / transformations** (strongest) — "grew MRR 40% in two weeks", "cut
   onboarding from 3 days to 2 hours", before/after.
2. **Specific testimonials with a name, face, role, and a concrete result** — not "Great product!"
   but "We closed our first 10 enterprise deals using X — *Jane, Head of Sales, Acme*."
3. **Case studies / detailed stories** — depth for high-consideration buyers.
4. **Ratings & review counts** (4.8★ from 2,300 reviews), media mentions, certifications.
5. **Customer logos** (weakest alone) — they say "others use this," not "it worked." Useful as
   *reinforcement*, never as the only proof.

**Rule 2 — specificity is the proof.** Vague praise persuades no one; numbers do. "Increased
revenue" → "increased revenue 40% in two weeks." Real names, real photos, real figures (organic,
e.g. `47.2%`, not `99.99%` — see [anti-slop.md](anti-slop.md)). A precise claim feels true; a round
or generic one feels invented.

**Rule 3 — weave it through the whole journey, don't park it in the footer.** Doubt arises at
specific moments — at the price, at "is this for my use case," at sign-up. Put the matching proof
*there*: a results stat under the hero, a testimonial beside the relevant feature, a case-study
quote next to pricing, a rating near the final CTA. A single "Testimonials" graveyard at the bottom
is the spot fewest visitors reach. Proof works where the objection lives.

## 4. Conversion CTAs

- **One conversion goal per page.** Pick the single action the page exists to drive (trial, demo,
  signup, purchase). Competing primary CTAs split attention and lower conversion. Secondary paths
  are allowed but must look secondary.
- **Repeat the primary CTA at decision points** — after the hero, after the proof, after pricing,
  and at the foot. A motivated visitor should never have to scroll back up to act.
- **Intent-driven copy** (verb + outcome): "Start free trial", "Get my report", "Book a demo" — not
  "Submit", "Contact us", or "Learn more." Name what happens when they click.
- **Reduce friction at the ask.** Fewer fields, clear "what happens next", no surprise required
  account. State the cost-to-act honestly ("Free, no card required") — uncertainty kills clicks.
- **Every page/section ends with a next step.** Don't leave the visitor at a dead end; the bottom of
  the page is prime conversion real estate, not a place to trail off.

## 5. Page structure — the persuasion arc

A landing page is an argument with an order. A reliable arc (adapt, don't follow blindly):

1. **Hero** — the promise + primary CTA (§1).
2. **Proof band** — quick credibility right after the promise (logos/metrics/rating).
3. **Problem → solution** — name the pain in the visitor's words, then how you remove it.
4. **Benefits, not feature dumps** — each feature framed as the outcome it produces; pair with the
   relevant proof.
5. **Deeper social proof** — testimonials, a case study, transformation numbers.
6. **Handle objections** — pricing clarity, FAQ, guarantees/risk-reversal.
7. **Final CTA** — restate the core promise and ask once more, confidently.

Vary the layout families across these sections (see [anti-slop.md](anti-slop.md)) — don't ship eight
identical alternating image/text rows. And keep the page breathing: generous negative space reads as
confidence and premium; a cramped, wall-to-wall page reads subconsciously as cheap, regardless of
the copy.

## 6. Landing-specific anti-patterns

On top of the global [anti-slop.md](anti-slop.md) bans:

- **A hero that doesn't say what the product is.** Mood photography + a poetic slogan with no plain
  statement of the offer. Pretty and useless.
- **Too many CTAs / competing goals.** "Start trial" *and* "Book demo" *and* "Read docs" *and*
  "Join newsletter" all at equal weight — the visitor picks none.
- **Proof only in the footer**, or proof that's all logos and zero outcomes.
- **Vague, unquantified testimonials** ("Amazing tool, highly recommend!") — they read as filler.
- **Feature lists with no benefit framing** — specs the visitor has to translate into value
  themselves.
- **Buzzword soup** ("Seamlessly leverage world-class synergy") — say what it does (see
  [anti-slop.md](anti-slop.md)).
- **Burying the CTA** — making a convinced visitor hunt for how to act.
- **Crowding** — packing the page edge-to-edge to "fit more," which signals low-rent.

## 7. Memorable, once the basics hold (a launch page, never a dense tool)

Only after the hero, hierarchy, proof and CTA pass (§1–§6). Drama laid over broken hierarchy is just louder. Skip this
section for dashboards, admin panels and any internal tool.

- **The signature moment is a composition decision first** (one oversized type line, one asymmetric block, one real
  product shot that breaks the grid), an animation second. Pick one; the rest stays calm.
- **Type at scale:** display to body ratio of about 10:1 or more (a 120–180 px headline over 14–16 px text), tracking
  −0.02 to −0.05 em on large sizes, tight line height (~1.0–1.1). Check the display face covers the page language
  (Cyrillic, Tajik letters ҳ қ ӯ ғ ҷ ӣ: [i18n.md](i18n.md)).
- **Easing:** the browser defaults (`ease`, `ease-in`, `linear`) are the tell. Use named product curves from the
  motion module, for example `cubic-bezier(0.16, 1, 0.3, 1)` (expressive out), `cubic-bezier(0.25, 1, 0.5, 1)`
  (calm out), `cubic-bezier(0.87, 0, 0.13, 1)` (in-out for a big move).
- **Load choreography, in one breath:** structure 0–200 ms, headline 200–600 ms, subhead 400–800 ms, nav 600–900 ms,
  supporting content 800–1200 ms. Anything past ~1.2 s needs a reason; nothing blocks reading or the CTA.
- **Budget first:** decide the performance budget before the effects (LCP under 2.5 s, 60 fps, only `transform` and
  `opacity`, no parallax on text). Heavy costs, in order: WebGL, full-bleed video, scroll-hijack libraries, display
  fonts. Pure black and the purple-to-blue gradient are tells ([anti-slop.md](anti-slop.md)).
- **Reduced motion keeps the layout and drops the choreography:** the page must still look designed with every
  animation off ([motion.md](motion.md)).
- **Cursor tricks and scroll effects are opt-in,** never on a page whose job is to convert a hurried visitor.
