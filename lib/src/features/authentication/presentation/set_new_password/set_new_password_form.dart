// import 'package:axlerate/Themes/text_style_config.dart';
// import 'package:axlerate/app_util/extensions/extensions.dart';
// import 'package:axlerate/responsive.dart';
// import 'package:axlerate/router/axle_route.dart';
// import 'package:axlerate/src/analytics/events.dart';
// import 'package:axlerate/src/analytics/google_analytics.dart';
// import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
// import 'package:axlerate/src/common/common_widgets/axle_text_field.dart';
// import 'package:axlerate/src/features/authentication/presentation/auth_constants.dart';
// import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
// import 'package:axlerate/src/features/authentication/presentation/auth_widgets/otp_field.dart';
// import 'package:axlerate/src/localizations/l10n.dart';
// import 'package:axlerate/src/utils/axle_loader.dart';
// import 'package:axlerate/src/utils/form_validators.dart';
// import 'package:axlerate/src/utils/snackbar_util.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// class SetNewPasswordForm extends ConsumerStatefulWidget {
//   const SetNewPasswordForm({
//     Key? key,
//     this.contactId,
//   }) : super(key: key);
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _SetNewPasswordFormState();

//   final String? contactId;
// }

// class _SetNewPasswordFormState extends ConsumerState<SetNewPasswordForm> {
//   GlobalKey<FormState> setNewPasswordFormKey = GlobalKey<FormState>();
//   late TextEditingController otpController;
//   late TextEditingController passwordController;
//   late TextEditingController confirmPasswordController;

//   @override
//   void initState() {
//     otpController = TextEditingController();
//     passwordController = TextEditingController();
//     confirmPasswordController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     otpController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     bool isMobile = Responsive.isMobile(context);
//     double contentSize = isMobile ? formContentSizeMobile : formContentSizeMobile;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.contactId == null) {
//         context.go(AxleRoute.login);
//       }
//     });

//     ref.listen<bool>(
//       isAuthLoadingProvider,
//       (previous, isLoading) {
//         if (isLoading == true) {
//           AxleLoader.show(context, enableOverlay: false);
//         } else {
//           AxleLoader.hide();
//         }
//       },
//     );

//     /// To access GoogleAnalytics
//     final analytics = ref.watch(googleAnalyticsProvider);

//     return Center(
//       child: SingleChildScrollView(
//         child: Form(
//           key: setNewPasswordFormKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               if (isMobile)
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Image.asset(
//                       'assets/new_assets/axlerate_text_logo.png',
//                     ),
//                     const SizedBox(height: 36.0)
//                   ],
//                 ),
//               Text(
//                 context.loc.setNewPassword,
//                 style: AxleTextStyle.authScreenHeadingStyle,
//               ),
//               const SizedBox(height: 12.0),
//               Text(
//                 context.loc.setNewPasswordPageMessage,
//                 textAlign: TextAlign.center,
//                 style: AxleTextStyle.authScreenMessageStyle,
//               ),
//               const SizedBox(height: 16.0),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   OTPField(
//                     otpLabel: context.loc.otpFieldLabel,
//                     fieldWidth: isMobile ? screenWidth * 12 / 100 : screenWidth * 4.5 / 100,
//                     onFieldSubmit: (value) => otpController.text = value,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20.0),
//               AxleTextField(
//                 fieldController: passwordController,
//                 fieldHeading: context.loc.newPasswordFieldLabel,
//                 fieldHint: context.loc.newPasswordFieldHint,
//                 fieldWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
//                 isPasswordField: true,
//                 enableInteractiveSelection: false,
//                 validate: Validators(context.loc.newPasswordFieldLabel).required().password(),
//               ),
//               const SizedBox(height: 18.0),
//               AxleTextField(
//                 fieldController: confirmPasswordController,
//                 fieldHeading: context.loc.confirmPasswordFieldLabel,
//                 fieldHint: context.loc.confirmPasswordFieldHint,
//                 fieldWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
//                 isPasswordField: true,
//                 enableInteractiveSelection: false,
//                 validate: Validators(context.loc.confirmPasswordFieldLabel).required().password(),
//               ),
//               const SizedBox(height: 30.0),
//               AxlePrimaryButton(
//                 buttonText: context.loc.submitButton,
//                 buttonWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
//                 onPress: () {
//                   analytics.sendEvent(loginButtonEvent);
//                   _submit();
//                 },
//               ),
//               const SizedBox(height: 30.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _submit() async {
//     if (setNewPasswordFormKey.currentState!.validate()) {
//       if (otpController.text.length == 6) {
//         if (passwordController.text == confirmPasswordController.text) {
//           bool? userStatus = await ref.read(authStateProvider.notifier).setNewPassword(
//                 contactId: widget.contactId ?? '',
//                 otp: otpController.text,
//                 password: passwordController.text,
//                 isEmail: widget.contactId?.isEmail ?? true,
//               );
//           if (userStatus != null) {
//             if (!userStatus && mounted) {
//               context.go(AxleRoute.accountActivation);
//             }
//           }
//         } else {
//           Snackbar.error(newAndOldNotSame);
//         }
//       } else {
//         Snackbar.error(validOtp);
//       }
//     }
//   }
// }
