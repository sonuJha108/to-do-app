import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_app/data/provider/appwrite_provider.dart';
import 'package:todo_app/data/repository/auth_repository.dart';

final locator = GetIt.I;

void setUpLocator() {
  locator.registerLazySingleton(() => InternetConnectionChecker);

  locator.registerLazySingleton<AppwriteProvider>(() => AppwriteProvider());

  locator.registerLazySingleton<AuthRepository>(() => AuthRepository());
}
