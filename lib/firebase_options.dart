// File generated manually based on google-services.json
// DO NOT EDIT — regenerate with `flutterfire configure` if you change your Firebase project.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions are not configured for web. '
        'Run `flutterfire configure` to add web support.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS. '
          'Run `flutterfire configure` to add iOS support.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhvepGyZtoEwhu6EPlRGjqHpScIABmkIo',
    appId: '1:685800893661:android:99cd320615019b77a13f34',
    messagingSenderId: '685800893661',
    projectId: 'mali-f5605',
    storageBucket: 'mali-f5605.firebasestorage.app',
  );
}
