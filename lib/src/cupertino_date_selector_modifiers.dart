import 'package:flutter/cupertino.dart';

import 'cupertino_date_selector_selection_mode.dart';

/// Optional cross-cutting behavior for [CupertinoDateSelector] and
/// [CupertinoDateSelectorWidget] without bloating every factory signature.
@immutable
class CupertinoDateSelectorModifiers {
  const CupertinoDateSelectorModifiers({
    this.selectionMode,
    this.enableHapticFeedback,
    this.locale,
    this.modalBarrierColor,
    this.useRootNavigator,
    this.monthLabelBuilder,
    this.semanticsLabel,
  });

  /// When non-null, overrides default [CupertinoDateSelectorSelectionMode.live].
  final CupertinoDateSelectorSelectionMode? selectionMode;

  /// Light haptic on each wheel selection change (items, wheels, timer).
  final bool? enableHapticFeedback;

  /// Locale for month names when using the default month label formatter.
  final Locale? locale;

  /// Passed to [showCupertinoModalPopup] when using [CupertinoDateSelector.show].
  final Color? modalBarrierColor;

  /// Passed to [showCupertinoModalPopup] when using [CupertinoDateSelector.show].
  final bool? useRootNavigator;

  /// Custom month name for month wheel (1–12). When null, [intl] is used.
  final String Function(int month, Locale locale)? monthLabelBuilder;

  /// Optional semantics label for the picker region.
  final String? semanticsLabel;
}
