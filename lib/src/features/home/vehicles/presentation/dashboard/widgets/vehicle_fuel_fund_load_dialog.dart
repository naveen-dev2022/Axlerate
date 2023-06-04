// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_info_dialog_model.dart';
import 'package:axlerate/src/dialogs/vehicle_fund_load_info_dialog.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_fuel_acc_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/vehicle_fund_load_card.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VehicleFundLoadDialogFuel extends ConsumerWidget {
  VehicleFundLoadDialogFuel({
    super.key,
    required this.msgData,
    required this.org,
    required this.balanceData,
    required this.formKey,
    required this.vehicle,
  });

  final OrgFuelAccInfoMessage? msgData;
  final OrgDoc? org;
  final String balanceData;
  final GlobalKey<FormState> formKey;
  final Vehicle? vehicle;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isMobile = false;
  double screenWidth = 0.0;
  double customerBalance = 0.0;
  double vehicleBalance = 0.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isLoading = ref.watch(vehicleFundLoadLoadingProvider);
    isMobile = Responsive.isMobile(context);
    screenWidth = MediaQuery.of(context).size.width;

    try {
      customerBalance = double.parse(balanceData);
    } catch (e) {
      // debugPrint(e.toString());
    }

    try {
      vehicleBalance = double.parse(msgData!.availableBalance.toString());
    } catch (e) {
      // debugPrint(e.toString());
    }

    return AlertDialog(
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
          child: Column(
            children: [
              const Text(
                'Fund Load',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0),

              // * From Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'From',
                        style: AxleTextStyle.backToLoginStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        org != null ? org?.displayName : '',
                        style: AxleTextStyle.imageUploadTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  VehicleFundLoadCard(
                    title: 'Customer Wallet Balance',
                    subtitle: 'Available',
                    balance: axleCurrencyFormatterwithDecimals.format(customerBalance),
                    borderColor: const Color(0xffDCE9F6),
                    textColor: Colors.black,
                    assetName: "assets/new_assets/icons/user_icon.svg",
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      Text(
                        'To',
                        style: AxleTextStyle.backToLoginStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        msgData != null ? vehicle?.registrationNumber ?? ' -' : ' -',
                        style: AxleTextStyle.imageUploadTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  VehicleFundLoadCard(
                    title: 'Vehicle Wallet Balance',
                    subtitle: 'Available',
                    balance: axleCurrencyFormatterwithDecimals.format(vehicleBalance),
                    borderColor: const Color(0xffDCE9F6),
                    textColor: Colors.black,
                    assetName: "assets/new_assets/icons/user_icon.svg",
                  ),
                  const SizedBox(height: 10.0),
                  Form(
                    key: formKey,
                    child: AxleFormTextField(
                      autofocus: true,
                      lengthLimit: 8,
                      fieldHeading: 'Load Amount*',
                      fieldHint: 'Enter the Load Amount',
                      fieldWidth: 350,
                      isOnlyDigits: true,
                      textType: TextInputType.number,
                      fieldController: amountController,
                      fieldAction: TextInputAction.done,
                      onSubmit: (_) async {
                        // bool isValidated = formKey.currentState!.validate() && amountController.text.isNotEmpty;
                        // if (isValidated == true) {
                        //   int value = int.parse(amountController.text);
                        //   if (value > 0) {
                        //     // ref.read(vehicleFundLoadLoadingProvider.notifier).state = true;
                        //     AxleLoader.show(context);
                        //     bool res = await ref.read(vehicleControllerProvider).fundLoadForTag(
                        //           orgId: msgData != null ? (msgData?.organizationId) ?? '' : '',
                        //           vehicleRegNo: msgData != null ? msgData?.organizationEntityId ?? "" : '',
                        //           amount: int.parse(amountController.text),
                        //         );
                        //     AxleLoader.hide();
                        //     if (res) {
                        //       // ref.read(vehicleFundLoadLoadingProvider.notifier).state = false;
                        //       Navigator.of(context).pop(true);
                        //       await const VehicleFundLoadInfoDialog().present(context);
                        //       Snackbar.success("Updated Successfully");
                        //     }
                        //   } else {
                        //     Snackbar.error("Should be greater than 0 ");
                        //   }
                        // }
                      },
                      validate: Validators("Load Amount").required().max(6),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  AxleFormTextField(
                    fieldHeading: 'Description',
                    fieldHint: 'Enter Description',
                    fieldWidth: 350,
                    fieldController: descriptionController,
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
                          buttonText: 'Add Amount',
                          buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                          buttonColor: AxleColors.axleBlueColor,
                          buttonWidth: isMobile ? screenWidth * 32 / 100 : 150.0,
                          onPress: () async {
                            if (formKey.currentState!.validate()) {
                              int value = int.parse(amountController.text);
                              if (value > 0) {
                                // ref.read(vehicleFundLoadLoadingProvider.notifier).state = true;
                                AxleLoader.show(context);

                                bool res = await ref.read(vehicleControllerProvider).loadAmountFuelCard(
                                      orgId: msgData != null ? (msgData?.organizationEnrollmentId) ?? '' : '',
                                      vehicleRegNo: msgData != null ? vehicle?.registrationNumber ?? "" : '',
                                      amount: int.parse(amountController.text),
                                      description: descriptionController.text,
                                    );
                                AxleLoader.hide();
                                if (res) {
                                  // ref.read(vehicleFundLoadLoadingProvider.notifier).state = false;
                                  Navigator.of(context).pop(true);
                                  await const VehicleFundLoadInfoDialog().present(context);
                                  Snackbar.success("Updated Successfully");
                                }
                              } else {
                                Snackbar.error("Should be greater than 0 ");
                              }
                            }

                            // if (formKey.currentState!.validate()) {
                            //   ref.read(vehicleFundLoadLoadingProvider.notifier).state = true;
                            //   bool res = await ref.read(vehicleControllerProvider).fundLoadForTag(
                            //         orgId: msgData != null ? (msgData?.organizationId) ?? '' : '',
                            //         vehicleRegNo: msgData != null ? msgData?.entityId ?? "" : '',
                            //         amount: int.parse(amountController.text),
                            //       );
                            //   if (res) {
                            //     ref.read(vehicleFundLoadLoadingProvider.notifier).state = false;
                            //     Navigator.of(context).pop(true);

                            //     await const VehicleFundLoadInfoDialog().present(context);
                            //   } else {
                            //     ref.read(vehicleFundLoadLoadingProvider.notifier).state = false;
                            //   }
                            // }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
