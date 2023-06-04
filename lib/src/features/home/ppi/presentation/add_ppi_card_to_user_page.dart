import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_account_info_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:axlerate/src/features/home/ppi/domain/add_ppi_service_to_user_input_model.dart';
import 'package:axlerate/src/features/home/ppi/presentation/controllers/ppi_controller.dart';
import 'package:axlerate/src/features/home/ppi/presentation/controllers/ppi_ui_controller.dart';
import 'package:axlerate/src/features/home/ppi/presentation/widgets/ppi_address_form.dart';
import 'package:axlerate/src/localizations/l10n.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';

class AddPpiCardToUserPage extends ConsumerStatefulWidget {
  const AddPpiCardToUserPage({
    super.key,
    // required this.userId,
    // required this.organizationID,
    required this.userData,
    required this.orgenrollIdOfUser,
    required this.userEnrollmentId,
    required this.onPress,
  });

  // final UserID userId;
  // final OrganizationID organizationID;
  // final OrgEntityID orgEntityID;
  final String userEnrollmentId;
  final String orgenrollIdOfUser;
  final UpdatedUserByEnrolmentIdModel userData;
  final void Function()? onPress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPpiPageState();
}

class _AddPpiPageState extends ConsumerState<AddPpiCardToUserPage> {
  Future<UpdatedUserByEnrolmentIdModel>? updatedUserFuture;
  final GlobalKey<FormState> addPPIFormKey = GlobalKey<FormState>();

  // Kit Number Controller
  // final TextEditingController _kitNumberController = TextEditingController();
  // Personal Number Controller
  final TextEditingController _salutationController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _marriatalStatusController = TextEditingController();
  final TextEditingController _employementTypeController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? dob;

  final TextEditingController _isIndependentController = TextEditingController();
  final TextEditingController _isMinorController = TextEditingController();
  final TextEditingController _isNriController = TextEditingController();

  // Permanent Address controllers
  final TextEditingController _address2ControllerP = TextEditingController();
  final TextEditingController _address3ControllerP = TextEditingController();
  final TextEditingController _address1ControllerP = TextEditingController();
  final TextEditingController _cityControllerP = TextEditingController();
  final TextEditingController _stateControllerP = TextEditingController();
  final TextEditingController _countryControllerP = TextEditingController(text: 'India');
  final TextEditingController _pincodeControllerP = TextEditingController();
  // Communication Address controllers
  final TextEditingController _address2ControllerC = TextEditingController();
  final TextEditingController _address3ControllerC = TextEditingController();
  final TextEditingController _address1ControllerC = TextEditingController();
  final TextEditingController _cityControllerC = TextEditingController();
  final TextEditingController _stateControllerC = TextEditingController();
  final TextEditingController _countryControllerC = TextEditingController(text: 'India');
  final TextEditingController _pincodeControllerC = TextEditingController();
  // Communication Info Controller
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  //KYC Info
  final TextEditingController _panNo = TextEditingController();

  bool isAlreadyenabled = false;
  OrgDoc? org;
  // UserDoc? user;
  // UpdatedUserByEnrolmentIdModel? userData;
  late String userEntityId = '';
  bool isMobile = false;
  double screenWidth = 0.0;
  double availabeWidth = 0.0;
  // UserService? ppiService;
  UserService? userService;
  UserAccountInfoModel? userAccInfo;

  String? title;

  bool isdropdowntitletrue = false;

  bool isCheckSameAddress = false;

  // UserService? lqTagService;

  @override
  void initState() {
    getUserServiceList(widget.userData);

    super.initState();
  }

  autofill() {
    if (userService != null) {
      // _kitNumberController.text = userAccInfo?.data != null ? userAccInfo?.data?.message.kitNumber ?? '' : '';
      _salutationController.text = userService?.title ?? '';

      _firstNameController.text = userService?.firstName ?? '';
      // _middleNameController.text = ppiService?.
      _lastNameController.text = userService?.lastName ?? '';
      _genderController.text = userService?.gender ?? '';
      // _marriatalStatusController.text = ppiService?.
      _employementTypeController.text = userService?.employmentType ?? '';
      _dobController.text =
          (userService != null && userService!.dateInfo.isNotEmpty) ? userService!.dateInfo.first.date : '';
      try {
        dob = DateTime.parse(userService?.dateOfBirth ?? '');
      } catch (e) {
        log(e.toString());
      }
      _panNo.text = userService?.panNumber ?? '';

      _isIndependentController.text = userService?.isDependant == false ? 'Yes' : 'No';
      _isMinorController.text = userService?.isMinor == true ? 'Yes' : 'No';
      _isNriController.text = userService?.isNriCustomer == true ? 'Yes' : 'No';

      _address1ControllerP.text = userService?.addressInfo != null ? userService?.addressInfo.first.address1 ?? '' : '';
      _address2ControllerP.text = userService?.addressInfo.first.address2 ?? '';
      _address3ControllerP.text = userService?.addressInfo.first.address3 ?? '';
      _cityControllerP.text = userService?.addressInfo.first.city ?? '';
      _stateControllerP.text = userService?.addressInfo.first.state ?? '';
      _countryControllerP.text = userService?.addressInfo.first.country ?? '';
      _pincodeControllerP.text = userService?.addressInfo.first.pinCode ?? '';

      _address1ControllerC.text = userService?.addressInfo.last.address1 ?? '';
      _address2ControllerC.text = userService?.addressInfo.last.address2 ?? '';
      _address3ControllerC.text = userService?.addressInfo.last.address3 ?? '';
      _cityControllerC.text = userService?.addressInfo.last.city ?? '';
      _stateControllerC.text = userService?.addressInfo.last.state ?? '';
      _countryControllerC.text = userService?.addressInfo.last.country ?? '';
      _pincodeControllerC.text = userService?.addressInfo.last.pinCode ?? '';
      _emailController.text = userService?.communicationInfo.first.emailId ?? '';
    }
    isAlreadyenabled = userService != null ? true : false;
    setState(() {});
  }

  UserService? getUserServiceList(UpdatedUserByEnrolmentIdModel userData) {
    try {
      for (OrganizationUpdated e in userData.data?.message?.organizations ?? []) {
        userService = getOrgServiceFromUserEnrollId(
          e,
          "PPI",
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

  getEntityIdFromOrgList(String userEnrolmentId) async {
    String result = '';

    try {
      for (OrganizationUpdated e in widget.userData.data?.message?.organizations ?? []) {
        result = getOrgServiceFromUserEnrollId(e, "PPI", issuerName: "LIVQUIK")?.userEntityId ?? '';
        if (result.isNotEmpty) {
          fetchUserCardPreference(result);
          break;
        }
      }
    } catch (e) {
      return result;
    }
    log('The Result Entity ID is -> $result');
    return userEntityId = result;
  }

  fetchUserCardPreference(String? userEntityId) async {
    // log('I Got Called');
    // ref.read(userAccountInfoStateProvider.notifier).state = null;
    if (userEntityId != null && userEntityId.isNotEmpty) {
      userAccInfo = await ref.read(userControllerProvider).getUserAccountInfo(
            userEntityId: userEntityId,
          );
    }
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

    final resetTimerState = ref.watch(resetSecondsProvider);
    final otpvisibility = ref.watch(ppiOtpVisibilityProvider);

    return SingleChildScrollView(
        child: org == null
            ? AxleLoader.axleProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: getOrgService(org, 'PPI') == null
                    ? const AxleErrorWidget(
                        titleStr: 'Please enable prepaid card service in organization level',
                      )
                    : Form(
                        key: addPPIFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if (!isAlreadyenabled)
                            //   Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(InputFormConstants.kitNumberLabel,
                            //           style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                            //       const SizedBox(height: 10.0),
                            //       Text(HomeConstants.kitNumberMandatoryText,
                            //           overflow: TextOverflow.ellipsis,
                            //           style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey),
                            //           maxLines: 2),
                            //       const SizedBox(height: 10.0),
                            //       AxleFormTextField(
                            //         fieldHeading: InputFormConstants.kitNumberLabel,
                            //         fieldHint: InputFormConstants.kitNumberHint,
                            //         fieldWidth: isMobile ? screenWidth : 320,
                            //         fieldController: _kitNumberController,
                            //         validate: Validators(InputFormConstants.kitNumberLabel).required(),
                            //         isRequiredField: true,
                            //         isFieldEnabled: !isAlreadyenabled,
                            //       ),
                            //       const SizedBox(height: 16.0),
                            //       const Divider(color: AxleColors.axleShadowColor),
                            //     ],
                            //   ),

                            const SizedBox(height: 16.0),

                            //* Personal Details
                            Text(HomeConstants.personalDetails,
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
                                    dropDownOptions: addPpiToUserTitleList,
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
                                  inputformatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[A-Za-z]'), replacementString: '')
                                  ],
                                  validate: Validators(InputFormConstants.firstNameLabel).required(),
                                  isRequiredField: true,
                                  isFieldEnabled: !isAlreadyenabled,
                                ),
                                AxleFormTextField(
                                  fieldHeading: InputFormConstants.middleNameLabel,
                                  fieldHint: InputFormConstants.middleNameHint,
                                  fieldController: _middleNameController,
                                  fieldWidth: isMobile ? screenWidth : 320,
                                  lengthLimit: 30,
                                  inputformatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[A-Za-z]'), replacementString: '')
                                  ],
                                  isFieldEnabled: !isAlreadyenabled,
                                ),
                                AxleFormTextField(
                                  fieldHeading: InputFormConstants.lastnameLabel,
                                  fieldHint: InputFormConstants.lastnameHint,
                                  fieldWidth: isMobile ? screenWidth : 320,
                                  lengthLimit: 30,
                                  inputformatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[A-Za-z]'), replacementString: '')
                                  ],
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
                                AbsorbPointer(
                                  absorbing: isAlreadyenabled,
                                  child: AxleSearchDropDownField(
                                    fieldHeading: InputFormConstants.marriatalStatusLabel,
                                    fieldHint: InputFormConstants.marriatalFieldHint,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    fieldController: _marriatalStatusController,
                                    dropDownOptions: marriatalStatusList,
                                    onChanged: (val) {
                                      _marriatalStatusController.text = val;
                                    },
                                    validate: Validators(InputFormConstants.marriatalStatusLabel).required(),
                                    isRequired: true,
                                  ),
                                ),
                                AbsorbPointer(
                                  absorbing: isAlreadyenabled,
                                  child: AxleSearchDropDownField(
                                    fieldHeading: InputFormConstants.employmentTypeLabel,
                                    fieldHint: InputFormConstants.employmentTypeHint,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    fieldController: _employementTypeController,
                                    dropDownOptions: employmentTypeList,
                                    onChanged: (val) {
                                      _employementTypeController.text = val;
                                    },
                                    validate: Validators(InputFormConstants.employmentTypeLabel).required(),
                                    isRequired: true,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: isAlreadyenabled
                                      ? null
                                      : () async {
                                          DateTime? date =
                                              await DatePickerUtil.pickDate(context, showRecentPicked: pickedDateValue);
                                          pickedDateValue = date;
                                          if (date != null) {
                                            _dobController.text = DatePickerUtil.userViewDateFormatter(date);
                                            dob = date;
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
                                AbsorbPointer(
                                  absorbing: isAlreadyenabled,
                                  child: AxleSearchDropDownField(
                                    fieldHeading: InputFormConstants.isIndependentLabel,
                                    fieldHint: InputFormConstants.isIndependentHint,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    fieldController: _isIndependentController,
                                    dropDownOptions: HomeConstants.yesNoList.map((e) => e.label).toList(),
                                    validate: Validators(InputFormConstants.isIndependentLabel).required(),
                                    isRequired: true,
                                    onChanged: (val) {
                                      _isIndependentController.text = val;
                                    },
                                  ),
                                ),
                                AbsorbPointer(
                                  absorbing: isAlreadyenabled,
                                  child: AxleSearchDropDownField(
                                    fieldHeading: InputFormConstants.isMinorLabel,
                                    fieldHint: InputFormConstants.isMinorHint,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    fieldController: _isMinorController,
                                    dropDownOptions: HomeConstants.yesNoList.map((e) => e.label).toList(),
                                    validate: Validators(InputFormConstants.isMinorLabel).required(),
                                    isRequired: true,
                                    onChanged: (val) {
                                      _isMinorController.text = val;
                                    },
                                  ),
                                ),
                                AbsorbPointer(
                                  absorbing: isAlreadyenabled,
                                  child: AxleSearchDropDownField(
                                    fieldHeading: InputFormConstants.isNriLabel,
                                    fieldHint: InputFormConstants.isNriHint,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    fieldController: _isNriController,
                                    dropDownOptions: HomeConstants.yesNoList.map((e) => e.label).toList(),
                                    validate: Validators(InputFormConstants.isNriLabel).required(),
                                    isRequired: true,
                                    onChanged: (val) {
                                      _isNriController.text = val;
                                    },
                                  ),
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
                            //* Communication Address Info
                            Text(HomeConstants.communicationAddress,
                                style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: defaultPadding),
                            Text(HomeConstants.communicationAddressHintText,
                                overflow: TextOverflow.ellipsis,
                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey),
                                maxLines: 2),
                            const SizedBox(height: defaultPadding),
                            Row(
                              children: [
                                Checkbox(
                                  value: isAlreadyenabled ? true : ref.watch(fillAddressStateProvider),
                                  onChanged: isAlreadyenabled
                                      ? null
                                      : (value) {
                                          ref.read(fillAddressStateProvider.notifier).state = value ?? false;
                                          if (value ?? false) {
                                            isCheckSameAddress = true;
                                            fillCommunicationAddress();
                                          } else {
                                            isCheckSameAddress = false;
                                            clearCommunicationAddress();
                                          }
                                        },
                                ),
                                // const SizedBox(width: 10.0),
                                Text(HomeConstants.clickIfSameAsPermanentAddress,
                                    overflow: TextOverflow.ellipsis, style: AxleTextStyle.labelLarge),
                              ],
                            ),
                            const SizedBox(height: defaultPadding),
                            PpiAddressDetailsForm(
                              isCopyAddressWidget: true,
                              isAlreadyenabled: isCheckSameAddress,
                              isCenterAligned: false,
                              address1Controller: _address1ControllerC,
                              address2Controller: _address2ControllerC,
                              address3Controller: _address3ControllerC,
                              cityController: _cityControllerC,
                              stateController: _stateControllerC,
                              countryController: _countryControllerC,
                              pinCodeController: _pincodeControllerC,
                            ),
                            const SizedBox(height: defaultPadding),
                            const Divider(color: AxleColors.axleShadowColor),
                            const SizedBox(height: defaultPadding),

                            //* KYC Info
                            Text("KYC Info", style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: defaultPadding),
                            AxleFormTextField(
                              fieldHeading: "PAN Number",
                              fieldController: _panNo,
                              fieldHint: "PAN Number",
                              isRequiredField: true,
                              validate: Validators("PAN").required().panCard(),
                              inputformatters: [
                                FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]'), replacementString: '')
                              ],
                            ),
                            const SizedBox(height: defaultPadding),
                            // const Divider(color: AxleColors.axleShadowColor),
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
                                // Visibility(
                                //   visible: !otpvisibility,
                                //   child: AxleFormTextField(
                                //     fieldHeading: InputFormConstants.mobileNumberFieldLabel,
                                //     fieldHint: InputFormConstants.mobileNumberFieldHint,
                                //     fieldController: _mobileController,
                                //     fieldWidth: isMobile ? screenWidth : 320,
                                //     validate: Validators(InputFormConstants.mobileNumberFieldLabel).required(),
                                //     isRequiredField: true,
                                //     lengthLimit: 10,
                                //     isOnlyDigits: true,
                                //     textType: TextInputType.number,
                                //   ),
                                // ),
                                Visibility(
                                  visible: true,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(InputFormConstants.mobileNumberFieldLabel,
                                          style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('+91 - ${widget.userData.data?.message?.contactNumber}',
                                              style: AxleTextStyle.phoneNuberStyle),
                                          const SizedBox(width: defaultPadding),
                                          // IconButton(
                                          //   onPressed: () {
                                          //     ref.read(resetSecondsProvider.notifier).resetTimer();
                                          //     ref.read(ppiOtpVisibilityProvider.notifier).toggle();
                                          //   },
                                          //   icon: const Icon(CupertinoIcons.pencil_circle, color: AxleColors.axlePrimaryColor),
                                          // )
                                        ],
                                      ),
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
                                                      bool res = await ref
                                                          .read(ppiControllerProvider)
                                                          .generateUserPPIOtp(
                                                            mobile: widget.userData.data?.message?.contactNumber ?? '',
                                                            userId: widget.userData.data?.message?.id ?? '',
                                                            orgId: org!.id, //widget.organizationID,
                                                            // orgEntityId: user!.organizations.organizationEntityId! //widget.orgEntityID,
                                                          );
                                                      if (res) {
                                                        ref.read(resetSecondsProvider.notifier).startTimer();
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
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Visibility(
                                      visible: !otpvisibility,
                                      child: AxleOutlineButton(
                                        buttonText: 'Generate OTP',
                                        buttonWidth: isMobile ? 150 : 250,
                                        buttonHeight: isMobile ? 40 : 60,
                                        onPress: isAlreadyenabled
                                            ? null
                                            : () async {
                                                // if (_mobileController.text.isEmpty) {
                                                //   Snackbar.error('Please enter mobile number');
                                                //   return;
                                                // }
                                                AxleLoader.show(context);

                                                bool res = await ref.read(ppiControllerProvider).generateUserPPIOtp(
                                                      mobile: widget.userData.data?.message?.contactNumber ?? '',
                                                      userId: widget.userData.data?.message?.id ?? '',
                                                      orgId: org!.id, //widget.organizationID,
                                                      // orgEntityId: user!.organizations.organizationEntityId! //widget.orgEntityID,
                                                    );
                                                if (res) {
                                                  ref.read(ppiOtpVisibilityProvider.notifier).setToTrue();
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
                              ],
                            ),

                            const SizedBox(height: 16.0),
                            AxleFormTextField(
                              fieldHeading: InputFormConstants.emailFieldLabel,
                              fieldHint: InputFormConstants.emailFieldHint,
                              fieldWidth: isMobile ? screenWidth : 320,
                              fieldController: _emailController,
                              validate: Validators(InputFormConstants.emailFieldLabel).required(),
                              isRequiredField: true,
                              isFieldEnabled: !isAlreadyenabled,
                            ),
                            const SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                              children: [
                                if (!isAlreadyenabled)
                                  AxleOutlineButton(
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
                                  buttonText: isAlreadyenabled ? 'Enabled' : HomeConstants.submitBT,
                                  buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                  onPress: isAlreadyenabled
                                      ? null
                                      : () async {
                                          // log('Status -> ${addPPIFormKey.currentState!.validate()}');
                                          if (addPPIFormKey.currentState!.validate()) {
                                            AddPpiServiceToUserInputModel form = getFormDataFromFields();
                                            // debugPrint(form.toMap().toString());
                                            AxleLoader.show(context);

                                            bool res = await ref
                                                .read(ppiControllerProvider)
                                                .addPpiServiceToUser(formInput: form);
                                            if (res && mounted) {
                                              // await ref
                                              //     .read(userControllerProvider)
                                              //     .getUserByEnrolmentId(userEnrolmentId: widget.userEnrollmentId);
                                              widget.onPress!();
                                            }
                                            AxleLoader.hide();
                                          }
                                        },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
              ));
  }

  AddPpiServiceToUserInputModel getFormDataFromFields() {
    return AddPpiServiceToUserInputModel(
        contactNumber: widget.userData.data?.message?.contactNumber ?? '',
        otp: _otpController.text,
        userId: widget.userData.data?.message?.id ?? '', //widget.userId,
        organizationId: org!.id, //widget.organizationID,
        // organizationEntityId: user!.organizations.userEntityId!, //widget.orgEntityID,
        title: _salutationController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        gender: _genderController.text,
        isNriCustomer: getBooleanType(_isNriController.text),
        // kitNumber: _kitNumberController.text,
        isMinor: getBooleanType(_isMinorController.text),
        isDependant: !getBooleanType(_isIndependentController.text),
        maritalStatus: _marriatalStatusController.text.toUpperCase(),
        employmentIndustry: 'INFORMATION_TECHNOLOGY',
        employmentType: _employementTypeController.text,
        addresses: AddPPIAddresses(
          addressAsPerAadhar: AddressAsPerAadhar(
            address1: _address1ControllerP.text,
            address2: _address2ControllerP.text,
            address3: _address3ControllerP.text,
            city: _cityControllerP.text,
            state: _stateControllerP.text,
            country: _countryControllerP.text,
            pinCode: _pincodeControllerP.text,
          ),
          communicationAddress: AddressAsPerAadhar(
            address1: _address1ControllerC.text,
            address2: _address2ControllerC.text,
            address3: _address3ControllerC.text,
            city: _cityControllerC.text,
            state: _stateControllerC.text,
            country: _countryControllerC.text,
            pinCode: _pincodeControllerC.text,
          ),
        ),
        communicationInfo: [
          AddPPICommunicationInfo(
            contactNo: widget.userData.data?.message?.contactNumber ?? '',
            contactNo2: widget.userData.data?.message?.contactNumber ?? '',
            notification: true,
            emailId: _emailController.text,
          ),
        ],
        dateInfo: [
          AddPPIDateInfo(
            dateType: 'DOB',
            date: dob ?? DateTime.now(),
          ),
        ],
        pan: _panNo.text.toUpperCase());
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

  // Clears communication address fields
  void clearCommunicationAddress() {
    _address2ControllerC.clear();
    _address3ControllerC.clear();
    _address1ControllerC.clear();
    _cityControllerC.clear();
    _stateControllerC.clear();
    _pincodeControllerC.clear();
  }

  // Fills communication address with Permanent Address
  void fillCommunicationAddress() {
    _address2ControllerC.text = _address2ControllerP.text;
    _address3ControllerC.text = _address3ControllerP.text;
    _address1ControllerC.text = _address1ControllerP.text;
    _cityControllerC.text = _cityControllerP.text;
    _stateControllerC.text = _stateControllerP.text;
    _pincodeControllerC.text = _pincodeControllerP.text;
  }

  @override
  void dispose() {
    // Kit Number Controller
    // _kitNumberController.dispose();
    // Personal Number Controller
    _salutationController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _marriatalStatusController.dispose();
    _employementTypeController.dispose();
    _dobController.dispose();
    _isIndependentController.dispose();
    _isMinorController.dispose();
    _isNriController.dispose();

    // Permanent Address controllers
    _address2ControllerP.dispose();
    _address3ControllerP.dispose();
    _address1ControllerP.dispose();
    _cityControllerP.dispose();
    _stateControllerP.dispose();
    _countryControllerP.dispose();
    _pincodeControllerP.dispose();
    // Communication Address controllers
    _address2ControllerC.dispose();
    _address3ControllerC.dispose();
    _address1ControllerC.dispose();
    _cityControllerC.dispose();
    _stateControllerC.dispose();
    _countryControllerC.dispose();
    _pincodeControllerC.dispose();
    // Communication Info Controller
    _mobileController.dispose();
    _otpController.dispose();
    _emailController.dispose();

    super.dispose();
  }
}
