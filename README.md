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

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  cupertino_date_selector: ^0.0.2
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

- `onChange` / `onChanged`: Fires when wheel value changes
- `onSubmit`: Fires when submit button is tapped
- `onDismiss`: Bottom sheet only; fires when modal is dismissed

Note: submit button is shown only when `onSubmit` is provided.

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

A complete demo is available in `example/lib/main.dart` covering all picker modes for both modal and inline widget usage.
