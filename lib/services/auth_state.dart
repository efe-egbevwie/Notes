import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AuthState {
  final Preference<bool> authState;

  AuthState(StreamingSharedPreferences preferences)
      : authState = preferences.getBool('isSignedIn', defaultValue: false);
}
