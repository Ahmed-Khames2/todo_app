import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/theme/app_theme.dart';
import 'package:todo_app/core/theme/bloc/theme_bloc.dart';

/// صفحة الإعدادات لتغيير الثيم.
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إعدادات التطبيق',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          AppTheme currentTheme = AppTheme.todoLight; // default
          if (state is LoadingThemeState) {
            currentTheme = state.appTheme;
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: AppTheme.values.length,
            itemBuilder: (context, index) {
              final itemAppTheme = AppTheme.values[index];
              return RadioListTile<AppTheme>(
                value: itemAppTheme,
                groupValue: currentTheme,
                title: Center(
                  child: Text(
                    itemAppTheme.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      // fontFamily: 'me_quran',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                activeColor: appThemeData[itemAppTheme]!.primaryColor,
                onChanged: (AppTheme? value) {
                  if (value != null) {
                    context.read<ThemeBloc>().add(ChangeThemeEvent(value));
                  }
                },
                tileColor: appThemeData[itemAppTheme]!.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
