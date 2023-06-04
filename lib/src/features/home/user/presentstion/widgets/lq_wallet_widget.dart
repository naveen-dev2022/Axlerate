import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/features/home/logistics/domain/lq_user_acc_info_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/ui_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/values/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class LqTagWallet extends ConsumerStatefulWidget {
  final String userEnrollmentId;
  final String kycType;
  final String kycStatus;
  final String orgenrollIdOfUser;
  const LqTagWallet({
    super.key,
    required this.userEnrollmentId,
    this.kycType = '',
    this.kycStatus = '',
    this.orgenrollIdOfUser = '',
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LqTagWalletState();
}

class _LqTagWalletState extends ConsumerState<LqTagWallet> {
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;

  bool isButton = false;
  String statusText = '';
  double maxLimit = minKycLimitPpi;
  double availableBalance = 0.0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userBalance = ref.watch(userDashBalanceProvider);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2 + defaultPadding);

    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    final lqTagAccountInfo = ref.watch(livquikTagAccDetailsProvider);
    if (lqTagAccountInfo != null && lqTagAccountInfo.data != null && lqTagAccountInfo.data!.message.isNotEmpty) {
      for (LqUserAccInfoModelMessage e in lqTagAccountInfo.data!.message) {
        if (e.userEnrollmentId.toLowerCase() == widget.userEnrollmentId.toLowerCase()) {
          availableBalance = e.availableBalance;
          break;
        }
      }
    }

    if (widget.kycType == "MIN_KYC") {
      if (widget.kycStatus == "PENDING") {
        isButton = false; //button hide show status
        statusText = "Pending";
      }
      if (widget.kycStatus == "MIN_KYC_APPROVED") {
        isButton = true; //button show , Complete Full KYC
      }
    }
    if (widget.kycType == "FULL_KYC") {
      if (widget.kycStatus == "VKYC_APPROVED") {
        maxLimit = fullKycLimitPpi;
        isButton = false; //Show text only APPROVED
        statusText = "Approved";
      }
      if (widget.kycStatus == "VKYC_REJECTED") {
        isButton = true; //button show , Complete Full KYC
      }
    }

    return Container(
        constraints: BoxConstraints(minWidth: isMobile ? availableWidth : 350),
        height: isMobile ? null : 300,
        width: isMobile ? availableWidth : availableWidth * 35 / 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Colors.blue.shade600),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Positioned(bottom: -10, right: -10, child: Image.asset("assets/new_assets/images/purse.png", width: 200)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Wallet Balance', style: AxleTextStyle.titleMedium.copyWith(color: Colors.white)),
                          //  if (!isMobile)
                          isButton
                              ? OutlinedButton(
                                  onPressed: () async {
                                    AxleLoader.show(context);
                                    String? link = await ref.read(userControllerProvider).getVKycLinkLqTag(
                                        userEnrollId: widget.userEnrollmentId, orgEnrollId: widget.orgenrollIdOfUser);
                                    AxleLoader.hide();
                                    if (link != null && mounted) {
                                      _launchUrl(Uri.parse(link));
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(width: 1.2, color: Colors.white),
                                  ),
                                  child: const Text(
                                    'Complete V-KYC',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                )
                              : Text('Status : $statusText',
                                  style: AxleTextStyle.titleMedium.copyWith(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          lqTagAccountInfo == null
                              ? AxleLoader.axleProgressIndicator(height: 20.0, width: 20.0)
                              : Text(axleCurrencyFormatterwithDecimals.format(availableBalance).toString(),
                                  style: AxleTextStyle.displaySmall.copyWith(color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.all(defaultMobilePadding / 2),
                            child: Text("Available", style: AxleTextStyle.labelSmall.copyWith(color: Colors.white)),
                          )
                        ],
                      ),
                      const SizedBox(height: defaultMobilePadding),
                      SizedBox(
                        width: 200,
                        child: Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text("Limit", style: AxleTextStyle.pieChartText),
                              Text(axleCurrencyFormatter.format(maxLimit).toString(), style: AxleTextStyle.pieChartText)
                            ]),
                            const SizedBox(height: defaultMobilePadding),
                            if (userBalance != null &&
                                userBalance.data != null &&
                                userBalance.data!.message.result.isNotEmpty)
                              LinearProgressIndicator(
                                  value: double.parse(userBalance.data?.message.result[0].balance ?? '0') / maxLimit,
                                  color: sideMenuBgColor,
                                  backgroundColor: Colors.white.withOpacity(0.19),
                                  minHeight: 7)
                          ],
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      // if (isMobile)
                      //   Align(
                      //     alignment: Alignment.center,
                      //     child: isButton
                      //         ? OutlinedButton(
                      //             onPressed: () async {
                      //               AxleLoader.show(context);
                      //               String? link = await ref.read(userControllerProvider).getVKycLinkLqTag(
                      //                   userEnrollId: widget.userEnrollmentId, orgEnrollId: widget.orgenrollIdOfUser);
                      //               AxleLoader.hide();
                      //               if (link != null && mounted) {
                      //                 _launchUrl(Uri.parse(link));
                      //               }
                      //             },
                      //             style: OutlinedButton.styleFrom(
                      //               side: const BorderSide(width: 1.2, color: Colors.white),
                      //             ),
                      //             child: const Text(
                      //               'Complete V-KYC',
                      //               style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 14.0,
                      //               ),
                      //             ),
                      //           )
                      //         : Text('Status : $statusText',
                      //             style: AxleTextStyle.titleMedium.copyWith(color: Colors.white)),
                      //   ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
