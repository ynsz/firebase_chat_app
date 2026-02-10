import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final instance = SharedPrefService();

  late final SharedPreferences _prefs;

  Future<void> setPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setUid(String uid) async {
    _prefs.setString('uid', uid);
  }
}