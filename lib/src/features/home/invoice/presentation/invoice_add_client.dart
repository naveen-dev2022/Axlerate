import 'package:flutter/material.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_icon_button.dart';
import 'package:axlerate/src/features/home/invoice/presentation/controller/invoice_add_client_controller.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class InvoiceAddClient extends ConsumerStatefulWidget {
  const InvoiceAddClient({Key? key}) : super(key: key);

  @override
  ConsumerState<InvoiceAddClient> createState() => _InvoiceAddClientState();
}

class _InvoiceAddClientState extends ConsumerState<InvoiceAddClient> {
  TextEditingController countryController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? pickedDateValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AxleColors.axleBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ref.watch(stepCompleted).contains(1)
                              ? Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: AxleColors.axleGreenColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.check, size: 17.5, color: Colors.white),
                                  ),
                                )
                              : Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "1",
                                      style: AxleTextStyle.titleMedium.copyWith(color: Colors.black),
                                    ),
                                  ),
                                ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Basic information",
                                style: AxleTextStyle.titleMedium.copyWith(color: Colors.black),
                              ),
                              Text(
                                "Name, Alise Name, Logo",
                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "2",
                                style: AxleTextStyle.titleMedium.copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Business information",
                                style: AxleTextStyle.titleMedium.copyWith(color: Colors.black),
                              ),
                              Text(
                                "Business details, Category",
                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "3",
                                style: AxleTextStyle.titleMedium.copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Address",
                                style: AxleTextStyle.titleMedium.copyWith(color: Colors.black),
                              ),
                              Text(
                                "City, Country etc.",
                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "4",
                                style: AxleTextStyle.titleMedium.copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Online Presence",
                                style: AxleTextStyle.titleMedium.copyWith(color: Colors.black),
                              ),
                              Text(
                                "Website, Social media etc.",
                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      backgroundColor: Colors.white,
                      collapsedBackgroundColor: Colors.white,
                      expandedAlignment: Alignment.centerLeft,
                      childrenPadding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      title: Row(
                        children: [
                          Text(
                            "1. Basic Information",
                            style: AxleTextStyle.titleMedium.copyWith(color: Colors.black, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(width: 25),
                          ref.watch(stepCompleted).contains(1)
                              ? Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: AxleColors.axleGreenColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.check, size: 15, color: Colors.white),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      children: [
                        Text(
                          "Profile Image/Business Logo",
                          style: AxleTextStyle.titleMedium.copyWith(color: Colors.black87),
                        ),
                        Text(
                          "Upload a professional picture if you are a freelancer",
                          style: AxleTextStyle.titleSmall.copyWith(color: Colors.black54),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            ref.watch(imagePicker) == null
                                ? GestureDetector(
                                    onTap: () async {
                                      await ImagePickerWeb.getImageAsWidget().then((Image? value) {
                                        if (value != null) {
                                          ref.read(imagePicker.notifier).state = value;
                                        }
                                        return null;
                                      });
                                    },
                                    child: Container(
                                      width: 125,
                                      height: 125,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AxleColors.dashBlue,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          color: AxleColors.axlePrimaryColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 125,
                                    height: 125,
                                    child: ref.watch(imagePicker),
                                  ),
                            const SizedBox(width: 25),
                            GestureDetector(
                              onTap: () async {
                                await ImagePickerWeb.getImageAsWidget().then((Image? value) {
                                  if (value != null) {
                                    ref.read(imagePicker.notifier).state = value;
                                  }
                                  return null;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: AxleColors.dashBlue,
                                  ),
                                ),
                                padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.cloud_upload_outlined,
                                      color: AxleColors.axlePrimaryColor,
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      ref.watch(imagePicker) == null
                                          ? "Upload from Computer"
                                          : "Upload Different Image",
                                      style: AxleTextStyle.titleSmall.copyWith(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "Country*",
                          style: AxleTextStyle.titleMedium.copyWith(color: Colors.black87),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: AxleSearchDropDown(
                            fieldWidth: MediaQuery.of(context).size.width,
                            fieldHint: 'Select Country',
                            dropDownOptions: const [
                              DropDownValueModel(name: 'India', value: 'India'),
                              DropDownValueModel(name: 'China', value: 'China'),
                              DropDownValueModel(name: 'Japan', value: 'Japan')
                            ],
                            fieldController: countryController,
                            onChanged: (dynamic data) {},
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "Your Name/Business Name*",
                          style: AxleTextStyle.titleMedium.copyWith(color: Colors.black87),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Official name of your business. Use your personal name if you are a freelancer.",
                          style: AxleTextStyle.titleSmall.copyWith(color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: AxleFormTextField(
                            fieldHint: "Your or Business name",
                            fieldController: businessNameController,
                            fieldWidth: MediaQuery.of(context).size.width,
                            isRequiredField: true,
                          ),
                        ),
                        const SizedBox(height: 25),
                        ref.watch(showBrandOrDisplayName)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Brand Name / Display Name",
                                    style: AxleTextStyle.titleMedium.copyWith(color: Colors.black87),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "This name will be shown publicly on your profile.",
                                    style: AxleTextStyle.titleSmall.copyWith(color: Colors.black54),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: AxleFormTextField(
                                      fieldHint: "Brand or Display name",
                                      fieldController: brandNameController,
                                      fieldWidth: MediaQuery.of(context).size.width,
                                      isRequiredField: true,
                                    ),
                                  ),
                                ],
                              )
                            : GestureDetector(
                                onTap: () {
                                  ref.read(showBrandOrDisplayName.notifier).state = true;
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.add_box_outlined, color: AxleColors.axlePrimaryColor),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Add Brand or Display name",
                                      style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                              ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AxlePrimaryIconButton(
                              buttonIcon: const Icon(Icons.check, size: 20.0),
                              buttonWidth: 180.0,
                              onPress: () async {
                                setState(() {
                                  ref.watch(stepCompleted.notifier).state.add(1);
                                });
                              },
                              buttonText: "Save & Continue",
                              buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
                            ),
                            const SizedBox(width: 25),
                            Text(
                              "Reset",
                              style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      backgroundColor: Colors.white,
                      collapsedBackgroundColor: Colors.white,
                      expandedAlignment: Alignment.centerLeft,
                      childrenPadding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      title: Row(
                        children: [
                          Text(
                            "2. Profile Information",
                            style: AxleTextStyle.titleMedium.copyWith(color: Colors.black, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(width: 25),
                          ref.watch(stepCompleted).contains(2)
                              ? Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: AxleColors.axleGreenColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.check, size: 15, color: Colors.white),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      children: [
                        Text(
                          "What describes you best?",
                          style: AxleTextStyle.titleMedium.copyWith(color: Colors.black87),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            RadioListTile(
                              dense: true,
                              title: Text(
                                "Individual/Freelancer",
                                style: AxleTextStyle.titleSmall.copyWith(color: Colors.black87),
                              ),
                              value: "Individual/Freelancer",
                              groupValue: ref.watch(youBestRadio),
                              onChanged: (value) {
                                setState(() {
                                  ref.read(youBestRadio.notifier).state = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              dense: true,
                              title: Text(
                                "Team/Agency/Company",
                                style: AxleTextStyle.titleSmall.copyWith(color: Colors.black87),
                              ),
                              value: "Team/Agency/Company",
                              groupValue: ref.watch(youBestRadio),
                              onChanged: (value) {
                                setState(() {
                                  ref.read(youBestRadio.notifier).state = value.toString();
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "In Business Since",
                          style: AxleTextStyle.titleMedium.copyWith(color: Colors.black87),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Month and Year of when you started the business",
                          style: AxleTextStyle.titleSmall.copyWith(color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: GestureDetector(
                            onTap: () async {
                              showMonthPicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((date) {
                                if (date != null) {
                                  print('#####----date----$date');
                                  dateController.text = DatePickerUtil.monthYearFormatter(date);
                                }
                              });
                            },
                            child: AxleFormTextField(
                              fieldHint: 'Select Date',
                              fieldController: dateController,
                              fieldWidth: MediaQuery.of(context).size.width,
                              isFieldEnabled: false,
                              isRequiredField: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "Your Business Category*",
                          style: AxleTextStyle.titleMedium.copyWith(color: Colors.black87),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "What category does your business belong to? Select all that apply or add a new category",
                          style: AxleTextStyle.titleSmall.copyWith(color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 25),
                        Text(
                          "Tell us more about your business",
                          style: AxleTextStyle.titleMedium.copyWith(color: Colors.black87),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Everything that people should know about your business",
                          style: AxleTextStyle.titleSmall.copyWith(color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AxlePrimaryIconButton(
                              buttonIcon: const Icon(Icons.check, size: 20.0),
                              buttonWidth: 180.0,
                              onPress: () async {
                                setState(() {
                                  ref.watch(stepCompleted.notifier).state.add(1);
                                });
                              },
                              buttonText: "Save & Continue",
                              buttonTextStyle: AxleTextStyle.iconButtonTextStyle,
                            ),
                            const SizedBox(width: 25),
                            Text(
                              "Reset",
                              style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
