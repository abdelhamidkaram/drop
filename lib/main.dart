import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'bloc_observer.dart';
import 'firebase_options.dart';
import 'core/shared_prefs/app_prefs.dart';
import 'injection_container.dart' as di ;
String token = '';
String uId = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  AppPreferences appPreferences = AppPreferences(di.sl());
  token = await appPreferences.getToken() ;
  uId = await appPreferences.getUid();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
  runApp(const DropApp());
}