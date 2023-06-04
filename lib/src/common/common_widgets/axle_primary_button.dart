// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:flutter/material.dart';

class AxlePrimaryButton extends StatelessWidget {
  AxlePrimaryButton({
    Key? key,
    required this.buttonText,
    required this.onPress,
    this.buttonTextStyle,
    this.buttonWidth = 200.0,
    this.buttonHeight = 50,
    this.buttonColor = primaryColor,
    this.buttonPadding,
    this.icon,
  }) : super(key: key);

  final String buttonText;
  final void Function()? onPress;
  double buttonWidth;
  final TextStyle? buttonTextStyle;
  final double buttonHeight;
  final Color buttonColor;
  final EdgeInsetsGeometry? buttonPadding;
  final Icon? icon;

  double screenWidth = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);
    // if (!isMobile) {
    //   if (buttonWidth < 200) {
    //     buttonWidth = 200;
    //   }
    // }
    return icon != null
        ? Semantics(
            button: true,
            label: '$buttonText Button',
            child: ElevatedButton.icon(
              icon: icon!,
              onPressed: onPress,
              style: ElevatedButton.styleFrom(
                padding: buttonPadding,
                backgroundColor: buttonColor,
                minimumSize: Size(buttonWidth, buttonHeight),
                maximumSize: Size(buttonWidth, buttonHeight),
              ),
              label: Text(buttonText),
            ),
          )
        : Semantics(
            button: true,
            label: '$buttonText Button',
            child: ElevatedButton(
              onPressed: onPress,
              style: ElevatedButton.styleFrom(
                padding: buttonPadding,
                backgroundColor: buttonColor,
                minimumSize: Size(buttonWidth, buttonHeight),
                maximumSize: Size(buttonWidth, buttonHeight),
              ),
              child: Text(
                buttonText,
                style: buttonTextStyle ?? AxleTextStyle.titleMedium.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
