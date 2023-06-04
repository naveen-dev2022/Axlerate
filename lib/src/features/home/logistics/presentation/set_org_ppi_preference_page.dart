import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/logistics/domain/org_account_info_model.dart' as orgacc;
import 'package:axlerate/src/features/home/logistics/domain/set_org_ppi_preference_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_ui_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/card_service_toggle_widget.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

@RoutePage()
class SetOrgPPIPreferencePage extends ConsumerStatefulWidget {
  const SetOrgPPIPreferencePage({
    super.key,
    @PathParam('custId') required this.orgEnrolld,
  });

  final String orgEnrolld;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetOrgPPIPreferencePageState();
}

class _SetOrgPPIPreferencePageState extends ConsumerState<SetOrgPPIPreferencePage> {
  final TextEditingController posController = TextEditingController();
  final TextEditingController atmController = TextEditingController();
  final TextEditingController ecomController = TextEditingController();
  final TextEditingController contactlessController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Future<orgacc.OrgAccountInfoModel> orgAccountDataFuture;

  orgacc.OrgAccountInfoModel? orgAccInfo;

  OrgDoc? org;
  String orgEntityId = '';

  bool isPosEnabled = false;
  bool isAtmEnabled = false;
  bool isEcomEnabled = false;
  bool isContactlessEnabled = false;

  String posLimit = '0';
  String atmLimit = '0';
  String ecomLimit = '0';
  // String contactlessLimit = '0';

  @override
  void initState() {
    Future(() {
      getOrgDataAndMakeApiCall();
    });
    super.initState();
  }

  Future<void> getOrgDataAndMakeApiCall() async {
    ref.read(isOrgPrefLoadingProvider.notifier).state = true;
    // orgEntityId = '';
    // final orgData = ref.read(orgDetailsProvider);
    // if (orgData == null) {
    //   await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(enrolId: widget.orgEnrolld);
    //   orgEntityId = getOrgService(ref.read(orgDetailsProvider), 'PPI')?.organizationEntityId ?? '';
    // }
    if (orgEntityId.isEmpty) {
      //await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(enrolId: widget.orgEnrolld);
      orgEntityId =
          getOrgService(ref.read(orgDetailsProvider), 'PPI', issuerName: 'LIVQUIK')?.organizationEntityId ?? '';
    }
    if (getOrgService(ref.read(orgDetailsProvider), 'PPI', issuerName: 'LIVQUIK')?.kycStatus == 'APPROVED') {
      if (orgEntityId.isNotEmpty) {
        orgAccInfo = await ref.read(logisticsControllerProvider).getOrgAccountInfo(orgEntityId: orgEntityId);
      }
    }

    log('The value is pos: ${orgAccInfo?.data?.message?.cardPreference?.pos}');
    log('The value is atm: ${orgAccInfo?.data?.message?.cardPreference?.atm}');
    log('The value is ecom: ${orgAccInfo?.data?.message?.cardPreference?.ecom}');

    isPosEnabled = orgAccInfo?.data?.message?.cardPreference?.pos ?? false;
    isAtmEnabled = orgAccInfo?.data?.message?.cardPreference?.atm ?? false;
    isEcomEnabled = orgAccInfo?.data?.message?.cardPreference?.ecom ?? false;

    posLimit = orgAccInfo?.data?.message?.cardPreference?.limitConfig?.pos ?? '0';
    atmLimit = orgAccInfo?.data?.message?.cardPreference?.limitConfig?.atm ?? '0';
    ecomLimit = orgAccInfo?.data?.message?.cardPreference?.limitConfig?.ecom ?? '0';
    ref.read(isOrgPrefLoadingProvider.notifier).state = false;
    setState(() {});
  }

  // Future<orgAcc.OrgAccountInfoModel> getOrgAccInfoData(String entityId) async {
  //   return ref.read(logisticsControllerProvider).getOrgAccountInfo(orgEntityId: entityId);
  // }

  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    org = ref.watch(orgDetailsProvider);
    isMobile = Responsive.isMobile(context);
    final isLoading = ref.watch(isOrgPrefLoadingProvider);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: isMobile
              ? const EdgeInsets.all(defaultPadding)
              : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          child: org == null
              ? AxleLoader.axleProgressIndicator()
              : isLoading
                  ? AxleLoader.axleProgressIndicator()
                  : buildBodyWidget(getOrgService(org, 'PPI')),
        ),
      ),
    );
  }

  Widget buildBodyWidget(OrganizationService? ppiService) {
    // String id = ppiService?.organizationEntityId ?? '';

    bool isFullKyc = (ppiService?.kycType ?? '') == 'FULL_KYC';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(HomeConstants.orgCardPreference, style: AxleTextStyle.titleMedium),
        const SizedBox(height: defaultPadding),
        Text(HomeConstants.transactionSettings, style: AxleTextStyle.titleSmall),
        const SizedBox(height: defaultPadding),
        Form(
          key: formKey,
          child: Wrap(
            spacing: defaultPadding,
            runSpacing: defaultPadding,
            children: [
              CardServiceToggleWidget(
                enableSecondaryCard: false,
                title: 'Merchant Outlet',
                // defaultCardTitle: 'Set Limit',
                buttonValue: isPosEnabled,
                defaultCurrentLimit: posLimit,
                defaultLimitController: posController,
                defaultMaxLimitAmount: isFullKyc ? fullKycLimitPpi : minKycLimitPpi,
                onChange: (val) async {
                  setState(() => isPosEnabled = !isPosEnabled);
                },
              ),
              const SizedBox(height: defaultPadding),
              CardServiceToggleWidget(
                enableSecondaryCard: false,
                title: 'ATM Withdrawal',
                // defaultCardTitle: 'Set Limit',
                buttonValue: isAtmEnabled,
                defaultCurrentLimit: atmLimit,
                defaultLimitController: atmController,
                defaultMaxLimitAmount: isFullKyc ? fullKycLimitPpi : minKycLimitPpi,
                onChange: (val) async {
                  setState(() => isAtmEnabled = !isAtmEnabled);
                },
              ),
              const SizedBox(height: defaultPadding),
              CardServiceToggleWidget(
                enableSecondaryCard: false,
                title: 'Online',
                // defaultCardTitle: 'Set Limit',
                buttonValue: isEcomEnabled,
                defaultCurrentLimit: ecomLimit,
                defaultLimitController: ecomController,
                defaultMaxLimitAmount: isFullKyc ? fullKycLimitPpi : minKycLimitPpi,

                // buttonValue: res?.data.message.ecom ?? false,
                onChange: (val) async {
                  setState(() => isEcomEnabled = !isEcomEnabled);
                },
              ),
              const SizedBox(height: 30.0),
              // * Apply Button
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AxlePrimaryButton(
                        buttonText: "Apply",
                        onPress: () async {
                          log(formKey.currentState!.validate().toString());
                          // return;
                          if (!formKey.currentState!.validate()) return;
                          AxleLoader.show(context);
                          bool res =
                              await ref.read(logisticsControllerProvider).updateOrgPPiPreference(inputs: getInputs());
                          AxleLoader.hide();
                          if (res) {
                            await getOrgDataAndMakeApiCall();
                          }
                          // if (res && mounted) {
                          //   final orgEnrollId = ref
                          //           .read(sharedPreferenceProvider)
                          //           .getString(Storage.currentlyPickedOrgEnrollId)
                          //           ?.toLowerCase() ??
                          //       '';
                          //   context.go('/app/$orgEnrollId/customers');
                          // }
                          // await fetchUserCardPreference();
                        }),
                    const SizedBox(width: 30),
                    AxleOutlineButton(
                      buttonText: "Cancel",
                      onPress: () {
                        context.router.pushNamed(RouteUtils.getCustomerDashboardPath(custEnrollId: widget.orgEnrolld));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  SetOrgPpiPreferenceModel getInputs() {
    return SetOrgPpiPreferenceModel(
      organizationEntityId: orgEntityId,
      cardSettings: CardSettings(
        atm: isAtmEnabled,
        pos: isPosEnabled,
        ecom: isEcomEnabled,
        contactless: isContactlessEnabled,
      ),
      limitConfig: LimitConfig(
        atm: atmController.text,
        pos: posController.text,
        ecom: ecomController.text,
      ),
    );
  }
}
