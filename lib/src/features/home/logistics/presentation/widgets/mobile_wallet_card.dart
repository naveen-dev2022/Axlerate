import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/account_info_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/upi_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/logistics_mobile_dashboard.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class MobileWalletCard extends StatelessWidget {
  const MobileWalletCard({required this.wallet, this.direction = TextDirection.ltr, super.key});
  final WalletDisplayModel wallet;
  final TextDirection direction;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width * 78 / 100,
      margin: const EdgeInsets.symmetric(horizontal: defaultMobilePadding, vertical: 10.0),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: wallet.walletColor.withOpacity(0.1), //Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.black.withOpacity(0.2), blurRadius: 5.0, spreadRadius: 0.4, offset: const Offset(0, 2)),
        // ],
      ),
      child: Row(
        textDirection: direction,
        children: [
          Container(
            width: 30,
            decoration: BoxDecoration(
                color: wallet.walletColor,
                borderRadius: direction == TextDirection.ltr
                    ? const BorderRadius.horizontal(left: Radius.circular(12.0))
                    : const BorderRadius.horizontal(right: Radius.circular(12.0))),
            child: Padding(
              padding: const EdgeInsets.all(defaultMobilePadding),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    wallet.icon,
                    alignment: Alignment.center,
                    width: 20,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: FittedBox(
                      child: Text(
                        wallet.walletName,
                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                        // overflow: TextOverflow.ellipsis,
                        textWidthBasis: TextWidthBasis.longestLine,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ),

                  // SvgPicture.asset(
                  //   wallet.issuerLogo!,
                  //   alignment: Alignment.center,
                  //   width: 20,
                  // ),
                ],
              ),
            ),
          ),
          // RotatedBox(
          //     quarterTurns: 3,
          //     child: Row(
          //       children: [
          //         SvgPicture.asset(
          //           wallet.svgPath,
          //           alignment: Alignment.center,
          //           width: 20,
          //           color: Colors.black,
          //         ),
          //         const SizedBox(width: defaultPadding),
          //         Flexible(
          //             fit: FlexFit.tight,
          //             child: Text(
          //               wallet.walletName,
          //               style: AxleTextStyle.labelLarge.copyWith(color: Colors.black, fontWeight: FontWeight.w800),
          //               // overflow: TextOverflow.ellipsis,
          //               textWidthBasis: TextWidthBasis.longestLine,
          //               maxLines: 1,
          //               softWrap: false,
          //             )),
          //       ],
          //     )),
          // const SizedBox(width: defaultPadding),
          Expanded(
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.all(defaultMobilePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FittedBox(
                      child: Text(axleCurrencyFormatterwithDecimals.format(wallet.balance),
                          style: AxleTextStyle.headlineMedium.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    // const SizedBox(height: defaultPadding * 2),
                    if (wallet.walletName == 'PPI Corporate')
                      AccountInfoWidget(
                          accountNumber: wallet.accountNumber, ifscCode: wallet.ifscCode, upiId: 'PPICorporate@Mobile'),
                    if (wallet.walletName != 'PPI Corporate') Text(wallet.upiId, style: AxleTextStyle.labelSmall),
                    if (wallet.walletName != 'PPI Corporate')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // upi.contains('FASTag') || upi.contains('Prepaid')
                          //     ? const SizedBox()
                          //     :
                          IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: const Icon(Icons.copy, color: AxleColors.axlePrimaryColor),
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(text: wallet.upiId));
                              Snackbar.success("UPI Id is copied to Clipboard.");
                            },
                          ),
                          // const SizedBox(width: 1.0),
                          // upi.contains('FASTag') || upi.contains('Prepaid')
                          //     ? const SizedBox()
                          //     :
                          IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: const Icon(Icons.qr_code, color: AxleColors.axlePrimaryColor),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => QRPopUpWidget(
                                  upiId: wallet.upiId,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(defaultMobilePadding),
                  child: Image.asset(
                    wallet.issuerLogo,
                    height: 15,
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class MobileWalletSideCard extends StatelessWidget {
  const MobileWalletSideCard({required this.wallet, super.key, this.alignment = Alignment.centerLeft});
  final WalletDisplayModel wallet;
  final Alignment alignment;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      // constraints: BoxConstraints(maxWidth: 100),
      // width: MediaQuery.of(context).size.width * 10 / 100,
      alignment: alignment,
      // margin: const EdgeInsets.symmetric(horizontal: defaultMobilePadding, vertical: 10.0),
      padding: const EdgeInsets.all(defaultMobilePadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: wallet.walletColor.withOpacity(0.2), // Color.fromARGB(255, 164, 20, 20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2), blurRadius: 5.0, spreadRadius: 0.4, offset: const Offset(0, 2)),
        ],
      ),
      child: RotatedBox(
          quarterTurns: 3,
          child: Row(
            children: [
              SvgPicture.asset(wallet.icon, alignment: Alignment.center, width: 20),
              const SizedBox(width: defaultPadding),
              Text(wallet.walletName, style: AxleTextStyle.headlineLarge.copyWith(color: Colors.black)),
            ],
          )),
    );
  }
}
