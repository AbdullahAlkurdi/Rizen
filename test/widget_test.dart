import 'package:flutter_test/flutter_test.dart';
import 'package:rizen/app.dart';

void main() {
  testWidgets('Rizen app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RizenApp());
    await tester.pump();

    expect(find.text('Rizen'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
