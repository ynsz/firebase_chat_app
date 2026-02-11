import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final instance = SharedPrefService();

  late final SharedPreferences _prefs;
  final _uidKey = 'uid';

  Future<void> setPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setUid(String uid) async {
    _prefs.setString(_uidKey, uid);
  }

  String getUid() {
    return _prefs.getString(_uidKey) ?? '';
  }
}
