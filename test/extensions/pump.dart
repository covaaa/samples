import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/shared/l10n/l10n.dart';

extension XPump on WidgetTester {
  Future<void> pumpRiverpodWidget({
    required Widget child,
    List<Override> overrides = const [],
  }) {
    return pumpWidget(ProviderScope(overrides: overrides, child: child));
  }

  Future<void> pumpApp({
    required Widget child,
    bool scaffold = true,
    List<Override> overrides = const [],
  }) async {
    return pumpRiverpodWidget(
      overrides: overrides,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.supportedLocales,
        localizationsDelegates: L10n.localizationsDelegates,
        onGenerateTitle: (context) => context.l10n.title,
        home: scaffold ? Scaffold(body: child) : child,
      ),
    );
  }
}
