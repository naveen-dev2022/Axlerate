import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/main.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/form_widgets/address_details_form.dart';
import 'package:axlerate/src/features/home/form_widgets/address_details_form_with_copy.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/logistics/domain/create_logistics_input_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_ui_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/widgets/logistics_details_form.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class CompleteInvitedLogistics extends ConsumerStatefulWidget {
  const CompleteInvitedLogistics({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompleteInvitedLogisticsState();
}

class _CompleteInvitedLogisticsState extends ConsumerState<CompleteInvitedLogistics> {
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double availabeWidth = 0.0;
  bool isMobile = false;

  final GlobalKey<FormState> completeLogisticsRegFormKey = GlobalKey<FormState>();

  final TextEditingController _orgCodeController = TextEditingController();
  final TextEditingController _salutationController = TextEditingController();
  final TextEditingController _orgFirstNameController = TextEditingController();
  final TextEditingController _ownerLastNameController = TextEditingController();
  final TextEditingController _dateFieldController = TextEditingController();
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

  String orgType = '';
  String orgId = '';
  DateTime? dob;

  @override
  void initState() {
    orgType = sharedPreferences.getString(Storage.currentlyPickedOrgCode) ?? '';
    orgId = sharedPreferences.getString(Storage.currentlyPickedOrgId) ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    availabeWidth = screenWidth - (sideMenuWidth + (horizontalPadding * 2));
    isMobile = Responsive.isMobile(context);

    if (isMobile) {
      availabeWidth = screenWidth - defaultPadding * 2;
    }

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: appBlue,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isMobile ? defaultPadding : horizontalPadding,
              vertical: isMobile ? defaultPadding : verticalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/new_assets/icons/axlerate_logo.svg'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome to Axlerate,", style: AxleTextStyle.displaySmall.copyWith(color: Colors.black)),
                      Text("Please fill the form", style: AxleTextStyle.headline5BlackStyle),
                    ],
                  ),
                  if (!isMobile) SvgPicture.asset('assets/new_assets/icons/complete_reg_header.svg'),
                ],
              ),
              if (isMobile)
                Row(
                  children: [
                    SvgPicture.asset('assets/new_assets/icons/complete_reg_header.svg'),
                  ],
                ),
              Container(
                width: availabeWidth,
                decoration: CommonStyleUtil.axleContainerDecoration,
                child: Column(
                  children: [
                    Form(
                      key: completeLogisticsRegFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: isMobile ? defaultPadding : defaultPadding * 2,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: isMobile ? defaultPadding : defaultPadding * 2),
                            child: Text(
                              "${InputFormConstants.customerrDetails} - $orgType",
                              style: AxleTextStyle.headingPrimary,
                            ),
                          ),
                          LogisticsDetailsForm(
                            showOrgCode: false,
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
                          SizedBox(
                            height: isMobile ? defaultMobilePadding : defaultPadding,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: isMobile ? defaultPadding : defaultPadding * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Permanent office address",
                                  style: AxleTextStyle.headingPrimary,
                                ),
                                const SizedBox(height: defaultMobilePadding),
                                Flexible(
                                  child: Text(
                                    "Fill the Registered Office Address Details (All fields marked * are mandatory)",
                                    overflow: TextOverflow.ellipsis,
                                    style: AxleTextStyle.formSectionHintStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AddressDetailsForm(
                            address1Controller: _address1ControllerP,
                            address2Controller: _address2ControllerP,
                            cityController: _cityControllerP,
                            stateController: _stateControllerP,
                            countryController: _countryControllerP,
                            pinCodeController: _pincodeControllerP,
                          ),
                          SizedBox(
                            height: isMobile ? defaultMobilePadding : defaultPadding,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: isMobile ? defaultPadding : defaultPadding * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Communication Address",
                                  style: AxleTextStyle.headingPrimary,
                                ),
                                const SizedBox(height: defaultMobilePadding),
                                Flexible(
                                  child: Text(
                                    "Fill the Registered Office Address Details (All fields marked * are mandatory)",
                                    overflow: TextOverflow.ellipsis,
                                    style: AxleTextStyle.formSectionHintStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: AxlePrimaryButton(
                            buttonWidth: isMobile ? (availabeWidth - defaultMobilePadding * 3) : 300,
                            buttonText: "Submit",
                            onPress: () async {
                              if (completeLogisticsRegFormKey.currentState!.validate()) {
                                AxleLoader.show(context);
                                bool res = await ref.read(logisticsControllerProvider).updateLogistics(
                                      orgId,
                                      updateLogisticsFormInput(),
                                    );

                                if (res && mounted) {
                                  await ref
                                      .read(sharedPreferenceProvider)
                                      .setString(Storage.selectedOrgStatus, 'ACTIVE');
                                  // Navigate to Dashboard
                                  // log('Gonna Load');
                                  final orgEnrollId = ref
                                          .read(sharedPreferenceProvider)
                                          .getString(Storage.currentlyPickedOrgEnrollId) ??
                                      '';
                                  AxleLoader.hide();
                                  // ignore: use_build_context_synchronously
                                  context.router.popUntilRouteWithName('/app/${orgEnrollId.toLowerCase()}/dashboard');
                                  // log('Load Over');
                                } else {
                                  AxleLoader.hide();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              //   child: Center(
              //     child: AxlePrimaryButton(
              //       buttonWidth: availabeWidth,
              //       buttonText: "Submit",
              //       onPress: () async {
              //         AxleLoader.show(context);
              //         bool res = await ref.read(logisticsControllerProvider).updateLogistics(
              //               orgId,
              //               updateLogisticsFormInput(),
              //             );
              //         AxleLoader.hide();
              //         if (res && mounted) {
              //           await ref.read(sharedPreferenceProvider).setString(Storage.selectedOrgStatus, 'ACTIVE');
              //           // Navigate to Dashboard
              //           // log('Gonna Load');
              //           final orgEnrollId =
              //               ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
              //           // ignore: use_build_context_synchronously
              //           context.pushReplacement('/app/${orgEnrollId.toLowerCase()}/dashboard');
              //           // log('Load Over');
              //         }
              //       },
              //     ),
              //   ),
              // )
            ],
          ),
        )),
      ),
    );
  }

  CreateLogisticsInputModel updateLogisticsFormInput() {
    // DateTime? selected = ref.read(logisticsSelectedDateProvider.notifier).state;
    // final DateTime dob = selected ?? DateTime.now();

    return CreateLogisticsInputModel(
      orgCode: '',
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
      admin: Admin(userName: ''),
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
