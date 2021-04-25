import 'package:get_it/get_it.dart';
import 'package:todolist/services/database_service.dart';


GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => DatabaseService());
}

