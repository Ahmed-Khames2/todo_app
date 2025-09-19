import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/theme/app_theme.dart';
import 'package:todo_app/core/theme/bloc/theme_bloc.dart';
import 'package:todo_app/features/settings/widget/custom_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const SettingsAppBar(), // AppBar مخصص
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            AppTheme currentTheme = AppTheme.todoLight;
            if (state is LoadingThemeState) {
              currentTheme = state.appTheme;
            }

            return ListView.separated(
              itemCount: AppTheme.values.length,
              separatorBuilder: (_, __) => SizedBox(height: 18.h),
              itemBuilder: (context, index) {
                final itemAppTheme = AppTheme.values[index];
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
                            gradient: isSelected
                                ? LinearGradient(
                                    colors: [
                                      appThemeData[itemAppTheme]!.primaryColor,
                                      appThemeData[itemAppTheme]!.primaryColor
                                          // ignore: deprecated_member_use
                                          .withOpacity(0.7),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: isSelected ? null : theme.cardColor,
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
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
                                color: isSelected
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
                                    color: isSelected
                                        ? Colors.white
                                        : theme.textTheme.bodyMedium?.color,
                                    shadows: isSelected
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