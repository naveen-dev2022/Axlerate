// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/axle_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_service_icon.dart';
import 'package:axlerate/src/common/common_widgets/bottom_status_card.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/values/constants.dart';
import 'package:axlerate/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
import 'dart:developer';

class ListingCard extends ConsumerWidget {
  ListingCard({
    Key? key,
    required this.doc,
    this.showAddIcon = true,
  }) : super(key: key);

  final OrgDoc doc;
  bool showAddIcon;
  bool enableCardTap = true;

  OrgType orgType = OrgType.dummy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    orgType = ref.read(localStorageProvider).getOrgType();

    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId)!.toLowerCase();

    if (ref.watch(localStorageProvider).getOrgType() == OrgType.partner) {
      enableCardTap = false;
    }

    if (doc.status.toLowerCase() == 'invited') {
      showAddIcon = false;
      enableCardTap = false;
    }
    if (doc.organizationServices.length >= 6) {
      showAddIcon = false;
    }
    if (doc.organizationServices.isEmpty) {
      enableCardTap = false;
    }

    return GestureDetector(
      onTap: enableCardTap
          ? () async {
              await context.router.pushNamed(
                '/app/$orgEnrollId/customers/${doc.enrollmentId.toLowerCase()}',
              );
            }
          : null,
      child: SizedBox(
        width: isMobile ? screenWidth : 300,
        // height: isMobile ? 225 : 260,
        child: Container(
          decoration: CommonStyleUtil.axleListingCardDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(height: 10.0),
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Container(
                        decoration: CommonStyleUtil.cardTileIconDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            "assets/new_assets/icons/user_icon.svg",
                            colorFilter: const ColorFilter.mode(AxleColors.axleBlueColor, BlendMode.srcIn),
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                      title: Text(
                        doc.firstName.isEmpty ? doc.enrollmentId : '${doc.firstName} ${doc.lastName}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc.firstName.isEmpty
                                ? doc.orgCode
                                : '${doc.addresses?.communicationAddress?.city ?? ""}, ${doc.addresses?.communicationAddress?.state ?? ""}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            doc.enrollmentId,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // * Total User and Vehicles Count
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          "assets/new_assets/icons/user_icon.svg",
                          colorFilter: const ColorFilter.mode(AxleColors.axleBlueColor, BlendMode.srcIn),
                          height: 15,
                          width: 15,
                        ),
                        Text(
                          doc.users.toString(),
                          style: AxleTextStyle.subtitle1BlackBold,
                        ),
                        Container(
                          height: 14.0,
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        SvgPicture.asset(
                          "assets/new_assets/icons/vehicle_fill_icon.svg",
                          colorFilter: const ColorFilter.mode(AxleColors.axleBlueColor, BlendMode.srcIn),
                          height: 15,
                          width: 15,
                        ),
                        Text(
                          doc.vehicles.toString(),
                          style: AxleTextStyle.subtitle1BlackBold,
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? defaultPadding : 30.0),

                    // * Services Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (getOrgService(doc, 'TAG', issuerName: "YESBANK") != null)
                          AxleServiceIcon(
                              serviceName: Strings.yesBankTag,
                              svgPath: "assets/icons/yb_fastag_icon.svg",
                              status: getOrgService(doc, 'TAG')?.kycStatus ?? ""),
                        if (getOrgService(doc, 'TAG', issuerName: "LIVQUIK") != null)
                          AxleServiceIcon(
                              serviceName: Strings.livquikTag,
                              svgPath: "assets/icons/lq_fastag_icon.svg",
                              status: getOrgService(doc, 'TAG')?.kycStatus ?? ""),
                        if (getOrgService(doc, 'GPS') != null)
                          const AxleServiceIcon(
                              serviceName: Strings.gps, svgPath: "assets/icons/gps_icon.svg", status: "APPROVED"),
                        if (getOrgService(doc, 'PPI') != null)
                          AxleServiceIcon(
                              serviceName: Strings.ppiCard,
                              svgPath: "assets/new_assets/icons/card_icon.svg",
                              status: getOrgService(doc, 'PPI')?.kycStatus ?? ""),
                        if (getOrgService(doc, 'FUEL') != null)
                          AxleServiceIcon(
                              serviceName: Strings.fuelCard,
                              svgPath: "assets/new_assets/icons/fuel_icon.svg",
                              status: getOrgService(doc, 'FUEL')?.kycStatus ?? ""),
                        if (getOrgService(doc, 'INVOICE') != null)
                          AxleServiceIcon(
                              serviceName: Strings.invoice,
                              svgPath: "assets/icons/payment_links_icon.svg",
                              status: getOrgService(doc, 'INVOICE')?.kycStatus ?? ""),
                        // const AxleServiceIcon(svgPath: "assets/new_assets/icons/fuel_icon.svg", status: "DISABLED"),
                        if (showAddIcon)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: CircleAvatar(
                              backgroundColor: AxleColors.axlePrimaryColor,
                              child: IconButton(
                                onPressed: () {
                                  log('ENROLL ID IS : ${doc.enrollmentId}');
                                  context.router.pushNamed(
                                      RouteUtils.getCustomerServicesPath(custEnrollId: doc.enrollmentId.toLowerCase()));
                                  // '/app/$orgEnrollId/customers/${doc.enrollmentId.toLowerCase()}/details/services',
                                  // extra: {
                                  //   'orgName':
                                  //       '${doc.firstName} ${doc.lastName}',
                                  //   'orgId': doc.id,
                                  //   'orgEnrollId': doc.enrollmentId,
                                  //   'orgEntityId': doc.entityId,
                                  //   'isPpiEnabled':
                                  //       doc.services?.ppi != null
                                  //           ? true
                                  //           : false,
                                  // },
                                  // );
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ),
                          )
                      ],
                    ),
                    // SizedBox(height: isMobile ? 10 : 20.0),
                  ],
                ),
              ),
              // bottomStatusCard(doc),
              if (doc.status != 'APPROVED')
                BottomStatusCard(text: doc.status.toString(), cardColor: AxleColors.getStatusColor(doc.status))
            ],
          ),
        ),
      ),
    );
  }

  // Widget showServicesCard(ListOrgDoc doc, bool isMobile) {
  //   if (doc.services == null) {
  //     return Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 2.0),
  //       child: CircleAvatar(
  //         radius: isMobile ? 16.0 : 20.0,
  //         backgroundColor: Colors.redAccent.shade100,
  //         child: Icon(
  //           Icons.lock_clock,
  //           size: isMobile ? 16.0 : 20.0,
  //           color: Colors.redAccent,
  //         ),
  //       ),
  //     );
  //   } else {
  //     doc.services.gps
  //   }
  // }

  Widget? bottomStatusCard(OrgDoc doc) {
    bool isDeclined = doc.status != 'APPROVED';
    if (isDeclined) {
      return BottomStatusCard(text: doc.status.toString(), cardColor: AxleColors.getStatusColor(doc.status));
    } else {
      return const BottomStatusCard(text: '', cardColor: Colors.transparent);
    }
  }
}
