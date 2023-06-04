import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VehicleFundLoadCard extends ConsumerWidget {
  const VehicleFundLoadCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.balance,
    required this.borderColor,
    required this.textColor,
    required this.assetName,
  });

  final String title;
  final String subtitle;
  final String balance;
  final Color borderColor;
  final Color textColor;
  final String assetName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: 350.0,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.2,
          color: borderColor,
        ),
        color: const Color(0xffF1EFF8),
      ),
      // * From Card Column
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AxleTextStyle.walletBalanceText,
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    balance,
                    style: isMobile
                        ? AxleTextStyle.authScreenHeadingStyle.copyWith(color: Colors.black, fontSize: 25)
                        : AxleTextStyle.authScreenHeadingStyle.copyWith(color: Colors.black),
                  ),
                  Text(
                    subtitle,
                    style: AxleTextStyle.walletBalanceText,
                  ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              SvgPicture.asset(
                assetName,
                width: 62,
                height: 62,
              ),
            ],
          )
        ],
      ),
    );
  }
}
