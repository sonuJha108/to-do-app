import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/Theme/app_theme.dart';
import 'package:todo_app/core/locators/locators.dart';
import 'package:todo_app/core/routes/routes.dart';
import 'package:todo_app/core/utils/app_string.dart';
import 'package:todo_app/features/auth/cubit/register_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => RegisterCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      theme: AppTheme.darkThemeMode,
      routerConfig: router,
    );
  }
}
