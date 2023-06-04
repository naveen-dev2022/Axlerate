// ignore_for_file: must_be_immutable

import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_controllers/list_org_by_type_controller.dart';
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

class PpiPrimaryDetailsForm extends ConsumerStatefulWidget {
  PpiPrimaryDetailsForm({
    super.key,
    required this.organizationController,
    required this.commissionController,
    this.isLq = false,
    this.isEditable = false,
  });

  TextEditingController organizationController;
  final TextEditingController commissionController;
  final bool isLq;
  final bool isEditable;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PpiPrimaryDetailsFormState();
}

class _PpiPrimaryDetailsFormState extends ConsumerState<PpiPrimaryDetailsForm> {
  late Future<ListOrgsByTypeModel?> orgByTypeFuture;
  bool isPartnerAdmin = false;
  String partnerId = '';

  @override
  void initState() {
    orgByTypeFuture = getOrgListByType();
    super.initState();
  }

  Future<ListOrgsByTypeModel?> getOrgListByType() async {
    return await ref.read(listOrgByTypeControllerProvider).getListOfOrganizationByType(
          orgType: 'PARTNER',
        );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);

    List<ListOrgByTypeDoc> orgList = [];

    String orgType = 'orgType';
    if (ref.read(localStorageProvider).getOrgType() == OrgType.partner) {
      isPartnerAdmin = true;
      partnerId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      widget.organizationController.text = partnerId;
    }

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Wrap(
        runSpacing: 20.0,
        spacing: 60.0,
        children: [
          // isPartnerAdmin
          //     ?
          //     AxleFormTextField(
          //         fieldHeading: 'Partner Organization Name',
          //         fieldHint: '',
          //         isFieldEnabled: false,
          //         fieldController: widget.organizationController,
          //       )
          //     :
          if (orgType.isNotEmpty && !isPartnerAdmin)
            ref.watch(listOrgByTypeProvider('PARTNER')).when(
                  data: (list) {
                    orgList = list.data.message.docs;
                    return AbsorbPointer(
                      absorbing: !widget.isEditable,
                      child: AxleSearchDropDownField(
                        fieldHeading: "Partner Organization Name",
                        fieldHint: "Partner Organization Name",
                        fieldController: widget.organizationController,
                        fieldWidth: isMobile ? screenWidth : 420,
                        isEnabled: widget.organizationController.text.isEmpty,
                        validate: Validators('Partner Organization Name').required(),
                        dropDownOptions: orgList
                            .map((item) => "${item.enrollmentId}-${item.firstName} ${item.lastName}, ${item.zipCode}")
                            .toList(),
                        isRequired: true,
                        onChanged: (val) {
                          widget.organizationController.text = val!;
                          final String selectedPartner = widget.organizationController.text.split('-').first;
                          ref.read(selectPartnerOrgIdProvider.notifier).state =
                              orgList.where((element) => element.enrollmentId == selectedPartner).first.id;
                          // if (widget.isLq) {
                          //   ref.read(selectPartnerForLqProvider.notifier).state =
                          //       orgList.where((element) => element.enrollmentId == selectedPartner).first.id;
                          // } else {
                          //   ref.read(selectPartnerOrgIdProvider.notifier).state =
                          //       orgList.where((element) => element.enrollmentId == selectedPartner).first.id;
                          // }
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) {
                    return Text(error.toString());
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),

          // FutureBuilder(
          //   future: orgByTypeFuture,
          //   builder: (context, snapshot) {
          //     switch (snapshot.connectionState) {
          //       case ConnectionState.waiting:
          //         return AxleLoader.axleProgressIndicator();
          //       case ConnectionState.done:
          //       default:
          //         if (snapshot.hasError) {
          //           return TextButton(onPressed: () {}, child: Text('Try Again'));
          //         } else if (snapshot.hasData) {
          //           return Text('Data');
          //         } else {
          //           return AxleLoader.axleProgressIndicator();
          //         }
          //     }
          //   },
          // ),
          AxleFormTextField(
            fieldHeading: "Commission % for Customer",
            fieldHint: "Commission % for Customer",
            fieldController: widget.commissionController,
            validate: Validators('Commission % for Customer').required().min(1).max(3),
            lengthLimit: 3,
            isOnlyDigits: true,
            textType: TextInputType.number,
            fieldWidth: isMobile ? screenWidth : 420,
            isRequiredField: true,
            isFieldEnabled: widget.isEditable,
          ),
        ],
      ),
    );
  }
}
