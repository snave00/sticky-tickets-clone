import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../modules/di/injection.dart' as di;
import '../modules/firebase/firebase_options.dart';

Future<void> initDependencies() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await _setOrientation();

  // * init get_it service locator / dependency injection
  await di.init();

  // * wait it so sl<SharedPreferences>() will work on initIsar() properly
  await di.sl.allReady();

  // * initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // * init isar local db
  // await IsarDatabaseService().initIsar();

  // * initialize bloc observer
  // Bloc.observer = AppBlocObserver();

  // removeSplash();
}

Future<void> _setOrientation() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

/// * You can move me somewhere that make sense :)
/// - after all dependencies were loaded
void removeSplash() {
  FlutterNativeSplash.remove();
}
