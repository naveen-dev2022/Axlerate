import 'app_localizations.dart';

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get helloWorld => 'வணக்கம் உலகம்';

  @override
  String get login => 'உள்நுழைய';

  @override
  String get usernameFieldLabel => 'பயனர்';

  @override
  String get usernameFieldHint => 'மின்னஞ்சல் ஐடி / தொடர்பு எண்ணை உள்ளிடவும்.';

  @override
  String get passwordFieldLabel => 'கடவுச்சொல்';

  @override
  String get passwordFieldHint => 'கடவுச்சொல்லை உள்ளிடவும்';

  @override
  String get loginWithOtp => 'OTP மூலம் உள்நுழையவும்';

  @override
  String get forgotPassword => 'கடவுச்சொல்லை மறந்துவிட்டீர்களா?';

  @override
  String get contactNumberFieldLabel => 'தொடர்பு எண்';

  @override
  String get contactNumberFieldHint => 'தொடர்பு எண்ணை உள்ளிடவும்';

  @override
  String get resendOtpQuestion => 'Did not recieve the OTP?';

  @override
  String get getOtpButton => '';

  @override
  String get resendOtpButton => '';

  @override
  String get enterOtpFieldLabel => '';

  @override
  String get submitButton => '';

  @override
  String get resetPassword => '';

  @override
  String get resetPasswordPageMessage => '';

  @override
  String get emailIdFieldLabel => '';

  @override
  String get emailIdFieldHint => '';

  @override
  String get resetButton => '';

  @override
  String get backToLogin => '';

  @override
  String get setNewPassword => 'Set New Password';

  @override
  String get setNewPasswordPageMessage => 'Your Password must be different to\n previously used password. 🔐';

  @override
  String get otpFieldLabel => '';

  @override
  String get otpFieldHint => '';

  @override
  String get newPasswordFieldLabel => '';

  @override
  String get newPasswordFieldHint => '';

  @override
  String get confirmPasswordFieldLabel => '';

  @override
  String get confirmPasswordFieldHint => '';
}
