import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/analytics/events.dart';
import 'package:axlerate/src/analytics/google_analytics.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_field.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_constants.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_widgets/back_to_login_button.dart';
import 'package:axlerate/src/localizations/l10n.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordForm extends ConsumerStatefulWidget {
  const ResetPasswordForm({
    Key? key,
    this.isScrollable = false,
  }) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetPasswordFormState();

  final bool isScrollable;
}

class _ResetPasswordFormState extends ConsumerState<ResetPasswordForm> {
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    double contentSize = isMobile ? formContentSizeMobile : formContentSizeMobile;

    /// To access GoogleAnalytics
    final analytics = ref.watch(googleAnalyticsProvider);
    // final loginController = ref.watch(loginControllerProvider);

    ref.listen<bool>(
      isAuthLoadingProvider,
      (previous, isLoading) {
        if (isLoading == true) {
          AxleLoader.show(context, enableOverlay: false);
        } else {
          AxleLoader.hide();
        }
      },
    );

    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: resetPasswordFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isMobile)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset("assets/new_assets/icons/axlerate_logo_with_tagline.svg", height: 60),
                    const SizedBox(height: 36.0)
                  ],
                ),
              Text(
                context.loc.resetPassword,
                style: AxleTextStyle.authScreenHeadingStyle,
              ),
              const SizedBox(height: 26.0),
              Text(
                context.loc.resetPasswordPageMessage,
                textAlign: TextAlign.center,
                style: AxleTextStyle.authScreenMessageStyle,
              ),
              const SizedBox(height: 30.0),
              AxleTextField(
                fieldController: emailController,
                fieldHeading: context.loc.usernameFieldLabel,
                fieldHint: context.loc.usernameFieldHint,
                fieldWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
                lengthLimit: 30,
                validate: Validators(context.loc.emailIdFieldLabel).required(),
                textType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 38.0),
              AxlePrimaryButton(
                buttonText: context.loc.resetButton,
                buttonWidth: isMobile ? screenWidth * contentSize / 100 : screenWidth * 30 / 100,
                onPress: () {
                  analytics.sendEvent(resetButtonEvent);
                  _submit(context);
                },
              ),
              const SizedBox(height: 20.0),
              const BackToLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  _submit(BuildContext context) async {
    if (resetPasswordFormKey.currentState!.validate()) {
      bool isOtpSent = await ref.read(authStateProvider.notifier).generateOtp(
            contactMethod: emailController.text,
            isEmail: emailController.text.isEmail ? true : false,
          );
      if (isOtpSent && mounted) {
        // context.push(
        //   AxleRoute.setNewPassword,
        //   extra: emailController.text,
        // );
      }
    }
  }
}
