final String databaseTableName = 'notes';
final int databaseVersion = 1;

 final List<String> databaseQueryParameters = [
   '_id', 'title', 'description', 'timeCreated'
 ];

class DatabaseColumnNames {
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String timeCreated = 'timeCreated';
}

class RouteNames {
  static const String notesView = 'notesView';
  static const String editNoteView = 'editNoteView';
  static const String noteDetailView = 'noteDetailView';
  static const String signInView = 'signInView';
  static const String signUpView = 'signUpView';
}
