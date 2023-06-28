import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../common/common_widgets.dart';

@RoutePage()
class CreditScoreHistory extends StatefulWidget {
  const CreditScoreHistory({Key? key}) : super(key: key);

  @override
  State<CreditScoreHistory> createState() => _CreditScoreHistoryState();
}

class _CreditScoreHistoryState extends State<CreditScoreHistory> {
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      body: Column(
        children: [
          DynamicVerificationCard(
            onTap: () {},
            imageUrl: 'assets/images/cibil_history.svg',
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
                          iconData: 'assets/images/challan_icon.svg',
                          heading: 'Credit Score Search History',
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
                        title: 'Vehicle Registration Number: ',
                        subTitle: '19 May, 2023',
                        number: 'TN38CH1948',
                      ),
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