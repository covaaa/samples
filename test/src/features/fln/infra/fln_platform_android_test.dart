import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/features/fln/fln.dart';
import 'package:timezone/data/latest.dart';
import '../../../../extensions/binding.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TestDefaultBinaryMessengerBinding binding;
  late DateTime date;
  late FLN hello;
  late FLN scheduled;
  late FLN updatable;
  late ProviderContainer container;
  late FLNPlatform platform;

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
    platform = container.read(flnPlatformProvider);
  });

  tearDown(() {
    container.dispose();
    debugDefaultTargetPlatformOverride = null;
    binding.setUpNull();
  });

  group('fln platform android', () {
    test(
      'should get props',
      () => expect(
        platform.props,
        equals([
          isA<AndroidNotificationDetails>(),
          isA<AndroidInitializationSettings>(),
          isA<AndroidFlutterLocalNotificationsPlugin>(),
        ]),
      ),
    );

    test(
      'should initialize timezone and plugin',
      () => expect(platform.initialize(), completion(isA<void>())),
    );

    test(
      'should show fln',
      () => expect(platform.show(hello), completion(isA<void>())),
    );

    test(
      'should show scheduled fln',
      () => expect(platform.showScheduled(scheduled), completion(isA<void>())),
    );

    test(
      'should update fln',
      () => expect(platform.update(updatable), completion(isA<void>())),
    );
  });
}
