// import 'dart:developer';

// import 'package:axlerate/Themes/axle_colors.dart';
// import 'package:axlerate/Themes/text_style_config.dart';
// import 'package:axlerate/responsive.dart';
// import 'package:axlerate/src/common/common_constants/common_list.dart';
// import 'package:axlerate/src/common/common_widgets/axle_file_picker.dart';
// import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
// import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
// import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
// import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
// import 'package:axlerate/src/features/home/form_widgets/form_section_heading_widget.dart';
// import 'package:axlerate/src/features/home/payments/presentation/enable_payments_page.dart';
// import 'package:axlerate/src/features/home/services/presentation/widgets/doc_name_field_widget.dart';
// import 'package:axlerate/src/features/home/services/presentation/widgets/payments_kyc_details_form.dart';
// import 'package:axlerate/src/features/home/services/presentation/widgets/tag_primary_details_form.dart';
// import 'package:axlerate/src/features/home/services/presentation/widgets/tag_upload_docs_form.dart';
// import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
// import 'package:axlerate/src/utils/form_validators.dart';
// import 'package:axlerate/values/constants.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';

// class AddPaymentsService extends ConsumerStatefulWidget {
//   const AddPaymentsService({super.key});

//   @override
//   ConsumerState<AddPaymentsService> createState() => _AddPaymentsServiceState();
// }

// class _AddPaymentsServiceState extends ConsumerState<AddPaymentsService> {
//   final GlobalKey<FormState> enablePaymentsKey = GlobalKey<FormState>();

//   final TextEditingController kycStatusController = TextEditingController();
//   final TextEditingController midController = TextEditingController();
//   final TextEditingController midPassController = TextEditingController();
//   final TextEditingController rejReasoncontroller = TextEditingController();
//   final TextEditingController registerNameController = TextEditingController();
//   final TextEditingController businessTypeController = TextEditingController();

//   final TextEditingController doc1Name = TextEditingController();
//   final TextEditingController doc2Name = TextEditingController();
//   final TextEditingController doc3Name = TextEditingController();
//   final TextEditingController doc4Name = TextEditingController();
//   final TextEditingController doc5Name = TextEditingController();
//   final TextEditingController doc6Name = TextEditingController();
//   final TextEditingController doc7Name = TextEditingController();
//   final TextEditingController doc8Name = TextEditingController();
//   final TextEditingController doc9Name = TextEditingController();
//   final TextEditingController doc10Name = TextEditingController();

//   final TextEditingController doc1Url = TextEditingController();
//   final TextEditingController doc2Url = TextEditingController();
//   final TextEditingController doc3Url = TextEditingController();
//   final TextEditingController doc4Url = TextEditingController();
//   final TextEditingController doc5Url = TextEditingController();
//   final TextEditingController doc6Url = TextEditingController();
//   final TextEditingController doc7Url = TextEditingController();
//   final TextEditingController doc8Url = TextEditingController();
//   final TextEditingController doc9Url = TextEditingController();
//   final TextEditingController doc10Url = TextEditingController();

//   String orgLogoUrl = '';

//   bool isMobile = false;

//   double screenWidth = 0.0;

//   @override
//   Widget build(BuildContext context) {
//     screenWidth = MediaQuery.of(context).size.width;
//     isMobile = Responsive.isMobile(context);

//     return Form(
//       key: enablePaymentsKey,
//       child: Padding(
//         padding: const EdgeInsets.all(defaultPadding),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "KYC Details",
//               style: AxleTextStyle.headingPrimary,
//             ),
//             Theme(
//               data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//               child: PaymentsKycDetailsForm(
//                 kycStatusController: TextEditingController(),
//                 midController: TextEditingController(),
//                 midPassController: TextEditingController(),
//                 rejReasoncontroller: TextEditingController(),
//               ),
//             ),
//             Text(
//               "Organization Logo",
//               style: AxleTextStyle.headingPrimary,
//             ),

//             const SizedBox(height: defaultPadding),
//             // * Logo Upload Card
//             MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: GestureDetector(
//                 onTap: () async {
//                   Map<String, String>? imageData = await FileUploadUtil.pickImagefromGallery(
//                     ref,
//                     docType: 'organization/user',
//                     orgEnrollId: 'AX0',
//                     showSuccessSnackbar: true,
//                   );
//                   setState(() {
//                     orgLogoUrl = imageData!['url'] ?? '';
//                     // Snackbar.success(imageData.toString());
//                   });
//                 },
//                 child: (orgLogoUrl.isNotEmpty)
//                     ? ClipRRect(
//                         borderRadius: const BorderRadius.all(
//                           Radius.circular(16.0),
//                         ),
//                         child: Stack(
//                           alignment: Alignment.bottomCenter,
//                           children: [
//                             Image.network(
//                               orgLogoUrl,
//                               width: 250,
//                               height: 250,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const SizedBox(
//                                   height: 200,
//                                   width: 200,
//                                   child: Icon(
//                                     Icons.business_outlined,
//                                     color: Colors.grey,
//                                     size: 100.0,
//                                   ),
//                                 );
//                               },
//                             ),
//                             Container(
//                               decoration: const BoxDecoration(
//                                   gradient: LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   Colors.transparent,
//                                   Colors.black,
//                                 ],
//                               )),
//                               width: 250,
//                               height: 50,
//                               child: Center(
//                                   child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   SvgPicture.asset('assets/new_assets/icons/change_image_icon.svg'),
//                                   const SizedBox(width: defaultPadding),
//                                   Text(
//                                     "Change Image",
//                                     style: AxleTextStyle.subtitle2White,
//                                   )
//                                 ],
//                               )),
//                             )
//                           ],
//                         ),
//                       )
//                     : Container(
//                         height: 200,
//                         width: 200,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: DottedBorder(
//                           padding: const EdgeInsets.all(20.0),
//                           color: AxleColors.axleBlueColor,
//                           dashPattern: const [6],
//                           radius: const Radius.circular(16.0),
//                           strokeWidth: 2.0,
//                           borderType: BorderType.RRect,
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 SvgPicture.asset('assets/new_assets/icons/image_upload_icon.svg'),
//                                 Text(
//                                   'Upload Image',
//                                   style: AxleTextStyle.imageUploadTextStyle,
//                                 ),
//                                 const SizedBox(height: 20.0),
//                                 Text(
//                                   'Maximum file size: 3MB',
//                                   style: AxleTextStyle.primaryMiniHintStyle,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//               ),
//             ),
//             const SizedBox(height: defaultPadding),
//             Text(
//               "Upload KYC Documents",
//               style: AxleTextStyle.headingPrimary,
//             ),
//             const SizedBox(height: defaultPadding),

//             // Theme(
//             //   data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//             //   child: TagUploadDocsForm(
//             //     idProofController: TextEditingController(),
//             //     addressProofController: TextEditingController(),
//             //     orgEnrollId: '',
//             //     idUrlController: TextEditingController(),
//             //     addressUrlController: TextEditingController(),
//             //   ),
//             // ),
//             const SizedBox(
//               width: verticalPadding,
//             ),

//             DocNameFieldWidget(
//               docNameController: TextEditingController(),
//               urlController: TextEditingController(),
//               docNameLable: 'Document 1',
//               docNameHint: 'Upload File',
//               nameLable: 'Document 1',
//               nameHint: 'Select Document Name',
//               docType: 'organization/user',
//               orgEnrollId: 'AX0',
//             ),
//             DocNameFieldWidget(
//               docNameController: TextEditingController(),
//               urlController: TextEditingController(),
//               docNameLable: 'Document 2',
//               docNameHint: 'Upload File',
//               nameLable: 'Document 2',
//               nameHint: 'Select Document Name',
//               docType: 'organization/user',
//               orgEnrollId: 'AX0',
//             ),
//             DocNameFieldWidget(
//               docNameController: TextEditingController(),
//               urlController: TextEditingController(),
//               docNameLable: 'Document 3',
//               docNameHint: 'Upload File',
//               nameLable: 'Document 3',
//               nameHint: 'Select Document Name',
//               docType: 'organization/user',
//               orgEnrollId: 'AX0',
//             ),
//             DocNameFieldWidget(
//               docNameController: TextEditingController(),
//               urlController: TextEditingController(),
//               docNameLable: 'Document 4',
//               docNameHint: 'Upload File',
//               nameLable: 'Document 4',
//               nameHint: 'Select Document Name',
//               docType: 'organization/user',
//               orgEnrollId: 'AX0',
//             ),
//             DocNameFieldWidget(
//               docNameController: TextEditingController(),
//               urlController: TextEditingController(),
//               docNameLable: 'Document 5',
//               docNameHint: 'Upload File',
//               nameLable: 'Document 5',
//               nameHint: 'Select Document Name',
//               docType: 'organization/user',
//               orgEnrollId: 'AX0',
//             ),

//             const SizedBox(width: 50.0),
//             Padding(
//               padding: const EdgeInsets.all(defaultPadding),
//               child: Row(
//                 mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
//                 children: [
//                   AxleOutlineButton(
//                     buttonText: InputFormConstants.cancelbuttonText,
//                     buttonStyle: AxleTextStyle.outLineButtonStyle,
//                     buttonWidth: isMobile ? 100.0 : 200.0,
//                     onPress: () {
//                       context.pop();
//                     },
//                   ),
//                   const SizedBox(width: 20.0),
//                   AxlePrimaryButton(
//                     buttonText: "ENABLE PAYMENTS",
//                     buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
//                     buttonWidth: 200.0,
//                     onPress: () async {
//                       if (enablePaymentsKey.currentState?.validate() ?? false) {
//                         log('Validated');
//                       }
//                     },
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     doc1Name.dispose();
//     doc2Name.dispose();
//     doc3Name.dispose();
//     doc4Name.dispose();
//     doc5Name.dispose();
//     doc6Name.dispose();
//     doc7Name.dispose();
//     doc8Name.dispose();
//     doc9Name.dispose();
//     doc10Name.dispose();
//     doc1Url.dispose();
//     doc2Url.dispose();
//     doc3Url.dispose();
//     doc4Url.dispose();
//     doc5Url.dispose();
//     doc6Url.dispose();
//     doc7Url.dispose();
//     doc8Url.dispose();
//     doc9Url.dispose();
//     doc10Url.dispose();
//     super.dispose();
//   }
// }
