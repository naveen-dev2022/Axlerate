// import 'package:axlerate/Themes/color_constants.dart';
// import 'package:axlerate/Themes/text_style_config.dart';
// import 'package:axlerate/responsive.dart';
// import 'package:axlerate/router/axle_route.dart';
// import 'package:axlerate/src/analytics/events.dart';
// import 'package:axlerate/src/analytics/google_analytics.dart';
// import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
// import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
// import 'package:axlerate/src/common/common_widgets/axle_text_field.dart';
// import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
// import 'package:axlerate/src/localizations/l10n.dart';
// import 'package:axlerate/src/features/authentication/presentation/auth_constants.dart';
// import 'package:axlerate/src/utils/axle_loader.dart';
// import 'package:axlerate/src/utils/form_validators.dart';
// import 'package:axlerate/values/constants.dart';
// import 'package:axlerate/values/strings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';

// class LoginWithEmailForm extends ConsumerStatefulWidget {
//   const LoginWithEmailForm({
//     Key? key,
//     this.isScrollable = false,
//   }) : super(key: key);
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _LoginWithEmailFormState();

//   final bool isScrollable;
// }

// class _LoginWithEmailFormState extends ConsumerState<LoginWithEmailForm> {
//   GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
//   late TextEditingController userNameController;
//   late TextEditingController passwordController;

//   @override
//   void initState() {
//     userNameController = TextEditingController();
//     passwordController = TextEditingController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     bool isMobile = Responsive.isMobile(context);
//     double contentSize = isMobile ? formContentSizeMobile : formContentSizeMobile;

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

//     /// To access current language
//     // final localeLang = ref.watch(localeLangProvider);

//     return SafeArea(
//       child: Center(
//         child: SingleChildScrollView(
//           child: Form(
//             key: loginFormKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isMobile)
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/new_assets/icons/axlerate_logo_with_tagline.svg",
//                         height: 60,
//                       ),
//                       const SizedBox(height: 36.0)
//                     ],
//                   ),
//                 Text(
//                   context.loc.login,
//                   style: AxleTextStyle.authScreenHeadingStyle,
//                 ),
//                 const SizedBox(height: 30.0),
//                 AxleTextField(
//                   fieldController: userNameController,
//                   fieldHeading: 'Mobile Number',
//                   fieldHint: 'Enter Mobile Number',
//                   fieldWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
//                   validate: Validators(Strings.fieldUsername).required(),
//                   textType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 18.0),
//                 AxleTextField(
//                   fieldController: passwordController,
//                   fieldHeading: context.loc.passwordFieldLabel,
//                   fieldHint: context.loc.passwordFieldHint,
//                   fieldWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
//                   isPasswordField: true,
//                   enableInteractiveSelection: false,
//                   validate: Validators(Strings.fieldPassword).required(),
//                 ),
//                 const SizedBox(height: 30.0),
//                 AxlePrimaryButton(
//                   buttonText: context.loc.login,
//                   buttonWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
//                   onPress: () {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                     analytics.sendEvent(loginButtonEvent);
//                     _submit(context);
//                   },
//                 ),
//                 SizedBox(height: isMobile ? defaultPadding : verticalPadding),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       height: 2.0,
//                       margin: const EdgeInsets.symmetric(horizontal: 20.0),
//                       width: isMobile ? screenWidth * 28 / 100 : screenWidth * 12 / 100,
//                       color: loginDividerColor,
//                     ),
//                     Text(
//                       'or',
//                       style: AxleTextStyle.orDividerStyle,
//                     ),
//                     Container(
//                       height: 2.0,
//                       margin: const EdgeInsets.symmetric(horizontal: 20.0),
//                       width: isMobile ? screenWidth * 28 / 100 : screenWidth * 12 / 100,
//                       color: loginDividerColor,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: isMobile ? defaultPadding : verticalPadding),
//                 // AxleOutlineButton(
//                 //   buttonText: context.loc.loginWithOtp,
//                 //   buttonWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
//                 //   onPress: () {
//                 //     FocusManager.instance.primaryFocus?.unfocus();
//                 //     analytics.sendEvent(loginWithOtpEvent);
//                 //     context.push(AxleRoute.loginWithOtp);
//                 //   },
//                 // ),
//                 // const SizedBox(height: 26.0),
//                 TextButton(
//                   onPressed: () {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                     analytics.sendEvent(forgotPasswordEvent);
//                     context.push(AxleRoute.resetPassword);
//                   },
//                   child: Text(
//                     context.loc.forgotPassword,
//                     style: AxleTextStyle.forgotPassTextStyle,
//                   ),
//                 ),
//                 const SizedBox(height: 26.0),
//                 // DropdownButton(
//                 //   value: localeLang.locale,
//                 //   items: L10n.dropDownLocaleList,
//                 //   onChanged: (value) {
//                 //     ref.read(localeLangProvider.notifier).setLocale(value as Locale);
//                 //   },
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _submit(BuildContext context) async {
//     if (loginFormKey.currentState!.validate()) {
//       // debugPrint("Form Validated");
//       await ref.read(authStateProvider.notifier).loginWithCredentials(
//             username: userNameController.text,
//             password: passwordController.text,
//           );
//     }
//   }

//   // @override
//   // bool get wantKeepAlive => true;
// }
