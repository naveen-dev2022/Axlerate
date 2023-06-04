import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_file_picker.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/enable_gps_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/get_vehicle_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnableGpsServiceForm extends ConsumerStatefulWidget {
  const EnableGpsServiceForm({
    super.key,
    required this.orgId,
    required this.orgEnrollId,
    required this.vehicleRegNumber,
    required this.vehicleEnrollId,
    required this.vehicleDoc,
    required this.isGpsEnabled,
    required this.orgType,
  });

  final String orgId;
  final String orgEnrollId;
  final String vehicleRegNumber;
  final String vehicleEnrollId;
  final Vehicle vehicleDoc;
  final bool isGpsEnabled;
  final OrgType orgType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnableGpsServiceState();
}

class _EnableGpsServiceState extends ConsumerState<EnableGpsServiceForm> {
  final GlobalKey<FormState> enableGPSForVehicleKey = GlobalKey<FormState>();

  final TextEditingController imeiController = TextEditingController();
  final TextEditingController rcBookcontroller = TextEditingController();
  final TextEditingController rcUrlcontroller = TextEditingController();

  bool isEditable = false;

  // bool isImeiDisabled = false;

  @override
  void initState() {
    if (widget.isGpsEnabled) {
      final Service? gpsData = getVehicleService(widget.vehicleDoc, 'GPS');

      imeiController.text = gpsData?.imei ?? '';
      rcBookcontroller.text = gpsData?.kycDocuments?.rcBookImage?.docUploadStatus != null ? "Uploaded" : '';
      rcUrlcontroller.text = gpsData?.kycDocuments?.rcBookImage?.url ?? '';
    } else {
      isEditable = true;
    }
    // if (getVehicleService(widget.vehicleDoc, 'GPS') != null) {
    //   isImeiDisabled = true;
    // }

    super.initState();
  }

  @override
  void dispose() {
    imeiController.dispose();
    rcBookcontroller.dispose();
    rcUrlcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: enableGPSForVehicleKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Primary Details",
                      style: AxleTextStyle.headingPrimary,
                    ),
                    (widget.orgType == OrgType.axlerate && widget.isGpsEnabled)
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
                  runSpacing: 20.0,
                  spacing: 60.0,
                  children: [
                    AxleFormTextField(
                      fieldHeading: 'IMEI Number',
                      fieldHint: 'Enter IMEI Number',
                      fieldController: imeiController,
                      fieldWidth: isMobile ? screenWidth : 300,
                      textType: TextInputType.number,
                      validate: Validators('IMEI Number').required().min(15).max(15),
                      isRequiredField: true,
                      lengthLimit: 15,
                      isOnlyDigits: true,
                      isFieldEnabled: !widget.isGpsEnabled || isEditable,
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                // * Documnet Upload Section
                Text(
                  "Upload Documents",
                  style: AxleTextStyle.headingPrimary,
                ),
                const SizedBox(height: defaultPadding),
                Wrap(
                  runSpacing: 20.0,
                  spacing: 60.0,
                  children: [
                    // * RC Book
                    AxleFilePicker(
                      customWidth: isMobile ? screenWidth : 420,
                      labelText: InputFormConstants.docFieldRCproof,
                      isRequiredField: true,
                      controller: rcBookcontroller,
                      isEnabled: !widget.isGpsEnabled || isEditable,

                      // isEnabled: rcBookcontroller.text == "Uploaded" ? false : true,
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
                          docType: 'organization/vehicle',
                          orgEnrollId: widget.vehicleEnrollId,
                          allowPdf: true,
                        );
                        if (document != null) {
                          rcBookcontroller.text = document['name'] ?? '';
                          rcUrlcontroller.text = document['url'] ?? '';
                        } else {
                          rcBookcontroller.clear();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
            children: [
              isEditable || !widget.isGpsEnabled
                  ? AxleOutlineButton(
                      buttonText: InputFormConstants.cancelbuttonText,
                      buttonStyle: AxleTextStyle.outLineButtonStyle,
                      buttonWidth: isMobile ? 100.0 : 200.0,
                      onPress: () {
                        context.router.pop();
                      },
                    )
                  : Container(),
              const SizedBox(width: 20.0),
              AxlePrimaryButton(
                buttonText: isEditable || !widget.isGpsEnabled ? "SUBMIT" : "Service Enabled",
                buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                buttonWidth: isMobile ? 100.0 : 200.0,
                onPress: isEditable || !widget.isGpsEnabled
                    ? () async {
                        if (enableGPSForVehicleKey.currentState!.validate()) {
                          AxleLoader.show(context);
                          bool res = await ref.read(vehicleControllerProvider).enableGpsService(getGpsInputs());

                          AxleLoader.hide();
                          if (res && mounted) {
                            await ref
                                .read(vehicleControllerProvider)
                                .getVehicleByRegistrationNumber(vehicleEnrolId: widget.vehicleRegNumber.toUpperCase());
                          }
                        }
                      }
                    : null,
              )
            ],
          ),
        ),
      ],
    );
  }

  EnableGpsInputModel getGpsInputs() {
    return EnableGpsInputModel(
      organizationId: widget.orgId,
      vehicleRegNo: widget.vehicleRegNumber,
      imei: imeiController.text.trim(),
      kycDocuments: {
        "RC_BOOK_IMAGE": {
          'url': rcUrlcontroller.text,
        }
      },
    );
  }
}
