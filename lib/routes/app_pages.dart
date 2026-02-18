import 'package:gamified_todo_app/modules/auth/bindings/login_binding.dart';
import 'package:gamified_todo_app/modules/auth/screens/auth_gate_screen.dart';
import 'package:gamified_todo_app/modules/auth/screens/login_screen.dart';
import 'package:gamified_todo_app/modules/main/bindings/add_task_binding.dart';
import 'package:gamified_todo_app/modules/main/bindings/calendar_binding.dart';
import 'package:gamified_todo_app/modules/main/bindings/edit_task_binding.dart';
import 'package:gamified_todo_app/modules/main/bindings/home_binding.dart';
import 'package:gamified_todo_app/modules/main/bindings/main_binding.dart';
import 'package:gamified_todo_app/modules/main/bindings/profile_binding.dart';
import 'package:gamified_todo_app/modules/main/bindings/tasks_binding.dart';
import 'package:gamified_todo_app/modules/main/screens/add_task_screen.dart';
import 'package:gamified_todo_app/modules/main/screens/calendar_screen.dart';
import 'package:gamified_todo_app/modules/main/screens/edit_task_screen.dart';
import 'package:gamified_todo_app/modules/main/screens/home_screen.dart';
import 'package:gamified_todo_app/modules/main/screens/main_screen.dart';
import 'package:gamified_todo_app/modules/main/screens/profile_screen.dart';
import 'package:gamified_todo_app/modules/main/screens/tasks_screen.dart';
import 'package:gamified_todo_app/routes/app_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

final appPages = [
  GetPage(name: AppRoutes.authGate, page: () => const AuthGateScreen()),

  GetPage(
    name: AppRoutes.login,
    page: () => LoginScreen(),
    binding: LoginBinding(),
  ),

  GetPage(
    name: AppRoutes.main,
    page: () => MainScreen(),
    binding: MainBinding(),
    middlewares: [AuthMiddleware()],
  ),

  GetPage(
    name: AppRoutes.home,
    page: () => HomeScreen(),
    binding: HomeBinding(),
    middlewares: [AuthMiddleware()],
  ),

  GetPage(
    name: AppRoutes.calendar,
    page: () => CalendarScreen(),
    binding: CalendarBinding(),
    middlewares: [AuthMiddleware()],
  ),

  GetPage(
    name: AppRoutes.tasks,
    page: () => TasksScreen(),
    binding: TasksBinding(),
    middlewares: [AuthMiddleware()],
  ),

  GetPage(
    name: AppRoutes.profile,
    page: () => ProfileScreen(),
    binding: ProfileBinding(),
    middlewares: [AuthMiddleware()],
  ),

  GetPage(
    name: AppRoutes.addTask,
    page: () => AddTaskScreen(),
    binding: AddTaskBinding(),
  ),

  GetPage(
    name: AppRoutes.editTask,
    page: () => EdittaskScreen(),
    binding: EditTaskBinding(),
  ),
];
