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
    apiKey: 'AIzaSyDkx3p82oa6K8YfTIQK2p0wn01IHn5VeQg',
    appId: '1:150413073829:web:5da77cbc2dc1af049adc4c',
    messagingSenderId: '150413073829',
    projectId: 'electech-ee213',
    authDomain: 'electech-ee213.firebaseapp.com',
    databaseURL: 'https://electech-ee213-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'electech-ee213.appspot.com',
    measurementId: 'G-6MSR80WKV9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBmxtk1X3mD0kMw4yXxOfJWjK470MqVao',
    appId: '1:150413073829:android:ca0b1a670b160e1a9adc4c',
    messagingSenderId: '150413073829',
    projectId: 'electech-ee213',
    databaseURL: 'https://electech-ee213-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'electech-ee213.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD36Pgd_ZQkyx36FzWi66vOH9dxzPxLHcE',
    appId: '1:150413073829:ios:e82592d3c53edeb99adc4c',
    messagingSenderId: '150413073829',
    projectId: 'electech-ee213',
    databaseURL: 'https://electech-ee213-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'electech-ee213.appspot.com',
    androidClientId: '150413073829-grst0934v9hmn6sh5lqt6ojabntdetrf.apps.googleusercontent.com',
    iosClientId: '150413073829-1br43bbvtm3q477eplrq3jattkm870j6.apps.googleusercontent.com',
    iosBundleId: 'com.example.electech',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD36Pgd_ZQkyx36FzWi66vOH9dxzPxLHcE',
    appId: '1:150413073829:ios:e82592d3c53edeb99adc4c',
    messagingSenderId: '150413073829',
    projectId: 'electech-ee213',
    databaseURL: 'https://electech-ee213-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'electech-ee213.appspot.com',
    androidClientId: '150413073829-grst0934v9hmn6sh5lqt6ojabntdetrf.apps.googleusercontent.com',
    iosClientId: '150413073829-1br43bbvtm3q477eplrq3jattkm870j6.apps.googleusercontent.com',
    iosBundleId: 'com.example.electech',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDkx3p82oa6K8YfTIQK2p0wn01IHn5VeQg',
    appId: '1:150413073829:web:2b9371fe66a356589adc4c',
    messagingSenderId: '150413073829',
    projectId: 'electech-ee213',
    authDomain: 'electech-ee213.firebaseapp.com',
    databaseURL: 'https://electech-ee213-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'electech-ee213.appspot.com',
    measurementId: 'G-VWQLFEHC6M',
  );

}