import 'package:get_it/get_it.dart';
import 'package:notes/services/firebase_auth_service.dart';
import 'package:notes/services/sqlite_database_service.dart';
import 'package:notes/services/navigation_service.dart';



GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => SqliteDatabaseService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => NavigationService());
}

