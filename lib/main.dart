import 'package:flutter/material.dart';
import 'package:todolist/screens/notes_screen.dart';
import 'package:todolist/service_locator.dart';



import 'database/db.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
        accentColor: Colors.white,
      ),
      home: NotesScreen(),
    );
  }
}


