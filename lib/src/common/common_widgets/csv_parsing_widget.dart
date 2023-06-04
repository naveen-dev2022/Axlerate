import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/gps/data/add_gps_device_model.dart';
import 'package:axlerate/src/features/home/gps/data/gps_device_model.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CsvParsingWidget extends ConsumerStatefulWidget {
  const CsvParsingWidget({
    Key? key,
    required this.bytes,
  }) : super(key: key);
  final String bytes;
  @override
  ConsumerState<CsvParsingWidget> createState() => _CsvParsingWidgetState();
}

class _CsvParsingWidgetState extends ConsumerState<CsvParsingWidget> {
  bool hasTitle = false;
  String delimiter = ',';

  TextEditingController delimiterController = TextEditingController(text: ',');

  bool showServerStatus = false;
  List<Map<String, dynamic>> isValidData = [];
  List<List<dynamic>>? data;
  bool error = false;
  String? itemsCount;
  int successfulItems = 0;
  @override
  Widget build(BuildContext context) {
    successfulItems = 0;
    if (showServerStatus == false) {
      try {
        var d = const FirstOccurrenceSettingsDetector(eols: ['\r\n', '\n'], textDelimiters: ['"', "'"]);
        data = CsvToListConverter(
                // eol: '**\n',
                fieldDelimiter: delimiter,
                allowInvalid: true,
                csvSettingsDetector: d)
            .convert(widget.bytes);
        if (hasTitle) data!.removeAt(0);
        assert(!data!.any((element) => element.length != 2));
        isValidData = data!.map((e) {
          try {
            AddGpsDeviceItemModel temp = AddGpsDeviceItemModel(
                imei: e[0].toString(), type: GpsDeviceType.values.byName(e[1].toString().toLowerCase()));
            successfulItems++;
            return {'success': true, 'value': temp, 'serverStatus': "Pending"};
          } catch (e) {
            return {'success': false, 'serverStatus': "Pending"};
          }
        }).toList();
        setState(() {
          itemsCount = data!.length.toString();
          error = false;
        });
      } catch (e) {
        // debugPrint(e.toString());
        setState(() {
          data = null;
          error = true;
        });
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Has Title"),
            Checkbox(
                value: hasTitle,
                onChanged: (bool? val) {
                  setState(() {
                    hasTitle = val!;
                  });
                }),
            Expanded(child: Container()),
            const Text("Delimiter Text"),
            AxleFormTextField(
              fieldWidth: 40,
              fieldController: delimiterController,
              fieldHint: "Delimiting text",
              onChange: (p0) {
                setState(() {
                  delimiter = delimiterController.text;
                });
              },
            )
          ],
        ),
        error
            ? const Text("Unable to Parse CSV. Try a different delimiter")
            : Column(
                children: [
                  Text("Number of entries${itemsCount!}"),
                  DataTable(columns: [
                    const DataColumn(label: Text("IMEI")),
                    const DataColumn(label: Text("Device Type")),
                    const DataColumn(label: Text("IsValidData")),
                    if (showServerStatus == true) const DataColumn(label: Text("Server Status"))
                  ], rows: [
                    if (data != null)
                      for (int i = 0; i < data!.length; i++)
                        DataRow(
                            color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                              if (isValidData[i]['serverStatus'].toString().startsWith('Success')) {
                                return Colors.green[200];
                              }

                              if (isValidData[i]['serverStatus'].toString().startsWith('Failure')) {
                                return Colors.red[200];
                              }
                              return null;
                              // if (states.contains(MaterialState.selected))
                              //   return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                              // return null;  // Use the default value.
                            }),
                            cells: [
                              for (int j = 0; j < data![i].length; j++) DataCell(Text(data![i][j].toString())),
                              isValidData[i]['success']
                                  ? DataCell(Center(
                                      child: Icon(
                                        Icons.check_circle_rounded,
                                        color: Colors.greenAccent[400],
                                      ),
                                    ))
                                  : DataCell(Center(
                                      child: Icon(
                                        Icons.dangerous_rounded,
                                        color: Colors.red[400],
                                      ),
                                    )),
                              if (showServerStatus == true) DataCell(Text(isValidData[i]['serverStatus']))
                            ])
                  ]),
                ],
              ),
        AxlePrimaryButton(
            buttonText: "Process ($successfulItems)",
            onPress: successfulItems > 0
                ? () async {
                    // log("Button Pressed");
                    setState(() {
                      showServerStatus = true;
                    });
                    for (int i = 0; i < isValidData.length; i++) {
                      var element = isValidData[i];
                      if (element['success'] == true) {
                        // log("setting Status");
                        setState(() {
                          isValidData[i]['serverStatus'] = "Processing";
                        });
                        updateSuccess(i);
                      } else {
                        setState(() {
                          isValidData[i]['serverStatus'] = "Not Processed";
                        });
                      }
                      await Future.delayed(const Duration(milliseconds: 20));
                    }
                  }
                : null)
      ],
    );
  }

  updateSuccess(int i) async {
    await Future.delayed(const Duration(seconds: 2));
    AddGpsDevicesModel(devices: [isValidData[i]['value']]);

    try {
      assert(i % 2 == 0);
      // await ref.watch(gpsListControllerProvider).addGpsDevices(devices);
      setState(() {
        isValidData[i]['serverStatus'] = "Success!";
      });
    } catch (e) {
      setState(() {
        isValidData[i]['serverStatus'] = "Failure ${ApiHelper.getErrorMessage(e)}";
      });
    }
  }
}
