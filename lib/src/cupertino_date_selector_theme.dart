import 'package:flutter/cupertino.dart';

/// Visual customization options for [CupertinoDateSelector].
@immutable
class CupertinoDateSelectorThemeData {
  const CupertinoDateSelectorThemeData({
    this.backgroundColor = CupertinoColors.systemBackground,
    this.headerPadding = const EdgeInsets.fromLTRB(16, 14, 16, 8),
    this.headerTextStyle = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: CupertinoColors.label,
    ),
    this.closeIcon = CupertinoIcons.clear_thick_circled,
    this.closeIconColor = CupertinoColors.secondaryLabel,
    this.buttonPadding = const EdgeInsets.fromLTRB(16, 8, 16, 16),
    this.buttonDecoration,
    this.buttonColor = CupertinoColors.activeBlue,
    this.buttonTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: CupertinoColors.white,
    ),
    this.defaultButtonText = 'Select',
    this.dividerColor = const Color(0x1A000000),
    this.itemTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: CupertinoColors.label,
    ),
    this.topCornerRadius = 16,
  });

  final Color backgroundColor;
  final EdgeInsetsGeometry headerPadding;
  final TextStyle headerTextStyle;
  final IconData closeIcon;
  final Color closeIconColor;
  final EdgeInsetsGeometry buttonPadding;
  final Decoration? buttonDecoration;
  final Color buttonColor;
  final TextStyle buttonTextStyle;
  final String defaultButtonText;
  final Color dividerColor;
  final TextStyle itemTextStyle;
  final double topCornerRadius;

  CupertinoDateSelectorThemeData copyWith({
    Color? backgroundColor,
    EdgeInsetsGeometry? headerPadding,
    TextStyle? headerTextStyle,
    IconData? closeIcon,
    Color? closeIconColor,
    EdgeInsetsGeometry? buttonPadding,
    Decoration? buttonDecoration,
    Color? buttonColor,
    TextStyle? buttonTextStyle,
    String? defaultButtonText,
    Color? dividerColor,
    TextStyle? itemTextStyle,
    double? topCornerRadius,
  }) {
    return CupertinoDateSelectorThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerPadding: headerPadding ?? this.headerPadding,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      closeIcon: closeIcon ?? this.closeIcon,
      closeIconColor: closeIconColor ?? this.closeIconColor,
      buttonPadding: buttonPadding ?? this.buttonPadding,
      buttonDecoration: buttonDecoration ?? this.buttonDecoration,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      defaultButtonText: defaultButtonText ?? this.defaultButtonText,
      dividerColor: dividerColor ?? this.dividerColor,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      topCornerRadius: topCornerRadius ?? this.topCornerRadius,
    );
  }
}
