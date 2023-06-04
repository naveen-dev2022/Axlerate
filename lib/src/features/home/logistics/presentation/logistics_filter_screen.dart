import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_controllers/list_orgs_filter_controller.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/common/common_models/list_orgs_query_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class LogisticsFilterScreen extends ConsumerStatefulWidget {
  const LogisticsFilterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogisticsFilterScreenState();
}

class _LogisticsFilterScreenState extends ConsumerState<LogisticsFilterScreen> {
  ListOrgsQueryParams params = ListOrgsQueryParams(pageIndex: 1, organizationType: 'LOGISTICS');

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final natureOfBusinessFilter = ref.read(natureOfBusinessNotifierProviderPartner.notifier);

    return Scaffold(
      backgroundColor: AxleColors.axleWhiteColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AxleColors.axleWhiteColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
          color: AxleColors.axleBlackColor,
        ),
        title: Text(HomeConstants.filters, style: AxleTextStyle.miniHeadingBlackStyle),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(''),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AxleFormTextField(
                fieldHeading: 'Search by',
                fieldHint: 'Search By Customer Name / ID / Mobile Number',
                fieldWidth: screenWidth,
              ),
              const SizedBox(height: 10.0),

              Text(
                HomeConstants.state,
                style: AxleTextStyle.miniHeadingBlackStyle,
              ),
              const SizedBox(height: 10.0),
              MultiSelectDropDown(
                onOptionSelected: (List<ValueItem> selectedOptions) {
                  params = params.copyWith(
                    state: selectedOptions.map((ValueItem valueItem) => valueItem.value.toString()).toList(),
                  );
                },
                options: listOfStates
                    .map(
                      (item) => ValueItem(
                        label: item,
                        value: item.toUpperCase(),
                      ),
                    )
                    .toList(),
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 200,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),
              const SizedBox(height: 12.0),
              ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  HomeConstants.natureOfBusiness,
                  style: AxleTextStyle.miniHeadingBlackStyle,
                ),
                children: ref
                    .watch(natureOfBusinessNotifierProviderPartner)
                    .map(
                      (item) => CheckboxListTile(
                        value: item.status,
                        onChanged: (bool? val) {
                          natureOfBusinessFilter.changeStatus(item, val!);
                        },
                        title: Text(item.name),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    )
                    .toList(),
              ),
              // ExpansionTile(
              //   title: Text(
              //     HomeConstants.registrationStatus,
              //     style: AxleTextStyle.miniHeadingBlackStyle,
              //   ),
              //   children: kycStatusList
              //       .map(
              //         (item) => CheckboxListTile(
              //           value: false,
              //           onChanged: (bool? val) {},
              //           title: Text(item),
              //           controlAffinity: ListTileControlAffinity.leading,
              //         ),
              //       )
              //       .toList(),
              // ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
