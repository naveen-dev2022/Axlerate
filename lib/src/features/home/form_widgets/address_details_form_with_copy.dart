// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressDetailsFormWithCopy extends ConsumerWidget {
  AddressDetailsFormWithCopy({
    super.key,
    required this.address1Controller,
    required this.address2Controller,
    required this.cityController,
    required this.stateController,
    required this.countryController,
    required this.pinCodeController,
    // this.isCenterAligned = true,
    this.onCheckBoxChange,
    this.checkBoxValue = false,
    this.checkBoxDesc = '',
    this.showWithCheckBox = false,
  });

  final TextEditingController address1Controller;
  final TextEditingController address2Controller;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController pinCodeController;
  // final bool isCenterAligned;
  final void Function(bool?)? onCheckBoxChange;
  final bool checkBoxValue;
  final String checkBoxDesc;
  final bool showWithCheckBox;

  double screenWidth = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);

    return Padding(
      padding: EdgeInsets.all(isMobile ? defaultPadding : defaultPadding * 2),
      child: showWithCheckBox ? addressFormWidgetWithCheckBox() : addressFormWidget(),
    );
    // : showWithCheckBox
    //     ? addressFormWidgetWithCheckBox(isMobile, screenWidth, ref)
    //     : addressFormWidget(isMobile, screenWidth, ref);
  }

  Widget addressFormWidget() {
    return Wrap(
      runSpacing: defaultPadding,
      spacing: defaultPadding,
      children: [
        AxleFormTextField(
          fieldHeading: InputFormConstants.address1FieldLabel,
          fieldHint: InputFormConstants.address1FieldHint,
          fieldController: address1Controller,
          fieldWidth: isMobile ? screenWidth : 320,
          validate: Validators(InputFormConstants.address1FieldLabel).required(),
          isRequiredField: true,
        ),
        AxleFormTextField(
          fieldHeading: InputFormConstants.address2FieldLabel,
          fieldHint: InputFormConstants.address2FieldHint,
          fieldController: address2Controller,
          fieldWidth: isMobile ? screenWidth : 320,
          validate: Validators(InputFormConstants.address2FieldLabel).required(),
          isRequiredField: true,
        ),
        AxleFormTextField(
          fieldHeading: InputFormConstants.cityFieldLabel,
          fieldHint: InputFormConstants.cityFieldHint,
          fieldController: cityController,
          validate: Validators(InputFormConstants.cityFieldLabel).required(),
          fieldWidth: isMobile ? screenWidth : 320,
          isRequiredField: true,
        ),
        AxleSearchDropDownField(
          fieldHeading: InputFormConstants.stateFieldLabel,
          fieldHint: InputFormConstants.stateFieldHint,
          fieldController: stateController,
          fieldWidth: isMobile ? screenWidth : 320,
          validate: Validators(InputFormConstants.stateFieldLabel).required(),
          dropDownOptions: listOfStates,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'ABC is required';
            }
            return null;
          },
          onChanged: (val) {
            stateController.text = val;
          },
          isRequired: true,
        ),
        AxleFormTextField(
          fieldHeading: InputFormConstants.countryFieldLabel,
          fieldHint: InputFormConstants.countryFieldHint,
          fieldController: countryController,
          fieldWidth: isMobile ? screenWidth : 320,
          validate: Validators(InputFormConstants.countryFieldLabel).required(),
          isRequiredField: true,
          isFieldEnabled: false,
        ),
        AxleFormTextField(
          fieldHeading: InputFormConstants.pincodeFieldLabel,
          fieldHint: InputFormConstants.pincodeFieldHint,
          fieldController: pinCodeController,
          validate: Validators(InputFormConstants.pincodeFieldLabel).required(),
          lengthLimit: 6,
          isOnlyDigits: true,
          textType: TextInputType.number,
          fieldWidth: isMobile ? screenWidth : 320,
          isRequiredField: true,
        ),
      ],
    );
  }

  Widget addressFormWidgetWithCheckBox() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: checkBoxValue,
              onChanged: onCheckBoxChange,
            ),
            const SizedBox(width: 10.0),
            Text(
              checkBoxDesc,
              overflow: TextOverflow.ellipsis,
              style: AxleTextStyle.axleFormFieldHeadingStyle,
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            runSpacing: verticalPadding,
            spacing: defaultPadding,
            children: [
              AxleFormTextField(
                fieldHeading: InputFormConstants.address1FieldLabel,
                fieldHint: InputFormConstants.address1FieldHint,
                fieldController: address1Controller,
                fieldWidth: isMobile ? screenWidth : 320,
                validate: Validators(InputFormConstants.address1FieldLabel).required(),
                isRequiredField: true,
                isFieldEnabled: !checkBoxValue,
              ),
              AxleFormTextField(
                fieldHeading: InputFormConstants.address2FieldLabel,
                fieldHint: InputFormConstants.address2FieldHint,
                fieldController: address2Controller,
                fieldWidth: isMobile ? screenWidth : 320,
                validate: Validators(InputFormConstants.address2FieldLabel).required(),
                isRequiredField: true,
                isFieldEnabled: !checkBoxValue,
              ),
              AxleFormTextField(
                fieldHeading: InputFormConstants.cityFieldLabel,
                fieldHint: InputFormConstants.cityFieldHint,
                fieldController: cityController,
                validate: Validators(InputFormConstants.cityFieldLabel).required(),
                fieldWidth: isMobile ? screenWidth : 320,
                isRequiredField: true,
                isFieldEnabled: !checkBoxValue,
              ),
              checkBoxValue
                  ? AxleFormTextField(
                      fieldHeading: InputFormConstants.stateFieldLabel,
                      fieldHint: InputFormConstants.stateFieldHint,
                      fieldController: stateController,
                      fieldWidth: isMobile ? screenWidth : 320,
                      validate: Validators(InputFormConstants.stateFieldLabel).required(),
                      isRequiredField: true,
                      isFieldEnabled: !checkBoxValue,
                    )
                  : AxleSearchDropDownField(
                      fieldHeading: InputFormConstants.stateFieldLabel,
                      fieldHint: InputFormConstants.stateFieldHint,
                      fieldController: stateController,
                      fieldWidth: isMobile ? screenWidth : 320,
                      validate: Validators(InputFormConstants.stateFieldLabel).required(),
                      dropDownOptions: listOfStates,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ABC is required';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        stateController.text = val;
                      },
                      isRequired: true,
                    ),
              AxleFormTextField(
                fieldHeading: InputFormConstants.countryFieldLabel,
                fieldHint: InputFormConstants.countryFieldHint,
                fieldController: countryController,
                fieldWidth: isMobile ? screenWidth : 320,
                validate: Validators(InputFormConstants.countryFieldLabel).required(),
                isRequiredField: true,
                isFieldEnabled: !checkBoxValue,
              ),
              AxleFormTextField(
                fieldHeading: InputFormConstants.pincodeFieldLabel,
                fieldHint: InputFormConstants.pincodeFieldHint,
                fieldController: pinCodeController,
                validate: Validators(InputFormConstants.pincodeFieldLabel).required(),
                lengthLimit: 6,
                textType: TextInputType.number,
                fieldWidth: isMobile ? screenWidth : 320,
                isRequiredField: true,
                isFieldEnabled: !checkBoxValue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
