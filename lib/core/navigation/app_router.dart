import 'package:flutter/material.dart';
import 'package:todo_app/features/home/pages/home_page.dart';
import 'package:todo_app/features/layout/base_layout.dart';
import 'package:todo_app/features/settings/settings_page.dart';
import '../../features/tasks/pages/tasks_page.dart';

class AppRoutes {
  // أسماء الراوتات
  static const String layout = '/';

  // دالة إنشاء الراوت
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case layout:
        return MaterialPageRoute(
          builder: (_) => BaseLayout(
            pages: const [
              HomePage(),
              TasksPage(),
              SettingsPage(),
            ],
          ),
        );

      default:
        return _errorRoute("Route not found: ${settings.name}");
    }
  }

  // صفحة خطأ افتراضية لأي Route غير موجود
  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Route Error')),
        body: Center(child: Text(message)),
      ),
    );
  }
}
