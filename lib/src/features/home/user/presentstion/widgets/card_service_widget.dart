import 'package:axlerate/Themes/text_style_config.dart';
import 'package:flutter/material.dart';

class CardServiceWidget extends StatelessWidget {
  const CardServiceWidget({
    super.key,
    required this.title,
    this.onPress,
  });

  final String title;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          width: 500,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              width: 1.6,
              color: const Color(0xffEBEBFB),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AxleTextStyle.axleFormFieldHintStyle,
              ),
              const SizedBox(width: 30.0),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
