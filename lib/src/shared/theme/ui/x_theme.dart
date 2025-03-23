import 'package:flutter/material.dart';

extension XTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineSmall => textTheme.headlineSmall;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelMediumHint => labelMedium?.copyWith(color: hintColor);
  ColorScheme get colorScheme => theme.colorScheme;
  Color get hintColor => theme.hintColor;
  Color get primary => colorScheme.primary;
  Color get surface => colorScheme.surface;
}
