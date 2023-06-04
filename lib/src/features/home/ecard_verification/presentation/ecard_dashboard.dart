import 'package:auto_route/annotations.dart';
import 'package:axlerate/src/features/home/ecard_verification/domain/ecard_category_model.dart';
import 'package:axlerate/src/features/home/ecard_verification/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../Themes/axle_colors.dart';
import '../../../../../Themes/text_style_config.dart';
import '../../../../../responsive.dart';
import '../../../../../values/constants.dart';

@RoutePage()
class EcardVerificationDashboard extends ConsumerStatefulWidget {
  const EcardVerificationDashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<EcardVerificationDashboard> createState() =>
      _EcardVerificationDashboardState();
}

class _EcardVerificationDashboardState
    extends ConsumerState<EcardVerificationDashboard> {

  bool isMobile = false;
  final data = [
    ECardCategoryModel(
      title: 'Challan',
      imageUrl: '',
    ),
    ECardCategoryModel(
      title: 'Aadhaar',
      imageUrl: '',
    ),
    ECardCategoryModel(
      title: 'PAN',
      imageUrl: '',
    ),
    ECardCategoryModel(
      title: 'RC',
      imageUrl: '',
    ),
    ECardCategoryModel(
      title: 'Driving License',
      imageUrl: '',
    ),
    ECardCategoryModel(
      title: 'CIBIL',
      imageUrl: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: AxleColors.axleBackgroundColor,
        body: Padding(
          padding: isMobile
              ? const EdgeInsets.symmetric(horizontal: defaultPadding)
              : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding),
                  child: Text(
                    "E-Card Verification",
                    style: AxleTextStyle.headingPrimary,
                  ),
                ),
                Wrap(
                  runSpacing: defaultPadding,
                  spacing: defaultPadding,
                  children: data.map((item) => ECardItem(item: item)).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
