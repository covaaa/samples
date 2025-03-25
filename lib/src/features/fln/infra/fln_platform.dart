import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samples/src/features/fln/domain/fln.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
part 'fln_platform.g.dart';
part 'fln_platform_android.dart';
part 'fln_platform_ios.dart';

@riverpod
FLNPlatform flnPlatform(Ref ref) => FLNPlatform();

sealed class FLNPlatformMobile extends FLNPlatform {
  const FLNPlatformMobile._() : super._();
  Future<void> _initializeTimezone() async {
    tz.initializeTimeZones();
    final name = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(name));
  }

  @override
  Future<void> initialize() async {
    await _initializeTimezone();
    await _initializePlugin();
  }
}

sealed class FLNPlatform extends Equatable {
  factory FLNPlatform() {
    final plugin = FlutterLocalNotificationsPlugin();
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => FLNPlatformAndroid(plugin),
      TargetPlatform.iOS => FLNPlatformIOS(plugin),
      _ => throw UnsupportedError('platform not supported: $plugin'),
    };
  }

  const FLNPlatform._();

  Future<bool> _initializePlugin();
  Future<bool> _askPermission();
  Future<void> _show(FLN fln);
  Future<void> _zonedSchedule(FLN fln);
  Future<void> _update(FLN fln);

  Future<void> initialize();

  Future<void> show(FLN fln) async {
    if (!await _askPermission()) return;
    return _show(fln);
  }

  Future<void> showScheduled(FLN fln) async {
    if (!await _askPermission()) return;
    return _zonedSchedule(fln);
  }

  Future<void> update(FLN fln) => _update(fln);
}
