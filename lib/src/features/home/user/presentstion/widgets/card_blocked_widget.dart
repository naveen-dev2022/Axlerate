import 'package:axlerate/Themes/text_style_config.dart';
import 'package:flutter/material.dart';

class CardBlockedWidget extends StatelessWidget {
  const CardBlockedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Your card is blocked",
                style: AxleTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
