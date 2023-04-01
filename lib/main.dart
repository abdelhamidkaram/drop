import 'package:bloc/bloc.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/features/auth/domain/entities/user.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'bloc_observer.dart';
import 'firebase_options.dart';
import 'core/shared_prefs/app_prefs.dart';
import 'injection_container.dart' as di;

String token = '';
String uId = '';
UserDetails? userInfo;
String? imgUrl = userInfo?.photo;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) => Center(
    child:Container(
        color: AppColors.greyLight,
        child: Icon(Icons.error , color: AppColors.red,)),
  );
  await di.initAppModule();
  await di.initLoginModule();
  await di.initHomeModule();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.sl<ProfileCubit>().getProfileDetails(isRefresh: true , firstbuild: true);
  AppPreferences appPreferences = AppPreferences(di.sl());
  token = await appPreferences.getToken();
  uId = await appPreferences.getUid();
  Bloc.observer = AppBlocObserver();
  runApp(const DropApp());

}
