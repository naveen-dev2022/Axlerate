import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';

class OrgDashboardHeader extends StatelessWidget {
  const OrgDashboardHeader({
    Key? key,
    required this.title,
    this.orgName,
    this.enrollmentId = '',
  }) : super(key: key);

  final String title;
  final String? orgName;
  final String enrollmentId;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      color: AxleColors.axleBackgroundColor,
      child: Padding(
        padding: isMobile
            ? const EdgeInsets.all(defaultPadding)
            : const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(title, style: AxleTextStyle.titleMedium),
                const SizedBox(width: defaultPadding),
                if (orgName != null && orgName!.isNotEmpty)
                  const Icon(
                    Icons.circle,
                    color: primaryColor,
                    size: 10,
                  ),
                if (orgName != null && orgName!.isNotEmpty)
                  const SizedBox(
                    width: 16,
                  ),
                if (orgName != null && orgName!.isNotEmpty)
                  AxleTextWithBg(
                    text: orgName!,
                    textColor: primaryColor,
                    // opaquePercentage: 0.25,
                  ),
              ],
            ),
            if (enrollmentId.isNotEmpty)
              AxlePrimaryButton(
                buttonText: "Services",
                onPress: () {
                  context.router.pushNamed(RouteUtils.getCustomerServicesPath(custEnrollId: enrollmentId));
                },
              ),
          ],
        ),
      ),
    );
  }
}
