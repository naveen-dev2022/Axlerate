import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_service_icon.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/common/common_widgets/bottom_status_card.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_route/auto_route.dart';

class AxlePartnerCard extends ConsumerWidget {
  const AxlePartnerCard({
    Key? key,
    required this.doc,
  }) : super(key: key);

  final OrgDoc doc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);

    return GestureDetector(
      onTap: (() {
        // context.go(RouteUtils.getPartnersDashboardPath(doc.enrollmentId), extra: {
        //   'orgId': doc.id,
        // });
        context.router.pushNamed(RouteUtils.getPartnersDashboardPath(doc.enrollmentId));
      }),
      child: SizedBox(
        width: isMobile ? screenWidth : 300,
        // height: isMobile ? 230 : 260,
        child: Container(
          decoration: CommonStyleUtil.axleListingCardDecoration,
          child: Padding(
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
                      padding: const EdgeInsets.all(defaultMobilePadding),
                      child: SvgPicture.asset(
                        "assets/new_assets/icons/dummy_company_logo.svg",
                        // color: AxleColors.axleBlueColor,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  title: Text(
                    '${doc.firstName} ${doc.lastName}',
                    style: isMobile ? AxleTextStyle.headingBlack.copyWith(fontSize: 14) : AxleTextStyle.headingBlack,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  subtitle: Text(
                    '${doc.addresses?.communicationAddress?.city ?? ""}, ${doc.addresses?.communicationAddress?.state ?? ""}',
                    style: isMobile
                        ? AxleTextStyle.subtitle1IconGrey.copyWith(fontSize: 12)
                        : AxleTextStyle.subtitle1IconGrey,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),

                const SizedBox(height: defaultPadding),

                getPartnerOrgType(doc.natureOfBusiness),

                SizedBox(height: isMobile ? defaultMobilePadding : defaultPadding),
                SizedBox(height: isMobile ? defaultMobilePadding : defaultPadding),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (getOrgService(doc, 'TAG') != null)
                      Column(
                        children: [
                          const AxleServiceIcon(svgPath: "assets/new_assets/icons/tag_icon.svg", status: "Tag Enabled"),
                          Text(
                            doc.totalTagPartnerOrg.toString(),
                            style: AxleTextStyle.subHeadingBlack,
                          ),
                        ],
                      ),
                    if (getOrgService(doc, 'PPI') != null)
                      Column(
                        children: [
                          const AxleServiceIcon(
                              svgPath: "assets/new_assets/icons/card_icon.svg", status: "Card Enabled"),
                          Text(
                            doc.ppiUsersPartnerOrg.toString(),
                            style: AxleTextStyle.subHeadingBlack,
                          )
                        ],
                      ),
                    Column(
                      children: [
                        const AxleServiceIcon(svgPath: "assets/new_assets/icons/fuel_icon.svg", status: "DISABLED"),
                        Text(
                          "0",
                          style: AxleTextStyle.subHeadingBlack,
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

  Widget bottomStatusCard(OrgDoc doc) {
    bool isDeclined = doc.status != 'APPROVED';
    if (isDeclined) {
      return BottomStatusCard(text: doc.status.toString().toUiCase, cardColor: Colors.redAccent);
    } else {
      return const BottomStatusCard(text: '', cardColor: Colors.transparent);
    }
  }

  Widget getPartnerOrgType(String natureOfBusiness) {
    Widget toRet;
    if (natureOfBusiness.contains("PVT_LTD")) {
      toRet = const AxleTextWithBg(
        text: "Pvt. Ltd",
        textColor: AxleColors.axleAquaBlue,
        svgPath: 'assets/new_assets/icons/pvt_ltd_logo.svg',
      );
    } else if (natureOfBusiness.contains("PARTNERSHIP")) {
      toRet = const AxleTextWithBg(
        text: "Partnership",
        textColor: AxleColors.axlePrimaryColor,
        svgPath: 'assets/new_assets/icons/partnership_icon.svg',
      );
    } else if (natureOfBusiness.contains("SOLE_PROPRIETOR")) {
      toRet = const AxleTextWithBg(
        text: "Sole Proprietor",
        textColor: AxleColors.axlePurple,
        svgPath: 'assets/new_assets/icons/sole_proprietor_icon.svg',
      );
    } else if (natureOfBusiness.contains("PUBLIC_LTD")) {
      toRet = const AxleTextWithBg(
        text: "Public Limited",
        textColor: AxleColors.dashGreen,
        svgPath: 'assets/new_assets/icons/sole_proprietor_icon.svg',
      );
    } else if (natureOfBusiness.contains("INDIVIDUAL")) {
      toRet = const AxleTextWithBg(
        text: "Individual",
        textColor: AxleColors.dashPink,
        svgPath: 'assets/new_assets/icons/sole_proprietor_icon.svg',
      );
    } else {
      toRet = AxleTextWithBg(
        text: natureOfBusiness.toTitleCase(),
        textColor: primaryColor,
        svgPath: 'assets/new_assets/icons/pvt_ltd_logo.svg',
      );
    }
    return toRet;
  }
}
