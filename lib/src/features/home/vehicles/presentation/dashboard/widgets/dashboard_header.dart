import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
// import 'package:go_router/go_router.dart';
import 'package:auto_route/auto_route.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    Key? key,
    this.vehicleId,
    required this.title,
    this.orgName,
    this.buttonText,
    this.onButtonPressed,
    this.showBack = true,
    this.onBackPressed,
  }) : super(key: key);

  final String title;
  final String? vehicleId;
  final String? orgName;
  final String? buttonText;
  final Function()? onButtonPressed;
  final bool showBack;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (showBack && context.router.canNavigateBack)
                Row(
                  children: [
                    InkWell(
                        onTap: onBackPressed ??
                            () {
                              if (context.router.canNavigateBack) {
                                context.router.pop();
                              }
                            },
                        child: Text("<-", style: AxleTextStyle.headingPrimary)),
                    const SizedBox(width: defaultPadding),
                  ],
                ),
              Text(title, style: AxleTextStyle.titleMedium),
              const SizedBox(width: defaultPadding),
              if (vehicleId != null) Text(vehicleId!.toUpperCase(), style: AxleTextStyle.dashboardCardTitle1),
              if (vehicleId != null)
                const SizedBox(
                  width: 16,
                ),
              if (orgName != null)
                const Icon(
                  Icons.circle,
                  color: primaryColor,
                  size: 10,
                ),
              if (orgName != null)
                const SizedBox(
                  width: 16,
                ),
              if (orgName != null)
                AxleTextWithBg(
                  text: orgName!,
                  textColor: primaryColor,
                  // opaquePercentage: 0.25,
                )
            ],
          ),
          if (buttonText != null)
            AxlePrimaryButton(buttonText: buttonText!, onPress: onButtonPressed
                // () {
                //   context.go(RouteUtils.getVehicleDetailsPath(vehicleId), extra: {
                //     'vehicleId': vehicleId,
                //   });
                // },
                )
        ],
      ),
    );
  }
}
