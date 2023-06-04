import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:flutter/material.dart';

class PageIndicatorCard extends StatelessWidget {
  const PageIndicatorCard(
      {super.key,
      required this.value,
      this.onPress,
      this.onLongPressed,
      this.isSelected = false,
      this.disabled = false});

  final String value;
  final void Function()? onPress;
  final void Function()? onLongPressed;
  final bool isSelected;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPress,
        onLongPress: onLongPressed,
        child: Container(
          height: 30,
          width: 30,
          padding: const EdgeInsets.all(2.0),
          margin: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : (disabled ? iconGrey : null),
            border: Border.all(
              width: 1.2,
              color: AxleColors.axleBlueColor,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: isSelected ? Colors.white : AxleColors.axleBlueColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
