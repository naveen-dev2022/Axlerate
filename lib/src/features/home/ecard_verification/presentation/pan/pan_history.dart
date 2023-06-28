import 'package:auto_route/auto_route.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../common/common_widgets.dart';

@RoutePage()
class PanHistoryScreen extends StatefulWidget {
  const PanHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PanHistoryScreen> createState() => _PanHistoryScreenState();
}

class _PanHistoryScreenState extends State<PanHistoryScreen> {
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      body: Column(
        children: [
          DynamicVerificationCard(
            onTap: () {},
            imageUrl: 'assets/images/pan_history.svg',
            showHistoryIcon: false,
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              padding: isMobile
                  ? const EdgeInsets.symmetric(horizontal: defaultPadding)
                  : const EdgeInsets.symmetric(
                      horizontal: horizontalPadding, vertical: verticalPadding),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ECardVerificationWidgets.drawBGStackImageWidget(
                    context: context,
                  ),
                  ECardVerificationWidgets.drawLogoWidget(context: context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ECardVerificationWidgets.drawHistoryCardWidget(
                          iconData: 'assets/images/pan.svg',
                          heading: 'PAN Verification',
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        'Previous Searches',
                        style: AxleTextStyle.poppins12w500liteGrey,
                      ),
                      ECardVerificationWidgets.drawHistoryListTileWidget(
                          onTap: () {},
                          title: 'PAN Card Number: ',
                          subTitle: '19 May, 2023',
                          number: 'LIHPS5643H'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
