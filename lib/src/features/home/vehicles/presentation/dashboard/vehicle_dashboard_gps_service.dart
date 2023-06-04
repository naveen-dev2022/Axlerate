import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_gps_info_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/gps_widget.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';

class VehicleDashboardGPSService extends ConsumerStatefulWidget {
  const VehicleDashboardGPSService({
    Key? key,
    required this.vehicleRegNo,
    // required this.org,
  }) : super(key: key);
  final String vehicleRegNo;
  // final OrgDoc org;

  @override
  ConsumerState<VehicleDashboardGPSService> createState() => _VehicleDashboardGPSServiceState();
}

class _VehicleDashboardGPSServiceState extends ConsumerState<VehicleDashboardGPSService> {
  final double containerMinWidth = 450;
  double availableWidth = 0.0;
  double screenWidth = 0.0;
  bool isMobile = false;
  bool isLoading = false;
  late Future<VehicleGPSInfoModel> vehicleAccInfoGps;
  OrgDoc? org;

  @override
  void initState() {
    vehicleAccInfoGps = getvehicleAccInfoGps();
    super.initState();
  }

  Future<VehicleGPSInfoModel> getvehicleAccInfoGps() async =>
      await ref.read(vehicleControllerProvider).getVehicleGpsInfo(
            vehicleRegNo: widget.vehicleRegNo,
          );

  @override
  Widget build(BuildContext context) {
    org = ref.watch(orgDetailsProvider);

    screenWidth = MediaQuery.of(context).size.width;
    double menuWidth = kIsWeb ? sideMenuWidth : 0;
    availableWidth = screenWidth - (menuWidth + (defaultPadding * 3));

    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    return org == null
        ? Center(child: AxleLoader.axleProgressIndicator())
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<VehicleGPSInfoModel>(
              future: vehicleAccInfoGps,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: AxleLoader.axleProgressIndicator());
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      if (snapshot.data?.data == null) {
                        return const Center(
                          child: Text(
                            'No Data Found',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                          ),
                        );
                      }
                      final resData = snapshot.data;

                      return resData?.data != null
                          ? isMobile
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    gpsCardHeader("GPS Info", "More Info", () {
                                      context.router.pushNamed('./gps');
                                    }, resData!),
                                    gpsCardContent(resData),
                                    const SizedBox(height: defaultPadding),
                                    AxleOutlineButton(
                                        buttonText: "Refresh",
                                        onPress: () {
                                          vehicleAccInfoGps = getvehicleAccInfoGps();

                                          setState(() {});
                                        }),
                                    const SizedBox(height: defaultPadding),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: GpsWidget(
                                        size: Size(availableWidth, 500),
                                        lat: double.parse(resData.data?.message?.gpsInfo?.latitude ?? '12.9888'),
                                        lng: double.parse(resData.data?.message?.gpsInfo?.longitude ?? '80.0000'),
                                        markers: [
                                          LatLng(
                                            double.parse(resData.data?.message?.gpsInfo?.latitude ?? '12.9888'),
                                            double.parse(resData.data?.message?.gpsInfo?.longitude ?? '80.0000'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      constraints:
                                          BoxConstraints(minWidth: isMobile ? availableWidth : containerMinWidth),
                                      width: (availableWidth * 40) / 100,
                                      decoration:
                                          BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                                      child: Padding(
                                        // padding: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.only(bottom: 20.0),

                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          //header
                                          gpsCardHeader(
                                            "GPS Info",
                                            "More Info",
                                            () {
                                              context.router.pushNamed('./gps'
                                                  // RouteUtils.getVehicleGpsDetailsPath(
                                                  //   // widget.org.enrollmentId,
                                                  //   org!.enrollmentId,

                                                  //   widget.vehicleRegNo,
                                                  // ),
                                                  );
                                            },
                                            resData!,
                                          ),
                                          //content
                                          gpsCardContent(resData),
                                          //buttons
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              isLoading
                                                  ? const CircularProgressIndicator()
                                                  : AxleOutlineButton(
                                                      buttonText: "Refresh",
                                                      onPress: () {
                                                        // isLoading = true;
                                                        // setState(() {});
                                                        vehicleAccInfoGps = getvehicleAccInfoGps();
                                                        // isLoading = false;
                                                        setState(() {});
                                                      }),
                                              AxlePrimaryButton(
                                                buttonText: "Trip history",
                                                onPress: null,
                                              ),
                                            ],
                                          )
                                        ]),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: defaultPadding,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: GpsWidget(
                                        size: Size((availableWidth * 60) / 100, 500),
                                        lat: double.parse(resData.data?.message?.gpsInfo?.latitude ?? '12.9888'),
                                        lng: double.parse(resData.data?.message?.gpsInfo?.longitude ?? '80.0000'),
                                        markers: [
                                          LatLng(
                                            double.parse(resData.data?.message?.gpsInfo?.latitude ?? '12.9888'),
                                            double.parse(resData.data?.message?.gpsInfo?.longitude ?? '80.0000'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                          : Container();
                    } else {
                      return AxleLoader.axleProgressIndicator();
                    }
                }
              },
            ),
          );
  }

  Container gpsCardContent(VehicleGPSInfoModel vehicleGPSInfoModel) {
    bool isIgnitionOn = vehicleGPSInfoModel.data!.message!.gpsInfo!.isIgnitionOn ?? false;
    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : containerMinWidth),
      width: isMobile ? availableWidth : (availableWidth * 40) / 100,
      height: 276,
      child: Wrap(children: [
        gpsContentItem(
            "Ignition Time",
            DateFormat('MM/dd/yyyy hh:mm a')
                .format(DateTime.parse(vehicleGPSInfoModel.data!.message!.gpsInfo!.ignitionChangeTime ?? '')),
            "assets/new_assets/icons/ignition_icon.svg"),
        gpsContentItem("Ignition Status", isIgnitionOn ? "ON" : "OFF", "assets/new_assets/icons/ignition_icon.svg"),
        gpsContentItem("Battery", "${vehicleGPSInfoModel.data!.message!.gpsInfo!.batteryPercent}",
            "assets/new_assets/icons/battery_icon.svg"),
        gpsContentItem("Vehicle Status", "${vehicleGPSInfoModel.data!.message!.gpsInfo!.deviceStatus}",
            "assets/new_assets/icons/vehicle_moving.svg"),
        gpsContentItem(
            "Speed", "${vehicleGPSInfoModel.data!.message!.gpsInfo!.speed}", "assets/new_assets/icons/speed_icon.svg"),
        gpsContentItem("", "", ""),
      ]),
    );
  }

  Container gpsContentItem(String title, String value, String svgPath) {
    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth / 2 : containerMinWidth / 2),
      width: (availableWidth * 20) / 100,
      height: 90,
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(
          color: Color.fromRGBO(233, 243, 255, 1),
          width: 1,
        ),
        left: BorderSide(
          color: Color.fromRGBO(233, 243, 255, 1),
          width: 1,
        ),
        right: BorderSide(
          color: Color.fromRGBO(233, 243, 255, 1),
          width: 1,
        ),
      )),
      child: Padding(
        padding: isMobile
            ? const EdgeInsets.all(defaultPadding)
            : const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  svgPath,
                  width: 25,
                  height: 25,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: AxleTextStyle.miniHeadingBlackStyle,
                )
              ],
            ),
            const SizedBox(
              height: defaultMobilePadding,
            ),
            Text(
              value,
              style: AxleTextStyle.dashboardCardSubTitle,
            )
          ],
        ),
      ),
    );
  }

  Widget gpsCardHeader(String title, String buttonText, Function onPress, VehicleGPSInfoModel vehicleGPSInfoModel) {
    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth : containerMinWidth),
      width: isMobile ? availableWidth : (availableWidth * 40) / 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16)),
        color: Color.fromRGBO(220, 236, 255, 1), //rgba(220, 236, 255, 1)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AxleTextStyle.dashboardCardTitle,
                ),
                InkWell(
                  onTap: () {
                    onPress();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color.fromRGBO(85, 153, 244, 1))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8),
                      child: Text(
                        buttonText,
                        style: AxleTextStyle.goButtonstyle.copyWith(color: const Color.fromRGBO(45, 135, 255, 1)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                gpsHeaderItem("IMEI Number", "${vehicleGPSInfoModel.data!.message!.gpsInfo!.iMEI}",
                    "assets/new_assets/icons/imei_icon.svg"),
                gpsHeaderItem("Type", "Basic", "assets/new_assets/icons/gps_type_icon.svg"),
                gpsHeaderItem("Status", "Installed", "assets/new_assets/icons/gps_status_icon.svg")
              ],
            )
          ],
        ),
      ),
    );
  }

  Column gpsHeaderItem(String label, String value, String svgPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              width: 16,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              label,
              style: AxleTextStyle.miniHeadingBlackStyle,
            )
          ],
        ),
        const SizedBox(
          height: defaultMobilePadding,
        ),
        AxleTextWithBg(text: value, textColor: primaryColor)
      ],
    );
  }
}
