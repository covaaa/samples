import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/shared/l10n/l10n.dart';

extension XPump on WidgetTester {
  Future<void> pumpMaterialApp({required Widget child, bool scaffold = true}) {
    return pumpWidget(
      MaterialApp(
        supportedLocales: L10n.supportedLocales,
        localizationsDelegates: L10n.localizationsDelegates,
        home: scaffold ? Scaffold(body: child) : child,
      ),
    );
  }
}
