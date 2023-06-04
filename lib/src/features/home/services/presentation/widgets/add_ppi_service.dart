// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/typedefs/typedefs.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/services/domain/add_ppi_service_input_mode.dart';
import 'package:axlerate/src/features/home/services/presentation/controller/add_ppi_service_controller.dart';
import 'package:axlerate/src/features/home/services/presentation/controller/service_controller.dart';
import 'package:axlerate/src/features/home/services/presentation/widgets/ppi_primary_details_form.dart';
import 'package:axlerate/src/features/home/services/presentation/widgets/ppi_upload_docs_form.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPpiServiceToOrganization extends ConsumerStatefulWidget {
  const AddPpiServiceToOrganization({
    super.key,
    required this.orgId,
    required this.orgEnrollId,
    required this.orgType,
    required this.isPpiEnabled,
    required this.org,
  });

  final OrganizationID orgId;
  final OrgEnrollID orgEnrollId;
  // final String orgEntityId;
  final bool isPpiEnabled;
  final OrgDoc org;
  final OrgType orgType;

  @override
  ConsumerState<AddPpiServiceToOrganization> createState() => _AddPpiServiceToOrganizationState();
}

class _AddPpiServiceToOrganizationState extends ConsumerState<AddPpiServiceToOrganization> {
  final GlobalKey<FormState> enablePPIFormKey = GlobalKey<FormState>();

  final TextEditingController commissionController = TextEditingController();

  final TextEditingController organizationController = TextEditingController();

  final TextEditingController thresholdLimitController = TextEditingController();

  final TextEditingController idProofController = TextEditingController();

  final TextEditingController addressProffController = TextEditingController();

  final TextEditingController identityProofUrl = TextEditingController();
  final TextEditingController addressProofUrl = TextEditingController();

  bool isPartnerAdmin = false;

  String partnerOrgEnrollmentId = '';

  String partnerOrgId = '';
  bool isEditable = false;
  OrganizationService? ppiData;

  @override
  void initState() {
    ppiData = getOrgService(widget.org, 'PPI');
    autofillFields();
    if (widget.isPpiEnabled == false) {
      isEditable = true;
    }
    super.initState();
  }

  autofillFields() async {
    //OrgDoc? res = await ref.read(serviceControlProvider).getOrgById(orgId);
    if (widget.isPpiEnabled) {
      organizationController.text = ppiData?.partnerEnrollmentId ?? '';
      commissionController.text = ppiData?.cashBackPercentage.toString() ?? '';
      idProofController.text = ppiData?.kycDocuments?.identityProof?.url.isNotEmpty ?? false ? "UPLOADED" : '';
      addressProffController.text = ppiData?.kycDocuments?.addressProof?.url.isNotEmpty ?? false ? "UPLOADED" : '';
      identityProofUrl.text = ppiData?.kycDocuments?.identityProof?.url ?? '';
      addressProofUrl.text = ppiData?.kycDocuments?.addressProof?.url ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ref.watch(localStorageProvider).getOrgType() == OrgType.partner) {
      isPartnerAdmin = true;
      partnerOrgEnrollmentId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      partnerOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      organizationController.text = partnerOrgEnrollmentId;
    }

    bool isMobile = Responsive.isMobile(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: enablePPIFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: (widget.orgType != OrgType.logisticsAdmin),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Primary Details",
                        style: AxleTextStyle.headingPrimary,
                      ),
                      (widget.orgType == OrgType.axlerate && widget.isPpiEnabled)
                          ? ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isEditable ? Colors.grey : Colors.blue,
                              ),
                              onPressed: () {
                                isEditable ? isEditable = false : isEditable = true;
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 24.0,
                              ),
                              label: const Text('Edit'),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: (widget.orgType != OrgType.logisticsAdmin),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: PpiPrimaryDetailsForm(
                    commissionController: commissionController,
                    organizationController: organizationController,
                    isEditable: isEditable,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  "Upload Documents",
                  style: AxleTextStyle.headingPrimary,
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: PpiUploadDocsForm(
                  idProofController: idProofController,
                  addressProofController: addressProffController,
                  orgEnrollId: widget.orgEnrollId,
                  isEditable: isEditable,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        getOrgService(widget.org, 'PPI', issuerName: 'LIVQUIK')?.kycStatus == 'PENDING'
            ? Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                  children: [
                    AxleOutlineButton(
                      buttonText: InputFormConstants.cancelbuttonText,
                      buttonStyle: AxleTextStyle.outLineButtonStyle,
                      buttonWidth: isMobile ? 100.0 : 200.0,
                      onPress: () {
                        context.router.pop();
                      },
                    ),
                    const SizedBox(width: 20.0),
                    AxlePrimaryButton(
                      buttonText: "Resubmit",
                      buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                      buttonWidth: 200.0,
                      onPress: () {
                        log('message');
                        validatePpiForm(context, ref, true);
                      },
                    )
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                  children: [
                    if (!widget.isPpiEnabled || isEditable)
                      AxleOutlineButton(
                        buttonText: InputFormConstants.cancelbuttonText,
                        buttonStyle: AxleTextStyle.outLineButtonStyle,
                        buttonWidth: isMobile ? 100.0 : 200.0,
                        onPress: () {
                          context.router.pop();
                        },
                      ),
                    const SizedBox(width: 20.0),
                    AxlePrimaryButton(
                      buttonText: !widget.isPpiEnabled || isEditable ? "ENABLE PPI" : "Service Enabled",
                      buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                      buttonWidth: 200.0,
                      onPress: !widget.isPpiEnabled || isEditable
                          ? () {
                              validatePpiForm(context, ref, false);
                            }
                          : null,
                    )
                  ],
                ),
              )
      ],
    );
  }

  validatePpiForm(BuildContext context, WidgetRef ref, bool isRetry) async {
    if (isPartnerAdmin) {
      ref.read(selectPartnerOrgIdProvider.notifier).state = partnerOrgId;
    }
    if (enablePPIFormKey.currentState!.validate()) {
      if (widget.orgType == OrgType.logisticsAdmin) {
        addOrRetryPpiService(context, ref, isRetry);
      } else if (checkValidPercentage()) {
        addOrRetryPpiService(context, ref, isRetry);
      }
    }
  }

  addOrRetryPpiService(BuildContext context, WidgetRef ref, bool isRetry) async {
    AxleLoader.show(context);
    bool res;
    bool result;
    if (isRetry == true) {
      res = await ref.read(serviceControlProvider).retryaddPpiServiceToOrganization(widget.orgId);
    } else {
      res = await ref.read(serviceControlProvider).addPpiServiceToOrganization(getFormInputs(ref));
    }
    AxleLoader.hide();
    if (res) {
      result = await ref
          .read(logisticsControllerProvider)
          .getOrganisationByEnrolmentId(enrolId: widget.orgEnrollId, isSetOrgDetailProvider: true);
      if (result) {
        context.router.pushNamed(RouteUtils.getOrgManageCardPath(widget.org.enrollmentId));
      }
    }
  }

  bool checkValidPercentage() {
    final val = int.parse(commissionController.text);
    if (val > 100) {
      Snackbar.error('Commision Percentage should be less than 100');
      return false;
    }
    return true;
  }

  EnablePpiServiceInputModel getFormInputs(WidgetRef ref) {
    return EnablePpiServiceInputModel(
        serviceType: 'PPI',
        organizationId: widget.orgId,
        issuerName: 'LIVQUIK',
        partnerOrgId: widget.orgType == OrgType.axlerate ? ref.read(selectPartnerOrgIdProvider) : null,
        cashBackPercentage:
            widget.orgType == OrgType.logisticsAdmin ? null : double.parse(commissionController.text.toString()),
        kycDocuments: {
          "IDENTITY_PROOF": {
            'url': identityProofUrl.text.isNotEmpty
                ? identityProofUrl.text
                : ref
                    .read(ppiDocumentProvider.notifier)
                    // ignore: invalid_use_of_protected_member
                    .state
                    .where((element) => element.name == 'IDENTITY_PROOF')
                    .first
                    .url,
          },
          "ADDRESS_PROOF": {
            'url': addressProofUrl.text.isNotEmpty
                ? addressProofUrl.text
                : ref
                    .read(ppiDocumentProvider.notifier)
                    // ignore: invalid_use_of_protected_member
                    .state
                    .where((element) => element.name == 'ADDRESS_PROOF')
                    .first
                    .url,
          },
        });
  }
}
