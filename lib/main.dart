import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/screens/notes_screen.dart';
import 'package:todolist/service_locator.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode,));
}


class MyApp extends StatefulWidget {
   AdaptiveThemeMode savedThemeMode = AdaptiveThemeMode.dark;

   MyApp({Key key, this.savedThemeMode}) : super(key: key);


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor:  Theme.of(context).primaryColor,
        ),
        iconTheme: IconThemeData(
          color:  Colors.white,
        )
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[700],
        scaffoldBackgroundColor: Colors.black,
      ),
      initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Notes',
        theme: theme,
        darkTheme: darkTheme,
        themeMode:ThemeMode.system ,
        debugShowCheckedModeBanner: false,
        home: NotesScreen(),
      ),
    );
  }
}
