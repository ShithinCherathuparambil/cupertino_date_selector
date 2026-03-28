## 0.0.3

* Added `CupertinoDateSelectorModifiers` (selection mode, haptics, locale, modal
  barrier color, `useRootNavigator`, custom month labels, semantics).
* Added `CupertinoDateSelectorSelectionMode` (`live` vs `commitOnSubmit`).
* Added `CupertinoDateSelectorController` with `jumpTo` for programmatic wheel sync.
* Added `CupertinoDateSelectorPickerBody` for wheel-only embedding in custom UI.
* Localized month wheel labels via `intl` (optional `monthLabelBuilder` override).
* Added `CupertinoDateSelectorThemeData.selectedWheelItemTextStyle` for year/month wheels.
* Modal `show` uses `StatefulBuilder` so submit uses the latest value; supports
  barrier color and `useRootNavigator` via modifiers.
* Pubspec `topics`; example Recipes screen; widget tests.

## 0.0.2

* Added `CupertinoDateSelectorWidget` inline widget constructors for all picker modes.
* Added `onChanged` support for widget APIs and improved submit-button visibility behavior.
* Fixed date boundary normalization for date/monthYear pickers to avoid Cupertino assertions.
* Updated README and pubspec metadata for improved pub.dev package scoring.

## 0.0.1

* Rebuilt package as a Cupertino-first standalone selector library.
* Added `CupertinoDateSelector` with constructors for `items`, `date`, `time`, `dateTime`,
  `year`, `monthYear`, and `duration`.
* Added `CupertinoDateSelectorThemeData` for full visual customization.
* Added updated README docs with usage examples.
