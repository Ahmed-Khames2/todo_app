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
    return Scaffold(
      body: widget.pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10.h), // رفعها شوية من تحت
        child: ConvexAppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          activeColor: Colors.white,
          color:
              Theme.of(
                context,
              ).bottomNavigationBarTheme.unselectedItemColor, // اللون الغير نشط
          height: 60.h,
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
