import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/features/home/gps/controller/gps_controller.dart';
import 'package:axlerate/src/features/home/gps/data/gps_device_list_model.dart';
import 'package:axlerate/src/features/home/gps/data/gps_device_model.dart';
import 'package:axlerate/src/features/home/gps/presentation/allocate_gps_devices.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';

@RoutePage()
class ListGpsDevices extends ConsumerStatefulWidget {
  const ListGpsDevices({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListGpsDevicesState();
}

class _ListGpsDevicesState extends ConsumerState<ListGpsDevices> {
  @override
  void initState() {
    getDevicesList();
    super.initState();
  }

  List<String> headerItems = [
    "IMEI",
    "Device Type",
    "Status",
    "Organization",
    "Vehicle",
  ];

  late double contentWidth;

  Future<void> getDevicesList() async {
    ref.read(gpsListStateProvider.notifier).state = await ref.read(gpsControllerProvider).listGpsDevices();
  }

  List<bool> isSelected = [];
  GpsDeviceListModel? devices;
  @override
  Widget build(BuildContext context) {
    devices = ref.watch(gpsListStateProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // bool isMobile = Responsive.isMobile(context);

    double sideBarWidth = Responsive.isMobile(context) ? 0 : 300;
    double availableWidth = screenWidth - sideBarWidth - (defaultPadding * 3);
    contentWidth = availableWidth / headerItems.length;

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            children: [
              DashboardHeader(
                title: "GPS Device Management",
                buttonText: "Add Device",
                onButtonPressed: () {
                  // log("Adding Device");
                  context.router.pushNamed(RouteUtils.addGpsPath());
                },
              ),
              const SizedBox(
                height: defaultMobilePadding,
              ),
              if (devices != null &&
                  devices?.data != null &&
                  devices!.data!.message.docs.any((element) => element.isSelected!))
                AxleOutlineButton(
                    buttonWidth: 300,
                    buttonText:
                        "Allocate to Customers (${devices!.data!.message.docs.where((element) => element.isSelected!).length})",
                    onPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AllocateDevicesToLogisticsOrg(
                            devices: devices!.data!.message.docs.where((element) => element.isSelected!).toList(),
                          );
                        },
                      );
                    }),
              const SizedBox(
                height: defaultMobilePadding,
              ),
              gpsHeader(),
              const SizedBox(
                height: defaultMobilePadding,
              ),
              devices == null
                  ? AxleLoader.axleProgressIndicator()
                  : devices!.data == null
                      ? emptyResponse()
                      : SingleChildScrollView(
                          child: Column(children: [
                            SizedBox(
                              height: screenHeight * 80 / 100,
                              child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: devices!.data!.message.docs.length,
                                itemBuilder: (context, index) {
                                  List<String> itemRowData = [
                                    devices!.data!.message.docs[index].imei,
                                    devices!.data!.message.docs[index].type.name.toUpperCase(),
                                    devices!.data!.message.docs[index].status.text,
                                    devices!.data!.message.docs[index].logisticsOrgEnrollmentId ?? "",
                                    devices!.data!.message.docs[index].vehicleInfo?.vehicleEntityId ?? "",
                                    devices!.data!.message.docs[index].isSelected.toString()
                                  ];
                                  // isSelected..add(false); // = false;
                                  return listItem(context, itemRowData, index);
                                },
                              ),
                            )
                          ]),
                        )
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(BuildContext context, List<String> rowItem, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (rowItem.last == 'true') {
            devices!.data!.message.docs[index].isSelected = false;
          } else {
            devices!.data!.message.docs[index].isSelected = true;
          }
        });
      },
      child: Card(
          color: rowItem.last == 'true' ? Colors.blue[200] : null,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < rowItem.length - 1; i++)
                SizedBox(
                  width: contentWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
                    child: Text(
                      rowItem[i],
                    ),
                  ),
                ),
            ],
          )),
    );
  }

  Widget gpsHeader() {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        for (int i = 0; i < headerItems.length; i++) headerItem(contentWidth, headerItems[i]),
      ],
    ));
  }

  SizedBox headerItem(double contentWidth, String text) {
    return SizedBox(
        width: contentWidth,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(text),
        ));
  }

  Widget emptyResponse() {
    return const Center(
      child: Text(
        'No Items Found',
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
