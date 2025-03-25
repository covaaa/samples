import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

extension TestDefaultBinaryMessengerBindingX
    on TestDefaultBinaryMessengerBinding {
  void setUpNull([
    List<MethodChannel> channels = const [
      MethodChannel('dexterous.com/flutter/local_notifications'),
      MethodChannel('flutter_timezone'),
    ],
  ]) {
    for (final channel in channels) {
      defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
    }
  }

  void setUpFakeLocalNotifications() {
    defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('dexterous.com/flutter/local_notifications'),
      (call) {
        final value = switch (call.method) {
          'initialize' => true,
          // for iOS
          'requestPermissions' => true,
          // for Android
          'requestNotificationsPermission' => true,
          'show' => <String, Object?>{},
          'cancel' => <String, Object?>{},
          'zonedSchedule' => <String, Object?>{},
          'pendingNotificationRequests' => <Map<String, Object?>>[],
          'getActiveNotifications' => <Map<String, Object?>>[],
          'getNotificationAppLaunchDetails' => null,
          String() => PlatformException(
            code: 'Unexpected method: ${call.method}',
          ),
        };
        return Future.value(value);
      },
    );
  }

  void setUpFakeTimezone() {
    defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('flutter_timezone'),
      (call) {
        final code = 'unexpected method: ${call.method}';
        final value = switch (call.method) {
          'getLocalTimezone' => 'Asia/Tokyo',
          String() => throw PlatformException(code: code),
        };
        return Future.value(value);
      },
    );
  }
}
