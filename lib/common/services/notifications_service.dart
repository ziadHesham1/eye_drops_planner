import 'dart:io' show Platform;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class NotificationsService {
  NotificationsService._();
  static final NotificationsService instance = NotificationsService._();

  static const _channelId = 'eye_drops_reminders';
  static const _channelName = 'Eye drop reminders';
  static const _channelDescription =
      'Reminders for scheduled eye drop doses.';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    tzdata.initializeTimeZones();
    try {
      final localName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localName));
    } catch (_) {
      // Fall back to UTC if the platform timezone lookup fails.
      tz.setLocalLocation(tz.getLocation('UTC'));
    }

    const androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: darwinInit),
    );

    _initialized = true;
  }

  Future<bool> requestPermissions() async {
    if (Platform.isIOS) {
      final ios = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      final granted = await ios?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
      return granted;
    }

    if (Platform.isAndroid) {
      final notif = await Permission.notification.request();
      // Exact-alarm permission is auto-granted < Android 12 and on most OEMs;
      // if the user denies it we still get inexact alarms.
      try {
        await Permission.scheduleExactAlarm.request();
      } catch (_) {}
      return notif.isGranted;
    }

    return true;
  }

  /// Stable id scheme so daily reschedules don't collide:
  ///   id = dayOfYear * 1000 + slotIndex
  static int idFor(DateTime day, int slotIndex) {
    final start = DateTime(day.year, 1, 1);
    final dayOfYear = day.difference(start).inDays + 1;
    return dayOfYear * 1000 + slotIndex;
  }

  Future<void> scheduleDrop({
    required int id,
    required String drug,
    required int drops,
    required DateTime when,
  }) async {
    if (!_initialized) return;
    if (when.isBefore(DateTime.now())) return;

    final scheduled = tz.TZDateTime.from(when, tz.local);

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final body = drops == 1 ? '1 drop' : '$drops drops';

    await _plugin.zonedSchedule(
      id,
      'Time for $drug',
      body,
      scheduled,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelAll() async {
    if (!_initialized) return;
    await _plugin.cancelAll();
  }
}
