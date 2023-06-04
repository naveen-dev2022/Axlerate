import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/features/home/form_widgets/address_details_form_request.dart';
import 'package:axlerate/src/features/home/user/domain/retry_user_fuel_card_input_model.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_account_info_model.dart';
import 'package:axlerate/src/features/home/user/domain/user_fuel_card_input_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';

class AddFuelToUserPage extends ConsumerStatefulWidget {
  const AddFuelToUserPage({
    super.key,
    // required this.userId,
    // required this.organizationID,
    required this.userData,
    required this.orgenrollIdOfUser,
    required this.userEnrollmentId,
  });

  // final UserID userId;
  // final OrganizationID organizationID;
  // final OrgEntityID orgEntityID;
  final String userEnrollmentId;
  final String orgenrollIdOfUser;
  final UpdatedUserByEnrolmentIdModel userData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddFuelToUserPageState();
}

class _AddFuelToUserPageState extends ConsumerState<AddFuelToUserPage> {
  Future<UpdatedUserByEnrolmentIdModel>? updatedUserFuture;
  final GlobalKey<FormState> addFuelToUserFormKey = GlobalKey<FormState>();

  // Personal Number Controller
  final TextEditingController _salutationController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? dob;
  final TextEditingController _panController = TextEditingController();
//upload Pancard
  final TextEditingController panCardController = TextEditingController();
  final TextEditingController panUrl = TextEditingController();

  // Permanent Address controllers
  final TextEditingController _address2ControllerP = TextEditingController();
  final TextEditingController _address3ControllerP = TextEditingController();
  final TextEditingController _address1ControllerP = TextEditingController();
  final TextEditingController _cityControllerP = TextEditingController();
  final TextEditingController _stateControllerP = TextEditingController();
  final TextEditingController _countryControllerP = TextEditingController(text: 'India');
  final TextEditingController _pincodeControllerP = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
  OrgType currentType = OrgType.dummy;

  // UserService? lqTagService;

  @override
  void initState() {
    currentType = ref.read(localStorageProvider).getOrgType();
    getUserServiceList(widget.userData);
    super.initState();
  }

  autofill() {
    if (userService != null) {
      _salutationController.text = userService?.salutationCode ?? '';
      _firstNameController.text = userService?.firstName ?? '';
      // _middleNameController.text = userService?.firstName ?? '';
      _lastNameController.text = userService?.lastName ?? '';
      _panController.text = userService?.panNumber ?? '';
      _emailController.text = userService?.email ?? '';
      _dobController.text = userService?.dateOfBirth ?? '';
      try {
        dob = DateTime.parse(userService?.dateOfBirth ?? '');
      } catch (e) {
        log(e.toString());
      }
      _address1ControllerP.text = userService?.addressInfo.first.address1 ?? '';
      _address2ControllerP.text = userService?.addressInfo.first.address2 ?? '';
      _address3ControllerP.text = userService?.addressInfo.first.address3 ?? '';
      _cityControllerP.text = userService?.addressInfo.first.city ?? '';
      _stateControllerP.text = userService?.addressInfo.first.state ?? '';
      _countryControllerP.text = userService?.addressInfo.first.country ?? '';
      _pincodeControllerP.text = userService?.addressInfo.first.pinCode ?? '';
      _pincodeControllerP.text = userService?.addressInfo.first.pinCode ?? '';
      // panCardController.text =
      //       userService?.kycDocuments?.panProof?.url.isNotEmpty ?? false ? "UPLOADED" : '';
    }
    isAlreadyenabled = userService != null ? true : false;
    setState(() {});
  }

  UserService? getUserServiceList(UpdatedUserByEnrolmentIdModel userData) {
    try {
      for (OrganizationUpdated e in userData.data?.message?.organizations ?? []) {
        if (e.organizationEnrollmentId == widget.orgenrollIdOfUser.toUpperCase()) {
          userService = getOrgServiceFromUserEnrollId(
            e,
            "FUEL",
            issuerName: "HPCL",
            organizationEnrollmentId: widget.orgenrollIdOfUser,
          );
          autofill();
          break;
        }
        // log('getUserServiceList $ppiService');
        // log("${ppiService?.addressInfo.last.address1}");

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
        result = getOrgServiceFromUserEnrollId(e, "FUEL", issuerName: "HPCL")?.userEntityId ?? '';
        fetchUserCardPreference(result);
        break;
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

    return SingleChildScrollView(
        child: org == null
            ? AxleLoader.axleProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: getOrgService(org, 'FUEL') == null
                    ? const AxleErrorWidget(
                        titleStr: 'Please enable Fuel card service in organization level',
                      )
                    : Form(
                        key: addFuelToUserFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //* Personal Details
                            Text(HomeConstants.personalDetails,
                                style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10.0),
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
                            const SizedBox(height: defaultPadding),
                            Wrap(
                              runSpacing: defaultPadding,
                              spacing: defaultPadding,
                              children: [
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
                                  fieldHeading: InputFormConstants.middleNameLabel,
                                  fieldHint: InputFormConstants.middleNameHint,
                                  fieldController: _middleNameController,
                                  fieldWidth: isMobile ? screenWidth : 320,
                                  lengthLimit: 30,
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
                            Text(HomeConstants.permanentAddress,
                                style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: defaultPadding),
                            AddressDetailsFormRequest(
                              address1Controller: _address1ControllerP,
                              address2Controller: _address2ControllerP,
                              cityController: _cityControllerP,
                              stateController: _stateControllerP,
                              countryController: _countryControllerP,
                              pinCodeController: _pincodeControllerP,
                              isAlreadyAdded: isAlreadyenabled,
                              isEditable: true,
                            ),

                            // const Divider(color: AxleColors.axleShadowColor),
                            // const SizedBox(height: defaultPadding),
                            // Text(
                            //   "KYC Document",
                            //   style: AxleTextStyle.headingPrimary,
                            // ),
                            // const SizedBox(height: defaultPadding),

                            // // * PAN Card
                            // AxleFilePicker(
                            //   customWidth: isMobile ? screenWidth : 420,
                            //   labelText: InputFormConstants.docFieldPANproof,
                            //   isRequiredField: true,
                            //   showToolTip: true,
                            //   toolTipText:
                            //       'The document should be uploaded only in pdf format and should not exceed 1MB in size',
                            //   controller: panCardController,
                            //   isEnabled: true,
                            //   hintText: "Upload file",
                            //   validate: (val) {
                            //     if (panCardController.text.isEmpty) {
                            //       return 'Document Required';
                            //     }
                            //     return null;
                            //   },
                            //   onPress: () async {
                            //     panCardController.text = 'Uploading...';

                            //     final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(
                            //       ref,
                            //       docType: 'organization/fuel-doc',
                            //       orgEnrollId: widget.orgenrollIdOfUser,
                            //       allowPdf: true,
                            //       axleFileType: FileType.custom,
                            //     );
                            //     if (document != null) {
                            //       ref.read(tagDocumentsProvider.notifier).addItem(
                            //             TagDocumentModel(
                            //               name: "IDENTITY_PROOF",
                            //               url: document['url']!.getTillDoc,
                            //             ),
                            //           );
                            //       panCardController.text = document['name']!;
                            //       panUrl.text = document['url']!;
                            //     } else {
                            //       panCardController.clear();
                            //     }
                            //   },
                            // ),
                            // const SizedBox(height: defaultPadding),
                            // const Divider(color: AxleColors.axleShadowColor),
                            // const SizedBox(height: defaultPadding),

                            // * Communication Info
                            Text(HomeConstants.communicationInfo,
                                style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: defaultPadding),
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
                                    ],
                                  ),
                                ],
                              ),
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
                            (userService?.kycStatus == "PENDING" && currentType == OrgType.axlerate)
                                ? Row(
                                    mainAxisAlignment:
                                        isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                                    children: [
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
                                        buttonText: HomeConstants.reSubmitBT,
                                        buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                        onPress: () async {
                                          // log('Status -> ${addPPIFormKey.currentState!.validate()}');
                                          if (addFuelToUserFormKey.currentState!.validate()) {
                                            RetryAddFuelServiceToUserInputModel form = getRetryFormDataFromFields();
                                            // debugPrint(form.toMap().toString());
                                            AxleLoader.show(context);

                                            //  bool res =
                                            await ref.read(userControllerProvider).retryAddFuelService(inputs: form);
                                            AxleLoader.hide();

                                            if (mounted) {
                                              final orgEnrollId = ref
                                                  .read(sharedPreferenceProvider)
                                                  .getString(Storage.currentlyPickedOrgEnrollId)
                                                  ?.toLowerCase();
                                              context.router.pushNamed('/app/$orgEnrollId/staffs');
                                            }
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
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
                                        buttonText: isAlreadyenabled
                                            ? (userService?.kycStatus == "APPROVED")
                                                ? 'Enabled'
                                                : userService!.kycStatus.toUiCase
                                            : HomeConstants.submitBT,
                                        buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                        onPress: isAlreadyenabled
                                            ? null
                                            : () async {
                                                // log('Status -> ${addPPIFormKey.currentState!.validate()}');
                                                if (addFuelToUserFormKey.currentState!.validate()) {
                                                  AddFuelServiceToUserInputModel form = getFormDataFromFields();
                                                  // debugPrint(form.toMap().toString());
                                                  AxleLoader.show(context);

                                                  //  bool res =
                                                  await ref.read(userControllerProvider).addFuelService(inputs: form);
                                                  AxleLoader.hide();
                                                  if (mounted) {
                                                    // final orgEnrollId = ref
                                                    //     .read(sharedPreferenceProvider)
                                                    //     .getString(Storage.currentlyPickedOrgEnrollId)
                                                    //     ?.toLowerCase();
                                                    // context.go('/app/$orgEnrollId/staffs');
                                                    await ref
                                                        .read(userControllerProvider)
                                                        .getUserByEnrolmentId(userEnrolmentId: widget.userEnrollmentId);
                                                  }
                                                }
                                              },
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
              ));
  }

  AddFuelServiceToUserInputModel getFormDataFromFields() {
    return AddFuelServiceToUserInputModel(
      organizationEnrollmentId: org?.enrollmentId ?? '',
      serviceType: "FUEL",
      userEnrollmentId: widget.userEnrollmentId,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      dateOfBirth: dob.toString(),
      salutationCode: _salutationController.text,
      addressCategory: 'COMMUNICATION',
      addressLine1: _address1ControllerP.text,
      addressLine2: _address2ControllerP.text,
      city: _cityControllerP.text,
      country: _countryControllerP.text,
      state: _stateControllerP.text,
      postalCode: _pincodeControllerP.text,
      contactNumber: widget.userData.data?.message?.contactNumber ?? '',
      email: _emailController.text,
      panNumber: _panController.text,
    );
  }

  RetryAddFuelServiceToUserInputModel getRetryFormDataFromFields() {
    return RetryAddFuelServiceToUserInputModel(
      serviceType: "FUEL",
      issuerName: "HPCL",
      organizationEnrollmentId: org?.enrollmentId ?? '',
      // organizationId: org!.id,
      // userId: widget.userData.data?.message?.id ?? '',
      userEnrollmentId: widget.userEnrollmentId,
      panNumber: _panController.text,
      // panNumber: 'SEEFF8357R',
      // kycDocuments: RetryAddFuelServiceToUserKycDocuments(
      //   panProof: RetryAddFuelServiceToUserPanProof(
      //     url: panUrl.text,
      //   ),
      // ),
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
    // Personal Number Controller
    _salutationController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();

    // Permanent Address controllers
    _address2ControllerP.dispose();
    _address3ControllerP.dispose();
    _address1ControllerP.dispose();
    _cityControllerP.dispose();
    _stateControllerP.dispose();
    _countryControllerP.dispose();
    _pincodeControllerP.dispose();

    _mobileController.dispose();
    _emailController.dispose();

    super.dispose();
  }
}
