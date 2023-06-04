// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:flutter/material.dart';

class AxleOutlineButton extends StatelessWidget {
  AxleOutlineButton({
    Key? key,
    required this.buttonText,
    required this.onPress,
    this.outlineColor = primaryColor,
    this.buttonWidth = 200.0,
    this.buttonStyle,
    this.buttonHeight = 50,
    this.buttonPadding,
  }) : super(key: key);

  final String buttonText;
  final void Function()? onPress;
  double buttonWidth;
  final double buttonHeight;
  final Color outlineColor;
  final TextStyle? buttonStyle;
  final EdgeInsetsGeometry? buttonPadding;

  double screenWidth = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);
    if (!isMobile) {
      if (buttonWidth < 200) {
        buttonWidth = 200;
      }
    }
    return Semantics(
      button: true,
      label: '$buttonText Button',
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          padding: buttonPadding,
          backgroundColor: snowColor,
          foregroundColor: highlightColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0), side: BorderSide(color: outlineColor, width: 1.2)),
          minimumSize: Size(buttonWidth, buttonHeight),
          maximumSize: Size(buttonWidth, buttonHeight),
        ),
        child: Text(
          buttonText,
          style: buttonStyle ?? AxleTextStyle.titleMedium.copyWith(color: outlineColor),
        ),
      ),
    );
  }
}
