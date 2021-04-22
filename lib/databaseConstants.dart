final String databaseTableName = 'notes';
final int databaseVersion = 1;

 final List<String> databaseQueryParameters = [
   'id', 'title', 'description', 'timeCreated'
 ];

class DatabaseColumnNames {
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String timeCreated = 'timeCreated';
}
