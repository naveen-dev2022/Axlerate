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

class PpiAddressDetailsForm extends ConsumerWidget {
  const PpiAddressDetailsForm({
    super.key,
    required this.address1Controller,
    required this.address2Controller,
    this.address3Controller,
    required this.cityController,
    required this.stateController,
    required this.countryController,
    required this.pinCodeController,
    this.isCenterAligned = true,
    this.showAddr3 = true,
    this.isAlreadyenabled = false,
    this.isCopyAddressWidget = false,
  });

  final TextEditingController address1Controller;
  final TextEditingController address2Controller;
  final TextEditingController? address3Controller;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController pinCodeController;
  final bool isCenterAligned;
  final bool showAddr3;
  final bool isAlreadyenabled;
  final bool isCopyAddressWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);

    return isCenterAligned
        ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: addressFormWidget(isMobile, screenWidth),
            ))
        : addressFormWidget(isMobile, screenWidth);
  }

  Wrap addressFormWidget(bool isMobile, double screenWidth) {
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
          isFieldEnabled: !isAlreadyenabled,
          lengthLimit: 30,
          inputformatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9/., ]'), replacementString: '')],
        ),
        AxleFormTextField(
          fieldHeading: InputFormConstants.address2FieldLabel,
          fieldHint: InputFormConstants.address2FieldHint,
          fieldController: address2Controller,
          fieldWidth: isMobile ? screenWidth : 320,
          validate: Validators(InputFormConstants.address2FieldLabel).required(),
          isRequiredField: true,
          isFieldEnabled: !isAlreadyenabled,
          lengthLimit: 30,
          inputformatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9/., ]'), replacementString: '')],
        ),
        if (showAddr3)
          AxleFormTextField(
            fieldHeading: InputFormConstants.address3FieldLabel,
            fieldHint: InputFormConstants.address3FieldHint,
            fieldController: address3Controller,
            fieldWidth: isMobile ? screenWidth : 320,
            validate: Validators(InputFormConstants.address3FieldLabel).required(),
            isRequiredField: false,
            isFieldEnabled: !isAlreadyenabled,
            lengthLimit: 30,
            inputformatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9/., ]'), replacementString: '')],
          ),
        AxleFormTextField(
          fieldHeading: InputFormConstants.cityFieldLabel,
          fieldHint: InputFormConstants.cityFieldHint,
          fieldController: cityController,
          validate: Validators(InputFormConstants.cityFieldLabel).required(),
          fieldWidth: isMobile ? screenWidth : 320,
          lengthLimit: 20,
          inputformatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z]'), replacementString: '')],
          isRequiredField: true,
          isFieldEnabled: !isAlreadyenabled,
        ),
        isCopyAddressWidget && isAlreadyenabled
            ? AxleFormTextField(
                fieldHeading: InputFormConstants.stateFieldLabel,
                fieldHint: InputFormConstants.stateFieldHint,
                fieldController: stateController,
                validate: Validators(InputFormConstants.stateFieldLabel).required(),
                fieldWidth: isMobile ? screenWidth : 320,
                isRequiredField: true,
                isFieldEnabled: !isAlreadyenabled,
              )
            : AbsorbPointer(
                absorbing: isAlreadyenabled,
                child: AxleSearchDropDownField(
                  fieldHeading: InputFormConstants.stateFieldLabel,
                  fieldHint: InputFormConstants.stateFieldHint,
                  fieldController: stateController,
                  fieldWidth: isMobile ? screenWidth : 320,
                  validate: Validators(InputFormConstants.stateFieldLabel).required(),
                  dropDownOptions: listOfStates,
                  onChanged: (val) {
                    stateController.text = val!;
                  },
                  isRequired: true,
                ),
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
          validate: Validators(InputFormConstants.pincodeFieldLabel).required().min(6).max(6),
          lengthLimit: 6,
          textType: TextInputType.number,
          fieldWidth: isMobile ? screenWidth : 320,
          isRequiredField: true,
          isFieldEnabled: !isAlreadyenabled,
        ),
      ],
    );
  }
}
