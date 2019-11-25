import 'package:shared_preferences/shared_preferences.dart';

class PersistenceManager implements SettingsStorage, UserStorage {
  SharedPreferences _prefs;

  void init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  String get accessToken {
    return _prefs.getString(_ACCESS_TOKEN) ?? UserStorage.defaultAccessToken;
  }

  @override
  void setAccessToken(String token) async {
    await _prefs.setString(_ACCESS_TOKEN, token);
  }

  @override
  bool get isLoggedIn {
    return _prefs.getBool(_IS_LOGGED_IN) ?? UserStorage.defaultIsLoggedIn;
  }

  @override
  void setIsLoggedIn(bool value) async {
    await _prefs.setBool(_IS_LOGGED_IN, value);
  }

  @override
  Language get langauge {
    final langIndex = _prefs.getInt(_LANGUAGE);
    if (langIndex != null &&
        langIndex >= 0 &&
        langIndex <= Language.values.length) {
      return Language.values[langIndex];
    } else {
      return SettingsStorage.defaultLanguage;
    }
  }

  @override
  void setLanguage(Language lang) async {
    await _prefs.setInt(_LANGUAGE, lang.index);
  }

  static const _ACCESS_TOKEN = 'ACCESS_TOKEN';
  static const _IS_LOGGED_IN = 'IS_LOGGED_IN';
  static const _LANGUAGE = 'LANGUAGE';
}

abstract class UserStorage {
  static const defaultIsLoggedIn = false;
  bool get isLoggedIn;
  void setIsLoggedIn(bool value);

  static const String defaultAccessToken = null;
  String get accessToken;
  void setAccessToken(String token);
}

abstract class SettingsStorage {
  static const defaultLanguage = Language.UNSPECIFIED;
  Language get langauge;
  void setLanguage(Language language);
}

enum Language {
  ARABIC,
  ENGLISH,
  UNSPECIFIED,
}
