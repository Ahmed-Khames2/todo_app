import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  // 🟢 دالة عامة لإرسال إشعار بياخد الـ context علشان يسحب الـ Theme
  static NotificationDetails themedNotificationDetails(BuildContext context) {
    final theme = Theme.of(context);

    final androidDetails = AndroidNotificationDetails(
      'themed_channel',
      'Themed Notifications',
      channelDescription: 'Notifications that follow app theme',
      importance: Importance.max,
      priority: Priority.high,
      color: theme.colorScheme.primary, // 👈 لون الثيم الأساسي
      styleInformation: BigTextStyleInformation(
        theme.brightness == Brightness.dark
            ? 'Dark Mode Notification'
            : 'Light Mode Notification',
      ),
    );

    return NotificationDetails(android: androidDetails);
  }
}
