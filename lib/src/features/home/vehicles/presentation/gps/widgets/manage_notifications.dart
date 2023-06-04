import 'dart:async';
import 'dart:convert';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/gps/controller/gps_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/vehicles/domain/gps_notification_user_model.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_gps_acc_info_model.dart';
import 'package:axlerate/values/constants.dart';

class GpsUpdateNotificationModel {
  final String organizationId;
  final String vehicleEntityId;
  final String imei;
  final int? speedLimit;
  GpsNotifications notifications;
  List<String> notificationUsers;

  GpsUpdateNotificationModel({
    required this.organizationId,
    required this.vehicleEntityId,
    required this.imei,
    this.speedLimit,
    required this.notifications,
    required this.notificationUsers,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> gpsData = <String, dynamic>{
      'organizationId': organizationId,
      'vehicleEntityId': vehicleEntityId,
      'imei': imei,
      'notifications': notifications.toMap(),
      'notificationUsers': notificationUsers,
    };
    if (speedLimit != null) {
      gpsData.addAll({'speedLimit': speedLimit});
    }

    return gpsData;
  }

  factory GpsUpdateNotificationModel.fromMap(Map<String, dynamic> map) {
    return GpsUpdateNotificationModel(
      organizationId: map['organizationId'] as String,
      vehicleEntityId: map['vehicleEntityId'] as String,
      imei: map['imei'] as String,
      speedLimit: map['speedLimit'] as int,
      notifications: GpsNotifications.fromMap(map['notifications'] as Map<String, dynamic>),
      notificationUsers: List<String>.from((map['notificationUsers'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory GpsUpdateNotificationModel.fromJson(String source) =>
      GpsUpdateNotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ManageGpsNotifications extends ConsumerStatefulWidget {
  const ManageGpsNotifications({
    required this.gpsAccountInfo,
    required this.usersList,
    Key? key,
  }) : super(key: key);

  final VehicleGPSAccountInfoModel gpsAccountInfo;
  final NotificationUserModel usersList;
  @override
  ConsumerState<ManageGpsNotifications> createState() => _ManageGpsNotificationsState();
}

class _ManageGpsNotificationsState extends ConsumerState<ManageGpsNotifications> {
  @override
  void initState() {
    super.initState();
  }

  OrgDoc? org;

  GpsNotifications notification = GpsNotifications(
      speedAlert: false,
      ignitionAlert: false,
      engineCutRestoreAlert: false,
      powerDisconnectAlert: false,
      lowBatteryAlert: false,
      antiTheftAlert: false,
      noGpsSignalAlert: false,
      parkingAlarmAlert: false,
      acOnOffAlert: false,
      driverBehaviourAlert: false,
      temperatureAlert: false);
  TextEditingController speedController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // TextEditingController usersController = TextEditingController();

  List<ValueItem> selectedUsers = [];

  List<ValueItem> getSelectedItems() {
    selectedUsers = widget.usersList.docs!
        .where((e) {
          return widget.gpsAccountInfo.data?.message?.vehicelGpsInfo?.notificationUsers?.contains(e.userId) ?? false;
        })
        .map((e) => ValueItem(
              label: e.displayText,
              value: e.userId,
            ))
        .toList();

    return selectedUsers;
  }

  @override
  Widget build(BuildContext context) {
    speedController.text = widget.gpsAccountInfo.data!.message!.vehicelGpsInfo!.speedLimit?.toString() ?? "";
    org = ref.watch(orgDetailsProvider);
    // if (org != null) {
    //   getUsers();
    // }

    notification = widget.gpsAccountInfo.data!.message!.vehicelGpsInfo!.notifications!;

    // return Container(
    //   child: Text(
    //     "Choose Notifications for Vehicle ${widget.gpsAccountInfo.data!.message!.vehicelGpsInfo!.vehicleInfo!.vehicleEntityId}",
    //     style: AxleTextStyle.headingPrimary,
    //   ),
    // );

    return SingleChildScrollView(
      child: SizedBox(
          width: 500.0,
          // height: 700.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose Notifications for Vehicle ${widget.gpsAccountInfo.data!.message!.vehicelGpsInfo!.vehicleInfo!.vehicleEntityId}",
                style: AxleTextStyle.headingPrimary,
              ),
              Text(org?.enrollmentId ?? ""),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Over Speed"),
                  Switch(
                      value: notification.speedAlert,
                      onChanged: (value) => setState(() {
                            notification.speedAlert = value;
                          })),
                ],
              ),
              if (notification.speedAlert)
                ShowUp(
                  delay: 100,
                  child: Form(
                    key: formKey,
                    child: AxleFormTextField(
                      fieldWidth: 200,
                      fieldHint: "20 - 140",
                      fieldController: speedController,
                      isOnlyDigits: true,
                      isFieldEnabled: notification.speedAlert,
                      fieldHeading: "Enter Speed Limit (km/hr)",
                      lengthLimit: 3,
                      validate: Validators("Speed Limit").range(40, 200),
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Ignition Alert"),
                  Switch(
                      value: notification.ignitionAlert,
                      onChanged: (value) => setState(() {
                            notification.ignitionAlert = value;
                          })),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Engine Cut Restore Alert"),
                  Row(
                    children: [
                      Switch(
                          value: notification.engineCutRestoreAlert,
                          onChanged: (value) => setState(() {
                                notification.engineCutRestoreAlert = value;
                              })),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Power Disconnected Alert"),
                  Row(
                    children: [
                      Switch(
                          value: notification.powerDisconnectAlert,
                          onChanged: (value) => setState(() {
                                notification.powerDisconnectAlert = value;
                              })),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Low Battery Alert"),
                  Row(
                    children: [
                      Switch(
                          value: notification.lowBatteryAlert,
                          onChanged: (value) => setState(() {
                                notification.lowBatteryAlert = value;
                              })),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Anti Theft Alert"),
                  Row(
                    children: [
                      Switch(
                          value: notification.antiTheftAlert,
                          onChanged: (value) => setState(() {
                                notification.antiTheftAlert = value;
                              })),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("No GPS Signal Alert"),
                  Row(
                    children: [
                      Switch(
                          value: notification.noGpsSignalAlert,
                          onChanged: (value) => setState(() {
                                notification.noGpsSignalAlert = value;
                              })),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Parking Alarm Alert"),
                  Row(
                    children: [
                      Switch(
                          value: notification.parkingAlarmAlert,
                          onChanged: (value) => setState(() {
                                notification.parkingAlarmAlert = value;
                              })),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Driver Behaviour Alert"),
                  Row(
                    children: [
                      Switch(
                          value: notification.driverBehaviourAlert,
                          onChanged: (value) => setState(() {
                                notification.driverBehaviourAlert = value;
                              })),
                    ],
                  ),
                ],
              ),
              if (widget.gpsAccountInfo.data!.message!.vehicelGpsInfo!.type == "PREMIUM")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("AC Status Alert"),
                    Row(
                      children: [
                        Switch(
                            value: notification.acOnOffAlert,
                            onChanged: (value) => setState(() {
                                  notification.acOnOffAlert = value;
                                })),
                      ],
                    ),
                  ],
                ),
              if (widget.gpsAccountInfo.data!.message!.vehicelGpsInfo!.type == "PREMIUM")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Temperature Alert"),
                    Row(
                      children: [
                        Switch(
                            value: notification.temperatureAlert,
                            onChanged: (value) => setState(() {
                                  notification.temperatureAlert = value;
                                })),
                      ],
                    ),
                  ],
                ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  "Choose Users",
                  style: AxleTextStyle.headingPrimary,
                ),
              ),
              MultiSelectDropDown(
                selectedOptions: getSelectedItems(),

                //   try {
                //     NotificationUser user = widget.usersList.docs!.firstWhere((element) => element.userId == e);
                //     return ValueItem(label: "user.displayText", value: "user.userId");
                //   } catch (e) {
                //     return ValueItem(label: '');
                //   }
                // }).toList() ??
                // [],
                onOptionSelected: (List<ValueItem> selectedOptions) {
                  selectedUsers = selectedOptions.map((e) => e).toList();
                },
                options: widget.usersList.docs!
                    .map(
                      (e) => ValueItem(
                        label: e.displayText,
                        value: e.userId,
                      ),
                    )
                    .toList(),
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                dropdownHeight: 100,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              AxlePrimaryButton(
                  buttonText: "Update",
                  onPress: () async {
                    if (notification.speedAlert) {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                    }

                    GpsUpdateNotificationModel data = GpsUpdateNotificationModel(
                        organizationId: widget.gpsAccountInfo.data!.message!.vehicelGpsInfo!.logisticsOrganization!,
                        vehicleEntityId:
                            widget.gpsAccountInfo.data!.message!.vehicelGpsInfo!.vehicleInfo!.vehicleEntityId!,
                        imei: widget.gpsAccountInfo.data!.message!.vehicelGpsInfo!.imei!,
                        speedLimit: notification.speedAlert ? int.parse(speedController.text) : null,
                        notifications: notification,
                        notificationUsers: selectedUsers.map((e) => e.value!).toList());
                    try {
                      await ref.read(gpsControllerProvider).updateGpsNotifications(data);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    } catch (e) {
                      // debugPrint(e.toString());
                    }
                  })
            ],
          )),
    );
  }
}

class ShowUp extends StatefulWidget {
  final Widget child;
  final int? delay;

  const ShowUp({super.key, required this.child, this.delay});

  @override
  ShowUpState createState() => ShowUpState();
}

class ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset = Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero).animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay!), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animController,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
