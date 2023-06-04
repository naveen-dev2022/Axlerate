import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_error_widget.dart';
import 'package:axlerate/src/common/common_widgets/axle_file_picker.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/services/domain/tag_document_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/lqtag_admin_org_response_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/vehicle_fastag_service_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/services/vehicle_lqtag_service_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_details_model_updated.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/get_vehicle_service.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/services/tag_documnets_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_controller.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

const frontViewStr = 'Front View Image';
const sideViewStr = 'Side View Image';
const rcTextStr = 'RC Book';
const uploaded = 'UPLOADED';

class EnableTagServiceForm extends ConsumerStatefulWidget {
  const EnableTagServiceForm({
    super.key,
    // required this.orgId,
    // required this.orgEnrollId,
    required this.org,
    required this.vehicleRegNumber,
    required this.vehicleEnrollId,
    required this.vehicleDoc,
    required this.isTagEnabled,
    required this.isYesTagEnabled,
    required this.isLqTagEnabled,
    required this.orgType,
  });

  // final String orgId;
  // final String orgEnrollId;
  final OrgDoc? org;
  final String vehicleRegNumber;
  final String vehicleEnrollId;
  final Vehicle vehicleDoc;
  final bool isTagEnabled;
  final bool isYesTagEnabled;
  final bool isLqTagEnabled;
  final OrgType orgType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnableTagServiceFormState();
}

class _EnableTagServiceFormState extends ConsumerState<EnableTagServiceForm> {
  final GlobalKey<FormState> enableYesTagForVehicleKey = GlobalKey<FormState>();
  final GlobalKey<FormState> enableLqTagForVehicleKey = GlobalKey<FormState>();

  final TextEditingController balanceType = TextEditingController();
  final TextEditingController thresholdLimit = TextEditingController();
  final TextEditingController serialNumber = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController mapperController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();

  final TextEditingController frontViewcontroller = TextEditingController();
  final TextEditingController sideViewController = TextEditingController();
  final TextEditingController rcBookController = TextEditingController();

  final TextEditingController frontUrl = TextEditingController();
  final TextEditingController sideUrl = TextEditingController();
  final TextEditingController rcUrl = TextEditingController();

  final TextEditingController balanceTypeLq = TextEditingController();
  final TextEditingController serialNumberLq = TextEditingController();
  // final TextEditingController regNoControllerLq = TextEditingController();
  final TextEditingController regDateControllerLq = TextEditingController();
  DateTime? regDate;
  final TextEditingController fitnessDateControllerLq = TextEditingController();
  DateTime? fitnessDate;

  final TextEditingController ownerImagecontrollerLq = TextEditingController();
  final TextEditingController rcBookControllerLq = TextEditingController();
  final TextEditingController tagAdminControllerLq = TextEditingController();
  final TextEditingController tagAdminUserEnrollmentIdLq = TextEditingController();

  final TextEditingController ownerImageUrlLq = TextEditingController();
  final TextEditingController rcUrlLq = TextEditingController();
  late Future<LqTagAdminOrgResponseModel> lqTagAdminsListFuture;
  OrganizationService? orgLqService;

  OrgType currentType = OrgType.dummy;
  bool isRejVisible = false;

  // bool isAlreadyAdded = false;
  Service? lqServiceData;
  Service? yesServiceData;

  List<Widget> tagList = [];
  List<Widget> tabList = [];

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;
  bool isEditable = false;

  OrgType orgType = OrgType.dummy;

  String rejectionReason = '';

  @override
  void dispose() {
    balanceType.dispose();
    thresholdLimit.dispose();
    serialNumber.dispose();
    super.dispose();
  }

  @override
  void initState() {
    lqServiceData = getVehicleService(widget.vehicleDoc, 'TAG', issuerName: 'LIVQUIK');
    yesServiceData = getVehicleService(widget.vehicleDoc, 'TAG', issuerName: 'YESBANK');

    currentType = ref.read(localStorageProvider).getOrgType();
    if (widget.isTagEnabled) {
      serialNumber.text = yesServiceData?.serialNumber ?? '';
      mobileNoController.text = yesServiceData?.contactNumber ?? '';
      thresholdLimit.text = '';
      tagController.text = yesServiceData?.vehicleClass?.tagClass ?? '';
      balanceType.text = yesServiceData?.balanceType.toUiCase ?? '';
      mapperController.text = yesServiceData?.vehicleClass?.mapperClass ?? '';

      rcBookController.text = yesServiceData?.kycDocuments?.rcBookImage?.docUploadStatus ?? '';
      rcUrl.text = yesServiceData?.kycDocuments?.rcBookImage?.url ?? '';
      frontViewcontroller.text = widget.vehicleDoc.vehicleImage?.frontView != null ? frontViewStr : '';
      frontUrl.text = widget.vehicleDoc.vehicleImage?.frontView?.url ?? '';
      sideViewController.text = widget.vehicleDoc.vehicleImage?.sideView != null ? sideViewStr : '';
      sideUrl.text = sideUrl.text = widget.vehicleDoc.vehicleImage?.sideView?.url ?? '';

      // regDateControllerLq.text =
      //     DatePickerUtil.userViewDateFormatter(widget.vehicleDoc.registrationDate ?? DateTime.now()) ?? '';
      // regDate = widget.vehicleDoc.registrationDate;
      // fitnessDateControllerLq.text =
      //     DatePickerUtil.userViewDateFormatter(widget.vehicleDoc.fitnessUpto ?? DateTime.now()) ?? '';
      // fitnessDate = widget.vehicleDoc.fitnessUpto;

      if (lqServiceData != null) {
        balanceTypeLq.text = lqServiceData?.balanceType.toUiCase ?? '';
        serialNumberLq.text = lqServiceData?.serialNumber ?? '';
        rcBookControllerLq.text = lqServiceData?.kycDocuments?.rcBookImage?.url != null ? uploaded : '';
        tagAdminControllerLq.text = lqServiceData?.userEnrollmentId ?? '';
        ownerImageUrlLq.text = lqServiceData?.kycDocuments?.ownerImage?.url ?? '';
        ownerImagecontrollerLq.text = lqServiceData?.kycDocuments?.ownerImage?.url != null ? uploaded : '';
        rcUrlLq.text = lqServiceData?.kycDocuments?.rcBookImage?.url ?? '';
        rejectionReason = lqServiceData?.rejectionReason ?? '';
        try {
          if (lqServiceData!.registrationDate != null) {
            regDate = lqServiceData!.registrationDate!;
            regDateControllerLq.text = DatePickerUtil.userViewDateFormatter(regDate!) ?? '';
          }
        } catch (e) {
          log(e.toString());
        }
        try {
          if (lqServiceData?.kycDocuments?.rcBookImage!.documentExpiry != null) {
            fitnessDate = lqServiceData?.kycDocuments?.rcBookImage!.documentExpiry;
            fitnessDateControllerLq.text = DatePickerUtil.userViewDateFormatter(fitnessDate!) ?? '';
          }
        } catch (e) {
          log(e.toString());
        }
      }
    }
    orgLqService = getOrgService(widget.org, 'TAG', issuerName: 'LIVQUIK');
    orgType = ref.read(localStorageProvider).getOrgType();

    if (orgLqService != null && orgLqService?.kycStatus == 'APPROVED') {
      if (orgType != OrgType.partner) {
        lqTagAdminsListFuture = getLqAdminList();
      }
    }

    // showTagList();
    // showTabList();

    super.initState();
  }

  Future<LqTagAdminOrgResponseModel> getLqAdminList() async {
    return await ref.read(vehicleControllerProvider).getLQTagAdminOrgUser(orgEnrolId: widget.org!.enrollmentId);
  }

  showTagList() {
    if (yesServiceData != null) {
      return tagList.add(getYesTagFormVehicle());
    } else if (lqServiceData != null) {
      return tagList.add(getLqTagFormVehicle(widget.org));
    } else {
      return tagList.addAll([getYesTagFormVehicle(), getLqTagFormVehicle(widget.org)]);
    }
  }

  showTabList() {
    if (yesServiceData != null) {
      return tabList.add(
        Text(
          'YES Bank FASTag',
          style: AxleTextStyle.labelLarge,
        ),
      );
    } else if (lqServiceData != null) {
      return tabList.add(
        Text(
          'LivQuik FASTag',
          style: AxleTextStyle.labelLarge,
        ),
      );
    } else {
      return tabList.addAll([
        Text(
          'YES Bank FASTag',
          style: AxleTextStyle.labelLarge,
        ),
        Text(
          'LivQuik FASTag',
          style: AxleTextStyle.labelLarge,
        ),
      ]);
    }
  }

  DateTime? pickedRegDate;
  DateTime? pickedFitnessDate;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }
    return Container(
      padding: const EdgeInsets.only(bottom: defaultPadding, left: defaultPadding, right: defaultPadding),
      // color: Colors.blue,
      width: screenWidth,
      height: screenHeight * 69 / 100,
      child: ContainedTabBarView(
        tabBarProperties: const TabBarProperties(
          indicator: ContainerTabIndicator(
            radius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: appBlue,
          ),
        ),
        tabs: (lqServiceData != null)
            ? [
                Text(
                  'LivQuik FASTag',
                  style: AxleTextStyle.labelLarge,
                )
              ]
            : (yesServiceData != null)
                ? [
                    Text(
                      'YES Bank FASTag',
                      style: AxleTextStyle.labelLarge,
                    )
                  ]
                : [
                    Text(
                      'LivQuik FASTag',
                      style: AxleTextStyle.labelLarge,
                    ),
                    Text(
                      'YES Bank FASTag',
                      style: AxleTextStyle.labelLarge,
                    ),
                  ],
        views: (lqServiceData != null)
            ? [getLqTagFormVehicle(widget.org)]
            : (yesServiceData != null)
                ? [getYesTagFormVehicle()]
                : [getLqTagFormVehicle(widget.org), getYesTagFormVehicle()],
        onChange: (index) => print(index),
      ),
    );
  }

  Widget getYesTagFormVehicle() {
    return Container(
      color: appBlue,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Form(
                key: enableYesTagForVehicleKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Primary Details",
                          style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold),
                        ),
                        (widget.orgType == OrgType.axlerate && widget.isTagEnabled)
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
                    const SizedBox(height: defaultPadding),
                    Wrap(
                      runSpacing: 20.0,
                      spacing: 60.0,
                      children: [
                        widget.isTagEnabled
                            ? AxleFormTextField(
                                fieldHeading: 'Balance type',
                                fieldHint: 'Select Balance type',
                                fieldWidth: isMobile ? screenWidth : 300,
                                fieldController: balanceType,
                                isRequiredField: true,
                                isFieldEnabled: false,
                              )
                            : AxleSearchDropDownField(
                                fieldHeading: 'Balance type',
                                fieldHint: 'Select Balance type',
                                fieldController: balanceType,
                                fieldWidth: isMobile ? screenWidth : 300,
                                dropDownOptions: vehicleBalanceTypeList,
                                validate: Validators('Balance Type').required(),
                                isRequired: true,
                                onChanged: (val) {
                                  balanceType.text = val.name ?? '';
                                },
                              ),
                        // AxleSearchDropDown(
                        //     fieldHeading: 'Balance type',
                        //     fieldHint: 'Select Balance type',
                        //     fieldController: balanceType,
                        //     defaultName: balanceType.text,
                        //     fieldWidth: isMobile ? screenWidth : 300,
                        //     dropDownOptions: vehicleBalanceList,
                        //     validate: Validators('Balance Type').required(),
                        //     isRequired: true,
                        //     onChanged: (val) {
                        //       balanceType.text = val.name ?? '';
                        //     },
                        //   ),
                        AxleFormTextField(
                          fieldHeading: "Threshold Limit",
                          fieldHint: "Enter Threshold Limit",
                          validate: Validators('Threshold Limit').required().min(3).max(6),
                          fieldWidth: isMobile ? screenWidth : 300,
                          isRequiredField: true,
                          isOnlyDigits: true,
                          textType: TextInputType.number,
                          fieldController: thresholdLimit,
                          isFieldEnabled: !widget.isTagEnabled || isEditable,
                        ),
                        AxleFormTextField(
                          fieldHeading: "FASTag Serial Number",
                          fieldHint: "Enter FASTag Serial Number",
                          validate: Validators('FASTag Serial Number').required(),
                          fieldWidth: isMobile ? screenWidth : 300,
                          fieldController: serialNumber,
                          isRequiredField: true,
                          isFieldEnabled: !widget.isTagEnabled || isEditable,
                          onChange: (val) async {
                            if (val.length < 24) {
                              final status = ref.read(tagStatusIconProvider.notifier);
                              if (status.state != null) {
                                status.state = null;
                                tagController.clear();
                              }
                            }
                            if (val.length == 24) {
                              String? res = await ref.read(vehicleControllerProvider).getTagClass(serialNum: val);
                              if (res != null) {
                                tagController.text = res;
                              }
                            }
                          },
                          trailingIcon: ref.watch(tagStatusIconProvider) ?? const SizedBox(),
                        ),
                        AxleFormTextField(
                          fieldHeading: "Tag Class",
                          fieldHint: "Enter Tag Class",
                          validate: Validators('Tag Class').required(),
                          fieldWidth: isMobile ? screenWidth : 300,
                          fieldController: tagController,
                          isRequiredField: true,
                          isFieldEnabled: !widget.isTagEnabled || isEditable,
                        ),
                        widget.isTagEnabled
                            ? AxleFormTextField(
                                fieldHeading: 'Mapper Class',
                                fieldHint: 'Select Mapper Class',
                                fieldWidth: isMobile ? screenWidth : 300,
                                fieldController: mapperController,
                                isRequiredField: true,
                                isFieldEnabled: false,
                              )
                            : AxleSearchDropDown(
                                fieldHeading: 'Mapper Class',
                                fieldHint: 'Select Mapper Class',
                                fieldController: mapperController,
                                fieldWidth: isMobile ? screenWidth : 300,
                                dropDownOptions: getMapperList(),
                                validate: Validators('Mapper Class').required(),
                                isRequired: true,
                                //isEnabled: !widget.isTagEnabled,
                                onChanged: (val) {
                                  log("mapperController.text---$val");
                                  mapperController.text = val.name ?? '';
                                },
                              ),
                      ],
                    ),
                    const SizedBox(height: horizontalPadding),

                    Text(
                      "Secondary Details",
                      style: AxleTextStyle.headingPrimary,
                    ),
                    const SizedBox(height: defaultPadding),
                    AxleFormTextField(
                      fieldHeading: "Contact No. for Communication",
                      fieldHint: "Enter Mobile Number",
                      validate: Validators('Mobile Number').required().min(10).max(10),
                      fieldWidth: isMobile ? screenWidth : 300,
                      isRequiredField: true,
                      isOnlyDigits: true,
                      textType: TextInputType.number,
                      fieldController: mobileNoController,
                    ),
                    const SizedBox(height: horizontalPadding),

                    // * Documnet Upload Section
                    Text(
                      "Upload Documents",
                      style: AxleTextStyle.headingPrimary,
                    ),
                    const SizedBox(height: defaultPadding),
                    Wrap(
                      runSpacing: 20.0,
                      spacing: 60.0,
                      children: [
                        // * RC Book
                        AxleFilePicker(
                          customWidth: isMobile ? screenWidth : 420,
                          labelText: InputFormConstants.docFieldRCproof,
                          isRequiredField: true,
                          controller: rcBookController,
                          isEnabled: rcBookController.text != rcTextStr,
                          hintText: "Upload file",
                          validate: (val) {
                            if (rcBookController.text.isEmpty) {
                              return 'Document Required';
                            }
                            return null;
                          },
                          onPress: () async {
                            rcBookController.text = 'Uploading...';

                            final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(
                              ref,
                              docType: 'organization/vehicle',
                              orgEnrollId: widget.vehicleEnrollId,
                              allowPdf: true,
                            );
                            if (document != null) {
                              ref.read(tagDocumentsProvider.notifier).addItem(
                                    TagDocumentModel(
                                      name: "IDENTITY_PROOF",
                                      url: document['url']!.getTillDoc,
                                    ),
                                  );
                              rcBookController.text = document['name']!;
                              rcUrl.text = document['url']!;
                            } else {
                              rcBookController.clear();
                            }
                          },
                        ),
                        // *Vehicle Front Image
                        AxleFilePicker(
                          customWidth: isMobile ? screenWidth : 420,
                          hintText: "Upload file",
                          showToolTip: true,
                          toolTipText: 'Please ensure the vehicle`s registration number is clear in the picture',
                          labelText: InputFormConstants.vehicleFrontImage,
                          // isRequiredField: true,
                          controller: frontViewcontroller,
                          isEnabled: frontViewcontroller.text != frontViewStr,
                          // validate: (val) {
                          //   if (frontViewcontroller.text.isEmpty) {
                          //     return 'Image Required';
                          //   }
                          // },
                          onPress: frontViewcontroller.text == frontViewStr
                              ? () {}
                              : () async {
                                  frontViewcontroller.text = 'Uploading...';

                                  Map<String, String>? document;
                                  try {
                                    document = await FileUploadUtil.pickImagefromGallery(
                                      ref,
                                      docType: 'organization/vehicleImage',
                                      orgEnrollId: widget.vehicleEnrollId,
                                      axleFileType: FileType.image,
                                    );
                                  } catch (e) {
                                    debugPrint("Exception while getting Image from Gallery :: $e");
                                  }

                                  if (document != null) {
                                    // ref.read(tagDocumentsProvider.notifier).addItem(
                                    //       TagDocumentModel(
                                    //         name: "ADDRESS_PROOF",
                                    //         url: document['url']!.getTillDoc,
                                    //       ),
                                    //     );
                                    frontViewcontroller.text = document['name']!;
                                    frontUrl.text = document['url']!;
                                  } else {
                                    debugPrint("Error while getting Image from Gallery");
                                    frontViewcontroller.clear();
                                  }
                                },
                        ),
                        // * Vehicle Side View
                        AxleFilePicker(
                          hintText: "Upload file",
                          showToolTip: true,
                          toolTipText: 'Please ensure the vehicle`s axles are clearly visible in the picture',
                          customWidth: isMobile ? screenWidth : 420,
                          labelText: InputFormConstants.vehicleSideImage,
                          // isRequiredField: true,
                          controller: sideViewController,
                          isEnabled: frontViewcontroller.text != sideViewStr,
                          // validate: (val) {
                          //   if (sideViewController.text.isEmpty) {
                          //     return 'Image Required';
                          //   }
                          //   return null;
                          // },
                          onPress: sideViewController.text == sideViewStr
                              ? () {}
                              : () async {
                                  sideViewController.text = 'Uploading...';

                                  final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(
                                    ref,
                                    docType: 'organization/vehicleImage',
                                    orgEnrollId: widget.vehicleEnrollId,
                                    axleFileType: FileType.image,
                                  );
                                  if (document != null) {
                                    // ref.read(tagDocumentsProvider.notifier).addItem(
                                    //       TagDocumentModel(
                                    //         name: "RC_BOOK_IMAGE",
                                    //         url: document['url']!.getTillDoc,
                                    //       ),
                                    //     );
                                    sideViewController.text = document['name']!;
                                    sideUrl.text = document['url']!;
                                  } else {
                                    sideViewController.clear();
                                  }
                                },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                children: [
                  widget.isTagEnabled
                      ? Container()
                      : AxleOutlineButton(
                          buttonText: InputFormConstants.cancelbuttonText,
                          buttonStyle: AxleTextStyle.outLineButtonStyle,
                          buttonWidth: isMobile ? availableWidth * 38 / 100 : 200.0,
                          onPress: () {
                            context.router.pop();
                          },
                        ),
                  if (!isMobile) const SizedBox(width: defaultPadding),
                  AxlePrimaryButton(
                    buttonText: widget.isTagEnabled ? "Service Enabled" : "SUBMIT",
                    buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                    buttonWidth: isMobile ? availableWidth * 38 / 100 : 200.0,
                    onPress: widget.isTagEnabled
                        ? null
                        : () async {
                            if (enableYesTagForVehicleKey.currentState!.validate()) {
                              if (tagController.text.isEmpty) {
                                Snackbar.error('Invalid Fastag seriel number');
                                return;
                              }
                              log('before loader');
                              AxleLoader.show(context);
                              log('After loader - before request');
                              // debugPrint(getFormInputs().toString());
                              bool res = false;
                              try {
                                res = await ref.read(vehicleControllerProvider).enableTagService(getFormInputs());
                              } catch (e) {
                                log(e.toString());
                              }
                              AxleLoader.hide();
                              // log('After hide');
                              // debugPrint('The Form Inputs are -> ${getFormInputs().toMap()}');
                              // log('before loader');
                              // AxleLoader.show(context);
                              // log('After loader - before request');
                              // debugPrint(getFormInputs().toString());
                              // bool res = await ref.read(vehicleControllerProvider).enableTagService(getFormInputs());
                              // AxleLoader.hide();
                              // log('After hide');

                              if (res) {
                                // ignore: use_build_context_synchronously
                                context.router.pushNamed(RouteUtils.getVehiclesPath());
                              }
                            }
                          },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLqTagFormVehicle(OrgDoc? org) {
    bool isSuperAdmin = currentType == OrgType.axlerate;
    // bool isLqPending = lqServiceData?.kycStatus.contains('PENDING') ?? false;
    if (getOrgService(org, 'TAG', issuerName: 'LIVQUIK') == null) {
      return Column(
        children: [
          const AxleErrorWidget(
            imgHeight: 230.0,
            titleStr: 'Please enable Livquik service in Organization level.',
          ),
          AxlePrimaryButton(
            buttonText: "Enable LqTag",
            onPress: () {
              debugPrint(" org id ${widget.org?.enrollmentId}");
              context.router
                  .pushNamed(RouteUtils.getCustomerServicesPath(custEnrollId: widget.org?.enrollmentId ?? ''));
            },
          )
        ],
      );
    } else {
      return Container(
        color: appBlue,
        child: SingleChildScrollView(
          child: FutureBuilder<LqTagAdminOrgResponseModel>(
            future: lqTagAdminsListFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return AxleLoader.axleProgressIndicator();
                case ConnectionState.done:
                default:
                  if (snapshot.hasData) {
                    List<MessageLqAdmin> adminsList = snapshot.data?.data?.message ?? [];
                    if (adminsList.isEmpty) {
                      return Column(
                        children: [
                          const SizedBox(height: defaultPadding),
                          const AxleErrorWidget(
                            imgHeight: 250,
                            titleStr: "Please add LQTAG Admins",
                          ),
                          const SizedBox(height: defaultPadding),
                          Text(
                            "Note: To create 'FASTag Admin', Go to Staff -> Select Verified Admin -> Add FASTag Service ",
                            style: AxleTextStyle.labelMedium.copyWith(color: Colors.black),
                          ),
                          const SizedBox(height: defaultPadding),
                          AxlePrimaryButton(
                            buttonText: "Add LQTAG Admin",
                            onPress: () {
                              debugPrint(" org id ${widget.org?.enrollmentId}");
                              context.router.pushNamed(RouteUtils.getStaffsPath());

                              // context
                              //     .go(RouteUtils.getCustomerServicesPath(custEnrollId: widget.org?.enrollmentId ?? ''));
                            },
                          ),
                          const SizedBox(height: defaultPadding)
                        ],
                      );
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Form(
                            key: enableLqTagForVehicleKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (lqServiceData != null &&
                                    lqServiceData!.kycStatus == "DECLINED" &&
                                    rejectionReason.isNotEmpty)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        'Rejection Reason : $rejectionReason',
                                        style: AxleTextStyle.bodyLarge.copyWith(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                if (lqServiceData?.kycStatus == "PENDING" && lqServiceData?.regTruckException != null)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      lqServiceData?.regTruckException?.displayMessage ?? '',
                                      style: AxleTextStyle.bodyLarge.copyWith(color: Colors.red),
                                    ),
                                  ),
                                Text(
                                  "Primary Details",
                                  style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: defaultPadding),
                                Wrap(
                                  runSpacing: 20.0,
                                  spacing: 60.0,
                                  children: [
                                    AxleFormTextField(
                                      fieldHeading: "FASTag Serial Number",
                                      fieldHint: "Enter FASTag Serial Number",
                                      validate: Validators('FASTag Serial Number').required(),
                                      fieldWidth: isMobile ? screenWidth : 300,
                                      fieldController: serialNumberLq,
                                      isRequiredField: true,
                                      // lengthLimit: 16,
                                      isFieldEnabled: isSuperAdmin ? true : !widget.isLqTagEnabled,
                                      trailingIcon: ref.watch(tagStatusIconProvider) ?? const SizedBox(),
                                    ),
                                    GestureDetector(
                                      onTap: isSuperAdmin
                                          ? () async {
                                              DateTime? date = await DatePickerUtil.pickDate(context,
                                                  showRecentPicked: pickedRegDate);
                                              pickedRegDate = date;
                                              if (date != null) {
                                                regDateControllerLq.text = DatePickerUtil.userViewDateFormatter(date);
                                                regDate = date;
                                              }
                                            }
                                          : widget.isLqTagEnabled
                                              ? null
                                              : () async {
                                                  DateTime? date = await DatePickerUtil.pickDate(context,
                                                      showRecentPicked: pickedRegDate);
                                                  pickedRegDate = date;
                                                  if (date != null) {
                                                    regDateControllerLq.text =
                                                        DatePickerUtil.userViewDateFormatter(date);
                                                    regDate = date;
                                                  }
                                                },
                                      child: AxleFormTextField(
                                        fieldHeading: InputFormConstants.regDateFieldLabel,
                                        fieldHint: InputFormConstants.regDateFieldHint,
                                        fieldController: regDateControllerLq,
                                        fieldWidth: isMobile ? screenWidth : 300,
                                        isFieldEnabled: false,
                                        validate: Validators(InputFormConstants.regDateFieldLabel).required(),
                                        isRequiredField: true,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: isSuperAdmin
                                          ? () async {
                                              DateTime? date = await DatePickerUtil.pickDate(context,
                                                  showFuture: true, showRecentPicked: pickedFitnessDate);
                                              pickedFitnessDate = date;
                                              if (date != null) {
                                                fitnessDateControllerLq.text =
                                                    DatePickerUtil.userViewDateFormatter(date);
                                                fitnessDate = date;
                                              }
                                            }
                                          : widget.isLqTagEnabled
                                              ? null
                                              : () async {
                                                  DateTime? date = await DatePickerUtil.pickDate(context,
                                                      showFuture: true, showRecentPicked: pickedFitnessDate);
                                                  pickedFitnessDate = date;
                                                  if (date != null) {
                                                    fitnessDateControllerLq.text =
                                                        DatePickerUtil.userViewDateFormatter(date);
                                                    fitnessDate = date;
                                                  }
                                                },
                                      child: AxleFormTextField(
                                        fieldHeading: InputFormConstants.fitnessFieldLabel,
                                        fieldHint: InputFormConstants.fitnessFieldHint,
                                        fieldController: fitnessDateControllerLq,
                                        fieldWidth: isMobile ? screenWidth : 300,
                                        isFieldEnabled: false,
                                        validate: Validators(InputFormConstants.fitnessFieldLabel).required(),
                                        isRequiredField: true,
                                      ),
                                    ),
                                    AxleSearchDropDownField(
                                      fieldHeading: InputFormConstants.selectFastagAdmin,
                                      fieldHint: InputFormConstants.selectFastagAdmin,
                                      fieldWidth: isMobile ? screenWidth : 300,
                                      fieldController: tagAdminControllerLq,
                                      dropDownOptions: adminsList.map((item) {
                                        tagAdminUserEnrollmentIdLq.text = item.userEnrollmentId;
                                        return "${item.firstName} ${item.lastName}";
                                      }).toList(),
                                      validate: Validators(InputFormConstants.selectFastagAdmin).required(),
                                      isRequired: true,
                                      onChanged: (val) {
                                        tagAdminControllerLq.text = val;
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(height: horizontalPadding),

                                // * Documnet Upload Section
                                Text(
                                  "Upload Documents",
                                  style: AxleTextStyle.headingPrimary,
                                ),
                                const SizedBox(height: defaultPadding),
                                Wrap(
                                  runSpacing: defaultPadding,
                                  spacing: defaultPadding,
                                  children: [
                                    // * RC Book
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        AxleFilePicker(
                                          customWidth: isMobile ? screenWidth : 420,
                                          labelText: InputFormConstants.docFieldRCproof,
                                          isRequiredField: true,
                                          controller: rcBookControllerLq,
                                          isEnabled: isSuperAdmin ? true : rcBookControllerLq.text != uploaded,
                                          hintText: "Upload file",
                                          validate: (val) {
                                            if (rcBookControllerLq.text.isEmpty) {
                                              return 'Document Required';
                                            }
                                            return null;
                                          },
                                          onPress: () async {
                                            rcBookControllerLq.text = 'Uploading...';

                                            final Map<String, String>? document =
                                                await FileUploadUtil.pickImagefromGallery(
                                              ref,
                                              docType: 'organization/vehicle',
                                              orgEnrollId: widget.vehicleEnrollId.toUpperCase(),
                                              allowPdf: true,
                                            );
                                            if (document != null) {
                                              rcBookControllerLq.text = document['name']!;
                                              rcUrlLq.text = document['url']!;
                                            } else {
                                              rcBookControllerLq.clear();
                                            }
                                          },
                                        ),
                                        if (isSuperAdmin && widget.isLqTagEnabled)
                                          IconButton(
                                            icon: const Icon(Icons.download),
                                            style:
                                                ElevatedButton.styleFrom(backgroundColor: AxleColors.axlePrimaryColor),
                                            onPressed: () async {
                                              if (rcUrlLq.text.isNotEmpty) {
                                                AxleLoader.show(context);
                                                String res = await ref
                                                    .read(fileUploadControllerProvider)
                                                    .fileDownloadSignedUrl(urlStr: rcUrlLq.text);
                                                _launchUrl(res);
                                                AxleLoader.hide();
                                              }
                                            },
                                          )
                                      ],
                                    ),
                                    // * Owner Image
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        AxleFilePicker(
                                          customWidth: isMobile ? screenWidth : 420,
                                          hintText: "Upload file",
                                          showToolTip: true,
                                          toolTipText: 'Please ensure your face is clear in the picture',
                                          labelText: InputFormConstants.ownerImage,
                                          isRequiredField: true,
                                          controller: ownerImagecontrollerLq,
                                          isEnabled: isSuperAdmin ? true : ownerImagecontrollerLq.text != uploaded,
                                          // validate: (val) {
                                          //   if (ownerImagecontrollerLq.text.isEmpty) {
                                          //     return 'Image Required';
                                          //   }
                                          // },
                                          onPress: ownerImagecontrollerLq.text == frontViewStr
                                              ? () {}
                                              : () async {
                                                  ownerImagecontrollerLq.text = 'Uploading...';

                                                  final Map<String, String>? document =
                                                      await FileUploadUtil.pickImagefromGallery(
                                                    ref,
                                                    docType: 'organization/vehicle',
                                                    orgEnrollId: widget.vehicleEnrollId.toUpperCase(),
                                                    axleFileType: FileType.image,
                                                  );
                                                  if (document != null) {
                                                    ownerImagecontrollerLq.text = document['name']!;
                                                    ownerImageUrlLq.text = document['url']!;
                                                  } else {
                                                    ownerImagecontrollerLq.clear();
                                                  }
                                                },
                                        ),
                                        if (isSuperAdmin && widget.isLqTagEnabled)
                                          IconButton(
                                            icon: const Icon(Icons.download),
                                            style:
                                                ElevatedButton.styleFrom(backgroundColor: AxleColors.axlePrimaryColor),
                                            onPressed: () async {
                                              if (ownerImageUrlLq.text.isNotEmpty) {
                                                AxleLoader.show(context);
                                                String res = await ref
                                                    .read(fileUploadControllerProvider)
                                                    .fileDownloadSignedUrl(urlStr: ownerImageUrlLq.text);
                                                _launchUrl(res);
                                                AxleLoader.hide();
                                              }
                                            },
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: (isSuperAdmin &&
                                  widget.isLqTagEnabled &&
                                  (lqServiceData?.kycStatus.contains('INITIATED') ?? false))
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AxleOutlineButton(
                                      buttonText: InputFormConstants.cancelbuttonText,
                                      buttonStyle: AxleTextStyle.outLineButtonStyle,
                                      buttonWidth: isMobile ? availableWidth * 38 / 100 : 200.0,
                                      onPress: () {
                                        context.router.pop();
                                      },
                                    ),
                                    const SizedBox(width: 20.0),
                                    AxlePrimaryButton(
                                      buttonText: 'Approve/Decline',
                                      buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                      buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                                      onPress: () {
                                        showApproveDeclineDialog(lqServiceData?.userEnrollmentId ?? '');
                                      },
                                    ),
                                  ],
                                )
                              : (isSuperAdmin &&
                                      widget.isLqTagEnabled &&
                                      (lqServiceData?.kycStatus.contains('PENDING') ?? false))
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AxleOutlineButton(
                                          buttonText: InputFormConstants.cancelbuttonText,
                                          buttonStyle: AxleTextStyle.outLineButtonStyle,
                                          buttonWidth: isMobile ? availableWidth * 38 / 100 : 200.0,
                                          onPress: () {
                                            context.router.pop();
                                          },
                                        ),
                                        const SizedBox(width: 20.0),
                                        AxlePrimaryButton(
                                          buttonText: 'Retry',
                                          buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                          buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                                          onPress: () async {
                                            AxleLoader.show(context);
                                            bool res = await ref.read(vehicleControllerProvider).retryLqVehicle(
                                                  orgEnrolId: widget.org?.enrollmentId ?? '',
                                                  userEnrolId: lqServiceData?.userEnrollmentId ?? '',
                                                  vehicleRegNo: widget.vehicleRegNumber,
                                                );
                                            AxleLoader.hide();

                                            if (res && mounted) {
                                              await ref.read(vehicleControllerProvider).getVehicleByRegistrationNumber(
                                                  vehicleEnrolId: widget.vehicleRegNumber.toUpperCase());
                                            }
                                          },
                                        ),
                                      ],
                                    )
                                  : (isSuperAdmin && lqServiceData?.kycStatus == 'DECLINED')
                                      ? Row(
                                          mainAxisAlignment:
                                              isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                                          children: [
                                            AxleOutlineButton(
                                              buttonText: InputFormConstants.cancelbuttonText,
                                              buttonStyle: AxleTextStyle.outLineButtonStyle,
                                              buttonWidth: isMobile ? availableWidth * 38 / 100 : 200.0,
                                              onPress: () {
                                                context.router.pop();
                                              },
                                            ),
                                            const SizedBox(width: 20.0),
                                            AxlePrimaryButton(
                                              buttonText: "UPDATE",
                                              buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                              buttonWidth: isMobile ? availableWidth * 38 / 100 : 200.0,
                                              onPress: () async {
                                                if (enableLqTagForVehicleKey.currentState!.validate()) {
                                                  AxleLoader.show(context);
                                                  bool res = await ref
                                                      .read(vehicleControllerProvider)
                                                      .enableLqTagService(getLqTagInputForm());
                                                  AxleLoader.hide();

                                                  if (res && mounted) {
                                                    await ref
                                                        .read(vehicleControllerProvider)
                                                        .getVehicleByRegistrationNumber(
                                                            vehicleEnrolId: widget.vehicleRegNumber.toUpperCase());
                                                  }
                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      : widget.isLqTagEnabled
                                          ? Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                AxlePrimaryButton(
                                                  buttonText: 'Service Enabled',
                                                  buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                                  buttonWidth: isMobile ? availableWidth * 40 / 100 : 200.0,
                                                  onPress: null,
                                                ),
                                                const SizedBox(width: 20.0),
                                                const Icon(
                                                  Icons.check,
                                                  color: AxleColors.axleGreenColor,
                                                )
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                                              children: [
                                                AxleOutlineButton(
                                                  buttonText: InputFormConstants.cancelbuttonText,
                                                  buttonStyle: AxleTextStyle.outLineButtonStyle,
                                                  buttonWidth: isMobile ? availableWidth * 38 / 100 : 200.0,
                                                  onPress: () {
                                                    context.router.pop();
                                                  },
                                                ),
                                                const SizedBox(width: 20.0),
                                                AxlePrimaryButton(
                                                  buttonText: "SUBMIT",
                                                  buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                                  buttonWidth: isMobile ? availableWidth * 38 / 100 : 200.0,
                                                  onPress: () async {
                                                    if (enableLqTagForVehicleKey.currentState!.validate()) {
                                                      AxleLoader.show(context);
                                                      bool res = await ref
                                                          .read(vehicleControllerProvider)
                                                          .enableLqTagService(getLqTagInputForm());
                                                      AxleLoader.hide();

                                                      if (res && mounted) {
                                                        await ref
                                                            .read(vehicleControllerProvider)
                                                            .getVehicleByRegistrationNumber(
                                                                vehicleEnrolId: widget.vehicleRegNumber.toUpperCase());
                                                      }
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const AxleErrorWidget(
                          imgHeight: 250,
                          titleStr: "Please add LQTAG Admins",
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "Note: To create 'FASTag Admin', Go to Staff -> Select Verified Admin -> Add FASTag Service ",
                          style: AxleTextStyle.labelMedium.copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: defaultPadding),
                        AxlePrimaryButton(
                          buttonText: "Add LqTag Admin",
                          onPress: () {
                            debugPrint(" org id ${widget.org?.enrollmentId}");
                            context.router.pushNamed(RouteUtils.getStaffsPath());
                          },
                        )
                      ],
                    );
                  }
              }
            },
          ),
        ),
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    // html.AnchorElement anchorElement = new html.AnchorElement(href: url);
    // anchorElement.download = url;
    // anchorElement.click();

    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {}
  }

  void showApproveDeclineDialog(String userEnrollId) {
    final TextEditingController status = TextEditingController();
    final TextEditingController rejReason = TextEditingController();
    bool isVisible = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(builder: (context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const SizedBox(),
                //     IconButton(
                //       onPressed: () => Navigator.pop(context),
                //       icon: const Icon(Icons.close),
                //     )
                //   ],
                // ),
                const SizedBox(height: defaultPadding),
                AxleSearchDropDown(
                  fieldHint: 'Select Status',
                  fieldController: status,
                  onChanged: (val) {
                    status.text = val.value;
                    if (val.value == 'DECLINED') {
                      setState(() {
                        isVisible = true;
                      });
                    } else {
                      setState(() {
                        isVisible = false;
                      });
                    }
                  },
                  dropDownOptions: const [
                    DropDownValueModel(name: 'Approve', value: 'APPROVED'),
                    DropDownValueModel(name: 'Decline', value: 'DECLINED'),
                  ],
                ),
                const SizedBox(height: defaultMobilePadding),
                Visibility(
                  visible: isVisible,
                  child: AxleFormTextField(
                    fieldHint: 'Enter Reject Reason',
                    fieldController: rejReason,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AxleOutlineButton(
                      buttonText: 'Cancel',
                      onPress: () => Navigator.pop(context),
                    ),
                    AxlePrimaryButton(
                      buttonText: 'Done',
                      onPress: () async {
                        Navigator.pop(context);
                        AxleLoader.show(context);
                        bool res = await ref.read(vehicleControllerProvider).approveOrDeclineLqVehicle(
                              userEnrollId: userEnrollId,
                              orgEnrollId: widget.org?.enrollmentId ?? '',
                              vehicleRegNum: widget.vehicleRegNumber,
                              status: status.text,
                              rejReason: rejReason.text,
                            );
                        AxleLoader.hide();
                        if (res && mounted) {
                          await ref
                              .read(vehicleControllerProvider)
                              .getVehicleByRegistrationNumber(vehicleEnrolId: widget.vehicleRegNumber.toUpperCase());
                          // ignore: use_build_context_synchronously
                          context.router.pop();
                        }
                      },
                    )
                  ],
                )
              ],
            );
          }),
        );
      },
    );
  }

  List<DropDownValueModel> getMapperList() {
    switch (tagController.text) {
      case 'VC4':
        return vc4List;
      case 'VC5':
        return vc5List;
      case 'VC6':
        return vc6List;
      case 'VC7':
        return vc7List;
      case 'VC12':
        return vc12List;
      case 'VC15':
        return vc15List;
      default:
        return [];
    }
  }

  VehicleFastTagServiceInputModel getFormInputs() {
    log("-------------->${mapperController.text}");
    log("-------------->${balanceType.text}");
    return VehicleFastTagServiceInputModel(
      organizationId: widget.org?.id ?? '',
      vehicleRegistrationNumber: widget.vehicleRegNumber,
      balanceType: balanceType.text.toValueCase,
      fastagInfo: FastagInfo(
        serialNumber: serialNumber.text,
        vehicleClass: VehicleInputClass(
          axleCount: int.parse(mapperController.text.split('|').last.split('Axle').first),
          mapperClass: mapperController.text.split('|').first.trim(),
          tagClass: tagController.text,
        ),
      ),
      kycDocuments: {
        "RC_BOOK_IMAGE": {"url": rcUrl.text}
      },
      vehicleImages: {
        "FRONT_VIEW": {"url": frontUrl.text},
        "SIDE_VIEW": {"url": sideUrl.text}
      },
      // VehicleTagKycDocuments(
      //   identityProof: AddressProof(
      //     url: idUrl.text,
      //   ),
      //   addressProof: AddressProof(
      //     url: addressUrl.text,
      //   ),
      //   rcBookImage: AddressProof(
      //     url: rcUrl.text,
      //   ),
      // ),
      contactNumber: mobileNoController.text.trim(),
      thresholdLimit: int.parse(thresholdLimit.text),
    );
  }

  VehicleLqTagInputModel getLqTagInputForm() {
    return VehicleLqTagInputModel(
      userEnrollmentId: tagAdminUserEnrollmentIdLq.text.toUpperCase(),
      organizationEnrollmentId: widget.org?.enrollmentId ?? '',
      vehicleRegistrationNumber: widget.vehicleRegNumber,
      balanceType: 'CUSTOMER_LEVEL_BALANCE',
      fastagInfo: FastagInfoLq(
        serialNumber: serialNumberLq.text,
      ),
      kycDocuments: KycDocumentsLqInput(
        rcBookImage: RcBookImageLqInput(
          documentNo: widget.vehicleRegNumber,
          documentExpiry: fitnessDate.toString(),
          url: rcUrlLq.text,
        ),
        ownerImage: OwnerImageLqInput(
          url: ownerImageUrlLq.text,
        ),
      ),
      registrationDate: regDate.toString(),
    );
  }
}
