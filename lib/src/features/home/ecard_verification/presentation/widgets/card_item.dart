import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../Themes/common_style_util.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../router/route_utils.dart';
import '../../../../../../values/constants.dart';
import '../../../../../common/common_widgets/axle_primary_button.dart';
import '../../domain/ecard_category_model.dart';

class ECardItem extends ConsumerStatefulWidget {
  const ECardItem({Key? key, required this.item}) : super(key: key);

  final ECardCategoryModel item;

  @override
  ConsumerState<ECardItem> createState() => _ECardItemState();
}

class _ECardItemState extends ConsumerState<ECardItem> {
  double screenWidth = 0.0;

  double availableWidth = 0.0;

  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);
    availableWidth = screenWidth - (defaultPadding * 2);

    return Container(
      width: isMobile ? availableWidth : 250,
      decoration: CommonStyleUtil.axleListingCardDecoration,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.account_balance_sharp,
            size: 60,
            color: Colors.blueGrey,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(widget.item.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: AxleTextStyle.titleMedium.copyWith(color: Colors.black)),
          const SizedBox(
            height: 16,
          ),
          AxlePrimaryButton(
            buttonHeight: 40,
            buttonText: 'More',
            onPress: () {
              findRoute(
                value: widget.item.title,
                context: context,
              );
            },
          ),
        ],
      ),
    );
  }
}

void findRoute({required String value, required BuildContext context}) {
  switch (value) {
    case "Challan":
      {
        context.router.pushNamed(RouteUtils.getChallanPath());
      }
      break;

    case "Aadhaar":
      {
        context.router.pushNamed(RouteUtils.getAadhaarPath());
      }
      break;

    case "PAN":
      {
        context.router.pushNamed(RouteUtils.getPanPath());
      }
      break;

    case "RC":
      {
        context.router.pushNamed(RouteUtils.getRcPath());
      }
      break;

    case "Driving License":
      {
        context.router.pushNamed(RouteUtils.getDrivingLicensePath());
      }
      break;
    case "CIBIL":
      {
        context.router.pushNamed(RouteUtils.getCbilScorePath());
      }
      break;

    default:
      {
        //statements;
      }
      break;
  }
}
