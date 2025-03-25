import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:samples/src/shared/core/core.dart';

// For mocking ProviderBase
// ignore: subtype_of_sealed_class
class MockProvider extends Mock implements ProviderBase<Object?> {}

void main() {
  test('should observe', () {
    const RiverpodObserver()
      ..didAddProvider(MockProvider(), 0, ProviderContainer())
      ..didUpdateProvider(MockProvider(), 0, 1, ProviderContainer())
      ..didDisposeProvider(MockProvider(), ProviderContainer());
  });
}
