import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/src/features/home/ecard_verification/domain/ecard_category_model.dart';
import 'package:axlerate/src/features/home/ecard_verification/presentation/home/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../router/route_utils.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/widgets/grid_view_builder.dart';

void findRoute({required String value, required BuildContext context}) {
  switch (value) {
    case "assets/images/challan.svg":
      {
        context.router.pushNamed(RouteUtils.getChallanPath());
      }
      break;
    case "Aadhar\nVerification":
      {
        context.router.pushNamed(RouteUtils.getAadhaarPath());
      }
      break;
    case "PAN\nVerification":
      {
        context.router.pushNamed(RouteUtils.getPanPath());
      }
      break;
    case "Vehicle RC\nVerification":
      {
        context.router.pushNamed(RouteUtils.getRcPath());
      }
      break;
    case "Driver License\nVerification":
      {
        context.router.pushNamed(RouteUtils.getDrivingLicensePath());
      }
      break;
    case "assets/images/css_home.svg":
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

Widget navigationButton({required Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: AxleColors.axlePrimaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(Icons.arrow_forward_ios, color: AxleColors.axleWhite),
    ),
  );
}

Widget infoWidget() {
  return FittedBox(
    child: Container(
      decoration: BoxDecoration(
        color: AxleColors.axleBgYellow,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AxleColors.axleSecondaryColor),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 25,
          ),
          SvgPicture.asset('assets/images/info.svg'),
          const SizedBox(
            width: 6,
          ),
          Text(
            'You can check your details once every 3 months',
            style: AxleTextStyle.sfPro13w400,
          ),
          const SizedBox(
            width: 25,
          ),
        ],
      ),
    ),
  );
}

@RoutePage()
class EcardVerificationDashboard extends ConsumerStatefulWidget {
  const EcardVerificationDashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<EcardVerificationDashboard> createState() =>
      _EcardVerificationDashboardState();
}

class _EcardVerificationDashboardState
    extends ConsumerState<EcardVerificationDashboard> {
  TextEditingController searchTextController = TextEditingController();
  bool isMobile = false;

  final verifyDetails = [
    ECardCategoryModel(
      title: 'Vehicle RC\nVerification',
      imageUrl: 'assets/images/rc.svg',
      borderColor: const Color(0xff105AAC),
      bgColor: const Color(0xffEFF7FF),
    ),
    ECardCategoryModel(
      title: 'Driver License\nVerification',
      imageUrl: 'assets/images/license.svg',
      borderColor: const Color(0xffF3C521),
      bgColor: const Color(0xffFFF9E4),
    ),
    ECardCategoryModel(
      title: 'Aadhar\nVerification',
      imageUrl: 'assets/images/aadhar.svg',
      borderColor: const Color(0xff7442CE),
      bgColor: const Color(0xffF3EDFF),
    ),
    ECardCategoryModel(
      title: 'PAN\nVerification',
      imageUrl: 'assets/images/pan.svg',
      borderColor: const Color(0xffD16BAB),
      bgColor: const Color(0xffFFF3FB),
    ),
  ];

  final information = [
    ECardCategoryModel(
      title: '',
      imageUrl: 'assets/images/challan.svg',
    ),
    ECardCategoryModel(
      title: '',
      imageUrl: 'assets/images/css_home.svg',
    ),
  ];

  Widget enterOtpTextBar() {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0x0F000000),
          offset: Offset(0, 10),
          blurRadius: 22,
          spreadRadius: 0,
        ),
      ]),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return TextField(
            controller: searchTextController,
            onSubmitted: ((value) {}),
            onChanged: (v) {},
            onTap: () {
              context.router.pushNamed(RouteUtils.getECardSearch());
            },
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: AxleTextStyle.poppins16w400,
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0x5c3a3a3a),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: isMobile
              ? const EdgeInsets.symmetric(horizontal: defaultPadding)
              : const EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 22,
                ),
                enterOtpTextBar(),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Verify Details",
                  style: AxleTextStyle.poppins14w500,
                ),
                const SizedBox(
                  height: 16,
                ),
                GridViewBuilder(
                  itemCount: verifyDetails.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return FittedBox(
                      child: DashboardCard(
                        title: verifyDetails[index].title,
                        image: verifyDetails[index].imageUrl,
                        bgColor: verifyDetails[index].bgColor,
                        borderColor: verifyDetails[index].borderColor,
                      ),
                    );
                  },
                  constrain: constraints,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 0,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Information",
                  style: AxleTextStyle.headingPrimary,
                ),
                GridViewBuilder(
                  itemCount: information.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        findRoute(
                          value: information[index].imageUrl,
                          context: context,
                        );
                      },
                      child: SvgPicture.asset(
                        information[index].imageUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  },
                  constrain: constraints,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 0,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
