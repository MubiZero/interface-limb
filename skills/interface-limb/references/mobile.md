# Mobile reference — Flutter / React Native

Concrete ways to express the interface-limb principles on mobile, plus the
mobile-only tells (haptics, keyboard handling, permission priming). Adapt to the
project's actual stack.

## Design tokens / theme

**Flutter** — centralize in `ThemeData` + a token class so changes propagate:

```dart
class Space { static const s1 = 4.0, s2 = 8.0, s3 = 12.0, s4 = 16.0, s6 = 24.0, s8 = 32.0; }

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
  // light-theme elevation: soft shadows
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  // depth via lighter surfaces, not shadows — see below
);
```

**React Native** — a tokens module (`spacing`, `colors`, `radius`) imported everywhere;
drive component styles from it, never hard-code magic numbers.

## Dark theme depth

Shadows barely render on dark backgrounds. Make elevated surfaces *lighter* than what's
behind them so they appear to float. Concrete values:

- **Base surface `#121212`**, not pure black. Elevated surfaces get lighter via a white overlay
  scaled to elevation (~5% at 1dp → ~16% at 24dp).
- **Text opacity tiers: 87% / 60% / 38%** (primary / secondary / disabled) over near-white —
  never solid `#fff` body text.
- **Flutter:** Material 3 already tints elevated surfaces with `surfaceTint`; lean into it
  (`Card` elevation raises the tint). Keep elevation shadows subtle, let the lighter tint
  do the work. Set base `scaffoldBackgroundColor: Color(0xFF121212)`.
- **RN:** set card `backgroundColor` a step lighter than the screen background; minimize
  `elevation`/`shadow*` props in dark mode.
- Use faint borders and **desaturate brand colors** (shift to lighter, less-saturated tones) —
  saturated hues vibrate on dark.

## Touch targets

Every tappable element meets the platform minimum, even if its visual is smaller — pad the hit
area, don't shrink the target:
- **iOS: 44 × 44 pt.** Flutter on iOS / RN — ensure `GestureDetector`/`Pressable` wraps a region
  ≥44pt; wrap small icons in padding.
- **Android: 48 × 48 dp** with **8 dp** spacing between targets. Flutter `IconButton` defaults to a
  48dp target — keep it; don't override to something smaller. Use `MaterialTapTargetSize`.

## Typography

- One sans-serif family; scale by weight/size (display/title/body/caption).
- Tighten letter-spacing slightly on large text (Flutter `TextStyle(letterSpacing: -0.3)`
  on headings), tune line height (`height: 1.4–1.5` for body).
- Match icon size to text: Flutter `Icon(size: 20)` next to 16sp text, vertically centered
  in a `Row(crossAxisAlignment: CrossAxisAlignment.center)`.

## Interaction states + press feedback

Every tappable element should visibly respond. The signature cue is a slight scale-down
on press.

**Flutter** — wrap in a scale-on-press, and use stateful colors:

```dart
// Press feedback via AnimatedScale
GestureDetector(
  onTapDown: (_) => setState(() => _pressed = true),
  onTapUp:   (_) => setState(() => _pressed = false),
  onTapCancel: () => setState(() => _pressed = false),
  child: AnimatedScale(
    scale: _pressed ? 0.97 : 1.0,
    duration: const Duration(milliseconds: 120),
    curve: Curves.easeOut,
    child: /* button */,
  ),
)
```
Use `WidgetStateProperty` (formerly `MaterialStateProperty`) for hover/pressed/disabled
colors on Material buttons so states are declarative.

**React Native** — `Pressable` gives per-state styling for free:

```jsx
<Pressable
  onPress={onPress}
  style={({ pressed }) => [
    styles.btn,
    pressed && { transform: [{ scale: 0.97 }], opacity: 0.95 },
  ]}
  android_ripple={{ color: 'rgba(255,255,255,0.2)' }}
>
  {loading ? <ActivityIndicator /> : <Text style={styles.btnText}>{label}</Text>}
</Pressable>
```
Keep the loading indicator inside the button so layout doesn't jump.

## Platform chrome and native idiom (iOS HIG)

A Flutter or RN app on iPhone is judged against native apps. What changes code (Apple HIG; Flutter `SafeArea`,
`MediaQuery.padding`):

- **Safe areas:** nothing interactive under the status bar, Dynamic Island, or home indicator (bottom inset ≈ 34 pt).
  Only backgrounds and decoration bleed to the edges. Test an iPhone SE (375 pt wide) and a Dynamic Island model.
- **Chrome sizes to budget for:** nav bar 44 pt (≈ 96 pt with a large title), tab bar 49 pt plus the home inset, status
  bar 44–54 pt on Dynamic Island devices. Content margins 16–20 pt; rows and targets ≥ 44 pt.
- **System gestures stay the system's:** never override the edge swipe-back, swipe-down to dismiss a modal, or
  pull-to-refresh where the platform uses them. A custom horizontal swipe on a row must not start at the left edge.
- **Navigation:** 2–5 tabs, no hamburger drawer as the main nav on iOS; the back button carries the previous screen's
  title; destructive actions in red, and irreversible ones confirmed ([interaction.md](interaction.md)).
- **Type and color follow the system:** text styles that scale with Dynamic Type (test the largest step), body 17 pt,
  nothing under 11 pt, left-aligned never justified, lines 35–50 characters on a phone; semantic colors that flip
  with Dark Mode instead of hex literals, red/green/blue keep their system meaning (destructive/success/tint).
- **Icons:** SF Symbols (or one outline set matched to them) for in-app icons; the app icon has no text and ships
  light, dark and tinted variants on iOS 18+.
- **Android counterpart:** 48 dp targets, system back (predictive back) respected, edge-to-edge with insets handled,
  Material motion tokens ([standards.md](standards.md)).
- **Real device before done:** safe areas, haptics, keyboard and gestures only show on hardware; say so when not checked.

## Haptics — physical trust

A light vibration on meaningful events (toggle, successful submit, selection change) makes
a digital action feel real. Match weight to importance; don't buzz on everything.

**Flutter** (`HapticFeedback` from `services.dart`):
```dart
HapticFeedback.selectionClick();   // toggles, pickers
HapticFeedback.lightImpact();      // small confirmations
HapticFeedback.mediumImpact();     // notable actions
// success/error flows: pair with a visual state change
```

**React Native** (`expo-haptics` or `react-native-haptic-feedback`):
```js
import * as Haptics from 'expo-haptics';
Haptics.selectionAsync();                                   // selection change
Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success); // success
```

## Keyboard handling — a flagship tell

When the keyboard appears, inputs must slide into view and never be covered; the layout
should adapt smoothly.

**Flutter:**
- Wrap forms in a `SingleChildScrollView` so focused fields can scroll above the keyboard.
- `Scaffold(resizeToAvoidBottomInset: true)` (default) lets the body shrink for the keyboard.
- Use `MediaQuery.of(context).viewInsets.bottom` to pad above the keyboard when needed.
- `Scrollable.ensureVisible` on focus to bring a field into view with a gentle animation.

**React Native:**
- Wrap screens in `KeyboardAvoidingView` (`behavior="padding"` on iOS, often `height`/none
  on Android).
- Use a keyboard-aware scroll view (e.g. `react-native-keyboard-aware-scroll-view`) so the
  focused input animates above the keyboard.
- Add `keyboardShouldPersistTaps="handled"` so taps on buttons work while the keyboard is up.

## Motion

- Pick duration by scale: micro-feedback **100–150ms**, standard transitions **200–300ms**,
  large/screen **400–500ms**; never exceed ~500ms for routine motion.
- **Ease-out for entering, ease-in for exiting**; make exits ~30% shorter. Flutter
  `Curves.easeOutCubic` (enter) / `Curves.easeInCubic` (exit), or the M3
  `Easing.emphasizedDecelerate` / `emphasizedAccelerate`. RN: Reanimated easing on
  `transform`/`opacity` only.
- Screen transitions: gentle fade / shared-axis / natural scale, not flashy slides.
- Feedback must *begin* within ~100ms to feel instantaneous.
- Honor reduced motion: Flutter `MediaQuery.of(context).disableAnimations`;
  RN `AccessibilityInfo.isReduceMotionEnabled()` — replace big motion with a quick fade, keep
  essential motion.

## Shimmer skeletons (not spinners)

While loading, show a shimmering skeleton mirroring the real layout.
- **Flutter:** `shimmer` package, or an `AnimatedBuilder` sweeping a `LinearGradient` across
  placeholder boxes.
- **RN:** `react-content-loader` / `moti` skeletons, or an animated gradient overlay.
Mirror the actual content boxes so the swap-in is seamless.

## Empty states

Not "No data." Explain the area and give a first action:
- icon/illustration + short title + one line of guidance + a primary button.
- Build it as a reusable widget/component you drop into any empty list.

## Permission priming — never ask cold

Before triggering a system permission dialog (camera, notifications, location), show a
contextual screen explaining *why* and what the user gains. Only then call the OS prompt.
This raises grant rates and respects the user.

```
[contextual pre-prompt screen: icon + "Enable notifications" + benefit + "Allow" / "Not now"]
        → user taps Allow → THEN request the OS permission
```
- **Flutter:** `permission_handler` — gate `request()` behind your own priming screen.
- **RN:** `react-native-permissions` / Expo permissions — same pattern: explain, then request.
- If denied, degrade gracefully and offer a path to Settings rather than nagging.

## Systematize

- States (default/pressed/disabled/loading) → component variants / a shared `AppButton`,
  `AppTextField`, etc., so every screen inherits them.
- Tokens → `ThemeData` / tokens module; one source of truth for color/space/radius.
- Empty/loading/error → first-class states of your data widgets, with shimmer + empty
  components built in.
