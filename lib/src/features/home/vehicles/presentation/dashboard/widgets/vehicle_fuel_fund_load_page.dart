import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_fuel_acc_info_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/get_vehicle_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/vehicle_fund_load_card.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';

@RoutePage()
class VehicleFundLoadPage extends ConsumerStatefulWidget {
  const VehicleFundLoadPage({
    super.key,
    @PathParam('vehicleRegNo') required this.vehicleRegNo,
    @PathParam('custId') required this.orgEnrolld,
  });

  final String vehicleRegNo;
  final String orgEnrolld;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VehicleDashboardState();
}

class _VehicleDashboardState extends ConsumerState<VehicleFundLoadPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Vehicle? vehicle;
  OrgFuelAccInfo? vehicleFuelAccInfo;
  OrgFuelAccInfo? orgFuelAccInfo;
  String? userEnrollId;
  bool isLoading = true;
  double customerBalance = 0.0;
  double vehicleBalance = 0.0;
  bool isFundTransferOrgToVehicle = true;
  @override
  void initState() {
    loadInit();
    super.initState();
  }

  loadInit() async {
    await getVehicleDetails();
    if ((getVehicleService(vehicle, 'FUEL') != null && getVehicleService(vehicle, 'FUEL')?.kycStatus == 'APPROVED')) {
      vehicleFuelAccInfo = await getVehicleFuelAccountInfo();
    }

    if (getOrgService(org, 'FUEL') != null && getOrgService(org, 'FUEL')?.kycStatus == "APPROVED") {
      orgFuelAccInfo = await ref.read(logisticsControllerProvider).getOrgDashFuelAccountInfo(
          userOrgEnrollId: vehicleFuelAccInfo!.data!.message!.organizationEnrollmentId.toString(),
          entityType: 'ORGANIZATION');
    }
    try {
      customerBalance = double.parse(orgFuelAccInfo!.data!.message!.availableBalance.toString());
    } catch (e) {
      // debugPrint(e.toString());
    }

    try {
      vehicleBalance = double.parse(vehicleFuelAccInfo!.data!.message!.availableBalance.toString());
    } catch (e) {
      // debugPrint(e.toString());
    }
    isLoading = false;
    setState(() {});
  }

  getVehicleDetails() async {
    await ref.read(vehicleControllerProvider).getVehicleByRegistrationNumber(
        vehicleEnrolId: widget.vehicleRegNo.toUpperCase(), isSetVehicleDetailProvider: true);
  }

  Future<OrgFuelAccInfo> getVehicleFuelAccountInfo() async {
    userEnrollId = ref.watch(vehicleDetailsProvider)?.enrollmentId ?? '';
    return await ref
        .read(logisticsControllerProvider)
        .getOrgDashFuelAccountInfo(entityType: 'VEHICLE', userOrgEnrollId: userEnrollId ?? '');
  }

  double contentWidth = 0;
  OrgDoc? org;
  bool isMobile = false;
  bool displayedServicesToggleMenu = false;

  @override
  Widget build(BuildContext context) {
    org = ref.watch(orgDetailsProvider);
    vehicle = ref.watch(vehicleDetailsProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: org == null || vehicle == null || isLoading
            ? AxleLoader.axleProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: isMobile
                      ? const EdgeInsets.all(defaultPadding)
                      : const EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isMobile
                          ? Column(
                              children: [
                                Row(children: [
                                  GestureDetector(
                                      onTap: () => context.router.canNavigateBack ? context.router.pop() : null,
                                      child: Text("< Back", style: AxleTextStyle.labelLarge))
                                ]),
                                const SizedBox(height: defaultPadding)
                              ],
                            )
                          : Column(
                              children: [
                                DashboardHeader(
                                  title: "Fund Load",
                                  vehicleId: widget.vehicleRegNo,
                                  orgName: org?.displayName,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                              ],
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // * From Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  isFundTransferOrgToVehicle
                                      ? Text(
                                          org != null ? org?.displayName : '',
                                          style: AxleTextStyle.imageUploadTextStyle,
                                        )
                                      : Text(
                                          vehicleFuelAccInfo!.data!.message != null
                                              ? vehicle?.registrationNumber ?? ' -'
                                              : ' -',
                                          style: AxleTextStyle.imageUploadTextStyle,
                                        )
                                ],
                              ),
                              const SizedBox(height: 6.0),
                              isFundTransferOrgToVehicle ? customerFundWidget() : vehicleFundWidget(),
                              const SizedBox(height: 12.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  isFundTransferOrgToVehicle
                                      ? Text(
                                          vehicleFuelAccInfo!.data!.message != null
                                              ? vehicle?.registrationNumber ?? ' -'
                                              : ' -',
                                          style: AxleTextStyle.imageUploadTextStyle,
                                        )
                                      : Text(
                                          org != null ? org?.displayName : '',
                                          style: AxleTextStyle.imageUploadTextStyle,
                                        ),
                                  IconButton(
                                      onPressed: () {
                                        isFundTransferOrgToVehicle = isFundTransferOrgToVehicle ? false : true;
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.swap_vertical_circle))
                                ],
                              ),
                              const SizedBox(height: 6.0),
                              isFundTransferOrgToVehicle ? vehicleFundWidget() : customerFundWidget(),
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
                                  onSubmit: (_) async {},
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
                                        bool res;
                                        if (formKey.currentState!.validate()) {
                                          int value = int.parse(amountController.text);
                                          if (value > 0) {
                                            AxleLoader.show(context);
                                            if (isFundTransferOrgToVehicle) {
                                              res = await ref.read(vehicleControllerProvider).loadAmountFuelCard(
                                                    orgId: vehicleFuelAccInfo!.data!.message != null
                                                        ? (vehicleFuelAccInfo!
                                                                .data!.message?.organizationEnrollmentId) ??
                                                            ''
                                                        : '',
                                                    vehicleRegNo: vehicleFuelAccInfo!.data!.message != null
                                                        ? vehicle?.registrationNumber ?? ""
                                                        : '',
                                                    amount: int.parse(amountController.text),
                                                    description: descriptionController.text,
                                                  );
                                            } else {
                                              res = await ref.read(vehicleControllerProvider).withDrawAmountFuelCard(
                                                    orgId: vehicleFuelAccInfo!.data!.message != null
                                                        ? (vehicleFuelAccInfo!
                                                                .data!.message?.organizationEnrollmentId) ??
                                                            ''
                                                        : '',
                                                    vehicleRegNo: vehicleFuelAccInfo!.data!.message != null
                                                        ? vehicle?.registrationNumber ?? ""
                                                        : '',
                                                    amount: int.parse(amountController.text),
                                                    description: descriptionController.text,
                                                    vehicleEntityId: vehicleFuelAccInfo!.data!.message!.vehicleEntityId,
                                                  );
                                            }
                                            AxleLoader.hide();
                                            if (res) {
                                              loadInit();
                                              Snackbar.success("Updated Successfully");
                                            }
                                          } else {
                                            Snackbar.error("Should be greater than 0 ");
                                          }
                                        }
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget customerFundWidget() {
    return VehicleFundLoadCard(
      title: 'Customer Wallet Balance',
      subtitle: 'Available',
      balance: axleCurrencyFormatterwithDecimals.format(customerBalance),
      borderColor: const Color(0xffDCE9F6),
      textColor: Colors.black,
      assetName: "assets/new_assets/icons/user_icon.svg",
    );
  }

  Widget vehicleFundWidget() {
    return VehicleFundLoadCard(
      title: 'Vehicle Wallet Balance',
      subtitle: 'Available',
      balance: axleCurrencyFormatterwithDecimals.format(vehicleBalance),
      borderColor: const Color(0xffDCE9F6),
      textColor: Colors.black,
      assetName: "assets/new_assets/icons/user_icon.svg",
    );
  }
}
