import 'package:go_router/go_router.dart';
import 'package:todo_app/core/routes/name_routes.dart';
import 'package:todo_app/features/auth/views/login_page.dart';
import 'package:todo_app/features/auth/views/signin_page.dart';
import 'package:todo_app/features/splash/views/splash_view.dart';
import 'package:todo_app/features/todo/views/todo_view.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: "/",
    name: RoutesName.splash,
    builder: (context, state) => const SplashView(),
  ),
  GoRoute(
    name: RoutesName.login,
    path: "/login",
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    name: RoutesName.register,
    path: "/register",
    builder: (context, state) => const SigninPage(),
  ),
  GoRoute(
    name: RoutesName.todo,
    path: "/todo",
    builder: (context, state) => const TodoView(),
  )
]);
