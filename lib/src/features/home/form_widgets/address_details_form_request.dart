import 'dart:developer';
// ignore_for_file: must_be_immutable

import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/services/presentation/controller/service_ui_controller.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressDetailsFormRequest extends ConsumerWidget {
  AddressDetailsFormRequest({
    super.key,
    required this.address1Controller,
    required this.address2Controller,
    required this.cityController,
    required this.stateController,
    required this.countryController,
    required this.pinCodeController,
    required this.isAlreadyAdded,
    this.isEditable = false,
  });

  final TextEditingController address1Controller;
  final TextEditingController address2Controller;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController pinCodeController;
  final bool isAlreadyAdded;
  final bool isEditable;
  bool isMobile = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);
    return addressFormWidget(screenWidth, ref);
  }

  Widget addressFormWidget(double screenWidth, WidgetRef ref) {
    return Wrap(
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
          isFieldEnabled: !isAlreadyAdded || isEditable,
        ),
        AxleFormTextField(
          fieldHeading: InputFormConstants.address2FieldLabel,
          fieldHint: InputFormConstants.address2FieldHint,
          fieldController: address2Controller,
          lengthLimit: 30,
          fieldWidth: isMobile ? screenWidth : 320,
          validate: Validators(InputFormConstants.address2FieldLabel).required(),
          isRequiredField: true,
          isFieldEnabled: !isAlreadyAdded || isEditable,
        ),
        ref.watch(stateListProvider).when(
              data: (response) {
                List<String> allList = response.data?.message ?? [];
                return getStates(
                  screenWidth: screenWidth,
                  ref: ref,
                  allList: allList,
                  isEditable: isEditable,
                );
              },
              error: (error, stackTrace) => getStates(
                screenWidth: screenWidth,
                ref: ref,
                allList: [],
                isEditable: isEditable,
              ),
              loading: () => const CircularProgressIndicator(),
            ),
        ref.watch(selectedStateProvider).isNotEmpty || isEditable
            ? ref.watch(stateCitiesListProvider(ref.read(selectedStateProvider))).when(
                  data: (response) {
                    List<String> allList = response.data?.message ?? [];
                    if (cityController.text.isEmpty) {
                      cityController.text = allList.isNotEmpty ? allList[0] : '';
                    }
                    return AxleSearchDropDownField(
                      key: UniqueKey(),
                      fieldHeading: InputFormConstants.cityFieldLabel,
                      fieldHint: InputFormConstants.cityFieldHint,
                      fieldWidth: isMobile ? screenWidth : 320,
                      fieldController: cityController,
                      dropDownOptions: allList,
                      validate: Validators(InputFormConstants.partnerOrgFieldName).required(),
                      isRequired: true,
                      onChanged: (val) {
                        cityController.text = val!;
                        ref.read(selectedCityProvider.notifier).state = val;
                        // log('Entered Function ');
                        // final picked = stateController.text.split('-').first.trim();
                        // log('Entered SelectedState - $picked');
                      },
                    );
                  },
                  error: (error, stackTrace) => const Text('Error'),
                  loading: () => const CircularProgressIndicator(),
                )
            : AxleFormTextField(
                fieldHeading: InputFormConstants.cityFieldLabel,
                fieldHint: InputFormConstants.cityFieldHint,
                isFieldEnabled: false,
                fieldController: cityController,
                lengthLimit: 20,
                inputformatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                ],
                validate: Validators(InputFormConstants.cityFieldLabel).required(),
                fieldWidth: isMobile ? screenWidth : 320,
                isRequiredField: true,
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
          isFieldEnabled: !isAlreadyAdded || isEditable,
        ),
      ],
    );
  }

  Widget getStates({
    required double screenWidth,
    required WidgetRef ref,
    required List<String> allList,
    required bool isEditable,
  }) {
    return AbsorbPointer(
      absorbing: !isEditable,
      child: AxleSearchDropDownField(
        fieldHeading: InputFormConstants.stateFieldLabel,
        fieldHint: InputFormConstants.stateFieldHint,
        fieldWidth: isMobile ? screenWidth : 320,
        fieldController: stateController,
        dropDownOptions: allList,
        validate: Validators(InputFormConstants.partnerOrgFieldName).required(),
        isRequired: true,
        isEnabled: isEditable,
        onChanged: isEditable
            ? (val) {
                stateController.text = val!;
                cityController.text = '';
                // log('state controller text ${stateController.text}');
                // log('state controller val $val');
                ref.read(selectedStateProvider.notifier).state =
                    stateController.text.isNotEmpty ? stateController.text : val;
                // log('Entered Function ');
                final picked = stateController.text.split('-').first.trim();
                log('Entered SelectedState - $picked');
              }
            : (_) {},
      ),
    );
  }
}
