import 'package:go_router/go_router.dart';
import 'package:todo_app/core/routes/name_routes.dart';
import 'package:todo_app/features/auth/views/login_page.dart';
import 'package:todo_app/features/auth/views/signin_page.dart';
import 'package:todo_app/features/splash/views/splash_view.dart';
import 'package:todo_app/features/todo/views/add_edit_todo_list.dart';
import 'package:todo_app/features/todo/views/todo_view.dart';

// using the go routes packages in the app
final GoRouter router = GoRouter(routes: [
  // Go route modules using its takes the 3 type path name of the routes and builder and create the main page path
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
  ),
  GoRoute(
    name: RoutesName.addTodo,
    path: '/add-todo',
    builder: (context, state) => const AddEditTodoList(),
  ),
]);
