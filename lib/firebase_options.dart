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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAF1fs2qA9tgW8Ju_30ufeo766202QfKpA',
    appId: '1:675216732165:web:f9bfb99e9744d8c7b42c6c',
    messagingSenderId: '675216732165',
    projectId: 'fuel-price-tracker-9a2a7',
    authDomain: 'fuel-price-tracker-9a2a7.firebaseapp.com',
    storageBucket: 'fuel-price-tracker-9a2a7.firebasestorage.app',
    measurementId: 'G-0WVWPJ40D0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOyo3wIYdmdBq8Re1jejtwtr3SK66nheM',
    appId: '1:675216732165:android:eac6254466bc8dc9b42c6c',
    messagingSenderId: '675216732165',
    projectId: 'fuel-price-tracker-9a2a7',
    storageBucket: 'fuel-price-tracker-9a2a7.firebasestorage.app',
  );
}
