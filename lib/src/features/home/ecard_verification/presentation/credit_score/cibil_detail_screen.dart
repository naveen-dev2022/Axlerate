import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../../../Themes/axle_colors.dart';
import '../../../../../../Themes/common_style_util.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/axle_loader.dart';
import '../../domain/cibil_detail_entity.dart';
import '../controller/ecard_controller.dart';

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
    /*  WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(cbilStateProvider.notifier).state = null;
      ref.read(cbilStateProvider.notifier).state =
          await ref.read(eCardControllerProvider).fetchCibilData(
                fName: '',
                lName: '',
                phoneNumber: '',
                panNum: '',
              );
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);

    final CibilDetailEntity? cibilDetailEntity = ref.watch(cbilStateProvider);

    return Scaffold(
      backgroundColor: AxleColors.axlePrimaryColor,
      body: /*cibilDetailEntity == null
          ? AxleLoader.axleProgressIndicator()
          : _renderApiData(cibilDetailEntity),*/
          _renderApiData(cibilDetailEntity),
    );
  }

  Widget _renderApiData(CibilDetailEntity? cibilDetailEntity) {
    return Padding(
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: defaultMobilePadding)
          : const EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Container(
          color: AxleColors.axlePrimaryColor,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              _getRadialGauge(),
              const Text(
                'Your credit is in good shape',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              _getLinearGauge()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRadialGauge() {
    return SfRadialGauge(
        backgroundColor: AxleColors.axlePrimaryColor,
        // title: const GaugeTitle(
        //     text: '',
        //     textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 150,
            showAxisLine: false,
            showLabels: false,
            showTicks: false,
            axisLineStyle: const AxisLineStyle(
              cornerStyle: CornerStyle.bothCurve,
              thickness: 20,
            ),
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 60,
                color: Colors.red,
                // startWidth: 10,
                // endWidth: 10,
              ),
              GaugeRange(
                startValue: 60,
                endValue: 62,
                startWidth: 0,
                endWidth: 0,
                color: Colors.transparent,
              ),
              GaugeRange(
                startValue: 62,
                endValue: 70,
                color: Colors.yellow,
                // startWidth: 10,
                // endWidth: 10,
              ),
              GaugeRange(
                startValue: 70,
                endValue: 72,
                startWidth: 0,
                endWidth: 0,
                color: Colors.transparent,
              ),
              GaugeRange(
                startValue: 72,
                endValue: 80,
                color: Colors.green,
                // startWidth: 10,
                // endWidth: 10,
              ),
              GaugeRange(
                startValue: 80,
                endValue: 82,
                startWidth: 0,
                endWidth: 0,
                color: Colors.transparent,
              ),
              GaugeRange(
                startValue: 82,
                endValue: 120,
                color: Colors.green,
                // startWidth: 10,
                // endWidth: 10,
              )
            ],
            annotations: const <GaugeAnnotation>[
              GaugeAnnotation(
                verticalAlignment: GaugeAlignment.near,
                widget: Column(
                  children: [
                    Text(
                      '779',
                      style: TextStyle(
                        fontSize: 75,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'GOOD',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                angle: 120,
                positionFactor: 0.0,
              )
            ],
          )
        ]);
  }

  Widget _getLinearGauge() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SfLinearGauge(
        minimum: 0.0,
        maximum: 1000.0,
        showTicks: false,
        orientation: LinearGaugeOrientation.horizontal,
        majorTickStyle: const LinearTickStyle(length: 300),
        axisLabelStyle: const TextStyle(
          fontSize: 12.0,
          color: Colors.white,
          height: 2.0,
        ),
        // ranges: const <LinearGaugeRange>[
        //   LinearGaugeRange(
        //     startValue: 0,
        //     endValue: 100,
        //     color: Colors.red,
        //     position: LinearElementPosition.cross,
        //   )
        // ],
        axisTrackStyle: const LinearAxisTrackStyle(
          color: Colors.green,
          edgeStyle: LinearEdgeStyle.bothCurve,
          thickness: 15.0,
          borderColor: Colors.grey,
        ),
      ),
    );
  }
}
