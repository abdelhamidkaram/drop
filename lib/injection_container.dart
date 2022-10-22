import 'package:dio/dio.dart';
import 'package:dropeg/core/api/api_cosumer.dart';
import 'package:dropeg/core/api/dio_consumer.dart';
import 'package:dropeg/core/map_services/location_helper.dart';
import 'package:dropeg/core/network/network_info.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/features/auth/data/datasources/remote_data/login_remote_data_source.dart';
import 'package:dropeg/features/auth/data/datasources/remote_data/register_remote_data_source.dart';
import 'package:dropeg/features/auth/data/repositories/login_repository_imp.dart';
import 'package:dropeg/features/auth/data/repositories/profile_repositry_impl.dart';
import 'package:dropeg/features/auth/data/repositories/register_repository_imp.dart';
import 'package:dropeg/features/auth/domain/repositories/login_repository.dart';
import 'package:dropeg/features/auth/domain/repositories/profile_repositry.dart';
import 'package:dropeg/features/auth/domain/usecase/register_usecase.dart';
import 'package:dropeg/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/app_interceptors.dart';
import 'features/auth/data/datasources/remote_data/profile_remote_data_source.dart';
import 'features/auth/domain/repositories/register_repository.dart';
import 'features/auth/domain/usecase/login_usecase.dart';
import 'features/auth/domain/usecase/profile_usecase.dart';
import 'features/auth/presentation/screens/register/register_compound/bloc/compound_register_cuibt.dart';

final sl = GetIt.instance;

Future<void> init() async {

  /// ---------------features

  // blocs

  sl.registerFactory(() => AuthCubit(
    appPreferences: sl() ,
        getRegisterWithEmail: sl(),
        getRegisterWithFaceBook: sl() ,
        getRegisterWithGoogle: sl(),
        getLoginWithEmail: sl(),
        getProfileUseCase: sl(),
      ));

  sl.registerFactory(() => CompoundCubit());

  // use cases

  sl.registerLazySingleton(() => GetRegisterWithEmail(registerRepository: RegisterRepositoryImpl(
    networkInfo: sl(),
    registerRemoteDataSource: sl(),
  )));
  sl.registerLazySingleton(() => GetRegisterWithFaceBook(sl()));
  sl.registerLazySingleton(() => GetRegisterWithGoogle(sl()));
  sl.registerLazySingleton(() => GetLoginWithEmail(loginRepository: sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(profileRepository: sl()));

  // Repository

  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(
        networkInfo: sl(),
        registerRemoteDataSource: sl(),
      ));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImp(loginRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(networkInfo:sl(), profileRemoteDataSource: sl() ,  ));

  // data Source

  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(sl<AppPreferences>()));
  sl.registerLazySingleton<RegisterRemoteDataSource>(() => RegisterRemoteDataSourceImpl(sl<AppPreferences>()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl());

  /// ---------------------core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

  /// ---------------------external
 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() =>  sharedPreferences );
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
    request: true ,
    requestBody: true,
    responseBody:true ,
    requestHeader: true,
    error: true,
     responseHeader: true,
  ));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LocationHelper());


}
