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
    apiKey: 'AIzaSyC9tslPlX6Z_KdLonpSaPFK40iLJhu17J4',
    appId: '1:926370175097:web:e148d663a2c3c4bea5dca8',
    messagingSenderId: '926370175097',
    projectId: 'tasks-organizer-92d6a',
    authDomain: 'tasks-organizer-92d6a.firebaseapp.com',
    storageBucket: 'tasks-organizer-92d6a.firebasestorage.app',
    measurementId: 'G-NL0ZLQCQJK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9dgvMytDp0LSwjSJU-2sQt6QmxdyqYTI',
    appId: '1:926370175097:android:85c3f22ef94eb652a5dca8',
    messagingSenderId: '926370175097',
    projectId: 'tasks-organizer-92d6a',
    storageBucket: 'tasks-organizer-92d6a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAL7szcrYYMYdADg93IS39nSOnE_sq0I8I',
    appId: '1:926370175097:ios:1656b281ab808b11a5dca8',
    messagingSenderId: '926370175097',
    projectId: 'tasks-organizer-92d6a',
    storageBucket: 'tasks-organizer-92d6a.firebasestorage.app',
    iosBundleId: 'com.example.testTask',
  );
}
