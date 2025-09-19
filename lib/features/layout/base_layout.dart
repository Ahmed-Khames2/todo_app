import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseLayout extends StatefulWidget {
  final List<Widget> pages;
  const BaseLayout({super.key, required this.pages});

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body:
          // AnimatedSwitcher(
          //   duration: const Duration(milliseconds: 400),
          //   transitionBuilder: (child, animation) {
          //     // Slide Animation
          //     final offsetAnimation = Tween<Offset>(
          //       begin: const Offset(0.2, 0.0),
          //       end: Offset.zero,
          //     ).animate(
          //       CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          //     );
          //     return SlideTransition(
          //       position: offsetAnimation,
          //       child: FadeTransition(opacity: animation, child: child),
          //     );
          //   },
          // child:
          widget.pages[_currentIndex],
      // ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: ConvexAppBar(
          backgroundColor: theme.colorScheme.primary,
          activeColor: Colors.white,
          color: theme.bottomNavigationBarTheme.unselectedItemColor,
          height: 55.h,
          curveSize: 70.r,
          style: TabStyle.react,
          items: const [
            TabItem(icon: Icons.home, title: 'الرئيسية'),
            TabItem(icon: Icons.task, title: 'المهام'),
            TabItem(icon: Icons.settings, title: 'الإعدادات'),
          ],
          initialActiveIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
