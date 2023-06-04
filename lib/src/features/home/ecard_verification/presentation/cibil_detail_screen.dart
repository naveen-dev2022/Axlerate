import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../Themes/axle_colors.dart';
import '../../../../../Themes/common_style_util.dart';
import '../../../../../Themes/text_style_config.dart';
import '../../../../../responsive.dart';
import '../../../../../values/constants.dart';
import '../../../../utils/axle_loader.dart';
import '../domain/cibil_detail_entity.dart';
import 'controller/ecard_controller.dart';

@RoutePage()
class CibilScreen extends ConsumerStatefulWidget {
  const CibilScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CibilScreen> createState() => _CibilScreenState();
}

class _CibilScreenState extends ConsumerState<CibilScreen> {
  double screenWidth = 0.0;
  bool isMobile = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(cbilStateProvider.notifier).state = null;
      ref.read(cbilStateProvider.notifier).state =
          await ref.read(eCardControllerProvider).fetchCibilData(
                fName: '',
                lName: '',
                phoneNumber: '',
                panNum: '',
              );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);

    final CibilDetailEntity? cibilDetailEntity = ref.watch(cbilStateProvider);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: cibilDetailEntity == null
          ? AxleLoader.axleProgressIndicator()
          : _renderApiData(cibilDetailEntity),
    );
  }

  Widget _renderApiData(CibilDetailEntity? cibilDetailEntity) {
    return Padding(
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: defaultMobilePadding)
          : const EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Container(
          decoration: CommonStyleUtil.axleListingCardDecoration,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding,
                ),
                child: Text(
                  "CBIL Score",
                  style: AxleTextStyle.headingPrimary,
                ),
              ),
              Text('${cibilDetailEntity?.data?.toJson()}')],
          ),
        ),
      ),
    );
  }
}
