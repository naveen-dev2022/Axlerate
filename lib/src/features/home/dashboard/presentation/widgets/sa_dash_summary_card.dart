// ignore_for_file: must_be_immutable

import 'package:axlerate/responsive.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';

class SaDashSummaryCard extends StatelessWidget {
  SaDashSummaryCard(
      {Key? key,
      required this.title,
      required this.value,
      this.svgPath,
      this.subTitle,
      this.fontSize = 42,
      this.iconSize = 60,
      this.borderColor = primaryColor})
      : super(key: key);

  final String title;
  final String value;
  final String? svgPath;
  final double fontSize;
  final double iconSize;
  final String? subTitle;
  final Color borderColor;

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2) + (defaultPadding * 7));

    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 3);
    }

    return Container(
      constraints: BoxConstraints(minWidth: isMobile ? availableWidth / 2 : 250),
      width: isMobile ? availableWidth / 2 : availableWidth * 25 / 100,
      height: 144,
      decoration: CommonStyleUtil.getAxleDashboardCardDecoration(borderColor: borderColor.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 24, 24),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: AxleTextStyle.titleMedium),
                  if (subTitle != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: defaultMobilePadding),
                      child: Text(subTitle!, style: AxleTextStyle.titleSmall),
                    )
                ],
              ),
              if (subTitle != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (svgPath != null) SvgPicture.asset(svgPath!, width: iconSize, alignment: Alignment.topCenter),
                    if (svgPath != null) const SizedBox(width: defaultPadding),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(value,
                          style: TextStyle(
                              height: 0, fontSize: fontSize, color: primaryColor, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              if (subTitle == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(value,
                          style: TextStyle(
                              height: 0, fontSize: fontSize, color: primaryColor, fontWeight: FontWeight.w700)),
                    ),
                    if (svgPath != null) SvgPicture.asset(svgPath!, width: iconSize, alignment: Alignment.topCenter)
                  ],
                )
            ]),
      ),
    );
  }
}
