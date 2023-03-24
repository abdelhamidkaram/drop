import 'package:dio/dio.dart';
import 'package:dropeg/core/api/api_cosumer.dart';
import 'package:dropeg/core/api/dio_consumer.dart';
import 'package:dropeg/core/map_services/location_helper.dart';
import 'package:dropeg/core/network/network_info.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/features/auth/data/datasources/remote_data/login_remote_data_source.dart';
import 'package:dropeg/features/auth/data/datasources/remote_data/register_remote_data_source.dart';
import 'package:dropeg/features/auth/data/repositories/compounds_repository_impl.dart';
import 'package:dropeg/features/auth/data/repositories/login_repository_imp.dart';
import 'package:dropeg/features/auth/data/repositories/profile_repositry_impl.dart';
import 'package:dropeg/features/auth/data/repositories/register_repository_imp.dart';
import 'package:dropeg/features/auth/domain/repositories/login_repository.dart';
import 'package:dropeg/features/auth/domain/repositories/profile_repositry.dart';
import 'package:dropeg/features/auth/domain/usecase/register_usecase.dart';
import 'package:dropeg/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:dropeg/features/home/features/services/data/data_source/remote_data/services_remote_datasource.dart';
import 'package:dropeg/features/home/features/services/data/repository/services_repository_impl.dart';
import 'package:dropeg/features/home/features/services/domain/repository/service_repository.dart';
import 'package:dropeg/features/home/features/services/data/data_source/local_data/services_local_datasource.dart';
import 'package:dropeg/features/home/features/services/domain/usecase/serviec_usecase.dart';
import 'package:dropeg/features/payment/presentation/bloc/payment_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/app_interceptors.dart';
import 'features/auth/data/datasources/local_data/car_local_data_source.dart';
import 'features/auth/data/datasources/local_data/compound_local_data_source.dart';
import 'features/auth/data/datasources/local_data/location_local_data_source.dart';
import 'features/auth/data/datasources/local_data/profile_local_data_source.dart';
import 'features/auth/data/datasources/remote_data/cars_remote_data_source.dart';
import 'features/auth/data/datasources/remote_data/componds_remote_data_source.dart';
import 'features/auth/data/datasources/remote_data/locations_remote_data_source.dart';
import 'features/auth/data/datasources/remote_data/profile_remote_data_source.dart';
import 'features/auth/data/repositories/car_repositry_impl.dart';
import 'features/auth/data/repositories/location_repository_impl.dart';
import 'features/auth/domain/repositories/car_repository.dart';
import 'features/auth/domain/repositories/compound_repository.dart';
import 'features/auth/domain/repositories/location_repository.dart';
import 'features/auth/domain/repositories/register_repository.dart';
import 'features/auth/domain/usecase/car_usecase.dart';
import 'features/auth/domain/usecase/compound_usecase.dart';
import 'features/auth/domain/usecase/locations_usecase.dart';
import 'features/auth/domain/usecase/login_usecase.dart';
import 'features/auth/domain/usecase/profile_usecase.dart';
import 'features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'features/auth/presentation/screens/register/register_compound/bloc/compound_register_cuibt.dart';
import 'features/home/bloc/home_cubit.dart';

final sl = GetIt.instance;

Future<void> initAppModule() async {
  /// ---------------------core

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

  /// ---------------external

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        error: true,
        responseHeader: true,
      ));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LocationHelper());
}

Future initLoginModule() async {
  // blocs

  sl.registerFactory(() => AuthCubit(
        appPreferences: sl(),
        getRegisterWithEmail: sl(),
        getRegisterWithFaceBook: sl(),
        getRegisterWithGoogle: sl(),
        getLoginWithEmail: sl(),
      ));
  sl.registerFactory(() => CompoundCubit(
        addCompoundToUserUseCase: sl(),
        getCompoundUseCase: sl(),
      ));
  sl.registerFactory(() => ProfileCubit(
        getCompoundUseCases: sl(),
        carsUseCase: sl(),
        locationUseCase: sl(),
        appPreferences: sl(),
        getProfileUseCase: sl(),
      ));

  sl.registerFactory(() => PaymentCubit(dioConsumer: sl<DioConsumer>()));

  // use cases

  sl.registerLazySingleton(() => GetRegisterWithEmail(
          registerRepository: RegisterRepositoryImpl(
        networkInfo: sl(),
        registerRemoteDataSource: sl(),
      )));
  sl.registerLazySingleton(() => GetRegisterWithFaceBook(sl()));
  sl.registerLazySingleton(() => GetRegisterWithGoogle(sl()));
  sl.registerLazySingleton(() => GetLoginWithEmail(loginRepository: sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(profileRepository: sl()));
  sl.registerLazySingleton(() => LocationUseCase(locationRepository: sl()));
  sl.registerLazySingleton(() => CarsUseCase(carsRepository: sl()));
  sl.registerLazySingleton(() => GetCompoundUseCase(compoundRepository: sl()));
  sl.registerLazySingleton(
      () => AddCompoundToUserUseCase(compoundRepository: sl()));

  // Repository

  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(
        networkInfo: sl(),
        registerRemoteDataSource: sl(),
      ));
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImp(loginRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
      networkInfo: sl(),
      profileRemoteDataSource: sl(),
      profileLocalDataSource: sl()));
  sl.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl(
      networkInfo: sl(),
      locationRemoteDataSource: sl(),
      locationsLocalDataSource: sl()));
  sl.registerLazySingleton<CarsRepository>(() => CarsRepositoryImpl(
      carsLocalDataSource: sl(),
      networkInfo: sl(),
      carsRemoteDataSource: sl()));
  sl.registerLazySingleton<CompoundRepository>(() => CompoundRepositoryImpl(
      compoundRemoteDataSource: sl(),
      networkInfo: sl(),
      compoundsLocalDataSource: sl()));

  // data Source

  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(sl<AppPreferences>()));
  sl.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl(sl<AppPreferences>()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl());
  sl.registerLazySingleton<LocationRemoteDataSource>(
      () => LocationRemoteDataSourceImpl());
  sl.registerLazySingleton<CarsRemoteDataSource>(
      () => CarsRemoteDataSourceImpl());
  sl.registerLazySingleton<CompoundRemoteDataSource>(
      () => CompoundRemoteDataSourceImpl());

  sl.registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<LocationsLocalDataSource>(
      () => LocationsLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CarsLocalDataSource>(
      () => CarsLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CompoundsLocalDataSource>(
      () => CompoundsLocalDataSourceImpl(sharedPreferences: sl()));
}

Future initHomeModule() async {
  if (!GetIt.I.isRegistered<HomeCubit>()) {
    //bloc
    sl.registerFactory<HomeCubit>(() => HomeCubit(
          serviceUseCase: sl(),
        ));
    //usecase
    sl.registerLazySingleton<ServiceUseCase>(
        () => ServiceUseCase(serviceRepository: sl<ServicesRepository>()));

    //repository
    sl.registerLazySingleton<ServicesRepository>(() => ServicesRepositoryImpl(
          remoteDataSource: sl<ServicesRemoteDataSource>(),
          localDataSource: sl<ServicesLocalDataSource>(),
          networkInfo: sl<NetworkInfo>(),
          appPreferences: sl<AppPreferences>(),
        ));
    // data source
    sl.registerLazySingleton<ServicesLocalDataSource>(() =>
        ServicesLocalDataSourceImpl(
            sharedPreferences: sl<SharedPreferences>()));
    sl.registerLazySingleton<ServicesRemoteDataSource>(
        () => ServicesRemoteDataSourceImpl(
        ));
  

  
  }


}
