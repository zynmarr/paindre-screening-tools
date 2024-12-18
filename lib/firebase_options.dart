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
    apiKey: 'AIzaSyCyGADhg1Scvv3yKBCKxQ39xrSB0GbeK4Y',
    appId: '1:414832348965:web:fb49bc20cf955f5d4dd4cc',
    messagingSenderId: '414832348965',
    projectId: 'paindre-screening-tools',
    authDomain: 'paindre-screening-tools.firebaseapp.com',
    storageBucket: 'paindre-screening-tools.firebasestorage.app',
    measurementId: 'G-4B76819TG4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHtq3ijkoVxjVhEqgl-mlMHDc-g74-bH4',
    appId: '1:414832348965:android:53ca9df0ce10e91e4dd4cc',
    messagingSenderId: '414832348965',
    projectId: 'paindre-screening-tools',
    storageBucket: 'paindre-screening-tools.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXR4nN6nPuUdeaVNKflvqYJ6DzsPgO2vU',
    appId: '1:414832348965:ios:ac029738dffe2dc94dd4cc',
    messagingSenderId: '414832348965',
    projectId: 'paindre-screening-tools',
    storageBucket: 'paindre-screening-tools.firebasestorage.app',
    iosBundleId: 'com.paindreinnovation.screeningToolsAndroid',
  );

}