import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/src/common/common_widgets/axle_text_with_bg.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:axlerate/Themes/text_style_config.dart';

class LqTagVehicleDetailsWidget extends StatelessWidget {
  const LqTagVehicleDetailsWidget({
    super.key,
    required this.vehicleRegNo,
    required this.lqftSerialNo,
    required this.tagStatus,
    required this.walletBalance,
    required this.balanceType,
  });

  final String vehicleRegNo;
  final String lqftSerialNo;
  final String tagStatus;
  final int walletBalance;
  final String balanceType;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(vehicleRegNo, style: AxleTextStyle.titleLarge),
          const SizedBox(height: defaultPadding),
          Text(lqftSerialNo, style: AxleTextStyle.titleMedium),
          const SizedBox(height: defaultPadding),
          Row(
            children: [Text("Vehicle Wallet Balance", style: AxleTextStyle.titleSmall.copyWith(color: Colors.black))],
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(axleCurrencyFormatterwithDecimals.format(walletBalance),
                style: AxleTextStyle.displaySmall.copyWith(color: Colors.black)),
            const SizedBox(width: defaultMobilePadding / 2),
            Padding(
              padding: const EdgeInsets.all(defaultMobilePadding),
              child: Text("Available", style: AxleTextStyle.labelSmall.copyWith(color: Colors.grey)),
            )
          ]),
          const SizedBox(height: defaultPadding),
          AxleTextWithBg(text: "This vehicle is under $balanceType", textColor: primaryColor)
        ]);
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
