import 'package:auto_route/auto_route.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../responsive.dart';
import '../common/dynamic_verification_card.dart';

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
                  Positioned(
                    bottom: 20,
                    left: MediaQuery.of(context).size.width / 2 - 120 / 2,
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 100,
                      height: 25,
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
                              SvgPicture.asset(
                                'assets/images/aadhar.svg',
                                width: 25,
                                height: 25,
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              const Text('Aadhar Verification')
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
                          'Aadhar Card Number: XXXX XXXX 1234',
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
