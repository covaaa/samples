import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/features/tabs/home/home.dart';
import '../../../../../extensions/pump.dart';

void main() {
  testWidgets('home page should increment counts', (tester) async {
    await tester.pumpApp(child: const HomePage());
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
