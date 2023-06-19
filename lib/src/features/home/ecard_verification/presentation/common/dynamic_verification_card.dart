import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../Themes/axle_colors.dart';

class DynamicVerificationCard extends StatelessWidget {
  const DynamicVerificationCard(
      {Key? key,
      required this.onTap,
      required this.imageUrl,
      this.showHistoryIcon = true})
      : super(key: key);

  final Function() onTap;
  final String imageUrl;
  final bool showHistoryIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: AxleColors.axlePrimaryColor,
      ),
      child: FittedBox(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            showHistoryIcon
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 12,
                        ),
                        child: GestureDetector(
                          onTap: onTap,
                          child: SvgPicture.asset(
                            'assets/images/history.svg',
                            height: 20,
                            width: 20,
                          ),
                        ),
                      )
                    ],
                  )
                : const SizedBox.shrink(),
            SvgPicture.asset(
              imageUrl,
              height: 230,
              width: 263,
            ),
            const SizedBox(
              height: 19,
            ),
          ],
        ),
      ),
    );
  }
}
