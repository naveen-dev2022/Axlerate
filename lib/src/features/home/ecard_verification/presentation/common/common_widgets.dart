import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../Themes/text_style_config.dart';

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

class ECardVerificationWidgets {
  static Widget drawHistoryListTileWidget(
      {required Function()? onTap,
      required String? title,
      required String? number,
      required String? subTitle}) {
    return ListTile(
      onTap: onTap,
      title: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title ?? "",
              style: AxleTextStyle.poppins12w400.copyWith(
                color: const Color(0xff8B9197),
              ),
            ),
            TextSpan(
              text: number ?? "",
              style: AxleTextStyle.poppins12w400.copyWith(
                color: const Color(0xff252525),
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(
        subTitle ?? "",
        style: AxleTextStyle.poppins12w400.copyWith(
          color: const Color(0xff8B9197),
        ),
      ),
      trailing: Container(
        height: 22,
        width: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AxleColors.axlePrimaryColor, width: 1.5),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_forward,
            color: AxleColors.axleSecondaryColor,
            size: 14,
          ),
        ),
      ),
    );
  }

  static Widget drawHistoryCardWidget(
      {required String iconData, required String heading}) {
    return Container(
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
            iconData,
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 18,
          ),
          Text(
            heading,
            style: AxleTextStyle.poppins12w500,
          )
        ],
      ),
    );
  }

  static Widget drawLogoWidget({required BuildContext context}) {
    return Positioned(
      bottom: 20,
      left: MediaQuery.of(context).size.width / 2 - 120 / 2,
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        width: 100,
        height: 25,
      ),
    );
  }

  static Widget drawBGStackImageWidget({required BuildContext context}) {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SvgPicture.asset(
          'assets/images/bg_stack.svg',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  static Widget buildKeyValue({required String key, required String? value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              key,
              style: AxleTextStyle.poppins12w400,
            ),
            const SizedBox(
              width: 25,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                value ?? "",
                softWrap: false,
                overflow: TextOverflow.fade,
                style: AxleTextStyle.poppins12w500,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  static Widget detailHeadingCard({
    required String icon,
    required String? title,
    required String? subTitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 10),
            blurRadius: 25,
            spreadRadius: 0,
          ),
        ],
        color: Colors.white,
        border: Border.all(
          color: AxleColors.axleSecondaryColor,
          width: 1.5,
        ),
      ),
      child: ListTile(
        leading: SvgPicture.asset(icon),
        title: Text(
          title ?? "",
          style: AxleTextStyle.poppins12w400,
        ),
        subtitle: Text(
          subTitle ?? "",
          style: AxleTextStyle.poppins16w400
              .copyWith(color: const Color(0xff252525)),
        ),
      ),
    );
  }
}
