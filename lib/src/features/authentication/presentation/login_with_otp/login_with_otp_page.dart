import 'package:axlerate/src/features/authentication/presentation/login_with_otp/login_with_otp_form.dart';
import 'package:axlerate/src/features/authentication/presentation/shared/auth_background.dart';
import 'package:flutter/material.dart';

class LoginWithOtpPage extends StatelessWidget {
  const LoginWithOtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AuthBackground(
      screenForm: LoginWithOtpForm(),
    );
  }
}
