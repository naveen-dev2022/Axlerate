// ignore_for_file: must_be_immutable

import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UpiWidget extends StatelessWidget {
  UpiWidget({
    Key? key,
    this.isAccountInfo = false,
    required this.upi,
  }) : super(key: key);

  final String upi;
  bool isAccountInfo;
  bool isMobile = false;
  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return isAccountInfo
        ? isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [label("UPI ID:"), const SizedBox(width: defaultMobilePadding), value(context)],
              )
            : Row(
                children: [label("UPI ID:"), const SizedBox(width: defaultMobilePadding), value(context)],
              )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [label("UPI ID"), value(context)],
          );
  }

  Widget value(BuildContext context) {
    return isMobile
        ? SizedBox(
            height: 80,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isAccountInfo ? upiValue() : expandedUpiValue(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: upi));
                          Snackbar.success("Copied to Clipboard.");
                        },
                        icon: const Icon(Icons.copy, size: 24, color: Color.fromRGBO(128, 159, 184, 1))),
                    IconButton(
                        onPressed: () {
                          showDialog(context: context, builder: (_) => QRPopUpWidget(upiId: upi));
                        },
                        icon: const Icon(Icons.qr_code_scanner_outlined,
                            size: 24, color: Color.fromRGBO(128, 159, 184, 1))),
                  ],
                ),
              ],
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              isAccountInfo ? upiValue() : expandedUpiValue(),
              IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: upi));
                    Snackbar.success("Copied to Clipboard.");
                  },
                  icon: const Icon(Icons.copy, size: 24, color: Color.fromRGBO(128, 159, 184, 1))),
              IconButton(
                  onPressed: () {
                    showDialog(context: context, builder: (_) => QRPopUpWidget(upiId: upi));
                  },
                  icon: const Icon(Icons.qr_code_scanner_outlined, size: 24, color: Color.fromRGBO(128, 159, 184, 1))),
            ],
          );
  }

  Widget upiValue() => Text(upi, style: AxleTextStyle.walletBalanceText.copyWith(color: Colors.black));

  Widget expandedUpiValue() =>
      Expanded(child: Text(upi, style: AxleTextStyle.labelMedium.copyWith(color: AxleColors.iconColor)));

  Widget label(String labelText) => Text(labelText, style: AxleTextStyle.labelLarge.copyWith(color: Colors.black));
}

class QRPopUpWidget extends StatelessWidget {
  const QRPopUpWidget({
    Key? key,
    required this.upiId,
  }) : super(key: key);

  final String upiId;

  @override
  Widget build(BuildContext context) {
    String qrStr = "upi://pay?cu=INR&pa=$upiId&pn=For%20FASTag";
    return AlertDialog(
      title: const Text("QR CODE"),
      content: SizedBox(
        // height: 500,
        width: 500,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          QrImageView(
            padding: const EdgeInsets.all(0.0),
            data: qrStr,
            version: QrVersions.auto,
            size: 350,
          ),
          Text("Paying to UPI Id : $upiId"),
          // AxleOutlineButton(
          //   buttonText: "OpenApp",
          //   onPress: () async {
          //     if (!await launchUrl(
          //         Uri(scheme: 'upi', host: 'pay', queryParameters: {'cu': 'INR', 'pa': upiId, 'pn': 'For FASTag'}))) {
          //       throw Exception('Could not launch $qrStr');
          //     }
          //   },
          // )
        ]),
      ),
    );
  }
}
