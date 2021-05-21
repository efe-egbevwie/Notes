import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes/service_locator.dart';
import 'package:notes/services/auth_state.dart';
import 'package:notes/services/firebase_auth_service.dart';
import 'package:notes/services/navigation_service.dart';
import 'package:notes/ui/authenticationWrapper.dart';
import 'package:notes/ui/router.dart';
import 'package:notes/viewModels/notes_view_viewModel.dart';
import 'package:notes/viewModels/sign_in_viewModel.dart';
import 'package:notes/viewModels/sign_up_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  StreamingSharedPreferences _prefs = await StreamingSharedPreferences.instance;
  final authState = AuthState(_prefs);
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: false,
  );
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(
    savedThemeMode: savedThemeMode,
    authState: authState,
  ));
}

class MyApp extends StatefulWidget {
  AdaptiveThemeMode savedThemeMode = AdaptiveThemeMode.system;
  final AuthState authState;

  MyApp({Key key, this.savedThemeMode, this.authState}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => SignInViewModel()),
        ChangeNotifierProvider(create: (context) => NotesViewViewModel())
      ],
      child: PreferenceBuilder<bool>(
        preference: widget.authState.authState,
        builder: (context, snapshot) {
          return AdaptiveTheme(
            light: ThemeData(
                // scaffoldBackgroundColor: Colors.blue,
                brightness: Brightness.light,
                primarySwatch: Colors.blue,
                accentColor: Colors.white,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                textTheme: Theme.of(context).textTheme.apply(
                      displayColor: Colors.black,
                      bodyColor: Colors.black,
                    )),
            dark: ThemeData(
                brightness: Brightness.dark,
                primaryColor: Colors.grey[800],
                accentColor: Colors.purple,
                hintColor: Colors.purple,
                textTheme: Theme.of(context).textTheme.apply(
                      displayColor: Colors.white,
                      bodyColor: Colors.white,
                    ),
                iconTheme: IconThemeData(color: Theme.of(context).accentColor)),
            initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
            builder: (theme, darkTheme) => GetMaterialApp(
              title: 'Notes',
              theme: theme,
              navigatorKey: locator<NavigationService>().navigationKey,
              onGenerateRoute: RouteGenerator.generateRoute,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              home: AuthenticationWrapper(
                authState: widget.authState,
                key: UniqueKey(),
              ),
            ),
          );
        },
      ),
    );
  }
}
