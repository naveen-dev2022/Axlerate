// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class DashSummaryTransactionsCard extends StatelessWidget {
  DashSummaryTransactionsCard(
      {Key? key,
      required this.title,
      this.credit,
      required this.debit,
      this.borderColor = primaryColor,
      this.subTitle = "Total Value of Transaction (Credit - Debit)",
      this.fontSize = 42,
      this.iconSize = 100})
      : super(key: key);

  final String title;
  final String? credit;
  final String debit;
  final Color borderColor;
  final double fontSize;
  final double iconSize;
  String? subTitle;
  bool isComingSoon = false;

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    isMobile = Responsive.isMobile(context);
    isComingSoon = debit.toLowerCase().contains("coming soon");
    if (isComingSoon) {
      subTitle = null;
    }
    return Container(
      width: isMobile ? screenWidth : 350,
      height: 162,
      decoration: CommonStyleUtil.getAxleDashboardCardDecoration(borderColor: borderColor.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                // textBaseline: TextBaseline.ideographic,
                children: [
                  if (credit != null) creditDebitDisplayWithIcon(type: "Credit", value: credit!),
                  creditDebitDisplayWithIcon(type: "Debit", value: debit),
                ],
              )
            ]),
      ),
    );
  }

  Row creditDebitDisplayWithIcon({required String type, required String value}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            type == "Credit"
                ? "assets/new_assets/icons/dashboard_card_credit.svg"
                : "assets/new_assets/icons/dashboard_card_debit.svg",
            width: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          value.contains("Coming Soon")
              ? Text(value, style: AxleTextStyle.subtitle1IconGreyBold)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      type,
                      style: AxleTextStyle.dashboardCardCrDrTitle,
                    ),
                    Text(
                      value,
                      style: AxleTextStyle.dashboardCardCrDrValue,
                    )
                  ],
                )
        ],
      );
}
