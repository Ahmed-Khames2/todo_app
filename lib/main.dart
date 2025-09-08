import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_constant.dart';
import 'package:todo_app/core/theme/app_theme.dart';
import 'package:todo_app/core/theme/bloc/theme_bloc.dart';
import 'package:todo_app/features/todo/presentation/pages/testpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BlocProvider(
      create: (context) => ThemeBloc()..add(GetCuurrentThemeEvent()),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            ThemeData lightTheme = appThemeData[AppTheme.todoLight]!;
            ThemeData darkTheme = appThemeData[AppTheme.todoDark]!;

            // تحديد themeMode حسب الـ Bloc
            ThemeMode themeMode = ThemeMode.system; // default
            if (state is LoadingThemeState) {
              themeMode = state.appTheme == AppTheme.todoLight
                  ? ThemeMode.light
                  : ThemeMode.dark;
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppConstants.appName,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              home: child,
            );
          },
        );
      },
      child: const SettingPage(), // مؤقتًا للتجربة
    );
  }
}
