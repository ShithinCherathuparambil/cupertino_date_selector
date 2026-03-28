import 'package:flutter/foundation.dart';

/// Optional controller to mirror the current value and to **jump** the picker
/// from outside (rebuilds the wheel with a new initial value).
///
/// Call [jumpTo] when you need programmatic selection (e.g. arrow buttons).
/// User-driven scroll updates [value] without incrementing [syncGeneration].
class CupertinoDateSelectorController extends ChangeNotifier {
  dynamic _value;
  int _syncGeneration = 0;

  dynamic get value => _value;

  /// Bumps when [jumpTo] is called; use with [ValueKey] to reset wheel state.
  int get syncGeneration => _syncGeneration;

  /// Updates the mirrored value from wheel interaction (no [notifyListeners]).
  void adoptValue(dynamic v) {
    _value = v;
  }

  /// Programmatically set selection and force picker widgets to rebuild.
  void jumpTo(dynamic v) {
    _value = v;
    _syncGeneration++;
    notifyListeners();
  }
}
