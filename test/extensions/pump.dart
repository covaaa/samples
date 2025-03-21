import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension XPump on WidgetTester {
  Future<void> pumpRiverpodWidget({
    required Widget child,
    List<Override> overrides = const [],
  }) => pumpWidget(ProviderScope(overrides: overrides, child: child));

  Future<void> pumpApp({
    required Widget child,
    bool scaffold = true,
    List<Override> overrides = const [],
  }) => pumpRiverpodWidget(
    overrides: overrides,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: scaffold ? Scaffold(body: child) : child,
    ),
  );
}
