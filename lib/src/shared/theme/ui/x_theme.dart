import 'package:flutter/material.dart';

extension XTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  ColorScheme get colorScheme => theme.colorScheme;
  Color get surface => colorScheme.surface;
}
