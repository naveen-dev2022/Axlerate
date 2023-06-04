import 'package:axlerate/src/features/home/dashboard/presentation/dashboard.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/account_info_widget.dart';
import 'package:axlerate/src/features/home/logistics/presentation/logistics_mobile_dashboard.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/logistics_dashboard_services.dart';
import 'package:axlerate/src/features/home/logistics/presentation/dashboard/widgets/services/upi_widget.dart';
import 'package:axlerate/src/utils/currency_format.dart';

class BalanceWidget extends StatelessWidget {
  BalanceWidget({
    super.key,
    required this.wallet,
    required this.type,
    this.showCustomerCount = true,
  });

  final WalletDisplayModel wallet;
  final DashboardServicesType type;
  final bool showCustomerCount;
  final formatCurrency = axleCurrencyFormatterwithDecimals;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (wallet.walletName != "") Text(wallet.walletName, style: AxleTextStyle.bodyLarge),
        Text("Wallet Balance", style: AxleTextStyle.labelSmall.copyWith(color: Colors.black)),
        Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(formatCurrency.format(wallet.balance.floor()),
                  style: AxleTextStyle.headlineLarge.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
              Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("Available", style: AxleTextStyle.labelSmall.copyWith(color: Colors.black)))
            ]),
        SizedBox(height: isMobile ? 0 : verticalPadding),
        if (type == DashboardServicesType.fastag && showCustomerCount)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Balance Type", style: AxleTextStyle.walletBalanceText),
              const SizedBox(height: 8),
              balanceLevelCardWithValue("Customer Level", wallet.customerLevelCount.toString()),
              const SizedBox(height: 8),
              balanceLevelCardWithValue("Vehicle Level", wallet.vehicleLevelCount.toString()),
              SizedBox(height: isMobile ? 0 : verticalPadding),
            ],
          ),
        if ((type == DashboardServicesType.fuel) || (type == DashboardServicesType.ppi))
          AccountInfoWidget(
            accountNumber: wallet.accountNumber,
            ifscCode: wallet.ifscCode,
          ),
        if (type == DashboardServicesType.fastag)
          UpiWidget(
            upi: wallet.upiId,
          ),
      ],
    );
  }

  Container balanceLevelCardWithValue(String label, String value) {
    return Container(
      height: 30,
      width: 200,
      // color: Colors.red,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: const Color.fromRGBO(227, 234, 239, 1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: 30,
          width: 150,
          // color: Colors.red,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.white),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                label,
                style: AxleTextStyle.walletBalanceType,
              ),
            ),
            Container(
              height: 30,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(6), color: const Color.fromRGBO(227, 234, 239, 1)),
              child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      value,
                      style: AxleTextStyle.headline6BlackStyle,
                    ),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
