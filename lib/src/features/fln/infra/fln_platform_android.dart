part of 'fln_platform.dart';

typedef _AndroidPlugin = AndroidFlutterLocalNotificationsPlugin;

final class FLNPlatformAndroid extends FLNPlatformMobile {
  factory FLNPlatformAndroid(FlutterLocalNotificationsPlugin plugin) {
    const settings = AndroidInitializationSettings('@mipmap/ic_launcher');
    return FLNPlatformAndroid._(
      plugin.resolvePlatformSpecificImplementation<_AndroidPlugin>()!,
      settings: settings,
      details: AndroidNotificationDetails(
        'reminder_channel',
        'Reminder',
        channelDescription: 'Channel for reminder notifications',
        enableLights: true,
        priority: Priority.high,
        importance: Importance.high,
        visibility: NotificationVisibility.public,
        icon: settings.defaultIcon,
        color: Colors.deepPurple,
      ),
    );
  }

  const FLNPlatformAndroid._(
    this.plugin, {
    required this.details,
    required this.settings,
  }) : super._();

  final AndroidNotificationDetails details;
  final AndroidInitializationSettings settings;
  final AndroidFlutterLocalNotificationsPlugin plugin;

  @override
  List<Object> get props => [details, settings, plugin];

  @override
  Future<bool> _initializePlugin() => plugin.initialize(settings);

  @override
  Future<bool> _askPermission() async {
    return (await plugin.requestNotificationsPermission()) ?? false;
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
      scheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
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

extension on AndroidNotificationDetails {
  AndroidNotificationDetails toUpdatable() => AndroidNotificationDetails(
    channelId,
    channelName,
    channelDescription: channelDescription,
    enableLights: enableLights,
    priority: priority,
    importance: importance,
    visibility: visibility,
    icon: icon,
    color: color,
    // required for updatable notifications
    ongoing: true,
    // should not play sound on updates
    playSound: false,
    // show alert only on first notification
    onlyAlertOnce: true,
  );
}
