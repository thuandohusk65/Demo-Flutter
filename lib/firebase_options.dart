// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyAVCOauricWN1jsbElHqgmFsyoFfwf9eKk',
    appId: '1:80378079468:web:536dd54262d8d885219dc9',
    messagingSenderId: '80378079468',
    projectId: 'fir-flutter-7d3a1',
    authDomain: 'fir-flutter-7d3a1.firebaseapp.com',
    storageBucket: 'fir-flutter-7d3a1.appspot.com',
    measurementId: 'G-V6RS1HPGQP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCw2ZBUESaRYUd5JVMcVA1yJ8DJtFbHjPg',
    appId: '1:80378079468:android:8067476c7b641ed6219dc9',
    messagingSenderId: '80378079468',
    projectId: 'fir-flutter-7d3a1',
    storageBucket: 'fir-flutter-7d3a1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrTpDzD_cSjks1xguHgPOwfnZCDJkyLxo',
    appId: '1:80378079468:ios:a985a592452ef1e2219dc9',
    messagingSenderId: '80378079468',
    projectId: 'fir-flutter-7d3a1',
    storageBucket: 'fir-flutter-7d3a1.appspot.com',
    androidClientId: '80378079468-3jcsro0moa8h2756cdcna35gkbqp9dg1.apps.googleusercontent.com',
    iosClientId: '80378079468-2unotbvdog40ipuftiut87hud2vc4gsn.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterProject',
  );
}
