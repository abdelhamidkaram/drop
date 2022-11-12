import 'dart:convert';
import 'package:dropeg/core/error/exception.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/core/shared_prefs/prefs_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/service_model.dart';

abstract class ServicesLocalDataSource {
  Future<List<ServiceModel>> getServices();
  Future<void> setServicesToCache(List<ServiceModel> services);
}

class ServicesLocalDataSourceImpl extends ServicesLocalDataSource {
  SharedPreferences sharedPreferences;
  ServicesLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final cachedServices =
          sharedPreferences.getString(AppPrefsKes.cachedServices);
      if (cachedServices != null) {
        Map servicesToMap = json.decode(cachedServices);
        List services = servicesToMap["result"];
        return services.map((e) => ServiceModel.fromJson(e)).toList();
      } else {
        throw CacheException();
      }
    } catch (e) {
      debugPrint(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> setServicesToCache(List<ServiceModel> services) {
    AppPreferences appPreferences = AppPreferences(sharedPreferences);
    appPreferences.setServicesCachedCreateTime(DateTime.now());
    return sharedPreferences.setString(AppPrefsKes.cachedServices,
        json.encode({"result": services.map((e) => e.toJson()).toList()}));
  }
}
