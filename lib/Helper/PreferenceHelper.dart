import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoughts_creator/utils/PrefUtils.dart';

class PreferenceHelper {
  SharedPreferences prefs;

  PreferenceHelper(SharedPreferences prefs) {
    this.prefs = prefs;
  }


  void saveCounter(int counter) {
    prefs.setInt(PrefUtils.IS_COUNTER, counter);
  }

  int getCounter() {
    return prefs.getInt(PrefUtils.IS_COUNTER) ?? "";
  }


  void saveIsUserNew(bool isLoggedIn) {
    prefs.setBool(PrefUtils.IS_USERNEW, isLoggedIn);
  }

  bool getIsUserNew() {
    return prefs.getBool(PrefUtils.IS_USERNEW) ?? true;
  }


}
