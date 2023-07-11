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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPKxF97eoEZhDI8EvHYCQkJb-wLJvx5DI',
    appId: '1:90008980506:android:a00a9ed810db68331d95a3',
    messagingSenderId: '90008980506',
    projectId: 'aquasol-coastal-flooding-sih',
    storageBucket: 'aquasol-coastal-flooding-sih.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDal8eZmYVbLRIyLYob_rcJ1Ss9H-qUUuI',
    appId: '1:90008980506:ios:7be2ef14e8d856f21d95a3',
    messagingSenderId: '90008980506',
    projectId: 'aquasol-coastal-flooding-sih',
    storageBucket: 'aquasol-coastal-flooding-sih.appspot.com',
    iosClientId: '90008980506-q71sb9niooafvqv07qmq3j8gr3nufcv1.apps.googleusercontent.com',
    iosBundleId: 'com.example.sih2023',
  );
}