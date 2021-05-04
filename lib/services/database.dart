abstract class Database{
  Future createNote();

  Future readNotes();

  Future readNoteSingle();

  Future updateNote();

  Future deleteNote();
}