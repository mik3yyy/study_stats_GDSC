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
        return macos;
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
    apiKey: 'AIzaSyD0X-dLgxVAWEF5o3-1rriOtrZ5hBzRxqw',
    appId: '1:539900922405:web:917b3ec122d72d8e134dcc',
    messagingSenderId: '539900922405',
    projectId: 'studystat-3178c',
    authDomain: 'studystat-3178c.firebaseapp.com',
    storageBucket: 'studystat-3178c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVg0_G6fVmdxnOwgE2ku3xhhvjOHkf3zY',
    appId: '1:539900922405:android:a3b3aa1b0cde8aeb134dcc',
    messagingSenderId: '539900922405',
    projectId: 'studystat-3178c',
    storageBucket: 'studystat-3178c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCojb45QnE3kfw3-0-nTdDGicAXIXH0TKA',
    appId: '1:539900922405:ios:dc6a491b9671a1c4134dcc',
    messagingSenderId: '539900922405',
    projectId: 'studystat-3178c',
    storageBucket: 'studystat-3178c.appspot.com',
    iosBundleId: 'com.example.studyStats',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCojb45QnE3kfw3-0-nTdDGicAXIXH0TKA',
    appId: '1:539900922405:ios:524d64766276aa78134dcc',
    messagingSenderId: '539900922405',
    projectId: 'studystat-3178c',
    storageBucket: 'studystat-3178c.appspot.com',
    iosBundleId: 'com.example.studyStats.RunnerTests',
  );
}
