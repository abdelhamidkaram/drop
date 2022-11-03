import 'dart:convert';

import 'package:dropeg/features/auth/domain/entities/compound.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/shared_prefs/prefs_keys.dart';

abstract class CompoundsLocalDataSource {
  Future<List<Compound>> getCompounds();
  Future<void> setCompoundsToCache(List<Compound> compounds );
}
 class CompoundsLocalDataSourceImpl implements CompoundsLocalDataSource {

   SharedPreferences sharedPreferences ;
   CompoundsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<Compound>> getCompounds() {
    final  cachedCompounds = sharedPreferences.getString(AppPrefsKes.cachedCompounds);
    if(cachedCompounds != null ){
      Map compoundsToMap = json.decode(cachedCompounds);
      List compounds =  compoundsToMap["result"] ;
      return Future.value(compounds.map((e) => Compound.formJson(e)).toList());
    }else {
      throw CacheException();
    }
  }

  @override
  Future<void> setCompoundsToCache(List<Compound> compounds) {

    return sharedPreferences.setString(AppPrefsKes.cachedCompounds , json.encode({"result" : compounds}));
  }

 }