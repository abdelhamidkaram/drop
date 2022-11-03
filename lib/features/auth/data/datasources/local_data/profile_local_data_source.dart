import 'dart:convert';
import 'package:dropeg/core/error/exception.dart';
import 'package:dropeg/core/shared_prefs/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

abstract  class ProfileLocalDataSource {
  Future<UserDetailsModel> getProfileDetails();
  Future<void> setProfileDetailsToCache(UserDetailsModel userDetailsModel);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences sharedPreferences ;
  ProfileLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserDetailsModel> getProfileDetails() {
    final jsonString = sharedPreferences.getString(AppPrefsKes.cachedProfileDetails);
    if(jsonString !=null ){
      final cacheProfileDetails = UserDetailsModel.formJson(json.decode(jsonString));
      return Future.value(cacheProfileDetails);
    }else{
      throw CacheException();
    }
  }

  @override
  Future<void> setProfileDetailsToCache(UserDetailsModel userDetailsModel)  {
    return  sharedPreferences.setString(AppPrefsKes.cachedProfileDetails, json.encode(userDetailsModel.toJson()));
  }

}
