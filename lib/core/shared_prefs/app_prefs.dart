import 'package:shared_preferences/shared_preferences.dart';
import 'prefs_keys.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  // Future<String> getAppLanguage() async {
  //   String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
  //   if (language != null && language.isNotEmpty) {
  //     return language;
  //   } else {
  //     // return default lang
  //     return LanguageType.ENGLISH.getValue();
  //   }
  // }

  // Future<void> changeAppLanguage() async {
  //   String currentLang = await getAppLanguage();
  //
  //   if (currentLang == LanguageType.ARABIC.getValue()) {
  //     // set english
  //     _sharedPreferences.setString(
  //         PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
  //   } else {
  //     // set arabic
  //     _sharedPreferences.setString(
  //         PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
  //   }
  // }

  // Future<Locale> getLocal() async {
  //   String currentLang = await getAppLanguage();
  //
  //   if (currentLang == LanguageType.ARABIC.getValue()) {
  //     return ARABIC_LOCAL;
  //   } else {
  //     return ENGLISH_LOCAL;
  //   }
  // }

  // on boarding

  Future<void> setOnBoardingScreenViewed() async {
    await _sharedPreferences.setBool(AppPrefsKes.onBoardingViewed, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(AppPrefsKes.onBoardingViewed) ?? false;
  }

  //login

  Future<void> setUserLoggedIn() async {
    await _sharedPreferences.setBool(AppPrefsKes.login, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(AppPrefsKes.login) ?? false;
  }

// token

  Future<void> setToken(String token) async {
    await _sharedPreferences.setString(AppPrefsKes.token, token);
  }

  Future<String> getToken() async {
    return _sharedPreferences.getString(AppPrefsKes.token) ?? "";
  }

// uid

  Future<void> setUid(String uid ) async {
    await _sharedPreferences.setString(AppPrefsKes.uid, uid);
  }

  Future<String > getUid() async {
    return _sharedPreferences.getString(AppPrefsKes.uid) ?? "";
  }

// log out

  Future<void> logout() async {
    await _sharedPreferences.remove(AppPrefsKes.login);
    await _sharedPreferences.remove(AppPrefsKes.token);
    await _sharedPreferences.remove(AppPrefsKes.uid);
  }

// log in

  Future<void> loginAllCache(String token , String uid) async {
    await setToken(token);
    await setUid(uid);
    await setUserLoggedIn();
  }


}