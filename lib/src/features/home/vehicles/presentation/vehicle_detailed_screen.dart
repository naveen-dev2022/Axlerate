import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/lq_user_acc_info_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/yesbank_tag_account_info_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/get_vehicle_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/widgets/info_widget.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

@RoutePage()
class VehicleDetailedScreen extends ConsumerStatefulWidget {
  const VehicleDetailedScreen({
    super.key,
    // required this.orgEnrolId,
    // required this.vehicleEntityId,
  });

  // final String orgEnrolId;
  // final String vehicleEntityId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VehicleDetailedScreenState();
}

class _VehicleDetailedScreenState extends ConsumerState<VehicleDetailedScreen> {
  late Future<DetailVehicleUpdatedModel> vehicleDetailsFuture;
  late Future<YesBankTagAccountInfoModel> yesBankTagAccDetailsFuture;
  late Future<LqUserAccInfoModel> livquikTagAccDetailsFuture;

  Service? vehicleDataLq;

  @override
  void initState() {
    vehicleDetailsFuture = getVehicleDetails();
    yesBankTagAccDetailsFuture = getYesBankTagAccDetails();
    livquikTagAccDetailsFuture = getLivquikTagAccDetails();

    vehicleDataLq = getVehicleService(vehicle, "TAG", issuerName: "LIVQUIK");
    super.initState();
  }

  Future<DetailVehicleUpdatedModel> getVehicleDetails() async {
    vehicle = ref.read(vehicleDetailsProvider);
    return await ref.read(vehicleControllerProvider).getVehicleDetailsById(vehicleId: vehicle!.id);
  }

  Future<YesBankTagAccountInfoModel> getYesBankTagAccDetails() async {
    vehicle = ref.read(vehicleDetailsProvider);
    if (getVehicleService(vehicle, "TAG", issuerName: "YESBANK") != null) {
      return await ref
          .read(vehicleControllerProvider)
          .getYesBankTagAccInfoDetailsByEntityId(entityId: vehicle!.registrationNumber);
    } else {
      return const YesBankTagAccountInfoModel.unknown();
    }
  }

  Future<LqUserAccInfoModel> getLivquikTagAccDetails() async {
    org = ref.read(orgDetailsProvider);
    vehicle = ref.read(vehicleDetailsProvider);
    if (getVehicleService(vehicle, "TAG", issuerName: "LIVQUIK") != null) {
      return await ref.read(logisticsControllerProvider).lqTagAccInfoByEnrollmentId(orgEnrollId: org!.enrollmentId);
    } else {
      return LqUserAccInfoModel.unknown();
    }
  }

  OrgDoc? org;
  Vehicle? vehicle;

  @override
  Widget build(BuildContext context) {
    org = ref.watch(orgDetailsProvider);
    vehicle = ref.watch(vehicleDetailsProvider);
    return org == null || vehicle == null
        ? AxleLoader.axleProgressIndicator()
        : FutureBuilder<DetailVehicleUpdatedModel>(
            future: vehicleDetailsFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return AxleLoader.axleProgressIndicator();
                case ConnectionState.done:
                default:
                  // if (snapshot.hasError) {
                  //   return const Text('Error');
                  // } else
                  if (snapshot.hasData) {
                    final DetailVehicleUpdatedModel? allData = snapshot.data;
                    // log(allData!.data!.message?.registrationNumber ?? 'NOO');
                    if (snapshot.data?.data == null) {
                      return const Text('Something went wrong!');
                    }
                    final msgData = allData?.data?.message;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                        child: Column(
                          children: [
                            DashboardHeader(
                              title: "Vehicle Detailed View",
                              orgName: org!.displayName,
                              vehicleId: vehicle!.registrationNumber,
                              // buttonText: "Detailed View",
                              // onButtonPressed: () {
                              //   context.go(
                              //     RouteUtils.getVehicleDetailsPath(org!.enrollmentId, vehicle!.registrationNumber),
                              //   );
                              // },
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AxleColors.borderColor, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      children: [
                                        getVehicleService(vehicle, "TAG") != null
                                            ? VehicleServiceStatusCard(
                                                title: "FASTag",
                                                status: getVehicleService(vehicle, 'TAG') != null
                                                    ? msgData?.services != null
                                                        ? ("KYC ${getVehicleService(msgData, 'TAG')?.kycStatus.toUiCase}")
                                                        : 'Not Installed'
                                                    : 'Not Installed',
                                                iconPath: "assets/new_assets/icons/tag_icon_with_bg.svg",
                                              )
                                            : Container(),
                                        const SizedBox(width: defaultPadding),
                                        getVehicleService(vehicle, "GPS") != null
                                            ? VehicleServiceStatusCard(
                                                title: "GPS",
                                                status: getVehicleService(vehicle, "GPS") != null
                                                    ? (getVehicleService(msgData, 'GPS')
                                                                ?.kycStatus
                                                                .toUpperCase()
                                                                .contains("INSTALLED") !=
                                                            null)
                                                        ? "Installed"
                                                        : 'Not Installed'
                                                    : 'Not Installed',
                                                iconPath: "assets/new_assets/icons/gps_icon_with_bg.svg",
                                              )
                                            : Container(),
                                        const SizedBox(width: defaultPadding),
                                        //  VehicleServiceStatusCard(
                                        //   title: "Fuel Card",
                                        //   status: msgData?.services?.fuel.isNotEmpty ?? false
                                        //       ? ("KYC ${msgData?.services?.fuel.first.status.toUiCase}")
                                        //       : 'Not Installed',
                                        //   iconPath: "assets/new_assets/icons/fuel_icon_with_bg.svg",
                                        // ),
                                        // const SizedBox(width: defaultPadding),
                                      ],
                                    ),
                                    const SizedBox(height: defaultPadding),
                                    Container(
                                      padding: const EdgeInsets.all(defaultPadding),
                                      decoration: CommonStyleUtil.axleListingCardDecoration,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "Vehicle Details",
                                                    style: AxleTextStyle.subtitle1IconGreyBold,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: defaultPadding),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Wrap(
                                                    spacing: 50,
                                                    runSpacing: 50,
                                                    children: [
                                                      InfoWidget(
                                                        title: 'Registration No.',
                                                        data: msgData?.registrationNumber ?? 'N/A',
                                                      ),
                                                      InfoWidget(
                                                        title: 'Registration Date',
                                                        data: msgData?.registrationDate != null
                                                            ? DateFormat('dd/MM/yyyy').format(
                                                                DateTime.parse(
                                                                    msgData?.registrationDate.toString() ?? 'N/A'),
                                                              )
                                                            : 'N/A',
                                                        //  msgData?.registrationDate?.toString() ?? 'N/A',
                                                      ),
                                                      InfoWidget(
                                                        title: 'Registration Certificate Status',
                                                        data: msgData?.status ?? '',
                                                      ),
                                                      InfoWidget(
                                                        title: 'Engine No',
                                                        data: msgData?.engineNumber ?? '',
                                                      ),
                                                      InfoWidget(
                                                        title: 'Chassis Number',
                                                        data: msgData?.chasisNumber ?? '',
                                                      ),
                                                      InfoWidget(
                                                        title: 'Fuel Type',
                                                        data: msgData?.fuelType.toUiCase ?? '',
                                                      ),
                                                      InfoWidget(
                                                        title: 'Fitness Expiry Date',
                                                        data: msgData?.fitnessUpto != null
                                                            ? DateFormat('dd/MM/yyyy').format(
                                                                DateTime.parse(msgData?.fitnessUpto.toString() ?? ''),
                                                              )
                                                            : 'N/A',
                                                        //  msgData?.fitnessUpto.toString() ?? '',
                                                      ),
                                                      InfoWidget(
                                                        title: 'Insurance Expiry Date',
                                                        data: msgData?.insuranceExpiryDate != null
                                                            ? DateFormat('dd/MM/yyyy').format(
                                                                DateTime.parse(
                                                                    msgData?.insuranceExpiryDate.toString() ?? 'N/A'),
                                                              )
                                                            : 'N/A',
                                                        // msgData?.insuranceExpiryDate.toString() ?? 'N/A',
                                                      ),
                                                      InfoWidget(
                                                        title: 'Vehicle Type',
                                                        data: msgData?.vehicleCategory ?? 'N/A',
                                                      ),
                                                      InfoWidget(
                                                        title: 'Fitness Certificate Status',
                                                        data: msgData?.status ?? 'N/A',
                                                      ),
                                                      InfoWidget(
                                                        title: 'Insurance Status',
                                                        data: msgData?.insuranceExpiryDate != null
                                                            ? DateTime.parse(msgData?.insuranceExpiryDate.toString() ??
                                                                            '')
                                                                        .difference(DateTime.now())
                                                                        .inMinutes >=
                                                                    5
                                                                ? 'Active'
                                                                : 'Inactive'
                                                            : 'N/A',
                                                      ),
                                                      InfoWidget(
                                                        title: 'Maker Model of Manufacturer',
                                                        data: msgData?.vehicleType?.maker ?? 'N/A',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: defaultPadding),
                                              const SizedBox(height: defaultPadding),
                                              Container(height: 1, color: AxleColors.iconColor.withOpacity(0.2)),

                                              getVehicleService(vehicle, "TAG", issuerName: "YESBANK") != null
                                                  ? FutureBuilder<YesBankTagAccountInfoModel>(
                                                      future: yesBankTagAccDetailsFuture,
                                                      builder: (context, snapshot) {
                                                        switch (snapshot.connectionState) {
                                                          case ConnectionState.waiting:
                                                            return AxleLoader.axleProgressIndicator();
                                                          case ConnectionState.done:
                                                          default:
                                                            if (snapshot.hasError) {
                                                              return const Text('Error');
                                                            } else if (snapshot.hasData) {
                                                              if (snapshot.data?.data == null) {
                                                                return const Center(
                                                                  child: Text(
                                                                    'No Data Found',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold, fontSize: 22.0),
                                                                  ),
                                                                );
                                                              }
                                                              final resData = snapshot.data;
                                                              return Column(
                                                                children: [
                                                                  const SizedBox(height: defaultPadding),
                                                                  const SizedBox(height: defaultPadding),
                                                                  Padding(
                                                                    padding: const EdgeInsets.symmetric(
                                                                        horizontal: defaultPadding),
                                                                    child: Align(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Text(
                                                                        "FASTag Details",
                                                                        style: AxleTextStyle.subtitle1IconGreyBold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: defaultPadding),
                                                                  Padding(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                                                    child: Align(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Wrap(
                                                                        spacing: 60,
                                                                        runSpacing: 50,
                                                                        children: [
                                                                          InfoWidget(
                                                                            title: 'Balance Type',
                                                                            data: msgData?.services.indexWhere(
                                                                                        (element) =>
                                                                                            element.serviceType ==
                                                                                            'TAG') !=
                                                                                    null
                                                                                ? msgData?.services != null
                                                                                    ? ("${getVehicleService(msgData, 'TAG')?.balanceType.toUiCase}")
                                                                                    : ''
                                                                                : '',
                                                                          ),
                                                                          InfoWidget(
                                                                            title: 'Threshold Limit',
                                                                            data: resData?.data?.message != null
                                                                                ? (resData
                                                                                        ?.data?.message?.thresholdLimit
                                                                                        .toString() ??
                                                                                    '0')
                                                                                : '',
                                                                          ),
                                                                          InfoWidget(
                                                                            title: 'Tag Balance',
                                                                            data: resData?.data?.message != null
                                                                                ? (resData?.data?.message
                                                                                        ?.availableBalance
                                                                                        .toString() ??
                                                                                    '0')
                                                                                : '',
                                                                          ),
                                                                          InfoWidget(
                                                                            title: 'Tag Status',
                                                                            data: resData?.data?.message != null
                                                                                ? (resData?.data?.message?.status ?? '')
                                                                                : '',
                                                                          ),
                                                                          InfoWidget(
                                                                            title: 'FASTag Serial Number',
                                                                            data: msgData?.services.indexWhere(
                                                                                        (element) =>
                                                                                            element.serviceType ==
                                                                                            'TAG') !=
                                                                                    null
                                                                                ? msgData?.services != null
                                                                                    ? ("${getVehicleService(msgData, 'TAG')?.serialNumber.toUiCase}")
                                                                                    : ''
                                                                                : '',
                                                                          ),
                                                                          InfoWidget(
                                                                            title: 'Tag Class',
                                                                            data: msgData?.services.indexWhere(
                                                                                        (element) =>
                                                                                            element.serviceType ==
                                                                                            'TAG') !=
                                                                                    null
                                                                                ? msgData?.services != null
                                                                                    ? ("${getVehicleService(msgData, 'TAG')?.vehicleClass?.tagClass.toUiCase}")
                                                                                    : ''
                                                                                : '',
                                                                          ),
                                                                          InfoWidget(
                                                                            title: 'Mapper Class',
                                                                            data: msgData?.services.indexWhere(
                                                                                        (element) =>
                                                                                            element.serviceType ==
                                                                                            'TAG') !=
                                                                                    null
                                                                                ? msgData?.services != null
                                                                                    ? ("${getVehicleService(msgData, 'TAG')?.vehicleClass?.mapperClass.toUiCase}")
                                                                                    : ''
                                                                                : '',
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: defaultPadding),
                                                                  const SizedBox(height: defaultPadding),
                                                                  Container(
                                                                      height: 1,
                                                                      color: AxleColors.iconColor.withOpacity(0.2)),
                                                                ],
                                                              );
                                                            } else {
                                                              return AxleLoader.axleProgressIndicator();
                                                            }
                                                        }
                                                      },
                                                    )
                                                  : Container(),

                                              vehicleDataLq != null
                                                  ? FutureBuilder<LqUserAccInfoModel>(
                                                      future: livquikTagAccDetailsFuture,
                                                      builder: (context, snapshot) {
                                                        switch (snapshot.connectionState) {
                                                          case ConnectionState.waiting:
                                                            return AxleLoader.axleProgressIndicator();
                                                          case ConnectionState.done:
                                                          default:
                                                            if (snapshot.hasError) {
                                                              return const Text('Error');
                                                            } else if (snapshot.hasData) {
                                                              if (snapshot.data?.data == null) {
                                                                return const Center(
                                                                  child: Text(
                                                                    'No Data Found',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold, fontSize: 22.0),
                                                                  ),
                                                                );
                                                              }
                                                              final resData = snapshot.data;
                                                              return Column(
                                                                children: [
                                                                  const SizedBox(height: defaultPadding),
                                                                  const SizedBox(height: defaultPadding),
                                                                  Padding(
                                                                    padding: const EdgeInsets.symmetric(
                                                                        horizontal: defaultPadding),
                                                                    child: Align(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Text(
                                                                        "FASTag Details",
                                                                        style: AxleTextStyle.subtitle1IconGreyBold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: defaultPadding),
                                                                  Padding(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                                                    child: Align(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Wrap(
                                                                        spacing: 60,
                                                                        runSpacing: 50,
                                                                        children: [
                                                                          InfoWidget(
                                                                            title: 'Balance Type',
                                                                            data: vehicleDataLq != null
                                                                                ? msgData?.services != null
                                                                                    ? ("${vehicleDataLq?.balanceType.toUiCase}")
                                                                                    : ''
                                                                                : '',
                                                                          ),
                                                                          InfoWidget(
                                                                            title: 'Threshold Limit',
                                                                            data: resData?.data?.message != null
                                                                                ? getLqTagAccInfo(resData, "VEHICLE")
                                                                                        ?.thresholdLimit
                                                                                        .toString() ??
                                                                                    '0'
                                                                                : '',
                                                                          ),
                                                                          InfoWidget(
                                                                            title: 'Tag Balance',
                                                                            data: (resData?.data?.message != null)
                                                                                ? getLqTagAccInfo(resData, "VEHICLE")
                                                                                        ?.availableBalance
                                                                                        .toString() ??
                                                                                    '0'
                                                                                : '0',
                                                                          ),
                                                                          InfoWidget(
                                                                            title: 'Tag Status',
                                                                            data: resData?.data?.message != null
                                                                                ? getLqTagAccInfo(resData, "VEHICLE")
                                                                                        ?.status
                                                                                        .toString() ??
                                                                                    '0'
                                                                                : '',
                                                                          ),
                                                                          InfoWidget(
                                                                            title: 'FASTag Serial Number',
                                                                            data: msgData?.services.indexWhere(
                                                                                        (element) =>
                                                                                            element.serviceType ==
                                                                                            'TAG') !=
                                                                                    null
                                                                                ? msgData?.services != null
                                                                                    ? ("${vehicleDataLq?.serialNumber.toUiCase}")
                                                                                    : ''
                                                                                : '',
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: defaultPadding),
                                                                  const SizedBox(height: defaultPadding),
                                                                  Container(
                                                                      height: 1,
                                                                      color: AxleColors.iconColor.withOpacity(0.2)),
                                                                ],
                                                              );
                                                            } else {
                                                              return AxleLoader.axleProgressIndicator();
                                                            }
                                                        }
                                                      },
                                                    )
                                                  : Container(),

                                              getVehicleService(vehicle, "GPS") != null
                                                  ? Column(
                                                      children: [
                                                        const SizedBox(height: defaultPadding),
                                                        const SizedBox(height: defaultPadding),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(horizontal: defaultPadding),
                                                          child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(
                                                              "GPS Details",
                                                              style: AxleTextStyle.subtitle1IconGreyBold,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: defaultPadding),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                                          child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Wrap(
                                                              spacing: 60,
                                                              runSpacing: 50,
                                                              children: [
                                                                InfoWidget(
                                                                  title: 'IMEI Number', //check
                                                                  data: msgData?.services.indexWhere((element) =>
                                                                              element.serviceType == 'GPS') !=
                                                                          null
                                                                      ? msgData?.services != null
                                                                          ? ("${getVehicleService(msgData, 'GPS')?.imei.toUiCase}")
                                                                          : 'N/A'
                                                                      : 'N/A',
                                                                ),
                                                                InfoWidget(
                                                                  title: 'GPS Status',
                                                                  data: msgData?.services.indexWhere((element) =>
                                                                              element.serviceType == 'GPS') !=
                                                                          null
                                                                      ? msgData?.services != null
                                                                          ? ("${getVehicleService(msgData, 'GPS')?.kycStatus.toUiCase}")
                                                                          : 'N/A'
                                                                      : 'N/A',
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: defaultPadding),
                                                        const SizedBox(height: defaultPadding),
                                                        Container(
                                                            height: 1, color: AxleColors.iconColor.withOpacity(0.2)),
                                                      ],
                                                    )
                                                  : Container(),

                                              // const SizedBox(height: defaultPadding),
                                              // const SizedBox(height: defaultPadding),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                                              //   child: Align(
                                              //     alignment: Alignment.centerLeft,
                                              //     child: Text(
                                              //       "Fuel Card Details",
                                              //       style: AxleTextStyle.subtitle1IconGreyBold,
                                              //     ),
                                              //   ),
                                              // ),
                                              // const SizedBox(height: defaultPadding),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(horizontal: 16),
                                              //   child: Align(
                                              //     alignment: Alignment.centerLeft,
                                              //     child: Wrap(
                                              //       spacing: 60,
                                              //       runSpacing: 50,
                                              //       children: const [
                                              //         InfoWidget(
                                              //           title: 'Name of Service Provider',
                                              //           data: 'DriveTrackPlus-HP',
                                              //         ),
                                              //         InfoWidget(
                                              //           title: 'Control Card Number',
                                              //           data: '3501249560',
                                              //         ),
                                              //         InfoWidget(
                                              //           title: 'Customer ID',
                                              //           data: '2001303883',
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),

                                              // const SizedBox(height: 36),
                                              // const Padding(
                                              //   padding: EdgeInsets.symmetric(horizontal: 16),
                                              //   child: Align(
                                              //     alignment: Alignment.centerLeft,
                                              //     child: Text(
                                              //       "KYC Documents",
                                              //       style: TextStyle(
                                              //         fontWeight: FontWeight.bold,
                                              //         fontSize: 15,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                              // const SizedBox(height: 18),
                                              // Container(height: 1, color: Colors.grey),
                                              // const SizedBox(height: 18),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(horizontal: 16),
                                              //   child: Align(
                                              //     alignment: Alignment.centerLeft,
                                              //     child: Wrap(
                                              //       spacing: 60,
                                              //       runSpacing: 50,
                                              //       children: const [
                                              //         // for (var i = 0; i < vehicleDetails.kycDocuments.length; i++)
                                              //         //   KYCDocumentWidget(
                                              //         //     title: Strings.getStatusString(vehicleDetails.kycDocuments[i].name),
                                              //         //     downloadUrl: vehicleDetails.kycDocuments[i].url,
                                              //         //   )
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return AxleLoader.axleProgressIndicator();
                  }
              }
            },
          );
  }
}

class VehicleServiceStatusCard extends StatelessWidget {
  const VehicleServiceStatusCard({super.key, required this.title, required this.status, required this.iconPath});

  final String title;
  final String status;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    Color textColor = getColor(status.toLowerCase());
    return Stack(
      alignment: AlignmentDirectional.topEnd - const AlignmentDirectional(0.2, 2),
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: textColor, width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: AxleTextStyle.headingBlack,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "Status",
                    style: AxleTextStyle.subHeadingBlack,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: textColor.withOpacity(0.1),
                    ),
                    alignment: Alignment.center,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 4),
                        child: Row(
                          children: [
                            // Icon(getIcon(status), color: textColor),
                            // const SizedBox(width: defaultPadding),
                            Text(
                              status,
                              style: TextStyle(color: textColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
        SvgPicture.asset(
          iconPath,
          height: 100,
        )
      ],
    );
  }

  getColor(String status) {
    Color toRet = primaryColor;

    if (status.contains("approved") || status.contains("installed")) {
      toRet = AxleColors.axleGreenColor;
    } else if (status.contains("rejected")) {
      toRet = AxleColors.axleRedColor;
    } else if (status.contains("not")) {
      toRet = Colors.grey;
    }

    return toRet;
  }

  getIcon(String status) {
    IconData toRet = Icons.check_circle;

    if (status.contains("approved")) {
      toRet = Icons.check_circle;
    } else if (status.contains("rejected")) {
      toRet = Icons.cancel_rounded;
    } else if (status.contains("not")) {
      toRet = Icons.close_rounded;
    }

    return toRet;
  }
}

LqUserAccInfoModelMessage? getLqTagAccInfo(
  LqUserAccInfoModel? doc,
  String type,
) {
  int index = 0;
  try {
    if (doc == null || doc.data == null || doc.data!.message.isEmpty) {
      return null;
    }

    index = doc.data!.message.indexWhere((element) {
      return element.type == type;
    });

    if (index == -1) {
      return null;
    }
    return doc.data!.message[index];
  } catch (e) {
    return null;
  }
}
