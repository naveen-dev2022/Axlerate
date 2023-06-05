import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('ta'),
    Locale('te')
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// Login page heading
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Username field label
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameFieldLabel;

  /// Username field hint
  ///
  /// In en, this message translates to:
  /// **'Enter Email ID / Contact No.'**
  String get usernameFieldHint;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordFieldLabel;

  /// Password field hint
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get passwordFieldHint;

  /// Login with OTP title
  ///
  /// In en, this message translates to:
  /// **'Login with OTP'**
  String get loginWithOtp;

  /// Forgot password button title
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Mobile Number field label
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get contactNumberFieldLabel;

  /// Enter Contact Number
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get contactNumberFieldHint;

  /// Resend OTP Question
  ///
  /// In en, this message translates to:
  /// **'Did not recieve the OTP?'**
  String get resendOtpQuestion;

  /// Get OTP button text
  ///
  /// In en, this message translates to:
  /// **'Get OTP'**
  String get getOtpButton;

  /// Resend OTP button text
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtpButton;

  /// OTP field label
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtpFieldLabel;

  /// Submit button text
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// Reset Password Page Heading
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// Reset Password Page Message
  ///
  /// In en, this message translates to:
  /// **'No worries, we’ll send OTP to your\n registered Email ID. 📩'**
  String get resetPasswordPageMessage;

  /// Email ID field label
  ///
  /// In en, this message translates to:
  /// **'Email ID'**
  String get emailIdFieldLabel;

  /// Email field hint
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailIdFieldHint;

  /// Reset button text
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetButton;

  /// Back to login button text
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// Set New Password heading
  ///
  /// In en, this message translates to:
  /// **'Set New Password'**
  String get setNewPassword;

  /// set new password screen msg
  ///
  /// In en, this message translates to:
  /// **'Your Password must be different to\n previously used password. 🔐'**
  String get setNewPasswordPageMessage;

  /// otp field label
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otpFieldLabel;

  /// OTP field hint
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get otpFieldHint;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordFieldLabel;

  /// New Password field hint
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get newPasswordFieldHint;

  /// Confirm Password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordFieldLabel;

  /// Confirm Password field hint
  ///
  /// In en, this message translates to:
  /// **'Re-enter New Password'**
  String get confirmPasswordFieldHint;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi', 'ta', 'te'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
    case 'ta': return AppLocalizationsTa();
    case 'te': return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
