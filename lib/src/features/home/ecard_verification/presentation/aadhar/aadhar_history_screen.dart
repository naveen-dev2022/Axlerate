import 'package:auto_route/auto_route.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import '../../../../../../responsive.dart';
import '../common/common_widgets.dart';

@RoutePage()
class AadharHistoryScreen extends StatefulWidget {
  const AadharHistoryScreen({Key? key}) : super(key: key);

  @override
  State<AadharHistoryScreen> createState() => _DrHistoryState();
}

class _DrHistoryState extends State<AadharHistoryScreen> {
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      body: Column(
        children: [
          DynamicVerificationCard(
            onTap: () {},
            imageUrl: 'assets/images/aadhar_history.svg',
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
                          iconData: 'assets/images/aadhar.svg',
                          heading: 'Aadhar Verification',
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text('Previous Searches'),
                      ECardVerificationWidgets.drawHistoryListTileWidget(
                        onTap: () {},
                        title: 'Aadhar Card Number:',
                        subTitle: '19 May, 2023',
                        number: ' XXXX XXXX 1234',
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
