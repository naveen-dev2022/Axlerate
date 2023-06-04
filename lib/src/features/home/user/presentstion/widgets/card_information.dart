// // ignore_for_file: must_be_immutable

// import 'package:axlerate/Themes/axle_colors.dart';
// import 'package:axlerate/Themes/common_style_util.dart';
// import 'package:axlerate/Themes/text_style_config.dart';
// import 'package:axlerate/responsive.dart';
// import 'package:axlerate/router/route_utils.dart';
// import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
// import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
// import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
// import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
// import 'package:axlerate/src/features/home/user/presentstion/widgets/label_value_widget.dart';
// import 'package:axlerate/src/utils/axle_loader.dart';
// import 'package:axlerate/src/utils/web_view/web_view_manager.dart';
// import 'package:axlerate/values/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// class CardInformation extends ConsumerWidget {
//   CardInformation({
//     Key? key,
//     required this.org,
//     required this.user,
//     required this.userEnrollId,
//   }) : super(key: key);

//   final OrgDoc? org;
//   final UpdatedMessageUser? user;
//   final String userEnrollId;

//   double screenWidth = 0.0;
//   double screenHeight = 0.0;
//   double availableWidth = 0.0;
//   bool isMobile = false;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//     availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2);

//     isMobile = Responsive.isMobile(context);

//     if (isMobile) {
//       availableWidth = screenWidth - (defaultPadding * 2);
//     }

//     return Container(
//       margin: EdgeInsets.all(isMobile ? 0 : defaultMobilePadding),
//       constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 600),
//       height: isMobile ? null : 300,
//       width: isMobile ? availableWidth : availableWidth * 63 / 100,
//       // padding: const EdgeInsets.all(10.0),
//       decoration: CommonStyleUtil.axleListingCardDecoration,
//       child: Padding(
//         padding: const EdgeInsets.all(defaultPadding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Card Information', style: AxleTextStyle.titleMedium),
//                 MouseRegion(
//                   cursor: SystemMouseCursors.click,
//                   child: GestureDetector(
//                     onTap: () {
//                       AxleLoader.show(context);

//                       Future.delayed(const Duration(seconds: 1), () async {
//                         String url = await ref
//                             .read(userControllerProvider)
//                             .getCardPciWidget(userEnrollId: userEnrollId, orgId: org?.id ?? '');
//                         if (url.isNotEmpty) {
//                           // ignore: use_build_context_synchronously
//                           showCardDetailsDialog(context, url);
//                         }

//                         AxleLoader.hide();
//                       });
//                     },
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text('Show', style: AxleTextStyle.labelMedium.copyWith(color: AxleColors.iconColor)),
//                         const SizedBox(width: 4.0),
//                         const Icon(Icons.visibility_off, color: AxleColors.iconColor),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // const SizedBox(height: defaultPadding),
//             isMobile
//                 ? Column(
//                     children: [
//                       const SizedBox(height: defaultPadding),
//                       getAxleDebitCard(),
//                       const SizedBox(height: defaultPadding),
//                       getAxleDebitCardDetails(),
//                       const SizedBox(height: defaultPadding),
//                       getManageCardButton(context),
//                       const SizedBox(height: defaultPadding),
//                     ],
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.only(top: defaultPadding),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Column(children: [
//                           getAxleDebitCard(),
//                           const SizedBox(height: defaultPadding),
//                           getManageCardButton(context),
//                         ]),
//                         const SizedBox(width: defaultPadding),
//                         getAxleDebitCardDetails(),
//                       ],
//                     ),
//                   )
//           ],
//         ),
//       ),
//     );
//   }

//   void showCardDetailsDialog(BuildContext context, String url) {
//     double sw = MediaQuery.of(context).size.width;
//     double sh = MediaQuery.of(context).size.height;

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           titlePadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const SizedBox(),
//               Text('Card Details', style: AxleTextStyle.subtitle1BlackBold),
//               IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
//             ],
//           ),
//           content: SizedBox(
//             height: isMobile ? sh : sh * 90 / 100,
//             width: isMobile ? sw : sw * 90 / 100,
//             child: WebViewManager.instance.buildUiSettings(
//               context: context,
//               url: url,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget getAxleDebitCardDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         LabelValueWidget(heading: 'Name on Card', value: user?.name ?? "***** *"),
//         const LabelValueWidget(heading: 'Card Number', value: '**** **** **** ****'),
//         const LabelValueWidget(heading: 'Valid From', value: '**/****'),
//         const LabelValueWidget(heading: 'Valid To', value: '**/****'),
//       ],
//     );
//   }

//   Widget getAxleDebitCard() {
//     return Container(
//         width: isMobile ? availableWidth : 250.0,
//         decoration: BoxDecoration(color: AxleColors.axleBackgroundColor, borderRadius: BorderRadius.circular(10.0)),
//         child: Stack(alignment: AlignmentDirectional.bottomStart, children: [
//           Image.asset(width: availableWidth, 'assets/images/axle-ppi-card.png', fit: BoxFit.fitWidth),
//           Padding(
//             padding: const EdgeInsets.only(left: defaultPadding, bottom: defaultMobilePadding),
//             child: Text((user?.name ?? "***** *").toUpperCase(), style: AxleTextStyle.subtitle1Card),
//           )
//         ]));
//   }

//   Widget getManageCardButton(BuildContext context) {
//     return AxleOutlineButton(
//       buttonText: 'Manage Card',
//       outlineColor: AxleColors.axleBlueColor,
//       buttonWidth: 250.0,
//       buttonHeight: isMobile ? 40 : 50,
//       onPress: () {
//         context.push(RouteUtils.getStaffManageCardPath(org!.enrollmentId, user!.enrollmentId));
//       },
//     );
//   }
// }
