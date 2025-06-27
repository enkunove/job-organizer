import 'package:shared_preferences/shared_preferences.dart';

class SettingsDatasource {
  static const _rememberMeKey = 'remember_me';

  Future<void> setRememberMe(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, value);
  }

  Future<bool> getRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }
}
