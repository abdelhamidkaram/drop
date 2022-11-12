import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'prefs_keys.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setOnBoardingScreenViewed() async {
    await _sharedPreferences.setBool(AppPrefsKes.onBoardingViewed, true);
    debugPrint(" preference : setOnBoardingScreenViewed  ");
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(AppPrefsKes.onBoardingViewed) ?? false;
  }

  //login

  Future<void> setUserLoggedIn() async {
    await _sharedPreferences.setBool(AppPrefsKes.login, true);
    debugPrint(" preference : setUserLoggedIn  ");
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(AppPrefsKes.login) ?? false;
  }

  //profileFristBuild

  Future<void> setProfileNotFirstBuild() async {
    await _sharedPreferences.setBool(AppPrefsKes.profileFristBuild, true);
    debugPrint(" preference : profileFristBuild  ");
  }

  Future<bool> isProfileNotFirstBuild() async {
    return _sharedPreferences.getBool(AppPrefsKes.profileFristBuild) ?? false;
  }

  //location

  Future<void> setLocationAdded() async {
    await _sharedPreferences.setBool(AppPrefsKes.locationAdd, true);
    debugPrint(" preference : setLocationAdded ");
  }

  Future<bool> isLocationAdded() async {
    return _sharedPreferences.getBool(AppPrefsKes.locationAdd) ?? false;
  }

// token

  Future<void> setToken(String token) async {
    await _sharedPreferences.setString(AppPrefsKes.token, token);
    debugPrint(" preference : set token   ");
  }

  Future<String> getToken() async {
    return _sharedPreferences.getString(AppPrefsKes.token) ?? "";
  }

// uid

  Future<void> setUid(String uid) async {
    await _sharedPreferences.setString(AppPrefsKes.uid, uid);
    debugPrint(" preference : set uid  ");
  }

  Future<String> getUid() async {
    return _sharedPreferences.getString(AppPrefsKes.uid) ?? "";
  }

// setServicesCachedCreateTime

  Future<void> setServicesCachedCreateTime(DateTime createCacheTime) async {
    await _sharedPreferences.setString(
        AppPrefsKes.servicesCachedExpired, createCacheTime.toString());
    debugPrint(" preference : set services cached expired ");
  }

  Future<bool> isServicesCachedExpired() async {
    String? createTime =
        _sharedPreferences.getString(AppPrefsKes.servicesCachedExpired);
    if (createTime != null) {
      int hours =
          DateTime.now().toUtc().difference(DateTime.parse(createTime)).inHours;
      if (hours < 24) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

// log out

  Future<void> logout() async {
    await _sharedPreferences.remove(AppPrefsKes.login);
    await _sharedPreferences.remove(AppPrefsKes.token);
    await _sharedPreferences.remove(AppPrefsKes.uid);
    debugPrint(" preference : remove data for log out  ");
  }

// log in

  Future<void> loginAllCache(String token, String uid) async {
    await setToken(token);
    await setUid(uid);
    await setUserLoggedIn();
  }

// delete Locations , cara , compounds

  Future<void> deleteUserDetailsAndLogOut() async {
    await logout();
    await _sharedPreferences.remove(AppPrefsKes.cachedCompounds);
    await _sharedPreferences.remove(AppPrefsKes.cachedLocations);
    await _sharedPreferences.remove(AppPrefsKes.cachedCars);
    await _sharedPreferences.remove(AppPrefsKes.cachedProfileDetails);
    await _sharedPreferences.remove(AppPrefsKes.profileFristBuild);
  }

  Future<void> deleteUserDetailsAndNotLogOut() async {
    await _sharedPreferences.remove(AppPrefsKes.cachedCompounds);
    await _sharedPreferences.remove(AppPrefsKes.cachedLocations);
    await _sharedPreferences.remove(AppPrefsKes.cachedCars);
    await _sharedPreferences.remove(AppPrefsKes.cachedProfileDetails);
    await _sharedPreferences.remove(AppPrefsKes.profileFristBuild);
  }
}
