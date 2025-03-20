import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/shared/l10n/l10n.dart';

void main() {
  late L10nJa l10n;

  setUp(() => l10n = L10nJa());

  test('should get values', () {
    expect(l10n.title, '国際化');
    expect(l10n.increment, '増やす');
    expect(l10n.increment_title, '何回ボタンを押したかというと...');
    expect(l10n.increment_suffix, '回');
  });
}
