// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:axlerate/Themes/text_style_config.dart';

class StatusAnalyticsSlider extends StatelessWidget {
  StatusAnalyticsSlider({
    Key? key,
    required this.items,
    this.height = 180,
    this.scrollController,
    required this.width,
  }) : super(key: key);

  List<StatusAnalyticsItem> items;
  final double height;
  final double width;
  ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    scrollController ?? ScrollController();
    return SizedBox(
      height: height,
      width: width,
      child: ListView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          children: items
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: StatusAnalyticsItem(
                      primaryColor: e.primaryColor,
                      value: e.value,
                      label: e.label,
                      labelColor: e.labelColor,
                      secondaryColor: e.secondaryColor,
                      svgPath: e.svgPath,
                    ),
                  ))
              .toList()),
    );
  }
}

class StatusAnalyticsItem extends StatelessWidget {
  const StatusAnalyticsItem({
    Key? key,
    required this.primaryColor,
    required this.value,
    required this.label,
    required this.labelColor,
    required this.secondaryColor,
    this.svgPath,
  }) : super(key: key);

  final Color primaryColor;
  final String value;
  final String label;
  final Color labelColor;
  final Color secondaryColor;
  final String? svgPath;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 140,
          height: 40,
          decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.8),
              border: Border.all(
                  width: 1,
                  color: (secondaryColor == Colors.white) ? const Color.fromRGBO(225, 231, 236, 1) : secondaryColor),
              borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text(label, style: AxleTextStyle.kitsAvailableText.copyWith(color: labelColor))),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.2),
                  border: Border.all(width: 1.5, color: primaryColor),
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: Text(
                  value,
                  style: AxleTextStyle.kitsAvailableValue,
                ),
              ),
            ),
            if (svgPath != null)
              Positioned(
                bottom: 0,
                left: -20,
                child: SvgPicture.asset(svgPath!, alignment: Alignment.center, width: 50),
              )
          ],
        ),
      ],
    );
  }
}
