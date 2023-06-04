import 'package:axlerate/Themes/text_style_config.dart';
import 'package:flutter/material.dart';

class PaymnetListKeyValueWidget extends StatelessWidget {
  const PaymnetListKeyValueWidget({
    super.key,
    required this.keyStr,
    required this.value,
  });
  final String keyStr;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          keyStr,
          style: AxleTextStyle.titleSmall,
        ),
        Text(
          value,
          style: AxleTextStyle.labelSmall.copyWith(
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
