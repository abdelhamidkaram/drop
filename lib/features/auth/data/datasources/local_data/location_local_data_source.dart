import 'dart:convert';
import 'package:dropeg/core/error/exception.dart';
import 'package:dropeg/core/shared_prefs/prefs_keys.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocationsLocalDataSource {
  Future<List<LocationEntity>> getLocations();
  Future<void> setLocationsToCache(List<LocationEntity> locations );
}

class LocationsLocalDataSourceImpl implements LocationsLocalDataSource{

   SharedPreferences sharedPreferences ;
   LocationsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<LocationEntity>> getLocations() async {
    final  cachedLocations = sharedPreferences.getString(AppPrefsKes.cachedLocations);
    if(cachedLocations != null ){
      Map locationsToMap = json.decode(cachedLocations);
      List locations =  locationsToMap["result"] ;
      return Future.value(locations.map((e) => LocationEntity.formJson(e)).toList());
    }else {
      throw CacheException();
    }
  }

  @override
  Future<void> setLocationsToCache(List<LocationEntity> locations) {
    return sharedPreferences.setString(AppPrefsKes.cachedLocations, json.encode({"result":locations}));
  }

}
