import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';

@immutable
class CardLockDialogModel<T> {
  final String heading;
  final String title1;
  final String subtitle1;
  final String title2;
  final String subtitle2;

  const CardLockDialogModel({
    required this.heading,
    required this.title1,
    required this.subtitle1,
    required this.title2,
    required this.subtitle2,
  });
}

extension Present<T> on CardLockDialogModel<T> {
  Future<T?> present(BuildContext context, {bool isLocked = false}) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    heading,
                    textAlign: TextAlign.center,
                    style: AxleTextStyle.headline6BlackStyle,
                  ),
                  IconButton(
                    splashRadius: 15.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26.0),
              // * First Item
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.grey.shade100,
                        width: 2.0,
                      )),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isLocked ? 'Unlock Card' : 'Lock Card',
                          textAlign: TextAlign.center,
                          style: AxleTextStyle.headline6BlackStyle.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Flexible(
                          child: SizedBox(
                            width: 350.0,
                            child: Text(
                              subtitle1,
                              textAlign: TextAlign.left,
                              style: AxleTextStyle.subtitle2GreyStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // * Second Item
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.grey.shade100,
                        width: 2.0,
                      )),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title2,
                          textAlign: TextAlign.center,
                          style: AxleTextStyle.headline6BlackStyle.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Flexible(
                          child: SizedBox(
                            width: 350.0,
                            child: Text(
                              subtitle2,
                              textAlign: TextAlign.left,
                              style: AxleTextStyle.subtitle2GreyStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
