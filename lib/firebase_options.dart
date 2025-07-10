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
    apiKey: 'AIzaSyBXR4nN6nPuUdeaVNKflvqYJ6DzsPgO2vU',
    appId: '1:414832348965:ios:ac029738dffe2dc94dd4cc',
    messagingSenderId: '414832348965',
    projectId: 'paindre-screening-tools',
    storageBucket: 'paindre-screening-tools-d014e.firebasestorage.app',
    iosBundleId: 'com.paindreinnovation.screeningToolsAndroid',
  );
}
