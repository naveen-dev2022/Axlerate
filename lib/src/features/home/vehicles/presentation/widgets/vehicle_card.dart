import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_service_icon.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/common/common_widgets/bottom_status_card.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_info_dialog_model.dart';
import 'package:axlerate/src/dialogs/service_info_dialog.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/vehicle_list_model_updated.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/values/constants.dart';
import 'package:axlerate/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';

class VehicleCard extends ConsumerStatefulWidget {
  const VehicleCard({super.key, required this.doc});

  final VehicleDoc doc;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VehicleCardState();
}

double screenWidth = 0.0;
double availableWidth = 0.0;
bool isMobile = false;

class _VehicleCardState extends ConsumerState<VehicleCard> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);

    availableWidth = screenWidth - (defaultPadding * 2);

    final orgData = widget.doc.organizationDetails;

    return GestureDetector(
      onTap: (widget.doc.vehicleServices.isNotEmpty)
          ? () {
              // log('The Vehicle Card Tap Condition -> ${widget.doc.vehicleServices.first.serviceType == 'GPS' || widget.doc.vehicleServices.first.serviceType == 'TAG'}');
              if (((getVehicleListService(
                              vehicleDoc: widget.doc, serviceType: 'GPS') !=
                          null &&
                      getVehicleListService(
                                  vehicleDoc: widget.doc, serviceType: 'GPS')
                              ?.kycStatus ==
                          'INSTALLED') ||
                  (getVehicleListService(
                              vehicleDoc: widget.doc, serviceType: 'TAG') !=
                          null &&
                      getVehicleListService(
                                  vehicleDoc: widget.doc, serviceType: 'TAG')
                              ?.kycStatus ==
                          'APPROVED') ||
                  (getVehicleListService(
                              vehicleDoc: widget.doc, serviceType: 'FUEL') !=
                          null &&
                      getVehicleListService(
                                  vehicleDoc: widget.doc, serviceType: 'FUEL')
                              ?.kycStatus ==
                          'APPROVED'))) {
                context.router.pushNamed(
                  RouteUtils.getVehicleDashboardPath(
                    widget.doc.organizationEnrollmentId,
                    widget.doc.registrationNumber,
                  ),
                );
                return;
              } else {
                // log(getVehicleListService(vehicleDoc: widget.doc, serviceType: 'GPS')?.kycStatus ?? "sdflmsadf;");
                if (getVehicleListService(
                            vehicleDoc: widget.doc, serviceType: 'GPS') !=
                        null ||
                    getVehicleListService(
                            vehicleDoc: widget.doc, serviceType: 'TAG') !=
                        null ||
                    getVehicleListService(
                            vehicleDoc: widget.doc, serviceType: 'FUEL') !=
                        null) {
                  final orgEnrollId = ref
                      .read(sharedPreferenceProvider)
                      .getString(Storage.currentlyPickedOrgEnrollId)!
                      .toLowerCase();
                  context.router.pushNamed(
                    '/app/$orgEnrollId/customers/${widget.doc.organizationEnrollmentId}/vehicles/${widget.doc.registrationNumber}/services',
                  );
                }
              }
            }
          : null,
      child: SizedBox(
        width: isMobile ? availableWidth : 250,
        // height: isMobile ? null : 230,
        child: Container(
          decoration: CommonStyleUtil.axleListingCardDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: isMobile
                    ? const EdgeInsets.symmetric(
                        horizontal: defaultMobilePadding)
                    : const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Container(
                        decoration: CommonStyleUtil.cardTileIconDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                              "assets/new_assets/icons/vehicle_icon.svg",
                              height: 20,
                              width: 20),
                        ),
                      ),
                      title: Text(widget.doc.registrationNumber,
                          overflow: TextOverflow.fade,
                          style: AxleTextStyle.titleMedium
                              .copyWith(color: Colors.black)),
                      subtitle: Text(
                          '${orgData?.firstName} ${orgData?.lastName}',
                          overflow: TextOverflow.ellipsis,
                          style: AxleTextStyle.labelLarge
                              .copyWith(color: Colors.grey)),
                    ),
                    // SizedBox(height: isMobile ? defaultMobilePadding : defaultPadding),

                    /* Removing Tag Status - Need to refine the UI
                    // * Tag Status yesbank
                    if ((widget.doc.accountInformation?.status ?? '').isNotEmpty)
                      tagStatusCard(widget.doc.accountInformation?.status ?? ''),
                    // * Tag Status lq
                    if ((widget.doc.lqtagaccountinformation?.status ?? '').isNotEmpty)
                      tagStatusCard(widget.doc.lqtagaccountinformation?.status ?? ''),
                    */

                    // Adding extra space if approved
                    if (widget.doc.status.toString() == 'APPROVED')
                      const SizedBox(height: defaultPadding),

                    (widget.doc.vehicleServices.isNotEmpty)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (getVehicleListService(
                                      vehicleDoc: widget.doc,
                                      serviceType: 'TAG',
                                      issuerName: "YESBANK") !=
                                  null)
                                AxleServiceIcon(
                                    serviceName: Strings.yesBankTag,
                                    svgPath: "assets/icons/yb_fastag_icon.svg",
                                    status: getVehicleListService(
                                                vehicleDoc: widget.doc,
                                                serviceType: 'TAG')
                                            ?.kycStatus ??
                                        ""),
                              if (getVehicleListService(
                                      vehicleDoc: widget.doc,
                                      serviceType: 'TAG',
                                      issuerName: "LIVQUIK") !=
                                  null)
                                AxleServiceIcon(
                                  serviceName: Strings.fastag,
                                  svgPath: "assets/icons/lq_fastag_icon.svg",
                                  status: getVehicleListService(
                                              vehicleDoc: widget.doc,
                                              serviceType: 'TAG')
                                          ?.kycStatus ??
                                      '',
                                ),
                              if (getVehicleListService(
                                      vehicleDoc: widget.doc,
                                      serviceType: 'GPS') !=
                                  null)
                                AxleServiceIcon(
                                  serviceName: Strings.gps,
                                  svgPath: "assets/icons/gps_icon.svg",
                                  status: getVehicleListService(
                                                  vehicleDoc: widget.doc,
                                                  serviceType: 'GPS')
                                              ?.kycStatus ==
                                          'INSTALLED'
                                      ? 'APPROVED'
                                      : 'PENDING',
                                ),
                              if (getVehicleListService(
                                      vehicleDoc: widget.doc,
                                      serviceType: 'FUEL') !=
                                  null)
                                AxleServiceIcon(
                                  serviceName: Strings.fuelCard,
                                  svgPath:
                                      "assets/new_assets/icons/fuel_icon.svg",
                                  status: getVehicleListService(
                                              vehicleDoc: widget.doc,
                                              serviceType: 'FUEL')
                                          ?.kycStatus ??
                                      '',
                                ),
                              widget.doc.organizationDetails != null
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 6.0),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            AxleColors.axlePrimaryColor,
                                        child: IconButton(
                                          onPressed: () {
                                            final orgEnrollId = ref
                                                .read(sharedPreferenceProvider)
                                                .getString(Storage
                                                    .currentlyPickedOrgEnrollId)!
                                                .toLowerCase();
                                            context.router.pushNamed(
                                              '/app/$orgEnrollId/customers/${widget.doc.organizationEnrollmentId}/vehicles/${widget.doc.registrationNumber}/services',
                                            );
                                          },
                                          icon: const Icon(Icons.add),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        : Center(
                            child: AxlePrimaryButton(
                              buttonHeight: 40,
                              buttonText: 'Add Services',
                              onPress: () async {
                                if (widget.doc.organizationDetails != null) {
                                  final orgEnrollId = ref
                                      .read(sharedPreferenceProvider)
                                      .getString(
                                          Storage.currentlyPickedOrgEnrollId)!
                                      .toLowerCase();
                                  context.router.pushNamed(
                                    '/app/$orgEnrollId/customers/${widget.doc.organizationEnrollmentId}/vehicles/${widget.doc.registrationNumber}/services',
                                  );
                                } else {
                                  await const ServiceInfoDialog()
                                      .present(context);
                                }
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ),
                    SizedBox(height: isMobile ? defaultPadding : 0),
                  ],
                ),
              ),
              if (widget.doc.status.toString() != 'APPROVED')
                BottomStatusCard(
                  text: widget.doc.status.toString(),
                  cardColor: AxleColors.rejectedStatusColor,
                  textColor: Colors.white,
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget tagStatusCard(String tagStatus) {
    Color statusColor = AxleColors.getTagStatusColor(tagStatus.toLowerCase());
    return AxleTextWithBg(
      text: "${tagStatus.toUiCase} Tag",
      textColor: statusColor,
    );
    // return Container(
    //   padding: const EdgeInsets.symmetric(vertical: 4.0),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(8.0),
    //     color: statusColor.withOpacity(0.1),
    //   ),
    //   alignment: Alignment.center,
    //   child: Center(
    //     child: Text(
    //       "${tagStatus.toUiCase} Tag",
    //       style: TextStyle(
    //         color: statusColor,
    //       ),
    //     ),
    //   ),
    // );
  }
}

VehicleService? getVehicleListService({
  VehicleDoc? vehicleDoc,
  String? serviceType,
  String? issuerName,
}) {
  try {
    var index = -1;
    if (vehicleDoc == null || vehicleDoc.vehicleServices.isEmpty) {
      return null;
    }
    if (issuerName != null) {
      index = vehicleDoc.vehicleServices.indexWhere((element) =>
          element.issuerName == issuerName &&
          element.serviceType == serviceType);
    } else {
      index = vehicleDoc.vehicleServices
          .indexWhere((element) => element.serviceType == serviceType);
    }
    if (index == -1) {
      return null;
    }
    return vehicleDoc.vehicleServices[index];
  } catch (e) {
    return null;
  }
}
