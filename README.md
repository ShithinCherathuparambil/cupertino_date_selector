# cupertino_date_selector

A customizable Cupertino-style selector package for Flutter.

It supports both:
- **Bottom sheet selector** via `CupertinoDateSelector.*(...).show(context)`
- **Inline widget selector** via `CupertinoDateSelectorWidget.*(...)`

## Features

- Multiple picker modes: `items`, `date`, `time`, `dateTime`, `year`, `month`, `monthYear`, `duration`
- Modal and inline APIs
- Typed callbacks for changed/submitted values
- Theme configuration through `CupertinoDateSelectorThemeData`
- Custom header and custom submit button content
- RTL/LTR support and safe-area handling
- Optional `CupertinoDateSelectorModifiers` (haptics, `commitOnSubmit`, modal barrier, locale)
- `CupertinoDateSelectorPickerBody` for custom chrome around wheels only
- `CupertinoDateSelectorController` + `jumpTo` for programmatic selection (inline widget)

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  cupertino_date_selector: ^0.0.3
```

Then run:

```bash
flutter pub get
```

## Import

```dart
import 'package:cupertino_date_selector/cupertino_date_selector.dart';
```

## Quick start

### 1) Bottom sheet picker

```dart
await CupertinoDateSelector.monthYear(
  initialDateTime: DateTime.now(),
  minDateTime: DateTime(2023, 1),
  maxDateTime: DateTime(2028, 12),
  onChange: (DateTime value) {
    debugPrint('Changed: $value');
  },
  onSubmit: (DateTime value) {
    debugPrint('Submitted: $value');
  },
).show(context);
```

### 2) Inline widget picker

```dart
CupertinoDateSelectorWidget.monthYear(
  initialDateTime: DateTime.now(),
  minDateTime: DateTime(2023, 1),
  maxDateTime: DateTime(2028, 12),
  onChanged: (DateTime value) {
    debugPrint('Changed: $value');
  },
  onSubmit: (DateTime value) {
    debugPrint('Submitted: $value');
  },
)
```

## Picker modes

Use these constructors in both APIs:

- `items`
- `date`
- `time`
- `dateTime`
- `year`
- `month`
- `monthYear`
- `duration`

Examples:

- Bottom sheet: `CupertinoDateSelector.date(...).show(context)`
- Inline widget: `CupertinoDateSelectorWidget.date(...)`

## Callbacks

- `onChange` / `onChanged`: Fires when the wheel value changes (see selection mode below)
- `onSubmit`: Fires when submit button is tapped
- `onDismiss`: Bottom sheet only; fires when modal is dismissed

Note: submit button is shown only when `onSubmit` is provided.

### Selection mode

Pass `modifiers: CupertinoDateSelectorModifiers(selectionMode: …)`:

- `CupertinoDateSelectorSelectionMode.live` (default): `onChange` / `onChanged` on every tick.
- `CupertinoDateSelectorSelectionMode.commitOnSubmit`: no change callbacks while scrolling;
  on submit, `onSubmit` runs and `onChange` / `onChanged` runs once with the final value.

## Modifiers, picker-only, controller

```dart
// Custom sheet: only the wheels
CupertinoDateSelectorPickerBody(
  selector: CupertinoDateSelector.items(
    items: const [Text('S'), Text('M'), Text('L')],
    selectedItemIndex: 0,
  ),
  value: index,
  onChanged: (v) => setState(() => index = v as int),
);

// Programmatic year jumps (inline widget)
final c = CupertinoDateSelectorController();
CupertinoDateSelectorWidget.year(
  initialDateTime: DateTime(2020),
  minDateTime: DateTime(2010),
  maxDateTime: DateTime(2030),
  controller: c,
  onSubmit: (d) {},
);
// … later
c.jumpTo(DateTime(2025));
```

Month names use `intl` and `Localizations` / `modifiers.locale`. Override with
`modifiers: CupertinoDateSelectorModifiers(monthLabelBuilder: (m, loc) => '…')`.

## Theming

Use `CupertinoDateSelectorThemeData` to customize:
- Background and divider colors
- Item/button text styles
- Header/button paddings
- Corner radius and button decoration

```dart
theme: const CupertinoDateSelectorThemeData(
  defaultButtonText: 'Confirm',
)
```

## API notes

- `CupertinoDateSelector` is intended for modal presentation (`show(context)`).
- `CupertinoDateSelectorWidget` is intended for embedding directly in a screen.
- Modal-only options (like `dismissible`, `closeOnSubmit`, `onDismiss`) are available on `CupertinoDateSelector`.

## Example app

See `example/lib/main.dart` for all modes. `example/lib/recipes_screen.dart` shows
picker-only layout, modifiers, and controller usage.
