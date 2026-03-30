import 'package:cupertino_date_selector/cupertino_date_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Constructor types', () {
    test('time', () {
      expect(CupertinoDateSelector.time().type, CupertinoDateSelectorType.time);
    });

    test('dateTime', () {
      expect(
        CupertinoDateSelector.dateTime().type,
        CupertinoDateSelectorType.dateTime,
      );
    });
  });

  group('Modifiers on selector', () {
    test('defaults to live selection and haptics on', () {
      final s = CupertinoDateSelector.date();
      expect(s.selectionMode, CupertinoDateSelectorSelectionMode.live);
      expect(s.enableHapticFeedback, true);
    });

    test('modifiers override selection mode and haptics', () {
      final s = CupertinoDateSelector.date(
        modifiers: const CupertinoDateSelectorModifiers(
          selectionMode: CupertinoDateSelectorSelectionMode.commitOnSubmit,
          enableHapticFeedback: true,
        ),
      );
      expect(s.selectionMode, CupertinoDateSelectorSelectionMode.commitOnSubmit);
      expect(s.enableHapticFeedback, true);
    });

    test('enableHapticFeedback on factory enables without modifiers', () {
      final s = CupertinoDateSelector.date(enableHapticFeedback: true);
      expect(s.enableHapticFeedback, true);
    });

    test('factory enableHapticFeedback false overrides modifiers true', () {
      final s = CupertinoDateSelector.date(
        enableHapticFeedback: false,
        modifiers: const CupertinoDateSelectorModifiers(
          enableHapticFeedback: true,
        ),
      );
      expect(s.enableHapticFeedback, false);
    });

    test('modifiers enableHapticFeedback false disables when factory omits', () {
      final s = CupertinoDateSelector.date(
        modifiers: const CupertinoDateSelectorModifiers(
          enableHapticFeedback: false,
        ),
      );
      expect(s.enableHapticFeedback, false);
    });
  });

  group('CupertinoDateSelectorController', () {
    test('jumpTo updates value and syncGeneration', () {
      final c = CupertinoDateSelectorController();
      expect(c.syncGeneration, 0);
      c.jumpTo(DateTime(2024));
      expect(c.value, DateTime(2024));
      expect(c.syncGeneration, 1);
      c.adoptValue(DateTime(2023));
      expect(c.value, DateTime(2023));
      expect(c.syncGeneration, 1);
    });
  });

  group('ThemeData', () {
    test('copyWith preserves selectedWheelItemTextStyle', () {
      const base = CupertinoDateSelectorThemeData();
      final next = base.copyWith(
        selectedWheelItemTextStyle: TextStyle(fontSize: 24),
      );
      expect(next.selectedWheelItemTextStyle?.fontSize, 24);
    });
  });

  group('Widget smoke (each mode builds)', () {
    testWidgets('items', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200,
              child: CupertinoDateSelectorWidget.items(
                items: const [Text('a'), Text('b')],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoPicker), findsOneWidget);
    });

    testWidgets('date', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 280,
              child: CupertinoDateSelectorWidget.date(
                initialDateTime: DateTime(2024, 6, 15),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoDatePicker), findsOneWidget);
    });

    testWidgets('time', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 280,
              child: CupertinoDateSelectorWidget.time(
                initialDateTime: DateTime(2024, 1, 1, 14, 30),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoDatePicker), findsOneWidget);
    });

    testWidgets('dateTime', (tester) async {
      final now = DateTime(2024, 3, 10, 10, 0);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 280,
              child: CupertinoDateSelectorWidget.dateTime(
                initialDateTime: now,
                minDateTime: now.subtract(const Duration(days: 1)),
                maxDateTime: now.add(const Duration(days: 1)),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoDatePicker), findsOneWidget);
    });

    testWidgets('year', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200,
              child: CupertinoDateSelectorWidget.year(
                initialDateTime: DateTime(2022),
                minDateTime: DateTime(2020),
                maxDateTime: DateTime(2025),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoPicker), findsOneWidget);
    });

    testWidgets('month', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200,
              child: CupertinoDateSelectorWidget.month(
                initialDateTime: DateTime(1, 6),
                modifiers: const CupertinoDateSelectorModifiers(
                  locale: Locale('en', 'US'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoPicker), findsOneWidget);
    });

    testWidgets('monthYear', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 280,
              child: CupertinoDateSelectorWidget.monthYear(
                initialDateTime: DateTime(2024, 6),
                minDateTime: DateTime(2022, 1),
                maxDateTime: DateTime(2026, 12),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoDatePicker), findsOneWidget);
    });

    testWidgets('duration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 240,
              child: CupertinoDateSelectorWidget.duration(
                initialDuration: const Duration(hours: 1, minutes: 5),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoTimerPicker), findsOneWidget);
    });
  });

  group('CupertinoDateSelectorPickerBody', () {
    testWidgets('forwards selection changes', (tester) async {
      int? last;
      final config = CupertinoDateSelector.items(
        items: const [Text('0'), Text('1'), Text('2')],
        selectedItemIndex: 0,
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  height: 200,
                  child: CupertinoDateSelectorPickerBody(
                    selector: config,
                    value: 0,
                    onChanged: (v) {
                      last = v as int;
                      setState(() {});
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.drag(find.byType(CupertinoPicker), const Offset(0, -60));
      await tester.pumpAndSettle();
      expect(last, isNotNull);
    });
  });

  group('Live vs commit', () {
    testWidgets('live fires onChange while scrolling', (tester) async {
      int n = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CupertinoDateSelectorWidget.items(
              items: const [Text('A'), Text('B'), Text('C')],
              selectedItemIndex: 0,
              onChange: (_) => n++,
              modifiers: const CupertinoDateSelectorModifiers(
                selectionMode: CupertinoDateSelectorSelectionMode.live,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final before = n;
      await tester.drag(find.byType(CupertinoPicker), const Offset(0, -80));
      await tester.pumpAndSettle();
      expect(n, greaterThan(before));
    });
  });

  group('Custom month labels', () {
    testWidgets('monthLabelBuilder overrides default names', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 220,
              child: CupertinoDateSelectorWidget.month(
                initialDateTime: DateTime(1, 3),
                modifiers: CupertinoDateSelectorModifiers(
                  monthLabelBuilder: (m, _) => 'M$m',
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('M3'), findsWidgets);
    });
  });

  group('Semantics', () {
    testWidgets('semanticsLabel wraps picker', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CupertinoDateSelectorWidget.items(
              items: const [Text('x')],
              modifiers: const CupertinoDateSelectorModifiers(
                semanticsLabel: 'Test item picker',
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel('Test item picker'), findsOneWidget);
    });
  });

  group('buildPicker', () {
    testWidgets('exposes wheels without chrome', (tester) async {
      final sel = CupertinoDateSelector.items(
        items: const [Text('p')],
        selectedItemIndex: 0,
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return SizedBox(
                  height: 180,
                  child: sel.buildPicker(
                    context,
                    value: 0,
                    onChanged: (_) {},
                  ),
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoPicker), findsOneWidget);
    });
  });
}
