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
            Container(
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
                leading: SvgPicture.asset('assets/images/rc_detail.svg'),
                title: const Text('PAN Card Number'),
                subtitle: Text("${data?.idNumber}"),
              ),
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
                  const Text('PAN Card Details'),
                  const SizedBox(
                    height: 12,
                  ),
                  _buildKeyValue(
                      key: 'PAN Holder Full Name', value: data?.fullName ?? ""),
                  _buildKeyValue(
                      key: 'PAN Status', value: data?.panStatus ?? ""),
                  _buildKeyValue(
                      key: 'Aadhar Linking Status',
                      value: data?.aadhaarSeedingStatus ?? ""),
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

  Widget _buildKeyValue({required String key, required String value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(key),
            const SizedBox(
              width: 25,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                value,
                softWrap: false,
                overflow: TextOverflow.fade,
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
}
