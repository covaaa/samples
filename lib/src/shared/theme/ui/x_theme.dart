import 'package:flutter/material.dart';

extension XTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get titleLarge => textTheme.titleLarge;
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get bodyLargeHint => bodyLarge?.copyWith(color: hintColor);
  Color get hintColor => theme.hintColor;
}
