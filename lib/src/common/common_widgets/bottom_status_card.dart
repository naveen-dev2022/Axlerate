import 'package:axlerate/Themes/text_style_config.dart';
import 'package:flutter/material.dart';

class BottomStatusCard extends StatelessWidget {
  const BottomStatusCard({
    super.key,
    required this.text,
    required this.cardColor,
    this.textColor = Colors.white,
    this.cardHeight = 30.0,
  });

  final String text;
  final Color cardColor;
  final double cardHeight;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            ),
            height: cardHeight,
            child: Center(
              child: Text(text, style: AxleTextStyle.labelMedium.copyWith(color: Colors.white)),
            ),
          ),
        )
      ],
    );
  }
}
