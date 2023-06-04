// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'dart:developer';

import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/user/domain/list_user_fuel_response_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/ui_controller.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VehicleMapDriverDialog extends ConsumerWidget {
  VehicleMapDriverDialog({
    super.key,
    required this.formKey,
    required this.vehicleRegNo,
    required this.organizationEnrollmentId,
    required this.isMapped,
    required this.btnValue,
    this.userDetails,
  });

  final GlobalKey<FormState> formKey;
  final String vehicleRegNo;
  final String organizationEnrollmentId;
  final bool isMapped;
  final String btnValue;
  UserDetails? userDetails;

  final TextEditingController userMapController = TextEditingController();

  bool isMobile = false;
  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isLoading = ref.watch(vehicleFundLoadLoadingProvider);
    isMobile = Responsive.isMobile(context);
    screenWidth = MediaQuery.of(context).size.width;
    List<MessageElement> allList;

    return btnValue == "UNMAP"
        ? AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            titlePadding: isMobile
                ? const EdgeInsets.all(defaultPadding)
                : const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            title: SingleChildScrollView(
              child: GestureDetector(
                onTap: (() {
                  FocusManager.instance.primaryFocus?.unfocus();
                }),
                child: SizedBox(
                  width: 400,
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'UnMap Staff',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "“Are you sure you want to unmap User from vehicle no",
                                      style: AxleTextStyle.labelLarge.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: defaultMobilePadding),
                                    Text(vehicleRegNo.toUpperCase(), style: AxleTextStyle.titleMedium),
                                  ],
                                ),
                              ],
                            )
                          : Wrap(
                              children: [
                                Text(
                                  "“Are you sure you want to unmap User from vehicle no",
                                  style: AxleTextStyle.labelLarge.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: defaultMobilePadding),
                                Text(vehicleRegNo.toUpperCase(), style: AxleTextStyle.titleMedium),
                              ],
                            ),
                      const SizedBox(height: 30.0),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AxleOutlineButton(
                              buttonText: 'Cancel',
                              buttonStyle: AxleTextStyle.saveAndContinuePrimaryStyle,
                              outlineColor: AxleColors.axleBlueColor,
                              buttonWidth: isMobile ? screenWidth * 32 / 100 : 150.0,
                              onPress: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 10.0),
                            AxlePrimaryButton(
                              buttonText: 'UnMap Staff',
                              buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                              buttonColor: AxleColors.axleBlueColor,
                              buttonWidth: isMobile ? screenWidth * 32 / 100 : 150.0,
                              onPress: () async {
                                final res = ref.read(selectUserMapProvider);
                                log('result.....${res.split('-').first}');
                                AxleLoader.show(context);
                                bool result = await ref.read(vehicleControllerProvider).mapDriverToVehicle(
                                      driverEnrollmentId: res.split('-').first.trimLeft(),
                                      mapStatus: "UNMAP",
                                      organizationEnrollmentId: organizationEnrollmentId,
                                      vehicleRegNo: vehicleRegNo.toUpperCase(),
                                    );
                                if (result) {
                                  Navigator.of(context).pop();
                                  await ref
                                      .read(vehicleControllerProvider)
                                      .getVehicleByRegistrationNumber(vehicleEnrolId: vehicleRegNo.toUpperCase());
                                }
                                AxleLoader.hide();
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            titlePadding: isMobile
                ? const EdgeInsets.all(defaultPadding)
                : const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            title: SingleChildScrollView(
              child: GestureDetector(
                onTap: (() {
                  FocusManager.instance.primaryFocus?.unfocus();
                }),
                child: SizedBox(
                  width: 500,
                  height: 360,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        isMapped ? 'Reassign Staff' : 'Map Staff',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Select the staff you want to map to vehicle no",
                                      style: AxleTextStyle.labelLarge.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: defaultMobilePadding),
                                    Text(vehicleRegNo.toUpperCase(), style: AxleTextStyle.titleMedium),
                                  ],
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Select the staff you want to map to vehicle no",
                                  style: AxleTextStyle.labelLarge.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: defaultMobilePadding),
                                Text(vehicleRegNo.toUpperCase(), style: AxleTextStyle.titleMedium),
                              ],
                            ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: Wrap(
                          children: [
                            Text(
                              "Kindly note that only the staf who have been successfully onboarded under the Fuel Card service and who are currently not mapped to any vehicle will be shown in the list below.",
                              style: AxleTextStyle.labelLarge.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: verticalPadding),
                      Wrap(
                        children: [
                          ref.watch(userMapListProvider(organizationEnrollmentId)).when(
                                data: (response) {
                                  allList = response.data?.message ?? [];
                                  if (userDetails != null) {
                                    allList.removeWhere((element) {
                                      if (userDetails!.userEnrollmentId == element.userEnrollmentId &&
                                          (element.mapStatus == "MAP" ||
                                              element.mapStatus == "MAP_INITIATED" ||
                                              element.mapStatus == "REASSIGN_INITIATED")) {
                                        return true;
                                      }
                                      // else if (element.mapStatus == "MAP" || element.mapStatus == "MAP_INITIATED") {
                                      //   return true;
                                      // }
                                      return false;
                                    });
                                  }
                                  return AxleSearchDropDownField(
                                    fieldHeading: InputFormConstants.selectStaffLabel,
                                    fieldHint: InputFormConstants.selectStaffHint,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    fieldController: userMapController,
                                    dropDownOptions: allList
                                        .map((item) => " ${item.userEnrollmentId}- ${item.firstName} ${item.lastName}")
                                        .toList(),
                                    validate: Validators(InputFormConstants.partnerOrgFieldName).required(),
                                    isRequired: true,
                                    onChanged: (val) {
                                      log('value ....$val');
                                      userMapController.text = val!;
                                      ref.read(selectUserMapProvider.notifier).state = val;
                                      // log('Entered Function ');
                                      // final picked = stateController.text.split('-').first.trim();
                                      // log('Entered SelectedState - $picked');

                                      // getUserOrganizationData(userData, orgEnrollId)
                                    },
                                  );
                                },
                                error: (error, stackTrace) => const Text('Error'),
                                loading: () => const CircularProgressIndicator(),
                              ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AxleOutlineButton(
                              buttonText: 'Cancel',
                              buttonStyle: AxleTextStyle.saveAndContinuePrimaryStyle,
                              outlineColor: AxleColors.axleBlueColor,
                              buttonWidth: isMobile ? screenWidth * 32 / 100 : 150.0,
                              onPress: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 10.0),
                            AxlePrimaryButton(
                              buttonText: isMapped ? 'Reassign Staff' : 'Map Staff',
                              buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                              buttonColor: AxleColors.axleBlueColor,
                              buttonWidth: isMobile ? screenWidth * 32 / 100 : 150.0,
                              onPress: () async {
                                final res = ref.read(selectUserMapProvider);
                                log('result.....${res.split('-').first}');
                                AxleLoader.show(context);
                                bool result = await ref.read(vehicleControllerProvider).mapDriverToVehicle(
                                      driverEnrollmentId: res.split('-').first.trimLeft(),
                                      mapStatus: isMapped ? 'REASSIGN' : "MAP",
                                      organizationEnrollmentId: organizationEnrollmentId,
                                      vehicleRegNo: vehicleRegNo.toUpperCase(),
                                    );
                                if (result) {
                                  Navigator.of(context).pop();
                                  await ref
                                      .read(vehicleControllerProvider)
                                      .getVehicleByRegistrationNumber(vehicleEnrolId: vehicleRegNo.toUpperCase());
                                }
                                AxleLoader.hide();
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
