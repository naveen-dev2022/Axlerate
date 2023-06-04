import 'dart:developer';

import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/common/common_models/list_orgs_query_params.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/gps/controller/gps_controller.dart';
import 'package:axlerate/src/features/home/gps/data/allocate_gps_device_model.dart';
import 'package:axlerate/src/features/home/gps/data/gps_device_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';

class AllocateDevicesToLogisticsOrg extends ConsumerStatefulWidget {
  const AllocateDevicesToLogisticsOrg({Key? key, required this.devices}) : super(key: key);

  final List<GpsDevice> devices;

  @override
  ConsumerState<AllocateDevicesToLogisticsOrg> createState() => _AllocateDevicesToLogisticsOrgState();
}

class _AllocateDevicesToLogisticsOrgState extends ConsumerState<AllocateDevicesToLogisticsOrg> {
  ListOrgsQueryParams params = ListOrgsQueryParams.allOrgs();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getListOfLogistics(params);
    });
    super.initState();
  }

  Future<void> getListOfLogistics(ListOrgsQueryParams params) async {
    // ref.read(listofLogisticsStateProvider.notifier).state = null;
    ref.read(listofLogisticsStateProvider.notifier).state =
        await ref.read(logisticsControllerProvider).getLogisticsList(queryParams: params);
  }

  @override
  Widget build(BuildContext context) {
    OrgDoc? selectedOrg;
    final logisticsList = ref.watch(listofLogisticsStateProvider);
    int basicDevicesCount = widget.devices.where((element) => element.type == GpsDeviceType.basic).length;
    int premiumDevicesCount = widget.devices.where((element) => element.type == GpsDeviceType.premium).length;
    return AlertDialog(
      title: Text(
        "Allocate Devices ",
        style: AxleTextStyle.dashboardHeadingText,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Count of Basic Devices - $basicDevicesCount"),
          Text("Count of Premium Devices - $premiumDevicesCount"),
          const SizedBox(
            height: defaultPadding,
          ),
          if (logisticsList != null)
            AxleSearchDropDownField(
                validate: Validators("Customer").required(),
                fieldHint: "Choose Customer",
                fieldController: controller,
                dropDownOptions: logisticsList.data!.message.docs
                    .map((e) => '${e.enrollmentId} - ${e.firstName} ${e.lastName}')
                    .toList(),
                onChanged: (value) {
                  // log(value);
                  controller.text = value;

                  String selectedText = value;
                  String selectedEnrollmentId = selectedText.split('-').first.trim();
                  selectedOrg = logisticsList.data!.message.docs
                      .firstWhere((element) => element.enrollmentId == selectedEnrollmentId);
                }),
          const SizedBox(
            height: defaultPadding,
          ),
          AxlePrimaryButton(
            buttonText: "Allocate",
            onPress: () async {
              if (selectedOrg == null) {
                Snackbar.warn("Choose Organization");
                return;
              }
              AllocateGpsDeviceModel data = AllocateGpsDeviceModel(
                  devices: widget.devices.map((e) => AllocateGpsDeviceItemModel(imei: e.imei)).toList(),
                  organizationId: selectedOrg!.id);

              try {
                AxleLoader.show(context);
                await ref.read(gpsControllerProvider).allocateGpsDevices(data);
                // formArray.forEach((element) {
                //   element.imei.dispose();
                // });
                // context.go(RouteUtils.getGpsManagePath());
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                // formArray.clear();
                // formArray.add(getFormGroup());
              } catch (e) {
                log(e.toString());
              }
              AxleLoader.hide();
            },
          )
        ],
      ),
    );
  }
}
