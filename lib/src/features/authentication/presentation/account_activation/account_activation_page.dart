import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_controllers/reset_password_controller.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/authentication/presentation/account_activation/account_ativation_controller.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_constants.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_widgets/otp_field.dart';
import 'package:axlerate/src/features/home/profile/presentation/profile_page_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/localizations/l10n.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

@RoutePage()
class AccountActivationPage extends ConsumerStatefulWidget {
  const AccountActivationPage({
    super.key,
    @PathParam('token') required this.token,
  });

  final String token;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountActivationPageState();
}

class _AccountActivationPageState extends ConsumerState<AccountActivationPage> {
  final GlobalKey<FormState> activateAccountFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailVerifyKey = GlobalKey<FormState>();

  late TextEditingController _displayNameController;
  late TextEditingController _editableFieldController;
  late TextEditingController _otpController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  String enrollmentId = '';
  // late String headingContactId = '';
  // bool fromEmail = false;

  @override
  void initState() {
    // log("Initstate called from AccountActivationPage");

    final token = ref.read(sharedPreferenceProvider).getString(Storage.accessToken);
    if (token != null) {
      Snackbar.warn('Please logout to continue');
    }
    getTokenData();

    _displayNameController = TextEditingController();
    _editableFieldController = TextEditingController();
    _otpController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {

  //   super.didChangeDependencies();
  // }

  void getTokenData() async {
    try {
      await ref.read(sharedPreferenceProvider).setString(Storage.accessToken, widget.token);

      final decoded = JwtDecoder.decode(widget.token);
      // if (decoded['email'] == null) {
      //   fromEmail = false;
      // }
      // headingContactId = fromEmail ? decoded['email'] : decoded['contactNumber'];
      enrollmentId = decoded['enrollmentId'];
    } catch (e) {
      // debugPrint("Exception while decoding token :: $e");
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _editableFieldController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  String profileUrl = '';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context) || Responsive.isTablet(context);

    // ref.listen<bool>(
    //   isAuthLoadingProvider,
    //   (previous, isLoading) {
    //     if (isLoading == true) {
    //       AxleLoader.show(context);
    //     } else {
    //       AxleLoader.hide();
    //     }
    //   },
    // );

    final resetTimerState = ref.watch(resetSecondsProvider);
    final isEmailEditable = ref.watch(activateAccountEmailEditableNotifierProvider);

    Widget imageUploadWidget() {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            Map<String, String>? imageData = await FileUploadUtil.pickImagefromGallery(ref,
                allowPdf: false,
                axleFileType: FileType.image,
                docType: 'organization/user',
                orgEnrollId: enrollmentId,
                showSuccessSnackbar: true);
            if (imageData != null) {
              await ref
                  .read(profileControllerProvider)
                  .uploadProfilePic(enrollmentId: enrollmentId, url: imageData['url'] ?? "");
              setState(() {
                profileUrl = imageData['url'] ?? '';
              });
            }
          },
          child: (profileUrl.isNotEmpty)
              ? ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.network(
                        profileUrl,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // log("Error Network Image", error: error, stackTrace: stackTrace);
                          return Image.asset(
                            'assets/new_assets/dummy_profile.png',
                          );
                        },
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                        )),
                        width: 250,
                        height: 50,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/new_assets/icons/change_image_icon.svg'),
                            const SizedBox(width: defaultPadding),
                            Text(
                              "Change Image",
                              style: AxleTextStyle.subtitle2White,
                            )
                          ],
                        )),
                      )
                    ],
                  ),
                )
              : Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DottedBorder(
                    padding: const EdgeInsets.all(20.0),
                    color: AxleColors.axleBlueColor,
                    dashPattern: const [6],
                    radius: const Radius.circular(16.0),
                    strokeWidth: 2.0,
                    borderType: BorderType.RRect,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/new_assets/icons/image_upload_icon.svg'),
                          Text(
                            'Upload Image',
                            style: AxleTextStyle.imageUploadTextStyle,
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Maximum file size: 3MB',
                            style: AxleTextStyle.primaryMiniHintStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      );
    }

    Widget accountActivateForm() {
      return Form(
        key: activateAccountFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AxleFormTextField(
              fieldHeading: 'Display Name',
              fieldHint: 'Enter Display Name',
              fieldController: _displayNameController,
              fieldWidth: isMobile ? screenWidth : screenWidth * 20 / 100,
              isRequiredField: true,
              lengthLimit: 30,
              inputformatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
              ],
              validate: Validators('Display Name').required().max(30),
              onChange: (value) {},
            ),
            const SizedBox(height: 16.0),
            isEmailEditable
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: emailVerifyKey,
                        // child: fromEmail
                        //     ? AxleFormTextField(
                        //         fieldHeading: 'Contact Number',
                        //         fieldHint: 'Enter Contact Number',
                        //         fieldController: _editableFieldController,
                        //         fieldWidth: isMobile ? screenWidth : screenWidth * 20 / 100,
                        //         isOnlyDigits: true,
                        //         lengthLimit: 10,
                        //         validate: Validators('Contact Number').required(),
                        //         onChange: (value) {},
                        //       )
                        //     : AxleFormTextField(
                        //         fieldHeading: 'Email ID',
                        //         fieldHint: 'Enter Email ID',
                        //         fieldController: _editableFieldController,
                        //         fieldWidth: isMobile ? screenWidth : screenWidth * 20 / 100,
                        //         validate: Validators('Email ID').required().email(),
                        //         onChange: (value) {},
                        //       ),
                        child: AxleFormTextField(
                          fieldHeading: 'Email ID',
                          fieldHint: 'Enter Email ID',
                          fieldController: _editableFieldController,
                          fieldWidth: isMobile ? screenWidth : screenWidth * 20 / 100,
                          validate: Validators('Email ID').required().email(),
                          onChange: (value) {},
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      AxleOutlineButton(
                        // buttonText: fromEmail ? 'Verify Mobile Number' : 'Verify Email ID',
                        buttonText: 'Verify Email ID',
                        buttonWidth: isMobile ? screenWidth : screenWidth * 20 / 100,
                        onPress: () async {
                          if (emailVerifyKey.currentState!.validate()) {
                            bool isOtpSent = await ref.read(authStateProvider.notifier).generateOtpToVerify(
                                  contactID: _editableFieldController.text.trim(),
                                  isEmail: _editableFieldController.text.isEmail,
                                  token: widget.token,
                                );
                            if (isOtpSent) {
                              ref.read(activateAccountEmailEditableNotifierProvider.notifier).makeUnEditable();
                            }
                          }
                        },
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // fromEmail
                      //     // ignore: dead_code
                      //     ? Text(
                      //         'Email ID',
                      //         style: AxleTextStyle.axleFormFieldHeadingStyle,
                      //       )
                      //     : Text(
                      //         'Contact Number',
                      //         style: AxleTextStyle.axleFormFieldHeadingStyle,
                      //       ),
                      Text(
                        'Email ID',
                        style: AxleTextStyle.axleFormFieldHeadingStyle,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            _editableFieldController.text,
                            style: AxleTextStyle.axleFormFieldHintStyle,
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {
                              ref.read(resetSecondsProvider.notifier).resetTimer();
                              ref.read(activateAccountEmailEditableNotifierProvider.notifier).makeEditable();
                            },
                            icon: const Icon(
                              CupertinoIcons.pencil_circle_fill,
                              color: primaryColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 14.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            context.loc.resendOtpQuestion,
                            style: AxleTextStyle.resendOTPQuestionStyle,
                          ),
                          TextButton(
                            onPressed: resetTimerState == 0
                                ? () async {
                                    await ref.read(authStateProvider.notifier).generateOtpToVerify(
                                          contactID: _editableFieldController.text.trim(),
                                          isEmail: _editableFieldController.text.isEmail,
                                          token: widget.token,
                                        );

                                    ref.read(resetSecondsProvider.notifier).startTimer();
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
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: isMobile ? screenWidth : 300,
                        child: OTPField(
                          fieldWidth: isMobile ? screenWidth * 12 / 100 : screenWidth * 2.6 / 100,
                          otpLabel: context.loc.enterOtpFieldLabel,
                          labelStyle: AxleTextStyle.axleFormFieldHeadingStyle,
                          onFieldSubmit: (value) => _otpController.text = value,
                          mainAlignment: MainAxisAlignment.start,
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 16.0),
            // AxleFormTextField(
            //   fieldHeading: 'Password',
            //   fieldHint: 'Enter Password',
            //   fieldWidth: isMobile ? screenWidth : screenWidth * 20 / 100,
            //   fieldController: _passwordController,
            //   isRequiredField: true,
            //   isPasswordField: true,
            //   lengthLimit: 16,
            //   validate: Validators('Password').required().password().min(6).max(16),
            //   onChange: (value) {
            //     ref.read(resetSecondsProvider.notifier).startTimer();
            //   },
            // ),
            // const SizedBox(height: 16.0),
            // AxleFormTextField(
            //   fieldHeading: 'Confirm Passsword',
            //   fieldHint: 'Re-Enter Password',
            //   fieldWidth: isMobile ? screenWidth : screenWidth * 20 / 100,
            //   isRequiredField: true,
            //   isPasswordField: true,
            //   fieldController: _confirmPasswordController,
            //   lengthLimit: 16,
            //   validate: Validators('Confirm Password').required().min(6).max(16),
            //   onChange: (value) {
            //     ref.read(resetSecondsProvider.notifier).startTimer();
            //   },
            // ),
          ],
        ),
      );
    }

    Widget submitButtonWidget() {
      return AxlePrimaryButton(
        buttonText: 'Submit',
        buttonWidth: isMobile ? screenWidth : 500,
        onPress: () async {
          if (activateAccountFormKey.currentState!.validate()) {
            if (_passwordController.text == _confirmPasswordController.text) {
              AxleLoader.show(context);
              // Form is valid
              await ref.read(authStateProvider.notifier).activateAccount(
                  name: _displayNameController.text.trim(),
                  otp: _otpController.text,
                  contactId: _editableFieldController.text.trim());
              // ignore: use_build_context_synchronously
              context.router.navigateNamed('/app');
              AxleLoader.hide();
            } else {
              Snackbar.error('Password mismatch');
            }
          } else {
            // Form is Not valid
          }
        },
      );
    }

    Widget desktopFormViewWidget() {
      return Container(
        width: screenWidth * 50 / 100,
        constraints: const BoxConstraints(minWidth: 700),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
          child: Container(
            padding: const EdgeInsets.all(40.0),
            decoration: CommonStyleUtil.accountActivationcardStyle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Text(
                //       'Activate your Account',
                //       style: AxleTextStyle.activateAccountTitleStyle,
                //     ),
                //     const SizedBox(width: 10.0),
                //     Text(
                //       headingContactId,
                //       style: AxleTextStyle.activateAccountNumberStyle,
                //     ),
                //     const SizedBox(
                //       height: 10.0,
                //     ),
                //   ],
                // ),
                Text(
                  'Activate your Account',
                  style: AxleTextStyle.activateAccountTitleStyle,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    imageUploadWidget(),
                    accountActivateForm(),
                  ],
                ),
                const SizedBox(height: 20.0),
                submitButtonWidget()
              ],
            ),
          ),
        ),
      );
    }

    Widget activationPageWelcomeMessage() {
      return Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/new_assets/icons/axlerate_logo.svg'),
          const SizedBox(height: verticalPadding),
          Text(
            accountActivationTitleMsg,
            textAlign: TextAlign.left,
            style: AxleTextStyle.accountActivationTitleStyle.copyWith(
              fontSize: isMobile ? 34 : 42.0,
            ),
          ),
          Text(
            accountActivationSemiTitle,
            textAlign: TextAlign.left,
            style: AxleTextStyle.accountActivationSemiTitleStyle.copyWith(
              fontSize: isMobile ? 28 : 34.0,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            accountActivationSubTitle,
            textAlign: TextAlign.left,
            style: AxleTextStyle.accountActivationSubTitleStyle.copyWith(
              fontSize: isMobile ? 20 : 24,
              height: 1.2,
            ),
          ),
        ],
      );
    }

    Widget desktopView() {
      return Scaffold(
        backgroundColor: AxleColors.axleBackgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(
                    'assets/new_assets/images/account-activation-bg.svg',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 40 / 100,
                    child: Padding(
                      padding: const EdgeInsets.all(horizontalPadding),
                      child: activationPageWelcomeMessage(),
                    ),
                  ),
                  desktopFormViewWidget(),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget mobileView() {
      return Scaffold(
        backgroundColor: AxleColors.axleWhiteColor,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      activationPageWelcomeMessage(),
                      const SizedBox(height: 30.0),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AxleColors.axleCardColor, width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     Text(
                            //       'Activate your Account',
                            //       style: AxleTextStyle.activateAccountTitleStyle.copyWith(fontSize: 16),
                            //     ),
                            //     const SizedBox(width: 4),
                            //     Text(
                            //       headingContactId,
                            //       style: AxleTextStyle.activateAccountNumberStyle.copyWith(fontSize: 16),
                            //     ),
                            //   ],
                            // ),
                            Text('Activate your Account',
                                style: AxleTextStyle.activateAccountNumberStyle.copyWith(fontSize: 16)),
                            const SizedBox(height: 20.0),
                            imageUploadWidget(),
                            const SizedBox(height: 20.0),
                            accountActivateForm(),
                            const SizedBox(height: 20.0),
                            submitButtonWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Responsive(mobile: mobileView(), desktop: desktopView());
  }
}
