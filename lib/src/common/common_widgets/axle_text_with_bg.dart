import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AxleTextWithBg extends StatelessWidget {
  const AxleTextWithBg(
      {super.key,
      required this.text,
      required this.textColor,
      this.svgPath = '',
      this.opaquePercentage = 0.1,
      this.textAlign = TextAlign.start,
      this.backgroundColor,
      this.titleStyle,
      this.height,
      this.maxLines,
      this.wrapText = false});

  final String text;
  final Color textColor;
  final String svgPath;
  final double opaquePercentage;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final double? height;
  final int? maxLines;
  final bool wrapText;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: backgroundColor ?? textColor.withOpacity(opaquePercentage),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isMobile ? defaultMobilePadding : defaultPadding, vertical: isMobile ? 2 : 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgPath.isNotEmpty)
              Row(
                children: [
                  SvgPicture.asset(
                    svgPath,
                    colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                  ),
                  const SizedBox(width: defaultPadding),
                ],
              ),
            wrapText
                ? Expanded(
                    child: Text(text.toUiCase,
                        maxLines: maxLines,
                        textAlign: textAlign,
                        style: titleStyle ?? AxleTextStyle.labelMedium.copyWith(color: textColor)))
                : Text(text.toUiCase, style: titleStyle ?? AxleTextStyle.labelMedium.copyWith(color: textColor))
          ],
        ),
      ),
    );
  }
}
