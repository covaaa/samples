import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/features/home/home.dart';
import 'package:samples/src/shared/locale/locale.dart';
import '../../../../extensions/pump.dart';

void main() {
  group('home page', () {
    testWidgets('should increment counts', (tester) async {
      await tester.pumpApp(child: const HomePage());
      expect(find.text('0 times'), findsOneWidget);
      expect(find.text('1 times'), findsNothing);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('0 times'), findsNothing);
      expect(find.text('1 times'), findsOneWidget);
    });

    testWidgets('should show locale sheet', (tester) async {
      await tester.pumpApp(child: const HomePage());
      await tester.tap(find.byIcon(Icons.translate_outlined));
      await tester.pumpAndSettle();
      expect(find.byType(LocaleSheet), findsOneWidget);
    });
  });
}
