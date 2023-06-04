import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:flutter/material.dart';

@immutable
class AxleInfoDialogModel<T> {
  final String title;
  final String subTitle;
  final String buttonTitle;

  const AxleInfoDialogModel({
    required this.title,
    required this.subTitle,
    required this.buttonTitle,
  });
}

extension Present<T> on AxleInfoDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          insetPadding: const EdgeInsets.all(30.0),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: AxleTextStyle.headline6BlackStyle,
              ),
              const SizedBox(height: 20.0),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: AxleTextStyle.subtitle2GreyStyle,
              ),
              const SizedBox(height: 26.0),
              AxlePrimaryButton(
                buttonText: buttonTitle,
                buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                onPress: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
