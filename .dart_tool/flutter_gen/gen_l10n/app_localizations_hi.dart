import 'app_localizations.dart';

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get helloWorld => 'नमस्ते दुनिया';

  @override
  String get login => 'लॉग इन करें';

  @override
  String get usernameFieldLabel => 'उपयोगकर्ता';

  @override
  String get usernameFieldHint => 'ईमेल आईडी / संपर्क नंबर दर्ज करें।';

  @override
  String get passwordFieldLabel => 'पासवर्ड';

  @override
  String get passwordFieldHint => 'पास वर्ड दर्ज करें';

  @override
  String get loginWithOtp => 'OTP के साथ लॉगिन करें';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get contactNumberFieldLabel => 'संपर्क संख्या';

  @override
  String get contactNumberFieldHint => 'संपर्क नंबर दर्ज करें';

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
