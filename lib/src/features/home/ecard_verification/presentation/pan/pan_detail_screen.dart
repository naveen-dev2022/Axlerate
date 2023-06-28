import 'package:auto_route/annotations.dart';
import 'package:axlerate/src/features/home/ecard_verification/presentation/rc_screen/rc_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../Themes/common_style_util.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/axle_loader.dart';
import '../../../../../utils/string_operations.dart';
import '../../domain/pan_entity.dart';
import '../common/common_widgets.dart';
import '../controller/ecard_controller.dart';

@RoutePage()
class PanScreen extends ConsumerStatefulWidget {
  const PanScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PanScreen> createState() => _PanScreenState();
}

class _PanScreenState extends ConsumerState<PanScreen> {
  bool isMobile = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(panStateProvider.notifier).state = null;
      ref.read(panStateProvider.notifier).state = await ref
          .read(eCardControllerProvider)
          .fetchPanDetailsData(idNumber: '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);
    final panDataList = ref.watch(panStateProvider);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: panDataList == null
          ? AxleLoader.axleProgressIndicator()
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  ECardVerificationWidgets.drawBGStackImageWidget(
                    context: context,
                  ),
                  ECardVerificationWidgets.drawLogoWidget(context: context),
                  _buildPanDetail(panDataList)
                ],
              ),
            ),
    );
  }

  Widget _buildPanDetail(PanEntity? panDataList) {
    final data = panDataList!.data;
    return Padding(
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: defaultPadding)
          : const EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            ECardVerificationWidgets.detailHeadingCard(
              icon: 'assets/images/rc_detail.svg',
              title: 'PAN Card Number',
              subTitle: data?.idNumber,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    offset: Offset(0, 10),
                    blurRadius: 25,
                    spreadRadius: 0,
                  ),
                ],
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PAN Card Details',
                    style: AxleTextStyle.poppins14w500Blue,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'PAN Holder Full Name',
                    value: data?.fullName,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'PAN Status',
                    value: data?.panStatus,
                  ),
                  ECardVerificationWidgets.buildKeyValue(
                    key: 'Aadhar Linking Status',
                    value: data?.aadhaarSeedingStatus,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
