import 'package:firebase_core/firebase_core.dart';

class DevConfig {
  /// Prevents from object instantiation.
  DevConfig._();

  /// Holds the 'Site Key' for the `Google reCAPTCHA v3` API .
  static const String siteKey = '6Le2aI0iAAAAAL-L9zdWkh3TSAYOfqzf_hCeOZV_';

  // /// Holds the 'Secret Key' for the `Google reCAPTCHA v3` API .
  // static const String secretKey = '6Le2aI0iAAAAAMW-b6PrncfxhZrDpmAzFM1YZ3N9';

  // /// Holds the 'Verfication URL' for the `Google reCAPTCHA v3` API .
  // static final verificationURL =
  //     Uri.parse('https://www.google.com/recaptcha/api/siteverify');

  static const FirebaseOptions webOptions = FirebaseOptions(
    apiKey: "AIzaSyAr4JxUrT-gQBq_gWtWFczfXInzXTlM2fI",
    authDomain: "axlerate-portal-dev.firebaseapp.com",
    projectId: "axlerate-portal-dev",
    storageBucket: "axlerate-portal-dev.appspot.com",
    messagingSenderId: "722126722783",
    appId: "1:722126722783:web:0437197fbd3a1ec254fb6a",
    measurementId: "G-YJN65CMZVF",
  );
}
