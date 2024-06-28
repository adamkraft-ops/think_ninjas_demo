import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBiECQOE2ojr92216nVzYwn7fX7QuEqJyQ',
    appId: '1:554143801028:web:1a755359f7a68038183391',
    messagingSenderId: '554143801028',
    projectId: 'think-ninjas-app',
    authDomain: 'think-ninjas-app.firebaseapp.com',
    storageBucket: 'think-ninjas-app.appspot.com',
    measurementId: 'G-3LRM8TK256',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCdEau6roFmyPV4mchSog-UjaY9YPqlAk',
    appId: '1:554143801028:android:b670412646dfe985183391',
    messagingSenderId: '554143801028',
    projectId: 'think-ninjas-app',
    storageBucket: 'think-ninjas-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCeRwIo85RDO8odRL4sBWZNxKBVpVEMABo',
    appId: '1:554143801028:ios:2a37c1ed1c8ff34f183391',
    messagingSenderId: '554143801028',
    projectId: 'think-ninjas-app',
    storageBucket: 'think-ninjas-app.appspot.com',
    iosBundleId: 'com.example.thinkNinjasApp',
  );
}
