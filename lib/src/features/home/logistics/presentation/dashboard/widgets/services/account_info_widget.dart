import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/upi_widget.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountInfoWidget extends StatelessWidget {
  final String accountNumber;
  final String ifscCode;
  final String upiId;
  const AccountInfoWidget({
    super.key,
    required this.accountNumber,
    required this.ifscCode,
    this.upiId = '',
  });

  @override
  Widget build(BuildContext context) {
    // bool isMobile = Responsive.isMobile(context);

    bool isMobileDash = upiId == 'PPICorporate@Mobile';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobileDash) Text("Account Info", style: AxleTextStyle.titleMedium),
        //const SizedBox(height: defaultMobilePadding),
        Row(
          children: [
            Text(isMobileDash ? "Acc. No.:" : "Account Number :",
                style:
                    isMobileDash ? AxleTextStyle.labelSmall : AxleTextStyle.labelLarge.copyWith(color: Colors.black)),
            SizedBox(width: isMobileDash ? 4 : defaultMobilePadding),
            Text(accountNumber,
                style: isMobileDash
                    ? AxleTextStyle.labelSmall
                    : AxleTextStyle.walletBalanceText.copyWith(color: Colors.black)),
            if (!isMobileDash) const SizedBox(width: defaultMobilePadding),
            IconButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: accountNumber));
                Snackbar.success("Copied to Clipboard.");
              },
              icon: Icon(Icons.copy,
                  size: 24, color: isMobileDash ? primaryColor : const Color.fromRGBO(128, 159, 184, 1)),
            ),
          ],
        ),
        Row(
          children: [
            Text(isMobileDash ? "IFSC:" : "IFSC Code :",
                style:
                    isMobileDash ? AxleTextStyle.labelSmall : AxleTextStyle.labelLarge.copyWith(color: Colors.black)),
            SizedBox(width: isMobileDash ? 4 : defaultMobilePadding),
            Text(ifscCode,
                style: isMobileDash
                    ? AxleTextStyle.labelSmall
                    : AxleTextStyle.walletBalanceText.copyWith(color: Colors.black)),
            if (!isMobileDash) const SizedBox(width: defaultMobilePadding),
            IconButton(
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(text: ifscCode),
                );
                Snackbar.success("Copied to Clipboard.");
              },
              icon: Icon(Icons.copy,
                  size: 24, color: isMobileDash ? primaryColor : const Color.fromRGBO(128, 159, 184, 1)),
            ),
          ],
        ),
        if (upiId.isNotEmpty && !isMobileDash) UpiWidget(upi: upiId, isAccountInfo: true),
      ],
    );
  }
}
