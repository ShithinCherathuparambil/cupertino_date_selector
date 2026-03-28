import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' hide TextDirection;

import 'cupertino_date_selector_controller.dart';
import 'cupertino_date_selector_modifiers.dart';
import 'cupertino_date_selector_selection_mode.dart';
import 'cupertino_date_selector_theme.dart';

/// Builder used to render a custom selector header.
typedef SelectorHeaderBuilder =
    Widget Function(BuildContext context, VoidCallback close);

/// Supported picker modes for [CupertinoDateSelector].
enum CupertinoDateSelectorType {
  items,
  date,
  time,
  dateTime,
  year,
  month,
  monthYear,
  duration,
}

/// Cupertino-style modal selector: call [show] to present a bottom sheet.
///
/// For inline UI or custom chrome, use [CupertinoDateSelectorWidget] or
/// [CupertinoDateSelectorPickerBody].
class CupertinoDateSelector {
  CupertinoDateSelector._({
    required this.type,
    required this.theme,
    this.headerBuilder,
    this.onSubmit,
    this.onChange,
    this.onDismiss,
    this.dismissible = true,
    this.closeOnSubmit = true,
    this.height = 320,
    this.itemExtent = 36,
    this.selectionOverlay,
    this.layoutDirection,
    this.useSafeArea = true,
    this.showSubmitButton = true,
    this.buttonContent,
    this.buttonAlignment = MainAxisAlignment.center,
    this.submitButtonDecoration,
    this.initialDateTime,
    this.minDateTime,
    this.maxDateTime,
    this.minuteInterval = 1,
    this.use24hFormat = false,
    this.initialDuration = Duration.zero,
    this.timerMode = CupertinoTimerPickerMode.hm,
    this.timerSecondInterval = 1,
    this.items = const <Widget>[],
    this.selectedItemIndex = 0,
    this.dateOrder,
    this.selectionMode = CupertinoDateSelectorSelectionMode.live,
    this.enableHapticFeedback = false,
    this.locale,
    this.modalBarrierColor,
    this.useRootNavigator = false,
    this.monthLabelBuilder,
    this.semanticsLabel,
  }) : assert(itemExtent > 0),
       assert(minuteInterval > 0),
       assert(timerSecondInterval > 0);

  /// Creates a modal wheel picker for a custom list of [items].
  factory CupertinoDateSelector.items({
    required List<Widget> items,
    int selectedItemIndex = 0,
    ValueChanged<int>? onChange,
    ValueChanged<int>? onSubmit,
    ValueChanged<int>? onDismiss,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    bool dismissible = true,
    bool closeOnSubmit = true,
    double height = 320,
    double itemExtent = 36,
    Widget? selectionOverlay,
    TextDirection? layoutDirection,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
  }) {
    return CupertinoDateSelector._(
      type: CupertinoDateSelectorType.items,
      items: items,
      selectedItemIndex: selectedItemIndex,
      onChange: onChange == null ? null : (value) => onChange(value as int),
      onSubmit: onSubmit == null ? null : (value) => onSubmit(value as int),
      onDismiss: onDismiss == null ? null : (value) => onDismiss(value as int),
      theme: theme,
      headerBuilder: headerBuilder,
      dismissible: dismissible,
      closeOnSubmit: closeOnSubmit,
      height: height,
      itemExtent: itemExtent,
      selectionOverlay: selectionOverlay,
      layoutDirection: layoutDirection,
      useSafeArea: useSafeArea,
      showSubmitButton: showSubmitButton,
      buttonContent: buttonContent,
      buttonAlignment: buttonAlignment,
      submitButtonDecoration: submitButtonDecoration,
      selectionMode:
          modifiers.selectionMode ?? CupertinoDateSelectorSelectionMode.live,
      enableHapticFeedback: modifiers.enableHapticFeedback ?? false,
      locale: modifiers.locale,
      modalBarrierColor: modifiers.modalBarrierColor,
      useRootNavigator: modifiers.useRootNavigator ?? false,
      monthLabelBuilder: modifiers.monthLabelBuilder,
      semanticsLabel: modifiers.semanticsLabel,
    );
  }

  /// Creates a modal date picker.
  factory CupertinoDateSelector.date({
    DateTime? initialDateTime,
    DateTime? minDateTime,
    DateTime? maxDateTime,
    DatePickerDateOrder? dateOrder,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    ValueChanged<DateTime>? onDismiss,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    bool dismissible = true,
    bool closeOnSubmit = true,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
  }) {
    return CupertinoDateSelector._(
      type: CupertinoDateSelectorType.date,
      initialDateTime: initialDateTime,
      minDateTime: minDateTime,
      maxDateTime: maxDateTime,
      dateOrder: dateOrder,
      onChange: onChange == null
          ? null
          : (value) => onChange(value as DateTime),
      onSubmit: onSubmit == null
          ? null
          : (value) => onSubmit(value as DateTime),
      onDismiss: onDismiss == null
          ? null
          : (value) => onDismiss(value as DateTime),
      theme: theme,
      headerBuilder: headerBuilder,
      dismissible: dismissible,
      closeOnSubmit: closeOnSubmit,
      height: height,
      useSafeArea: useSafeArea,
      showSubmitButton: showSubmitButton,
      buttonContent: buttonContent,
      buttonAlignment: buttonAlignment,
      submitButtonDecoration: submitButtonDecoration,
      selectionMode:
          modifiers.selectionMode ?? CupertinoDateSelectorSelectionMode.live,
      enableHapticFeedback: modifiers.enableHapticFeedback ?? false,
      locale: modifiers.locale,
      modalBarrierColor: modifiers.modalBarrierColor,
      useRootNavigator: modifiers.useRootNavigator ?? false,
      monthLabelBuilder: modifiers.monthLabelBuilder,
      semanticsLabel: modifiers.semanticsLabel,
    );
  }

  /// Creates a modal time picker.
  factory CupertinoDateSelector.time({
    DateTime? initialDateTime,
    int minuteInterval = 1,
    bool use24hFormat = false,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    ValueChanged<DateTime>? onDismiss,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    bool dismissible = true,
    bool closeOnSubmit = true,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
  }) {
    return CupertinoDateSelector._(
      type: CupertinoDateSelectorType.time,
      initialDateTime: initialDateTime,
      minuteInterval: minuteInterval,
      use24hFormat: use24hFormat,
      onChange: onChange == null
          ? null
          : (value) => onChange(value as DateTime),
      onSubmit: onSubmit == null
          ? null
          : (value) => onSubmit(value as DateTime),
      onDismiss: onDismiss == null
          ? null
          : (value) => onDismiss(value as DateTime),
      theme: theme,
      headerBuilder: headerBuilder,
      dismissible: dismissible,
      closeOnSubmit: closeOnSubmit,
      height: height,
      useSafeArea: useSafeArea,
      showSubmitButton: showSubmitButton,
      buttonContent: buttonContent,
      buttonAlignment: buttonAlignment,
      submitButtonDecoration: submitButtonDecoration,
      selectionMode:
          modifiers.selectionMode ?? CupertinoDateSelectorSelectionMode.live,
      enableHapticFeedback: modifiers.enableHapticFeedback ?? false,
      locale: modifiers.locale,
      modalBarrierColor: modifiers.modalBarrierColor,
      useRootNavigator: modifiers.useRootNavigator ?? false,
      monthLabelBuilder: modifiers.monthLabelBuilder,
      semanticsLabel: modifiers.semanticsLabel,
    );
  }

  /// Creates a modal combined date and time picker.
  factory CupertinoDateSelector.dateTime({
    DateTime? initialDateTime,
    DateTime? minDateTime,
    DateTime? maxDateTime,
    int minuteInterval = 1,
    bool use24hFormat = false,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    ValueChanged<DateTime>? onDismiss,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    bool dismissible = true,
    bool closeOnSubmit = true,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
  }) {
    return CupertinoDateSelector._(
      type: CupertinoDateSelectorType.dateTime,
      initialDateTime: initialDateTime,
      minDateTime: minDateTime,
      maxDateTime: maxDateTime,
      minuteInterval: minuteInterval,
      use24hFormat: use24hFormat,
      onChange: onChange == null
          ? null
          : (value) => onChange(value as DateTime),
      onSubmit: onSubmit == null
          ? null
          : (value) => onSubmit(value as DateTime),
      onDismiss: onDismiss == null
          ? null
          : (value) => onDismiss(value as DateTime),
      theme: theme,
      headerBuilder: headerBuilder,
      dismissible: dismissible,
      closeOnSubmit: closeOnSubmit,
      height: height,
      useSafeArea: useSafeArea,
      showSubmitButton: showSubmitButton,
      buttonContent: buttonContent,
      buttonAlignment: buttonAlignment,
      submitButtonDecoration: submitButtonDecoration,
      selectionMode:
          modifiers.selectionMode ?? CupertinoDateSelectorSelectionMode.live,
      enableHapticFeedback: modifiers.enableHapticFeedback ?? false,
      locale: modifiers.locale,
      modalBarrierColor: modifiers.modalBarrierColor,
      useRootNavigator: modifiers.useRootNavigator ?? false,
      monthLabelBuilder: modifiers.monthLabelBuilder,
      semanticsLabel: modifiers.semanticsLabel,
    );
  }

  /// Creates a modal year-only picker.
  factory CupertinoDateSelector.year({
    DateTime? initialDateTime,
    DateTime? minDateTime,
    DateTime? maxDateTime,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    ValueChanged<DateTime>? onDismiss,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    bool dismissible = true,
    bool closeOnSubmit = true,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
  }) {
    return CupertinoDateSelector._(
      type: CupertinoDateSelectorType.year,
      initialDateTime: initialDateTime,
      minDateTime: minDateTime,
      maxDateTime: maxDateTime,
      onChange: onChange == null
          ? null
          : (value) => onChange(value as DateTime),
      onSubmit: onSubmit == null
          ? null
          : (value) => onSubmit(value as DateTime),
      onDismiss: onDismiss == null
          ? null
          : (value) => onDismiss(value as DateTime),
      theme: theme,
      headerBuilder: headerBuilder,
      dismissible: dismissible,
      closeOnSubmit: closeOnSubmit,
      height: height,
      useSafeArea: useSafeArea,
      showSubmitButton: showSubmitButton,
      buttonContent: buttonContent,
      buttonAlignment: buttonAlignment,
      submitButtonDecoration: submitButtonDecoration,
      selectionMode:
          modifiers.selectionMode ?? CupertinoDateSelectorSelectionMode.live,
      enableHapticFeedback: modifiers.enableHapticFeedback ?? false,
      locale: modifiers.locale,
      modalBarrierColor: modifiers.modalBarrierColor,
      useRootNavigator: modifiers.useRootNavigator ?? false,
      monthLabelBuilder: modifiers.monthLabelBuilder,
      semanticsLabel: modifiers.semanticsLabel,
    );
  }

  /// Creates a modal month + year picker.
  factory CupertinoDateSelector.monthYear({
    DateTime? initialDateTime,
    DateTime? minDateTime,
    DateTime? maxDateTime,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    ValueChanged<DateTime>? onDismiss,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    bool dismissible = true,
    bool closeOnSubmit = true,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
  }) {
    return CupertinoDateSelector._(
      type: CupertinoDateSelectorType.monthYear,
      initialDateTime: initialDateTime,
      minDateTime: minDateTime,
      maxDateTime: maxDateTime,
      onChange: onChange == null
          ? null
          : (value) => onChange(value as DateTime),
      onSubmit: onSubmit == null
          ? null
          : (value) => onSubmit(value as DateTime),
      onDismiss: onDismiss == null
          ? null
          : (value) => onDismiss(value as DateTime),
      theme: theme,
      headerBuilder: headerBuilder,
      dismissible: dismissible,
      closeOnSubmit: closeOnSubmit,
      height: height,
      useSafeArea: useSafeArea,
      showSubmitButton: showSubmitButton,
      buttonContent: buttonContent,
      buttonAlignment: buttonAlignment,
      submitButtonDecoration: submitButtonDecoration,
      selectionMode:
          modifiers.selectionMode ?? CupertinoDateSelectorSelectionMode.live,
      enableHapticFeedback: modifiers.enableHapticFeedback ?? false,
      locale: modifiers.locale,
      modalBarrierColor: modifiers.modalBarrierColor,
      useRootNavigator: modifiers.useRootNavigator ?? false,
      monthLabelBuilder: modifiers.monthLabelBuilder,
      semanticsLabel: modifiers.semanticsLabel,
    );
  }

  /// Creates a modal month-only picker.
  factory CupertinoDateSelector.month({
    DateTime? initialDateTime,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    ValueChanged<DateTime>? onDismiss,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    bool dismissible = true,
    bool closeOnSubmit = true,
    double height = 320,
    double itemExtent = 36,
    Widget? selectionOverlay,
    TextDirection? layoutDirection,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
  }) {
    return CupertinoDateSelector._(
      type: CupertinoDateSelectorType.month,
      initialDateTime: initialDateTime,
      onChange: onChange == null
          ? null
          : (value) => onChange(value as DateTime),
      onSubmit: onSubmit == null
          ? null
          : (value) => onSubmit(value as DateTime),
      onDismiss: onDismiss == null
          ? null
          : (value) => onDismiss(value as DateTime),
      theme: theme,
      headerBuilder: headerBuilder,
      dismissible: dismissible,
      closeOnSubmit: closeOnSubmit,
      height: height,
      itemExtent: itemExtent,
      selectionOverlay: selectionOverlay,
      layoutDirection: layoutDirection,
      useSafeArea: useSafeArea,
      showSubmitButton: showSubmitButton,
      buttonContent: buttonContent,
      buttonAlignment: buttonAlignment,
      submitButtonDecoration: submitButtonDecoration,
      selectionMode:
          modifiers.selectionMode ?? CupertinoDateSelectorSelectionMode.live,
      enableHapticFeedback: modifiers.enableHapticFeedback ?? false,
      locale: modifiers.locale,
      modalBarrierColor: modifiers.modalBarrierColor,
      useRootNavigator: modifiers.useRootNavigator ?? false,
      monthLabelBuilder: modifiers.monthLabelBuilder,
      semanticsLabel: modifiers.semanticsLabel,
    );
  }

  /// Creates a modal duration picker.
  factory CupertinoDateSelector.duration({
    Duration initialDuration = Duration.zero,
    CupertinoTimerPickerMode timerMode = CupertinoTimerPickerMode.hm,
    int timerSecondInterval = 1,
    ValueChanged<Duration>? onChange,
    ValueChanged<Duration>? onSubmit,
    ValueChanged<Duration>? onDismiss,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    bool dismissible = true,
    bool closeOnSubmit = true,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
  }) {
    return CupertinoDateSelector._(
      type: CupertinoDateSelectorType.duration,
      initialDuration: initialDuration,
      timerMode: timerMode,
      timerSecondInterval: timerSecondInterval,
      onChange: onChange == null
          ? null
          : (value) => onChange(value as Duration),
      onSubmit: onSubmit == null
          ? null
          : (value) => onSubmit(value as Duration),
      onDismiss: onDismiss == null
          ? null
          : (value) => onDismiss(value as Duration),
      theme: theme,
      headerBuilder: headerBuilder,
      dismissible: dismissible,
      closeOnSubmit: closeOnSubmit,
      height: height,
      useSafeArea: useSafeArea,
      showSubmitButton: showSubmitButton,
      buttonContent: buttonContent,
      buttonAlignment: buttonAlignment,
      submitButtonDecoration: submitButtonDecoration,
      selectionMode:
          modifiers.selectionMode ?? CupertinoDateSelectorSelectionMode.live,
      enableHapticFeedback: modifiers.enableHapticFeedback ?? false,
      locale: modifiers.locale,
      modalBarrierColor: modifiers.modalBarrierColor,
      useRootNavigator: modifiers.useRootNavigator ?? false,
      monthLabelBuilder: modifiers.monthLabelBuilder,
      semanticsLabel: modifiers.semanticsLabel,
    );
  }

  final CupertinoDateSelectorType type;
  final CupertinoDateSelectorThemeData theme;
  final SelectorHeaderBuilder? headerBuilder;
  final ValueChanged<dynamic>? onSubmit;
  final ValueChanged<dynamic>? onChange;
  final ValueChanged<dynamic>? onDismiss;
  final bool dismissible;
  final bool closeOnSubmit;
  final double height;
  final double itemExtent;
  final Widget? selectionOverlay;
  final TextDirection? layoutDirection;
  final bool useSafeArea;
  final bool showSubmitButton;
  final Widget? buttonContent;
  final MainAxisAlignment buttonAlignment;
  final Decoration? submitButtonDecoration;

  final DateTime? initialDateTime;
  final DateTime? minDateTime;
  final DateTime? maxDateTime;
  final int minuteInterval;
  final bool use24hFormat;
  final Duration initialDuration;
  final CupertinoTimerPickerMode timerMode;
  final int timerSecondInterval;
  final List<Widget> items;
  final int selectedItemIndex;
  final DatePickerDateOrder? dateOrder;

  final CupertinoDateSelectorSelectionMode selectionMode;
  final bool enableHapticFeedback;
  final Locale? locale;
  final Color? modalBarrierColor;
  final bool useRootNavigator;
  final String Function(int month, Locale locale)? monthLabelBuilder;
  final String? semanticsLabel;

  /// Builds only the scrollable wheels (no header, divider, or submit area).
  Widget buildPicker(
    BuildContext context, {
    required dynamic value,
    required ValueChanged<dynamic> onChanged,
  }) {
    Widget child = _buildPicker(context, value, onChanged);
    final String? label = semanticsLabel;
    if (label != null && label.isNotEmpty) {
      child = Semantics(label: label, child: child);
    }
    return child;
  }

  Future<T?> show<T>(BuildContext context) async {
    dynamic currentValue = _initialValue();

    final result = await showCupertinoModalPopup<T>(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: modalBarrierColor ?? const Color(0x33000000),
      useRootNavigator: useRootNavigator,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Directionality(
              textDirection:
                  layoutDirection ?? Directionality.of(context),
              child: SafeArea(
                top: false,
                left: false,
                right: false,
                bottom: useSafeArea,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(theme.topCornerRadius),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildHeader(ctx),
                        Expanded(
                          child: buildPicker(
                            ctx,
                            value: currentValue,
                            onChanged: (value) {
                              currentValue = value;
                              if (selectionMode ==
                                  CupertinoDateSelectorSelectionMode.live) {
                                onChange?.call(value);
                              }
                              setModalState(() {});
                            },
                          ),
                        ),
                        if (showSubmitButton && onSubmit != null)
                          _buildSubmitButton(ctx, currentValue),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    onDismiss?.call(result ?? currentValue);
    return result;
  }

  dynamic _initialValue() {
    switch (type) {
      case CupertinoDateSelectorType.items:
        return selectedItemIndex.clamp(
          0,
          (items.length - 1).clamp(0, items.length),
        );
      case CupertinoDateSelectorType.duration:
        return initialDuration;
      case CupertinoDateSelectorType.date:
      case CupertinoDateSelectorType.time:
      case CupertinoDateSelectorType.dateTime:
      case CupertinoDateSelectorType.year:
      case CupertinoDateSelectorType.month:
      case CupertinoDateSelectorType.monthYear:
        return _normalizeDate(initialDateTime ?? DateTime.now());
    }
  }

  Widget _buildHeader(BuildContext context) {
    if (headerBuilder != null) {
      return Padding(
        padding: theme.headerPadding,
        child: headerBuilder!(context, () => Navigator.of(context).pop()),
      );
    }

    return const SizedBox.shrink();
  }

  String _monthNameFor(BuildContext context, int month) {
    final Locale loc =
        locale ?? Localizations.maybeLocaleOf(context) ?? const Locale('en');
    final String Function(int month, Locale locale)? builder = monthLabelBuilder;
    if (builder != null) {
      return builder(month, loc);
    }
    return DateFormat.MMMM(loc.toString()).format(DateTime(2000, month));
  }

  Widget _buildPicker(
    BuildContext context,
    dynamic initialValue,
    ValueChanged<dynamic> onValueChange,
  ) {
    void forward(dynamic v) {
      if (enableHapticFeedback) {
        HapticFeedback.selectionClick();
      }
      onValueChange(v);
    }

    if (type == CupertinoDateSelectorType.items) {
      final FixedExtentScrollController controller = FixedExtentScrollController(
        initialItem: initialValue as int,
      );
      return CupertinoPicker(
        scrollController: controller,
        itemExtent: itemExtent,
        selectionOverlay: selectionOverlay,
        onSelectedItemChanged: forward,
        children: items,
      );
    }

    if (type == CupertinoDateSelectorType.duration) {
      return CupertinoTimerPicker(
        mode: timerMode,
        initialTimerDuration: initialValue as Duration,
        secondInterval: timerSecondInterval,
        onTimerDurationChanged: forward,
      );
    }

    if (type == CupertinoDateSelectorType.year) {
      return _buildYearPicker(initialValue as DateTime, forward);
    }

    if (type == CupertinoDateSelectorType.month) {
      return _buildMonthPicker(context, initialValue as DateTime, forward);
    }

    DateTime? normalizedMinimumDate = _normalizedPickerBoundary(
      minDateTime,
      isMinimum: true,
    );
    DateTime? normalizedMaximumDate = _normalizedPickerBoundary(
      maxDateTime,
      isMinimum: false,
    );

    if (normalizedMinimumDate != null &&
        normalizedMaximumDate != null &&
        normalizedMinimumDate.isAfter(normalizedMaximumDate)) {
      normalizedMaximumDate = normalizedMinimumDate;
    }

    final DateTime pickerInitialDateTime = _clampInitialDateTimeForPicker(
      _alignedInitialDateTime(initialValue as DateTime),
      minimum: normalizedMinimumDate,
      maximum: normalizedMaximumDate,
    );

    return CupertinoDatePicker(
      mode: _datePickerMode(),
      dateOrder: dateOrder,
      initialDateTime: pickerInitialDateTime,
      minimumDate: normalizedMinimumDate,
      maximumDate: normalizedMaximumDate,
      minuteInterval: minuteInterval,
      use24hFormat: use24hFormat,
      onDateTimeChanged: (date) => forward(_normalizeDate(date)),
    );
  }

  Widget _buildSubmitButton(BuildContext context, dynamic currentValue) {
    return Padding(
      padding: theme.buttonPadding,
      child: Row(
        mainAxisAlignment: buttonAlignment,
        children: [
          Expanded(
            child: DecoratedBox(
              decoration:
                  submitButtonDecoration ??
                  theme.buttonDecoration ??
                  BoxDecoration(
                    color: theme.buttonColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                onPressed: () {
                  if (selectionMode ==
                      CupertinoDateSelectorSelectionMode.commitOnSubmit) {
                    onChange?.call(currentValue);
                  }
                  onSubmit?.call(currentValue);
                  if (closeOnSubmit) {
                    Navigator.of(context).pop(currentValue);
                  }
                },
                child:
                    buttonContent ??
                    Text(theme.defaultButtonText, style: theme.buttonTextStyle),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CupertinoDatePickerMode _datePickerMode() {
    switch (type) {
      case CupertinoDateSelectorType.date:
      case CupertinoDateSelectorType.year:
      case CupertinoDateSelectorType.month:
        return CupertinoDatePickerMode.date;
      case CupertinoDateSelectorType.monthYear:
        return CupertinoDatePickerMode.monthYear;
      case CupertinoDateSelectorType.time:
        return CupertinoDatePickerMode.time;
      case CupertinoDateSelectorType.dateTime:
        return CupertinoDatePickerMode.dateAndTime;
      case CupertinoDateSelectorType.items:
      case CupertinoDateSelectorType.duration:
        return CupertinoDatePickerMode.date;
    }
  }

  DateTime _normalizeDate(DateTime value) {
    if (type == CupertinoDateSelectorType.year) {
      return DateTime(value.year);
    }
    if (type == CupertinoDateSelectorType.monthYear) {
      return DateTime(value.year, value.month);
    }
    if (type == CupertinoDateSelectorType.month) {
      return DateTime(1, value.month);
    }
    return value;
  }

  DateTime _alignedInitialDateTime(DateTime value) {
    if (minuteInterval <= 1) {
      return value;
    }

    final int remainder = value.minute % minuteInterval;
    if (remainder == 0) {
      return value;
    }

    // Align down to the nearest valid minute to satisfy CupertinoDatePicker assertions.
    return value.subtract(Duration(minutes: remainder));
  }

  DateTime? _normalizedPickerBoundary(
    DateTime? value, {
    required bool isMinimum,
  }) {
    if (value == null) {
      return null;
    }

    if (type == CupertinoDateSelectorType.monthYear) {
      final int lastDayOfMonth = DateUtils.getDaysInMonth(
        value.year,
        value.month,
      );
      return isMinimum
          ? DateTime(value.year, value.month, 1)
          : DateTime(
              value.year,
              value.month,
              lastDayOfMonth,
              23,
              59,
              59,
              999,
              999,
            );
    }

    if (type == CupertinoDateSelectorType.date) {
      return isMinimum
          ? DateTime(value.year, value.month, value.day)
          : DateTime(value.year, value.month, value.day, 23, 59, 59, 999, 999);
    }

    return value;
  }

  DateTime _clampInitialDateTimeForPicker(
    DateTime value, {
    DateTime? minimum,
    DateTime? maximum,
  }) {
    DateTime result = value;
    if (minimum != null && result.isBefore(minimum)) {
      result = minimum;
    }
    if (maximum != null && result.isAfter(maximum)) {
      result = maximum;
    }
    return result;
  }

  Widget _buildYearPicker(
    DateTime initialValue,
    ValueChanged<dynamic> onValueChange,
  ) {
    final int currentYear = DateTime.now().year;
    final int minYear = minDateTime?.year ?? (currentYear - 100);
    final int maxYear = maxDateTime?.year ?? (currentYear + 100);
    final int safeMaxYear = maxYear < minYear ? minYear : maxYear;
    final int initialYear = initialValue.year.clamp(minYear, safeMaxYear);
    final int initialItem = initialYear - minYear;
    final List<int> years = List<int>.generate(
      (safeMaxYear - minYear) + 1,
      (index) => minYear + index,
    );
    final TextStyle baseStyle = theme.itemTextStyle;
    final TextStyle selectedStyle =
        theme.selectedWheelItemTextStyle ?? theme.itemTextStyle;

    return _StyledIndexPicker(
      itemCount: years.length,
      initialItemIndex: initialItem,
      itemExtent: itemExtent,
      selectionOverlay: selectionOverlay,
      onSelectedItemChanged: (index) => onValueChange(DateTime(years[index])),
      itemBuilder: (context, index, isSelected) => Center(
        child: Text(
          years[index].toString(),
          style: isSelected ? selectedStyle : baseStyle,
        ),
      ),
    );
  }

  Widget _buildMonthPicker(
    BuildContext context,
    DateTime initialValue,
    ValueChanged<dynamic> onValueChange,
  ) {
    final int initialMonth = initialValue.month.clamp(1, 12);
    final int initialItem = initialMonth - 1;

    return _StyledIndexPicker(
      itemCount: 12,
      initialItemIndex: initialItem,
      itemExtent: itemExtent,
      selectionOverlay: selectionOverlay,
      onSelectedItemChanged: (index) =>
          onValueChange(DateTime(1, index + 1)),
      itemBuilder: (context, index, isSelected) {
        final String label = _monthNameFor(context, index + 1);
        final TextStyle baseStyle = theme.itemTextStyle;
        final TextStyle selectedStyle =
            theme.selectedWheelItemTextStyle ?? theme.itemTextStyle;
        return Center(
          child: Text(
            label,
            style: isSelected ? selectedStyle : baseStyle,
          ),
        );
      },
    );
  }
}

typedef _PickerItemBuilder =
    Widget Function(BuildContext context, int index, bool isSelected);

class _StyledIndexPicker extends StatefulWidget {
  const _StyledIndexPicker({
    required this.itemCount,
    required this.initialItemIndex,
    required this.itemExtent,
    required this.selectionOverlay,
    required this.onSelectedItemChanged,
    required this.itemBuilder,
  });

  final int itemCount;
  final int initialItemIndex;
  final double itemExtent;
  final Widget? selectionOverlay;
  final ValueChanged<int> onSelectedItemChanged;
  final _PickerItemBuilder itemBuilder;

  @override
  State<_StyledIndexPicker> createState() => _StyledIndexPickerState();
}

class _StyledIndexPickerState extends State<_StyledIndexPicker> {
  late int _selectedIndex;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    assert(widget.itemCount > 0);
    _selectedIndex = widget.initialItemIndex.clamp(0, widget.itemCount - 1);
    _scrollController = FixedExtentScrollController(initialItem: _selectedIndex);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_StyledIndexPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemCount != widget.itemCount && widget.itemCount > 0) {
      _selectedIndex = _selectedIndex.clamp(0, widget.itemCount - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: _scrollController,
      itemExtent: widget.itemExtent,
      selectionOverlay: widget.selectionOverlay,
      onSelectedItemChanged: (index) {
        setState(() => _selectedIndex = index);
        widget.onSelectedItemChanged(index);
      },
      children: List<Widget>.generate(
        widget.itemCount,
        (i) => widget.itemBuilder(context, i, i == _selectedIndex),
      ),
    );
  }
}

/// Inline widget variant for rendering selectors in a page.
class CupertinoDateSelectorWidget extends StatefulWidget {
  const CupertinoDateSelectorWidget._({
    super.key,
    required this.selector,
    this.controller,
  });

  /// Creates an inline wheel picker for a custom list of [items].
  factory CupertinoDateSelectorWidget.items({
    Key? key,
    required List<Widget> items,
    int selectedItemIndex = 0,
    ValueChanged<int>? onChanged,
    ValueChanged<int>? onChange,
    ValueChanged<int>? onSubmit,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    double height = 320,
    double itemExtent = 36,
    Widget? selectionOverlay,
    TextDirection? layoutDirection,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
    CupertinoDateSelectorController? controller,
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
      controller: controller,
      selector: CupertinoDateSelector.items(
        items: items,
        selectedItemIndex: selectedItemIndex,
        onChange: onChanged ?? onChange,
        onSubmit: onSubmit,
        theme: theme,
        headerBuilder: headerBuilder,
        height: height,
        itemExtent: itemExtent,
        selectionOverlay: selectionOverlay,
        layoutDirection: layoutDirection,
        useSafeArea: useSafeArea,
        showSubmitButton: showSubmitButton,
        buttonContent: buttonContent,
        buttonAlignment: buttonAlignment,
        submitButtonDecoration: submitButtonDecoration,
        modifiers: modifiers,
      ),
    );
  }

  /// Creates an inline date picker.
  factory CupertinoDateSelectorWidget.date({
    Key? key,
    DateTime? initialDateTime,
    DateTime? minDateTime,
    DateTime? maxDateTime,
    DatePickerDateOrder? dateOrder,
    ValueChanged<DateTime>? onChanged,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
    CupertinoDateSelectorController? controller,
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
      controller: controller,
      selector: CupertinoDateSelector.date(
        initialDateTime: initialDateTime,
        minDateTime: minDateTime,
        maxDateTime: maxDateTime,
        dateOrder: dateOrder,
        onChange: onChanged ?? onChange,
        onSubmit: onSubmit,
        theme: theme,
        headerBuilder: headerBuilder,
        height: height,
        useSafeArea: useSafeArea,
        showSubmitButton: showSubmitButton,
        buttonContent: buttonContent,
        buttonAlignment: buttonAlignment,
        submitButtonDecoration: submitButtonDecoration,
        modifiers: modifiers,
      ),
    );
  }

  /// Creates an inline time picker.
  factory CupertinoDateSelectorWidget.time({
    Key? key,
    DateTime? initialDateTime,
    int minuteInterval = 1,
    bool use24hFormat = false,
    ValueChanged<DateTime>? onChanged,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
    CupertinoDateSelectorController? controller,
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
      controller: controller,
      selector: CupertinoDateSelector.time(
        initialDateTime: initialDateTime,
        minuteInterval: minuteInterval,
        use24hFormat: use24hFormat,
        onChange: onChanged ?? onChange,
        onSubmit: onSubmit,
        theme: theme,
        headerBuilder: headerBuilder,
        height: height,
        useSafeArea: useSafeArea,
        showSubmitButton: showSubmitButton,
        buttonContent: buttonContent,
        buttonAlignment: buttonAlignment,
        submitButtonDecoration: submitButtonDecoration,
        modifiers: modifiers,
      ),
    );
  }

  /// Creates an inline combined date and time picker.
  factory CupertinoDateSelectorWidget.dateTime({
    Key? key,
    DateTime? initialDateTime,
    DateTime? minDateTime,
    DateTime? maxDateTime,
    int minuteInterval = 1,
    bool use24hFormat = false,
    ValueChanged<DateTime>? onChanged,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
    CupertinoDateSelectorController? controller,
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
      controller: controller,
      selector: CupertinoDateSelector.dateTime(
        initialDateTime: initialDateTime,
        minDateTime: minDateTime,
        maxDateTime: maxDateTime,
        minuteInterval: minuteInterval,
        use24hFormat: use24hFormat,
        onChange: onChanged ?? onChange,
        onSubmit: onSubmit,
        theme: theme,
        headerBuilder: headerBuilder,
        height: height,
        useSafeArea: useSafeArea,
        showSubmitButton: showSubmitButton,
        buttonContent: buttonContent,
        buttonAlignment: buttonAlignment,
        submitButtonDecoration: submitButtonDecoration,
        modifiers: modifiers,
      ),
    );
  }

  /// Creates an inline year-only picker.
  factory CupertinoDateSelectorWidget.year({
    Key? key,
    DateTime? initialDateTime,
    DateTime? minDateTime,
    DateTime? maxDateTime,
    ValueChanged<DateTime>? onChanged,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
    CupertinoDateSelectorController? controller,
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
      controller: controller,
      selector: CupertinoDateSelector.year(
        initialDateTime: initialDateTime,
        minDateTime: minDateTime,
        maxDateTime: maxDateTime,
        onChange: onChanged ?? onChange,
        onSubmit: onSubmit,
        theme: theme,
        headerBuilder: headerBuilder,
        height: height,
        useSafeArea: useSafeArea,
        showSubmitButton: showSubmitButton,
        buttonContent: buttonContent,
        buttonAlignment: buttonAlignment,
        submitButtonDecoration: submitButtonDecoration,
        modifiers: modifiers,
      ),
    );
  }

  /// Creates an inline month + year picker.
  factory CupertinoDateSelectorWidget.monthYear({
    Key? key,
    DateTime? initialDateTime,
    DateTime? minDateTime,
    DateTime? maxDateTime,
    ValueChanged<DateTime>? onChanged,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
    CupertinoDateSelectorController? controller,
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
      controller: controller,
      selector: CupertinoDateSelector.monthYear(
        initialDateTime: initialDateTime,
        minDateTime: minDateTime,
        maxDateTime: maxDateTime,
        onChange: onChanged ?? onChange,
        onSubmit: onSubmit,
        theme: theme,
        headerBuilder: headerBuilder,
        height: height,
        useSafeArea: useSafeArea,
        showSubmitButton: showSubmitButton,
        buttonContent: buttonContent,
        buttonAlignment: buttonAlignment,
        submitButtonDecoration: submitButtonDecoration,
        modifiers: modifiers,
      ),
    );
  }

  /// Creates an inline month-only picker.
  factory CupertinoDateSelectorWidget.month({
    Key? key,
    DateTime? initialDateTime,
    ValueChanged<DateTime>? onChanged,
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onSubmit,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    double height = 320,
    double itemExtent = 36,
    Widget? selectionOverlay,
    TextDirection? layoutDirection,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
    CupertinoDateSelectorController? controller,
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
      controller: controller,
      selector: CupertinoDateSelector.month(
        initialDateTime: initialDateTime,
        onChange: onChanged ?? onChange,
        onSubmit: onSubmit,
        theme: theme,
        headerBuilder: headerBuilder,
        height: height,
        itemExtent: itemExtent,
        selectionOverlay: selectionOverlay,
        layoutDirection: layoutDirection,
        useSafeArea: useSafeArea,
        showSubmitButton: showSubmitButton,
        buttonContent: buttonContent,
        buttonAlignment: buttonAlignment,
        submitButtonDecoration: submitButtonDecoration,
        modifiers: modifiers,
      ),
    );
  }

  /// Creates an inline duration picker.
  factory CupertinoDateSelectorWidget.duration({
    Key? key,
    Duration initialDuration = Duration.zero,
    CupertinoTimerPickerMode timerMode = CupertinoTimerPickerMode.hm,
    int timerSecondInterval = 1,
    ValueChanged<Duration>? onChanged,
    ValueChanged<Duration>? onChange,
    ValueChanged<Duration>? onSubmit,
    CupertinoDateSelectorThemeData theme =
        const CupertinoDateSelectorThemeData(),
    SelectorHeaderBuilder? headerBuilder,
    double height = 320,
    bool useSafeArea = true,
    bool showSubmitButton = true,
    Widget? buttonContent,
    MainAxisAlignment buttonAlignment = MainAxisAlignment.center,
    Decoration? submitButtonDecoration,
    CupertinoDateSelectorModifiers modifiers = const CupertinoDateSelectorModifiers(),
    CupertinoDateSelectorController? controller,
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
      controller: controller,
      selector: CupertinoDateSelector.duration(
        initialDuration: initialDuration,
        timerMode: timerMode,
        timerSecondInterval: timerSecondInterval,
        onChange: onChanged ?? onChange,
        onSubmit: onSubmit,
        theme: theme,
        headerBuilder: headerBuilder,
        height: height,
        useSafeArea: useSafeArea,
        showSubmitButton: showSubmitButton,
        buttonContent: buttonContent,
        buttonAlignment: buttonAlignment,
        submitButtonDecoration: submitButtonDecoration,
        modifiers: modifiers,
      ),
    );
  }

  final CupertinoDateSelector selector;

  /// Optional controller to jump the wheel from outside the widget.
  final CupertinoDateSelectorController? controller;

  @override
  State<CupertinoDateSelectorWidget> createState() =>
      _CupertinoDateSelectorWidgetState();
}

class _CupertinoDateSelectorWidgetState
    extends State<CupertinoDateSelectorWidget> {
  late dynamic _currentValue;
  late Key _pickerKey;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.selector._initialValue();
    _pickerKey = widget.controller != null
        ? ValueKey<int>(widget.controller!.syncGeneration)
        : const ValueKey<String>('cupertino_date_selector_picker');
    widget.controller?.adoptValue(_currentValue);
    widget.controller?.addListener(_onControllerSync);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerSync);
    super.dispose();
  }

  void _onControllerSync() {
    final CupertinoDateSelectorController? c = widget.controller;
    if (!mounted || c == null) {
      return;
    }
    setState(() {
      _currentValue = c.value;
      _pickerKey = ValueKey<int>(c.syncGeneration);
    });
  }

  @override
  void didUpdateWidget(covariant CupertinoDateSelectorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerSync);
      widget.controller?.addListener(_onControllerSync);
      widget.controller?.adoptValue(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      height: widget.selector.height,
      color: widget.selector.theme.backgroundColor,
      child: Column(
        children: [
          widget.selector._buildHeader(context),
          Expanded(
            child: KeyedSubtree(
              key: _pickerKey,
              child: widget.selector.buildPicker(
                context,
                value: _currentValue,
                onChanged: (value) {
                  setState(() => _currentValue = value);
                  widget.controller?.adoptValue(value);
                  if (widget.selector.selectionMode ==
                      CupertinoDateSelectorSelectionMode.live) {
                    widget.selector.onChange?.call(value);
                  }
                },
              ),
            ),
          ),
          if (widget.selector.showSubmitButton &&
              widget.selector.onSubmit != null)
            Padding(
              padding: widget.selector.theme.buttonPadding,
              child: Row(
                mainAxisAlignment: widget.selector.buttonAlignment,
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration:
                          widget.selector.submitButtonDecoration ??
                          widget.selector.theme.buttonDecoration ??
                          BoxDecoration(
                            color: widget.selector.theme.buttonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        onPressed: () {
                          if (widget.selector.selectionMode ==
                              CupertinoDateSelectorSelectionMode
                                  .commitOnSubmit) {
                            widget.selector.onChange?.call(_currentValue);
                          }
                          widget.selector.onSubmit?.call(_currentValue);
                        },
                        child:
                            widget.selector.buttonContent ??
                            Text(
                              widget.selector.theme.defaultButtonText,
                              style: widget.selector.theme.buttonTextStyle,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );

    if (widget.selector.useSafeArea) {
      content = SafeArea(top: false, left: false, right: false, child: content);
    }

    return content;
  }
}

/// Picker wheels only — no header, divider, or submit area.
///
/// Use inside your own sheet or card; you keep [value] in parent state.
class CupertinoDateSelectorPickerBody extends StatelessWidget {
  const CupertinoDateSelectorPickerBody({
    super.key,
    required this.selector,
    required this.value,
    required this.onChanged,
  });

  /// Configuration from a [CupertinoDateSelector] factory.
  final CupertinoDateSelector selector;

  final dynamic value;

  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return selector.buildPicker(context, value: value, onChanged: onChanged);
  }
}
