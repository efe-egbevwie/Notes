import 'package:notes/models/note.dart';
import 'package:notes/service_locator.dart';
import 'package:notes/services/database.dart';
import 'package:notes/viewModels/base_model.dart';

class NotesViewViewModel extends BaseModel{
  Database _database = locator<Database>();
  List<Note> notes;

  Future readNotes() async {
    setLoading(true);

    notes = await _database.readNotes();

    setLoading(false);
  }



}