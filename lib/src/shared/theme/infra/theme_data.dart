import 'package:flutter/material.dart';

extension type const SamplesThemeData._(ThemeData _) implements ThemeData {
  factory SamplesThemeData.light(Color color) {
    return SamplesThemeData._m3(color, Brightness.light);
  }
  factory SamplesThemeData.dark(Color color) {
    return SamplesThemeData._m3(color, Brightness.dark);
  }
  factory SamplesThemeData._m3(Color color, Brightness brightness) {
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: color,
      ),
    );
    return SamplesThemeData._(
      theme.copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),
        cardTheme: const CardThemeData(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.symmetric(vertical: 4),
        ),
      ),
    );
  }
}
