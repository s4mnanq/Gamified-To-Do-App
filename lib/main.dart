import 'package:flutter/material.dart';
import 'package:gamified_todo_app/core/network/dio_client.dart';
import 'package:get/get.dart';

import 'env/app_config.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment (dev or prod)
  const bool isProd = bool.fromEnvironment('dart.vm.product');
  await AppConfig.init(isProd: isProd);

  // Initialize Dio client
  await Get.putAsync(() => DioClient().init());

  runApp(const MyApp());
}
