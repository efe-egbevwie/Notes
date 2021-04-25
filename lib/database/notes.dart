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
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      timeCreated: DateTime.parse(json['timeCreated'] as String),
    );
  }

  Map<String, Object> toJson() => {
   'id': id,
    'title': title,
    'description': description,
    'timeCreated': timeCreated.toIso8601String(),
  };

  Map <String, dynamic> toMap () {
    Map<String, dynamic> map = {
    'name' : description
    };
    return map;
  }

  static Note fromMap (Map <String, dynamic> map) {
    return Note(
      id: map['id'],
      description: map['name']
    );
  }

}