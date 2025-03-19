import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension XPump on WidgetTester {
  Future<void> pumpMaterialApp({required Widget child, bool scaffold = true}) {
    return pumpWidget(
      MaterialApp(home: scaffold ? Scaffold(body: child) : child),
    );
  }
}
