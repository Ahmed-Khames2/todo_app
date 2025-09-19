import 'package:flutter/material.dart';
import 'package:todo_app/features/home/home_page.dart';
import 'package:todo_app/features/layout/base_layout.dart';
import 'package:todo_app/features/settings/settings_page.dart';
import '../../features/tasks/tasks_page.dart';

class AppRoutes {
  static const String layout = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case layout:
        return _animatedRoute(
          BaseLayout(
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

  // هنا بتحكم في الأنيميشن
  static PageRouteBuilder _animatedRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Slide Animation من اليمين للشمال
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Route Error')),
        body: Center(child: Text(message)),
      ),
    );
  }
}
