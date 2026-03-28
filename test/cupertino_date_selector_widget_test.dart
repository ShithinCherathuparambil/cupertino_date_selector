import 'package:cupertino_date_selector/cupertino_date_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('submit button hidden when onSubmit is null', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CupertinoDateSelectorWidget.items(
            items: const [Text('A'), Text('B')],
            showSubmitButton: true,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CupertinoButton), findsNothing);
  });

  testWidgets('commitOnSubmit calls onChange only after submit', (tester) async {
    int changeCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CupertinoDateSelectorWidget.items(
            items: const [Text('A'), Text('B'), Text('C')],
            selectedItemIndex: 0,
            onChange: (_) => changeCount++,
            onSubmit: (_) {},
            modifiers: const CupertinoDateSelectorModifiers(
              selectionMode: CupertinoDateSelectorSelectionMode.commitOnSubmit,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(changeCount, 0);

    await tester.drag(
      find.byType(CupertinoPicker),
      const Offset(0, -80),
    );
    await tester.pumpAndSettle();
    expect(changeCount, 0);

    await tester.tap(find.text('Select'));
    await tester.pumpAndSettle();
    expect(changeCount, 1);
  });

  testWidgets('controller jumpTo rebuilds picker value', (tester) async {
    final controller = CupertinoDateSelectorController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 320,
            child: CupertinoDateSelectorWidget.year(
              initialDateTime: DateTime(2020),
              minDateTime: DateTime(2018),
              maxDateTime: DateTime(2025),
              controller: controller,
              onSubmit: (_) {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    controller.jumpTo(DateTime(2024));
    await tester.pumpAndSettle();

    expect(controller.value, DateTime(2024));
    expect(find.text('2024'), findsWidgets);
  });
}
