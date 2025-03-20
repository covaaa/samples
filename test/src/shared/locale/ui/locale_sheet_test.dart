import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/shared/locale/locale.dart';
import '../../../../extensions/pump.dart';

void main() {
  group('locale sheet', () {
    testWidgets('should sync locale en', (tester) async {
      await tester.pumpApp(
        scaffold: false,
        child: const LocaleSheet(LocaleJa()),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(RadioListTile<SealedLocale>).at(0));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton));
    });

    testWidgets('should sync locale ja', (tester) async {
      await tester.pumpApp(
        scaffold: false,
        child: const LocaleSheet(LocaleEn()),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(RadioListTile<SealedLocale>).at(1));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton));
    });
  });
}
