import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../common/common_widgets.dart';

@RoutePage()
class ChallanHistory extends StatefulWidget {
  const ChallanHistory({Key? key}) : super(key: key);

  @override
  State<ChallanHistory> createState() => _ChallanHistoryState();
}

class _ChallanHistoryState extends State<ChallanHistory> {
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      body: Column(
        children: [
          DynamicVerificationCard(
            onTap: () {},
            imageUrl: 'assets/images/challan_home_big.svg',
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
                          heading: 'Challan Information',
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text('Previous Searches'),
                      ECardVerificationWidgets.drawHistoryListTileWidget(
                        onTap: () {},
                        title: 'Vehicle Registration Number:',
                        subTitle: '19 May, 2023',
                        number: ' TN38CH1948',
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
