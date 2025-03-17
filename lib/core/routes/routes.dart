import 'package:go_router/go_router.dart';
import 'package:todo_app/core/routes/name_routes.dart';
import 'package:todo_app/features/splash/views/splash_view.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: "/",
    name: RoutesName.splash,
    builder: (context, state) => const SplashView(),
  ),
]);
