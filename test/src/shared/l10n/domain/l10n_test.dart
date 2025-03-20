import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/shared/l10n/l10n.dart';

void main() {
  test(
    'should reload',
    () => expect(L10n.delegate.shouldReload(L10n.delegate), isFalse),
  );

  test(
    'should lookup ja',
    () => expect(lookupL10n(const Locale('ja')), isA<L10nJa>()),
  );

  test(
    'should throw flutter error',
    () => expect(() => lookupL10n(const Locale('_')), throwsFlutterError),
  );
}
