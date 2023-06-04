import 'package:axlerate/responsive.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';

class GpsDetailCard extends StatelessWidget {
  const GpsDetailCard({
    Key? key,
    required this.svgPath,
    required this.title,
    required this.value,
    required this.unit,
  }) : super(key: key);

  final String svgPath;
  final String title;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double availableWidth = screenWidth - (defaultPadding * 5);
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        height: 160,
        width: isMobile ? availableWidth / 2 : 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), border: Border.all(color: AxleColors.borderColor, width: 1)),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(svgPath, width: 32),
                  const SizedBox(width: defaultMobilePadding),
                  Expanded(
                    child: Tooltip(
                      triggerMode: kIsWeb ? null : TooltipTriggerMode.tap,
                      message: title,
                      child: Text(title, style: AxleTextStyle.subHeadingBlack, overflow: TextOverflow.ellipsis),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value.toString(), style: AxleTextStyle.gpsCardValueText),
                  Padding(
                    padding: const EdgeInsets.only(bottom: defaultMobilePadding),
                    child: Text(unit, style: AxleTextStyle.gpsCardUnitText),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
