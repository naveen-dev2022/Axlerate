// ignore_for_file: must_be_immutable

import 'package:axlerate/app_util/enums/kyc_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentsKycDetailsForm extends ConsumerStatefulWidget {
  PaymentsKycDetailsForm({
    super.key,
    required this.kycStatusController,
    required this.midController,
    required this.mccController,
    required this.midPassController,
    required this.rejReasoncontroller,
    required this.productionKeyController,
    required this.productionApiKeyController,
    required this.testApiKeyController,
    required this.currentKycType,
    required this.companyNameController,
    this.isFieldEnable = true,
  });

  final TextEditingController kycStatusController;
  final TextEditingController midController;
  final TextEditingController mccController;
  final TextEditingController midPassController;
  final TextEditingController rejReasoncontroller;
  final TextEditingController productionKeyController;
  final TextEditingController productionApiKeyController;
  final TextEditingController testApiKeyController;
  final TextEditingController companyNameController;
  KycType currentKycType;
  bool isFieldEnable;

  @override
  ConsumerState<PaymentsKycDetailsForm> createState() => _PaymentsKycDetailsFormState();
}

class _PaymentsKycDetailsFormState extends ConsumerState<PaymentsKycDetailsForm> {
  bool isMobile = false;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;

  // KycType currentKycType = KycType.kycPending;

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    screenWidth = MediaQuery.of(context).size.height;
    screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Wrap(
        runSpacing: defaultPadding,
        spacing: 40.0,
        children: [
          // widget.currentKycType == KycType.kycRejected
          //     ? AxleFormTextField(
          //         fieldHeading: "Rejected Reason",
          //         fieldHint: "Enter Reason for KYC Rejection",
          //         fieldController: widget.rejReasoncontroller,
          //         validate: Validators('Rejected Reason').required(),
          //         textType: TextInputType.text,
          //         fieldWidth: isMobile ? screenWidth : 420,
          //         isRequiredField: true,
          //       )
          //     : Container(),
          Visibility(
            visible: widget.currentKycType == KycType.kycApproved,
            child: AxleFormTextField(
              fieldHeading: "Company Name",
              fieldHint: "Enter Company Name",
              fieldController: widget.companyNameController,
              validate: Validators('Company Name').required(),
              textType: TextInputType.text,
              fieldWidth: isMobile ? screenWidth : 420,
              isRequiredField: true,
              isFieldEnabled: widget.isFieldEnable,
            ),
          ),
          Visibility(
            visible: widget.currentKycType == KycType.kycApproved,
            child: AxleFormTextField(
              fieldHeading: "MID",
              fieldHint: "Enter MID",
              fieldController: widget.midController,
              validate: Validators('MID').required(),
              isOnlyDigits: true,
              textType: TextInputType.number,
              fieldWidth: isMobile ? screenWidth : 420,
              isRequiredField: true,
              isFieldEnabled: widget.isFieldEnable,
            ),
          ),
          Visibility(
            visible: widget.currentKycType == KycType.kycApproved,
            child: AxleFormTextField(
              fieldHeading: "MCC",
              fieldHint: "Enter MCC",
              fieldController: widget.mccController,
              validate: Validators('MCC').required(),
              isOnlyDigits: true,
              textType: TextInputType.number,
              fieldWidth: isMobile ? screenWidth : 420,
              isRequiredField: true,
              isFieldEnabled: widget.isFieldEnable,
            ),
          ),
          // Visibility(
          //   visible: widget.currentKycType == KycType.kycApproved,
          //   child: AxleFormTextField(
          //     fieldHeading: "Password",
          //     fieldHint: "Enter Password",
          //     fieldController: widget.midPassController,
          //     validate: Validators('Password').required(),
          //     textType: TextInputType.text,
          //     fieldWidth: isMobile ? screenWidth : 420,
          //     isRequiredField: true,
          //   ),
          // ),
          Visibility(
            visible: widget.currentKycType == KycType.kycApproved,
            child: AxleFormTextField(
              fieldHeading: "ProductionKey",
              fieldHint: "Enter ProductionKey",
              fieldController: widget.productionKeyController,
              validate: Validators('ProductionKey').required(),
              textType: TextInputType.text,
              fieldWidth: isMobile ? screenWidth : 420,
              isRequiredField: true,
              isFieldEnabled: widget.isFieldEnable,
            ),
          ),
          Visibility(
            visible: widget.currentKycType == KycType.kycApproved,
            child: AxleFormTextField(
              fieldHeading: "Production Api Key",
              fieldHint: "Enter production Api Key",
              fieldController: widget.productionApiKeyController,
              validate: Validators('Production ApiKey').required(),
              textType: TextInputType.text,
              fieldWidth: isMobile ? screenWidth : 420,
              isRequiredField: true,
              isFieldEnabled: widget.isFieldEnable,
            ),
          ),
          Visibility(
            visible: widget.currentKycType == KycType.kycApproved,
            child: AxleFormTextField(
              fieldHeading: "Test Api Key",
              fieldHint: "Enter Test Api Key",
              fieldController: widget.testApiKeyController,
              validate: Validators('Test ApiKey').required(),
              textType: TextInputType.text,
              fieldWidth: isMobile ? screenWidth : 420,
              isRequiredField: true,
              isFieldEnabled: widget.isFieldEnable,
            ),
          ),
        ],
      ),
    );
  }
}
