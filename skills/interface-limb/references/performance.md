# Performance as design — what speed feels like

Speed is part of the interface. A screen that drops frames while scrolling or jumps when images load reads as cheap
however it is styled.

## Budgets

- **Response:** visual feedback within 100 ms of any input; results under ~1 s feel immediate; past that show
  progress ([states.md](states.md)). The Doherty threshold (~400 ms) is where people stop waiting attentively.
- **Frames:** 60 fps (16 ms per frame) for scroll, drag and transitions; 120 on devices that have it.
- **Web loading:** Largest Contentful Paint ≤ 2.5 s, Interaction to Next Paint ≤ 200 ms, Cumulative Layout Shift
  ≤ 0.1 (Core Web Vitals, at the 75th percentile, on a mid-range phone on 4G).

## Habits that keep it

- **No layout shift:** reserve space for images (`aspect-ratio`, width/height), fonts with `font-display: swap` and a
  metric-matched fallback, skeletons the same size as content.
- **Animate only transform and opacity** ([motion.md](motion.md)); avoid shadows and blurs that animate every frame.
- **Long lists are virtualized** (`ListView.builder`, `FlatList`, virtual scrolling); images sized for their slot and
  cached.
- **Optimistic UI** for likely-success actions; prefetch the next likely screen.
- **Measure on the slow device** the product actually runs on (a cheap Android till, an old iPad), not the developer's
  laptop; Flutter in profile mode, the browser's performance panel with CPU throttling.
- **Startup:** show the shell and cached data first; refresh in place.
