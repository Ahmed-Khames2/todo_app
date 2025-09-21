import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/theme/app_theme.dart';
import 'package:todo_app/core/theme/bloc/theme_bloc.dart';
import 'package:todo_app/features/settings/widget/custom_app_bar.dart';
import 'package:todo_app/core/services/notification_service.dart'; // استدعاء NotificationService

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const SettingsAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            AppTheme currentTheme = AppTheme.todoLight;
            if (state is LoadingThemeState) {
              currentTheme = state.appTheme;
            }

            // نضيف عنصر Notification كأول عنصر
            final notificationTile = ListTile(
              onTap: () {
                NotificationService().showNotification();
              },
              leading: const Icon(Icons.notifications),
              title: const Text('Notification repeated'),
              trailing: IconButton(
                onPressed: () {
                  NotificationService().cancelNotification(
                    0,
                  ); // نفس الـ id اللي استخدمته
                },
                icon: const Icon(Icons.cancel),
              ),
            );

            return ListView.separated(
              itemCount: AppTheme.values.length + 1, // زودنا 1 للـ notification
              separatorBuilder: (_, __) => SizedBox(height: 18.h),
              itemBuilder: (context, index) {
                if (index == 0)
                  return notificationTile; // Notification في أول عنصر

                final itemAppTheme = AppTheme.values[index - 1]; // باقي العناصر
                final isSelected = currentTheme == itemAppTheme;

                return TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 200),
                  tween: Tween(begin: 1.0, end: isSelected ? 1.05 : 1.0),
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: InkWell(
                        onTap: () {
                          context.read<ThemeBloc>().add(
                            ChangeThemeEvent(itemAppTheme),
                          );
                        },
                        borderRadius: BorderRadius.circular(20.r),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 18.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            gradient:
                                isSelected
                                    ? LinearGradient(
                                      colors: [
                                        appThemeData[itemAppTheme]!
                                            .primaryColor,
                                        appThemeData[itemAppTheme]!.primaryColor
                                            .withOpacity(0.7),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                    : null,
                            color: isSelected ? null : theme.cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6.r,
                                offset: Offset(0, 4.h),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                itemAppTheme == AppTheme.todoLight
                                    ? Icons.wb_sunny
                                    : Icons.nightlight_round,
                                color:
                                    isSelected
                                        ? Colors.white
                                        : theme.colorScheme.primary,
                                size: 26.sp,
                              ),
                              SizedBox(width: 14.w),
                              Expanded(
                                child: Text(
                                  itemAppTheme.name,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : theme.textTheme.bodyMedium?.color,
                                    shadows:
                                        isSelected
                                            ? [
                                              Shadow(
                                                offset: Offset(1.w, 1.h),
                                                blurRadius: 2.r,
                                                color: Colors.black45,
                                              ),
                                            ]
                                            : null,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 22.sp,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
