import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/models/note.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({
    Key key,
    @required this.note,
    @required this.index,
  }):super(key: key);

  final Note note;
  final int index;



  @override
  Widget build(BuildContext context) {
    final color = cardColors[index % cardColors.length];
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMd().format(note.timeCreated),
              style: TextStyle(color: Colors.grey[800]),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              note.title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              note.description,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 15),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            )
          ],
        ),
      ),
    );
  }
}

double getMinHeight(int index) {
  switch (index % 4) {
    case 0:
      return 100;
    case 1:
      return 150;
    default:
      return 100;
  }
}

final cardColors = [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent,
  Colors.pinkAccent,
  Colors.orangeAccent,
  Colors.amberAccent,
  Colors.cyanAccent,
];
