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
    apiKey: 'AIzaSyANTSsLa4h7h5d6pepj7t4SBuu2GV2WCPA',
    appId: '1:353378345989:web:74b8cec05a5bc7f2aee86c',
    messagingSenderId: '353378345989',
    projectId: 'myfirst-8c21a',
    authDomain: 'myfirst-8c21a.firebaseapp.com',
    storageBucket: 'myfirst-8c21a.appspot.com',
    measurementId: 'G-BCHCQ6LYHN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAP6KRMDwhoRktz1w1GDgamIJ6S2Kll9Lo',
    appId: '1:353378345989:android:1115cce282b8a196aee86c',
    messagingSenderId: '353378345989',
    projectId: 'myfirst-8c21a',
    storageBucket: 'myfirst-8c21a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpRMHOvumQXEUAON4c3IIDiTfghmCwrF8',
    appId: '1:353378345989:ios:dff39881b3556c65aee86c',
    messagingSenderId: '353378345989',
    projectId: 'myfirst-8c21a',
    storageBucket: 'myfirst-8c21a.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpRMHOvumQXEUAON4c3IIDiTfghmCwrF8',
    appId: '1:353378345989:ios:dff39881b3556c65aee86c',
    messagingSenderId: '353378345989',
    projectId: 'myfirst-8c21a',
    storageBucket: 'myfirst-8c21a.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyANTSsLa4h7h5d6pepj7t4SBuu2GV2WCPA',
    appId: '1:353378345989:web:6353667713d42eefaee86c',
    messagingSenderId: '353378345989',
    projectId: 'myfirst-8c21a',
    authDomain: 'myfirst-8c21a.firebaseapp.com',
    storageBucket: 'myfirst-8c21a.appspot.com',
    measurementId: 'G-NQMWVMF8ZL',
  );
}
