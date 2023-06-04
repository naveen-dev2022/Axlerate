import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_icon_button.dart';
import 'package:axlerate/src/common/common_widgets/csv_parsing_widget.dart';
import 'package:axlerate/src/features/home/gps/data/add_gps_device_model.dart';
import 'package:axlerate/src/features/home/gps/data/gps_device_model.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/gps/controller/gps_controller.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/dashboard/widgets/dashboard_header.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter_svg/svg.dart';

class AddGpsDeviceFormItemModel {
  TextEditingController imei;
  String type;
  AddGpsDeviceFormItemModel({required this.imei, required this.type});
}

@RoutePage()
class AddGpsDevices extends ConsumerStatefulWidget {
  const AddGpsDevices({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddGpsDevicesState();
}

class _AddGpsDevicesState extends ConsumerState<AddGpsDevices> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  AddGpsDeviceFormItemModel getFormGroup() {
    return AddGpsDeviceFormItemModel(imei: TextEditingController(), type: "Basic"
        // key: GlobalKey<FormState>()

        );
  }

  List<AddGpsDeviceFormItemModel> formArray = [
    AddGpsDeviceFormItemModel(imei: TextEditingController(), type: "Basic"

        // key: GlobalKey<FormState>()
        )
  ];
  @override
  void initState() {
    log("ADD GPS DEVICES");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(children: [
            const DashboardHeader(
              title: "Add GPS Device",
              // buttonText: "Add Device",
              // onButtonPressed: () {
              //   log("Adding Device");
              // },
            ),
            const SizedBox(
              height: defaultMobilePadding,
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: GestureDetector(
                onTap: () async {
                  // List<List>? csvData =
                  try {
                    String? bytes = await CSVFileUploadUtil.pickCsvFile();

                    // ignore: use_build_context_synchronously
                    showDialog(
                      // barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          scrollable: true,
                          // icon: Icon(Icons.table_view_rounded),
                          title: Text(
                            "CSV Data",
                            style: AxleTextStyle.dashboardCardTitle,
                          ),
                          content: CsvParsingWidget(bytes: bytes!),
                        );
                      },
                    );
                  } catch (e) {
                    // debugPrint("No File was selected");
                  }
                },
                child: DottedBorder(
                  padding: const EdgeInsets.all(20.0),
                  color: AxleColors.axleBlueColor,
                  dashPattern: const [6],
                  radius: const Radius.circular(16.0),
                  strokeWidth: 2.0,
                  borderType: BorderType.RRect,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/new_assets/icons/image_upload_icon.svg'),
                        Text(
                          'Upload CSV',
                          style: AxleTextStyle.imageUploadTextStyle,
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Maximum file size: 3MB',
                          style: AxleTextStyle.primaryMiniHintStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: defaultMobilePadding,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AxlePrimaryIconButton(
                buttonIcon: const Icon(Icons.add),
                buttonText: "Add Rows",
                onPress: () {
                  setState(() {
                    formArray.add(getFormGroup());
                  });
                },
              ),
            ),
            AxlePrimaryButton(
              buttonText: "Submit",
              onPress: () async {
                if (!key.currentState!.validate()) return;

                // log("Call Submit");
                AddGpsDevicesModel devices = AddGpsDevicesModel(
                    devices: formArray.map((element) {
                  return AddGpsDeviceItemModel(
                      imei: element.imei.text, type: GpsDeviceType.values.byName(element.type.toLowerCase()));
                }).toList());
                try {
                  AxleLoader.show(context);
                  await ref.read(gpsControllerProvider).addGpsDevices(devices);
                  ref.read(gpsListStateProvider.notifier).state =
                      await ref.read(gpsControllerProvider).listGpsDevices();

                  // formArray.forEach((element) {
                  //   element.imei.dispose();
                  // });
                  // ignore: use_build_context_synchronously
                  context.router.pushNamed(RouteUtils.getGpsManagePath());
                  // formArray.clear();
                  // formArray.add(getFormGroup());
                } catch (e) {
                  log(e.toString());
                }
                AxleLoader.hide();
              },
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            SizedBox(
                height: 600,
                width: 650,
                child: Form(
                  key: key,
                  child: ListView.builder(
                    itemCount: formArray.length,
                    itemBuilder: (context, index) {
                      return addGpsDeviceFormItem(formArray[index]);
                    },
                  ),
                )),
          ]),
        ),
      ),
    );
  }

  Widget addGpsDeviceFormItem(AddGpsDeviceFormItemModel formItem) {
    return Stack(
        // fit: StackFit.passthrough,
        alignment: Alignment.topLeft,
        children: [
          Container(
            decoration: CommonStyleUtil.axleContainerDecoration,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AxleFormTextField(
                    fieldController: formItem.imei,
                    // fieldHeading: "",
                    fieldHint: "Enter IMEI Number",
                    fieldWidth: 300,
                    isOnlyDigits: true,
                    lengthLimit: 15,
                    textType: TextInputType.number,
                    validate: Validators("IMEI").required(),
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: DropdownButtonFormField<String>(
                      // key: ,
                      value: formItem.type,
                      icon: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                          )),
                      elevation: 8,
                      style: const TextStyle(color: Colors.black),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.deepPurpleAccent,
                      // ),
                      focusColor: Colors.transparent,

                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: primaryColor,
                            width: 1.7,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: Color(0xffDCE9F6),
                            width: 1.6,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(color: fieldErrorColor, width: 1.2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(color: fieldErrorColor, width: 1.2),
                        ),
                        hintText: "fieldHint",
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          formItem.type = value!;
                        });
                      },
                      items: GpsDeviceType.values
                          .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem<String>(value: e.text, child: Text(e.text)))
                          .toList(),

                      //     list.map<DropdownMenuItem<String>>((String value) {
                      //   return DropdownMenuItem<String>(
                      //     value: value,
                      //     child: Text(value),
                      //   );
                      // }).toList(),
                    ),
                  ),
                  // AxleSearchDropDownField(
                  //   // fieldHeading: "",
                  //   fieldHint: "Choose Device Type",
                  //   fieldController: formItem.type,
                  //   dropDownOptions:
                  //       GpsDeviceType.values.map((e) => e.text).toList(),
                  //   onChanged: (value) {
                  //     formItem.type.text = value;
                  //   },
                  //   // isRequired: true,
                  //   validate: Validators("Device Type").required(),
                  // ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                iconSize: 16,
                color: Colors.red[300],
                alignment: Alignment.center,
                onPressed: formArray.length <= 1
                    ? null
                    : () {
                        setState(() {
                          formArray.remove(formItem);
                        });
                      },
                icon: const Icon(Icons.delete)),
          )
        ]);
  }
}
