// ignore_for_file: must_be_immutable

import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_providers/list_org_by_type_provider.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/services/presentation/controller/add_ppi_service_controller.dart';
import 'package:axlerate/src/features/home/user/domain/list_orgs_by_type_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagPrimaryDetailsForm extends ConsumerWidget {
  TagPrimaryDetailsForm({
    super.key,
    required this.organizationController,
    required this.commissionController,
    required this.thresholdLimitController,
  });

  final TextEditingController organizationController;
  final TextEditingController commissionController;
  final TextEditingController thresholdLimitController;

  bool isPartnerAdmin = false;
  String partnerId = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);

    List<ListOrgByTypeDoc> orgList = [];

    String orgType = 'orgType';

    if (ref.watch(localStorageProvider).getOrgType() == OrgType.partner) {
      isPartnerAdmin = true;
      partnerId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      organizationController.text = partnerId;
    }

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Wrap(
        runSpacing: defaultPadding,
        spacing: defaultPadding,
        children: [
          isPartnerAdmin
              ? AxleFormTextField(
                  fieldHeading: 'Partner Organization Name',
                  fieldHint: '',
                  isFieldEnabled: false,
                  fieldController: organizationController,
                )
              : orgType.isNotEmpty
                  ? ref.watch(listOrgByTypeProvider('PARTNER')).when(
                        data: (list) {
                          orgList = list.data.message.docs;
                          return AxleSearchDropDownField(
                            fieldHeading: "Partner Organization Name",
                            fieldHint: "Partner Organization Name",
                            fieldController: organizationController,
                            fieldWidth: isMobile ? screenWidth : 420,
                            isEnabled: organizationController.text.isEmpty,
                            validate: Validators('Partner Organization Name').required(),
                            dropDownOptions: orgList
                                .map((item) =>
                                    "${item.enrollmentId}-${item.firstName} ${item.lastName}, ${item.zipCode}")
                                .toList(),
                            isRequired: true,
                            onChanged: (val) {
                              // debugPrint(val);
                              organizationController.text = val!;
                              final String selectedPartner = organizationController.text.trim().split('-').first;
                              ref.read(selectPartnerOrgIdProvider.notifier).state =
                                  orgList.where((element) => element.enrollmentId == selectedPartner).first.id;
                              // debugPrint(ref.read(selectPartnerOrgIdProvider));
                            },
                          );
                        },
                        error: (error, stackTrace) {
                          return Text(error.toString());
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                  : const SizedBox(),
          AxleFormTextField(
            fieldHeading: "Commission % for Customer",
            fieldHint: "Commission % for Customer",
            fieldController: commissionController,
            validate: Validators('"Commission % for Customer').required().min(1).max(3),
            lengthLimit: 3,
            isOnlyDigits: true,
            textType: TextInputType.number,
            fieldWidth: isMobile ? screenWidth : 420,
            isRequiredField: true,
            isFieldEnabled: !commissionController.text.contains('.'),
          ),
          AxleFormTextField(
            fieldHeading: "Threshold Limit",
            fieldHint: "Enter Threshold Limit",
            fieldController: thresholdLimitController,
            validate: Validators('"Threshold Limit for tag').required().min(1).max(3),
            lengthLimit: 3,
            isOnlyDigits: true,
            textType: TextInputType.number,
            fieldWidth: isMobile ? screenWidth : 420,
            isRequiredField: true,
            isFieldEnabled: !commissionController.text.contains('.'),
          ),
        ],
      ),
    );
  }
}
