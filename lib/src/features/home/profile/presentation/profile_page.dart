import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_controllers/reset_password_controller.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/features/authentication/presentation/login_with_otp/login_with_otp_form.dart';
import 'package:axlerate/src/features/home/profile/domain/user_profile_model.dart';
import 'package:axlerate/src/features/home/profile/presentation/controllers/profile_image_controller.dart';
import 'package:axlerate/src/features/home/profile/presentation/profile_page_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final GlobalKey<FormState> activateAccountFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailVerifyKey = GlobalKey<FormState>();

  late TextEditingController _displayNameController;
  late TextEditingController _editableFieldController;
  late TextEditingController _otpController;
  // late TextEditingController _passwordController;
  // late TextEditingController _confirmPasswordController;

  late UserProfileModel? _profileData;

  @override
  void initState() {
    // log('Loaded');
    _displayNameController = TextEditingController();
    _editableFieldController = TextEditingController();
    _otpController = TextEditingController();
    // _passwordController = TextEditingController();
    // _confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _editableFieldController.dispose();
    _otpController.dispose();
    // _passwordController.dispose();
    // _confirmPasswordController.dispose();

    super.dispose();
  }

  int i = 0;
  late String? profileUrl = _profileData?.data!.message?.profilePic;
  bool showOtpforNumber = false;
  bool showOtpforEmail = false;
  // bool showOtp1 = false;

  double screenHeight = 0.0;
  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context) || Responsive.isTablet(context);

    //final resetTimerState =
    ref.watch(resetSecondsProvider);

    Widget imageUploadWidget(String enrollmentId) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Profile Picture", style: AxleTextStyle.headingPrimary),
          const SizedBox(height: defaultPadding),
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DottedBorder(
              padding: const EdgeInsets.all(0.0),
              color: AxleColors.axleBlueColor,
              dashPattern: const [1],
              radius: const Radius.circular(16.0),
              strokeWidth: 2.0,
              borderType: BorderType.RRect,
              child: GestureDetector(
                onTap: () async {
                  AxleLoader.show(context);
                  Map<String, String>? imageData = await FileUploadUtil.pickImagefromGallery(
                    ref,
                    docType: 'organization/user',
                    orgEnrollId: enrollmentId,
                    showSuccessSnackbar: false,
                    axleFileType: FileType.image,
                  );
                  // debugPrint(imageData.toString());

                  if (imageData != null) {
                    await ref
                        .read(profileControllerProvider)
                        .uploadProfilePic(enrollmentId: enrollmentId, url: imageData['url'] ?? "");
                    setState(() {
                      profileUrl = imageData['url'];
                    });
                    ref.read(profileImageStateProvider.notifier).state = profileUrl!;
                    await ref.watch(sharedPreferenceProvider).setString(Storage.profileUrl, profileUrl!);
                  }
                  AxleLoader.hide();
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      profileUrl != null
                          ? ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(defaultPadding)),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Image.network(
                                    ref.read(profileImageStateProvider),
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      // log("Error Network Image", error: error, stackTrace: stackTrace);
                                      return Image.asset('assets/new_assets/dummy_profile.png');
                                    },
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Colors.transparent, Colors.black],
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
                                        Text("Change Image", style: AxleTextStyle.subtitle2White)
                                      ],
                                    )),
                                  )
                                ],
                              ),
                            )
                          : const Center(child: CircularProgressIndicator())
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Widget changePasswordButtonWidget() {
    //   return AxlePrimaryButton(
    //     buttonText: isMobile ? 'Change' : 'Change Password',
    //     buttonWidth: isMobile ? 100 : 250,
    //     onPress: () {
    //       showDialog(context: context, builder: (_) => ChangePassword());
    //     },
    //   );
    // }

    Widget verifyButtonWidget(String contactID, bool isEmail) {
      return (isEmail ? showOtpforEmail : showOtpforNumber)
          ? LoginWithOtpForm(
              isProfilePage: true,
              contactNumber: contactID,
              isEmail: isEmail,
              onSuccess: () {
                // setState(() {
                // showOtp = false;
                // ignore: unused_result
                ref.refresh(getUserProfileDataProvider);
                // });
              })
          : AxleOutlineButton(
              buttonText: 'Add Email ID',
              buttonWidth: isMobile ? 100 : 250,
              onPress: () {
                setState(() {
                  isEmail ? showOtpforEmail = true : showOtpforNumber = true;
                });
                // ref.read(profileControllerProvider).generateOtpToVerify(
                //       contactID: contactID,
                //       isEmail: contactID.isEmail,
                //     );
              },
            );
    }

    Widget verifiedButtonWidget() {
      return AxleOutlineButton(
        buttonText: 'Verified',
        buttonWidth: isMobile ? 100 : 250,
        outlineColor: Colors.green,
        onPress: null,
      );
    }

    Widget getProfileItem(String title, String value) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AxleTextStyle.labelLarge),
          const SizedBox(height: defaultMobilePadding),
          Text(value, style: AxleTextStyle.labelMedium.copyWith(color: loginDividerColor)),
        ],
      );
    }

    Widget viewProfileData(UserProfileModel profile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Display name",
            style: AxleTextStyle.phoneNuberStyle,
          ),
          const SizedBox(height: 10.0),
          Text(
            profile.data!.message?.name ?? '',
            style: AxleTextStyle.resendOTPQuestionStyle,
          ),
          const SizedBox(height: 50.0),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     // SizedBox(
          //     //   width: 250,
          //     //   child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          //     //     Text(
          //     //       "Password",
          //     //       style: AxleTextStyle.phoneNuberStyle,
          //     //     ),
          //     //     const SizedBox(height: 10.0),
          //     //     Text(
          //     //       "**********",
          //     //       style: AxleTextStyle.resendOTPQuestionStyle,
          //     //     ),
          //     //   ]),
          //     // ),
          //     const SizedBox(
          //       width: 16,
          //     ),
          //     // changePasswordButtonWidget(),
          //   ],
          // ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Contact Number", style: AxleTextStyle.phoneNuberStyle),
                    const SizedBox(height: 10.0),
                    Text(profile.data!.message?.contactNumber ?? '', style: AxleTextStyle.resendOTPQuestionStyle),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              verifiedButtonWidget()
              // profile.data!.message?.isContactNumberVerified ?? false
              //     ? verifiedButtonWidget()
              //     : verifyButtonWidget("Contact Number", profile.data!.message?.contactNumber ?? '', false),
            ],
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Email ID", style: AxleTextStyle.phoneNuberStyle),
                    const SizedBox(height: 10.0),
                    Text(profile.data!.message?.email ?? '', style: AxleTextStyle.resendOTPQuestionStyle),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              profile.data!.message?.isEmailVerified ?? false
                  ? verifiedButtonWidget()
                  : verifyButtonWidget(profile.data!.message?.email ?? '', true),
            ],
          ),
        ],
      );
    }

    Widget viewProfileDataMobile(UserProfileModel profile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getProfileItem("Display name", profile.data!.message?.name ?? ''),
          const SizedBox(height: horizontalPadding),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // getProfileItem("Password", "**********"),
              // changePasswordButtonWidget(),
            ],
          ),
          const SizedBox(height: horizontalPadding),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            getProfileItem("Contact Number", profile.data!.message?.contactNumber ?? ''),
            verifiedButtonWidget()
          ]),
          // profile.data!.message?.isContactNumberVerified ?? false
          //     ? Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           getProfileItem("Contact Number", profile.data!.message?.contactNumber ?? ''),
          //           verifiedButtonWidget()
          //         ],
          //       )
          //     : verifyButtonWidget("Contact Number", profile.data!.message?.contactNumber ?? '', false),
          const SizedBox(height: horizontalPadding),
          profile.data!.message?.isEmailVerified ?? false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [getProfileItem("Email ID", profile.data!.message?.email ?? ''), verifiedButtonWidget()],
                )
              : verifyButtonWidget(profile.data!.message?.email ?? '', true),
        ],
      );
    }

    Widget desktopFormViewWidget(UserProfileModel profile) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                imageUploadWidget(profile.data!.message!.enrollmentId),
                const SizedBox(width: 50.0),
                viewProfileData(profile),
              ],
            ),
          ],
        ),
      );
    }

    Widget desktopView(UserProfileModel? profile) {
      return profile != null
          ? SingleChildScrollView(
              child: Align(
                alignment: Alignment.topLeft,
                child: desktopFormViewWidget(profile),
              ),
            )
          : const Center(
              child: Text('Empty'),
            );
    }

    Widget mobileView(UserProfileModel profile) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imageUploadWidget(profile.data!.message!.enrollmentId),
                const SizedBox(height: 20.0),
                viewProfileDataMobile(profile),
              ],
            ),
          ),
        ),
      );
    }

    final AsyncValue<UserProfileModel?> userProfile = ref.watch(getUserProfileDataProvider);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: userProfile.when(
        data: (UserProfileModel? data) {
          _profileData = data;
          // ref.read(profileImageStateProvider.notifier).state = data?.data?.message?.profilePic ?? '';

          AxleLoader.hide();
          if (data != null) {
            return Responsive(mobile: mobileView(data), desktop: desktopView(data));
          } else {
            return const Center(
              child: Text('Empty'),
            );
          }
        },
        error: (error, stackTrace) {
          AxleLoader.hide();
          return const Center(
            child: Text('Unable to Load. Please Try Again'),
          );
        },
        loading: () {
          AxleLoader.show(context, enableOverlay: false);
          return const SizedBox();
        },
      ),
    );
  }
}
