import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:flutter/material.dart';

class AxlePrimaryIconButton extends StatelessWidget {
  const AxlePrimaryIconButton({
    Key? key,
    required this.buttonText,
    required this.onPress,
    this.buttonTextStyle,
    this.adjustButtonText = false,
    required this.buttonIcon,
    this.buttonWidth = 200.0,
    this.buttonHeight = 50,
  }) : super(key: key);

  final String buttonText;
  final void Function()? onPress;
  final double buttonWidth;
  final double buttonHeight;
  final bool adjustButtonText;
  final Widget buttonIcon;
  final TextStyle? buttonTextStyle;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$buttonText Button',
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          backgroundColor: primaryColor,
          minimumSize: Size(buttonWidth, buttonHeight),
          maximumSize: Size(buttonWidth, buttonHeight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            buttonIcon,
            const SizedBox(width: 4.0),
            Text(
              buttonText,
              style: buttonTextStyle ?? AxleTextStyle.primaryButtonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
