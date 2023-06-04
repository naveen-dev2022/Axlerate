// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/profile/presentation/profile_page_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePassword extends ConsumerWidget {
  ChangePassword({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  double screenWidth = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);

    Future<void> onSubmit() async {
      if (_formKey.currentState!.validate()) {
        if (newPassword.text != confirmPassword.text) {
          // log("New Passwords are not same");
          Snackbar.error("Passwords do not match");
          return;
        }
        AxleLoader.show(context);
        bool res = await ref
            .read(profileControllerProvider)
            .changePassword(newPass: newPassword.text, oldPass: oldPassword.text);
        AxleLoader.hide();
        if (res) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      }
    }

    return AlertDialog(
      title: Center(child: Text("Change Password", style: AxleTextStyle.headline6BlackStyle)),
      titlePadding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
      contentPadding: isMobile ? EdgeInsets.zero : const EdgeInsets.fromLTRB(32, 0, 32, 32),
      actionsPadding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      actionsAlignment: MainAxisAlignment.spaceAround,
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Scrollbar(
            thickness: 5,
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(defaultPadding),
                  //   child: Text("Your new password must be different from previous used passwords",
                  //       style: AxleTextStyle.subtitle2GreyStyle),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: AxleFormTextField(
                      fieldController: oldPassword,
                      fieldHeading: "Current Password",
                      fieldHint: "Enter Current Password",
                      obscure: true,
                      isPasswordField: true,
                      isRequiredField: true,
                      validate: Validators("Current Password").required().password(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: AxleFormTextField(
                      fieldController: newPassword,
                      fieldHeading: "New Password",
                      fieldHint: "Enter New Password",
                      obscure: true,
                      isPasswordField: true,
                      isRequiredField: true,
                      validate: Validators("New Password").required().password(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: AxleFormTextField(
                      fieldAction: TextInputAction.done,
                      fieldController: confirmPassword,
                      fieldHeading: "Confirm Password",
                      fieldHint: "Enter Password again",
                      obscure: true,
                      isPasswordField: true,
                      isRequiredField: true,
                      validate: Validators("Confirm Password").required(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        AxleOutlineButton(
            buttonWidth: screenWidth * 30 / 100,
            buttonText: "Cancel",
            onPress: () {
              Navigator.pop(context);
            }),
        AxlePrimaryButton(
          buttonWidth: screenWidth * 30 / 100,
          buttonText: "Submit",
          onPress: onSubmit,
        )
      ],
    );
  }
}
