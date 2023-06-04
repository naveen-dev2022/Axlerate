// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/analytics/events.dart';
import 'package:axlerate/src/analytics/google_analytics.dart';
import 'package:axlerate/src/common/common_controllers/reset_password_controller.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_field.dart';
import 'package:axlerate/src/features/authentication/domain/auth_result.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_constants.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_widgets/otp_field.dart';
import 'package:axlerate/src/features/authentication/presentation/login_with_otp/login_with_otp_controller.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/profile/presentation/profile_page_controller.dart';
import 'package:axlerate/src/localizations/l10n.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class LoginWithOtpForm extends ConsumerStatefulWidget {
  const LoginWithOtpForm(
      {Key? key,
      this.isScrollable = false,
      this.isProfilePage = false,
      this.contactNumber,
      this.onSuccess,
      this.isEmail = false})
      : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginWithOtpFormState();

  final bool isScrollable;
  final bool isProfilePage;
  final String? contactNumber;
  final bool isEmail;
  final Function()? onSuccess;
}

class _LoginWithOtpFormState extends ConsumerState<LoginWithOtpForm> {
  GlobalKey<FormState> loginWithOtpformKey = GlobalKey<FormState>();
  late TextEditingController phoneController;
  late TextEditingController otpController;
  bool isMobile = false;

  @override
  void initState() {
    phoneController = TextEditingController(text: widget.contactNumber);
    otpController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(otpVisibilityProvider.notifier).setToFalse();
    });
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);
    double contentSize = 90;
    //isMobile ? formContentSizeMobile : formContentSizeMobile;

    /// To access GoogleAnalytics
    final analytics = ref.watch(googleAnalyticsProvider);
    final visibilityState = ref.watch(otpVisibilityProvider);
    final resetTimerState = ref.watch(resetSecondsProvider);

    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: loginWithOtpformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!widget.isProfilePage)
                if (isMobile)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset("assets/new_assets/icons/axlerate_logo_with_tagline.svg", height: 60),
                      const SizedBox(height: 36.0)
                    ],
                  ),
              if (!widget.isProfilePage)
                Text(
                  context.loc.loginWithOtp,
                  style: AxleTextStyle.authScreenHeadingStyle,
                ),
              Visibility(
                visible: !visibilityState,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 30.0),
                    widget.isEmail
                        ? AxleTextField(
                            fieldController: phoneController,
                            fieldHeading: "Email ID",
                            fieldHint: "Email ID",
                            fieldWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
                            validate: Validators("Email Id").email().required(),
                          )
                        : AxleTextField(
                            fieldController: phoneController,
                            fieldHeading: InputFormConstants.mobileNum,
                            fieldHint: InputFormConstants.mobileNumberFieldHint,
                            textType: TextInputType.number,
                            fieldWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
                            validate: Validators(context.loc.contactNumberFieldLabel).required().max(10).min(10),
                            isOnlyDigits: true,
                            lengthLimit: 10,
                            isFieldEnabled: !visibilityState,
                          ),
                    const SizedBox(height: 30.0),
                    AxlePrimaryButton(
                      buttonText: context.loc.getOtpButton,
                      buttonWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
                      onPress: () async {
                        FocusManager.instance.primaryFocus?.unfocus();

                        try {
                          String inputValue = phoneController.text;
                          if (inputValue.trim().isEmpty) {
                            Snackbar.warn("Field cannot be Empty");
                            return;
                          }
                          isMobile ? AxleLoader.show(context) : AxleLoader.showNoOverlay(context);
                          analytics.sendEvent(resetButtonEvent);
                          bool isOtpSent = false;
                          if (widget.isProfilePage) {
                            isOtpSent = await ref.read(profileControllerProvider).generateOtpToVerify(
                                  contactID: phoneController.text,
                                  isEmail: phoneController.text.isEmail,
                                );
                          } else {
                            isOtpSent = await ref
                                .read(authStateProvider.notifier)
                                .generateOtp(contactMethod: phoneController.text);
                          }
                          if (isOtpSent && mounted) {
                            ref.read(otpVisibilityProvider.notifier).toggle();
                          }
                        } catch (e) {
                          // debugPrint('The Error is -> $e');
                        }
                        AxleLoader.hide();
                      },
                    ),
                    if (!widget.isProfilePage) const SizedBox(height: 30.0),
                    // if (!widget.isProfilePage) const BackToLoginButton(),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              Visibility(
                visible: visibilityState,
                child: SizedBox(
                  width: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.isEmail ? phoneController.text : '+91 - ${phoneController.text}',
                              style: AxleTextStyle.phoneNuberStyle,
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () {
                                ref.read(resetSecondsProvider.notifier).resetTimer();
                                ref.read(otpVisibilityProvider.notifier).toggle();
                              },
                              icon: const Icon(
                                CupertinoIcons.pencil_circle_fill,
                                color: primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      // const SizedBox(height: 20),
                      Row(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.loc.resendOtpQuestion,
                            style: AxleTextStyle.resendOTPQuestionStyle,
                          ),
                          TextButton(
                            onPressed: resetTimerState == 0
                                ? () async {
                                    bool isOtpSent = await ref
                                        .read(authStateProvider.notifier)
                                        .generateOtp(contactMethod: phoneController.text);
                                    if (isOtpSent) {
                                      ref.read(resetSecondsProvider.notifier).startTimer();
                                    } else {
                                      Snackbar.error(errorSendingOtp);
                                    }
                                  }
                                : null,
                            child: Text(
                              resetTimerState == 0
                                  ? context.loc.resendOtpButton
                                  : '${context.loc.resendOtpButton} in 00:$resetTimerState',
                              style: AxleTextStyle.resendOTPStyle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: OTPField(
                            otpLabel: context.loc.enterOtpFieldLabel,
                            onFieldSubmit: (value) {
                              otpController.text = value;
                              _submit(context);
                            }),
                      ),
                      const SizedBox(height: 30.0),
                      AxlePrimaryButton(
                        buttonText: context.loc.submitButton,
                        buttonWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
                        onPress: () {
                          analytics.sendEvent(resetButtonEvent);
                          _submit(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    /// Validating field
    isMobile ? AxleLoader.show(context) : AxleLoader.showNoOverlay(context);
    if (loginWithOtpformKey.currentState!.validate()) {
      if (otpController.text.length == 6) {
        if (widget.isProfilePage) {
          AxleLoader.show(context);
          bool res = await ref.read(profileControllerProvider).verifyOtpForContactAddress(
              contactID: phoneController.text, otp: otpController.text, isEmail: widget.isEmail);
          AxleLoader.hide();
          if (res) {
            widget.onSuccess!();
          }
        } else {
          String status = await ref.read(authStateProvider.notifier).loginWithOtp(
                number: phoneController.text,
                otp: otpController.text,
              );
          final authState = ref.read(authResultProvider);
          final authToken = ref.watch(authTokenProvider);
          print(authToken);
          if (authState == AuthResult.pending) {
            context.router.pushNamed('/account-activation/$authToken');
          } else {
            if (status == 'Invalid Credentials') {
              otpController = TextEditingController();
              setState(() {});
            } else {
              context.router.pushNamed('/app');
            }
          }
        }
      } else {
        Snackbar.error(validOtp);
      }
    }

    AxleLoader.hide();
  }
}
