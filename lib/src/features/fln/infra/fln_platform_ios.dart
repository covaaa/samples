part of 'fln_platform.dart';

typedef _IOSPlugin = IOSFlutterLocalNotificationsPlugin;

final class FLNPlatformIOS extends FLNPlatformMobile {
  factory FLNPlatformIOS(FlutterLocalNotificationsPlugin plugin) {
    return FLNPlatformIOS._(
      plugin.resolvePlatformSpecificImplementation<_IOSPlugin>()!,
      details: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  const FLNPlatformIOS._(this.plugin, {required this.details}) : super._();

  final DarwinNotificationDetails details;
  final IOSFlutterLocalNotificationsPlugin plugin;

  @override
  List<Object> get props => [details, plugin];

  @override
  Future<bool> _initializePlugin() async {
    final initialized = await plugin.initialize(
      const DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    return initialized ?? false;
  }

  @override
  Future<bool> _askPermission() async {
    final permission = await plugin.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    return permission ?? false;
  }

  @override
  Future<void> _show(FLN fln) {
    return plugin.show(1, fln.title, fln.body, notificationDetails: details);
  }

  @override
  Future<void> _zonedSchedule(FLN fln) {
    return plugin.zonedSchedule(
      1,
      fln.title,
      fln.body,
      tz.TZDateTime.from(fln.date!, tz.local),
      details,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Future<void> _update(FLN fln) {
    return plugin.show(
      1,
      fln.title,
      fln.body,
      notificationDetails: details.toUpdatable(),
    );
  }
}

extension on DarwinNotificationDetails {
  DarwinNotificationDetails toUpdatable() => DarwinNotificationDetails(
    presentAlert: presentAlert,
    presentBadge: presentBadge,
    // should not play sound on updates
    presentSound: false,
  );
}
