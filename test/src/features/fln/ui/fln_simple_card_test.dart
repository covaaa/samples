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
    registerFallbackValue(FLN.hello());
  });

  Future<void> mockCreate() {
    return mockFLNService.create(any(that: isA<FLN>()));
  }

  group('fln simple card', () {
    testWidgets('should show notification', (tester) async {
      when(mockCreate).thenAnswer((_) async {});
      await tester.pumpApp(
        overrides: [flnServiceProvider.overrideWithValue(mockFLNService)],
        child: const FLNSimpleCard(),
      );
      await tester.tap(find.byType(FilledButton));
      verify(mockCreate).called(1);
    });
  });
}
