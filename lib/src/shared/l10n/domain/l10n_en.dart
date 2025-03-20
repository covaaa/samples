// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get locale => 'English';

  @override
  String get language => 'Language';

  @override
  String get title => 'intl';

  @override
  String get done => 'done';

  @override
  String get increment => 'Increment';

  @override
  String get increment_title => 'You have pushed the button this many times:';

  @override
  String get increment_suffix => 'times';
}
