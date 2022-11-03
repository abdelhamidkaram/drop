import 'dart:convert';
import 'package:dropeg/features/auth/domain/entities/car.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/shared_prefs/prefs_keys.dart';

abstract class CarsLocalDataSource {
  Future<List<Car>> getCars();
  Future<void> setCarsToCache(List<Car> cars );
}
class CarsLocalDataSourceImpl implements CarsLocalDataSource {

  SharedPreferences sharedPreferences ;
  CarsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<Car>> getCars() {
    final  cachedCars = sharedPreferences.getString(AppPrefsKes.cachedCars);
    if(cachedCars != null ){
      Map carsToMap = json.decode(cachedCars);
      List cars =  carsToMap["result"] ;
      return Future.value(cars.map((e) => Car.fromJson(e)).toList());
    }else {
      throw CacheException();
    }
  }

  @override
  Future<void> setCarsToCache(List<Car> cars) {
    return sharedPreferences.setString(AppPrefsKes.cachedCars , json.encode({"result":cars}));
  }

}