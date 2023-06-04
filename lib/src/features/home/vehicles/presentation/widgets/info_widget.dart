import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    required this.title,
    required this.data,
    Key? key,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: AxleTextStyle.titleMedium.copyWith(color: Colors.black)),
        const SizedBox(height: defaultMobilePadding),
        Text(data, style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey)),
      ],
    );
  }
}
