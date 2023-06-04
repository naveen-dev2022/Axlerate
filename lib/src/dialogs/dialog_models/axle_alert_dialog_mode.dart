import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:flutter/material.dart';

@immutable
class AxleAlertDialogModel<T> {
  final String title;
  final String subTitle;
  final Map<String, T> buttons;

  const AxleAlertDialogModel({
    required this.title,
    required this.subTitle,
    required this.buttons,
  });
}

extension Present<T> on AxleAlertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
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
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: buttons.entries.map(
                  (entry) {
                    return entry.key == 'NO' || entry.key == 'INVITE'
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AxleOutlineButton(
                                buttonText: entry.key,
                                buttonStyle: AxleTextStyle.saveAndContinuePrimaryStyle,
                                buttonWidth: isMobile ? 100 : 200.0,
                                onPress: () {
                                  Navigator.of(context).pop(entry.value);
                                },
                              ),
                              const SizedBox(width: 10.0)
                            ],
                          )
                        : AxlePrimaryButton(
                            buttonText: entry.key,
                            buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                            buttonWidth: isMobile ? 100.0 : 200.0,
                            onPress: () {
                              Navigator.of(context).pop(entry.value);
                            },
                          );
                  },
                ).toList(),
              )
            ],
          ),
        );
      },
    );
  }
}
