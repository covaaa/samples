import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samples/src/shared/locale/locale.dart';
part 'read.g.dart';

@riverpod
class ReadLocale extends _$ReadLocale {
  @override
  SealedLocale? build() => null;
  SealedLocale syncEn() => state = const LocaleEn();
  SealedLocale syncJa() => state = const LocaleJa();
}
