// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDpLslEWoJkgwXNPJEus_0Pb005Hw4gCHg',
    appId: '1:713671850351:web:86eea38aab436bac3cd09a',
    messagingSenderId: '713671850351',
    projectId: 'sticky-tickets-dev',
    authDomain: 'sticky-tickets-dev.firebaseapp.com',
    storageBucket: 'sticky-tickets-dev.appspot.com',
    measurementId: 'G-8FF8CP72JG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6Z61egOpGkwASi4yabNmjyoovaEZjiuY',
    appId: '1:713671850351:android:5183657e9fd6343a3cd09a',
    messagingSenderId: '713671850351',
    projectId: 'sticky-tickets-dev',
    storageBucket: 'sticky-tickets-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGmTqn_AM4gigt5h6djsiosEsZ6Tr41_o',
    appId: '1:713671850351:ios:d6ab4c9f5bc6b4e03cd09a',
    messagingSenderId: '713671850351',
    projectId: 'sticky-tickets-dev',
    storageBucket: 'sticky-tickets-dev.appspot.com',
    iosBundleId: 'com.snave.stickyTicketsClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGmTqn_AM4gigt5h6djsiosEsZ6Tr41_o',
    appId: '1:713671850351:ios:2efc10b7e539c49a3cd09a',
    messagingSenderId: '713671850351',
    projectId: 'sticky-tickets-dev',
    storageBucket: 'sticky-tickets-dev.appspot.com',
    iosBundleId: 'com.example.evansTemplate',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDpLslEWoJkgwXNPJEus_0Pb005Hw4gCHg',
    appId: '1:713671850351:web:7488f4a76a6853713cd09a',
    messagingSenderId: '713671850351',
    projectId: 'sticky-tickets-dev',
    authDomain: 'sticky-tickets-dev.firebaseapp.com',
    storageBucket: 'sticky-tickets-dev.appspot.com',
    measurementId: 'G-Q3FZWPXS8D',
  );
}