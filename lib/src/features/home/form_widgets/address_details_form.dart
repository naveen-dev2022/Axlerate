// ignore_for_file: must_be_immutable

import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressDetailsForm extends ConsumerWidget {
  AddressDetailsForm({
    super.key,
    required this.address1Controller,
    required this.address2Controller,
    required this.cityController,
    required this.stateController,
    required this.countryController,
    required this.pinCodeController,
    this.isCenterAligned = true,
  });

  final TextEditingController address1Controller;
  final TextEditingController address2Controller;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController pinCodeController;
  final bool isCenterAligned;
  bool isMobile = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);

    return addressFormWidget(screenWidth);
  }

  Widget addressFormWidget(double screenWidth) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? defaultPadding : verticalPadding),
      child: Wrap(
        runSpacing: defaultPadding,
        spacing: defaultPadding,
        children: [
          AxleFormTextField(
            fieldHeading: InputFormConstants.address1FieldLabel,
            fieldHint: InputFormConstants.address1FieldHint,
            fieldController: address1Controller,
            lengthLimit: 30,
            fieldWidth: isMobile ? screenWidth : 320,
            validate: Validators(InputFormConstants.address1FieldLabel).required(),
            isRequiredField: true,
          ),
          AxleFormTextField(
            fieldHeading: InputFormConstants.address2FieldLabel,
            fieldHint: InputFormConstants.address2FieldHint,
            fieldController: address2Controller,
            lengthLimit: 30,
            fieldWidth: isMobile ? screenWidth : 320,
            validate: Validators(InputFormConstants.address2FieldLabel).required(),
            isRequiredField: true,
          ),
          AxleFormTextField(
            fieldHeading: InputFormConstants.cityFieldLabel,
            fieldHint: InputFormConstants.cityFieldHint,
            fieldController: cityController,
            lengthLimit: 20,
            inputformatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
            ],
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
                return 'State is required';
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
      ),
    );
  }
}
