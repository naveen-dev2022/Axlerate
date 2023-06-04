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
import 'package:axlerate/src/features/home/form_widgets/address_details_form.dart';
import 'package:axlerate/src/features/home/form_widgets/address_details_form_with_copy.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/partner/presentation/controller/parter_ui_controller.dart';
import 'package:axlerate/src/features/home/partner/presentation/controller/partner_controller.dart';
import 'package:axlerate/src/features/home/partner/presentation/widgets/partner_details_form.dart';
import 'package:axlerate/src/features/home/form_widgets/form_section_heading_widget.dart';
import 'package:axlerate/src/features/home/partner/domain/create_partner_input_model.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CreatePartnerPage extends ConsumerStatefulWidget {
  const CreatePartnerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateCustomerPageState();
}

class _CreateCustomerPageState extends ConsumerState<CreatePartnerPage> {
  final GlobalKey<FormState> createPartnerFormKey = GlobalKey<FormState>();

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
  // * Commison Controllers
  final TextEditingController _tagCommisionController = TextEditingController();
  final TextEditingController _ppiCommisionController = TextEditingController();

  @override
  void dispose() {
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
            margin: isMobile
                ? const EdgeInsets.all(defaultPadding)
                : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
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
                      InputFormConstants.createPartner,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // * Basic Partner Details
                      Container(
                        decoration: CommonStyleUtil.createUserFormCardStyle,
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            maintainState: true,
                            leading: const Icon(Icons.person),
                            childrenPadding: const EdgeInsets.all(0),
                            title: const FormSectionHeadingWidget(
                              title: InputFormConstants.partnerDetails,
                              subTitle: InputFormConstants.mandatoryHint,
                            ),
                            expandedAlignment: Alignment.centerLeft,
                            children: [
                              PartnerDetailsForm(
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
                            maintainState: true,
                            leading: const Icon(Icons.location_city),
                            title: const FormSectionHeadingWidget(
                                title: InputFormConstants.permanentAddressTitle,
                                subTitle: InputFormConstants.mandatoryHint),
                            expandedAlignment: Alignment.centerLeft,
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
                            maintainState: true,
                            leading: const Icon(Icons.location_city),
                            title: const FormSectionHeadingWidget(
                              title: InputFormConstants.communicationAddressTitle,
                              subTitle: InputFormConstants.mandatoryHint,
                            ),
                            expandedAlignment: Alignment.centerLeft,
                            children: [
                              AddressDetailsFormWithCopy(
                                address1Controller: _address1ControllerC,
                                address2Controller: _address2ControllerC,
                                cityController: _cityControllerC,
                                stateController: _stateControllerC,
                                countryController: _countryControllerC,
                                pinCodeController: _pincodeControllerC,
                                showWithCheckBox: true,
                                checkBoxValue: ref.watch(partnerCopyAddressProvider),
                                checkBoxDesc: HomeConstants.clickIfSameAsPermanentAddress,
                                onCheckBoxChange: (value) {
                                  ref.read(partnerCopyAddressProvider.notifier).state = value ?? false;
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
                            maintainState: true,
                            leading: const Icon(Icons.person_rounded),
                            title: const FormSectionHeadingWidget(
                              title: InputFormConstants.adminDetailsSectionTitle,
                              subTitle: InputFormConstants.mandatoryHint,
                            ),
                            expandedAlignment: Alignment.centerLeft,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(isMobile ? defaultPadding : verticalPadding),
                                child: AxleFormTextField(
                                  fieldHeading: InputFormConstants.mobileNumberFieldLabel,
                                  fieldHint: InputFormConstants.mobileNumberFieldHint,
                                  fieldController: _adminUserNameController,
                                  validate: Validators(InputFormConstants.mobileNumberFieldLabel).required(),
                                  fieldWidth: isMobile ? screenWidth : 320,
                                  isRequiredField: true,
                                  isOnlyDigits: true,
                                  textType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30.0),
                        height: 30.0,
                        width: 2.0,
                        color: primaryColor,
                      ),
                      // * Commision Percentage
                      Container(
                        decoration: CommonStyleUtil.createUserFormCardStyle,
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            maintainState: true,
                            leading: const Icon(Icons.location_city),
                            title: const FormSectionHeadingWidget(
                              title: InputFormConstants.commisonPercentage,
                              subTitle: InputFormConstants.mandatoryHint,
                            ),
                            expandedAlignment: Alignment.centerLeft,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(isMobile ? defaultPadding : verticalPadding),
                                child: Wrap(
                                  runSpacing: defaultPadding,
                                  spacing: defaultPadding,
                                  children: [
                                    AxleFormTextField(
                                      fieldHeading: "Partner Commission % for FASTag",
                                      fieldHint: "Enter Commission %",
                                      fieldController: _tagCommisionController,
                                      validate: Validators('Partner Commission % for FASTag').required().min(1).max(3),
                                      lengthLimit: 3,
                                      isOnlyDigits: true,
                                      textType: TextInputType.number,
                                      fieldWidth: isMobile ? screenWidth : 350,
                                      isRequiredField: true,
                                      isFieldEnabled: !_tagCommisionController.text.contains('.'),
                                    ),
                                    AxleFormTextField(
                                      fieldHeading: "Partner Commission % for PPI Card",
                                      fieldHint: "Enter Commission %",
                                      fieldController: _ppiCommisionController,
                                      validate:
                                          Validators('Partner Commission % for PPI Card').required().min(1).max(3),
                                      lengthLimit: 3,
                                      isOnlyDigits: true,
                                      textType: TextInputType.number,
                                      fieldWidth: isMobile ? screenWidth : 350,
                                      isRequiredField: true,
                                      isFieldEnabled: !_ppiCommisionController.text.contains('.'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AxleOutlineButton(
                              buttonText: InputFormConstants.cancelbuttonText,
                              buttonStyle: AxleTextStyle.outLineButtonStyle,
                              buttonWidth: isMobile ? 100.0 : 200.0,
                              onPress: () {
                                context.router.pushNamed(RouteUtils.getPartnersPath());
                              },
                            ),
                            const SizedBox(width: 20.0),
                            AxlePrimaryButton(
                              buttonText: InputFormConstants.saveAndContinueText,
                              buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                              buttonWidth: isMobile ? 200.0 : 200.0,
                              onPress: () async {
                                if (createPartnerFormKey.currentState!.validate()) {
                                  if (checkValidPercentage()) {
                                    final formInputModel = createPartnerFormInput();
                                    AxleLoader.show(context);
                                    bool res = await ref.read(partnerControllerProvider).createPartner(formInputModel);
                                    AxleLoader.hide();
                                    if (res && mounted) {
                                      context.router.pushNamed(RouteUtils.getPartnersPath());
                                      ref.read(listofPartnersStateProvider.notifier).state =
                                          await ref.read(partnerControllerProvider).getPartnersList(
                                                queryParams: ListOrgsQueryParams(
                                                  organizationType: 'PARTNER',
                                                ),
                                              );
                                    }
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

  bool checkValidPercentage() {
    final val1 = int.parse(_tagCommisionController.text);
    final val2 = int.parse(_ppiCommisionController.text);

    if (val1 > 100 || val2 > 100) {
      Snackbar.error('Commision Percentage should be less than 100');
      return false;
    }
    return true;
  }

  CreatePartnerInputModel createPartnerFormInput() {
    return CreatePartnerInputModel(
      title: _salutationController.text,
      firstName: _orgFirstNameController.text,
      lastName: _ownerLastNameController.text,
      email: _emailController.text,
      incorporateDate: dob ?? DateTime.now(),
      natureOfBusiness: _natureOfBusinessController.text.toValueCase,
      panNumber: _panNumberController.text,
      contactNumber: _mobileNumberController.text,
      addresses: PartnerAddresses(
        communicationAddress: PartnerAddress(
          addressLine1: _address1ControllerC.text,
          addressLine2: _address2ControllerC.text,
          city: _cityControllerC.text,
          country: _countryControllerC.text,
          state: _stateControllerC.text,
          zipCode: _pincodeControllerC.text,
        ),
        officeAddress: PartnerAddress(
          addressLine1: _address1ControllerP.text,
          addressLine2: _address2ControllerP.text,
          city: _cityControllerP.text,
          country: _countryControllerP.text,
          state: _stateControllerP.text,
          zipCode: _pincodeControllerP.text,
        ),
      ),
      admin: PartnerAdmin(userName: _adminUserNameController.text),
      tagCashBackPercentage: double.parse(_tagCommisionController.text.toString()),
      ppiCashBackPercentage: double.parse(_ppiCommisionController.text.toString()),
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
