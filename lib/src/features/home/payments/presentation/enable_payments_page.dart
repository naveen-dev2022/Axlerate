import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/kyc_type.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_alert_dialog_mode.dart';
import 'package:axlerate/src/dialogs/dialog_models/create_vehicle_alert_dialog.dart';
import 'package:axlerate/src/features/home/dashboard/controllers/selected_organisation_controller.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/form_widgets/form_section_heading_widget.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/payments/domain/request_invoice_input_model.dart';
import 'package:axlerate/src/features/home/payments/presentation/controller/payments_controller.dart';
import 'package:axlerate/src/features/home/payments/presentation/controller/payments_ui_controller.dart';
import 'package:axlerate/src/features/home/services/presentation/widgets/doc_name_field_widget.dart';
import 'package:axlerate/src/features/home/services/presentation/widgets/payments_kyc_details_form.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EnablePaymentsPage extends ConsumerStatefulWidget {
  const EnablePaymentsPage({
    super.key,
    required this.orgEnrollId,
    required this.isPaymentEnabled,
    required this.org,
    required this.orgType,
  });

  final String orgEnrollId;
  final bool isPaymentEnabled;
  final OrgDoc? org;
  final OrgType orgType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnablePaymentsPageState();
}

class _EnablePaymentsPageState extends ConsumerState<EnablePaymentsPage> {
  final GlobalKey<FormState> enablePaymentsFormKey = GlobalKey<FormState>();
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();

  final TextEditingController kycStatusController = TextEditingController();
  final TextEditingController midController = TextEditingController();
  final TextEditingController midPassController = TextEditingController();
  final TextEditingController rejReasoncontroller = TextEditingController();
  final TextEditingController mccController = TextEditingController();
  final TextEditingController productionApiKeyController = TextEditingController();
  final TextEditingController productionKeyController = TextEditingController();
  final TextEditingController testApiKeyController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();

  final TextEditingController doc1Name = TextEditingController();
  final TextEditingController doc2Name = TextEditingController();
  final TextEditingController doc3Name = TextEditingController();
  final TextEditingController doc4Name = TextEditingController();
  final TextEditingController doc5Name = TextEditingController();
  final TextEditingController doc1Url = TextEditingController();
  final TextEditingController doc2Url = TextEditingController();
  final TextEditingController doc3Url = TextEditingController();
  final TextEditingController doc4Url = TextEditingController();
  final TextEditingController doc5Url = TextEditingController();

  List<TextEditingController> urlControllers = [];
  List<TextEditingController> nameControllers = [];

  bool isMobile = false;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;

  String orgLogoUrl = '';
  // OrgDoc? org;
  bool isApproved = false;
  bool isRejected = false;
  bool isInitiated = false;
  String rejectedReason = '';
  bool isEditable = false;
  OrganizationService? orgService;

  @override
  void initState() {
    SelectedOrganizationModel selOrg = ref.read(selectedOrganizationStateProvider);
    orgLogoUrl = selOrg.logoUrl ?? '';
    invoiceDocsList = invoiceDocsListOrigin;

    urlControllers.addAll([doc1Url, doc2Url, doc3Url, doc4Url, doc5Url]);
    nameControllers.addAll([doc1Name, doc2Name, doc3Name, doc4Name, doc5Name]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(enableDocsNotifierProvider.notifier).addAnotherDoc();
      setState(() {});
    });

    orgService = getOrgService(widget.org, 'INVOICE');

    if (widget.isPaymentEnabled) {
      if (orgService != null) {
        // final paymentData = widget.org;
        if (widget.org != null) {
          if (orgService!.kycStatus == 'APPROVED') {
            isApproved = true;
            currentKycType = KycType.kycApproved;
            kycStatusController.text = orgService!.kycStatus;
            companyNameController.text = orgService!.companyName ?? '';
            midController.text = orgService!.mid ?? '';
            mccController.text = orgService!.mcc ?? '';
            productionKeyController.text = orgService!.productionKey ?? '';
            productionApiKeyController.text = orgService!.productionApiKey ?? '';
            testApiKeyController.text = orgService!.testApiKey ?? '';
            orgLogoUrl = orgService!.logo ?? '';
            RequestInvoiceInputDocuments? documents = orgService!.documents;
            if (documents != null) {
              docList.clear();
              if (documents.boardResolution != null) {
                addDocList(docName: 'Board Resolution', url: documents.boardResolution!.url);
              }
              if (documents.listOfDirectors != null) {
                addDocList(docName: 'List of Directors / Partners from MCA', url: documents.listOfDirectors!.url);
              }
              if (documents.undertaking != null) {
                addDocList(docName: 'Undertaking of Product/Services to be Sold', url: documents.undertaking!.url);
              }
              if (documents.merchantApplication != null) {
                addDocList(docName: 'Merchant Application Form (MAF)', url: documents.merchantApplication!.url);
              }
              if (documents.merchantOnboarding != null) {
                addDocList(docName: 'MERCHANT_ONBOARDING', url: documents.merchantOnboarding!.url);
              }
              if (documents.articlesOfAssociation != null) {
                addDocList(docName: 'Articles of Association (AOA)', url: documents.articlesOfAssociation!.url);
              }
              if (documents.memorandumOfAssociation != null) {
                addDocList(docName: 'Memorandum of Association (MOA)', url: documents.memorandumOfAssociation!.url);
              }
              if (documents.listOfDirectorsPartners != null) {
                addDocList(
                    docName: 'List of Directors / Partners from MCA', url: documents.listOfDirectorsPartners!.url);
              }
              if (documents.incorporationCertificate != null) {
                addDocList(docName: 'Certification of Incorporation', url: documents.incorporationCertificate!.url);
              }
              if (documents.partnershipDeed != null) {
                addDocList(docName: 'Partnership Deed', url: documents.partnershipDeed!.url);
              }
              if (documents.establishmentCertificate != null) {
                addDocList(docName: 'Establishment Certificate', url: documents.establishmentCertificate!.url);
              }
              if (documents.registrationCertificate != null) {
                addDocList(docName: 'Registration Certificate', url: documents.registrationCertificate!.url);
              }
              if (documents.companyPan != null) {
                addDocList(docName: 'PAN of the Company/Firm', url: documents.companyPan!.url);
              }
              if (documents.gstRegistrationCertificate != null) {
                addDocList(docName: 'GST Registration Certificate', url: documents.gstRegistrationCertificate!.url);
              }
              if (documents.productServicesUndertaking != null) {
                addDocList(
                    docName: 'Undertaking of Product/Services to be Sold',
                    url: documents.productServicesUndertaking!.url);
              }
              if (documents.companyAddressProof != null) {
                addDocList(
                    docName: 'Current Address Proof of the Company/Firm', url: documents.companyAddressProof!.url);
              }
              if (documents.kycDirectorsPartners != null) {
                addDocList(docName: 'KYC of Directors / Partners', url: documents.kycDirectorsPartners!.url);
              }
              if (documents.serviceAgreement != null) {
                addDocList(docName: 'Service Agreement', url: documents.serviceAgreement!.url);
              }
              if (documents.cancellationCheque != null) {
                addDocList(docName: 'Cancellation Cheque', url: documents.cancellationCheque!.url);
              }
              if (documents.legalOpinionDocument != null) {
                addDocList(docName: 'Legal Opinion document', url: documents.legalOpinionDocument!.url);
              }
              if (documents.bankStatement != null) {
                addDocList(docName: 'Bank Statement', url: documents.bankStatement!.url);
              }
              if (documents.commencentOfBusinessCertificate != null) {
                addDocList(
                    docName: 'Certificate of Commencement of Business',
                    url: documents.commencentOfBusinessCertificate!.url);
              }
              if (documents.others != null) {
                addDocList(docName: 'Others', url: documents.others!.url);
              }
            }
          }
          if (orgService!.kycStatus == 'REJECTED') {
            rejectedReason = orgService!.rejectionReason ?? '';
            isRejected = true;
            //   currentKycType = KycType.kycRejected;
            //   kycStatusController.text = orgService.kycStatus;
            //   rejReasoncontroller.text = orgService.rejectionReason ?? '';
          }

          if (orgService!.kycStatus == 'INITIATED') {
            isInitiated = true;
          }
        }
      }
    }

    super.initState();
  }

  addDocList({required String docName, required String url}) {
    docList.add(DocListItemModel(
      docName: TextEditingController(text: docName),
      docUrl: TextEditingController(text: url),
    ));
  }

  DocListItemModel getNewOne() {
    return DocListItemModel(
      docName: TextEditingController(),
      docUrl: TextEditingController(),
      docFieldTitle: 'Document Name',
      docTitle: 'Document',
    );
  }

  List<DocListItemModel> docList = [
    DocListItemModel(
      docName: TextEditingController(),
      docUrl: TextEditingController(),
    )
  ];

  KycType currentKycType = KycType.kycPending;

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    availableWidth = screenWidth - sideMenuWidth;
    // ref.watch(orgDetailsProvider);
    if (widget.org != null) {
      companyNameController.text = widget.org!.displayName;
    }

    return Padding(
      padding: isMobile
          ? const EdgeInsets.all(defaultMobilePadding)
          : const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding,
            ),
      child: Column(
        children: [
          if (!widget.isPaymentEnabled)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(horizontalPadding),
                child: Column(
                  children: [
                    Text(
                      'Request Admin to Enable Payment Service',
                      style: isMobile ? AxleTextStyle.bodyMedium : AxleTextStyle.headingPrimary,
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            buttonText: "Enable Payment",
                            buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                            buttonWidth: 200.0,
                            onPress: () async {
                              AxleLoader.show(context);
                              await ref.read(paymentsControllerProvider).requestInvoiceService(
                                    inputs: RequestInvoiceInputModel(
                                      organizationEnrollmentId: widget.orgEnrollId,
                                    ),
                                  );
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
          if (widget.isPaymentEnabled && widget.orgType == OrgType.axlerate)
            Form(
              key: enablePaymentsFormKey,
              child: Column(
                children: [
                  const SizedBox(height: defaultMobilePadding),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: CommonStyleUtil.axleListingCardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "KYC Details",
                          style: AxleTextStyle.headingPrimary,
                        ),
                        const SizedBox(height: defaultPadding),

                        Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: Wrap(
                            children: [
                              Row(
                                children: [
                                  AxleSearchDropDownField(
                                    fieldHeading: "Update KYC Status",
                                    fieldHint: "Enter KYC status",
                                    fieldController: kycStatusController,
                                    fieldWidth: isMobile ? screenWidth : 420,
                                    validate: Validators('Update KYC Status').required(),
                                    dropDownOptions: kycStatusList,
                                    isRequired: true,
                                    onChanged: (val) {
                                      switchKycStatus(val);
                                    },
                                  ),
                                  const SizedBox(width: verticalPadding),
                                  currentKycType == KycType.kycRejected
                                      ? AxleFormTextField(
                                          fieldHeading: "Rejected Reason",
                                          fieldHint: "Enter Reason for KYC Rejection",
                                          fieldController: rejReasoncontroller,
                                          validate: Validators('Rejected Reason').required(),
                                          textType: TextInputType.text,
                                          fieldWidth: isMobile ? screenWidth : 420,
                                          isRequiredField: true,
                                        )
                                      : Container(),
                                ],
                              ),
                              PaymentsKycDetailsForm(
                                kycStatusController: kycStatusController,
                                midController: midController,
                                midPassController: midPassController,
                                rejReasoncontroller: rejReasoncontroller,
                                mccController: mccController,
                                productionApiKeyController: productionApiKeyController,
                                productionKeyController: productionKeyController,
                                testApiKeyController: testApiKeyController,
                                currentKycType: currentKycType,
                                isFieldEnable: isEditable || !isApproved ? true : false,
                                companyNameController: companyNameController,
                              ),
                            ],
                          ),
                        ),
                        const FormSectionHeadingWidget(
                          title: 'Organization Logo',
                          subTitle: '',
                        ),
                        const Divider(
                          color: AxleColors.axleShadowColor,
                        ),
                        const SizedBox(height: defaultPadding),
                        // * Logo Upload Card
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () async {
                              Map<String, String>? imageData = await FileUploadUtil.pickImagefromGallery(
                                ref,
                                docType: 'organization/logo',
                                orgEnrollId: widget.orgEnrollId,
                                showSuccessSnackbar: true,
                              );
                              setState(() {
                                orgLogoUrl = imageData!['url'] ?? '';
                                // Snackbar.success(imageData.toString());
                              });
                            },
                            child: (orgLogoUrl.isNotEmpty)
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Image.network(
                                          orgLogoUrl,
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const SizedBox(
                                              height: 200,
                                              width: 200,
                                              child: Icon(
                                                Icons.business_outlined,
                                                color: Colors.grey,
                                                size: 100.0,
                                              ),
                                            );
                                          },
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black,
                                            ],
                                          )),
                                          width: 250,
                                          height: 50,
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset('assets/new_assets/icons/change_image_icon.svg'),
                                              const SizedBox(width: defaultPadding),
                                              Text(
                                                "Change Image",
                                                style: AxleTextStyle.subtitle2White,
                                              )
                                            ],
                                          )),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: DottedBorder(
                                      padding: const EdgeInsets.all(20.0),
                                      color: AxleColors.axleBlueColor,
                                      dashPattern: const [6],
                                      radius: const Radius.circular(16.0),
                                      strokeWidth: 2.0,
                                      borderType: BorderType.RRect,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset('assets/new_assets/icons/image_upload_icon.svg'),
                                            Text(
                                              'Upload Image',
                                              style: AxleTextStyle.imageUploadTextStyle,
                                            ),
                                            const SizedBox(height: 20.0),
                                            Text(
                                              'Maximum file size: 3MB',
                                              style: AxleTextStyle.primaryMiniHintStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        currentKycType == KycType.kycApproved
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const FormSectionHeadingWidget(
                                    title: HomeConstants.uploadKycDocs,
                                    subTitle: '',
                                  ),
                                  const Divider(
                                    color: AxleColors.axleShadowColor,
                                  ),
                                  const SizedBox(height: defaultMobilePadding),
                                  Wrap(
                                    runSpacing: 20.0,
                                    spacing: 60.0,
                                    children: docList.map((e) {
                                      return DocNameFieldWidget(
                                        docNameController: e.docName,
                                        urlController: e.docUrl,
                                        docNameLable: e.docFieldTitle,
                                        docNameHint: 'Upload File',
                                        nameLable: e.docTitle,
                                        nameHint: 'Select Document Name',
                                        docType: 'organization/doc',
                                        orgEnrollId: widget.orgEnrollId,
                                        showAddButton: false,
                                        isEditable: isEditable,
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 40),
                                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                    AxlePrimaryButton(
                                      buttonText: 'Add',
                                      onPress: docList.length < 5
                                          ? () {
                                              docList.add(getNewOne());
                                              setState(() {});
                                            }
                                          : null,
                                    ),
                                  ]),
                                ],
                              )
                            : Container(),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                          children: [
                            AxleOutlineButton(
                              buttonWidth: isMobile ? availableWidth * 40 / 100 : availableWidth * 20 / 100,
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
                              buttonWidth: isMobile ? availableWidth * 40 / 100 : availableWidth * 20 / 100,
                              buttonText: HomeConstants.submitBT,
                              buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                              onPress: () async {
                                AxleLoader.show(context);
                                if (enablePaymentsFormKey.currentState?.validate() ?? false) {
                                  log('Validated');
                                  await ref
                                      .read(paymentsControllerProvider)
                                      .enableInvoiceService(inputs: getInvoiceInput());
                                }
                                AxleLoader.hide();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  getUrlForSearchInList(String docName) {
    if (docList.any((e) => e.docName.toString().contains(docName))) {
      return docList[0].docUrl.text;
    }
    return null;
  }

  String getNatureOfBusiness(String input) {
    String res = '';
    if (input == 'SOLE_PROPRIETOR') {
      res = 'SOLE_PROPRIETOR';
    }
    if (input == 'PARTNERSHIP') {
      res = 'PARTNERSHIP';
    }
    if (input == 'PVT_LTD') {
      res = 'PVT_LTD';
    }
    if (input == 'PUBLIC_LTD' || input == 'SCHOOL_TRUST_ASSOCIATIONS' || input == 'GOVT_BODY') {
      res = 'SCHOOL_TRUST_ASSOCIATIONS_GOVT_BODY';
    }
    return res;
  }

  RequestInvoiceInputModel getInvoiceInput() {
    if (kycStatusController.text.toUpperCase() == "APPROVED") {
      return RequestInvoiceInputModel(
        organizationEnrollmentId: widget.orgEnrollId,
        logo: orgLogoUrl,
        status: kycStatusController.text.toValueCase,
        mcc: mccController.text.toValueCase,
        mid: midController.text.toValueCase,
        productionKey: productionKeyController.text,
        productionApiKey: productionApiKeyController.text,
        testApiKey: testApiKeyController.text,
        companyName: companyNameController.text,
        registrationType: getNatureOfBusiness(widget.org!.natureOfBusiness),
        documents: RequestInvoiceInputDocuments(
          articlesOfAssociation: getUrlForSearchInList('ARTICLES_OF_ASSOCIATION') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('ARTICLES_OF_ASSOCIATION')),
          boardResolution: getUrlForSearchInList('BOARD_RESOLUTION') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('BOARD_RESOLUTION')),
          undertaking: getUrlForSearchInList('UNDERTAKING') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('UNDERTAKING')),
          merchantApplication: getUrlForSearchInList('MERCHANT_APPLICATION') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('MERCHANT_APPLICATION')),
          merchantOnboarding: getUrlForSearchInList('MERCHANT_ONBOARDING') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('MERCHANT_ONBOARDING')),
          memorandumOfAssociation: getUrlForSearchInList('MEMORANDUM_OF_ASSOCIATION') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('MEMORANDUM_OF_ASSOCIATION')),
          listOfDirectorsPartners: getUrlForSearchInList('LIST_OF_DIRECTORS_PARTNERS') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('LIST_OF_DIRECTORS_PARTNERS')),
          incorporationCertificate: getUrlForSearchInList('INCORPORATION_CERTIFICATE') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('INCORPORATION_CERTIFICATE')),
          partnershipDeed: getUrlForSearchInList('PARTNERSHIP_DEED') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('PARTNERSHIP_DEED')),
          establishmentCertificate: getUrlForSearchInList('ESTABLISHMENT_CERTIFICATE') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('ESTABLISHMENT_CERTIFICATE')),
          registrationCertificate: getUrlForSearchInList('REGISTRATION_CERTIFICATE') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('REGISTRATION_CERTIFICATE')),
          companyPan: getUrlForSearchInList('COMPANY_PAN') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('COMPANY_PAN')),
          gstRegistrationCertificate: getUrlForSearchInList('GST_REGISTRATION_CERTIFICATE') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('GST_REGISTRATION_CERTIFICATE')),
          companyAddressProof: getUrlForSearchInList('COMPANY_ADDRESS_PROOF') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('COMPANY_ADDRESS_PROOF')),
          kycDirectorsPartners: getUrlForSearchInList('KYC_DIRECTORS_PARTNERS') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('KYC_DIRECTORS_PARTNERS')),
          serviceAgreement: getUrlForSearchInList('SERVICE_AGREEMENT') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('SERVICE_AGREEMENT')),
          cancellationCheque: getUrlForSearchInList('CANCELLATION_CHEQUE') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('CANCELLATION_CHEQUE')),
          legalOpinionDocument: getUrlForSearchInList('LEGAL_OPINION_DOCUMENT') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('LEGAL_OPINION_DOCUMENT')),
          bankStatement: getUrlForSearchInList('BANK_STATEMENT') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('BANK_STATEMENT')),
          commencentOfBusinessCertificate: getUrlForSearchInList('COMMENCENT_OF_BUSINESS_CERTIFICATE') == null
              ? null
              : UploadDocuments(url: getUrlForSearchInList('COMMENCENT_OF_BUSINESS_CERTIFICATE')),
          others:
              getUrlForSearchInList('OTHERS') == null ? null : UploadDocuments(url: getUrlForSearchInList('OTHERS')),
        ),
      );
    } else {
      return RequestInvoiceInputModel(
        organizationEnrollmentId: widget.orgEnrollId,
        // companyName: widget.org!.title,
        logo: orgLogoUrl,
        // registrationType: widget.org!.natureOfBusiness,
        status: kycStatusController.text.toValueCase,
        // mcc: midPassController.text.toValueCase,
        // mid: midController.text.toValueCase,
        rejectionReason: rejReasoncontroller.text,

        // documents: RequestInvoiceInputDocuments(boardResolution:UploadDocuments(url: url) )
      );
    }
  }

  switchKycStatus(String type) {
    KycType selectedType = KycType.kycPending;
    switch (type) {
      case 'Approved':
        selectedType = KycType.kycApproved;
        break;
      case 'Rejected':
        selectedType = KycType.kycRejected;
        break;
      default:
        selectedType = KycType.kycPending;
    }
    setState(() {
      currentKycType = selectedType;
    });
  }

  @override
  void dispose() {
    registerNameController.dispose();
    businessTypeController.dispose();
    doc1Name.dispose();
    doc2Name.dispose();
    doc3Name.dispose();
    doc4Name.dispose();
    doc5Name.dispose();
    doc1Url.dispose();
    doc2Url.dispose();
    doc3Url.dispose();
    doc4Url.dispose();
    doc5Url.dispose();
    super.dispose();
  }
}
