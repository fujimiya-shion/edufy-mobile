import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys {
  userToken,
}

class PrefRepository {
  final SharedPreferences _preferences;
  const PrefRepository({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  String get userToken => _preferences.getString(PrefKeys.userToken.name) ?? '';
  Future<bool> setUserToken(String? token) => _preferences.setString(PrefKeys.userToken.name, token ?? '');  
}