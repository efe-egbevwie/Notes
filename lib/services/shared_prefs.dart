import 'package:notes/service_locator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SharedPrefs{
  static String isSignedInKey = 'isSignedIn';
  StreamingSharedPreferences _preferences = locator<StreamingSharedPreferences>();

  void setSignedIn(){
    _preferences.setBool(isSignedInKey, true);
  }

  void setSignedOut(){
    _preferences.setBool(isSignedInKey, false);
  }

  Preference getSignedInStatus() {
    return _preferences.getBool(isSignedInKey, defaultValue: false);
  }

}