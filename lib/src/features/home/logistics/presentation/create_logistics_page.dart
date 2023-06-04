import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_models/list_orgs_query_params.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/logistics/domain/create_logistics_input_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_ui_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/widgets/logistics_details_form.dart';
import 'package:axlerate/src/features/home/form_widgets/address_details_form.dart';
import 'package:axlerate/src/features/home/form_widgets/form_section_heading_widget.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/form_widgets/address_details_form_with_copy.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CreateLogisticsPage extends ConsumerStatefulWidget {
  const CreateLogisticsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateCustomerPageState();
}

class _CreateCustomerPageState extends ConsumerState<CreateLogisticsPage> {
  final GlobalKey<FormState> createPartnerFormKey = GlobalKey<FormState>();

  final TextEditingController _orgCodeController = TextEditingController();
  final TextEditingController _salutationController = TextEditingController();
  final TextEditingController _orgFirstNameController = TextEditingController();
  final TextEditingController _ownerLastNameController = TextEditingController();
  final TextEditingController _dateFieldController = TextEditingController();
  DateTime? dob;
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _panNumberController = TextEditingController();
  final TextEditingController _natureOfBusinessController = TextEditingController();
  // * Permanent Address Controllers
  final TextEditingController _address1ControllerP = TextEditingController();
  final TextEditingController _address2ControllerP = TextEditingController();
  final TextEditingController _cityControllerP = TextEditingController();
  final TextEditingController _stateControllerP = TextEditingController();
  final TextEditingController _countryControllerP = TextEditingController(text: 'India');
  final TextEditingController _pincodeControllerP = TextEditingController();
  // * Communication Address Controllers
  final TextEditingController _address1ControllerC = TextEditingController();
  final TextEditingController _address2ControllerC = TextEditingController();
  final TextEditingController _cityControllerC = TextEditingController();
  final TextEditingController _stateControllerC = TextEditingController();
  final TextEditingController _countryControllerC = TextEditingController(text: 'India');
  final TextEditingController _pincodeControllerC = TextEditingController();
  final TextEditingController _adminUserNameController = TextEditingController();

  @override
  void dispose() {
    _orgCodeController.dispose();
    _salutationController.dispose();
    _orgFirstNameController.dispose();
    _ownerLastNameController.dispose();
    _dateFieldController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
    _panNumberController.dispose();
    _natureOfBusinessController.dispose();
    _address1ControllerC.dispose();
    _address2ControllerC.dispose();
    _cityControllerC.dispose();
    _stateControllerC.dispose();
    _countryControllerC.dispose();
    _pincodeControllerC.dispose();
    _address1ControllerP.dispose();
    _address2ControllerP.dispose();
    _cityControllerP.dispose();
    _stateControllerP.dispose();
    _countryControllerP.dispose();
    _pincodeControllerP.dispose();
    _adminUserNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: createPartnerFormKey,
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          if (context.router.canNavigateBack) {
                            context.router.pop();
                          }
                        },
                        child: Text("<-", style: AxleTextStyle.headingPrimary)),
                    const SizedBox(width: defaultPadding),
                    Text(
                      InputFormConstants.createCustomer,
                      style: AxleTextStyle.headingPrimary,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  // decoration: CommonStyleUtil.axleContainerDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         Icon(Icons.person),
                      //         VerticalDivider(
                      //           color: Colors.green,
                      //           width: 2.0,
                      //         ),
                      //       ],
                      //     ),
                      // * Basic Details
                      Container(
                        decoration: CommonStyleUtil.createUserFormCardStyle,
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            // tilePadding: const EdgeInsets.all(0),
                            expandedAlignment: Alignment.topLeft,
                            maintainState: true,
                            leading: const Icon(Icons.person),
                            childrenPadding: const EdgeInsets.all(0),
                            title: const FormSectionHeadingWidget(
                              title: InputFormConstants.customerrDetails,
                              subTitle: InputFormConstants.mandatoryHint,
                            ),
                            children: [
                              LogisticsDetailsForm(
                                orgCodeController: _orgCodeController,
                                titleController: _salutationController,
                                orgFirstNameController: _orgFirstNameController,
                                ownerLastNameController: _ownerLastNameController,
                                dateFieldController: _dateFieldController,
                                mobileController: _mobileNumberController,
                                emailController: _emailController,
                                panNumberController: _panNumberController,
                                natureOfBusinessController: _natureOfBusinessController,
                                onTap: (val) {
                                  dob = val;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      //   ],
                      // ),

                      // * Permanent Address
                      Container(
                        margin: const EdgeInsets.only(left: 30.0),
                        height: 30.0,
                        width: 2.0,
                        color: primaryColor,
                      ),

                      Container(
                        decoration: CommonStyleUtil.createUserFormCardStyle,
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            expandedAlignment: Alignment.topLeft,
                            maintainState: true,
                            leading: const Icon(Icons.location_city),
                            title: const FormSectionHeadingWidget(
                              title: InputFormConstants.permanentAddressTitle,
                              subTitle: InputFormConstants.mandatoryHint,
                            ),
                            children: [
                              AddressDetailsForm(
                                address1Controller: _address1ControllerP,
                                address2Controller: _address2ControllerP,
                                cityController: _cityControllerP,
                                stateController: _stateControllerP,
                                countryController: _countryControllerP,
                                pinCodeController: _pincodeControllerP,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // * Communication Address
                      Container(
                        margin: const EdgeInsets.only(left: 30.0),
                        height: 30.0,
                        width: 2.0,
                        color: primaryColor,
                      ),
                      Container(
                        decoration: CommonStyleUtil.createUserFormCardStyle,
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            expandedAlignment: Alignment.topLeft,
                            maintainState: true,
                            leading: const Icon(Icons.location_city),
                            title: const FormSectionHeadingWidget(
                              title: InputFormConstants.communicationAddressTitle,
                              subTitle: InputFormConstants.mandatoryHint,
                            ),
                            children: [
                              AddressDetailsFormWithCopy(
                                address1Controller: _address1ControllerC,
                                address2Controller: _address2ControllerC,
                                cityController: _cityControllerC,
                                stateController: _stateControllerC,
                                countryController: _countryControllerC,
                                pinCodeController: _pincodeControllerC,
                                showWithCheckBox: true,
                                checkBoxValue: ref.watch(logisticsCopyAddressProvider),
                                checkBoxDesc: HomeConstants.clickIfSameAsPermanentAddress,
                                onCheckBoxChange: (value) {
                                  ref.read(logisticsCopyAddressProvider.notifier).state = value ?? false;
                                  if (value ?? false) {
                                    fillCommunicationAddress();
                                  } else {
                                    clearCommunicationAddress();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      // * Admin Details
                      Container(
                        margin: const EdgeInsets.only(left: 30.0),
                        height: 30.0,
                        width: 2.0,
                        color: primaryColor,
                      ),
                      Container(
                        decoration: CommonStyleUtil.createUserFormCardStyle,
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            expandedAlignment: Alignment.topLeft,
                            maintainState: true,
                            leading: const Icon(Icons.person_rounded),
                            title: const FormSectionHeadingWidget(
                              title: InputFormConstants.adminDetailsSectionTitle,
                              subTitle: InputFormConstants.mandatoryHint,
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: AxleFormTextField(
                                  fieldHeading: InputFormConstants.mobileNum,
                                  fieldHint: InputFormConstants.mobileNumberFieldHint,
                                  fieldController: _adminUserNameController,
                                  validate: Validators(InputFormConstants.userMobileNoFieldLabel).required(),
                                  fieldWidth: isMobile ? screenWidth : 320,
                                  isRequiredField: true,
                                  isOnlyDigits: true,
                                  textType: TextInputType.number,
                                  lengthLimit: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(defaultMobilePadding),
                        child: Row(
                          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                          children: [
                            AxleOutlineButton(
                              buttonText: InputFormConstants.cancelbuttonText,
                              buttonStyle: AxleTextStyle.outLineButtonStyle,
                              buttonWidth: isMobile ? 100.0 : 200.0,
                              onPress: () {
                                context.router.pushNamed(RouteUtils.getCustomerspath());
                              },
                            ),
                            const SizedBox(width: defaultPadding),
                            AxlePrimaryButton(
                              buttonText: InputFormConstants.saveAndContinueText,
                              buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                              buttonWidth: 200.0,
                              onPress: () async {
                                // log(dob.toString());
                                if (createPartnerFormKey.currentState!.validate()) {
                                  AxleLoader.show(context);
                                  final formInputModel = createLogisticsFormInput();
                                  bool res =
                                      await ref.read(logisticsControllerProvider).createLogistics(formInputModel);
                                  AxleLoader.hide();
                                  if (res && mounted) {
                                    context.router.pushNamed(RouteUtils.getCustomerspath());
                                    ref.read(listofLogisticsStateProvider.notifier).state = await ref
                                        .read(logisticsControllerProvider)
                                        .getLogisticsList(
                                            queryParams: ListOrgsQueryParams(
                                                organizationType: 'LOGISTICS', pageIndex: 1, size: 15));
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CreateLogisticsInputModel createLogisticsFormInput() {
    // DateTime? selected = ref.read(logisticsSelectedDateProvider.notifier).state;
    // final DateTime dob = selected ?? DateTime.now();

    return CreateLogisticsInputModel(
      orgCode: _orgCodeController.text,
      title: _salutationController.text,
      firstName: _orgFirstNameController.text,
      lastName: _ownerLastNameController.text,
      email: _emailController.text,
      incorporateDate: dob ?? DateTime.now(),
      natureOfBusiness: _natureOfBusinessController.text.toValueCase,
      panNumber: _panNumberController.text,
      contactNumber: _mobileNumberController.text,
      addresses: OrgAddresses(
        communicationAddress: OrgAddress(
          addressLine1: _address1ControllerC.text,
          addressLine2: _address2ControllerC.text,
          city: _cityControllerC.text,
          country: _countryControllerC.text,
          state: _stateControllerC.text,
          zipCode: _pincodeControllerC.text,
        ),
        officeAddress: OrgAddress(
          addressLine1: _address1ControllerP.text,
          addressLine2: _address2ControllerP.text,
          city: _cityControllerP.text,
          country: _countryControllerP.text,
          state: _stateControllerP.text,
          zipCode: _pincodeControllerP.text,
        ),
      ),
      admin: Admin(userName: _adminUserNameController.text),
    );
  }

  // Clears communication address fields
  void clearCommunicationAddress() {
    _address2ControllerC.clear();
    _address1ControllerC.clear();
    _cityControllerC.clear();
    _stateControllerC.clear();
    // _countryControllerC.clear();
    _pincodeControllerC.clear();
  }

  // Fills communication address with Permanent Address
  void fillCommunicationAddress() {
    _address2ControllerC.text = _address2ControllerP.text;
    _address1ControllerC.text = _address1ControllerP.text;
    _cityControllerC.text = _cityControllerP.text;
    _stateControllerC.text = _stateControllerP.text;
    _countryControllerC.text = _countryControllerP.text;
    _pincodeControllerC.text = _pincodeControllerP.text;
  }
}
