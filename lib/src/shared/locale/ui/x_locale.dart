import 'package:flutter/material.dart';
import 'package:samples/src/shared/locale/domain/locale.dart';

extension XLocale on BuildContext {
  SealedLocale get locale => SealedLocale(Localizations.localeOf(this));
}
