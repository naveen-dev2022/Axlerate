import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconInfoWidget extends StatelessWidget {
  const IconInfoWidget({super.key, required this.iconPath, required this.title});

  final String title;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          child: SvgPicture.asset(
            iconPath,
            colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.only(left: defaultMobilePadding),
          child: Text(title, overflow: TextOverflow.ellipsis),
        )),
      ],
    );
  }
}
