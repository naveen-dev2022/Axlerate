import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get login => 'Login';

  @override
  String get usernameFieldLabel => 'Username';

  @override
  String get usernameFieldHint => 'Enter Email ID / Contact No.';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get passwordFieldHint => 'Enter Password';

  @override
  String get loginWithOtp => 'Login with OTP';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get contactNumberFieldLabel => 'Contact Number';

  @override
  String get contactNumberFieldHint => 'Contact Number';

  @override
  String get resendOtpQuestion => 'Did not recieve the OTP?';

  @override
  String get getOtpButton => 'Get OTP';

  @override
  String get resendOtpButton => 'Resend OTP';

  @override
  String get enterOtpFieldLabel => 'Enter OTP';

  @override
  String get submitButton => 'Submit';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordPageMessage => 'No worries, we’ll send OTP to your\n registered Email ID. 📩';

  @override
  String get emailIdFieldLabel => 'Email ID';

  @override
  String get emailIdFieldHint => 'Email Address';

  @override
  String get resetButton => 'Reset';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get setNewPassword => 'Set New Password';

  @override
  String get setNewPasswordPageMessage => 'Your Password must be different to\n previously used password. 🔐';

  @override
  String get otpFieldLabel => 'OTP';

  @override
  String get otpFieldHint => 'Enter OTP';

  @override
  String get newPasswordFieldLabel => 'New Password';

  @override
  String get newPasswordFieldHint => 'Enter New Password';

  @override
  String get confirmPasswordFieldLabel => 'Confirm Password';

  @override
  String get confirmPasswordFieldHint => 'Re-enter New Password';
}
