import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:samples/src/features/fln/fln.dart';
import 'package:timezone/data/latest.dart';
import '../../../../extensions/binding.dart';

class MockFLNService extends Mock implements FLNService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TestDefaultBinaryMessengerBinding binding;
  late DateTime date;
  late FLN hello;
  late FLN scheduled;
  late FLN updatable;
  late ProviderContainer container;
  late FLNService service;

  setUp(() {
    binding = TestDefaultBinaryMessengerBinding.instance
      ..setUpFakeTimezone()
      ..setUpFakeLocalNotifications();
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    initializeTimeZones();
    date = DateTime.now().add(const Duration(minutes: 1));
    hello = FLN.hello();
    scheduled = FLN.scheduled(date);
    updatable = FLN.updatable();
    container = ProviderContainer();
    service = container.read(flnServiceProvider);
  });

  tearDown(() {
    container.dispose();
    debugDefaultTargetPlatformOverride = null;
    binding.setUpNull();
  });

  group('fln service', () {
    test(
      'should get props',
      () => expect(service.props, [isA<FLNPlatformAndroid>()]),
    );

    test(
      'should initialize platform',
      () => expect(service.initialize(), completion(isA<void>())),
    );

    test(
      'should create fln',
      () => expect(service.create(hello), completion(isA<void>())),
    );

    test(
      'should create scheduled fln',
      () => expect(service.createScheduled(scheduled), completion(isA<void>())),
    );

    test(
      'should update fln',
      () => expect(service.createUpdatable(updatable), completion(isA<void>())),
    );
  });
}
