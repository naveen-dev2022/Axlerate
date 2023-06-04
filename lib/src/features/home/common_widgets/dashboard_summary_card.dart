// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class DashSummaryCard extends StatelessWidget {
  DashSummaryCard(
      {Key? key,
      required this.title,
      required this.value,
      required this.svgPath,
      this.subTitle,
      this.borderColor = const Color.fromRGBO(58, 54, 219, 0.1),
      this.fontSize = 42,
      this.iconSize = 100,
      this.isLoading = false})
      : super(key: key);

  final String title;
  final String value;
  final String svgPath;
  final double fontSize;
  double iconSize;
  final String? subTitle;
  final Color borderColor;
  final bool isLoading;

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;
  bool isComingSoon = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2) + (defaultPadding * 7));
    isComingSoon = value.contains("Coming Soon");
    isMobile = Responsive.isMobile(context);

    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 3);
      if (iconSize > 75) {
        iconSize = 75;
      }
    }

    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth / 2 : 250),
      width: isMobile ? availableWidth / 2 : availableWidth * 25 / 100,
      height: 164,
      decoration: CommonStyleUtil.getAxleDashboardCardDecoration(borderColor: borderColor.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: isComingSoon
                        ? AxleTextStyle.dashboardCardTitle.copyWith(color: AxleColors.iconColor)
                        : AxleTextStyle.dashboardCardTitle,
                  ),
                  if (subTitle != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(subTitle!,
                          style: isComingSoon
                              ? AxleTextStyle.dashboardCardSubTitle.copyWith(color: AxleColors.iconColor)
                              : AxleTextStyle.dashboardCardSubTitle),
                    )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: isLoading
                        ? Shimmer.fromColors(
                            enabled: true,
                            loop: 5,
                            baseColor: iconGrey.withOpacity(0.3),
                            highlightColor: iconGrey.withOpacity(0.6),
                            child: Container(
                              width: isMobile ? 80 : 150,
                              height: 30,
                              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                            ))
                        : FittedBox(
                            child: Text(
                              value,
                              style: TextStyle(
                                  // height: 0,
                                  fontSize: isComingSoon ? 13 : fontSize,
                                  color: isComingSoon ? AxleColors.iconColor : primaryColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                  ),
                  SvgPicture.asset(svgPath, width: iconSize, alignment: Alignment.topCenter)
                ],
              )
            ]),
      ),
    );
  }
}
