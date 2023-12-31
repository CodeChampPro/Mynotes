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
    apiKey: 'AIzaSyDPAS7GQx9oeP1O1IKyxPl7rKAXjkT5was',
    appId: '1:317030372746:web:a74b6aa134e8f860d12473',
    messagingSenderId: '317030372746',
    projectId: 'mynote-2-a5f5f',
    authDomain: 'mynote-2-a5f5f.firebaseapp.com',
    storageBucket: 'mynote-2-a5f5f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA9sUKhQIXW3vzjBxMmoRw5lgzlyyPkwO4',
    appId: '1:317030372746:android:e0fb2ae97bf06c45d12473',
    messagingSenderId: '317030372746',
    projectId: 'mynote-2-a5f5f',
    storageBucket: 'mynote-2-a5f5f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCemuybQumku4pIgqkpZYlPXf15bXrvMzY',
    appId: '1:317030372746:ios:56a26aacdb800419d12473',
    messagingSenderId: '317030372746',
    projectId: 'mynote-2-a5f5f',
    storageBucket: 'mynote-2-a5f5f.appspot.com',
    iosClientId: '317030372746-p3p505cvcdv9gpmet8nggpil43h00nhp.apps.googleusercontent.com',
    iosBundleId: 'com.example.mynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCemuybQumku4pIgqkpZYlPXf15bXrvMzY',
    appId: '1:317030372746:ios:be90f59a498e4d56d12473',
    messagingSenderId: '317030372746',
    projectId: 'mynote-2-a5f5f',
    storageBucket: 'mynote-2-a5f5f.appspot.com',
    iosClientId: '317030372746-u9gto6pbbqp4cam2rlao9uf4tuc24j8i.apps.googleusercontent.com',
    iosBundleId: 'com.example.mynotes.RunnerTests',
  );
}
