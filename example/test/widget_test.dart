import 'package:flutter_test/flutter_test.dart';

import 'package:cupertino_date_selector_example/main.dart';

void main() {
  testWidgets('Example app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const ExampleApp());

    expect(find.text('cupertino_date_selector'), findsOneWidget);
    expect(find.text('Items'), findsOneWidget);
  });
}
