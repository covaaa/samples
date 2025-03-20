import 'dart:ui';

final class LocaleEn extends SealedLocale {
  const LocaleEn() : super._(code);
  static const code = 'en';
}

final class LocaleJa extends SealedLocale {
  const LocaleJa() : super._(code);
  static const code = 'ja';
}

sealed class SealedLocale extends Locale {
  factory SealedLocale(Locale locale) => switch (locale.languageCode) {
    LocaleJa.code => const LocaleJa(),
    String() => const LocaleEn(),
  };
  const SealedLocale._(super.languageCode);
}
