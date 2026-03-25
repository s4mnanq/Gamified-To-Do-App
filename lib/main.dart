import 'package:flutter/material.dart';
import 'package:gamified_todo_app/core/network/dio_client.dart';
import 'package:gamified_todo_app/core/services/token_storage.dart';
import 'package:gamified_todo_app/repositories/auth_repository.dart';
import 'package:get/get.dart';
import 'package:shadow_log/shadow_log.dart';

import 'app.dart';
import 'env/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment (dev or prod)
  const bool isProd = bool.fromEnvironment('dart.vm.product');
  await AppConfig.init(isProd: isProd);

  // Initialize Dio client
  await Get.putAsync(() => DioClient().init());

  ShadowLog.configure(
    ShadowLogConfig(
      name: 'Gamified To-Do App',
      enabledInRelease: true,
      minLevel: isProd ? ShadowLogLevel.info : ShadowLogLevel.debug,
      formatter: const ShadowPrettyFormatter(),
      outputs: const <ShadowLogOutput>[
        ShadowDeveloperLogOutput(),
        ShadowDebugPrintOutput(),
      ],
    ),
  );

  Get.put(TokenStorage());
  Get.put(AuthRepository());

  runApp(const MyApp());
}
