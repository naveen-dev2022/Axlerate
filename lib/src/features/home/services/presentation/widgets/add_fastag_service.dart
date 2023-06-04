import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/typedefs/typedefs.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/services/domain/add_tag_service_input_modal.dart';
import 'package:axlerate/src/features/home/services/presentation/controller/add_ppi_service_controller.dart';
import 'package:axlerate/src/features/home/services/presentation/controller/service_controller.dart';
import 'package:axlerate/src/features/home/services/presentation/widgets/ppi_primary_details_form.dart';
import 'package:axlerate/src/features/home/services/presentation/widgets/tag_primary_details_form.dart';
import 'package:axlerate/src/features/home/services/presentation/widgets/tag_upload_docs_form.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/lqtag_admin_org_response_model.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddFastagServiceToOrganization extends ConsumerStatefulWidget {
  const AddFastagServiceToOrganization({
    super.key,
    required this.orgId,
    required this.orgEnrollId,
    // required this.orgEntityId,
    required this.isTagEnabled,
    required this.isYesTagEnabled,
    required this.isLqTagEnabled,
    required this.orgDoc,
  });

  final OrganizationID orgId;
  final OrgEnrollID orgEnrollId;
  // final String orgEntityId;
  final bool isTagEnabled;
  final bool isYesTagEnabled;
  final bool isLqTagEnabled;
  final OrgDoc? orgDoc;

  @override
  ConsumerState<AddFastagServiceToOrganization> createState() => _AddFastagServiceToOrganizationState();
}

class _AddFastagServiceToOrganizationState extends ConsumerState<AddFastagServiceToOrganization> {
  final GlobalKey<FormState> enableFastagFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> enableLqFormKey = GlobalKey<FormState>();

  OrgType orgType = OrgType.dummy;

  final TextEditingController commissionController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController thresholdLimitController = TextEditingController();
  final TextEditingController idProofController = TextEditingController();
  final TextEditingController idUrlController = TextEditingController();
  final TextEditingController addressProffController = TextEditingController();
  final TextEditingController addressUrlController = TextEditingController();

  final TextEditingController commissionControllerLq = TextEditingController();
  final TextEditingController organizationControllerLq = TextEditingController();
  final TextEditingController idProofControllerLq = TextEditingController();
  final TextEditingController idUrlControllerLq = TextEditingController();
  final TextEditingController addressProffControllerLq = TextEditingController();
  final TextEditingController addressUrlControllerLq = TextEditingController();

  Future<LqTagAdminOrgResponseModel>? lqTagAdminsListFuture;
  OrganizationService? orgLqService;
  OrganizationService? orgYesBankService;

  @override
  void initState() {
    orgType = ref.read(localStorageProvider).getOrgType();
    if (widget.isTagEnabled) {
      final OrganizationService? yestagData = getOrgService(widget.orgDoc, 'TAG', issuerName: 'YESBANK');
      commissionController.text = yestagData?.cashBackPercentage.toString() ?? '';
      organizationController.text = yestagData?.partnerEnrollmentId ?? '';
      thresholdLimitController.text = '';
      idProofController.text = yestagData?.kycDocuments?.identityProof?.url.isNotEmpty ?? false ? "UPLOADED" : '';
      addressProffController.text = yestagData?.kycDocuments?.addressProof?.url.isNotEmpty ?? false ? "UPLOADED" : '';

      final OrganizationService? lqtagData = getOrgService(widget.orgDoc, 'TAG', issuerName: 'LIVQUIK');
      commissionControllerLq.text = lqtagData?.cashBackPercentage.toString() ?? '';
      organizationControllerLq.text = lqtagData?.partnerEnrollmentId ?? '';
      idProofControllerLq.text = lqtagData?.kycDocuments?.identityProof?.url.isNotEmpty ?? false ? "UPLOADED" : '';
      addressProffControllerLq.text = lqtagData?.kycDocuments?.addressProof?.url.isNotEmpty ?? false ? "UPLOADED" : '';
    }
    orgLqService = getOrgService(widget.orgDoc, 'TAG', issuerName: 'LIVQUIK');
    orgYesBankService = getOrgService(widget.orgDoc, 'TAG', issuerName: 'YESBANK');

    if (orgLqService != null && orgLqService?.kycStatus == 'APPROVED') {
      if (orgType != OrgType.partner) {
        lqTagAdminsListFuture = getLqAdminList();
        getLqTagCorporateWallet();
      }
    }

    super.initState();
  }

  getLqTagCorporateWallet() async {
    List corporateWallets =
        await ref.read(serviceControlProvider).getLqTagCorporateWallet(orgEnrolId: widget.orgEnrollId);
    if (corporateWallets.isEmpty) {
      setState(() {
        showCreateCorporateWallet = true;
      });
    }
  }

  Future<LqTagAdminOrgResponseModel> getLqAdminList() async {
    return await ref.read(vehicleControllerProvider).getLQTagAdminOrgUser(orgEnrolId: widget.orgEnrollId);
  }

  bool isPartnerAdmin = false;
  String partnerOrgEnrollmentId = '';

  String partnerOrgId = '';
  bool isMobile = false;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;

  bool showCreateCorporateWallet = false;
  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2 + defaultPadding * 8);

    if (ref.read(localStorageProvider).getOrgType() == OrgType.partner) {
      isPartnerAdmin = true;
      partnerOrgEnrollmentId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      partnerOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      organizationController.text = partnerOrgEnrollmentId;
    }

    return Container(
      padding: const EdgeInsets.only(bottom: defaultPadding, left: defaultPadding, right: defaultPadding),
      // color: Colors.blue,
      width: screenWidth,
      height: screenHeight * 69 / 100,
      child: ContainedTabBarView(
        tabBarProperties: const TabBarProperties(
          indicator: ContainerTabIndicator(
              radius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)), color: appBlue),
        ),
        tabs: [
          Text(
            'LivQuik FASTag',
            style: AxleTextStyle.labelLarge,
          ),
          Text(
            'YES Bank FASTag',
            style: AxleTextStyle.labelLarge,
          ),
        ],
        views: [
          orgLqService != null && orgLqService?.kycStatus == 'APPROVED' ? getFastagAdmins() : getLivQuikFastagForm(),
          //getYesbankFastagForm(),
          orgYesBankService != null && orgYesBankService?.kycStatus == 'APPROVED'
              ? getYesbankFastagForm()
              : Container(
                  color: appBlue,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: emptyResponse(),
                  ),
                ),

          // (widget.orgEnrollId.toLowerCase() == 'axl20') ? getLivQuikFastagForm() : getFastagAdmins()
        ],
        onChange: (index) => print(index),
      ),
    );
  }

  Widget emptyResponse() {
    return const AxleErrorWidget(
      imgHeight: 250.0,
      titleStr: HomeConstants.underMaintenanceStr,
      subtitle: '',
    );
  }

  Widget getFastagAdmins() {
    return Container(
      color: appBlue,
      child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: FutureBuilder<LqTagAdminOrgResponseModel>(
              future: lqTagAdminsListFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return AxleLoader.axleProgressIndicator();
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasData) {
                      final adminsList = snapshot.data?.data;
                      if (adminsList == null) {
                        return const AxleErrorWidget();
                      }
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "LivQuik FASTag Admins",
                                      style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold),
                                    ),

                                    //Check for SuperAdmin
                                    if (ref.read(localStorageProvider).getOrgType() == OrgType.axlerate)
                                      Tooltip(
                                          message: showCreateCorporateWallet
                                              ? "Create Corporate Wallet"
                                              : "Corporate Wallet is Already Enabled",
                                          child: AxlePrimaryButton(
                                            icon: const Icon(Icons.add),
                                            buttonText: "Corporate Wallet",
                                            onPress: showCreateCorporateWallet
                                                ? () async {
                                                    try {
                                                      AxleLoader.show(context);
                                                      await ref
                                                          .read(serviceControlProvider)
                                                          .createLqTagCorporateWallet(widget.orgDoc!.enrollmentId);
                                                      setState(() {
                                                        showCreateCorporateWallet = false;
                                                      });
                                                    } catch (e) {
                                                      throw Exception("Error Creating Corporate Wallet : $e");
                                                    }
                                                    AxleLoader.hide();
                                                  }
                                                : null,
                                            // buttonWidth: 300,
                                          ))
                                  ],
                                ),
                                const SizedBox(height: defaultPadding),
                                adminsList.message.isEmpty
                                    ? Column(
                                        children: [
                                          const SizedBox(height: defaultPadding),
                                          const AxleErrorWidget(titleStr: 'Please add LQTAG Admins', imgHeight: 250.0),
                                          const SizedBox(height: defaultMobilePadding),
                                          Text(
                                            "Note: To create 'FASTag Admin', Go to Staff -> Select Verified Admin -> Add FASTag Service ",
                                            style: AxleTextStyle.labelMedium.copyWith(color: Colors.black),
                                          ),
                                          const SizedBox(height: defaultPadding),
                                          AxlePrimaryButton(
                                            buttonText: "Add LQTAG Admin",
                                            onPress: () {
                                              // debugPrint(" org id ${widget.orgDoc?.enrollmentId}");
                                              context.router.pushNamed(RouteUtils.getStaffsPath());
                                            },
                                          ),
                                          const SizedBox(height: defaultPadding)
                                        ],
                                      )
                                    : Wrap(
                                        runSpacing: defaultPadding,
                                        spacing: defaultPadding,
                                        children: [
                                          // adminCard('IPS', "+91 9876543210", 'KYC APPROVED'),
                                          for (var i in adminsList.message)
                                            adminCard(
                                                '${i.firstName} ${i.lastName}', '+91 ${i.contactNumber}', i.kycStatus),
                                        ],
                                      ),
                                const SizedBox(height: defaultPadding)
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const AxleErrorWidget();
                    }
                }
              })),
    );
  }

  Widget adminCard(String title, String description, String kycStatus) {
    return Container(
      width: isMobile ? null : availableWidth * 35 / 100,
      constraints: const BoxConstraints(minWidth: 250),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryColor, width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/new_assets/icons/tag_icon_with_bg.svg", height: 50, width: 50),
              const SizedBox(width: defaultPadding),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: AxleTextStyle.titleMedium),
                Text(description, style: AxleTextStyle.titleSmall),
              ])
            ],
          ),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("KYC Status", style: AxleTextStyle.bodySmall.copyWith(color: Colors.black)),
              const SizedBox(width: defaultPadding),
              AxleTextWithBg(
                text: kycStatus,
                textColor: AxleColors.getStatusColor(kycStatus),
              )
            ],
          )
        ]),
      ),
    );
  }

  Widget getLivQuikFastagForm() {
    return Container(
      color: appBlue,
      child: SingleChildScrollView(
        child: AbsorbPointer(
          absorbing: widget.isLqTagEnabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: enableLqFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: (orgType != OrgType.logisticsAdmin && orgType != OrgType.logisticsStaff),
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Text(
                          "Primary Details",
                          style: AxleTextStyle.headingPrimary,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (orgType != OrgType.logisticsAdmin && orgType != OrgType.logisticsStaff),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: PpiPrimaryDetailsForm(
                          commissionController: commissionControllerLq,
                          organizationController: organizationControllerLq,
                          isLq: true,
                          isEditable: true,
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
                      child: TagUploadDocsForm(
                        idProofController: idProofControllerLq,
                        addressProofController: addressProffControllerLq,
                        orgEnrollId: widget.orgEnrollId,
                        idUrlController: idUrlControllerLq,
                        addressUrlController: addressUrlControllerLq,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                  children: [
                    widget.isLqTagEnabled
                        ? Container()
                        : AxleOutlineButton(
                            buttonText: InputFormConstants.cancelbuttonText,
                            buttonStyle: AxleTextStyle.outLineButtonStyle,
                            buttonWidth: isMobile ? 100.0 : 200.0,
                            onPress: () {
                              context.router.pop();
                            },
                          ),
                    const SizedBox(width: 20.0),
                    AxlePrimaryButton(
                      buttonText: widget.isLqTagEnabled ? "Service Enabled" : "ENABLE LIVQUIK",
                      buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                      buttonWidth: 200.0,
                      onPress: widget.isLqTagEnabled
                          ? null
                          : () {
                              enableLivQuikTag();
                              // enablePpi(context, ref);
                            },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    // return Container(
    //     color: appBlue,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Expanded(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(
    //                   "To get access of LivQuik FASTags, enable it here and make one of you verified admin as 'FASTag Admin' ",
    //                   style: AxleTextStyle.labelLarge),
    //               const SizedBox(height: defaultPadding),
    //               AxlePrimaryButton(
    //                   buttonText: "Enable LivQuik FASTag", buttonWidth: isMobile ? 100.0 : 300.0, onPress: (() {})),
    //             ],
    //           ),
    //         ),
    //         Text(
    //           "Note: To create 'FASTag Admin', Go to Staff -> Select Verified Admin -> Add FASTag Service ",
    //           style: AxleTextStyle.labelMedium.copyWith(color: Colors.black),
    //         ),
    //         const SizedBox(height: defaultPadding)
    //       ],
    //     ));
  }

  void enableLivQuikTag() async {
    if (enableLqFormKey.currentState!.validate()) {
      AxleLoader.show(context);
      bool res = await ref.read(serviceControlProvider).addTagServiceToOrganization(getLqFormData());
      if (res && mounted) {
        // context.push(RouteUtils.getCustomerDetailsPath(custEnrollId: widget.orgEnrollId));
        await ref
            .read(logisticsControllerProvider)
            .getOrganisationByEnrolmentId(enrolId: widget.orgEnrollId.toUpperCase(), isSetOrgDetailProvider: true);
      }
      AxleLoader.hide();
    }
  }

  AddTagServiceInputModel getLqFormData() {
    bool isLogistics = orgType == OrgType.logisticsAdmin;

    return AddTagServiceInputModel(
      organizationId: widget.orgId,
      partnerOrgId: orgType == OrgType.axlerate
          ? ref.read(selectPartnerOrgIdProvider)
          : null, //isLogistics ? Strings.axleratePartnerOrgId : ref.read(selectPartnerForLqProvider),
      serviceType: 'TAG',
      issuerName: 'LIVQUIK',
      kycDocuments: {
        "IDENTITY_PROOF": {
          "url": idUrlControllerLq.text,
        },
        "ADDRESS_PROOF": {
          "url": addressUrlControllerLq.text,
        }
      },
      cashBackPercentage: isLogistics ? null : int.parse(commissionControllerLq.text),
    );
  }

  Widget getYesbankFastagForm() {
    return Container(
      color: appBlue,
      child: SingleChildScrollView(
        child: AbsorbPointer(
          absorbing: widget.isYesTagEnabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: enableFastagFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: (orgType != OrgType.logisticsAdmin && orgType != OrgType.logisticsStaff),
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Text("Primary Details",
                            style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Visibility(
                      visible: (orgType != OrgType.logisticsAdmin && orgType != OrgType.logisticsStaff),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: TagPrimaryDetailsForm(
                          commissionController: commissionController,
                          organizationController: organizationController,
                          thresholdLimitController: thresholdLimitController,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Text("Upload Documents",
                          style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: TagUploadDocsForm(
                        idProofController: idProofController,
                        addressProofController: addressProffController,
                        orgEnrollId: widget.orgEnrollId,
                        idUrlController: idUrlController,
                        addressUrlController: addressUrlController,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                  children: [
                    widget.isYesTagEnabled
                        ? Container()
                        : AxleOutlineButton(
                            buttonText: InputFormConstants.cancelbuttonText,
                            buttonStyle: AxleTextStyle.outLineButtonStyle,
                            buttonWidth: isMobile ? 100.0 : 200.0,
                            onPress: () {
                              context.router.pop();
                            },
                          ),
                    const SizedBox(width: 20.0),
                    AxlePrimaryButton(
                      buttonText: widget.isYesTagEnabled ? "Service Enabled" : "ENABLE FASTAG",
                      buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                      buttonWidth: 200.0,
                      onPress: widget.isYesTagEnabled
                          ? null
                          : () async {
                              if (isPartnerAdmin) {
                                ref.read(selectPartnerOrgIdProvider.notifier).state = partnerOrgId;
                              }

                              // log(getTagInputs(ref).toJson().toString());
                              // debugPrint(getTagInputs(ref).toJson().toString());
                              AxleLoader.show(context);
                              bool res =
                                  await ref.read(serviceControlProvider).addTagServiceToOrganization(getTagInputs(ref));
                              if (res && mounted) {
                                // context.push(RouteUtils.getCustomerDetailsPath(custEnrollId: widget.orgEnrollId));
                                await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(
                                    enrolId: widget.orgEnrollId.toUpperCase(), isSetOrgDetailProvider: true);
                              }
                              AxleLoader.hide();
                            },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AddTagServiceInputModel getTagInputs(WidgetRef ref) {
    bool isLogistics = orgType == OrgType.logisticsAdmin;
    return AddTagServiceInputModel(
      organizationId: widget.orgId,
      partnerOrgId: orgType == OrgType.axlerate ? ref.read(selectPartnerOrgIdProvider) : null,
      serviceType: 'TAG',
      issuerName: 'YESBANK',
      kycDocuments: {
        "IDENTITY_PROOF": {
          "url": idUrlController.text,
        },
        "ADDRESS_PROOF": {
          "url": addressUrlController.text,
        }
      },
      cashBackPercentage: isLogistics ? null : int.parse(commissionController.text),
      thresholdLimit: isLogistics ? 100 : int.parse(thresholdLimitController.text),
    );
  }

  @override
  void dispose() {
    commissionController.dispose();
    organizationController.dispose();
    thresholdLimitController.dispose();
    idProofController.dispose();
    idUrlController.dispose();
    addressProffController.dispose();
    addressUrlController.dispose();

    commissionControllerLq.dispose();
    organizationControllerLq.dispose();
    idProofControllerLq.dispose();
    idUrlControllerLq.dispose();
    addressProffControllerLq.dispose();
    addressUrlControllerLq.dispose();
    super.dispose();
  }
}
