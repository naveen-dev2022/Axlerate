import 'package:axlerate/Themes/text_style_config.dart';
import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({
    super.key,
    required this.icon,
    required this.text,
    this.textStyle,
    this.iconTextSpacing = 10.0,
  });

  final Icon icon;
  final String text;
  final TextStyle? textStyle;
  final double iconTextSpacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        SizedBox(width: iconTextSpacing),
        Text(
          text,
          style: textStyle ?? AxleTextStyle.bodyText1BlackStyle,
        ),
      ],
    );
  }
}
