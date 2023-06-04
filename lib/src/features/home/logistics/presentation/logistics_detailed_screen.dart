import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/widgets/info_widget.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class LogisticsDetailedScreen extends ConsumerStatefulWidget {
  const LogisticsDetailedScreen({
    @PathParam('custId') required this.enrolId,
    super.key,
  });
  final String enrolId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogisticsDetailedScreenState();
}

class _LogisticsDetailedScreenState extends ConsumerState<LogisticsDetailedScreen> {
  @override
  void initState() {
    super.initState();
  }

  String logoUrl = '';
  String uploadedUrl = '';

  @override
  Widget build(BuildContext context) {
    OrgDoc? org = ref.watch(orgDetailsProvider);
    if (org != null) {
      logoUrl = org.organizationLogo ?? uploadedUrl;
    }
    bool isMobile = Responsive.isMobile(context);

    return org == null
        ? AxleLoader.axleProgressIndicator()
        : SingleChildScrollView(
            child: Padding(
              padding: isMobile
                  ? const EdgeInsets.all(defaultPadding)
                  : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                children: [
                  if (!isMobile)
                    Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: DashboardHeader(title: "Customer Detailed View", orgName: org.displayName)),
                  if (isMobile)
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              context.router.pop();
                            },
                            child: Row(children: [
                              const Icon(size: 12, color: primaryColor, Icons.arrow_back_ios_new_rounded),
                              Text('Back', style: AxleTextStyle.labelLarge),
                              const SizedBox(width: defaultPadding)
                            ])),
                        AxleTextWithBg(text: org.displayName, textColor: primaryColor)
                      ],
                    ),
                  Padding(
                    padding: EdgeInsets.all(isMobile ? 0 : defaultPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: AxleColors.borderColor, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(defaultPadding),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: defaultMobilePadding),
                                                child: Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50.0),
                                                  ),
                                                  child: DottedBorder(
                                                    padding: const EdgeInsets.all(0.0),
                                                    color: AxleColors.axleBlueColor,
                                                    dashPattern: const [1],
                                                    radius: const Radius.circular(16.0),
                                                    strokeWidth: 2.0,
                                                    borderType: BorderType.RRect,
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        AxleLoader.show(context);
                                                        Map<String, String>? imageData =
                                                            await FileUploadUtil.pickImagefromGallery(
                                                          ref,
                                                          docType: 'organization/logo',
                                                          orgEnrollId: org.enrollmentId,
                                                          showSuccessSnackbar: false,
                                                          axleFileType: FileType.image,
                                                        );

                                                        if (imageData != null) {
                                                          await ref
                                                              .read(logisticsControllerProvider)
                                                              .uploadLogisticsOrgLogo(
                                                                  enrollmentId: org.id, url: imageData['url'] ?? "");
                                                          setState(() {
                                                            uploadedUrl = imageData['url'] ?? '';
                                                            logoUrl = uploadedUrl;
                                                          });
                                                        }
                                                        AxleLoader.hide();
                                                      },
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius: const BorderRadius.all(
                                                                  Radius.circular(defaultPadding)),
                                                              child: Stack(
                                                                alignment: Alignment.bottomCenter,
                                                                children: [
                                                                  Image.network(
                                                                    logoUrl,
                                                                    width: 150,
                                                                    height: 150,
                                                                    fit: BoxFit.cover,
                                                                    errorBuilder: (context, error, stackTrace) {
                                                                      log("Error Network Image",
                                                                          error: error, stackTrace: stackTrace);
                                                                      return Image.asset(
                                                                          'assets/new_assets/dummy_profile.png');
                                                                    },
                                                                  ),
                                                                  Container(
                                                                    decoration: const BoxDecoration(
                                                                        gradient: LinearGradient(
                                                                      begin: Alignment.topCenter,
                                                                      end: Alignment.bottomCenter,
                                                                      colors: [Colors.transparent, Colors.black],
                                                                    )),
                                                                    width: 150,
                                                                    height: 50,
                                                                    child: Center(
                                                                        child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                            'assets/new_assets/icons/change_image_icon.svg'),
                                                                        const SizedBox(width: defaultPadding),
                                                                        Text("Change Image",
                                                                            style: AxleTextStyle.subtitle2White)
                                                                      ],
                                                                    )),
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
                                              ),
                                              SizedBox(
                                                height: 220,
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: defaultPadding),
                                                    if (getOrgService(org, 'TAG', issuerName: 'LIVQUIK') != null)
                                                      OrgServiceStatusCard(
                                                        title: "LQ Tag",
                                                        status:
                                                            ("KYC ${getOrgService(org, 'TAG', issuerName: 'LIVQUIK')?.kycStatus.toUiCase}"),
                                                        iconPath: "assets/new_assets/icons/livquik_icon_with_bg.svg",
                                                      ),
                                                    const SizedBox(width: defaultPadding),
                                                    if (getOrgService(org, 'TAG', issuerName: 'YESBANK') != null)
                                                      OrgServiceStatusCard(
                                                        title: "YB Tag",
                                                        status:
                                                            ("KYC ${getOrgService(org, 'TAG', issuerName: 'YESBANK')?.kycStatus.toUiCase}"),
                                                        iconPath: "assets/new_assets/icons/yesbank_icon_with_bg.svg",
                                                      ),
                                                    const SizedBox(width: defaultPadding),
                                                    if (getOrgService(org, 'GPS') != null)
                                                      const OrgServiceStatusCard(
                                                        title: "GPS",
                                                        status: "Approved",
                                                        iconPath: "assets/new_assets/icons/gps_icon_with_bg.svg",
                                                      ),
                                                    const SizedBox(width: defaultPadding),
                                                    if (getOrgService(org, 'PPI') != null)
                                                      OrgServiceStatusCard(
                                                        title: "PPI",
                                                        status:
                                                            ("KYC ${getOrgService(org, 'PPI')?.kycStatus.toUiCase}"),
                                                        iconPath: "assets/new_assets/icons/ppi_icon_with_bg.svg",
                                                      ),
                                                    const SizedBox(width: defaultPadding),
                                                    if (getOrgService(org, 'FUEL') != null)
                                                      OrgServiceStatusCard(
                                                        title: "FUEL",
                                                        status:
                                                            ("KYC ${getOrgService(org, 'FUEL')?.kycStatus.toUiCase}"),
                                                        iconPath: "assets/new_assets/icons/fuel_icon_with_bg-1.svg",
                                                      ),
                                                    const SizedBox(width: defaultPadding),
                                                    if (getOrgService(org, 'INVOICE') != null)
                                                      OrgServiceStatusCard(
                                                        title: "INVOICE",
                                                        status:
                                                            ("KYC ${getOrgService(org, 'INVOICE')?.kycStatus.toUiCase}"),
                                                        iconPath: "assets/new_assets/icons/payment_icon_with_bg.svg",
                                                      ),
                                                    const SizedBox(width: defaultPadding),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(defaultPadding),
                                          decoration: CommonStyleUtil.axleListingCardDecoration,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        "Customer Details",
                                                        style: AxleTextStyle.titleMedium.copyWith(color: iconColor),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: defaultPadding),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Wrap(
                                                        spacing: horizontalPadding,
                                                        runSpacing: verticalPadding,
                                                        children: [
                                                          InfoWidget(
                                                              title: 'Customer Name', data: org.displayName ?? ''),
                                                          InfoWidget(title: 'Contact No.', data: org.contactNumber),
                                                          InfoWidget(title: 'Email', data: org.email),
                                                          InfoWidget(
                                                              title: 'Organization Type',
                                                              data: org.organizationType.toUiCase),
                                                          InfoWidget(
                                                              title: 'Nature of Business',
                                                              data: org.natureOfBusiness.toUiCase),
                                                          InfoWidget(title: 'PanNumber', data: org.panNumber),
                                                          if (org.incorporateDate != null)
                                                            InfoWidget(
                                                                title: 'Incorporate Date',
                                                                data: DatePickerUtil.dateMonthYearFormatter(
                                                                    org.incorporateDate!)),
                                                          InfoWidget(
                                                              title: 'Address 1',
                                                              data: org.addresses?.communicationAddress?.addressLine1 ??
                                                                  ''),
                                                          InfoWidget(
                                                              title: 'Address 2',
                                                              data: org.addresses?.communicationAddress?.addressLine2 ??
                                                                  ''),
                                                          InfoWidget(
                                                              title: 'City',
                                                              data: org.addresses?.communicationAddress?.city ?? ''),
                                                          InfoWidget(
                                                              title: 'Country',
                                                              data: org.addresses?.communicationAddress?.country ?? ''),
                                                          InfoWidget(
                                                              title: 'State',
                                                              data: org.addresses?.communicationAddress?.state ?? ''),
                                                          InfoWidget(
                                                              title: 'PinCode',
                                                              data:
                                                                  org.addresses?.communicationAddress?.zipCode ?? '-'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: defaultPadding),
                                                  const SizedBox(height: defaultPadding),
                                                  Container(height: 1, color: AxleColors.iconColor.withOpacity(0.2)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class OrgServiceStatusCard extends StatelessWidget {
  const OrgServiceStatusCard({super.key, required this.title, required this.status, required this.iconPath});

  final String title;
  final String status;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    Color textColor = getColor(status.toLowerCase());
    return SizedBox(
      height: 140,
      child: Stack(
        alignment: AlignmentDirectional.topEnd - const AlignmentDirectional(0.2, 2),
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: textColor, width: 1)),
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  title,
                  style: AxleTextStyle.headingBlack,
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: textColor.withOpacity(0.1),
                  ),
                  alignment: Alignment.center,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 4),
                      child: Text(
                        status,
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
          SvgPicture.asset(
            iconPath,
            height: 100,
          )
        ],
      ),
    );
  }

  getColor(String status) {
    Color toRet = primaryColor;

    if (status.contains("approved")) {
      toRet = AxleColors.axleGreenColor;
    } else if (status.contains("rejected")) {
      toRet = AxleColors.axleRedColor;
    } else if (status.contains("not")) {
      toRet = Colors.grey;
    }

    return toRet;
  }

  getIcon(String status) {
    IconData toRet = Icons.check_circle;

    if (status.contains("approved")) {
      toRet = Icons.check_circle;
    } else if (status.contains("rejected")) {
      toRet = Icons.cancel_rounded;
    } else if (status.contains("not")) {
      toRet = Icons.close_rounded;
    }

    return toRet;
  }
}
