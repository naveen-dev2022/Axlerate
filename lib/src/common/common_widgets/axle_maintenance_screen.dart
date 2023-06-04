import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UnderMaintenance extends StatelessWidget {
  const UnderMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Center(
            child: SvgPicture.asset(
              'assets/new_assets/curve_bg.svg',
            ),
          ),
        ),
        Text(
          "Oh Uh!",
          style: AxleTextStyle.labelLarge.copyWith(
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Text(
          "Service under maintenance. Please try again in sometime ",
          style: AxleTextStyle.labelMedium.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
