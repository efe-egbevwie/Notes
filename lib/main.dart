import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/screens/notes_screen.dart';
import 'package:todolist/service_locator.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
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
      initial: AdaptiveThemeMode.dark,
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
