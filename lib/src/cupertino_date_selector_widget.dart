import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cupertino_date_selector_theme.dart';

typedef SelectorHeaderBuilder =
    Widget Function(BuildContext context, VoidCallback close);

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

/// Highly customizable Cupertino-style selector.
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
  }) : assert(itemExtent > 0),
       assert(minuteInterval > 0),
       assert(timerSecondInterval > 0);

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
    );
  }

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
    );
  }

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
    );
  }

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
    );
  }

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
    );
  }

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
    );
  }

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
    );
  }

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

  Future<T?> show<T>(BuildContext context) async {
    dynamic currentValue = _initialValue();

    final result = await showCupertinoModalPopup<T>(
      context: context,
      barrierDismissible: dismissible,
      builder: (ctx) {
        return Directionality(
          textDirection: layoutDirection ?? Directionality.of(ctx),
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
                      child: _buildPicker(currentValue, (value) {
                        currentValue = value;
                        onChange?.call(value);
                      }),
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

    onDismiss?.call(currentValue);
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

  Widget _buildPicker(
    dynamic initialValue,
    ValueChanged<dynamic> onValueChange,
  ) {
    if (type == CupertinoDateSelectorType.items) {
      final controller = FixedExtentScrollController(
        initialItem: initialValue as int,
      );
      return CupertinoPicker(
        scrollController: controller,
        itemExtent: itemExtent,
        selectionOverlay: selectionOverlay,
        onSelectedItemChanged: onValueChange,
        children: items,
      );
    }

    if (type == CupertinoDateSelectorType.duration) {
      return CupertinoTimerPicker(
        mode: timerMode,
        initialTimerDuration: initialValue as Duration,
        secondInterval: timerSecondInterval,
        onTimerDurationChanged: onValueChange,
      );
    }

    if (type == CupertinoDateSelectorType.year) {
      return _buildYearPicker(initialValue as DateTime, onValueChange);
    }

    if (type == CupertinoDateSelectorType.month) {
      return _buildMonthPicker(initialValue as DateTime, onValueChange);
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
      onDateTimeChanged: (date) => onValueChange(_normalizeDate(date)),
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
    final controller = FixedExtentScrollController(initialItem: initialItem);
    final List<int> years = List<int>.generate(
      (safeMaxYear - minYear) + 1,
      (index) => minYear + index,
    );

    return CupertinoPicker(
      scrollController: controller,
      itemExtent: itemExtent,
      selectionOverlay: selectionOverlay,
      onSelectedItemChanged: (index) => onValueChange(DateTime(years[index])),
      children: years
          .map(
            (year) => Center(
              child: Text(year.toString(), style: theme.itemTextStyle),
            ),
          )
          .toList(),
    );
  }

  Widget _buildMonthPicker(
    DateTime initialValue,
    ValueChanged<dynamic> onValueChange,
  ) {
    final int initialMonth = initialValue.month.clamp(1, 12);
    final controller = FixedExtentScrollController(
      initialItem: initialMonth - 1,
    );
    final List<String> monthNames = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return CupertinoPicker(
      scrollController: controller,
      itemExtent: itemExtent,
      selectionOverlay: selectionOverlay,
      onSelectedItemChanged: (index) => onValueChange(DateTime(1, index + 1)),
      children: monthNames
          .map(
            (month) => Center(child: Text(month, style: theme.itemTextStyle)),
          )
          .toList(),
    );
  }
}

/// Inline widget variant for rendering selector in widget tree.
class CupertinoDateSelectorWidget extends StatefulWidget {
  const CupertinoDateSelectorWidget._({super.key, required this.selector});

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
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
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
      ),
    );
  }

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
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
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
      ),
    );
  }

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
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
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
      ),
    );
  }

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
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
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
      ),
    );
  }

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
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
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
      ),
    );
  }

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
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
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
      ),
    );
  }

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
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
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
      ),
    );
  }

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
  }) {
    return CupertinoDateSelectorWidget._(
      key: key,
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
      ),
    );
  }

  final CupertinoDateSelector selector;

  @override
  State<CupertinoDateSelectorWidget> createState() =>
      _CupertinoDateSelectorWidgetState();
}

class _CupertinoDateSelectorWidgetState
    extends State<CupertinoDateSelectorWidget> {
  late dynamic _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.selector._initialValue();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      height: widget.selector.height,
      color: widget.selector.theme.backgroundColor,
      child: Column(
        children: [
          widget.selector._buildHeader(context),
          // Container(height: 1, color: widget.selector.theme.dividerColor),
          Expanded(
            child: widget.selector._buildPicker(_currentValue, (value) {
              setState(() => _currentValue = value);
              widget.selector.onChange?.call(value);
            }),
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
