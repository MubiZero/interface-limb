# Libraries — borrow the behavior, own the look

When the model builds a toast, a drawer or a command menu from scratch it gets the default look and
none of the behavior: toasts pile up or vanish before they are read, the drawer does not drag, the
command menu breaks on the keyboard. Libraries are the cheapest way to get someone else's care for
the hard parts. Use them for behavior; make the look yours.

## Three kinds (web)

| Kind | Examples | Use for |
|---|---|---|
| **Foundations** — behavior and accessibility, you style | shadcn/ui, Base UI, Radix | Most of the app: buttons, inputs, dialogs, menus, tabs, popovers |
| **Specialists** — one component done very well | Sonner (toasts), Vaul (drawers), cmdk (command menu), NumberFlow (animated numbers) | The details people notice only when missing |
| **Designed components** — finished styled pieces to copy | Magic UI, Aceternity, Rare UI, Beautiful UI (AI-product states: streaming, approvals, diffs), 21st.dev | Marketing moments, AI-product surfaces |

- **Default shadcn is itself an AI look** (same radius, same gray, same font). Start from it, then
  change radius, color and type to the product's tokens — those three carry most of the personality.
  Copy-in libraries put the code in your repo, so it can be changed fully.
- **One standout moment per page.** One animated hero or interactive background makes a page feel
  designed; ten make the next AI look where everything glows and nothing stands out.
- **Name the library in the instruction** ("shadcn for base components, Sonner for toasts"), install
  it through its CLI or registry so the code is local and readable.

## Flutter

Flutter's Material 3 widgets are the foundation layer; wrap them once in the product's kit with its
tokens instead of restyling them per screen.

- **Toasts / messages:** one app-level messenger (`ScaffoldMessenger` / `SnackBar` behind a single
  `showInfo` / `showError` helper) so messages queue instead of stacking, last long enough to read,
  and look the same everywhere.
- **Bottom sheets / drawers:** `showModalBottomSheet` with `showDragHandle`, `isScrollControlled`,
  and `DraggableScrollableSheet` when it should be draggable to heights; one `showAppSheet` helper.
- **Search / command:** `SearchAnchor` / `SearchBar` for search-and-jump; give it keyboard shortcuts on
  desktop.
- **Animated numbers:** `AnimatedSwitcher` or `TweenAnimationBuilder` with tabular figures, so a total
  ticks instead of jumping and doesn't jiggle the layout.
- **Dialogs:** one `confirm` helper and one dialog shell with the action layout; never 100 hand-built
  `AlertDialog`s.

Check pub.dev for maintained packages before adding one, and prefer the platform widget wrapped in
your kit over a dependency for something small.

## React Native

Use a maintained bottom-sheet library (e.g. @gorhom/bottom-sheet) rather than a hand-made modal with a
drag handle, the platform's own date/time pickers, and one toast helper for the whole app.

## Rule of thumb

Before building an interactive component yourself, ask: does a library or the platform already solve
its behavior (stacking, dragging, keyboard, focus, accessibility)? If yes, use it and spend the time
on making it look like the product.
