import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/get_vehicle_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/services/enable_fuel_service_form.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/services/enable_gps_service_form.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/services/enable_tag_service_form.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum VehicleService {
  fastag,
  gps,
  fuelCard,
}

const idText = 'Identity Proof';
const addressText = 'Address Proof';
const rcText = 'RC Book';

@RoutePage()
class EnableVehicleServicePage extends ConsumerStatefulWidget {
  const EnableVehicleServicePage({
    super.key,
    @PathParam('vehicleRegNo') required this.vehicleId,
  });

  final String vehicleId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnableTagServiceState();
}

class _EnableTagServiceState extends ConsumerState<EnableVehicleServicePage> {
  late Widget formWidget;

  late bool isTagEnabled = false;
  late bool isYesTagEnabled = false;
  late bool isLqTagEnabled = false;
  late bool isGpsEnabled = false;
  late bool isFuelEnabled = false;
  int selectedIndex = 0;
  OrgDoc? org;
  OrgType orgType = OrgType.dummy;

  List<String> title = ["FASTag", "GPS", "Fuel Card"];
  List<String> description = [
    "Pay for tolls with quick recharge & track expense",
    "Get GPS to track fleet operations in real-time.",
    "Unify all fleet-related payments in a single card",
  ];

  @override
  void initState() {
    Future(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(vehicleControllerProvider)
            .getVehicleByRegistrationNumber(vehicleEnrolId: widget.vehicleId.toUpperCase());
      });
      orgType = ref.read(localStorageProvider).getOrgType();
    });

    super.initState();
  }

  Vehicle? vehicle;

  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    org = ref.watch(orgDetailsProvider);
    vehicle = ref.watch(vehicleDetailsProvider);

    if (vehicle != null) {
      isTagEnabled = getVehicleService(vehicle, 'TAG') != null ? true : false;
      isGpsEnabled = getVehicleService(vehicle, 'GPS') != null ? true : false;
      isYesTagEnabled = getVehicleService(vehicle, 'TAG', issuerName: 'YESBANK') != null ? true : false;
      isLqTagEnabled = getVehicleService(vehicle, 'TAG', issuerName: 'LIVQUIK') != null ? true : false;
      isFuelEnabled = getVehicleService(vehicle, 'FUEL') != null ? true : false;
    }

    //double screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);

    return Scaffold(
      body: org == null || vehicle == null
          ? AxleLoader.axleProgressIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: isMobile
                    ? const EdgeInsets.all(defaultPadding)
                    : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isMobile
                        ? Padding(
                            padding: const EdgeInsets.only(left: defaultPadding),
                            child: GestureDetector(
                                onTap: () => context.router.pushNamed(RouteUtils.getVehiclesPath()),
                                child: Text("< Back", style: AxleTextStyle.labelLarge)))
                        : DashboardHeader(
                            title: "AxlerateServices",
                            vehicleId: widget.vehicleId,
                            orgName: org?.displayName,
                            buttonText: "Detailed View",
                            onButtonPressed: () {
                              context.router.pushNamed('./details'
                                  // RouteUtils.getVehicleDetailsPath(org!.enrollmentId, widget.vehicleId),
                                  );
                            },
                          ),

                    // isMobile
                    //     ? Padding(
                    //         padding: const EdgeInsets.only(left: defaultPadding),
                    //         child: GestureDetector(
                    //             onTap: () => context.go(RouteUtils.getVehiclesPath()),
                    //             child: Text("< Back", style: AxleTextStyle.headingBlack)))
                    //     : DashboardHeader(
                    //         title: "AxlerateServices", vehicleId: widget.vehicleId, orgName: org!.displayName),

                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Container(
                      decoration: CommonStyleUtil.axleContainerDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: SizedBox(
                              height: 110,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: title.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: defaultPadding),
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // formWidget = getSelectedWidget(index);
                                            selectedIndex = index;
                                          });
                                        },
                                        child: vehicle!.services.isNotEmpty
                                            ? serviceCard(vehicle!, title[index], description[index], index)
                                            : axleServiceCard(title[index], description[index], index)),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Container(
                              width: double.infinity,
                              height: 2,
                              color: iconColor,
                            ),
                          ),
                          getSelectedWidget(selectedIndex, vehicle!)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget getSelectedWidget(int index, Vehicle doc) {
    Widget toRet = EnableTagServiceForm(
      key: UniqueKey(),
      isTagEnabled: isTagEnabled,
      isYesTagEnabled: isYesTagEnabled,
      isLqTagEnabled: isLqTagEnabled,
      org: org,
      vehicleRegNumber: vehicle!.registrationNumber,
      vehicleEnrollId: vehicle!.enrollmentId,
      vehicleDoc: vehicle!,
      orgType: orgType,
    );

    switch (index) {
      case 0:
        (getOrgService(org, 'TAG') != null)
            ? toRet = EnableTagServiceForm(
                key: UniqueKey(),
                isTagEnabled: isTagEnabled,
                isYesTagEnabled: isYesTagEnabled,
                isLqTagEnabled: isLqTagEnabled,
                org: org,
                vehicleRegNumber: vehicle!.registrationNumber,
                vehicleEnrollId: vehicle!.enrollmentId,
                vehicleDoc: vehicle!,
                orgType: orgType,
              )
            : toRet = serviceMsgWidget(contentMsg: "Please Ensure your Organisation is enabled with Tag Service");
        break;
      case 1:
        // (org?.services != null && org?.services?.gps != null)
        (getOrgService(org, 'GPS') != null)
            ? toRet = EnableGpsServiceForm(
                key: UniqueKey(),
                isGpsEnabled: isGpsEnabled,
                orgEnrollId: org!.enrollmentId,
                orgId: org!.id,
                vehicleRegNumber: vehicle!.registrationNumber,
                vehicleEnrollId: vehicle!.enrollmentId,
                vehicleDoc: vehicle!,
                orgType: orgType,
              )
            : toRet = serviceMsgWidget(contentMsg: "Please Ensure your Organisation is enabled with Gps Service");
        break;
      case 2:
        // (org?.services != null && org?.services?.gps != null)
        (getOrgService(org, 'FUEL') != null && getOrgService(org, 'FUEL')?.kycStatus == 'APPROVED')
            ? toRet = EnableFuelServiceForm(
                key: UniqueKey(),
                isFuelEnabled: isFuelEnabled,
                orgEnrollId: org!.enrollmentId,
                orgId: org!.id,
                vehicleRegNumber: vehicle!.registrationNumber,
                vehicleEnrollId: vehicle!.enrollmentId,
                vehicleDoc: vehicle!,
              )
            : toRet = serviceMsgWidget(contentMsg: "Please Ensure your Organisation is enabled with Fuel Service");
        break;

      default:
        toRet = serviceMsgWidget(contentMsg: "Coming Soon..");
    }

    return toRet;
  }

  Widget serviceMsgWidget({required String contentMsg}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(horizontalPadding),
        child: Text(
          contentMsg,
          style: isMobile ? AxleTextStyle.bodyMedium : AxleTextStyle.headingPrimary,
        ),
      ),
    );
  }

  Container serviceCard(
    Vehicle vehicle,
    title,
    String description,
    int index,
  ) {
    bool isFastTagEnabled;
    bool isGpsEnabled;
    bool isFuelCardEnabled;
    Container res = Container();
    switch (title) {
      case "FASTag":
        isFastTagEnabled = getVehicleService(vehicle, 'TAG') != null;
        if (isFastTagEnabled == true) {
          res = axleServiceCardEnabled(title, description, index, status: getVehicleService(vehicle, 'TAG')?.kycStatus);
        } else {
          res = axleServiceCard(title, description, index);
        }

        break;

      case "GPS":
        isGpsEnabled = getVehicleService(vehicle, 'GPS') != null;
        if (isGpsEnabled == true) {
          res = axleServiceCardEnabled(title, description, index, status: "APPROVED");
        } else {
          res = axleServiceCard(title, description, index);
        }
        break;
      case "Fuel Card":
        isFuelCardEnabled = getVehicleService(vehicle, 'FUEL') != null;
        if (isFuelCardEnabled == true) {
          res =
              axleServiceCardEnabled(title, description, index, status: getVehicleService(vehicle, 'FUEL')?.kycStatus);
        } else {
          res = axleServiceCard(title, description, index);
        }
        break;
      default:
        res = axleServiceCard(title, description, index);
    }
    return res;
  }

  Container axleServiceCard(String title, String description, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: selectedIndex == index ? primaryColor : AxleColors.axleCardColor, width: 2.0),
      ),
      height: 100,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            selectedIndex == index ? const Icon(Icons.radio_button_checked) : const Icon(Icons.radio_button_off),
            const SizedBox(
              width: defaultPadding,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AxleTextStyle.bodyMedium.copyWith(color: Colors.black, fontWeight: FontWeight.w600)),
                  Flexible(child: Text(description, style: AxleTextStyle.bodySmall.copyWith(color: Colors.black87)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container axleServiceCardEnabled(String title, String description, int index, {String? status}) {
    Color statusColor = AxleColors.getStatusColor(status ?? "");
    return Container(
      decoration: BoxDecoration(
        color: selectedIndex == index ? statusColor.withAlpha(35) : null,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: statusColor, width: 2),
        //  Border.all(color: AxleColors.axleGreenColor, width: 2.0),
      ),
      height: 100,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.only(left: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: statusColor),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AxleTextStyle.bodyMedium.copyWith(color: Colors.black, fontWeight: FontWeight.w600)),
                  Flexible(child: Text(description, style: AxleTextStyle.bodySmall.copyWith(color: Colors.black87)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                height: 135,
                width: 30,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      status != null
                          ? status == "APPROVED"
                              ? 'Enabled'
                              : status.toUiCase
                          : '',
                      style: AxleTextStyle.labelSmall.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
