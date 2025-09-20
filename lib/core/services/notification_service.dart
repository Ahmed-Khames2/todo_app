// lib/features/tasks/services/notification_service.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // === INIT: تهيئة المكتبة + ضبط التوقيت المحلي ===
  static Future<void> init() async {
    // 1. timezone init (ضروري للجدولة بدقة)
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo')); // أو أي لوكيشن حسب بلدك

    // 2. Android initialization settings
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    // 3. iOS initialization
    final iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final settings = InitializationSettings(android: androidInit, iOS: iosInit);

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        // handle notification tap
      },
    );

    // إنشاء قنوات أندرويد
    await _createAndroidChannels();
  }

  // === إنشاء قنوات أندرويد (channels) ===
  static Future<void> _createAndroidChannels() async {
    const taskChannel = AndroidNotificationChannel(
      'task_channel',
      'Task Notifications',
      description: 'Notifications for task reminders',
      importance: Importance.max,
    );

    const summaryChannel = AndroidNotificationChannel(
      'summary_channel',
      'Summary Notifications',
      description: 'Daily summary of tasks',
      importance: Importance.defaultImportance,
    );

    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(taskChannel);
      await androidPlugin.createNotificationChannel(summaryChannel);
    }
  }

  // === إشعار فوري للتجربة ===
  static Future<void> showTestNotification() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'task_channel',
        'Task Notifications',
        channelDescription: 'Channel for task reminders',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await _plugin.show(
      0,
      'Test Notification',
      'This is a test notification',
      details,
    );
  }

  // === جدولة إشعار في وقت محدد ===
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final tz.TZDateTime scheduled = tz.TZDateTime.from(scheduledDate, tz.local);

    // await _plugin.zonedSchedule(
    //   id,
    //   title,
    //   body,
    //   scheduled,
    //   const NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       'task_channel',
    //       'Task Notifications',
    //       channelDescription: 'Channel for task reminders',
    //       importance: Importance.max,
    //       priority: Priority.high,
    //     ),
    //     iOS: DarwinNotificationDetails(),
    //   ),
    //   androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime, // ✅ صح
    // );
  }

  // === جدولة إشعار متكرر يومياً ===
  static Future<void> scheduleDailySummary({
    required int id,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    // await _plugin.zonedSchedule(
    //   id,
    //   'ملخص اليوم',
    //   'تفاصيل إنجازاتك النهاردة',
    //   scheduled,
    //   const NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       'summary_channel',
    //       'Summary Notifications',
    //       channelDescription: 'Daily summary',
    //     ),
    //     iOS: DarwinNotificationDetails(),
    //   ),
    //   androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime,
    //   matchDateTimeComponents: DateTimeComponents.time,
    // );
  }

  // === إلغاء إشعار معين ===
  static Future<void> cancel(int id) async => _plugin.cancel(id);

  // === إلغاء كل الإشعارات ===
  static Future<void> cancelAll() async => _plugin.cancelAll();
}
