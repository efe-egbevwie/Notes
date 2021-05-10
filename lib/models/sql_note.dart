import 'dart:math';
import '../constants.dart';

class Note {


  final int id;
  final String title;
  final String description;
  final DateTime timeCreated;

  const Note({
    this.id,
    this.title,
    this.description,
    this.timeCreated
});

  Note copyWith({
    int id,
    String title,
    String description,
    DateTime timeCreated,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (title == null || identical(title, this.title)) &&
        (description == null || identical(description, this.description)) &&
        (timeCreated == null || identical(timeCreated, this.timeCreated))) {
      return this;
    }

    return new Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timeCreated: timeCreated ?? this.timeCreated,
    );
  }

  static Note fromJson(Map<String, Object> json) {
    return Note(
      id: json[DatabaseColumnNames.id] as int,
      title: json[DatabaseColumnNames.title] as String,
      description: json[DatabaseColumnNames.description] as String,
      timeCreated: DateTime.parse(json[DatabaseColumnNames.timeCreated] as String),
    );
  }

  Map<String, Object> toJson() => {
   DatabaseColumnNames.id: generateNoteId(),
    DatabaseColumnNames.title: title,
    DatabaseColumnNames.description: description,
    DatabaseColumnNames.timeCreated: timeCreated.toIso8601String(),
  };

  int generateNoteId() {
    var randomGenerator = Random.secure();
    var noteId = List.generate(12, (_) => randomGenerator.nextInt(1000000000));
    return noteId.first;
  }



}