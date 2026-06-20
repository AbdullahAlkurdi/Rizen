import 'package:flutter/material.dart';

import 'package:rizen/app.dart';

void main() {
  testWidgets('Rizen app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RizenApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Rizen'), findsOneWidget);
  });
}
