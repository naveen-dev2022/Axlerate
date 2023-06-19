import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../common/dynamic_verification_card.dart';

@RoutePage()
class RcHistoryScreen extends StatefulWidget {
  const RcHistoryScreen({Key? key}) : super(key: key);

  @override
  State<RcHistoryScreen> createState() => _RcHistoryScreenState();
}

class _RcHistoryScreenState extends State<RcHistoryScreen> {
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    return Scaffold(
      body: Column(
        children: [
          DynamicVerificationCard(
            onTap: () {},
            imageUrl: 'assets/images/rc_history.svg',
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
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SvgPicture.asset(
                        'assets/images/bg_stack.svg',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AxleColors.axleWhite,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0F000000),
                                offset: Offset(0, 4),
                                blurRadius: 30,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/rc.svg'),
                              const SizedBox(
                                width: 18,
                              ),
                              const Text('Vehicle RC Verification')
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text('Previous Searches'),
                      const SizedBox(
                        height: 18,
                      ),
                      ListTile(
                        title: const Text(
                          'Vehicle Registration Number: TN38CH1948',
                        ),
                        subtitle: const Text(
                          '19 May, 2023',
                        ),
                        trailing: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: AxleColors.axlePrimaryColor, width: 1.5),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_forward,
                              color: AxleColors.axleSecondaryColor,
                              size: 14,
                            ),
                          ),
                        ),
                      )
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
