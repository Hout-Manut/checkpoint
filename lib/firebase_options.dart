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
    apiKey: 'AIzaSyCwTjy7ucAR0GuBtD9ANPiYQnLnwqwk0kk',
    appId: '1:499889547572:web:f1f080f57e1c2777a79d61',
    messagingSenderId: '499889547572',
    projectId: 'checkpoint-f3d21',
    authDomain: 'checkpoint-f3d21.firebaseapp.com',
    storageBucket: 'checkpoint-f3d21.firebasestorage.app',
    measurementId: 'G-CMV8YKPX0F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0lrmHx3LjzZ-i_nYSdChZ7k9Zis5y7jU',
    appId: '1:499889547572:android:00460c8e5ccbf4d5a79d61',
    messagingSenderId: '499889547572',
    projectId: 'checkpoint-f3d21',
    storageBucket: 'checkpoint-f3d21.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCj0OYjLoJYakL7SvfyHGHkyh1S93hBQgU',
    appId: '1:499889547572:ios:06c2ecf2adf0b180a79d61',
    messagingSenderId: '499889547572',
    projectId: 'checkpoint-f3d21',
    storageBucket: 'checkpoint-f3d21.firebasestorage.app',
    iosBundleId: 'com.example.checkpoint',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCj0OYjLoJYakL7SvfyHGHkyh1S93hBQgU',
    appId: '1:499889547572:ios:06c2ecf2adf0b180a79d61',
    messagingSenderId: '499889547572',
    projectId: 'checkpoint-f3d21',
    storageBucket: 'checkpoint-f3d21.firebasestorage.app',
    iosBundleId: 'com.example.checkpoint',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCwTjy7ucAR0GuBtD9ANPiYQnLnwqwk0kk',
    appId: '1:499889547572:web:a4072f590312b198a79d61',
    messagingSenderId: '499889547572',
    projectId: 'checkpoint-f3d21',
    authDomain: 'checkpoint-f3d21.firebaseapp.com',
    storageBucket: 'checkpoint-f3d21.firebasestorage.app',
    measurementId: 'G-0VW7XRY0LF',
  );
}