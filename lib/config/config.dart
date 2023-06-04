import 'package:firebase_core/firebase_core.dart';

class Config {
  /// Prevents from object instantiation.
  Config._();

  /// Holds the 'Site Key' for the `Google reCAPTCHA v3` API .
  static const String siteKey = '6LdH5DghAAAAAOHerCVj3uUCwWCbke7NHvVPNZP3';

  /// Holds the 'Secret Key' for the `Google reCAPTCHA v3` API .
  static const String secretKey = '6LdH5DghAAAAAH7bDXO4AeDk1rnOu_Iga000dd_N';

  /// Holds the 'Verfication URL' for the `Google reCAPTCHA v3` API .
  static final verificationURL = Uri.parse('https://www.google.com/recaptcha/api/siteverify');

  static const FirebaseOptions webOptions = FirebaseOptions(
    apiKey: 'AIzaSyBcRqArOcVOV1yGzhFyB40JHkd62o9TisU',
    appId: '1:960448262830:web:3ed95b8161df59afc5f33f',
    messagingSenderId: '960448262830',
    projectId: 'axlerate-customer-portal',
    authDomain: 'axlerate-customer-portal.firebaseapp.com',
    storageBucket: 'axlerate-customer-portal.appspot.com',
    measurementId: 'G-DX2QLY0GEB',
  );
}
