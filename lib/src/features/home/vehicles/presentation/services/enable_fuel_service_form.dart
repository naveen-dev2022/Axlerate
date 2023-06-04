import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_widgets/axle_file_picker.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/enable_fuel_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/verify_veh_kyc_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/get_vehicle_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const otherProofsStr = 'Other Proofs';
const rcBookStr = 'RC Book';

class EnableFuelServiceForm extends ConsumerStatefulWidget {
  const EnableFuelServiceForm({
    super.key,
    required this.orgId,
    required this.orgEnrollId,
    required this.vehicleRegNumber,
    required this.vehicleEnrollId,
    required this.vehicleDoc,
    required this.isFuelEnabled,
  });

  final String orgId;
  final String orgEnrollId;
  final String vehicleRegNumber;
  final String vehicleEnrollId;
  final Vehicle vehicleDoc;
  final bool isFuelEnabled;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnableFuelServiceFormState();
}

class _EnableFuelServiceFormState extends ConsumerState<EnableFuelServiceForm> {
  final GlobalKey<FormState> enableFuelForVehicleKey = GlobalKey<FormState>();

  final TextEditingController omcNameController = TextEditingController(text: 'HPCL - Drive Track Plus');
  final TextEditingController vehicleMakeFieldController = TextEditingController();
  final TextEditingController profileIdController = TextEditingController();
  final TextEditingController profileIdAxleController = TextEditingController();

  final TextEditingController rcBookcontroller = TextEditingController();
  final TextEditingController rcBookUrl = TextEditingController();

  // final TextEditingController otherProofcontroller = TextEditingController();
  // final TextEditingController otherProofUrl = TextEditingController();

  // bool isAlreadyAdded = false;
  OrgType currentType = OrgType.dummy;

  @override
  void dispose() {
    omcNameController.dispose();
    vehicleMakeFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    currentType = ref.read(localStorageProvider).getOrgType();

    if (widget.isFuelEnabled) {
      final fuelData = getVehicleService(widget.vehicleDoc, 'FUEL');
      vehicleMakeFieldController.text = fuelData?.vehicleMake ?? '';
      profileIdController.text = fuelData?.profileId ?? '';
      profileIdAxleController.text = fuelData?.axle ?? '';
      omcNameController.text = fuelData?.issuerName ?? '';

      rcBookUrl.text = fuelData?.kycDocuments?.rcBook?.url ?? '';

      rcBookcontroller.text = fuelData?.kycDocuments?.rcBook?.docUploadStatus ?? '';

      // otherProofcontroller.text = widget.vehicleDoc.vehicleImage?.frontView != null ? otherProofsStr : '';

      // otherProofUrl.text = widget.vehicleDoc.vehicleImage?.frontView?.url ?? '';
    }

    // if (getVehicleService(widget.vehicleDoc, 'FUEL') != null) {
    //   isAlreadyAdded = true;
    // }
    super.initState();
  }

  double availableWidth = 0.0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    Service? getVehServiceData = getVehicleService(widget.vehicleDoc, 'FUEL');

    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: enableFuelForVehicleKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Primary Details", style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: defaultPadding),
                Wrap(
                  runSpacing: defaultPadding,
                  spacing: defaultPadding,
                  children: [
                    AbsorbPointer(
                      absorbing: widget.isFuelEnabled,
                      child: AxleSearchDropDown(
                        key: UniqueKey(),
                        fieldHeading: 'OMC Name',
                        fieldHint: 'Select OMC Name',
                        fieldController: omcNameController,
                        defaultName: omcNameController.text,
                        fieldWidth: isMobile ? screenWidth : 300,
                        dropDownOptions: omcList,
                        validate: Validators('OMC Name').required(),
                        isRequired: true,
                        onChanged: (val) {
                          omcNameController.text = val.value ?? '';
                        },
                        // isEnabled: !isAlreadyAdded,
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: widget.isFuelEnabled,
                      child: AxleSearchDropDown(
                        fieldHeading: 'Vehicle Make',
                        fieldHint: 'Select Vehicle Make',
                        fieldController: vehicleMakeFieldController,
                        defaultName: vehicleMakeFieldController.text,
                        fieldWidth: isMobile ? screenWidth : 300,
                        dropDownOptions: vehicleMakeList,
                        validate: Validators('Vehicle Make').required(),
                        isRequired: true,
                        onChanged: (val) {
                          vehicleMakeFieldController.text = val.value ?? '';
                          // log("message ${val.name}");
                          // log("message ${val.value}");
                        },
                        // isEnabled: !isAlreadyAdded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding),

                Wrap(
                  children: [
                    AbsorbPointer(
                      absorbing: widget.isFuelEnabled,
                      child: AxleSearchDropDown(
                        fieldHeading: 'Profle ID',
                        fieldHint: 'Select Tag Class',
                        fieldController: profileIdController,
                        defaultName: profileIdController.text,
                        fieldWidth: isMobile ? screenWidth : 300,
                        dropDownOptions: vehicleProfileIdList,
                        validate: Validators('Profle ID').required(),
                        isRequired: true,
                        onChanged: (val) {
                          profileIdController.text = val.name ?? '';
                          profileIdAxleController.text = val.value ?? '';
                        },
                        isEnabled: !widget.isFuelEnabled,
                      ),
                    ),
                  ],
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
                  spacing: defaultPadding,
                  children: [
                    // * RC Book
                    AxleFilePicker(
                      customWidth: isMobile ? screenWidth : 420,
                      labelText: InputFormConstants.docFieldRCproof,
                      isRequiredField: true,
                      showToolTip: true,
                      toolTipText:
                          'The document should be uploaded only in pdf format and should not exceed 1MB in size',
                      controller: rcBookcontroller,
                      hintText: "Upload file",
                      isEnabled: !widget.isFuelEnabled,
                      validate: (val) {
                        if (rcBookcontroller.text.isEmpty) {
                          return 'Document Required';
                        }
                        return null;
                      },
                      onPress: () async {
                        rcBookcontroller.text = 'Uploading...';

                        final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(
                          ref,
                          docType: 'organization/vehicle-fuel-doc',
                          orgEnrollId: widget.orgEnrollId,
                          allowPdf: true,
                        );
                        if (document != null) {
                          // ref.read(tagDocumentsProvider.notifier).addItem(
                          //       TagDocumentModel(
                          //         name: "IDENTITY_PROOF",
                          //         url: document['url']!.getTillDoc,
                          //       ),
                          //     );
                          rcBookcontroller.text = document['name']!;
                          rcBookUrl.text = document['url']!;
                        } else {
                          rcBookcontroller.clear();
                        }
                      },
                    ),
                    // * Other proof     //have to enable if needed

                    // AxleFilePicker(
                    //   customWidth: isMobile ? screenWidth : 420,
                    //   hintText: "Upload file",
                    //   showToolTip: true,
                    //   toolTipText:
                    //       'The document should be uploaded only in pdf format and should not exceed 1MB in size',
                    //   labelText: InputFormConstants.docFieldOtherProof,
                    //   // isRequiredField: true,
                    //   controller: otherProofcontroller,
                    //   isEnabled: otherProofcontroller.text != otherProofsStr,
                    //   // validate: (val) {
                    //   //   if (frontViewcontroller.text.isEmpty) {
                    //   //     return 'Image Required';
                    //   //   }
                    //   // },
                    //   onPress: otherProofcontroller.text == otherProofsStr
                    //       ? () {}
                    //       : () async {
                    //           otherProofcontroller.text = 'Uploading...';

                    //           final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(
                    //             ref,
                    //             docType: 'organization/vehicle-fuel-doc',
                    //             orgEnrollId: widget.orgEnrollId,
                    //             allowPdf: true,
                    //             axleFileType: FileType.custom,
                    //           );
                    //           if (document != null) {
                    //             // ref.read(tagDocumentsProvider.notifier).addItem(
                    //             //       TagDocumentModel(
                    //             //         name: "ADDRESS_PROOF",
                    //             //         url: document['url']!.getTillDoc,
                    //             //       ),
                    //             //     );
                    //             otherProofcontroller.text = document['name']!;
                    //             otherProofUrl.text = document['url']!;
                    //           } else {
                    //             otherProofcontroller.clear();
                    //           }
                    //         },
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
        (getVehServiceData != null && getVehServiceData.kycStatus == "PENDING_KYC" && currentType == OrgType.axlerate)
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
                        if (enableFuelForVehicleKey.currentState!.validate()) {
                          AxleLoader.show(context);

                          bool res = await ref.read(vehicleControllerProvider).verifyVehKyc(
                                getFuelKycInputVehicle("REJECTED"),
                                widget.vehicleEnrollId,
                              );
                          AxleLoader.hide();

                          if (res && mounted) {
                            await ref
                                .read(vehicleControllerProvider)
                                .getVehicleByRegistrationNumber(vehicleEnrolId: widget.vehicleRegNumber.toUpperCase());
                          }
                        }
                      },
                    ),
                    const SizedBox(width: 20.0),
                    AxlePrimaryButton(
                      buttonText: InputFormConstants.approve,
                      // buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                      buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                      onPress: () async {
                        if (enableFuelForVehicleKey.currentState!.validate()) {
                          AxleLoader.show(context);

                          bool res = await ref.read(vehicleControllerProvider).verifyVehKyc(
                                getFuelKycInputVehicle("APPROVED"),
                                widget.vehicleEnrollId,
                              );
                          AxleLoader.hide();

                          if (res && mounted) {
                            await ref
                                .read(vehicleControllerProvider)
                                .getVehicleByRegistrationNumber(vehicleEnrolId: widget.vehicleRegNumber.toUpperCase());
                          }
                        }
                      },
                    )
                  ],
                ),
              )
            : (getVehServiceData?.kycStatus == "PENDING")
                ? Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                      children: [
                        AxleOutlineButton(
                          buttonText: InputFormConstants.cancelButton,
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
                            if (enableFuelForVehicleKey.currentState!.validate()) {
                              AxleLoader.show(context);

                              bool res =
                                  await ref.read(vehicleControllerProvider).enableFuelService(getFuelInputsVehicle());
                              AxleLoader.hide();

                              if (res && mounted) {
                                await ref.read(vehicleControllerProvider).getVehicleByRegistrationNumber(
                                    vehicleEnrolId: widget.vehicleRegNumber.toUpperCase());
                              }
                            }
                          },
                        )
                      ],
                    ),
                  )
                : (getVehServiceData?.kycStatus == "APPROVED")
                    ? Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Row(
                          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                          children: [
                            AxlePrimaryButton(
                                buttonText: InputFormConstants.serviceEnabled,
                                buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                                onPress: null)
                          ],
                        ),
                      )
                    : (getVehServiceData?.kycStatus == "REJECTED")
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
                                    if (enableFuelForVehicleKey.currentState!.validate()) {
                                      AxleLoader.show(context);

                                      bool res = await ref
                                          .read(vehicleControllerProvider)
                                          .retryEnableFuelService(getFuelInputsVehicle());
                                      AxleLoader.hide();

                                      if (res && mounted) {
                                        await ref.read(vehicleControllerProvider).getVehicleByRegistrationNumber(
                                            vehicleEnrolId: widget.vehicleRegNumber.toUpperCase());
                                      }
                                    }
                                  },
                                )
                              ],
                            ),
                          )
                        : Padding(
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
                                  buttonText: "SUBMIT",
                                  buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                  buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                                  onPress: () async {
                                    if (enableFuelForVehicleKey.currentState!.validate()) {
                                      AxleLoader.show(context);

                                      bool res = await ref
                                          .read(vehicleControllerProvider)
                                          .enableFuelService(getFuelInputsVehicle());
                                      AxleLoader.hide();

                                      if (res && mounted) {
                                        await ref.read(vehicleControllerProvider).getVehicleByRegistrationNumber(
                                            vehicleEnrolId: widget.vehicleRegNumber.toUpperCase());
                                      }
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
      ],
    );
  }

  VehicleFuelServiceInputModel getFuelInputsVehicle() {
    return VehicleFuelServiceInputModel(
      organizationEnrollmentId: widget.orgEnrollId,
      vehicleRegistrationNumber: widget.vehicleRegNumber,
      kycDocuments: KycDocumentsVehicle(rcBook: RcBook(url: rcBookUrl.text)),
      issuerName: omcNameController.text.split('-').first.trimRight(),
      profileId: profileIdController.text.split('|').first.trimRight(),
      vehicleMake: vehicleMakeFieldController.text,
      // axle: profileIdAxleController.text,
      axle: '4',
    );
  }

  VerifyVehicleKycInputModel getFuelKycInputVehicle(String kycStatus) {
    return VerifyVehicleKycInputModel(
      organizationEnrollmentId: widget.orgEnrollId,
      kycStatus: kycStatus,
      kycComments: 'Verified',
      issuerName: omcNameController.text.split('-').first,
    );
  }
}
