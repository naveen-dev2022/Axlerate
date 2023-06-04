import 'package:axlerate/src/features/authentication/presentation/reset_password/reset_password_form.dart';
import 'package:axlerate/src/features/authentication/presentation/shared/auth_background.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AuthBackground(
      screenForm: ResetPasswordForm(),
    );
  }
}
