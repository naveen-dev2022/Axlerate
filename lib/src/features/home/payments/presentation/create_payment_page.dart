import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_providers/list_org_by_type_provider.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_alert_dialog_mode.dart';
import 'package:axlerate/src/dialogs/dialog_models/create_vehicle_alert_dialog.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/form_widgets/form_section_heading_widget.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/payments/domain/create_payment_link_input_model.dart';
import 'package:axlerate/src/features/home/payments/domain/list_invoice_saved_customer_query.dart';
import 'package:axlerate/src/features/home/payments/presentation/controller/payments_controller.dart';
import 'package:axlerate/src/features/home/user/domain/list_orgs_by_type_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/debounce_search.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CreatePaymentPage extends ConsumerStatefulWidget {
  const CreatePaymentPage({@PathParam('orgEnrollId') required this.orgEnrollId, super.key});
  final String orgEnrollId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatePaymentPageState();
}

class _CreatePaymentPageState extends ConsumerState<CreatePaymentPage> {
  final GlobalKey<FormState> createPaymentKey = GlobalKey<FormState>();

  final TextEditingController orgController = TextEditingController();
  final TextEditingController orgIdController = TextEditingController();

  TextEditingController clientName = TextEditingController();
  TextEditingController clientEmailId = TextEditingController();
  TextEditingController clientMobile = TextEditingController();
  final TextEditingController amountPayable = TextEditingController();
  final TextEditingController paymentFor = TextEditingController();
  final TextEditingController referenceId = TextEditingController();
  final TextEditingController paymentExpiry = TextEditingController();
  final TextEditingController refrenceId = TextEditingController();

  bool isMobile = false;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;

  OrgType currentOrgType = OrgType.dummy;
  bool checkBoxValue = false;

  bool isShowCustomerList = false;

  ListInvoiceCustomerQuery params = ListInvoiceCustomerQuery(
    searchText: "",
  );
  late Debouncer debouncer;
  String lastInputValue = '';

  @override
  void initState() {
    debouncer = Debouncer(milliseconds: 500);
    currentOrgType = ref.read(localStorageProvider).getOrgType();
    if (currentOrgType == OrgType.logisticsAdmin) {
      orgIdController.text = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
    }
    super.initState();
  }

  Future<void> getSavedCustomersList(ListInvoiceCustomerQuery params) async {
    ref.read(listSavedCustomerStateProvider.notifier).state = null;
    ref.read(listSavedCustomerStateProvider.notifier).state =
        await ref.read(paymentsControllerProvider).listInvoiceCustomer(query: params, orgEnrollId: widget.orgEnrollId);
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    availableWidth = screenWidth - sideMenuWidth;
    // Watching Providers
    final savedCustomerList = ref.watch(listSavedCustomerStateProvider);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: GestureDetector(
        onTap: () {
          setState(() {
            isShowCustomerList = false;
          });
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: isMobile
                ? const EdgeInsets.all(defaultMobilePadding)
                : const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
            child: Form(
              key: createPaymentKey,
              child: Column(
                children: [
                  const SizedBox(height: defaultMobilePadding),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.router.pushNamed(RouteUtils.getPaymentsPath(widget.orgEnrollId)),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AxleColors.axlePrimaryColor,
                        ),
                      ),
                      Text(
                        HomeConstants.createPayment,
                        style: AxleTextStyle.headingPrimary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: CommonStyleUtil.axleListingCardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: currentOrgType == OrgType.axlerate,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FormSectionHeadingWidget(
                                title: HomeConstants.fillOrgDetails,
                                subTitle: '',
                              ),
                              const Divider(
                                color: AxleColors.axleShadowColor,
                              ),
                              const SizedBox(
                                height: defaultMobilePadding,
                              ),
                              currentOrgType == OrgType.axlerate
                                  ? ref.watch(listOrgByTypeProvider('LOGISTICS')).when(
                                        data: (response) {
                                          List<ListOrgByTypeDoc> allList = response.data.message.docs;
                                          return searchFiledWidget(allList);
                                        },
                                        error: (error, stackTrace) => searchFiledWidget([]),
                                        loading: () => const CircularProgressIndicator(),
                                      )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        const FormSectionHeadingWidget(
                          title: HomeConstants.fillDetails,
                          subTitle: InputFormConstants.mandatoryHint,
                        ),
                        const Divider(
                          color: AxleColors.axleShadowColor,
                        ),
                        const SizedBox(
                          height: defaultMobilePadding,
                        ),
                        Stack(
                          children: [
                            Wrap(
                              runSpacing: 20.0,
                              spacing: 60.0,
                              children: [
                                AxleFormTextField(
                                  fieldHeading: InputFormConstants.clientNameFieldLabel,
                                  fieldHint: InputFormConstants.clientNameFieldHint,
                                  fieldWidth: isMobile ? screenWidth : 320,
                                  fieldController: clientName,
                                  lengthLimit: 30,
                                  validate: Validators(InputFormConstants.clientNameFieldLabel).required(),
                                  isRequiredField: true,
                                  onChange: (value) {
                                    if (lastInputValue != value && value.trim().length >= 3) {
                                      lastInputValue = value.trim();
                                      isShowCustomerList = true;
                                      params = ListInvoiceCustomerQuery(searchText: lastInputValue);
                                      debouncer.run(() {
                                        log("now search");
                                        getSavedCustomersList(params);
                                      });
                                    }
                                  },
                                ),
                                AxleFormTextField(
                                  fieldHeading: InputFormConstants.clientEmailFieldLabel,
                                  fieldHint: InputFormConstants.clientEmailFieldHint,
                                  fieldWidth: isMobile ? screenWidth : 320,
                                  fieldController: clientEmailId,
                                  lengthLimit: 30,
                                  validate: Validators(InputFormConstants.clientEmailFieldLabel).required(),
                                  isRequiredField: true,
                                ),
                                AxleFormTextField(
                                  fieldHeading: InputFormConstants.clientMobileFieldLabel,
                                  fieldHint: InputFormConstants.clientMobileFieldHint,
                                  fieldWidth: isMobile ? screenWidth : 320,
                                  fieldController: clientMobile,
                                  lengthLimit: 10,
                                  validate: Validators(InputFormConstants.clientMobileFieldLabel).required(),
                                  isRequiredField: true,
                                ),
                                AxleFormTextField(
                                  fieldHeading: InputFormConstants.amountFieldLabel,
                                  fieldHint: InputFormConstants.amountFieldHint,
                                  fieldWidth: isMobile ? screenWidth : 320,
                                  fieldController: amountPayable,
                                  textType: TextInputType.number,
                                  //lengthLimit: 30,
                                  isShowPrefixAmount: true,
                                  isOnlyDigits: true,
                                  validate: Validators(InputFormConstants.amountFieldLabel).required(),
                                  isRequiredField: true,
                                ),
                                AxleFormTextField(
                                  fieldHeading: InputFormConstants.paymentDescLabel,
                                  fieldHint: InputFormConstants.paymentDescHint,
                                  fieldWidth: isMobile ? screenWidth : 320,
                                  fieldController: paymentFor,
                                  lengthLimit: 100,
                                  validate: Validators(InputFormConstants.paymentDescHint).required(),
                                  isRequiredField: true,
                                ),
                                AxleFormTextField(
                                  fieldHeading: InputFormConstants.referenceIdLabel,
                                  fieldHint: InputFormConstants.referenceIdHint,
                                  fieldWidth: isMobile ? screenWidth : 320,
                                  fieldController: referenceId,
                                  lengthLimit: 15,
                                ),
                                // GestureDetector(
                                //   onTap: () async {
                                //     DateTime? date =
                                //         await DatePickerUtil.pickDate(context);
                                //     if (date != null) {
                                //       paymentExpiry.text =
                                //           DatePickerUtil.dateMonthYearFormatter(date);
                                //     }
                                //   },
                                //   child: AxleFormTextField(
                                //     fieldHeading:
                                //         InputFormConstants.paymentLinkExpiryLabel,
                                //     fieldHint:
                                //         InputFormConstants.paymentLinkExpiryHint,
                                //     fieldWidth: isMobile ? screenWidth : 320,
                                //     fieldController: paymentExpiry,
                                //     isFieldEnabled: false,
                                //     lengthLimit: 30,
                                //   ),
                                // ),
                              ],
                            ),
                            if (isShowCustomerList &&
                                (savedCustomerList != null &&
                                    savedCustomerList.data != null &&
                                    savedCustomerList.data!.message != null &&
                                    savedCustomerList.data!.message!.docs.isNotEmpty))
                              Positioned(
                                left: 0,
                                top: 80,
                                child: SizedBox(
                                  height: isMobile ? screenHeight * 40 / 100 : screenHeight * 20 / 100,
                                  width: isMobile ? screenWidth : 320,
                                  child: Card(
                                    elevation: 5,
                                    child: ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: savedCustomerList.data!.message!.docs.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            clientName = TextEditingController(
                                                text: savedCustomerList.data!.message!.docs[index].name);
                                            clientEmailId = TextEditingController(
                                                text: savedCustomerList.data!.message!.docs[index].email);
                                            clientMobile = TextEditingController(
                                                text: savedCustomerList.data!.message!.docs[index].phone);
                                            isShowCustomerList = false;
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              savedCustomerList.data!.message!.docs[index].name,
                                              style: AxleTextStyle.subtitle2GreyStyle,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            Checkbox(
                              value: checkBoxValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkBoxValue = value!;
                                });
                              },
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              "Save for Future Reference",
                              overflow: TextOverflow.ellipsis,
                              style: AxleTextStyle.axleFormFieldHintStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                          children: [
                            AxleOutlineButton(
                              buttonWidth: isMobile ? screenWidth * 40 / 100 : availableWidth * 20 / 100,
                              buttonText: HomeConstants.cancelBT,
                              buttonStyle: AxleTextStyle.saveAndContinuePrimaryStyle,
                              onPress: () async {
                                bool result = await const AxleExitAlertDialog().present(context) ?? false;
                                if (result && mounted) {
                                  context.router.pop();
                                }
                              },
                            ),
                            const SizedBox(width: 12.0),
                            AxlePrimaryButton(
                              buttonWidth: isMobile ? screenWidth * 40 / 100 : availableWidth * 20 / 100,
                              buttonText: 'CREATE',
                              buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                              onPress: () async {
                                if (createPaymentKey.currentState?.validate() ?? false) {
                                  log('Validated');
                                  await ref
                                      .read(paymentsControllerProvider)
                                      .createPaymnetLink(inputs: getCreatePaymentInput())
                                      .then((bool isSuccess) {
                                    if (isSuccess) {
                                      context.router.pop();
                                    }
                                  });
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CreatePaymentLinkInputModel getCreatePaymentInput() {
    return CreatePaymentLinkInputModel(
      organizationEnrollmentId: widget.orgEnrollId,
      orderInfo: paymentFor.text,
      amount: int.parse(amountPayable.text),
      referenceId: referenceId.text,
      customer: Customer(
        name: clientName.text,
        emailId: clientEmailId.text,
        phone: clientMobile.text,
        isSaveCustomer: checkBoxValue,
      ),
    );
  }

  Widget searchFiledWidget(List<ListOrgByTypeDoc> allList) {
    return AxleSearchDropDownField(
      fieldHeading: InputFormConstants.customerOrgFieldName,
      fieldHint: InputFormConstants.customerNameFieldHint,
      fieldWidth: isMobile ? screenWidth : 320,
      fieldController: orgController,
      dropDownOptions:
          allList.map((item) => '${item.enrollmentId} - ${item.firstName} ${item.lastName} - ${item.city}').toList(),
      validate: Validators(InputFormConstants.customerOrgFieldName).required(),
      isRequired: true,
      onChanged: (val) {
        orgController.text = val!;
        log('Entered Function ');
        final picked = orgController.text.split('-').first.trim();
        log('Entered SelectedID - $picked');
        for (final item in allList) {
          log('${item.enrollmentId}  - 1');
          if (item.enrollmentId == picked) {
            log('${item.enrollmentId}  - 2');

            orgIdController.text = item.id;
            log('Controller -> ${orgIdController.text}');
            break;
          }
        }
        log('Entered SelectedID 2');
      },
    );
  }

  @override
  void dispose() {
    clientName.dispose();
    clientEmailId.dispose();
    clientMobile.dispose();
    amountPayable.dispose();
    paymentFor.dispose();
    referenceId.dispose();
    paymentExpiry.dispose();
    super.dispose();
  }
}
