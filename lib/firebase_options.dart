import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
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
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAp2l3jzUBRL2tQFIaKFOMvS_4Baln9IG8',
    appId: '1:1009083053499:android:ff5e8f39324acb7da3c09e',
    messagingSenderId: '1009083053499',
    projectId: 'paindre-screening-tools-d014e',
    storageBucket: 'paindre-screening-tools-d014e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAw44ddOCWnLzAm3_5muvwuiMuXUDtE-Lk',
    appId: '1:1009083053499:ios:9ab1436c1d046643a3c09e',
    messagingSenderId: '1009083053499',
    projectId: 'paindre-screening-tools-d014e',
    storageBucket: 'paindre-screening-tools-d014e.firebasestorage.app',
    androidClientId: '1009083053499-kuabpdmo5rmkivdfibv8j4h82h7kj0sn.apps.googleusercontent.com',
    iosClientId: '1009083053499-ipk8fq7e64aaukjtj7vm2jhc6u6denpn.apps.googleusercontent.com',
    iosBundleId: 'com.paindreinnovation.screeningTools',
  );

}