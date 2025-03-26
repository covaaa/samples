import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:samples/src/features/fln/fln.dart';
import '../../../../extensions/pump.dart';
import '../infra/fln_service_test.dart';

void main() {
  late MockFLNService mockFLNService;

  setUp(() {
    mockFLNService = MockFLNService();
    registerFallbackValue(FLN.updatable());
  });

  Future<void> mockCreateUpdatable() {
    return mockFLNService.createUpdatable(any(that: isA<FLN>()));
  }

  group('fln updatable card', () {
    testWidgets('should show notification', (tester) async {
      when(mockCreateUpdatable).thenAnswer((_) async {});
      await tester.pumpApp(
        overrides: [flnServiceProvider.overrideWithValue(mockFLNService)],
        child: const FLNUpdatableCard(),
      );
      await tester.tap(find.byType(FilledButton));
      verify(mockCreateUpdatable).called(1);
    });
  });
}
