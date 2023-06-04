import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';

class LabelValueWidget extends StatelessWidget {
  const LabelValueWidget({
    Key? key,
    required this.heading,
    required this.value,
  }) : super(key: key);

  final String heading;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 120.0,
              child: Text(heading,
                  style: AxleTextStyle.bodyMedium.copyWith(color: AxleColors.iconColor, fontWeight: FontWeight.bold))),
          const SizedBox(width: defaultPadding),
          Text(value, style: AxleTextStyle.bodyMedium),
        ],
      ),
    );
  }
}
