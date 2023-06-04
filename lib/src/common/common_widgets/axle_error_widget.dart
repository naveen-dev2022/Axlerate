import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AxleErrorWidget extends StatelessWidget {
  const AxleErrorWidget(
      {super.key,
      this.imgPath = 'assets/images/no_txn_illus.svg',
      this.imgHeight = 380.0,
      this.titleStr = HomeConstants.somethingWentWrong,
      this.subtitle = '',
      this.showLeadingSpace = true,
      this.showTitle = true});

  final double imgHeight;
  final String imgPath;
  final String titleStr;
  final String subtitle;
  final bool showLeadingSpace;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        showLeadingSpace ? const SizedBox(height: 8.0) : const SizedBox(),
        Center(
          child: SvgPicture.asset(
            imgPath,
            height: imgHeight,
          ),
        ),
        const SizedBox(height: 6.0),
        if (showTitle)
          Text(
            titleStr,
            style: AxleTextStyle.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        const SizedBox(height: 6.0),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AxleTextStyle.titleMedium.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
