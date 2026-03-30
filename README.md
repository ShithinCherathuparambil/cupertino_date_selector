# cupertino_date_selector

[![pub](https://img.shields.io/pub/v/cupertino_date_selector?label=pub&labelColor=545454&color=blue)](https://pub.dev/packages/cupertino_date_selector)
[![license](https://img.shields.io/static/v1?label=license&message=MIT&labelColor=545454&color=daa520)](https://github.com/ShithinCherathuparambil/cupertino_date_selector/blob/main/LICENSE)
[![platform](https://img.shields.io/static/v1?label=platform&message=android%20%7C%20ios%20%7C%20web%20%7C%20macos%20%7C%20windows%20%7C%20linux&labelColor=545454&color=blue)](https://github.com/ShithinCherathuparambil/cupertino_date_selector)

A customizable Cupertino-style selector package for Flutter: modal bottom sheets, inline pages, or wheel-only embedding.

## Table of contents

- [Installation](#installation)
- [API overview](#api-overview)
- [Picker modes](#picker-modes)
- [Callbacks & selection mode](#callbacks--selection-mode)
- [Modifiers](#modifiers)
- [Haptic feedback](#haptic-feedback)
- [Inline controller](#inline-controller-programmatic-jump)
- [Picker-only embedding](#picker-only-embedding)
- [Theming](#theming)
- [Modal-only options](#modal-only-options)
- [Testing this package](#testing-this-package)
- [Roadmap & possible extensions](#roadmap--possible-extensions)
- [Notes for app developers](#notes-for-app-developers)
- [Example app](#example-app)

## Installation

```yaml
dependencies:
  cupertino_date_selector: ^0.0.3
```

```bash
flutter pub get
```

```dart
import 'package:cupertino_date_selector/cupertino_date_selector.dart';
```

## API overview

| API | Use when |
|-----|----------|
| `CupertinoDateSelector.*(...).show(context)` | Standard iOS-style modal popup |
| `CupertinoDateSelectorWidget.*(...)` | Drop into a `Scaffold` / form (same chrome as modal: optional header + submit) |
| `CupertinoDateSelectorPickerBody` | You provide sheet chrome; only the wheels |
| `selector.buildPicker(context, value:, onChanged:)` | Same as picker body, imperative API |

Shared concepts:

- **Theme**: `CupertinoDateSelectorThemeData` on constructors.
- **Modifiers**: `CupertinoDateSelectorModifiers` on every `CupertinoDateSelector.*` and `CupertinoDateSelectorWidget.*` factory (optional, defaults are sensible).
- **Haptics**: Wheel steps use [`HapticFeedback.selectionClick`](https://api.flutter.dev/flutter/services/HapticFeedback/selectionClick.html) by default on mobile/desktop; see [Haptic feedback](#haptic-feedback).
- **Submit button**: Shown only if `onSubmit` is non-null.

## Picker modes

Each mode exists on **both** `CupertinoDateSelector` and `CupertinoDateSelectorWidget`:

| Constructor | Value type | Notes |
|-------------|------------|--------|
| `items` | `int` (index) | Custom `List<Widget>` rows |
| `date` | `DateTime` | `CupertinoDatePicker` date mode |
| `time` | `DateTime` | `minuteInterval`, `use24hFormat` |
| `dateTime` | `DateTime` | Date + time; min/max + minute interval |
| `year` | `DateTime` | Year only (`DateTime(year)`) |
| `month` | `DateTime` | Month only (`DateTime(1, month)`); localized month names |
| `monthYear` | `DateTime` | Month + year; min/max normalized to avoid picker assertions |
| `duration` | `Duration` | `CupertinoTimerPicker` |

Modal usage:

```dart
await CupertinoDateSelector.monthYear(
  initialDateTime: DateTime.now(),
  minDateTime: DateTime(2023, 1),
  maxDateTime: DateTime(2028, 12),
  onChange: (d) { /* live updates */ },
  onSubmit: (d) { /* confirm */ },
).show(context);
```

Inline usage:

```dart
CupertinoDateSelectorWidget.monthYear(
  initialDateTime: DateTime.now(),
  minDateTime: DateTime(2023, 1),
  maxDateTime: DateTime(2028, 12),
  onChanged: (d) { /* prefer widget naming */ },
  onSubmit: (d) { },
)
```

## Callbacks & selection mode

- **`onChange` / `onChanged`**: Selection updates (behavior depends on [selection mode](#selection-mode)).
- **`onSubmit`**: User tapped the submit control; also used to **pop** the modal with the current value when `closeOnSubmit` is true.
- **`onDismiss`**: **Modal only** — after the route completes (including barrier dismiss).

### Selection mode

`modifiers: CupertinoDateSelectorModifiers(selectionMode: …)`

- **`CupertinoDateSelectorSelectionMode.live`** (default): fire `onChange` / `onChanged` on every wheel movement.
- **`CupertinoDateSelectorSelectionMode.commitOnSubmit`**: no change callbacks while scrolling; on submit, **`onSubmit`** runs and **`onChange` / `onChanged`** runs **once** with the final value.

## Modifiers

`CupertinoDateSelectorModifiers` groups cross-cutting options (avoids huge parameter lists):

| Field | Applies to | Purpose |
|-------|------------|---------|
| `selectionMode` | Modal + widget | `live` vs `commitOnSubmit` |
| `enableHapticFeedback` | Modal + widget | `HapticFeedback.selectionClick` on wheel changes; omit for **on** (default) |
| `locale` | Month wheel | Base locale when formatting month names |
| `modalBarrierColor` | Modal `show` only | `showCupertinoModalPopup` barrier |
| `useRootNavigator` | Modal `show` only | Passed through to `showCupertinoModalPopup` |
| `monthLabelBuilder` | Month wheel | `(month 1–12, Locale) => String`; overrides `intl` |
| `semanticsLabel` | Picker region | `Semantics` wrapper for accessibility |

You can also pass **`enableHapticFeedback`** on any factory (`bool?`). **Precedence:** if the factory argument is non-null, it wins; else **`modifiers.enableHapticFeedback`** if non-null; else **haptics are on**.

Example:

```dart
CupertinoDateSelectorWidget.date(
  initialDateTime: DateTime.now(),
  onSubmit: (d) {},
  modifiers: const CupertinoDateSelectorModifiers(
    semanticsLabel: 'Choose date',
  ),
);
```

Disable explicitly:

```dart
CupertinoDateSelector.date(
  enableHapticFeedback: false,
  onSubmit: (d) {},
);
```

## Haptic feedback

When haptics are enabled, each wheel selection change calls Flutter’s **`HapticFeedback.selectionClick`**.

| Platform | Behavior |
|----------|----------|
| **iOS** | Supported where the device provides haptic feedback. |
| **Android** | Supported via the platform vibrator. Add **`<uses-permission android:name="android.permission.VIBRATE" />`** to your app’s `AndroidManifest.xml` so vibration is allowed (recommended for production apps). |
| **Web** | The package **does not** invoke haptics (no vibration API in the browser). |
| **Desktop** (macOS, Windows, Linux) | Flutter forwards to the platform; may be a no-op depending on hardware and OS settings. |

To turn haptics off globally for one picker, use `enableHapticFeedback: false` on the factory or `CupertinoDateSelectorModifiers(enableHapticFeedback: false)`.

## Inline controller (programmatic jump)

`CupertinoDateSelectorController` mirrors the value and bumps **`syncGeneration`** on **`jumpTo`**, so the inline widget rebuilds the wheel with a new initial position.

```dart
final c = CupertinoDateSelectorController();

CupertinoDateSelectorWidget.year(
  initialDateTime: DateTime(2020),
  minDateTime: DateTime(2010),
  maxDateTime: DateTime(2030),
  controller: c,
  onSubmit: (d) {},
);

c.jumpTo(DateTime(2025));
```

## Picker-only embedding

Use your own drag handle, title, and buttons; only the wheels come from the package:

```dart
CupertinoDateSelectorPickerBody(
  selector: CupertinoDateSelector.items(
    items: const [Text('S'), Text('M'), Text('L')],
    selectedItemIndex: index,
  ),
  value: index,
  onChanged: (v) => setState(() => index = v as int),
);
```

Equivalent:

```dart
selector.buildPicker(context, value: index, onChanged: (v) => …);
```

Month names use **`intl`** and `Localizations` / `modifiers.locale`, unless you set **`monthLabelBuilder`**.

## Theming

`CupertinoDateSelectorThemeData` includes:

- Container: `backgroundColor`, `topCornerRadius`, `dividerColor`
- Header: `headerPadding`, `headerTextStyle`, `closeIcon`, `closeIconColor`
- Items in custom wheels (year / month): `itemTextStyle`, **`selectedWheelItemTextStyle`** (center row)
- Submit: `buttonPadding`, `buttonColor`, `buttonTextStyle`, `defaultButtonText`, `buttonDecoration`

```dart
theme: const CupertinoDateSelectorThemeData(
  defaultButtonText: 'Confirm',
  selectedWheelItemTextStyle: TextStyle(fontWeight: FontWeight.w600),
),
```

## Modal-only options

On **`CupertinoDateSelector`** factories (not on `CupertinoDateSelectorWidget`):

- `dismissible`, `closeOnSubmit`, `onDismiss`
- `layoutDirection` for the modal subtree
- Barrier / navigator via **modifiers**: `modalBarrierColor`, `useRootNavigator`

The modal route uses an internal **`StatefulBuilder`** so the submit action always sees the **latest** wheel value.

## Testing this package

From the package root:

```bash
flutter test
flutter analyze
```

Automated coverage includes:

- All picker **constructor types** (`items`, `date`, `time`, `dateTime`, `year`, `month`, `monthYear`, `duration`)
- **Widget smoke**: each `CupertinoDateSelectorWidget.*` mode builds
- **Submit hidden** when `onSubmit` is null
- **`commitOnSubmit`** vs **live** `onChange` behavior
- **`CupertinoDateSelectorController.jumpTo`**
- **`CupertinoDateSelectorPickerBody`** and **`buildPicker`**
- **Modifiers** merged on selector; **theme** `copyWith`
- **`monthLabelBuilder`**, **`semanticsLabel`**
- **Haptic default** (`enableHapticFeedback` on when unset)

## Roadmap & possible extensions

These items are **not guaranteed** to ship as-is; they sketch directions that would complement the current API (`CupertinoDateSelector`, `CupertinoDateSelectorWidget`, picker-only embedding, theme, modifiers, inline controller).

| Area | Idea |
|------|------|
| **Forms** | `FormField<DateTime>` / `FormField<Duration>` (and similar for custom `items`) with validation and error display wired to Flutter’s form system. |
| **Field preset** | A tappable row that shows a formatted value, opens the modal (or inline flow), and supports label, hint, error text, and disabled state—less boilerplate in settings and forms. |
| **Modal control** | Optional API to read or update the pending value while a modal is open, or to dismiss programmatically (inline already has `CupertinoDateSelectorController` for `jumpTo`). |
| **Large screens** | On tablet or desktop, optional centered dialog or anchored popover instead of a full-width bottom sheet, while keeping Cupertino styling. |
| **Accessibility** | Stronger semantics: announce committed values, clearer structure for combined date+time wheels, predictable focus order on web and desktop. |
| **Power APIs** | Hooks for per-column labels or styling in date-like modes, or filters such as skipping weekends or disabling specific dates (booking-style UIs). |
| **Quality & docs** | Golden tests for major modes and themes; short cookbook patterns (e.g. replacing Material `showDatePicker` / `showTimePicker` in a Cupertino-heavy app). |

Contributions or API proposals for any of the above are welcome via issues or pull requests on the repository.

## Notes for app developers

- If you import **`intl`** in the same library as Flutter’s **`TextDirection`**, use  
  `import 'package:intl/intl.dart' hide TextDirection;`  
  (`intl` defines its own `TextDirection`, which conflicts with `dart:ui`).
- **`publish_to`** must not be set in this package’s `pubspec` when publishing (only the example uses `publish_to: 'none'`).
- **Android haptics:** for wheel vibration, include **`android.permission.VIBRATE`** in your app manifest (see [Haptic feedback](#haptic-feedback)).

## Example app

- **`example/lib/main.dart`** — buttons for every modal and inline screen.
- **`example/lib/recipes_screen.dart`** — picker-only layout, modifiers, controller.

Run:

```bash
cd example && flutter run
```
