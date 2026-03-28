/// Controls when [CupertinoDateSelector.onChange] / widget [onChanged] fire.
enum CupertinoDateSelectorSelectionMode {
  /// Notify on every wheel change while the user scrolls.
  live,

  /// Suppress change callbacks while scrolling; on submit, fire [onSubmit]
  /// and also [onChange] / [onChanged] once with the committed value.
  commitOnSubmit,
}
