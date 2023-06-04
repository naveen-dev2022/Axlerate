import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:axlerate/responsive.dart';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/values/constants.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'controller/create_invoice_controller.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:number_to_character/number_to_character.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown.dart';
import 'package:axlerate/src/common/common_widgets/discount_type_dropdown.dart';
import 'package:axlerate/src/features/home/invoice/domain/dynamic_field_model.dart';
import 'package:axlerate/src/common/common_widgets/axie_form_text_field_underline.dart';
import 'package:axlerate/src/features/home/invoice/presentation/invoice_add_client.dart';
import 'package:axlerate/src/features/home/invoice/domain/create_invoice_input_model.dart';

@RoutePage()
class CreateInvoice extends ConsumerStatefulWidget {
  const CreateInvoice({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateInvoice> createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends ConsumerState<CreateInvoice> {
  bool isMobile = false;
  double screenWidth = 0.0;
  double availableWidth = 0.0;
  bool showAddSubTitle = false;
  bool logoSelected = false;
  String? logoPath;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _invoiceNoController = TextEditingController();
  final TextEditingController _invoiceNoTitleController = TextEditingController();
  final TextEditingController _invoiceDateController = TextEditingController();
  final TextEditingController _invoiceDateTitleController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _dueDateTitleController = TextEditingController();
  final TextEditingController _billedByTitleController = TextEditingController();
  final TextEditingController _billedToTitleController = TextEditingController();
  final TextEditingController _shippedFromController = TextEditingController();
  final TextEditingController _shippedFromBusinessNameController = TextEditingController();
  final TextEditingController _shippedFromCountryController = TextEditingController();
  final TextEditingController _shippedFromAddressController = TextEditingController();
  final TextEditingController _shippedFromCityController = TextEditingController();
  final TextEditingController _shippedFromPinCodeController = TextEditingController();
  final TextEditingController _shippedFromStateController = TextEditingController();
  final TextEditingController _shippedToController = TextEditingController();
  final TextEditingController _shippedToBusinessNameController = TextEditingController();
  final TextEditingController _shippedToCountryController = TextEditingController();
  final TextEditingController _shippedToAddressController = TextEditingController();
  final TextEditingController _shippedToCityController = TextEditingController();
  final TextEditingController _shippedToPinCodeController = TextEditingController();
  final TextEditingController _shippedToStateController = TextEditingController();
  final TextEditingController _challanNoTitleController = TextEditingController();
  final TextEditingController _challanNoValueController = TextEditingController();
  final TextEditingController _challanDateTitleController = TextEditingController();
  final TextEditingController _challanDateValueController = TextEditingController();
  final TextEditingController _transportNameTitleController = TextEditingController();
  final TextEditingController _transportNameValueController = TextEditingController();
  final TextEditingController _extraInformationController = TextEditingController();
  final TextEditingController _shippingNoteController = TextEditingController();
  final TextEditingController _subTotalController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _discountValueController = TextEditingController();
  final TextEditingController _signatureLabelController = TextEditingController();
  Image? imagePicker;
  bool shippedFromChecked = false;
  bool shippedToChecked = false;
  List<Image> thumbnailImageList = [];
  List<List<Image>> totalThumbnailImageList = [];
  List<TextEditingController> productFieldsList = [];
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2.5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    addNewProductFields();
  }

  addNewProductFields() {
    productFieldsList = [];
    thumbnailImageList = [];
    for (int i = 0; i < 11; i++) {
      TextEditingController newTextEditingController = TextEditingController();
      productFieldsList.add(newTextEditingController);
      ref.read(discountsTypeList.notifier).state.add(Icons.percent);
    }
    ref.read(termsAndConditionList).clear();
    for (int i = 0; i < 2; i++) {
      TextEditingController newTextEditingController = TextEditingController();
      if (i == 0) {
        newTextEditingController.text =
            "Please pay within 15 days from the date of invoice, overdue interest @ 14% will be charged on delayed payments.";
      } else {
        newTextEditingController.text = "Please quote invoice number when remitting funds.";
      }
      ref.read(termsAndConditionList).add(newTextEditingController);
    }
    ref.read(totalProductFieldsList.notifier).state.add(productFieldsList);
    totalThumbnailImageList.add(thumbnailImageList);
  }

  _showAddNewClient() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const InvoiceAddClient(),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);
    availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 2.5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AxleFormTextFieldUnderline(
                      fieldHeading: "Title",
                      fieldHint: "Invoice",
                      fieldController: _titleController,
                      fieldWidth: isMobile ? screenWidth : 300,
                      lengthLimit: 256,
                    ),
                    const SizedBox(height: 15),
                    showAddSubTitle
                        ? AxleFormTextFieldUnderline(
                            fieldHeading: "Sub Title",
                            fieldHint: "Enter Sub Title...",
                            fieldController: _subtitleController,
                            fieldWidth: isMobile ? screenWidth : 400,
                            lengthLimit: 256,
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                showAddSubTitle = true;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_box_outlined,
                                  size: 20,
                                  color: AxleColors.axlePrimaryColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Add Sub Title",
                                  style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                )
                              ],
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AxleFormTextFieldUnderline(
                                  fieldHeading: 'Invoice No',
                                  fieldHint: 'Invoice No',
                                  fieldController: _invoiceNoTitleController,
                                  fieldWidth: isMobile ? screenWidth : 160,
                                  lengthLimit: 256,
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AxleFormTextFieldUnderline(
                                      fieldHeading: 'Invoice No',
                                      fieldHint: 'A00002',
                                      fieldController: _invoiceNoController,
                                      fieldWidth: isMobile ? screenWidth : 160,
                                      lengthLimit: 256,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Latest Invoice No:\nA00001(Apr 19, 2023)",
                                      style: AxleTextStyle.labelMedium.copyWith(color: Colors.grey.shade600),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                AxleFormTextFieldUnderline(
                                  fieldHeading: 'Invoice Date',
                                  fieldHint: 'Invoice Date',
                                  fieldController: _invoiceDateTitleController,
                                  fieldWidth: isMobile ? screenWidth : 160,
                                  lengthLimit: 256,
                                ),
                                const SizedBox(width: 20),
                                AxleFormTextFieldUnderline(
                                  fieldHeading: 'Invoice Date',
                                  fieldHint: 'May 03,2023',
                                  isShowSuffixIcon: true,
                                  fieldController: _invoiceDateController,
                                  fieldWidth: isMobile ? screenWidth : 160,
                                  lengthLimit: 256,
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                AxleFormTextFieldUnderline(
                                  fieldHeading: 'Due Date',
                                  fieldHint: 'Due Date',
                                  fieldController: _dueDateTitleController,
                                  fieldWidth: isMobile ? screenWidth : 160,
                                  lengthLimit: 256,
                                ),
                                const SizedBox(width: 20),
                                AxleFormTextFieldUnderline(
                                  fieldHeading: 'Due Date',
                                  fieldHint: 'May 18,2023',
                                  isShowSuffixIcon: true,
                                  fieldController: _dueDateController,
                                  fieldWidth: isMobile ? screenWidth : 160,
                                  lengthLimit: 256,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: logoSelected
                              ? Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            logoSelected = false;
                                          });
                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.black87,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.close,
                                              size: 20,
                                              color: Colors.white60,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 100, height: 100, child: imagePicker!),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          Icons.edit,
                                          size: 16,
                                          color: AxleColors.axlePrimaryColor,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Change",
                                          style: AxleTextStyle.labelLarge
                                              .copyWith(fontSize: 16, color: Colors.grey.shade700),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    await ImagePickerWeb.getImageAsWidget().then((Image? value) {
                                      if (value != null) {
                                        setState(() {
                                          imagePicker = value;
                                          logoSelected = true;
                                        });
                                      }
                                      return null;
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: AxleColors.axleWhiteColor,
                                        border: Border.all(color: const Color(0xffDCE9F6), width: 1.6),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.image_outlined, color: Colors.grey.shade600),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Add Business Logo",
                                            style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.add_box_outlined, color: AxleColors.axlePrimaryColor),
                        const SizedBox(width: 10),
                        Text(
                          "Add More Fields",
                          style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3 - 24,
                          color: AxleColors.axleBackgroundColor,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AxleFormTextFieldUnderline(
                                    fieldHeading: 'Billed By',
                                    fieldHint: 'Billed By',
                                    isShowSuffixIcon: false,
                                    fieldController: _billedByTitleController,
                                    fieldWidth: isMobile ? screenWidth : 120,
                                    lengthLimit: 256,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "(Your Details)",
                                    style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade600),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  _showAddNewClient();
                                },
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          logoSelected
                                              ? SizedBox(width: 25, height: 25, child: imagePicker!)
                                              : Image.asset('assets/images/profile_pic.png', width: 25, height: 25),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Sakthi",
                                            style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                          )
                                        ],
                                      ),
                                      const Icon(Icons.keyboard_arrow_down_rounded)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Business Details",
                                            style: AxleTextStyle.labelLarge.copyWith(fontSize: 15, color: Colors.black),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.edit, size: 15, color: AxleColors.axlePrimaryColor),
                                              const SizedBox(width: 5),
                                              Text(
                                                "Edit",
                                                style: AxleTextStyle.labelLarge
                                                    .copyWith(color: AxleColors.axlePrimaryColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Business Name",
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "Address",
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Sakthi",
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "India",
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3 - 24,
                          color: AxleColors.axleBackgroundColor,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AxleFormTextFieldUnderline(
                                    fieldHeading: 'Billed To',
                                    fieldHint: 'Billed To',
                                    isShowSuffixIcon: false,
                                    fieldController: _billedToTitleController,
                                    fieldWidth: isMobile ? screenWidth : 120,
                                    lengthLimit: 256,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "(Client Details)",
                                    style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade600),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Siva",
                                      style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down_rounded)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Business Details",
                                            style: AxleTextStyle.labelLarge.copyWith(fontSize: 15, color: Colors.black),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.edit, size: 15, color: AxleColors.axlePrimaryColor),
                                              const SizedBox(width: 5),
                                              Text(
                                                "Edit",
                                                style: AxleTextStyle.labelLarge
                                                    .copyWith(color: AxleColors.axlePrimaryColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Business Name",
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "Address",
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Siva",
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "India",
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AxleColors.axlePrimaryColor,
                          value: ref.watch(showShippingAddress),
                          onChanged: (bool? value) {
                            setState(() {
                              ref.read(showShippingAddress.notifier).state = value!;
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Add Shipping Details",
                          style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                        )
                      ],
                    ),
                    SizedBox(height: ref.watch(showShippingAddress) ? 15 : 0),
                    ref.watch(showShippingAddress)
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3 - 24,
                                color: AxleColors.axleBackgroundColor,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AxleFormTextFieldUnderline(
                                      fieldHeading: 'Shipped From',
                                      fieldHint: 'Shipped From',
                                      isShowSuffixIcon: false,
                                      fieldController: _shippedFromController,
                                      fieldWidth: isMobile ? screenWidth : 150,
                                      lengthLimit: 256,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                checkColor: Colors.white,
                                                activeColor: AxleColors.axlePrimaryColor,
                                                value: shippedFromChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    shippedFromChecked = value!;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 2.5),
                                              Text(
                                                "Same as your business address",
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: 'Business / Freelancer Name',
                                            fieldHint: 'Business / Freelancer Name',
                                            isShowSuffixIcon: false,
                                            fieldController: _shippedFromBusinessNameController,
                                            lengthLimit: 256,
                                          ),
                                          const SizedBox(height: 15),
                                          AxleSearchDropDown(
                                            fieldHint: 'Select Country',
                                            dropDownOptions: const [
                                              DropDownValueModel(name: 'India', value: 'India'),
                                              DropDownValueModel(name: 'China', value: 'China'),
                                              DropDownValueModel(name: 'Japan', value: 'Japan')
                                            ],
                                            fieldController: _shippedFromCountryController,
                                            onChanged: (dynamic data) {},
                                          ),
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: 'Address',
                                            fieldHint: 'Address (optional)',
                                            isShowSuffixIcon: false,
                                            fieldController: _shippedFromAddressController,
                                            lengthLimit: 256,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              AxleFormTextFieldUnderline(
                                                fieldHeading: 'City',
                                                fieldHint: 'City (optional)',
                                                isShowSuffixIcon: false,
                                                fieldController: _shippedFromCityController,
                                                fieldWidth: isMobile ? screenWidth : 190,
                                                lengthLimit: 256,
                                              ),
                                              AxleFormTextFieldUnderline(
                                                fieldHeading: 'Postal Code / Zip code',
                                                fieldHint: 'Postal Code / Zip code',
                                                isShowSuffixIcon: false,
                                                fieldController: _shippedFromPinCodeController,
                                                fieldWidth: isMobile ? screenWidth : 190,
                                                lengthLimit: 256,
                                              ),
                                            ],
                                          ),
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: 'State',
                                            fieldHint: 'State (optional)',
                                            isShowSuffixIcon: false,
                                            fieldController: _shippedFromStateController,
                                            lengthLimit: 256,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3 - 24,
                                color: AxleColors.axleBackgroundColor,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AxleFormTextFieldUnderline(
                                      fieldHeading: 'Shipped To',
                                      fieldHint: 'Shipped To',
                                      isShowSuffixIcon: false,
                                      fieldController: _shippedToController,
                                      fieldWidth: isMobile ? screenWidth : 150,
                                      lengthLimit: 256,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Select a Shipping Address",
                                            style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                          ),
                                          const Icon(Icons.keyboard_arrow_down_rounded)
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                checkColor: Colors.white,
                                                activeColor: AxleColors.axlePrimaryColor,
                                                value: shippedFromChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    shippedFromChecked = value!;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 2.5),
                                              Text(
                                                "Same as your client's address",
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: "Client's Business Name",
                                            fieldHint: "Client's Business Name",
                                            isShowSuffixIcon: false,
                                            fieldController: _shippedToBusinessNameController,
                                            lengthLimit: 256,
                                          ),
                                          const SizedBox(height: 15),
                                          AxleSearchDropDown(
                                            fieldHint: 'Select Country',
                                            dropDownOptions: const [
                                              DropDownValueModel(name: 'India', value: 'India'),
                                              DropDownValueModel(name: 'China', value: 'China'),
                                              DropDownValueModel(name: 'Japan', value: 'Japan')
                                            ],
                                            fieldController: _shippedToCountryController,
                                            onChanged: (dynamic data) {},
                                          ),
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: 'Address',
                                            fieldHint: 'Address (optional)',
                                            isShowSuffixIcon: false,
                                            fieldController: _shippedToAddressController,
                                            lengthLimit: 256,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              AxleFormTextFieldUnderline(
                                                fieldHeading: 'City',
                                                fieldHint: 'City (optional)',
                                                isShowSuffixIcon: false,
                                                fieldController: _shippedToCityController,
                                                fieldWidth: isMobile ? screenWidth : 190,
                                                lengthLimit: 256,
                                              ),
                                              AxleFormTextFieldUnderline(
                                                fieldHeading: 'Postal Code / Zip code',
                                                fieldHint: 'Postal Code / Zip code',
                                                isShowSuffixIcon: false,
                                                fieldController: _shippedToPinCodeController,
                                                fieldWidth: isMobile ? screenWidth : 190,
                                                lengthLimit: 256,
                                              ),
                                            ],
                                          ),
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: 'State',
                                            fieldHint: 'State (optional)',
                                            isShowSuffixIcon: false,
                                            fieldController: _shippedToStateController,
                                            lengthLimit: 256,
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              const Icon(Icons.add_box_outlined, color: AxleColors.axlePrimaryColor),
                                              const SizedBox(width: 5),
                                              Text("Add More Fields",
                                                  style:
                                                      AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700)),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    SizedBox(height: ref.watch(showShippingAddress) ? 20 : 0),
                    ref.watch(showShippingAddress)
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3 - 24,
                              color: AxleColors.axleBackgroundColor,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AxleFormTextFieldUnderline(
                                    fieldHeading: 'Transport Details',
                                    fieldHint: 'Transport Details',
                                    isShowSuffixIcon: false,
                                    fieldController: _billedToTitleController,
                                    fieldWidth: isMobile ? screenWidth : 150,
                                    lengthLimit: 256,
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AxleFormTextFieldUnderline(
                                              fieldHeading: 'Challan Number',
                                              fieldHint: 'Challan Number',
                                              isShowSuffixIcon: false,
                                              fieldController: _challanNoTitleController,
                                              fieldWidth: isMobile ? screenWidth : 190,
                                              lengthLimit: 256,
                                            ),
                                            AxleFormTextFieldUnderline(
                                              fieldHeading: 'Challan Number (optional)',
                                              fieldHint: 'Challan Number (optional)',
                                              isShowSuffixIcon: false,
                                              fieldController: _challanNoValueController,
                                              fieldWidth: isMobile ? screenWidth : 190,
                                              lengthLimit: 256,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AxleFormTextFieldUnderline(
                                              fieldHeading: 'Challan Date',
                                              fieldHint: 'Challan Date',
                                              isShowSuffixIcon: false,
                                              fieldController: _challanDateTitleController,
                                              fieldWidth: isMobile ? screenWidth : 190,
                                              lengthLimit: 256,
                                            ),
                                            AxleFormTextFieldUnderline(
                                              fieldHeading: 'Challan Date (optional)',
                                              fieldHint: 'Challan Date (optional)',
                                              isShowSuffixIcon: true,
                                              fieldController: _challanDateValueController,
                                              fieldWidth: isMobile ? screenWidth : 190,
                                              lengthLimit: 256,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AxleFormTextFieldUnderline(
                                              fieldHeading: 'Transport',
                                              fieldHint: 'Transport',
                                              isShowSuffixIcon: false,
                                              fieldController: _transportNameTitleController,
                                              fieldWidth: isMobile ? screenWidth : 190,
                                              lengthLimit: 256,
                                            ),
                                            AxleFormTextFieldUnderline(
                                              fieldHeading: 'Transport Name (optional)',
                                              fieldHint: 'Transport Name (optional)',
                                              isShowSuffixIcon: false,
                                              fieldController: _transportNameValueController,
                                              fieldWidth: isMobile ? screenWidth : 190,
                                              lengthLimit: 256,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AxleFormTextFieldUnderline(
                                              fieldHeading: 'Extra Information',
                                              fieldHint: 'Extra Information',
                                              isShowSuffixIcon: false,
                                              fieldController: _extraInformationController,
                                              fieldWidth: isMobile ? screenWidth : 190,
                                              lengthLimit: 256,
                                            ),
                                            AxleFormTextFieldUnderline(
                                              fieldHeading: 'Shipping Note (optional)',
                                              fieldHint: 'Shipping Note (optional)',
                                              isShowSuffixIcon: false,
                                              fieldController: _shippingNoteController,
                                              fieldWidth: isMobile ? screenWidth : 190,
                                              lengthLimit: 256,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (ref.watch(showGST)) {
                              ref.read(showGST.notifier).state = false;
                            } else {
                              ref.read(showGST.notifier).state = true;
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                const Icon(Icons.percent, color: AxleColors.axlePrimaryColor),
                                const SizedBox(width: 10),
                                Text(
                                  ref.watch(showGST) ? 'Remove GST' : 'Add GST',
                                  style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text("Currency", style: AxleTextStyle.labelLarge.copyWith(color: Colors.black)),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Indian Rupee(INR, ₹)",
                                    style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.confirmation_number_outlined, color: AxleColors.axlePrimaryColor),
                              const SizedBox(width: 10),
                              Text(
                                "Change number Format",
                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.table_chart_outlined, color: AxleColors.axlePrimaryColor),
                              const SizedBox(width: 10),
                              Text(
                                "Rename/Add Fields",
                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: AxleColors.axleBlueColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                      ),
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 175,
                            child: Text(
                              "Item",
                              style: AxleTextStyle.titleSmall.copyWith(color: Colors.white),
                            ),
                          ),
                          ref.watch(showGST)
                              ? SizedBox(
                                  width: 70,
                                  child: Text(
                                    "HSN/SAC",
                                    style: AxleTextStyle.titleSmall.copyWith(color: Colors.white),
                                  ),
                                )
                              : const SizedBox(),
                          ref.watch(showGST)
                              ? SizedBox(
                                  width: 70,
                                  child: Text(
                                    "GST Rate",
                                    style: AxleTextStyle.titleSmall.copyWith(color: Colors.white),
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            width: 70,
                            child: Text(
                              "Quantity",
                              style: AxleTextStyle.titleSmall.copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(
                              "Rate",
                              style: AxleTextStyle.titleSmall.copyWith(color: Colors.white),
                            ),
                          ),
                          ref.watch(showDiscountsColumn)
                              ? SizedBox(
                                  width: 70,
                                  child: Text(
                                    "Discount",
                                    style: AxleTextStyle.titleSmall.copyWith(color: Colors.white),
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            width: 70,
                            child: Text(
                              "Amount",
                              style: AxleTextStyle.titleSmall.copyWith(color: Colors.white),
                            ),
                          ),
                          ref.watch(showGST)
                              ? SizedBox(
                                  width: 70,
                                  child: Text(
                                    "CGST",
                                    style: AxleTextStyle.titleSmall.copyWith(color: Colors.white),
                                  ),
                                )
                              : const SizedBox(),
                          ref.watch(showGST)
                              ? SizedBox(
                                  width: 70,
                                  child: Text(
                                    "SGST",
                                    style: AxleTextStyle.titleSmall.copyWith(color: Colors.white),
                                  ),
                                )
                              : const SizedBox(),
                          ref.watch(showGST)
                              ? SizedBox(
                                  width: 70,
                                  child: Text(
                                    "Total",
                                    style: AxleTextStyle.titleSmall.copyWith(color: Colors.white),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(width: 50),
                        ],
                      ),
                    ),
                    ref.watch(showProductRowList)
                        ? ListView.builder(
                            itemCount: ref.watch(totalProductFieldsList).length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ProductTableRow(
                                  productRowIndex: index,
                                  thumbnailImageList: thumbnailImageList,
                                  totalProductFieldsList: ref.watch(totalProductFieldsList),
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.3 - 16,
                          decoration: BoxDecoration(
                            color: AxleColors.axleBackgroundColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              addNewProductFields();
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_box_outlined, color: AxleColors.axlePrimaryColor),
                                const SizedBox(width: 5),
                                Text(
                                  "Add New Line",
                                  style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.3 - 16,
                          decoration: BoxDecoration(
                            color: AxleColors.axleBackgroundColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_box_outlined, color: AxleColors.axlePrimaryColor),
                              const SizedBox(width: 5),
                              Text(
                                "Add New Group",
                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.225,
                        child: Column(
                          children: [
                            ref.watch(showDiscountsColumn)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Discount",
                                        style: AxleTextStyle.labelLarge.copyWith(fontSize: 16, color: Colors.black),
                                      ),
                                      AxleFormTextFieldUnderline(
                                        fieldHeading: '0',
                                        fieldHint: '0',
                                        isShowSuffixIcon: false,
                                        fieldController: _discountValueController,
                                        fieldWidth: isMobile ? screenWidth : 120,
                                        lengthLimit: 256,
                                        onChange: (String data) {
                                          for (int i = 0; i < ref.watch(totalProductFieldsList).length; i++) {
                                            ref.watch(totalProductFieldsList)[i][5].text =
                                                (int.parse(_discountValueController.text) /
                                                        ref.watch(totalProductFieldsList).length)
                                                    .toString();
                                          }
                                        },
                                      ),
                                      DiscountTypeDropdown(
                                        value: ref.watch(mainDiscountsType),
                                        onChanged: (IconData? value) {
                                          ref.read(mainDiscountsType.notifier).state = value!;
                                          for (int i = 0; i < ref.watch(discountsTypeList).length; i++) {
                                            ref.read(discountsTypeList.notifier).state[i] = value;
                                          }
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref.read(showDiscountsColumn.notifier).state = false;
                                        },
                                        icon: const Icon(Icons.close),
                                        color: AxleColors.axlePrimaryColor,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            ref.watch(showDiscountsColumn)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AxleFormTextFieldUnderline(
                                        fieldHeading: 'Sub Total',
                                        fieldHint: 'Sub Total',
                                        isShowSuffixIcon: false,
                                        fieldController: _subTotalController,
                                        fieldWidth: isMobile ? screenWidth : 120,
                                        lengthLimit: 256,
                                      ),
                                      Text(
                                        ref.watch(totalAmount).toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(height: ref.watch(showGST) || ref.watch(showDiscountsColumn) ? 15 : 0),
                            ref.watch(showGST) || ref.watch(showDiscountsColumn)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Amount",
                                        style: AxleTextStyle.labelLarge.copyWith(fontSize: 16, color: Colors.black),
                                      ),
                                      Text(
                                        ref.watch(totalAmount).toString(),
                                        style: AxleTextStyle.labelLarge.copyWith(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(height: ref.watch(showGST) ? 15 : 0),
                            ref.watch(showGST)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "CGST",
                                        style: AxleTextStyle.labelLarge.copyWith(fontSize: 16, color: Colors.black),
                                      ),
                                      Text(
                                        ref.watch(totalCGST).toStringAsFixed(2),
                                        style: AxleTextStyle.labelLarge.copyWith(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(height: ref.watch(showGST) ? 15 : 0),
                            ref.watch(showGST)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "SGST",
                                        style: AxleTextStyle.labelLarge.copyWith(fontSize: 16, color: Colors.black),
                                      ),
                                      Text(
                                        ref.watch(totalSGST).toStringAsFixed(2),
                                        style: AxleTextStyle.labelLarge.copyWith(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 15),
                            ref.watch(showDiscountOnTotal)
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: ref.watch(discountOnTotalList).length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: 'reductions',
                                            fieldHint: 'Reductions',
                                            isShowSuffixIcon: false,
                                            fieldController: _subTotalController,
                                            fieldWidth: isMobile ? screenWidth : 120,
                                            lengthLimit: 256,
                                          ),
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: '0',
                                            fieldHint: '0',
                                            isShowSuffixIcon: false,
                                            fieldController: _subTotalController,
                                            fieldWidth: isMobile ? screenWidth : 120,
                                            lengthLimit: 256,
                                          ),
                                          DiscountTypeDropdown(
                                            value: ref.watch(discountOnTotalList)[index].chargeType,
                                            onChanged: (IconData? value) {
                                              ref.read(discountOnTotalList.notifier).state[index].chargeType = value!;
                                            },
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              ref.read(discountOnTotalList.notifier).state.removeAt(index);
                                              ref.read(showDiscountOnTotal.notifier).state = false;
                                              ref.read(showDiscountOnTotal.notifier).state = true;
                                            },
                                            icon: const Icon(Icons.close, size: 25),
                                            color: AxleColors.axlePrimaryColor,
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 15),
                            ref.watch(showAdditionalCharges)
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: ref.watch(additionalChargesList).length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: 'extraCharges',
                                            fieldHint: 'Extra Charges',
                                            isShowSuffixIcon: false,
                                            fieldController: _subTotalController,
                                            fieldWidth: isMobile ? screenWidth : 120,
                                            lengthLimit: 256,
                                          ),
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: '0',
                                            fieldHint: '0',
                                            isShowSuffixIcon: false,
                                            fieldController: _subTotalController,
                                            fieldWidth: isMobile ? screenWidth : 120,
                                            lengthLimit: 256,
                                          ),
                                          DiscountTypeDropdown(
                                            value: ref.watch(additionalChargesList)[index].chargeType,
                                            onChanged: (IconData? value) {
                                              ref.read(additionalChargesList.notifier).state[index].chargeType = value!;
                                            },
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              ref.read(additionalChargesList.notifier).state.removeAt(index);
                                              ref.read(showAdditionalCharges.notifier).state = false;
                                              ref.read(showAdditionalCharges.notifier).state = true;
                                            },
                                            icon: const Icon(Icons.close, size: 25),
                                            color: AxleColors.axlePrimaryColor,
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 15),
                            ref.watch(showChargesAndDiscounts)
                                ? Column(
                                    children: [
                                      ref.watch(showDiscountsColumn)
                                          ? const SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                ref.read(showDiscountsColumn.notifier).state = true;
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    Icons.pin_drop_outlined,
                                                    size: 17.5,
                                                    color: AxleColors.axlePrimaryColor,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text("Give Item wise Discount"),
                                                ],
                                              ),
                                            ),
                                      const SizedBox(height: 15),
                                      GestureDetector(
                                        onTap: () {
                                          ref.read(discountOnTotalList.notifier).state.add(
                                                AdditionalChargesModel(
                                                  TextEditingController(),
                                                  TextEditingController(),
                                                  Icons.percent,
                                                ),
                                              );
                                          ref.read(showDiscountOnTotal.notifier).state = false;
                                          ref.read(showDiscountOnTotal.notifier).state = true;
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.add_box_outlined,
                                              size: 17.5,
                                              color: AxleColors.axlePrimaryColor,
                                            ),
                                            SizedBox(width: 10),
                                            Text("Give Discount on Total"),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      GestureDetector(
                                        onTap: () {
                                          ref.read(additionalChargesList.notifier).state.add(
                                                AdditionalChargesModel(
                                                  TextEditingController(),
                                                  TextEditingController(),
                                                  Icons.percent,
                                                ),
                                              );
                                          ref.read(showAdditionalCharges.notifier).state = false;
                                          ref.read(showAdditionalCharges.notifier).state = true;
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.add_box_outlined,
                                              size: 17.5,
                                              color: AxleColors.axlePrimaryColor,
                                            ),
                                            SizedBox(width: 10),
                                            Text("Add Additional Charges"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      ref.read(showChargesAndDiscounts.notifier).state = true;
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.discount_outlined,
                                          size: 17.5,
                                          color: AxleColors.axlePrimaryColor,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Add Discounts/Additional Charges",
                                          style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                        ),
                                      ],
                                    ),
                                  ),
                            const SizedBox(height: 20),
                            ref.watch(roundOffTotalType) != ''
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AxleFormTextFieldUnderline(
                                        fieldHeading: 'roundOff',
                                        fieldHint: ref.watch(roundOffTotalType),
                                        isShowSuffixIcon: false,
                                        fieldController: _subTotalController,
                                        fieldWidth: isMobile ? screenWidth : 120,
                                        lengthLimit: 256,
                                      ),
                                      AxleFormTextFieldUnderline(
                                        fieldHeading: '0',
                                        fieldHint: '0',
                                        isShowSuffixIcon: false,
                                        fieldController: ref.watch(roundOffDiffController),
                                        fieldWidth: isMobile ? screenWidth : 120,
                                        lengthLimit: 256,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref.read(roundOffTotalType.notifier).state = '';
                                        },
                                        icon: const Icon(Icons.close, size: 25),
                                        color: AxleColors.axlePrimaryColor,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ref.read(finalOverAllTotal.notifier).state =
                                        ref.watch(tempOverAllTotal).ceilToDouble();
                                    ref.read(roundOffDiffController.notifier).state.text =
                                        (ref.watch(finalOverAllTotal) - ref.watch(tempOverAllTotal)).toStringAsFixed(2);
                                    ref.read(roundOffTotalType.notifier).state = 'Round Up';
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.rotate_right,
                                        size: 17.5,
                                        color: AxleColors.axlePrimaryColor,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Round Up",
                                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 25),
                                GestureDetector(
                                  onTap: () {
                                    ref.read(finalOverAllTotal.notifier).state =
                                        ref.watch(tempOverAllTotal).floorToDouble();
                                    ref.read(roundOffDiffController.notifier).state.text =
                                        (ref.watch(tempOverAllTotal) - ref.watch(finalOverAllTotal)).toStringAsFixed(2);
                                    ref.read(roundOffTotalType.notifier).state = 'Round Down';
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.rotate_left,
                                        size: 17.5,
                                        color: AxleColors.axlePrimaryColor,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Round Down",
                                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    AxleFormTextFieldUnderline(
                                      fieldHeading: 'Total',
                                      fieldHint: 'Total',
                                      isShowSuffixIcon: false,
                                      fieldController: _subTotalController,
                                      fieldWidth: isMobile ? screenWidth : 120,
                                      lengthLimit: 256,
                                    ),
                                    Text(
                                      "(INR)",
                                      style: AxleTextStyle.labelLarge.copyWith(fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Text(
                                  ref.watch(finalOverAllTotal).toString(),
                                  style: AxleTextStyle.labelLarge
                                      .copyWith(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(height: ref.watch(showTotalInWords) ? 5 : 20),
                            ref.watch(showTotalInWords)
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total (in Words)",
                                            style: AxleTextStyle.labelLarge
                                                .copyWith(fontSize: 13, color: Colors.grey.shade600),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              ref.read(showTotalInWords.notifier).state = false;
                                            },
                                            icon: const Icon(Icons.close, size: 25),
                                            color: AxleColors.axlePrimaryColor,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      AxleFormTextFieldUnderline(
                                        fieldHeading: 'totalInWords',
                                        fieldHint: 'Total In Words',
                                        isShowSuffixIcon: false,
                                        fieldController: ref.watch(totalInWordsController),
                                        lengthLimit: 256,
                                      ),
                                      const SizedBox(height: 15),
                                      Divider(
                                        color: Colors.grey.shade300,
                                      ),
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      print(
                                          '#####-----000----${double.parse(ref.watch(finalOverAllTotal).toString())}');
                                      var converter = NumberToCharacterConverter('en');
                                      ref.read(totalInWordsController.notifier).state.text = converter
                                          .convertDouble(ref.watch(finalOverAllTotal))
                                          .replaceAll('comma', 'and');
                                      ref.read(showTotalInWords.notifier).state = true;
                                      print('#####-----111');
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.monetization_on_outlined,
                                          size: 17.5,
                                          color: AxleColors.axlePrimaryColor,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Show Total in Words",
                                          style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                        ),
                                      ],
                                    ),
                                  ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Icon(
                                  Icons.add_box_outlined,
                                  size: 17.5,
                                  color: AxleColors.axlePrimaryColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Add more Fields",
                                  style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              color: AxleColors.axleBackgroundColor,
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "The exchange rate is for indicative purpose only",
                                    style: AxleTextStyle.labelLarge.copyWith(fontSize: 13, color: Colors.grey.shade600),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.125,
                                        child: Text(
                                          "The exchange rate is for indicative purpose only",
                                          style: AxleTextStyle.labelLarge.copyWith(
                                            height: 1.5,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                      AxleFormTextFieldUnderline(
                                        fieldHeading: 'exchangeRate',
                                        fieldHint: '0.014396',
                                        isShowSuffixIcon: false,
                                        fieldController: _subTotalController,
                                        fieldWidth: isMobile ? screenWidth : 100,
                                        lengthLimit: 256,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.075,
                                        child: Text(
                                          "Applied Exchange Rate",
                                          style: AxleTextStyle.labelLarge.copyWith(
                                            height: 1.5,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.075,
                                        child: Text(
                                          "1 USD = 81.9672 INR",
                                          style: AxleTextStyle.labelLarge.copyWith(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
                                      child: Text(
                                        "Update Exchange Rate",
                                        style: AxleTextStyle.labelLarge.copyWith(
                                          fontSize: 13,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.375,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            runSpacing: 20.0,
                            spacing: 0.0,
                            children: [
                              ref.watch(showTermsAndCondition)
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: () {
                                        ref.read(showTermsAndCondition.notifier).state = true;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.add_box_outlined, color: AxleColors.axlePrimaryColor),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Add Terms & Conditions',
                                                style: AxleTextStyle.labelLarge
                                                    .copyWith(fontSize: 13, color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ref.watch(showNotes)
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: () {
                                        ref.read(showNotes.notifier).state = true;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.sticky_note_2_outlined,
                                                color: AxleColors.axlePrimaryColor,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Add Notes',
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ref.watch(showAttachments)
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: () {
                                        ref.read(showAttachments.notifier).state = true;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.attach_file, color: AxleColors.axlePrimaryColor),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Add Attachments',
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ref.watch(showAdditionalInfo)
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: () {
                                        ref.read(showAdditionalInfo.notifier).state = true;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.info_outline, color: AxleColors.axlePrimaryColor),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Add Additional Info',
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ref.watch(showContactDetails)
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: () {
                                        ref.read(showContactDetails.notifier).state = true;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.call, color: AxleColors.axlePrimaryColor),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Add Contact Details',
                                                style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        ref.watch(showAddSignature)
                            ? Container(
                                color: AxleColors.axleBackgroundColor,
                                width: MediaQuery.of(context).size.width * 0.2,
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12, right: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Signature',
                                            style: AxleTextStyle.labelLarge.copyWith(color: Colors.black87),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              ref.read(showAddSignature.notifier).state = false;
                                            },
                                            icon: const Icon(Icons.close, size: 25),
                                            color: AxleColors.axlePrimaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ref.watch(signatureFileList).isNotEmpty
                                        ? SizedBox(
                                            width: 300,
                                            height: 150,
                                            child: ref.watch(signatureFileList)[0],
                                          )
                                        : Signature(
                                            controller: _signatureController,
                                            width: 300,
                                            height: 150,
                                            backgroundColor: Colors.white,
                                          ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12, right: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await ImagePickerWeb.getImageAsWidget().then((value) {
                                                setState(() {
                                                  ref.read(signatureFileList.notifier).state.add(value!);
                                                });
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.file_upload_rounded,
                                                  size: 17.5,
                                                  color: AxleColors.axlePrimaryColor,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  'Upload Signature',
                                                  style: AxleTextStyle.labelLarge.copyWith(color: Colors.black87),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _signatureController.clear();
                                                ref.read(signatureFileList.notifier).state.clear();
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.rotate_left,
                                                  size: 17.5,
                                                  color: AxleColors.axlePrimaryColor,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  'Reset',
                                                  style: AxleTextStyle.labelLarge.copyWith(color: Colors.black87),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4, right: 4),
                                      child: ref.watch(showSignatureLabel)
                                          ? Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Add Signature Label',
                                                      style: AxleTextStyle.labelLarge.copyWith(color: Colors.black87),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        ref.read(showSignatureLabel.notifier).state = false;
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                        size: 20,
                                                        color: AxleColors.axlePrimaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                AxleFormTextFieldUnderline(
                                                  fieldHeading: 'signatureLabel',
                                                  fieldHint: 'Add your Name',
                                                  isShowSuffixIcon: false,
                                                  fieldController: _signatureLabelController,
                                                  lengthLimit: 256,
                                                ),
                                              ],
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                ref.read(showSignatureLabel.notifier).state = true;
                                              },
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color: Colors.grey),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.add_box_outlined,
                                                      color: AxleColors.axlePrimaryColor,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      'Add Signature Label',
                                                      style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  ref.read(showAddSignature.notifier).state = true;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.edit, color: AxleColors.axlePrimaryColor),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Add Signature',
                                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(height: ref.watch(showTermsAndCondition) ? 30 : 0),
                    ref.watch(showTermsAndCondition)
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              color: AxleColors.axleBackgroundColor,
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Terms and Conditions',
                                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.black87),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref.read(showTermsAndCondition.notifier).state = false;
                                        },
                                        icon: const Icon(Icons.close, size: 25),
                                        color: AxleColors.axlePrimaryColor,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: ref.watch(termsAndConditionList).length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: AxleFormTextFieldUnderline(
                                              fieldHeading: 'termsAndConditions',
                                              fieldHint: 'termsAndConditions',
                                              isShowSuffixIcon: false,
                                              fieldController: ref.watch(termsAndConditionList)[index],
                                              fieldWidth: isMobile ? screenWidth : 120,
                                              lengthLimit: 256,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          IconButton(
                                            onPressed: () {
                                              ref.read(showTermsAndCondition.notifier).state = false;
                                              ref.read(termsAndConditionList.notifier).state.removeAt(index);
                                              ref.read(showTermsAndCondition.notifier).state = true;
                                            },
                                            icon: const Icon(Icons.close),
                                            color: AxleColors.axlePrimaryColor,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          TextEditingController newTextEditingController = TextEditingController();
                                          ref.read(termsAndConditionList).add(newTextEditingController);
                                          ref.read(showTermsAndCondition.notifier).state = false;
                                          ref.read(showTermsAndCondition.notifier).state = true;
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.add_box_outlined, color: AxleColors.axlePrimaryColor),
                                            const SizedBox(width: 5),
                                            Text(
                                              "Add New Line",
                                              style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.add_box_outlined, color: AxleColors.axlePrimaryColor),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Add New Group",
                                            style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: ref.watch(showNotes) ? 30 : 0),
                    ref.watch(showNotes)
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.3,
                              color: AxleColors.axleBackgroundColor,
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Additional Notes',
                                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.black87),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref.read(showNotes.notifier).state = false;
                                        },
                                        icon: const Icon(Icons.close),
                                        color: AxleColors.axlePrimaryColor,
                                      ),
                                    ],
                                  ),
                                  AxleFormTextFieldUnderline(
                                    fieldHeading: 'Notes',
                                    fieldHint: 'Notes',
                                    isShowSuffixIcon: false,
                                    fieldController: _notesController,
                                    lengthLimit: 256,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: ref.watch(showAttachments) ? 30 : 0),
                    ref.watch(showAttachments)
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              color: AxleColors.axleBackgroundColor,
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Attachments',
                                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.black87),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref.read(showAttachments.notifier).state = false;
                                        },
                                        icon: const Icon(Icons.close),
                                        color: AxleColors.axlePrimaryColor,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 75,
                                        child: ListView.builder(
                                          itemCount: ref.watch(attachmentsFileList).length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context, int index) {
                                            return Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 12),
                                                  child: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: ref.watch(attachmentsFileList)[index],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      ref.watch(attachmentsFileList).removeAt(index);
                                                    });
                                                  },
                                                  child: Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Container(
                                                      width: 15,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      child: const Center(
                                                        child: Icon(Icons.close, color: Colors.white, size: 10),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await ImagePickerWeb.getImageAsWidget().then((value) {
                                            setState(() {
                                              ref.watch(attachmentsFileList).add(value!);
                                            });
                                          });
                                        },
                                        child: Container(
                                          width: 75,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: ref.watch(showAdditionalInfo) ? 30 : 0),
                    ref.watch(showAdditionalInfo)
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              color: AxleColors.axleBackgroundColor,
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Additional Information',
                                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.black87),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref.read(showAdditionalInfo.notifier).state = false;
                                        },
                                        icon: const Icon(Icons.close),
                                        color: AxleColors.axlePrimaryColor,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: ref.watch(additionalInfoList).length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: 'fieldName',
                                            fieldHint: 'Field Name',
                                            isShowSuffixIcon: false,
                                            fieldController: ref.watch(additionalInfoList)[index].fieldName,
                                            fieldWidth: isMobile ? screenWidth : 120,
                                            lengthLimit: 256,
                                          ),
                                          AxleFormTextFieldUnderline(
                                            fieldHeading: 'value',
                                            fieldHint: 'Value',
                                            isShowSuffixIcon: false,
                                            fieldController: ref.watch(additionalInfoList)[index].value,
                                            fieldWidth: isMobile ? screenWidth : 120,
                                            lengthLimit: 256,
                                          ),
                                          const SizedBox(width: 40),
                                          IconButton(
                                            onPressed: () {
                                              ref.read(additionalInfoList.notifier).state.removeAt(index);
                                              ref.read(showAdditionalInfo.notifier).state = false;
                                              ref.read(showAdditionalInfo.notifier).state = true;
                                            },
                                            icon: const Icon(Icons.close),
                                            color: AxleColors.axlePrimaryColor,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () {
                                      ref.read(additionalInfoList.notifier).state.add(
                                            AdditionalInfoModel(
                                              fieldName: TextEditingController(),
                                              value: TextEditingController(),
                                            ),
                                          );
                                      ref.read(showAdditionalInfo.notifier).state = false;
                                      ref.read(showAdditionalInfo.notifier).state = true;
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.add_box_outlined,
                                          size: 20,
                                          color: AxleColors.axlePrimaryColor,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Add more fields",
                                          style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: ref.watch(showContactDetails) ? 30 : 0),
                    ref.watch(showContactDetails)
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              color: AxleColors.axleBackgroundColor,
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Your Contact Details',
                                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.black87),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref.read(showContactDetails.notifier).state = false;
                                        },
                                        icon: const Icon(Icons.close),
                                        color: AxleColors.axlePrimaryColor,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'For any enquiry, reach out via',
                                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        'Email at',
                                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                      ),
                                      const SizedBox(width: 10),
                                      AxleFormTextFieldUnderline(
                                        fieldWidth: 200,
                                        fieldHeading: 'email',
                                        fieldHint: 'Your email',
                                        isShowSuffixIcon: false,
                                        fieldController: _contactEmailController,
                                        lengthLimit: 256,
                                        prefixIcon: const Icon(Icons.mail_rounded, size: 20),
                                        isShowPrefixAmount: true,
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        'Call on',
                                        style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                      ),
                                      const SizedBox(width: 10),
                                      AxleFormTextFieldUnderline(
                                        fieldWidth: 200,
                                        fieldHeading: 'phoneNumber',
                                        fieldHint: 'Phone number',
                                        isShowSuffixIcon: false,
                                        fieldController: _contactEmailController,
                                        lengthLimit: 256,
                                        prefixIcon: const Icon(Icons.phone, size: 20),
                                        isShowPrefixAmount: true,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: AxleColors.axleBackgroundColor,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  activeColor: AxleColors.axlePrimaryColor,
                                  value: ref.watch(recurringInvoice),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      ref.read(recurringInvoice.notifier).state = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'This is a recurring invoice.',
                                  style: AxleTextStyle.labelLarge.copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'A draft invoice will be created with same details every next period.',
                              style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AxleOutlineButton(
                          buttonText: 'Save As Draft',
                          buttonStyle: AxleTextStyle.outLineButtonStyle,
                          buttonWidth: isMobile ? 100.0 : 200.0,
                          onPress: () {},
                        ),
                        const SizedBox(width: 20.0),
                        AxlePrimaryButton(
                          buttonText: 'Save And Continue',
                          buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                          buttonWidth: isMobile ? 200.0 : 200.0,
                          onPress: () async {
                            CreateInvoiceInputModel createInvoiceInputModel = getInvoiceInputDetails();
                            final bool res =
                                await ref.read(invoiceControllerProvider).fetchCreateInvoice(createInvoiceInputModel);
                            print('#####----res----$res');
                            AxleLoader.hide();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getInvoiceInputDetails() {
    List<String> termsAndConditionsList = [];
    List<Products> productsList = [];
    for (TextEditingController data in ref.watch(termsAndConditionList)) {
      termsAndConditionsList.add(data.text);
    }
    for (List<TextEditingController> data in ref.watch(totalProductFieldsList)) {
      productsList.add(
        Products(
          item: data[0].text,
          hSNSAC: data[1].text,
          gstRate: data[2].text,
          quantity: data[3].text,
          rate: data[4].text,
          amount: data[6].text,
          cgst: data[7].text,
          sgst: data[8].text,
          total: data[9].text,
          discription: data[10].text,
          thumbnail: '',
        ),
      );
    }
    return CreateInvoiceInputModel(
      userId: "1",
      businessLogo: "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
      invoiceNo: _invoiceNoController.text,
      invoiceDate: _invoiceDateController.text,
      duedate: _dueDateController.text,
      billedById: "1",
      billedToId: "2",
      shippedFrom: ShippedFrom(
        businessName: _shippedFromBusinessNameController.text,
        country: _shippedFromCountryController.text,
        address: _shippedFromAddressController.text,
        city: _shippedFromCityController.text,
        pincode: _shippedFromPinCodeController.text,
        state: _shippedFromStateController.text,
      ),
      shippedTo: ShippedFrom(
        businessName: _shippedToBusinessNameController.text,
        country: _shippedToCountryController.text,
        address: _shippedToAddressController.text,
        city: _shippedToCityController.text,
        pincode: _shippedToPinCodeController.text,
        state: _shippedToStateController.text,
      ),
      transportDetails: TransportDetails(
        challanNo: _challanNoValueController.text,
        challanDate: _challanDateValueController.text,
        transportName: _transportNameValueController.text,
        shippingNote: _shippingNoteController.text,
      ),
      products: productsList,
      amount: ref.watch(totalAmount).toString(),
      sgst: ref.watch(totalSGST).toStringAsFixed(2),
      cgst: ref.watch(totalCGST).toStringAsFixed(2),
      total: '${ref.watch(totalCGST) + ref.watch(totalSGST) + ref.watch(totalAmount)}',
      addTermsCondition: termsAndConditionsList,
      note: _notesController.text,
      addAttachment: " ",
      addSignature: " ",
      addAdditionalInfo: [AddAdditionalInfo(fieldName: "sample FName one", value: "sample value one")],
      addContactDetails: AddContactDetails(email: _contactEmailController.text, phone: _contactNumberController.text),
      invoiceRepeat: "false",
      nextRepeatDate: "",
      options: "Create as draft",
    );
  }
}

class ProductTableRow extends ConsumerStatefulWidget {
  const ProductTableRow({
    Key? key,
    required this.productRowIndex,
    required this.thumbnailImageList,
    required this.totalProductFieldsList,
  }) : super(key: key);

  final int productRowIndex;
  final List<Image> thumbnailImageList;
  final List<List<TextEditingController>> totalProductFieldsList;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductTableRowState();
}

class _ProductTableRowState extends ConsumerState<ProductTableRow> {
  bool isMobile = false;
  double screenWidth = 0.0;
  bool enableDescription = false;
  bool enableThumbnail = false;
  double tempAmount = 0.0;
  double tempCGST = 0.0;
  double tempSGST = 0.0;

  @override
  void initState() {
    super.initState();
    widget.totalProductFieldsList[widget.productRowIndex][2].text = "18";
    widget.totalProductFieldsList[widget.productRowIndex][3].text = "1";
    widget.totalProductFieldsList[widget.productRowIndex][4].text = "1";
    widget.totalProductFieldsList[widget.productRowIndex][5].text = "0";
    widget.totalProductFieldsList[widget.productRowIndex][6].text = "1.00";
    widget.totalProductFieldsList[widget.productRowIndex][7].text = ref.read(showGST) ? "0.09" : "0";
    widget.totalProductFieldsList[widget.productRowIndex][8].text = ref.read(showGST) ? "0.09" : "0";
    widget.totalProductFieldsList[widget.productRowIndex][9].text = ref.read(showGST) ? "1.18" : "1";
  }

  getTotalAmount() {
    int amount = 0;
    double cgst = 0;
    double sgst = 0;
    if (ref.read(showGST)) {
      for (int i = 0; i < widget.totalProductFieldsList.length; i++) {
        for (int j = 0; j < widget.totalProductFieldsList[i].length; j++) {
          if (j == 6) {
            amount = amount + double.parse(widget.totalProductFieldsList[i][j].text).toInt();
          }
          if (j == 7) {
            cgst = cgst + double.parse(widget.totalProductFieldsList[i][j].text);
          }
          if (j == 8) {
            sgst = sgst + double.parse(widget.totalProductFieldsList[i][j].text);
          }
        }
      }
    } else {
      for (int i = 0; i < widget.totalProductFieldsList.length; i++) {
        for (int j = 0; j < widget.totalProductFieldsList[i].length; j++) {
          if (j == 6) {
            amount = amount + double.parse(widget.totalProductFieldsList[i][j].text).toInt();
          }
        }
      }
    }
    ref.read(totalCGST.notifier).state = cgst;
    ref.read(totalSGST.notifier).state = sgst;
    ref.read(totalAmount.notifier).state = amount;
    ref.read(finalOverAllTotal.notifier).state = cgst + sgst + amount.toDouble();
    ref.read(tempOverAllTotal.notifier).state = cgst + sgst + amount.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AxleColors.axleBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 175,
                  child: AxleFormTextFieldUnderline(
                    fieldHeading: 'Item Name',
                    fieldHint: 'Item Name(Required)',
                    isShowSuffixIcon: false,
                    fieldController: widget.totalProductFieldsList[widget.productRowIndex][0],
                    fieldWidth: isMobile ? screenWidth : 175,
                    lengthLimit: 256,
                  ),
                ),
                ref.watch(showGST)
                    ? AxleFormTextFieldUnderline(
                        fieldHeading: 'HSN/SAC',
                        fieldHint: 'HSN/SAC',
                        isShowSuffixIcon: false,
                        fieldController: widget.totalProductFieldsList[widget.productRowIndex][1],
                        fieldWidth: isMobile ? screenWidth : 70,
                        lengthLimit: 256,
                      )
                    : const SizedBox(),
                ref.watch(showGST)
                    ? AxleFormTextFieldUnderline(
                        fieldHeading: 'GST',
                        fieldHint: 'GST',
                        isShowSuffixIcon: false,
                        fieldController: widget.totalProductFieldsList[widget.productRowIndex][2],
                        fieldWidth: isMobile ? screenWidth : 70,
                        lengthLimit: 256,
                        isOnlyDigits: true,
                        onChange: (String? data) {
                          widget.totalProductFieldsList[widget.productRowIndex][7].text = ((double.parse(data!) *
                                      double.parse(widget.totalProductFieldsList[widget.productRowIndex][3].text) *
                                      double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) /
                                      100) /
                                  2)
                              .toStringAsFixed(2);
                          widget.totalProductFieldsList[widget.productRowIndex][8].text = ((double.parse(data) *
                                      double.parse(widget.totalProductFieldsList[widget.productRowIndex][3].text) *
                                      double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) /
                                      100) /
                                  2)
                              .toStringAsFixed(2);
                          widget.totalProductFieldsList[widget.productRowIndex][9]
                              .text = ((double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) +
                                      (double.parse(data) *
                                          double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) /
                                          100)) *
                                  double.parse(widget.totalProductFieldsList[widget.productRowIndex][3].text))
                              .toStringAsFixed(2);
                          getTotalAmount();
                          tempCGST = double.parse(widget.totalProductFieldsList[widget.productRowIndex][7].text);
                          tempSGST = double.parse(widget.totalProductFieldsList[widget.productRowIndex][8].text);
                        },
                      )
                    : const SizedBox(),
                AxleFormTextFieldUnderline(
                  fieldHeading: 'Quantity',
                  fieldHint: 'Quant',
                  isShowSuffixIcon: false,
                  fieldController: widget.totalProductFieldsList[widget.productRowIndex][3],
                  fieldWidth: isMobile ? screenWidth : 70,
                  lengthLimit: 256,
                  onChange: (String? data) {
                    widget.totalProductFieldsList[widget.productRowIndex][6].text =
                        (double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) *
                                double.parse(data!))
                            .toStringAsFixed(2);
                    widget.totalProductFieldsList[widget.productRowIndex][7].text =
                        ((double.parse(widget.totalProductFieldsList[widget.productRowIndex][2].text) *
                                    double.parse(data) *
                                    double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) /
                                    100) /
                                2)
                            .toStringAsFixed(2);
                    widget.totalProductFieldsList[widget.productRowIndex][8].text =
                        ((double.parse(widget.totalProductFieldsList[widget.productRowIndex][2].text) *
                                    double.parse(data) *
                                    double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) /
                                    100) /
                                2)
                            .toStringAsFixed(2);
                    widget.totalProductFieldsList[widget.productRowIndex][9].text =
                        ((double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) +
                                    (double.parse(widget.totalProductFieldsList[widget.productRowIndex][2].text) *
                                        double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) /
                                        100)) *
                                double.parse(data))
                            .toStringAsFixed(2);
                    getTotalAmount();
                    tempAmount = double.parse(widget.totalProductFieldsList[widget.productRowIndex][6].text);
                    tempCGST = double.parse(widget.totalProductFieldsList[widget.productRowIndex][7].text);
                    tempSGST = double.parse(widget.totalProductFieldsList[widget.productRowIndex][8].text);
                  },
                ),
                AxleFormTextFieldUnderline(
                  fieldHeading: 'Rt',
                  fieldHint: 'Rt',
                  isShowSuffixIcon: false,
                  fieldController: widget.totalProductFieldsList[widget.productRowIndex][4],
                  fieldWidth: isMobile ? screenWidth : 70,
                  lengthLimit: 256,
                  onChange: (String? data) {
                    widget.totalProductFieldsList[widget.productRowIndex][6].text =
                        (double.parse(widget.totalProductFieldsList[widget.productRowIndex][3].text) *
                                double.parse(data!))
                            .toStringAsFixed(2);
                    widget.totalProductFieldsList[widget.productRowIndex][7].text =
                        ((double.parse(widget.totalProductFieldsList[widget.productRowIndex][2].text) *
                                    double.parse(widget.totalProductFieldsList[widget.productRowIndex][3].text) *
                                    double.parse(data) /
                                    100) /
                                2)
                            .toStringAsFixed(2);
                    widget.totalProductFieldsList[widget.productRowIndex][8].text =
                        ((double.parse(widget.totalProductFieldsList[widget.productRowIndex][2].text) *
                                    double.parse(widget.totalProductFieldsList[widget.productRowIndex][3].text) *
                                    double.parse(data) /
                                    100) /
                                2)
                            .toStringAsFixed(2);
                    widget.totalProductFieldsList[widget.productRowIndex][9].text = ((double.parse(data) +
                                (double.parse(widget.totalProductFieldsList[widget.productRowIndex][2].text) *
                                    double.parse(data) /
                                    100)) *
                            double.parse(widget.totalProductFieldsList[widget.productRowIndex][3].text))
                        .toStringAsFixed(2);
                    getTotalAmount();
                    tempAmount = double.parse(widget.totalProductFieldsList[widget.productRowIndex][6].text);
                    tempCGST = double.parse(widget.totalProductFieldsList[widget.productRowIndex][7].text);
                    tempSGST = double.parse(widget.totalProductFieldsList[widget.productRowIndex][8].text);
                  },
                ),
                ref.watch(showDiscountsColumn)
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AxleFormTextFieldUnderline(
                            fieldHeading: 'Discount',
                            fieldHint: 'Dis',
                            isShowSuffixIcon: false,
                            fieldController: widget.totalProductFieldsList[widget.productRowIndex][5],
                            fieldWidth: isMobile ? screenWidth : 70,
                            lengthLimit: 256,
                            onChange: (String? data) {
                              if (ref.watch(discountsTypeList)[widget.productRowIndex].codePoint == 984391) {
                                widget.totalProductFieldsList[widget.productRowIndex][6].text =
                                    (tempAmount - ((double.parse(data!) * 0.01) * tempAmount)).toStringAsFixed(2);
                                widget.totalProductFieldsList[widget.productRowIndex][7].text =
                                    (tempCGST - ((double.parse(data) * 0.01) * tempCGST)).toStringAsFixed(2);
                                widget.totalProductFieldsList[widget.productRowIndex][8].text =
                                    (tempSGST - ((double.parse(data) * 0.01) * tempSGST)).toStringAsFixed(2);
                              } else {
                                widget.totalProductFieldsList[widget.productRowIndex][6].text =
                                    (tempAmount - double.parse(data!)).toStringAsFixed(2);
                                widget.totalProductFieldsList[widget.productRowIndex][7].text =
                                    (tempCGST - ((double.parse(data) / 2) * 0.1)).toStringAsFixed(2);
                                widget.totalProductFieldsList[widget.productRowIndex][8].text =
                                    (tempSGST - ((double.parse(data) / 2) * 0.1)).toStringAsFixed(2);
                              }
                            },
                          ),
                          DiscountTypeDropdown(
                            value: ref.watch(discountsTypeList)[widget.productRowIndex],
                            onChanged: (IconData? value) {
                              ref.read(discountsTypeList.notifier).state[widget.productRowIndex] = value!;
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
                AxleFormTextFieldUnderline(
                  fieldHeading: 'Amt',
                  fieldHint: 'Amt',
                  isShowSuffixIcon: false,
                  fieldController: widget.totalProductFieldsList[widget.productRowIndex][6],
                  fieldWidth: isMobile ? screenWidth : 70,
                  lengthLimit: 256,
                  onChange: (String? data) {
                    widget.totalProductFieldsList[widget.productRowIndex][4].text = (double.parse(data!) /
                            double.parse(widget.totalProductFieldsList[widget.productRowIndex][3].text))
                        .toStringAsFixed(2);
                    widget.totalProductFieldsList[widget.productRowIndex][7].text =
                        ((double.parse(widget.totalProductFieldsList[widget.productRowIndex][2].text) *
                                    double.parse(widget.totalProductFieldsList[widget.productRowIndex][3].text) *
                                    double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) /
                                    100) /
                                2)
                            .toStringAsFixed(2);
                    widget.totalProductFieldsList[widget.productRowIndex][8].text =
                        ((double.parse(widget.totalProductFieldsList[widget.productRowIndex][2].text) *
                                    double.parse(widget.totalProductFieldsList[widget.productRowIndex][3].text) *
                                    double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) /
                                    100) /
                                2)
                            .toStringAsFixed(2);
                    widget.totalProductFieldsList[widget.productRowIndex][9].text =
                        ((double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) +
                                    (double.parse(widget.totalProductFieldsList[widget.productRowIndex][2].text) *
                                        double.parse(widget.totalProductFieldsList[widget.productRowIndex][4].text) /
                                        100)) *
                                double.parse(widget.totalProductFieldsList[widget.productRowIndex][3].text))
                            .toStringAsFixed(2);
                    getTotalAmount();
                    tempCGST = double.parse(widget.totalProductFieldsList[widget.productRowIndex][7].text);
                    tempSGST = double.parse(widget.totalProductFieldsList[widget.productRowIndex][8].text);
                  },
                ),
                ref.watch(showGST)
                    ? AxleFormTextFieldUnderline(
                        fieldHeading: 'CGST',
                        fieldHint: 'CGST',
                        isShowSuffixIcon: false,
                        fieldController: widget.totalProductFieldsList[widget.productRowIndex][7],
                        fieldWidth: isMobile ? screenWidth : 70,
                        lengthLimit: 256,
                      )
                    : const SizedBox(),
                ref.watch(showGST)
                    ? AxleFormTextFieldUnderline(
                        fieldHeading: 'SGST',
                        fieldHint: 'SGST',
                        isShowSuffixIcon: false,
                        fieldController: widget.totalProductFieldsList[widget.productRowIndex][8],
                        fieldWidth: isMobile ? screenWidth : 70,
                        lengthLimit: 256,
                      )
                    : const SizedBox(),
                ref.watch(showGST)
                    ? AxleFormTextFieldUnderline(
                        fieldHeading: 'tl',
                        fieldHint: 'tl',
                        isShowSuffixIcon: false,
                        fieldController: widget.totalProductFieldsList[widget.productRowIndex][9],
                        fieldWidth: isMobile ? screenWidth : 70,
                        lengthLimit: 256,
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: IconButton(
                    onPressed: () {
                      ref.read(showProductRowList.notifier).state = false;
                      ref.read(totalProductFieldsList.notifier).state.removeAt(widget.productRowIndex);
                      ref.read(showProductRowList.notifier).state = true;
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            enableThumbnail && enableDescription
                ? Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: AxleFormTextFieldUnderline(
                          fieldHeading: 'Description',
                          fieldHint: 'Description',
                          isShowSuffixIcon: false,
                          fieldController: widget.totalProductFieldsList[widget.productRowIndex][10],
                          fieldWidth: isMobile ? screenWidth : 70,
                          lengthLimit: 256,
                        ),
                      ),
                      const SizedBox(height: 10),
                      thumbnailView()
                    ],
                  )
                : enableDescription
                    ? Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: AxleFormTextFieldUnderline(
                              fieldHeading: 'tl',
                              fieldHint: 'tl',
                              isShowSuffixIcon: false,
                              fieldController: widget.totalProductFieldsList[widget.productRowIndex][10],
                              fieldWidth: isMobile ? screenWidth : 70,
                              lengthLimit: 256,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                enableThumbnail = true;
                              });
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.image_outlined, color: AxleColors.axlePrimaryColor),
                                const SizedBox(width: 10),
                                Text(
                                  "Add Thumbnail",
                                  style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : enableThumbnail
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    enableDescription = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.add_box_outlined, color: AxleColors.axlePrimaryColor),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Add Description",
                                      style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              thumbnailView()
                            ],
                          )
                        : Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    enableDescription = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.add_box_outlined, color: AxleColors.axlePrimaryColor),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Add Description",
                                      style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 50),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    enableThumbnail = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.image_outlined, color: AxleColors.axlePrimaryColor),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Add Thumbnail",
                                      style: AxleTextStyle.labelLarge.copyWith(color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  Widget thumbnailView() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          ListView.builder(
            itemCount: widget.thumbnailImageList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(width: 50, height: 50, child: widget.thumbnailImageList[index]),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.thumbnailImageList.removeAt(index);
                      });
                    },
                    child: Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Icon(Icons.close, color: Colors.white, size: 10),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () async {
              await ImagePickerWeb.getImageAsWidget().then((value) {
                setState(() {
                  widget.thumbnailImageList.add(value!);
                });
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
              child: const Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 10),
                  Text("Upload Thumbnail"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
