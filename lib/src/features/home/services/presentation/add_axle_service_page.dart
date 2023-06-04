import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/app_util/typedefs/typedefs.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/payments/domain/request_invoice_input_model.dart';
import 'package:axlerate/src/features/home/payments/presentation/controller/payments_controller.dart';
import 'package:axlerate/src/features/home/payments/presentation/enable_payments_page.dart';
import 'package:axlerate/src/features/home/services/presentation/widgets/add_fastag_service.dart';
import 'package:axlerate/src/features/home/services/presentation/widgets/add_fuel_service.dart';
import 'package:axlerate/src/features/home/services/presentation/widgets/add_ppi_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AddAxleServicePage extends ConsumerStatefulWidget {
  const AddAxleServicePage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddAxleServicePagePageState();
}

class _AddAxleServicePagePageState extends ConsumerState<AddAxleServicePage> {
  final TextEditingController commissionController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController thresholdLimitController = TextEditingController();
  final TextEditingController idProofController = TextEditingController();
  final TextEditingController addressProffController = TextEditingController();
  late OrgDoc doc;
  OrgDoc? org;

  OrgType orgType = OrgType.dummy;

  late OrganizationID orgId;
  late OrgEnrollID orgEnrollId;
  // late String orgEntityId;
  late String orgName;
  late bool isPpiEnabled = false;
  late bool isTagEnabled = false;
  late bool isYesTagEnabled = false;
  late bool isLqTagEnabled = false;
  late bool isFuelEnabled = false;
  late bool isGpsEnabled = false;
  late bool isPaymentEnabled = false;

  List<String> title = [
    "FASTag",
    "Prepaid Cards",
    "Fuel Card",
    // "GPS",
    "Payment Links",
  ];
  List<String> description = [
    "Pay for tolls with quick recharge & track expense",
    "Unify all fleet-related payments in a single card",
    // "Get GPS to track fleet operations in real-time.",
    "Prevent theft & gain rewards for fuel purchases",
    "Create payment links instantly",
  ];

  // OrgType currentOrgType = OrgType.dummy;

  String rejectedReason = '';
  @override
  void initState() {
    Future(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(logisticsControllerProvider)
            .getOrganisationByEnrolmentId(enrolId: orgEnrollId, isSetOrgDetailProvider: true);
      });
      orgType = ref.read(localStorageProvider).getOrgType();
    });

    super.initState();
  }

  // List<String> title = ["FASTag", "Prepaid Cards", "Fuel Card", "Payment Links"];
  // List<String> description = [
  //   "Pay for tolls with quick recharge & track expense",
  //   "Unify all fleet-related payments in a single card",
  //   "Prevent theft & gain rewards for fuel purchases",
  //   "Create payment links instantly",
  // ];

  // if (currentOrgType == OrgType.axlerate) {
  //   title.add('Payments');
  //   description.add('Create payment links instantly');
  // }

  // @override
  // void didChangeDependencies() {
  //   org = ref.watch(orgDetailsProvider);
  //   log("Did Change Dependencies called");
  //   debugPrint("ORG ::" + org.toString());
  //   super.didChangeDependencies();
  // }

  // @override
  // void didUpdateWidget(ow) {
  //   // org = ref.watch(orgDetailsProvider);

  //   super.didUpdateWidget(ow);
  // }

  late Widget formWidget;
  int selectedIndex = 0;

  OrganizationService? orgService;
  bool isInitiated = false;
  bool isRejected = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    org = ref.watch(orgDetailsProvider);
    if (org != null) {
      // log("Did Change Dependencies called and Org is not null");

      orgId = org!.id;
      orgEnrollId = org!.enrollmentId;
      orgName = "${org!.firstName} ${org!.lastName}";
      isPpiEnabled = getOrgService(org, 'PPI', issuerName: 'LIVQUIK') != null ? true : false;
      isTagEnabled = getOrgService(org, 'TAG') != null ? true : false;
      isYesTagEnabled = getOrgService(org, 'TAG', issuerName: 'YESBANK') != null ? true : false;
      isLqTagEnabled = getOrgService(org, 'TAG', issuerName: 'LIVQUIK') != null ? true : false;
      isFuelEnabled = getOrgService(org, 'FUEL') != null ? true : false;
      isGpsEnabled = getOrgService(org, 'GPS') != null ? true : false;
      isPaymentEnabled = getOrgService(org, 'INVOICE') != null ? true : false;
      orgService = getOrgService(org, 'INVOICE');
      log("isPaymentEnabled---$isPaymentEnabled");
      if (isPaymentEnabled) {
        if (orgService != null) {
          final paymentData = org;
          if (paymentData != null) {
            if (orgService!.kycStatus == 'REJECTED') {
              rejectedReason = orgService!.rejectionReason ?? '';
            }
          }

          if (orgService!.kycStatus == 'INITIATED') {
            isInitiated = true;
          }
          if (orgService!.kycStatus == 'REJECTED') {
            isRejected = true;
          }
        }
      }
    }

    return org == null
        ? AxleLoader.axleProgressIndicator()
        : SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: isMobile
                    ? const EdgeInsets.all(defaultPadding)
                    : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                child: Column(
                  children: [
                    if (!isMobile)
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: DashboardHeader(
                          title: "Axlerate Services",
                          orgName: orgName,
                          buttonText: "Detailed View",
                          onButtonPressed: () {
                            context.router
                                .pushNamed(RouteUtils.getCustomerDetailsPath(custEnrollId: org!.enrollmentId));
                          },
                        ),
                      ),
                    if (isMobile)
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: (() {
                                context.router.pop();
                              }),
                              child: Row(children: [
                                const Icon(size: 12, color: primaryColor, Icons.arrow_back_ios_new_rounded),
                                Text('Back', style: AxleTextStyle.labelLarge)
                              ]),
                            ),
                            const SizedBox(width: defaultPadding),
                            AxleTextWithBg(text: orgName, textColor: primaryColor)
                          ],
                        ),
                        ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(primaryColor)),
                            child: const Text('Details'),
                            onPressed: () {
                              context.router
                                  .pushNamed(RouteUtils.getCustomerDetailsPath(custEnrollId: org!.enrollmentId));
                            })
                      ]),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Container(
                      decoration: CommonStyleUtil.axleContainerDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: SizedBox(
                              height: 140,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: title.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(defaultPadding),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: org!.organizationServices.isNotEmpty
                                          ? serviceCard(org!, title[index], description[index], index)
                                          : axleServiceCard(title[index], description[index], index),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Container(width: double.infinity, height: 2, color: iconColor),
                          ),
                          getSelectedWidget(selectedIndex, isMobile)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget getSelectedWidget(int index, bool isMobile) {
    Widget toRet = AddFastagServiceToOrganization(
      orgId: orgId,
      orgEnrollId: orgEnrollId,
      isTagEnabled: isTagEnabled,
      isYesTagEnabled: isYesTagEnabled,
      isLqTagEnabled: isLqTagEnabled,
      orgDoc: org,
    );

    switch (index) {
      case 0:
        toRet = AddFastagServiceToOrganization(
          orgId: orgId,
          orgEnrollId: orgEnrollId,
          isTagEnabled: isTagEnabled,
          isYesTagEnabled: isYesTagEnabled,
          isLqTagEnabled: isLqTagEnabled,
          orgDoc: org,
        );
        break;

      case 1:
        toRet = AddPpiServiceToOrganization(
          key: UniqueKey(),
          isPpiEnabled: isPpiEnabled,
          org: org!,
          orgId: orgId,
          orgEnrollId: orgEnrollId,
          orgType: orgType,
        );
        break;

      case 2:
        toRet = AddFuelServiceToOrganization(
          orgEnrollId: org!.enrollmentId,
          orgId: org!.id,
          org: org!,
          orgType: orgType,
          isFuelEnabled: (getOrgService(org, 'FUEL')?.kycStatus == 'DECLINED' ||
                  getOrgService(org, 'FUEL')?.kycStatus == 'PENDING')
              ? false
              : isFuelEnabled,
        );

        break;

      case 3:
        toRet = (org!.natureOfBusiness != 'INDIVIDUAL')
            ? (orgType == OrgType.axlerate && orgService != null) ||
                    (orgType == OrgType.logisticsAdmin && (orgService != null && orgService!.kycStatus == "APPROVED"))
                ? EnablePaymentsPage(
                    key: UniqueKey(),
                    orgEnrollId: org!.enrollmentId,
                    isPaymentEnabled: isPaymentEnabled,
                    org: org!,
                    orgType: orgType,
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(horizontalPadding),
                      child: Column(
                        children: [
                          isInitiated
                              ? Text(
                                  'Axlerate has Initiated Payment Links Service',
                                  style: isMobile ? AxleTextStyle.bodyMedium : AxleTextStyle.headingPrimary,
                                )
                              : isRejected
                                  ? Text(
                                      'Contact Axlerate for more Information',
                                      style: isMobile ? AxleTextStyle.bodyMedium : AxleTextStyle.headingPrimary,
                                    )
                                  : Text(
                                      'Request Admin to Enable Payment Service',
                                      style: isMobile ? AxleTextStyle.bodyMedium : AxleTextStyle.headingPrimary,
                                    ),
                          const SizedBox(height: 50),
                          if (isPaymentEnabled && rejectedReason.isNotEmpty)
                            Text(
                              'Rejection Reason : $rejectedReason',
                              style: AxleTextStyle.bodyLarge.copyWith(color: Colors.red),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!isPaymentEnabled)
                                  AxleOutlineButton(
                                    buttonText: InputFormConstants.cancelbuttonText,
                                    buttonStyle: AxleTextStyle.outLineButtonStyle,
                                    buttonWidth: isMobile ? 100.0 : 200.0,
                                    onPress: () {
                                      context.router.pop();
                                    },
                                  ),
                                if (!isPaymentEnabled) const SizedBox(width: 20.0),
                                AxlePrimaryButton(
                                  buttonText: isPaymentEnabled
                                      ? "Service ${getOrgService(org, 'INVOICE')!.kycStatus.toUiCase}"
                                      : "Enable Payment",
                                  buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                  buttonWidth: 200.0,
                                  onPress: isPaymentEnabled
                                      ? null
                                      : () async {
                                          AxleLoader.show(context);
                                          await ref.read(paymentsControllerProvider).requestInvoiceService(
                                                inputs: RequestInvoiceInputModel(
                                                  organizationEnrollmentId: orgEnrollId,
                                                ),
                                              );
                                          if (mounted) {
                                            await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(
                                                enrolId: orgEnrollId, isSetOrgDetailProvider: true);
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
                  )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(horizontalPadding),
                  child: Column(
                    children: [
                      Text(
                        'Payment Links Service is not Available for Individuals',
                        style: isMobile ? AxleTextStyle.bodyMedium : AxleTextStyle.headingPrimary,
                      ),
                    ],
                  ),
                ),
              );
        break;

      default:
        toRet = Padding(
          padding: const EdgeInsets.all(horizontalPadding),
          child: Center(
              child: Text(
            "Coming Soon",
            style: AxleTextStyle.headingPrimary,
          )),
        );
    }

    return toRet;
  }

  Container serviceCard(OrgDoc? org, title, String description, int index) {
    bool isFastTagEnabled;
    bool isGpsEnabled;
    // bool isFuelCardEnabled;
    //bool isPaymentLinkEnabled;
    Container res = Container();
    log(title);
    switch (title) {
      case "FASTag":
        isFastTagEnabled = getOrgService(org, 'TAG') != null;
        if (isFastTagEnabled == true) {
          res = axleServiceCardEnabled(title, description, index, status: getOrgService(org, 'TAG')?.kycStatus);
        } else {
          res = axleServiceCard(title, description, index);
        }

        break;
      case "Prepaid Cards":
        isPpiEnabled = getOrgService(org, 'PPI') != null;
        if (isPpiEnabled == true) {
          res = axleServiceCardEnabled(title, description, index, status: getOrgService(org, 'PPI')?.kycStatus);
        } else {
          res = axleServiceCard(title, description, index);
        }
        break;

      case "GPS":
        isGpsEnabled = getOrgService(org, 'GPS') != null;
        if (isGpsEnabled == true) {
          res = axleServiceCardEnabled(title, description, index, status: "APPROVED");
        } else {
          res = axleServiceCard(title, description, index);
        }
        break;
      case "Fuel Card":
        // isFuelCardEnabled = getOrgService(org, 'FUEL') != null;
        if (isFuelEnabled == true) {
          res = axleServiceCardEnabled(title, description, index, status: getOrgService(org, 'FUEL')?.kycStatus);
        } else {
          res = axleServiceCard(title, description, index);
        }
        break;
      case "Payment Links":
        // isPaymentLinkEnabled = getOrgService(org, 'TAG') != null;
        if (isPaymentEnabled == true) {
          res = axleServiceCardEnabled(title, description, index, status: getOrgService(org, 'INVOICE')?.kycStatus);
        } else {
          res = axleServiceCard(title, description, index);
        }

        break;
      default:
        res = axleServiceCard(title, description, index);
    }
    return res;
  }

  Container axleServiceCard(String title, String description, int itemCount) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: selectedIndex == itemCount ? primaryColor : AxleColors.axleCardColor, width: 2.0),
      ),
      height: 100,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            selectedIndex == itemCount ? const Icon(Icons.radio_button_checked) : const Icon(Icons.radio_button_off),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Flexible(
                    child: Text(description, style: const TextStyle(fontSize: 12)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container axleServiceCardEnabled(String title, String description, int index, {String? status}) {
    Color statusColor = AxleColors.getStatusColor(status ?? "");
    return Container(
      decoration: BoxDecoration(
        color: selectedIndex == index ? statusColor.withAlpha(35) : null,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: statusColor, width: 2),
        //  Border.all(color: AxleColors.axleGreenColor, width: 2.0),
      ),
      height: 100,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.only(left: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            selectedIndex == index
                ? Icon(Icons.radio_button_checked, color: statusColor)
                : const Icon(Icons.radio_button_off),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AxleTextStyle.bodyMedium.copyWith(color: Colors.black, fontWeight: FontWeight.w600)),
                  Flexible(child: Text(description, style: AxleTextStyle.bodySmall.copyWith(color: Colors.black87)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                ),
                height: 135,
                width: 30,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                        status != null
                            ? status == "APPROVED"
                                ? 'Enabled'
                                : status.toUiCase
                            : '',
                        style: AxleTextStyle.labelSmall.copyWith(color: Colors.white),
                        textAlign: TextAlign.center),
                  ),
                  // child: RotatedBox(quarterTurns: 1, child: Text('A')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
