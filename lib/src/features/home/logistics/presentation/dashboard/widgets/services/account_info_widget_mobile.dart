import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/upi_widget.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountInfoWidgetMobile extends StatelessWidget {
  final String accountNumber;
  final String ifscCode;
  final String upiId;
  const AccountInfoWidgetMobile({
    super.key,
    required this.accountNumber,
    required this.ifscCode,
    this.upiId = '',
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Account Info", style: AxleTextStyle.titleMedium),
        SizedBox(height: isMobile ? defaultMobilePadding : defaultPadding),
        Text("Account Number :", style: AxleTextStyle.labelLarge.copyWith(color: Colors.black)),
        const SizedBox(width: defaultMobilePadding),
        Row(
          children: [
            Text(accountNumber, style: AxleTextStyle.walletBalanceText.copyWith(color: Colors.black)),
            const SizedBox(width: defaultMobilePadding),
            IconButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: accountNumber));
                Snackbar.success("Copied to Clipboard.");
              },
              icon: const Icon(Icons.copy, size: 24, color: Color.fromRGBO(128, 159, 184, 1)),
            ),
          ],
        ),
        Text("IFSC Code :", style: AxleTextStyle.labelLarge.copyWith(color: Colors.black)),
        const SizedBox(width: defaultMobilePadding),
        Row(
          children: [
            Text(ifscCode, style: AxleTextStyle.walletBalanceText.copyWith(color: Colors.black)),
            const SizedBox(width: defaultMobilePadding),
            IconButton(
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(text: ifscCode),
                );
                Snackbar.success("Copied to Clipboard.");
              },
              icon: const Icon(Icons.copy, size: 24, color: Color.fromRGBO(128, 159, 184, 1)),
            ),
          ],
        ),
        if (upiId.isNotEmpty) UpiWidget(upi: upiId, isAccountInfo: true),
      ],
    );
  }
}
