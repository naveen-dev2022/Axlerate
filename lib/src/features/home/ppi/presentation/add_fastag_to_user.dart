import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_file_picker.dart';
import 'package:axlerate/src/features/home/ppi/presentation/widgets/ppi_address_form.dart';
import 'package:axlerate/src/features/home/user/domain/add_lqtag_input_model.dart' as lqform;
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_account_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/widgets/info_widget.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_controllers/reset_password_controller.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/authentication/presentation/auth_widgets/otp_field.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/ppi/presentation/controllers/ppi_ui_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/localizations/l10n.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';

class AddFastagToUserPage extends ConsumerStatefulWidget {
  const AddFastagToUserPage({
    super.key,
    required this.userData,
    required this.orgenrollIdOfUser,
    required this.userEnrollmentId,
    required this.onPress,
  });

  final String userEnrollmentId;
  final String orgenrollIdOfUser;
  final void Function()? onPress;

  final UpdatedUserByEnrolmentIdModel userData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddFastagToUserState();
}

class _AddFastagToUserState extends ConsumerState<AddFastagToUserPage> {
  Future<UpdatedUserByEnrolmentIdModel>? updatedUserFuture;

  final GlobalKey<FormState> addPPIFormKey = GlobalKey<FormState>();

  // Kit Number Controller
  final TextEditingController _kitNumberController = TextEditingController();

  // Personal Number Controller
  final TextEditingController _salutationController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? dobDate;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _address1ControllerP = TextEditingController();
  final TextEditingController _address2ControllerP = TextEditingController();
  final TextEditingController _address3ControllerP = TextEditingController();
  final TextEditingController _cityControllerP = TextEditingController();
  final TextEditingController _stateControllerP = TextEditingController();
  final TextEditingController _countryControllerP = TextEditingController(text: 'India');
  final TextEditingController _pincodeControllerP = TextEditingController();

  final TextEditingController _addrProofController = TextEditingController();
  final TextEditingController _addrUrlController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  OrgDoc? org;

  late String userEntityId = '';
  bool isMobile = false;
  double screenWidth = 0.0;
  double availabeWidth = 0.0;
  UserService? userService;
  UserAccountInfoModel? userAccInfo;
  bool isAlreadyenabled = false;
  bool isStatusPending = false;

  @override
  void initState() {
    getUserServiceList(widget.userData);

    super.initState();
  }

  autofill() {
    if (userService != null) {
      _kitNumberController.text = userAccInfo?.data != null ? userAccInfo?.data?.message.kitNumber ?? '' : '';
      _salutationController.text = userService?.title ?? '';
      _firstNameController.text = userService?.firstName ?? '';
      _emailController.text = userService?.communicationInfo.first.emailId ?? '';
      _panController.text = userService?.kycInfo.first.documentNo ?? '';
      _lastNameController.text = userService?.lastName ?? '';
      _genderController.text = userService?.gender ?? '';
      _addrUrlController.text = userService?.kycDocuments?.addressProof?.url ?? '';
      _dobController.text =
          (userService != null && userService!.dateInfo.isNotEmpty) ? userService!.dateInfo.first.date : '';
      dobDate = DateTime.parse(userService!.dateInfo.first.date);

      _address1ControllerP.text = userService?.addressInfo.first.address1 ?? '';
      _address2ControllerP.text = userService?.addressInfo.first.address2 ?? '';
      _address3ControllerP.text = userService?.addressInfo.first.address3 ?? '';
      _cityControllerP.text = userService?.addressInfo.first.city ?? '';
      _stateControllerP.text = userService?.addressInfo.first.state ?? '';
      _countryControllerP.text = userService?.addressInfo.first.country ?? '';
      _pincodeControllerP.text = userService?.addressInfo.first.pinCode ?? '';
      _addrProofController.text = userService?.kycDocuments?.addressProof?.docUploadStatus ?? '';
    }
    isAlreadyenabled = userService != null ? true : false;
    isStatusPending = userService?.kycStatus == 'PENDING' ? true : false;
    setState(() {});
  }

  UserService? getUserServiceList(UpdatedUserByEnrolmentIdModel userData) {
    try {
      for (OrganizationUpdated e in userData.data?.message?.organizations ?? []) {
        userService = getOrgServiceFromUserEnrollId(
          e,
          "TAG",
          issuerName: "LIVQUIK",
          organizationEnrollmentId: widget.orgenrollIdOfUser,
        );

        if (userService != null) {
          autofill();
          break;
        }
      }
      return userService;
    } catch (e) {
      log(e.toString());
    }
    return userService;
  }

  DateTime? pickedDateValue;

  @override
  Widget build(BuildContext context) {
    org = ref.watch(orgDetailsProvider);
    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);

    availabeWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2 + defaultPadding * 4);
    if (isMobile) {
      availabeWidth = screenWidth - (defaultPadding * 4);
    }

    final resetTimerState = ref.watch(tagResetSecondsProvider);
    final otpvisibility = ref.watch(tagOtpVisibilityProvider);

    return SingleChildScrollView(
      child: org == null
          ? AxleLoader.axleProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: getOrgService(org, 'TAG', issuerName: 'LIVQUIK') == null
                  ? const AxleErrorWidget(
                      titleStr: 'Please enable TAG service in organization level',
                    )
                  : Form(
                      key: addPPIFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("LivQuik FASTag Admin",
                                  style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10.0),
                              Text("You are assigning the following admin as FASTag admin.",
                                  overflow: TextOverflow.ellipsis,
                                  style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey),
                                  maxLines: 2),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  InfoWidget(title: 'Admin Name', data: widget.userData.data?.message?.name ?? ''),
                                  const SizedBox(width: horizontalPadding),
                                  InfoWidget(
                                      title: 'Mobile Number', data: widget.userData.data?.message?.contactNumber ?? ''),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              const Divider(color: AxleColors.axleShadowColor),
                              const SizedBox(height: 16.0),

                              //* Personal Details
                              Text("Personal Details of the FASTag Admin",
                                  style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10.0),
                              const SizedBox(height: defaultPadding),
                              Wrap(
                                runSpacing: defaultPadding,
                                spacing: defaultPadding,
                                children: [
                                  AbsorbPointer(
                                    absorbing: isAlreadyenabled,
                                    child: AxleSearchDropDownField(
                                      fieldHeading: InputFormConstants.titleFieldLabel,
                                      fieldHint: InputFormConstants.titleFieldHint,
                                      fieldWidth: isMobile ? screenWidth : 320,
                                      fieldController: _salutationController,
                                      dropDownOptions: titleList,
                                      validate: Validators(InputFormConstants.titleFieldLabel).required(),
                                      onChanged: (val) {
                                        _salutationController.text = val;
                                      },
                                      isRequired: true,
                                    ),
                                  ),
                                  AxleFormTextField(
                                    fieldHeading: InputFormConstants.firstNameLabel,
                                    fieldHint: InputFormConstants.firstNameHint,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    fieldController: _firstNameController,
                                    lengthLimit: 30,
                                    validate: Validators(InputFormConstants.firstNameLabel).required(),
                                    isRequiredField: true,
                                    isFieldEnabled: !isAlreadyenabled,
                                  ),
                                  AxleFormTextField(
                                    fieldHeading: InputFormConstants.lastnameLabel,
                                    fieldHint: InputFormConstants.lastnameHint,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    lengthLimit: 30,
                                    fieldController: _lastNameController,
                                    validate: Validators(InputFormConstants.lastnameLabel).required(),
                                    isRequiredField: true,
                                    isFieldEnabled: !isAlreadyenabled,
                                  ),
                                  AbsorbPointer(
                                    absorbing: isAlreadyenabled,
                                    child: AxleSearchDropDownField(
                                      fieldHeading: InputFormConstants.genderFieldLable,
                                      fieldHint: InputFormConstants.genderFieldHint,
                                      fieldWidth: isMobile ? screenWidth : 320,
                                      fieldController: _genderController,
                                      dropDownOptions: genderList,
                                      onChanged: (val) {
                                        _genderController.text = val;
                                      },
                                      validate: Validators(InputFormConstants.genderFieldLable).required(),
                                      isRequired: true,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: isAlreadyenabled
                                        ? null
                                        : () async {
                                            DateTime? date = await DatePickerUtil.pickDate(context,
                                                showRecentPicked: pickedDateValue);
                                            pickedDateValue = date;
                                            if (date != null) {
                                              _dobController.text = DatePickerUtil.userViewDateFormatter(date);
                                              dobDate = date;
                                            }
                                          },
                                    child: AxleFormTextField(
                                      fieldHeading: InputFormConstants.dateOfBirthLabel,
                                      fieldHint: InputFormConstants.dateOfBirthHint,
                                      fieldWidth: isMobile ? screenWidth : 320,
                                      fieldController: _dobController,
                                      validate: Validators(InputFormConstants.dateOfBirthLabel).required(),
                                      isRequiredField: true,
                                      isFieldEnabled: false,
                                    ),
                                  ),
                                  AxleFormTextField(
                                    fieldHeading: InputFormConstants.emailFieldLabel,
                                    fieldHint: InputFormConstants.emailFieldHint,
                                    fieldController: _emailController,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    validate: Validators(InputFormConstants.emailFieldLabel).required(),
                                    isRequiredField: true,
                                    lengthLimit: 30,
                                    isFieldEnabled: !isAlreadyenabled,
                                  ),
                                  AxleFormTextField(
                                    fieldHeading: InputFormConstants.onlyPanFieldLable,
                                    fieldHint: InputFormConstants.panNumberFieldHint,
                                    fieldController: _panController,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    validate: Validators(InputFormConstants.onlyPanFieldLable).required(),
                                    isRequiredField: true,
                                    lengthLimit: 10,
                                    isFieldEnabled: !isAlreadyenabled,
                                  ),
                                ],
                              ),
                              const SizedBox(height: defaultPadding),
                              const Divider(color: AxleColors.axleShadowColor),
                              const SizedBox(height: defaultPadding),
                              //* Permanent Address Info (Address As Per Aadhar)
                              Text(HomeConstants.addressAsPerAadhar,
                                  style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: defaultPadding),
                              PpiAddressDetailsForm(
                                isAlreadyenabled: isAlreadyenabled,
                                isCenterAligned: false,
                                showAddr3: true,
                                address1Controller: _address1ControllerP,
                                address2Controller: _address2ControllerP,
                                address3Controller: _address3ControllerP,
                                cityController: _cityControllerP,
                                stateController: _stateControllerP,
                                countryController: _countryControllerP,
                                pinCodeController: _pincodeControllerP,
                              ),

                              const SizedBox(height: defaultPadding),
                              const Divider(color: AxleColors.axleShadowColor),
                              const SizedBox(height: defaultPadding),
                              Text(
                                "KYC Document",
                                style: AxleTextStyle.headingPrimary,
                              ),
                              const SizedBox(height: defaultPadding),

                              Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: AxleFilePicker(
                                  customWidth: isMobile ? screenWidth : 420,
                                  labelText: InputFormConstants.docFieldAddressproof,
                                  isRequiredField: true,
                                  controller: _addrProofController,
                                  validate: (val) {
                                    if (_addrProofController.text.isEmpty) {
                                      return 'Document Required';
                                    }
                                    return null;
                                  },
                                  isEnabled: !isAlreadyenabled,
                                  onPress: () async {
                                    _addrProofController.text = 'Uploading...';

                                    final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(ref,
                                        docType: 'organization/user/doc',
                                        orgEnrollId: widget.userEnrollmentId.toUpperCase(),
                                        allowPdf: true,
                                        onlyPdf: true);
                                    if (document != null) {
                                      _addrProofController.text = document['name'] ?? '';
                                      _addrUrlController.text = document['url'] ?? '';
                                    } else {
                                      _addrProofController.clear();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: defaultPadding),
                              const Divider(color: AxleColors.axleShadowColor),
                              const SizedBox(height: defaultPadding),
                              // * Communication Info
                              Text(HomeConstants.communicationInfo,
                                  style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: defaultPadding),
                              Wrap(
                                runSpacing: defaultPadding,
                                spacing: defaultPadding,
                                crossAxisAlignment: WrapCrossAlignment.end,
                                runAlignment: WrapAlignment.start,
                                children: [
                                  Visibility(
                                    visible: true,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(InputFormConstants.mobileNumberFieldLabel,
                                            style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 10.0),
                                        Text(widget.userData.data?.message?.contactNumber ?? '',
                                            style: AxleTextStyle.phoneNuberStyle),
                                        Visibility(
                                          visible: otpvisibility,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(context.loc.resendOtpQuestion,
                                                  style: AxleTextStyle.resendOTPQuestionStyle),
                                              TextButton(
                                                onPressed: resetTimerState == 0
                                                    ? () async {
                                                        ref.read(resetSecondsProvider.notifier).startTimer();
                                                        AxleLoader.show(context);

                                                        bool res = await ref
                                                            .read(userControllerProvider)
                                                            .generateLqTagOtp(
                                                                userEnrollId: widget.userEnrollmentId,
                                                                orgEnrollId: org?.enrollmentId ?? '');
                                                        if (res) {
                                                          ref.read(tagOtpVisibilityProvider.notifier).setToTrue();
                                                        }

                                                        AxleLoader.hide();
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
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: !otpvisibility,
                                    child: AxleOutlineButton(
                                      buttonText: 'Generate OTP',
                                      buttonWidth: isMobile ? 150 : 250,
                                      buttonHeight: isMobile ? 40 : 60,
                                      onPress: isAlreadyenabled && !isStatusPending
                                          ? null
                                          : () async {
                                              AxleLoader.show(context);

                                              bool res = await ref.read(userControllerProvider).generateLqTagOtp(
                                                  userEnrollId: widget.userEnrollmentId,
                                                  orgEnrollId: org?.enrollmentId ?? '');
                                              if (res) {
                                                ref.read(tagOtpVisibilityProvider.notifier).setToTrue();
                                              }

                                              AxleLoader.hide();
                                            },
                                    ),
                                  ),
                                  Visibility(
                                    visible: otpvisibility,
                                    child: SizedBox(
                                      width: isMobile ? availabeWidth : availabeWidth * 50 / 100,
                                      child: OTPField(
                                        otpLabel: 'Enter OTP',
                                        mainAlignment: MainAxisAlignment.start,
                                        fieldWidth: isMobile ? null : screenWidth * 2.5 / 100,
                                        onChange: (val) {
                                          // log(val);
                                        },
                                        onFieldSubmit: (val) {
                                          _otpController.text = val;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 30.0),
                              Row(
                                mainAxisAlignment: isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                                children: [
                                  isAlreadyenabled
                                      ? const SizedBox()
                                      : AxleOutlineButton(
                                          buttonWidth: isMobile ? screenWidth * 38 / 100 : 200,
                                          buttonText: HomeConstants.cancelBT,
                                          buttonStyle: AxleTextStyle.saveAndContinuePrimaryStyle,
                                          onPress: () {
                                            context.router.pushNamed(RouteUtils.getStaffsPath());
                                          },
                                        ),
                                  const SizedBox(width: 12.0),
                                  AxlePrimaryButton(
                                    buttonWidth: isMobile ? screenWidth * 38 / 100 : 200,
                                    buttonText: isStatusPending
                                        ? 'Retry'
                                        : isAlreadyenabled
                                            ? "Enabled"
                                            : HomeConstants.submitBT,
                                    buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                    onPress: isAlreadyenabled && !isStatusPending
                                        ? null
                                        : () async {
                                            if (addPPIFormKey.currentState!.validate()) {
                                              lqform.AddLqTaginputModel form = getFormInputs();
                                              AxleLoader.show(context);

                                              bool res =
                                                  await ref.read(userControllerProvider).addLqTagService(inputs: form);
                                              AxleLoader.hide();
                                              if (res) {
                                                // await ref
                                                //     .read(userControllerProvider)
                                                //     .getUserByEnrolmentId(userEnrolmentId: widget.userEnrollmentId);
                                                widget.onPress!();
                                              }
                                            } else {
                                              log('.....................');
                                            }
                                          },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
    );
  }

  lqform.AddLqTaginputModel getFormInputs() {
    return lqform.AddLqTaginputModel(
      otp: _otpController.text,
      userEnrollmentId: widget.userEnrollmentId,
      organizationEnrollmentId: org?.enrollmentId ?? '',
      kycDocuments: lqform.KycDocuments(
        addressProof: lqform.AddressProof(url: _addrUrlController.text),
        pan: lqform.Pan(documentNo: _panController.text.toUpperCase()),
      ),
      gender: _genderController.text,
      lastName: _lastNameController.text,
      firstName: _firstNameController.text,
      emailAddress: _emailController.text,
      title: _salutationController.text,
      addresses: {
        "addressAsPerAadhar": {
          "address1": _address1ControllerP.text,
          "address2": _address2ControllerP.text,
          "address3": _address3ControllerP.text,
          "city": _cityControllerP.text,
          "state": _stateControllerP.text,
          "country": _countryControllerP.text,
          "pinCode": _pincodeControllerP.text,
        }
      },
      communicationInfo: [
        lqform.CommunicationInfo(emailId: _emailController.text, notification: true),
      ],
      dateInfo: [
        lqform.DateInfo(date: dobDate.toString(), dateType: 'DOB'),
      ],
    );
  }

  bool getBooleanType(String text) {
    switch (text.toLowerCase()) {
      case 'yes':
        return true;
      case 'no':
        return false;
      default:
        return false;
    }
  }

  @override
  void dispose() {
    // Kit Number Controller
    _kitNumberController.dispose();
    // Personal Number Controller
    _salutationController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _dobController.dispose();

    // Permanent Address controllers
    _address2ControllerP.dispose();
    _address3ControllerP.dispose();
    _address1ControllerP.dispose();
    _cityControllerP.dispose();
    _stateControllerP.dispose();
    _countryControllerP.dispose();
    _pincodeControllerP.dispose();

    _otpController.dispose();
    _emailController.dispose();

    super.dispose();
  }
}
