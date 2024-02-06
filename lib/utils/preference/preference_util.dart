import 'package:anime_red/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  static Future<bool> setInitialLaunch() async {
    final instance = await SharedPreferences.getInstance();
    instance.setBool(PreferenceConstants.isFirstLaunch, true);
    return true;
  }

  static Future<bool> getIsInitiallyLaunched() async {
    final instance = await SharedPreferences.getInstance();
    return (instance.getBool(PreferenceConstants.isFirstLaunch)) ?? false;
  }
}
