import 'package:get_it/get_it.dart';
import 'package:notes/database/firebase_database.dart';
import 'package:notes/services/database.dart';
import 'package:notes/services/firebase_auth_service.dart';
import 'package:notes/services/firebase_database_service.dart';
import 'package:notes/services/navigation_service.dart';
import 'package:notes/services/sqlite_database_service.dart';
import 'package:notes/viewModels/edit_note_viewModel.dart';

GetIt locator = GetIt.instance;
const bool USE_FIREBASE_DATABASE = true;

void setUpLocator() {
  locator.registerLazySingleton<Database>(() =>
      USE_FIREBASE_DATABASE ? FirebaseDatabaseService() : SqliteDatabaseService());
  locator.registerLazySingleton<FirebaseDatabase>(() => FirebaseDatabase());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => EditNoteViewModel());

}
