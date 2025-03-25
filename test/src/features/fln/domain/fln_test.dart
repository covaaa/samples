import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/features/fln/fln.dart';

void main() {
  group('fln', () {
    test(
      'should get props',
      () => expect(FLN.hello().props, [
        'Hello! 👋',
        'This is a simple notification',
        null,
      ]),
    );

    test('should copy with', () => expect(FLN.hello().copyWith(), FLN.hello()));
  });
}
