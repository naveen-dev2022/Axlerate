import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:flutter/material.dart';

@immutable
class AxleDropdownDialogModel<T> {
  final String title;
  final String subTitle;
  final Map<String, T> buttons;
  final String dropdownLabel;
  final List<String> dropdownOptions;

  const AxleDropdownDialogModel({
    required this.title,
    required this.subTitle,
    required this.buttons,
    required this.dropdownLabel,
    required this.dropdownOptions,
  });
}

extension Present<T> on AxleDropdownDialogModel<T> {
  Future<T?> present(BuildContext context) {
    TextEditingController roleController = TextEditingController();
    // double screenWidth = MediaQuery.of(context).size.width;
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
              AxleSearchDropDownField(
                fieldHeading: dropdownLabel,
                fieldHint: dropdownLabel,
                validate: Validators(InputFormConstants.titleFieldLabel).required(),
                fieldController: roleController,
                // fieldWidth: isMobile ? screenWidth : 320,
                dropDownOptions: dropdownOptions,
                isRequired: true,
                onChanged: (val) {
                  roleController.text = val;
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: buttons.entries.map(
                  (entry) {
                    return entry.key == 'Cancel'
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AxleOutlineButton(
                                buttonWidth: isMobile ? 120 : 200.0,
                                buttonText: entry.key,
                                buttonStyle: AxleTextStyle.saveAndContinuePrimaryStyle,
                                onPress: () {
                                  Navigator.of(context).pop(entry.value);
                                },
                              ),
                              const SizedBox(width: 10.0)
                            ],
                          )
                        : AxlePrimaryButton(
                            buttonWidth: isMobile ? 120 : 200.0,
                            buttonText: entry.key,
                            buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                            onPress: () {
                              if (roleController.text.isNotEmpty) {
                                Navigator.of(context).pop(roleController.text);
                              }
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
