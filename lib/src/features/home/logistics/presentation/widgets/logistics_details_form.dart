import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_ui_controller.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class LogisticsDetailsForm extends ConsumerWidget {
  LogisticsDetailsForm({
    super.key,
    required this.orgCodeController,
    required this.titleController,
    required this.orgFirstNameController,
    required this.ownerLastNameController,
    required this.dateFieldController,
    required this.mobileController,
    required this.emailController,
    required this.panNumberController,
    required this.natureOfBusinessController,
    this.showOrgCode = true,
    this.onTap,
  });

  final bool showOrgCode;
  final TextEditingController orgCodeController;
  final TextEditingController titleController;
  final TextEditingController orgFirstNameController;
  final TextEditingController ownerLastNameController;
  final TextEditingController dateFieldController;
  final TextEditingController mobileController;
  final TextEditingController emailController;
  final TextEditingController panNumberController;
  final TextEditingController natureOfBusinessController;
  void Function(DateTime)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    DateTime? pickedDateValue;

    return Padding(
      padding: EdgeInsets.all(isMobile ? defaultPadding : defaultPadding * 2),
      child: Wrap(
        runSpacing: defaultPadding,
        spacing: defaultPadding,
        children: [
          AxleSearchDropDownField(
            fieldHeading: InputFormConstants.titleFieldLabel,
            fieldHint: InputFormConstants.titleFieldHint,
            validate: Validators(InputFormConstants.titleFieldLabel).required(),
            fieldController: titleController,
            fieldWidth: isMobile ? screenWidth : 320,
            dropDownOptions: titleList,
            isRequired: true,
            onChanged: (val) {
              titleController.text = val;
            },
          ),
          AxleFormTextField(
            fieldHeading: InputFormConstants.firstNameFieldLabel,
            fieldHint: InputFormConstants.firstNameFieldHint,
            fieldController: orgFirstNameController,
            fieldWidth: isMobile ? screenWidth : 320,
            lengthLimit: 20,
            validate: Validators(InputFormConstants.firstNameFieldLabel).required().min(3),
            isRequiredField: true,
            inputformatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
            ],
          ),
          AxleFormTextField(
            fieldHeading: InputFormConstants.lastnameFieldLabel,
            fieldHint: InputFormConstants.lastnameFieldHint,
            fieldController: ownerLastNameController,
            fieldWidth: isMobile ? screenWidth : 320,
            lengthLimit: 20,
            validate: Validators(InputFormConstants.lastnameFieldLabel).required().min(3),
            isRequiredField: true,
            inputformatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
            ],
          ),
          if (showOrgCode)
            AxleFormTextField(
              fieldHeading: InputFormConstants.orgCodeFieldLabel,
              fieldHint: InputFormConstants.orgCodeHint,
              fieldController: orgCodeController,
              fieldWidth: isMobile ? screenWidth : 320,
              lengthLimit: 3,
              validate: Validators(InputFormConstants.orgCodeFieldLabel).required().min(3).max(3),
              isRequiredField: true,
              onChange: (val) async {
                if (val.length >= 3) {
                  final res = await ref.read(logisticsControllerProvider).checkOrgCode(code: val);
                  if (res) {
                    ref.read(orgCheckIconProvider.notifier).state = const Icon(
                      Icons.check,
                      color: AxleColors.axleGreenColor,
                      size: 16.0,
                    );
                  } else {
                    ref.read(orgCheckIconProvider.notifier).state = const Icon(
                      Icons.close,
                      size: 16.0,
                      color: AxleColors.axleRedColor,
                    );
                  }
                }
              },
              trailingIcon: ref.watch(orgCheckIconProvider),
            ),
          GestureDetector(
            onTap: () async {
              DateTime? date = await DatePickerUtil.pickDate(context, showRecentPicked: pickedDateValue);
              //print(date!.toUtc().toIso8601String());
              pickedDateValue = date;
              if (date != null) {
                dateFieldController.text = DatePickerUtil.userViewDateFormatter(date);
                onTap!(date);
              }
            },
            child: AxleFormTextField(
              fieldHeading: InputFormConstants.dobfieldLabel,
              fieldHint: InputFormConstants.dobfieldHint,
              fieldController: dateFieldController,
              fieldWidth: isMobile ? screenWidth : 320,
              isFieldEnabled: false,
              validate: Validators(InputFormConstants.dobfieldLabel).required(),
              isRequiredField: true,
            ),
          ),
          AxleFormTextField(
            fieldHeading: InputFormConstants.mobileNumberFieldLabel,
            fieldHint: InputFormConstants.mobileNumberFieldHint,
            fieldController: mobileController,
            textType: TextInputType.number,
            lengthLimit: 10,
            isOnlyDigits: true,
            validate: Validators(InputFormConstants.mobileNumberFieldLabel).required().min(10).max(10),
            fieldWidth: isMobile ? screenWidth : 320,
            isRequiredField: true,
          ),
          AxleFormTextField(
            fieldHeading: InputFormConstants.emailFieldLabel,
            fieldHint: InputFormConstants.emailFieldHint,
            fieldController: emailController,
            fieldWidth: isMobile ? screenWidth : 320,
            validate: Validators(InputFormConstants.emailFieldLabel).required().email(),
            isRequiredField: true,
          ),
          AxleFormTextField(
            fieldHeading: InputFormConstants.panNumberFieldLable,
            fieldHint: InputFormConstants.panNumberFieldHint,
            fieldController: panNumberController,
            fieldWidth: isMobile ? screenWidth : 320,
            validate: Validators(InputFormConstants.panNumberFieldLable).required(),
            isRequiredField: true,
          ),
          AxleSearchDropDownField(
            fieldHeading: InputFormConstants.natureOfBusinessFieldLabel,
            fieldHint: InputFormConstants.natureOfBusinessFieldHint,
            fieldController: natureOfBusinessController,
            fieldWidth: isMobile ? screenWidth : 320,
            validate: Validators(InputFormConstants.natureOfBusinessFieldLabel).required(),
            dropDownOptions: natureOfBusinessList,
            isRequired: true,
            onChanged: (val) {
              natureOfBusinessController.text = val;
            },
          ),
        ],
      ),
    );
  }
}
