// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/gps/widgets/manage_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/features/home/vehicles/domain/gps_value_model.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/gps_detail_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/gps/widgets/gps_safety.dart';
import 'package:axlerate/values/constants.dart';

@RoutePage()
class GpsDetailPage extends ConsumerStatefulWidget {
  GpsDetailPage({@PathParam('vehicleRegNo') required this.vehicleRegNo, super.key}) {
    vehicleRegNo = vehicleRegNo.toUpperCase();
  }

  String vehicleRegNo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GpsDetailPageState();
}

class _GpsDetailPageState extends ConsumerState<GpsDetailPage> {
  GPSValueResponseModel? valueData;
  bool loading = true;
  @override
  void initState() {
    getValueData();
    super.initState();
  }

  Future<void> getValueData() async {
    loading = true;
    ref.read(gpsValueDataProvider.notifier).state =
        await ref.read(gpsDetailControllerProvider).getGpsValueData(vehicleRegistrationNumber: widget.vehicleRegNo);
    setState(() {
      loading = false;
    });
  }

  OrgDoc? org;
  bool isMobile = false;
  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    org = ref.watch(orgDetailsProvider);
    valueData = ref.watch(gpsValueDataProvider);
    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: isMobile
              ? const EdgeInsets.all(defaultPadding)
              : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          child: loading
              ? AxleLoader.axleProgressIndicator()
              : valueData == null
                  ? const Center(
                      child: Text(
                          "GPS is not enabled for this device. Please contact support team to enable GPS for this vehicle"))
                  : Column(children: [
                      if (!isMobile)
                        Column(
                          children: [
                            DashboardHeader(
                              title: "GPS Detailed View",
                              vehicleId: widget.vehicleRegNo,
                              orgName: valueData!.data.message.details[0].logisticsOrganizationName,
                            ),
                            const SizedBox(
                              height: defaultPadding,
                            ),
                          ],
                        ),
                      isMobile
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/new_assets/icons/gps_imei_icon.svg",
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(width: defaultMobilePadding),
                                        Text(
                                          "GPS IMEI Number",
                                          style: AxleTextStyle.miniHeadingBlackStyle,
                                        ),
                                      ],
                                    ),
                                    AxleTextWithBg(
                                      text: valueData!.data.message.details[0].IMEI,
                                      textColor: primaryColor,
                                    ),
                                  ],
                                ),
                                if (org != null)
                                  Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: AxlePrimaryButton(
                                          buttonText: "Manage Notifications",
                                          onPress: () {
                                            manageNotification();
                                          }))
                              ],
                            )
                          : Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(defaultMobilePadding),
                                  child: SvgPicture.asset(
                                    "assets/new_assets/icons/gps_imei_icon.svg",
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Text(
                                  "GPS IMEI Number",
                                  style: AxleTextStyle.miniHeadingBlackStyle,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: AxleTextWithBg(
                                    text: valueData!.data.message.details[0].IMEI,
                                    textColor: primaryColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                if (org != null)
                                  Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: AxlePrimaryButton(
                                          buttonWidth: 250,
                                          buttonText: "Manage Notifications",
                                          onPress: () {
                                            manageNotification();
                                          }))
                              ],
                            ),

                      const SizedBox(
                        height: defaultPadding,
                      ),
                      GpsSafetyWidget(gpsValueData: valueData!.data.message.details[0])
                      // AxleToggleMenu(provider: gpsDetailToggleSwitchIndex, items: [
                      //   AxleToggleMenuItem(
                      //       label: "Safety",
                      //       child: const ),
                      //   // AxleToggleMenuItem(
                      //   //     label: "Value",
                      //   //     child: const GpsValueWidget(
                      //   //         vehicleRegistrationNumber: "TN15AX1233")),
                      //   // AxleToggleMenuItem(
                      //   //     label: "Overview",
                      //   //     child: const GpsOverviewWidget(
                      //   //         vehicleRegistrationNumber: "TN15AX1233")),
                      // ])
                    ]),
        ),
      ),
    );
  }

  manageNotification() async {
    try {
      AxleLoader.show(context);
      List<dynamic> data = await Future.wait([
        ref.read(vehicleControllerProvider).getVehicleGpsAccountInfo(vehicleRegNo: widget.vehicleRegNo),
        ref.read(userControllerProvider).getOrgUsersListforGPSNotifications(org!.enrollmentId)
        //get Notifications Data,
        //get Users Data
      ]);
      AxleLoader.hide();
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                content: ManageGpsNotifications(gpsAccountInfo: data[0], usersList: data[1]),
              )));
    } catch (e) {
      // debugPrint(e.toString());
    }
  }
}
