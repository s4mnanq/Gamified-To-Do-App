import 'package:flutter/material.dart';
import 'package:gamified_todo_app/routes/app_pages.dart';
import 'package:gamified_todo_app/routes/app_routes.dart';
import 'package:gamified_todo_app/theme/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      getPages: appPages,
      initialRoute: AppRoutes.authGate,
    );
  }
}
