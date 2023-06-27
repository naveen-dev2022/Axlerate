import 'package:auto_route/auto_route.dart';
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
      height: MediaQuery.of(context).size.height / 2.7,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: AxleColors.axlePrimaryColor,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                ),
                child: IconButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              if (showHistoryIcon == true) ...[
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
              ] else ...[
                const SizedBox(
                  width: 5,
                )
              ]
            ],
          ),
          SvgPicture.asset(
            imageUrl,
            height: 200,
            width: 263,
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
