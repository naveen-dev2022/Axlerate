// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AxleSearchDropDownField extends StatelessWidget {
  AxleSearchDropDownField({
    super.key,
    this.isRequired = false,
    this.fieldHeading,
    required this.fieldHint,
    this.fieldWidth = 400,
    this.dropDownOptions = const [],
    required this.fieldController,
    this.validator,
    this.validate,
    this.readOnly = false,
    required this.onChanged,
    this.isEnabled = true,
    this.dropdownHeight = 0,
  });

  final bool isRequired;
  final String fieldHint;
  final String? fieldHeading;
  final double fieldWidth;
  final List<String> dropDownOptions;
  final TextEditingController fieldController;
  final String? Function(dynamic)? validator;
  final Validators? validate;
  final bool readOnly;
  final dynamic onChanged;
  final bool isEnabled;
  double dropdownHeight;

  @override
  Widget build(BuildContext context) {
    if (dropdownHeight == 0) {
      for (var i = 0; i < dropDownOptions.length; i++) {
        if (dropDownOptions.length >= 5) {
          dropdownHeight = 5 * 52;
        } else {
          dropdownHeight = dropDownOptions.length * 52;
        }
      }
    }

    return SizedBox(
      width: fieldWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (fieldHeading != null)
                Text(fieldHeading!, style: AxleTextStyle.titleSmall.copyWith(color: Colors.black)),
              isRequired ? const Text('*', style: TextStyle(color: Colors.redAccent)) : const SizedBox(),
            ],
          ),
          if (fieldHeading != null) const SizedBox(height: 10.0),
          Semantics(
            label: '$fieldHeading Field',
            child: Stack(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.transparent),
                  readOnly: readOnly,
                  controller: fieldController,
                  enabled: isEnabled,
                  // textInputAction: textInputAction,
                  // onTap: onTapField,
                  // onFieldSubmitted: onFieldSubmitted,
                  onFieldSubmitted: (value) {
                    // if (kIsWeb || textInputAction == TextInputAction.done) {
                    // onFieldSubmitted();
                    // }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    errorStyle: AxleTextStyle.fieldErrorTextStyle,
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: const BorderSide(color: primaryColor, width: 1.7),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: const BorderSide(color: Color(0xffDCE9F6), width: 1.6),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: const BorderSide(color: fieldErrorColor, width: 1.2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: const BorderSide(color: fieldErrorColor, width: 1.2),
                    ),
                    hintText: fieldHint,
                    hintStyle: AxleTextStyle.labelLarge.copyWith(color: Colors.grey),
                  ),
                  validator: MultiValidator(
                    validate != null ? validate!.validations : [],
                  ),
                ),
                TextDropdownFormField(
                  controller: DropdownEditingController(value: fieldController.text),
                  onChanged: ((dynamic item) {
                    fieldController.text = item;
                    onChanged!(item);
                  }),
                  options: dropDownOptions,
                  dropdownHeight: dropdownHeight,
                  decoration: InputDecoration(
                    enabled: isEnabled,
                    contentPadding: const EdgeInsets.all(20.0),
                    semanticCounterText: '$fieldHeading Field',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    hintStyle: AxleTextStyle.axleFormFieldHintStyle,
                    // errorStyle: AxleTextStyle.labelMedium,
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
