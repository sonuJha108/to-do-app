import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_app/core/utils/storeage_service.dart';
import 'package:todo_app/data/provider/appwrite_provider.dart';
import 'package:todo_app/data/repository/auth_repository.dart';
import 'package:todo_app/data/repository/todo_repository.dart';

// Its the package of the get it packages
final locator = GetIt.I;

void setUpLocator() {
  // to check the network connections in the app.
  locator.registerLazySingleton(() => InternetConnectionChecker);

  // cloud functions in the app to read write and delete and update the data.
  locator.registerLazySingleton<AppwriteProvider>(() => AppwriteProvider());

  // auth-cation in the app.
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository());

  // store the sessions in the offline mode.
  locator.registerLazySingleton<StoreageService>(() => StoreageService());

  // to create the todo repository.
  locator.registerLazySingleton<TodoRepository>(() => TodoRepository());
}
