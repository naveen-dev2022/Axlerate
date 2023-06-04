import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/transactions/domain/fuel_txn_query_params.dart';
import 'package:axlerate/src/features/home/transactions/presentation/fuel_txn_table.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/lqtag_admin_org_response_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/get_vehicle_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/vehicle_dasahboard_fastag_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/vehicle_dashboard_gps_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/vehicle_fuel_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/axle_toggle_menu_item_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/common/common_widgets/axle_toggle_menu.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/dashboard_controllers.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';

@RoutePage()
class VehicleDashboard extends ConsumerStatefulWidget {
  const VehicleDashboard({
    super.key,
    // required this.vehicleId,
    @PathParam('vehicleRegNo') required this.vehicleRegNo,
    @PathParam('custId') required this.orgEnrolld,
  });

  // final String vehicleId;
  final String vehicleRegNo;
  final String orgEnrolld;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VehicleDashboardState();
}

class _VehicleDashboardState extends ConsumerState<VehicleDashboard> {
  String? vehicleEntityId;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(vehicleDashboardToggleSwitchIndex.notifier).state = 0;
    });

    super.initState();
  }

  Future<LqTagAdminOrgResponseModel> getLqAdminList() async {
    return await ref.read(vehicleControllerProvider).getLQTagAdminOrgUser(orgEnrolId: widget.orgEnrolld);
  }

  List<String> headerItems = ["Date & Time", "Vehicle", "Toll Name", "Type", "Amount"];
  double contentWidth = 0;
  OrgDoc? org;
  Vehicle? vehicle;
  bool isMobile = false;
  bool loadOnce = false;
  bool displayedServicesToggleMenu = false;

  @override
  Widget build(BuildContext context) {
    org = ref.watch(orgDetailsProvider);
    vehicle = ref.watch(vehicleDetailsProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double sideBarWidth = Responsive.isMobile(context) ? 0 : 300;
    double availableWidth = screenWidth - (sideBarWidth + (horizontalPadding * 2));
    contentWidth = availableWidth / headerItems.length;

    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    if (vehicle != null) {
      for (var element in vehicle!.services) {
        if (element.serviceType == "FUEL" && element.issuerName == "HPCL") {
          vehicleEntityId = element.vehicleEntityId;
          break;
        }
      }
    }

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: org == null || vehicle == null
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
                                  title: "Vehicle Dashboard",
                                  vehicleId: widget.vehicleRegNo,
                                  orgName: org?.displayName,
                                  buttonText: "Services",
                                  onButtonPressed: () {
                                    context.router.pushNamed('services');
                                  },
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                              ],
                            ),
                      if ((getVehicleService(vehicle, 'GPS') != null &&
                              getVehicleService(vehicle, 'GPS')?.kycStatus == 'INSTALLED') ||
                          (getVehicleService(vehicle, 'TAG') != null &&
                              getVehicleService(vehicle, 'TAG')?.kycStatus == 'APPROVED') ||
                          (getVehicleService(vehicle, 'FUEL') != null &&
                              getVehicleService(vehicle, 'FUEL')?.kycStatus == 'APPROVED'))
                        getToggleMenu(),
                      (getVehicleService(vehicle, 'TAG', issuerName: "LIVQUIK") != null)
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: defaultPadding),
                                Text(
                                  " Recent Transactions",
                                  style: AxleTextStyle.headingPrimary,
                                ),
                                const SizedBox(height: defaultMobilePadding),
                                FuelTxnTableWidget(
                                  showDateFilter: false,
                                  txnParams: FuelTxnQueryParams(
                                    size: 10,
                                    pageIndex: 1,
                                    //  transactionType: "FUEL",
                                    vehicleEnrollmentId: vehicle!.enrollmentId,
                                    accountInfoEntity: vehicleEntityId,
                                  ),
                                  userOrgEnrollId: widget.orgEnrolld,
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  AxleToggleMenu getToggleMenu() {
    displayedServicesToggleMenu = true;
    return AxleToggleMenu(
      provider: vehicleDashboardToggleSwitchIndex,
      items: [
        if ((getVehicleService(vehicle, 'GPS') != null))
          AxleToggleMenuItem(
            label: "GPS",
            child: VehicleDashboardGPSService(
              vehicleRegNo: widget.vehicleRegNo,
              // org: org!,
            ),
          ),
        if ((getVehicleService(vehicle, 'TAG') != null && getVehicleService(vehicle, 'TAG')?.kycStatus == 'APPROVED'))
          AxleToggleMenuItem(
            label: "FASTag",
            child: VehicleDasahboardFastagService(
              key: UniqueKey(),
              vehicleRegNo: widget.vehicleRegNo,
              org: org,
              orgEnrolld: widget.orgEnrolld,
              vehicle: vehicle,
            ),
          ),
        if ((getVehicleService(vehicle, 'FUEL') != null && getVehicleService(vehicle, 'FUEL')?.kycStatus == 'APPROVED'))
          AxleToggleMenuItem(
            label: "FUEL",
            child: VehicleDashboardFuelService(
              org: org,
              vehicleRegNo: widget.vehicleRegNo,
              orgEnrolld: widget.orgEnrolld,
              vehicleEntityId: vehicleEntityId,
              vehicle: vehicle,
            ),
          ),
      ],
    );
  }

  Widget listItem(BuildContext context, List<String> rowItem) {
    return Card(
        child: Row(
      children: <Widget>[
        SizedBox(
          width: contentWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
            child: Text(rowItem[0]),
          ),
        ),
        SizedBox(
          width: contentWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2, horizontal: defaultPadding),
            child: Text(rowItem[1]),
          ),
        ),
        SizedBox(
          width: contentWidth,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2, horizontal: defaultPadding),
              child: AxleTextWithBg(
                  text: rowItem[2],
                  textColor: rowItem[3].contains('NETC') ? AxleColors.enabledStatusColor : AxleColors.axleAquaBlue)),
        ),
        SizedBox(
          width: contentWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2, horizontal: defaultPadding),
            child: Text(rowItem[3]),
          ),
        ),
        SizedBox(
          width: contentWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2, horizontal: defaultPadding),
            child: Text(
              rowItem[4],
              style: TextStyle(
                  color: rowItem[3] == 'DEBIT' ? AxleColors.rejectedStatusColor : AxleColors.enabledStatusColor),
            ),
          ),
        ),
      ],
    ));
  }
}
