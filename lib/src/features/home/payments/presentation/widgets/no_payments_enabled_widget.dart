import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoPaymentsEnabledWidget extends StatelessWidget {
  const NoPaymentsEnabledWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            'assets/images/no_txn_illus.svg',
            height: 380.0,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Text(
          'Payments service not enabled.',
          style: AxleTextStyle.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'If you are interested to opt for the service, click the below button to initiate the process',
          textAlign: TextAlign.center,
          style: AxleTextStyle.titleMedium.copyWith(
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
        AxlePrimaryButton(
          buttonWidth: 180.0,
          onPress: () {
            context.router.pushNamed(RouteUtils.getPaymentsEnablePath());
          },
          buttonText: 'Enable Payments',
          buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
