import 'package:cupertino_date_selector/cupertino_date_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('items constructor sets expected type', () {
    final picker = CupertinoDateSelector.items(
      items: const [Text('One'), Text('Two')],
    );

    expect(picker.type, CupertinoDateSelectorType.items);
    expect(picker.items.length, 2);
  });

  test('date constructor sets expected type', () {
    final picker = CupertinoDateSelector.date();

    expect(picker.type, CupertinoDateSelectorType.date);
  });

  test('duration constructor sets expected defaults', () {
    final picker = CupertinoDateSelector.duration();

    expect(picker.type, CupertinoDateSelectorType.duration);
    expect(picker.initialDuration, Duration.zero);
    expect(picker.timerSecondInterval, 1);
  });

  test('year constructor sets expected type', () {
    final picker = CupertinoDateSelector.year();
    expect(picker.type, CupertinoDateSelectorType.year);
  });

  test('month constructor sets expected type', () {
    final picker = CupertinoDateSelector.month();
    expect(picker.type, CupertinoDateSelectorType.month);
  });

  test('monthYear constructor sets expected type', () {
    final picker = CupertinoDateSelector.monthYear();
    expect(picker.type, CupertinoDateSelectorType.monthYear);
  });
}
