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
    registerFallbackValue(
      FLN.scheduled(DateTime.now().add(const Duration(seconds: 5))),
    );
  });

  Future<void> mockCreateScheduled() {
    return mockFLNService.createScheduled(any(that: isA<FLN>()));
  }

  group('fln scheduled card', () {
    testWidgets('should show notification', (tester) async {
      when(mockCreateScheduled).thenAnswer((_) async {});
      await tester.pumpApp(
        overrides: [flnServiceProvider.overrideWithValue(mockFLNService)],
        child: const FLNScheduledCard(),
      );
      await tester.tap(find.byType(FilledButton));
      verify(mockCreateScheduled).called(1);
    });
  });
}
