import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';

class FormSectionHeadingWidget extends StatelessWidget {
  const FormSectionHeadingWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    // bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: const EdgeInsets.all(defaultMobilePadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Text(title, style: AxleTextStyle.formSectionHeadingStyle, maxLines: 2)),
          const SizedBox(width: defaultMobilePadding),
          Flexible(
              child: Text(subTitle,
                  overflow: TextOverflow.ellipsis, style: AxleTextStyle.formSectionHintStyle, maxLines: 3)),
        ],
      ),
    );
  }
}
