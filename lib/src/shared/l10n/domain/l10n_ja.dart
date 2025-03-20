// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get locale => '日本語';

  @override
  String get language => '言語';

  @override
  String get title => '国際化';

  @override
  String get done => '完了';

  @override
  String get increment => '増やす';

  @override
  String get increment_title => '何回ボタンを押したかというと...';

  @override
  String get increment_suffix => '回';
}
