import 'package:auto_route/annotations.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../../../Themes/text_style_config.dart';
import '../../../../../../responsive.dart';
import '../../../../../../values/constants.dart';
import '../../../../../utils/axle_loader.dart';
import '../../../../../utils/date_time_helper.dart';
import '../../domain/challan_entity.dart';
import '../controller/ecard_controller.dart';

@RoutePage()
class ChallanScreen extends ConsumerStatefulWidget {
  const ChallanScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChallanScreen> createState() => _ChallanScreenState();
}

class _ChallanScreenState extends ConsumerState<ChallanScreen> {
  late EmployeeDataSource employeeDataSource;
  bool isMobile = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(challanStateProvider.notifier).state = null;
      ref.read(challanStateProvider.notifier).state =
          await ref.read(eCardControllerProvider).fetchChallanData('', '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = Responsive.isMobile(context);

    final challanList = ref.watch(challanStateProvider);
    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: challanList == null
          ? AxleLoader.axleProgressIndicator()
          : Padding(
              padding: isMobile
                  ? const EdgeInsets.symmetric(horizontal: defaultMobilePadding)
                  : const EdgeInsets.all(defaultPadding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding,
                      ),
                      child: Text(
                        "Challan",
                        style: AxleTextStyle.headingPrimary,
                      ),
                    ),
                    _loadChallanData(
                      challanList,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _loadChallanData(ChallanEntity? challanList) {
    employeeDataSource =
        EmployeeDataSource(employeeData: challanList!.data!.challans!);
    return SfDataGrid(
      source: employeeDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'Challan No',
          label: Container(
            color: AxleColors.axlePrimaryColor,
            padding: const EdgeInsets.all(defaultMobilePadding),
            alignment: Alignment.center,
            child: const Text(
              'Challan No',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        GridColumn(
          columnName: 'Date',
          label: Container(
            color: AxleColors.axlePrimaryColor,
            padding: const EdgeInsets.all(defaultMobilePadding),
            alignment: Alignment.center,
            child: const Text(
              'Date',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        GridColumn(
          columnName: 'RcDlNo',
          label: Container(
            color: AxleColors.axlePrimaryColor,
            padding: const EdgeInsets.all(defaultMobilePadding),
            alignment: Alignment.center,
            child: const Text(
              'RcDlNo',
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        GridColumn(
          columnName: 'OwnerName',
          label: Container(
            color: AxleColors.axlePrimaryColor,
            padding: const EdgeInsets.all(defaultMobilePadding),
            alignment: Alignment.center,
            child: const Text(
              'Owner Name',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        GridColumn(
          columnName: 'AccusedName',
          label: Container(
            color: AxleColors.axlePrimaryColor,
            padding: const EdgeInsets.all(defaultMobilePadding),
            alignment: Alignment.center,
            child: const Text(
              'Accused Name',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        GridColumn(
          columnName: 'ChallanStatus',
          label: Container(
            color: AxleColors.axlePrimaryColor,
            padding: const EdgeInsets.all(defaultMobilePadding),
            alignment: Alignment.center,
            child: const Text(
              'Challan Status',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        GridColumn(
          columnName: 'PaymentSource',
          label: Container(
            color: AxleColors.axlePrimaryColor,
            padding: const EdgeInsets.all(defaultMobilePadding),
            alignment: Alignment.center,
            child: const Text(
              'Payment Source',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        GridColumn(
          columnName: 'Amount',
          label: Container(
            color: AxleColors.axlePrimaryColor,
            padding: const EdgeInsets.all(defaultMobilePadding),
            alignment: Alignment.center,
            child: const Text(
              'Amount',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        GridColumn(
          columnName: 'State',
          label: Container(
            color: AxleColors.axlePrimaryColor,
            padding: const EdgeInsets.all(defaultMobilePadding),
            alignment: Alignment.center,
            child: const Text(
              'State',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        GridColumn(
          columnName: 'Area',
          label: Container(
            color: AxleColors.axlePrimaryColor,
            padding: const EdgeInsets.all(defaultMobilePadding),
            alignment: Alignment.center,
            child: const Text(
              'Area',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Challans> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                columnName: 'Challan No',
                value: e.challanNo,
              ),
              DataGridCell<String>(
                columnName: 'Date',
                value: DateTimeHelper.dateDisplayFromString(e.date!),
              ),
              DataGridCell<String>(
                columnName: 'RcDlNo',
                value: e.rcDlNo,
              ),
              DataGridCell<String>(
                columnName: 'OwnerName',
                value: e.ownerName,
              ),
              DataGridCell<String>(
                columnName: 'AccusedName',
                value: e.accusedName,
              ),
              DataGridCell<String>(
                columnName: 'ChallanStatus',
                value: e.challanStatus,
              ),
              DataGridCell<String>(
                columnName: 'PaymentSource',
                value: e.paymentSource,
              ),
              DataGridCell<int>(
                columnName: 'Amount',
                value: e.amount?.toInt(),
              ),
              DataGridCell<String>(
                columnName: 'State',
                value: e.state,
              ),
              DataGridCell<String>(
                columnName: 'Area',
                value: e.area,
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
