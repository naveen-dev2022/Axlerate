import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/kyc_type.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_file_picker.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/form_widgets/address_details_form_request.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/services/domain/fuel_service_input_model.dart';
import 'package:axlerate/src/features/home/services/domain/fuel_service_input_retry_model.dart';
import 'package:axlerate/src/features/home/services/domain/fuel_service_input_update_model.dart';
import 'package:axlerate/src/features/home/services/domain/tag_document_model.dart';
import 'package:axlerate/src/features/home/services/domain/verify_org_kyc_input_model.dart';
import 'package:axlerate/src/features/home/services/presentation/controller/service_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/tag_documnets_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const gstcertStr = 'GST Registration Certificate';
const panTextStr = 'PAN Card';

class AddFuelServiceToOrganization extends ConsumerStatefulWidget {
  const AddFuelServiceToOrganization({
    super.key,
    required this.orgId,
    required this.orgEnrollId,
    required this.org,
    required this.isFuelEnabled,
    required this.orgType,
  });

  final String orgId;
  final String orgEnrollId;
  final OrgDoc? org;
  final bool isFuelEnabled;
  final OrgType orgType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddFuelServiceToOrganizationState();
}

class _AddFuelServiceToOrganizationState extends ConsumerState<AddFuelServiceToOrganization> {
  final GlobalKey<FormState> enableFuelForOrgKey = GlobalKey<FormState>();

  final TextEditingController omcNameController = TextEditingController(text: 'HPCL-Drive Track Plus');
  final TextEditingController panCardFieldController = TextEditingController();
  final TextEditingController gstFieldController = TextEditingController();
  final TextEditingController selectedIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dateFieldController = TextEditingController();
  DateTime? dob;

  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController(text: 'India');
  final TextEditingController pinCodeController = TextEditingController();

  final TextEditingController rejReasoncontroller = TextEditingController();

  final TextEditingController organizationController = TextEditingController();

  final TextEditingController panCardController = TextEditingController();
  final TextEditingController panUrl = TextEditingController();

  final TextEditingController gstCertcontroller = TextEditingController();
  final TextEditingController gstUrl = TextEditingController();

  // OrgType currentType = OrgType.dummy;
  OrganizationService? fuelData;
  bool isEditable = false;

  String regCorporateExceptionDisplayMsg = '';

  @override
  void dispose() {
    omcNameController.dispose();
    panCardFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // currentType = ref.read(localStorageProvider).getOrgType();
    if (widget.isFuelEnabled == false) {
      isEditable = true;
    }
    fuelData = getOrgService(widget.org, 'FUEL');
    if (fuelData != null) {
      // final fuelData = widget.org;
      if (widget.org != null) {
        panCardFieldController.text = fuelData?.panNumber ?? '';
        gstFieldController.text = fuelData?.gstinNumber ?? '';
        omcNameController.text = 'HPCL-Drive Track Plus';
        emailController.text = fuelData?.email ?? '';
        mobileController.text = fuelData?.mobileNumber ?? '';
        dateFieldController.text = DatePickerUtil.yearMonthDateFormatter(widget.org?.incorporateDate ?? DateTime.now());
        address1Controller.text = fuelData?.addressInfo?.addressLine1 ?? '';
        address2Controller.text = fuelData?.addressInfo?.addressLine2 ?? '';
        cityController.text = fuelData?.addressInfo?.city ?? '';
        stateController.text = fuelData?.addressInfo?.state ?? '';
        countryController.text = fuelData?.addressInfo?.country ?? '';
        pinCodeController.text = fuelData?.addressInfo?.zipCode ?? '';
        panCardController.text = fuelData?.kycDocuments?.panProof?.url.isNotEmpty ?? false ? "UPLOADED" : '';
        panUrl.text = fuelData?.kycDocuments?.panProof?.url ?? '';

        gstCertcontroller.text = fuelData?.kycDocuments?.gstinProof?.url.isNotEmpty ?? false ? "UPLOADED" : '';
        gstUrl.text = fuelData?.kycDocuments?.gstinProof?.url ?? '';
        regCorporateExceptionDisplayMsg = fuelData?.regCorporateException?.displayMessage ?? '';
      }
    }

    super.initState();
  }

  double availableWidth = 0.0;

  bool isPartnerAdmin = false;

  String partnerOrgEnrollmentId = '';

  String partnerOrgId = '';
  DateTime? pickedDateValue;

  KycType currentKycType = KycType.kycPending;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    // OrganizationService? getOrgServiceData = getOrgService(widget.org, 'FUEL');
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }
    if (widget.orgType == OrgType.partner) {
      isPartnerAdmin = true;
      partnerOrgEnrollmentId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      partnerOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      organizationController.text = partnerOrgEnrollmentId;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: enableFuelForOrgKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (fuelData?.kycStatus == "PENDING" && regCorporateExceptionDisplayMsg.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      regCorporateExceptionDisplayMsg,
                      style: AxleTextStyle.bodyLarge.copyWith(color: Colors.red),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Primary Details",
                      style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    (widget.orgType == OrgType.axlerate && widget.isFuelEnabled && fuelData?.kycStatus != "APPROVED")
                        ? ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isEditable ? Colors.grey : Colors.blue,
                            ),
                            onPressed: () {
                              isEditable ? isEditable = false : isEditable = true;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 24.0,
                            ),
                            label: const Text('Edit'),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: defaultPadding),
                Wrap(
                  runSpacing: defaultPadding,
                  spacing: defaultPadding,
                  children: [
                    // AxleSearchDropDown(
                    //   fieldHeading: 'OMC Name',
                    //   fieldHint: 'Select OMC Name',
                    //   fieldController: omcNameController,
                    //   defaultName: omcNameController.text,
                    //   fieldWidth: isMobile ? screenWidth : 320,
                    //   dropDownOptions: omcList,
                    //   validate: Validators('OMC Name').required(),
                    //   isRequired: true,
                    //   onChanged: isAlreadyAdded
                    //       ? (_) {}
                    //       : (val) {
                    //           omcNameController.text = val.value ?? '';
                    //           // log("message ${val.name}");
                    //           // log("message ${val.value}");
                    //           // log("message ${omcNameController.text}");
                    //         },
                    //   isEnabled: !isAlreadyAdded,
                    // ),
                    AxleFormTextField(
                        fieldHeading: 'OMC Name',
                        fieldHint: 'Enter OMC Name',
                        fieldController: omcNameController,
                        fieldWidth: isMobile ? screenWidth : 320,
                        validate: Validators('OMC Name').required(),
                        isRequiredField: true,
                        isFieldEnabled: false),
                    AxleFormTextField(
                      fieldHeading: "PAN Number",
                      fieldHint: "Enter PAN Number",
                      validate: Validators('PAN Number').required().min(10).max(10),
                      fieldAction: TextInputAction.done,
                      inputformatters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      fieldWidth: isMobile ? screenWidth : 320,
                      fieldController: panCardFieldController,
                      lengthLimit: 10,
                      isRequiredField: true,
                      isFieldEnabled: !widget.isFuelEnabled || isEditable,
                    ),
                    AxleFormTextField(
                      fieldHeading: "GST Number",
                      fieldHint: "Enter GST Number",
                      fieldAction: TextInputAction.done,
                      inputformatters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                        LengthLimitingTextInputFormatter(15),
                      ],
                      fieldWidth: isMobile ? screenWidth : 320,
                      fieldController: gstFieldController,
                      lengthLimit: 15,
                      isFieldEnabled: !widget.isFuelEnabled || isEditable,
                    ),
                    AxleFormTextField(
                      fieldHeading: InputFormConstants.emailFieldLabel,
                      fieldHint: InputFormConstants.emailFieldHint,
                      fieldController: emailController,
                      fieldWidth: isMobile ? screenWidth : 320,
                      validate: Validators(InputFormConstants.emailFieldLabel).required().email(),
                      isRequiredField: true,
                      isFieldEnabled: !widget.isFuelEnabled || isEditable,
                    ),
                    AxleFormTextField(
                      fieldHeading: InputFormConstants.mobileNumberFieldLabel,
                      fieldHint: InputFormConstants.mobileNumberFieldHint,
                      fieldController: mobileController,
                      textType: TextInputType.number,
                      lengthLimit: 10,
                      isOnlyDigits: true,
                      validate: Validators(InputFormConstants.mobileNumberFieldLabel).required().min(10).max(10),
                      fieldWidth: isMobile ? screenWidth : 320,
                      isRequiredField: true,
                      isFieldEnabled: !widget.isFuelEnabled || isEditable,
                    ),
                    GestureDetector(
                      onTap: !widget.isFuelEnabled || isEditable
                          ? () async {
                              DateTime? date =
                                  await DatePickerUtil.pickDate(context, showRecentPicked: pickedDateValue);
                              pickedDateValue = date;
                              if (date != null) {
                                dateFieldController.text = DatePickerUtil.userViewDateFormatter(date);
                                dob = date;
                              }
                            }
                          : null,
                      child: AxleFormTextField(
                        fieldHeading: InputFormConstants.dobfieldLabel,
                        fieldHint: InputFormConstants.dobfieldHint,
                        fieldController: dateFieldController,
                        fieldWidth: isMobile ? screenWidth : 320,
                        isFieldEnabled: false,
                        validate: Validators(InputFormConstants.dobfieldLabel).required(),
                        isRequiredField: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: verticalPadding),
                Text(
                  "Communication Details",
                  style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: defaultPadding),

                AddressDetailsFormRequest(
                  address1Controller: address1Controller,
                  address2Controller: address2Controller,
                  cityController: cityController,
                  stateController: stateController,
                  countryController: countryController,
                  pinCodeController: pinCodeController,
                  isAlreadyAdded: widget.isFuelEnabled,
                  isEditable: isEditable,
                ),
                const SizedBox(height: horizontalPadding),

                // * Document Upload Section
                Text(
                  "Upload Documents",
                  style: AxleTextStyle.headingPrimary,
                ),
                const SizedBox(height: defaultPadding),
                Wrap(
                  runSpacing: defaultPadding,
                  spacing: 60.0,
                  children: [
                    // * PAN Card
                    AxleFilePicker(
                      customWidth: isMobile ? screenWidth : 420,
                      labelText: InputFormConstants.docFieldPANproof,
                      isRequiredField: true,
                      showToolTip: true,
                      toolTipText:
                          'The document should be uploaded only in pdf format and should not exceed 1MB in size',
                      controller: panCardController,
                      isEnabled: !widget.isFuelEnabled || isEditable,
                      hintText: "Upload file",
                      validate: (val) {
                        if (panCardController.text.isEmpty) {
                          return 'Document Required';
                        }
                        return null;
                      },
                      onPress: () async {
                        panCardController.text = 'Uploading...';

                        final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(
                          ref,
                          docType: 'organization/fuel-doc',
                          orgEnrollId: widget.orgEnrollId,
                          allowPdf: true,
                          axleFileType: FileType.custom,
                        );
                        if (document != null) {
                          ref.read(tagDocumentsProvider.notifier).addItem(
                                TagDocumentModel(
                                  name: "IDENTITY_PROOF",
                                  url: document['url']!.getTillDoc,
                                ),
                              );
                          panCardController.text = document['name']!;
                          panUrl.text = document['url']!;
                        } else {
                          panCardController.clear();
                        }
                      },
                    ),
                    // *GST registration certificate
                    AxleFilePicker(
                      customWidth: isMobile ? screenWidth : 420,
                      hintText: "Upload file",
                      showToolTip: true,
                      toolTipText:
                          'The document should be uploaded only in pdf format and should not exceed 1MB in size',
                      labelText: InputFormConstants.docFieldGSTproof,
                      controller: gstCertcontroller,
                      isEnabled: !widget.isFuelEnabled || isEditable,
                      onPress: () async {
                        gstCertcontroller.text = 'Uploading...';

                        final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(
                          ref,
                          docType: 'organization/fuel-doc',
                          orgEnrollId: widget.orgEnrollId,
                          allowPdf: true,
                          axleFileType: FileType.custom,
                        );
                        if (document != null) {
                          gstCertcontroller.text = document['name']!;
                          gstUrl.text = document['url']!;
                        } else {
                          gstCertcontroller.clear();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        (fuelData?.kycStatus == "DECLINED")
            ? Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                  children: [
                    AxleOutlineButton(
                      buttonText: InputFormConstants.cancelbuttonText,
                      buttonStyle: AxleTextStyle.outLineButtonStyle,
                      buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                      onPress: () {
                        context.router.pop();
                      },
                    ),
                    const SizedBox(width: 20.0),
                    AxlePrimaryButton(
                      buttonText: "Resubmit",
                      buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                      buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                      onPress: () async {
                        if (enableFuelForOrgKey.currentState!.validate()) {
                          // log('before loader');
                          AxleLoader.show(context);
                          // log('After loader - before request');
                          debugPrint(getFuelInputs.toString());
                          bool res = await ref.read(serviceControlProvider).updateAddFuelServiceToOrganization(
                                getFuelUpdateInput(fuelData),
                              );
                          // log('After hide');
                          debugPrint('The Form Inputs are -> ${getFuelInputs(fuelData).toMap()}');

                          if (res && mounted) {
                            await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(
                                enrolId: widget.orgEnrollId.toUpperCase(), isSetOrgDetailProvider: true);
                          }
                          AxleLoader.hide();
                        }
                      },
                    )
                  ],
                ),
              )
            : (fuelData?.kycStatus == "PENDING")
                ? Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                      children: [
                        AxleOutlineButton(
                          buttonText: InputFormConstants.deny,
                          buttonStyle: AxleTextStyle.outLineButtonStyle,
                          buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                          onPress: () {
                            context.router.pop();
                          },
                        ),
                        const SizedBox(width: 20.0),
                        AxlePrimaryButton(
                          buttonText: InputFormConstants.retry,
                          buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                          buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                          onPress: () async {
                            if (enableFuelForOrgKey.currentState!.validate()) {
                              // log('before loader');
                              AxleLoader.show(context);
                              // log('After loader - before request');
                              debugPrint(getFuelInputs.toString());
                              bool res = await ref.read(serviceControlProvider).retryAddFuelServiceToOrganization(
                                    getFuelRetryInput(fuelData),
                                  );

                              if (res && mounted) {
                                await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(
                                    enrolId: widget.orgEnrollId.toUpperCase(), isSetOrgDetailProvider: true);
                              }
                              AxleLoader.hide();
                            }
                          },
                        )
                      ],
                    ),
                  )
                // : (fuelData?.kycStatus == "APPROVED" &&
                //         fuelData?.businessConfig == false && fuelData?.defaultLimitUpdated == false)
                //     ? (widget.orgType == OrgType.axlerate)
                //         ? Padding(
                //             padding: const EdgeInsets.all(defaultPadding),
                //             child: Row(
                //               mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                //               children: [
                //                 AxleOutlineButton(
                //                   buttonText: InputFormConstants.deny,
                //                   buttonStyle: AxleTextStyle.outLineButtonStyle,
                //                   buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                //                   onPress: () {
                //                     context.router.pop();
                //                   },
                //                 ),
                //                 const SizedBox(width: 20.0),
                //                 AxlePrimaryButton(
                //                   buttonText: InputFormConstants.retry,
                //                   buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                //                   buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                //                   onPress: () async {
                //                     if (enableFuelForOrgKey.currentState!.validate()) {
                //                       // log('before loader');
                //                       AxleLoader.show(context);
                //                       // log('After loader - before request');
                //                       debugPrint(getFuelInputs.toString());
                //                       bool res =
                //                           await ref.read(serviceControlProvider).retryAddFuelServiceToOrganization(
                //                                 getFuelRetryInput(fuelData),
                //                               );

                //                       if (res && mounted) {
                //                         await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(
                //                             enrolId: widget.orgEnrollId.toUpperCase(), isSetOrgDetailProvider: true);
                //                       }
                //                       AxleLoader.hide();
                //                     }
                //                   },
                //                 )
                //               ],
                //             ),
                //           )
                //         : const SizedBox()
                : (fuelData?.kycStatus == "APPROVED" &&
                        fuelData?.businessConfig == false &&
                        fuelData?.defaultLimitUpdated == false)
                    ? (widget.orgType == OrgType.axlerate)
                        ? Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Row(
                              mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                              children: [
                                AxlePrimaryButton(
                                    buttonText: InputFormConstants.enableBusinessConfig,
                                    buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                    buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                                    onPress: () async {
                                      // log('before loader');
                                      AxleLoader.show(context);

                                      bool res =
                                          await ref.read(logisticsControllerProvider).addBusinessConfigWithFuelLimit(
                                                // formInput: fuelBusinessConfigInput(),
                                                orgEnrolId: widget.orgEnrollId,
                                              );
                                      AxleLoader.hide();

                                      if (res && mounted) {
                                        await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(
                                            enrolId: widget.orgEnrollId.toUpperCase(), isSetOrgDetailProvider: true);
                                      }
                                    })
                              ],
                            ),
                          )
                        : const SizedBox()
                    : (fuelData?.kycStatus == "APPROVED")
                        ? Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Row(
                              mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                              children: [
                                AxlePrimaryButton(
                                  buttonText: "Sevice Enabled",
                                  buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                  buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                                  onPress: null,
                                ),
                              ],
                            ),
                          )
                        : (fuelData?.kycStatus == "PENDING_KYC")
                            ? (widget.orgType == OrgType.axlerate)
                                ? Padding(
                                    padding: const EdgeInsets.all(defaultPadding),
                                    child: Row(
                                      mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                                      children: [
                                        AxleOutlineButton(
                                          buttonText: InputFormConstants.deny,
                                          buttonStyle: AxleTextStyle.outLineButtonStyle,
                                          buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                                          onPress: () async {
                                            AxleLoader.show(context);
                                            bool res = await ref.read(serviceControlProvider).verifyOrgKyc(
                                                  getFuelKycInput(kycStatus: 'DECLINED'),
                                                );
                                            if (res && mounted) {
                                              await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(
                                                  enrolId: widget.orgEnrollId.toUpperCase(),
                                                  isSetOrgDetailProvider: true);
                                            }
                                            AxleLoader.hide();
                                          },
                                        ),
                                        const SizedBox(width: 20.0),
                                        AxlePrimaryButton(
                                          buttonText: InputFormConstants.approve,
                                          buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                          buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                                          onPress: () async {
                                            if (enableFuelForOrgKey.currentState!.validate()) {
                                              // log('before loader');
                                              AxleLoader.show(context);

                                              bool res = await ref.read(serviceControlProvider).verifyOrgKyc(
                                                    getFuelKycInput(kycStatus: 'APPROVED'),
                                                  );
                                              AxleLoader.hide();

                                              if (res && mounted) {
                                                await ref
                                                    .read(logisticsControllerProvider)
                                                    .getOrganisationByEnrolmentId(
                                                        enrolId: widget.orgEnrollId.toUpperCase(),
                                                        isSetOrgDetailProvider: true);
                                              }
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Row(
                                  mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                                  children: [
                                    if (fuelData?.kycStatus != "PENDING_KYC")
                                      AxleOutlineButton(
                                        buttonText: InputFormConstants.cancelbuttonText,
                                        buttonStyle: AxleTextStyle.outLineButtonStyle,
                                        buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                                        onPress: () {
                                          context.router.pop();
                                        },
                                      ),
                                    const SizedBox(width: 20.0),
                                    AxlePrimaryButton(
                                      buttonText: fuelData?.kycStatus != "PENDING_KYC" ? "SUBMIT" : "Sevice Enabled",
                                      buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                      buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                                      onPress: fuelData?.kycStatus == "PENDING_KYC"
                                          ? null
                                          : () async {
                                              if (enableFuelForOrgKey.currentState!.validate()) {
                                                // log('before loader');
                                                AxleLoader.show(context);
                                                // log('After loader - before request');
                                                debugPrint(getFuelInputs.toString());
                                                // bool res =
                                                await ref.read(serviceControlProvider).addFuelServiceToOrganization(
                                                      getFuelInputs(fuelData),
                                                    );
                                                // log('After hide');
                                                debugPrint('The Form Inputs are -> ${getFuelInputs(fuelData).toMap()}');

                                                if (mounted) {
                                                  await ref
                                                      .read(logisticsControllerProvider)
                                                      .getOrganisationByEnrolmentId(
                                                          enrolId: widget.orgEnrollId.toUpperCase(),
                                                          isSetOrgDetailProvider: true);
                                                }
                                                AxleLoader.hide();
                                              }
                                            },
                                    ),
                                  ],
                                ),
                              ),
      ],
    );
  }

  FuelServiceInputModel getFuelInputs(OrganizationService? getOrgServiceData) {
    return FuelServiceInputModel(
      serviceType: 'FUEL',
      issuerName: omcNameController.text.split('-').first,
      panNumber: panCardFieldController.text.toUpperCase(),
      gstinNumber: gstFieldController.text.toUpperCase(),
      email: emailController.text,
      contactNumber: mobileController.text,
      addressLine1: address1Controller.text,
      addressLine2: address2Controller.text,
      city: cityController.text,
      state: stateController.text,
      postalCode: pinCodeController.text,
      country: countryController.text,
      dateOfBirth: dob.toString(),
      organizationEnrollmentId: widget.orgEnrollId,
      kycDocuments: gstUrl.text.isNotEmpty
          ? KycDocumentsFuel(
              panProof: PanProof(
                  url: panUrl.text.isEmpty ? getOrgServiceData?.kycDocuments?.panProof?.url ?? '' : panUrl.text),
              gstProof: GstProof(
                url: gstUrl.text,
              ),
            )
          : KycDocumentsFuel(
              panProof: PanProof(
                  url: panUrl.text.isEmpty ? getOrgServiceData?.kycDocuments?.panProof?.url ?? '' : panUrl.text),
            ),
    );
  }

  FuelServiceRetryInputModel getFuelRetryInput(OrganizationService? getOrgServiceData) {
    return FuelServiceRetryInputModel(
      serviceType: 'FUEL',
      issuerName: omcNameController.text.split('-').first,
      organizationEnrollmentId: widget.orgEnrollId,
      // organizationId: widget.orgId,
      panNumber: panCardFieldController.text.toUpperCase(),
      contactNumber: mobileController.text,
      kycDocuments: gstUrl.text.isNotEmpty
          ? RetryFuelKycDocuments(
              panProof: RetryProof(
                  url: panUrl.text.isEmpty ? getOrgServiceData?.kycDocuments?.panProof?.url ?? '' : panUrl.text),
              gstinProof: RetryProof(
                url: gstUrl.text,
              ))
          : RetryFuelKycDocuments(
              panProof: RetryProof(
                  url: panUrl.text.isEmpty ? getOrgServiceData?.kycDocuments?.panProof?.url ?? '' : panUrl.text),
            ),
    );
  }

  VerifyOrgKycInputModel getFuelKycInput({required String kycStatus}) {
    return VerifyOrgKycInputModel(
      // organizationId: widget.orgId,
      organizationEnrollmentId: widget.orgEnrollId,
      kycStatus: kycStatus,
      kycComments: 'Verified',
    );
  }

  FuelServiceUpdateInputModel getFuelUpdateInput(OrganizationService? getOrgServiceData) {
    return FuelServiceUpdateInputModel(
      organizationEnrollmentId: widget.orgEnrollId,
      // organizationId: widget.orgId,
      serviceType: 'FUEL',
      issuerName: omcNameController.text.split('-').first,
      firstName: getOrgServiceData?.firstName ?? '',
      lastName: getOrgServiceData?.lastName ?? '',
      // lastName: 'Mtp',
      panNumber: panCardFieldController.text.toUpperCase(),
      gstinNumber: gstFieldController.text.toUpperCase(),
      email: emailController.text,
      contactNumber: mobileController.text,
      // addressCategory: 'COMMUNICATION',
      addressLine1: address1Controller.text,
      addressLine2: address2Controller.text,
      // addressLine3: addressLine3,
      city: cityController.text,
      state: stateController.text,
      postalCode: pinCodeController.text,
      country: countryController.text,
      dateOfBirth: dateFieldController.text,
      salutationCode: getOrgServiceData?.salutationCode ?? '',
      kycDocuments: gstUrl.text.isNotEmpty
          ? FuelServiceUpdateKycDocuments(
              panProof: UpdateProof(
                  url: panUrl.text.isEmpty ? getOrgServiceData?.kycDocuments?.panProof?.url ?? '' : panUrl.text),
              gstinProof: UpdateProof(
                url: gstUrl.text,
              ))
          : FuelServiceUpdateKycDocuments(
              panProof: UpdateProof(url: panUrl.text),
            ),
    );
  }

  // AddBusinessConfigWithFuelInputModel fuelBusinessConfigInput() {
  //   return AddBusinessConfigWithFuelInputModel(
  //     organizationId: widget.orgId,
  //     organizationEnrollmentId: widget.orgEnrollId,
  //     kycStatus: 'APPROVED',
  //     kycComments: 'Verified',
  //   );
  // }
}
