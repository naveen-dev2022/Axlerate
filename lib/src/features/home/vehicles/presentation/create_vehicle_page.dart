import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_providers/list_org_by_type_provider.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/dialogs/dialog_models/axle_alert_dialog_mode.dart';
import 'package:axlerate/src/dialogs/dialog_models/create_vehicle_alert_dialog.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/form_widgets/form_section_heading_widget.dart';
import 'package:axlerate/src/features/home/home_contants.dart';
import 'package:axlerate/src/features/home/user/domain/list_orgs_by_type_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/create_vehicle_input_model.dart';
import 'package:axlerate/src/features/home/vehicles/domain/vehicle_query_params.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/date_picker_util.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

@RoutePage()
class CreateVehiclePage extends ConsumerStatefulWidget {
  const CreateVehiclePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateVehiclePageState();
}

class _CreateVehiclePageState extends ConsumerState<CreateVehiclePage> {
  final GlobalKey<FormState> createvehicleFormKey = GlobalKey<FormState>();

  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _pickedCustomerId = TextEditingController();
  final TextEditingController _regNumberController = TextEditingController();
  final TextEditingController _regDateController = TextEditingController();
  DateTime? regDate;
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _engineNumberController = TextEditingController();
  final TextEditingController _chasisNumberController = TextEditingController();
  final TextEditingController _fuelTypeController = TextEditingController();
  final TextEditingController _fitnessDateController = TextEditingController();
  DateTime? fitnessDate;
  final TextEditingController _insuranceController = TextEditingController();
  DateTime? insuranceDate;
  // final TextEditingController _mobileNumberController = TextEditingController(text: true ? '9876543210' : '');
  final TextEditingController _makerController = TextEditingController();

  bool isPartnerAdmin = false;
  String partnerOrgEnrollmentId = '';

  @override
  void initState() {
    initValues();
    super.initState();
  }

  initValues() {}

  bool isMobile = false;
  double availableWidth = 0.0;
  DateTime? pickedRegDate;
  DateTime? pickedFitnessExpDate;
  DateTime? pickedInsuranceExpDate;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);
    availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    if (ref.watch(localStorageProvider).getOrgType() == OrgType.partner) {
      isPartnerAdmin = true;
      partnerOrgEnrollmentId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
    }

    if (ref.watch(localStorageProvider).getOrgType() == OrgType.logisticsAdmin) {
      _pickedCustomerId.text = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AxleColors.axleBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: isMobile
                ? const EdgeInsets.all(defaultPadding)
                : const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: Form(
              key: createvehicleFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isMobile
                      ? Column(
                          children: [
                            GestureDetector(
                                onTap: () => context.router.pushNamed(RouteUtils.getVehiclesPath()),
                                child: Text("< Back", style: AxleTextStyle.labelLarge)),
                            const SizedBox(height: defaultPadding)
                          ],
                        )
                      : Row(
                          children: [
                            IconButton(
                              onPressed: () => context.router.pushNamed(RouteUtils.getVehiclesPath()),
                              icon: const Icon(Icons.arrow_back, color: AxleColors.axlePrimaryColor),
                            ),
                            Text(HomeConstants.createVehicle,
                                style: AxleTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: CommonStyleUtil.axleListingCardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (ref.watch(localStorageProvider).getOrgType() != OrgType.logisticsAdmin)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FormSectionHeadingWidget(
                                title: HomeConstants.customerDetails,
                                subTitle: InputFormConstants.mandatoryHint,
                              ),
                              const Divider(
                                color: AxleColors.axleShadowColor,
                              ),
                              const SizedBox(height: 20),
                              Wrap(
                                runSpacing: 20.0,
                                spacing: 60.0,
                                children: [
                                  ref.watch(listOrgByTypeProvider('LOGISTICS')).when(
                                        data: (response) {
                                          List<ListOrgByTypeDoc> allList = response.data.message.docs;
                                          return AxleSearchDropDownField(
                                            fieldHeading: InputFormConstants.customerNameFieldLabel,
                                            fieldHint: InputFormConstants.customerNameFieldHint,
                                            fieldWidth: isMobile ? screenWidth : 320,
                                            fieldController: _customerNameController,
                                            dropDownOptions: allList
                                                .map((item) =>
                                                    '${item.enrollmentId} - ${item.firstName} ${item.lastName}')
                                                .toList(),
                                            validate: Validators(InputFormConstants.customerNameFieldLabel).required(),
                                            isRequired: true,
                                            onChanged: (val) {
                                              _customerNameController.text = val!;
                                              // log('Entered Function ');
                                              final picked = _customerNameController.text.split('-').first.trim();
                                              // log('Entered SelectedID - $picked');
                                              for (final item in allList) {
                                                // log('${item.enrollmentId}  - 1');
                                                if (item.enrollmentId == picked) {
                                                  // log('${item.enrollmentId}  - 2');
                                                  _pickedCustomerId.text = item.id;
                                                  // log('Controller -> ${_pickedCustomerId.text}');
                                                  break;
                                                }
                                              }
                                              // log('Entered SelectedID 2');
                                            },
                                          );
                                        },
                                        error: (error, stackTrace) => const Text('Error'),
                                        loading: () => const CircularProgressIndicator(),
                                      ),
                                  // AxleSearchDropDownField(
                                  //   fieldHeading: InputFormConstants.customerNameFieldLabel,
                                  //   fieldHint: InputFormConstants.customerNameFieldHint,
                                  //   fieldController: _customerNameController,
                                  //   fieldWidth: isMobile ? screenWidth : 320,
                                  //   dropDownOptions: [],
                                  //   validate: Validators(InputFormConstants.customerNameFieldLabel).required(),
                                  //   isRequired: true,
                                  //   onChanged: (val) {
                                  //     _customerNameController.text = val!;
                                  //   },
                                  // ),
                                  // AxleSearchDropDownField(
                                  //   fieldHeading: InputFormConstants.customerOrgFieldName,
                                  //   fieldHint: InputFormConstants.partnerOrgFieldHint,
                                  //   fieldWidth: isMobile ? screenWidth : 320,
                                  //   fieldController: _partnerOrgNameController,
                                  //   dropDownOptions: [],
                                  //   validate: Validators(InputFormConstants.typeOfOrgFieldlabel).required(),
                                  //   isRequired: true,
                                  //   onChanged: (val) {
                                  //     _partnerOrgNameController.text = val!;
                                  //   },
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        const FormSectionHeadingWidget(
                          title: HomeConstants.vehicleDetails,
                          subTitle: InputFormConstants.mandatoryHint,
                        ),
                        const Divider(
                          color: AxleColors.axleShadowColor,
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          runSpacing: verticalPadding,
                          spacing: defaultPadding,
                          alignment: WrapAlignment.start,
                          children: [
                            // * Reg Number, Reg Date, Vehicle type
                            AxleFormTextField(
                              fieldHeading: InputFormConstants.regNumberFieldLabel,
                              fieldHint: InputFormConstants.regNumberFieldHint,
                              fieldController: _regNumberController,
                              fieldWidth: isMobile ? screenWidth : 320,
                              validate: Validators(InputFormConstants.regNumberFieldLabel).required(),
                              isRequiredField: true,
                              lengthLimit: 16,
                              textCapitalization: TextCapitalization.characters,
                            ),
                            GestureDetector(
                              onTap: () async {
                                DateTime? date =
                                    await DatePickerUtil.pickDate(context, showRecentPicked: pickedRegDate);
                                pickedRegDate = date;
                                if (date != null) {
                                  _regDateController.text = DatePickerUtil.userViewDateFormatter(date);
                                  regDate = date;
                                }
                              },
                              child: AxleFormTextField(
                                fieldHeading: InputFormConstants.regDateFieldLabel,
                                fieldHint: InputFormConstants.regDateFieldHint,
                                fieldController: _regDateController,
                                fieldWidth: isMobile ? screenWidth : 320,
                                validate: Validators(InputFormConstants.regDateFieldLabel).required(),
                                isRequiredField: true,
                                isFieldEnabled: false,
                              ),
                            ),
                            AxleSearchDropDownField(
                              fieldHeading: InputFormConstants.vehicleCategoryFieldLabel,
                              fieldHint: InputFormConstants.vehicleCategoryFieldHint,
                              fieldController: _vehicleTypeController,
                              onChanged: (val) {
                                _vehicleTypeController.text = val!;
                              },
                              fieldWidth: isMobile ? screenWidth : 320,
                              dropDownOptions: vehicleCategoryList,
                              validate: Validators(InputFormConstants.vehicleCategoryFieldLabel).required(),
                              isRequired: true,
                            ),

                            // * Engine Number
                            AxleFormTextField(
                              fieldHeading: InputFormConstants.engineNumberFieldLabel,
                              fieldHint: InputFormConstants.engineNumberFieldHint,
                              fieldController: _engineNumberController,
                              fieldWidth: isMobile ? screenWidth : 320,
                              validate: Validators(InputFormConstants.engineNumberFieldLabel).required(),
                              isRequiredField: true,
                              lengthLimit: 64,
                            ),

                            // * Chasis Number
                            AxleFormTextField(
                              fieldHeading: InputFormConstants.chasisNumberFieldLabel,
                              fieldHint: InputFormConstants.chasisNumberFieldHint,
                              fieldController: _chasisNumberController,
                              fieldWidth: isMobile ? screenWidth : 320,
                              validate: Validators(InputFormConstants.chasisNumberFieldLabel).required(),
                              isRequiredField: true,
                              lengthLimit: 20,
                            ),

                            // * Fuel type
                            AxleSearchDropDownField(
                              fieldHeading: InputFormConstants.fuelTypeFieldLabel,
                              fieldHint: InputFormConstants.fuelTypeFieldHint,
                              fieldController: _fuelTypeController,
                              fieldWidth: isMobile ? screenWidth : 320,
                              onChanged: (val) {
                                _fuelTypeController.text = val!;
                              },
                              dropDownOptions: vehicleFuelType,
                              validate: Validators(InputFormConstants.fuelTypeFieldLabel).required(),
                              isRequired: true,
                            ),
                            // * Fitness Date, Insurance Date, Model Name
                            GestureDetector(
                              onTap: () async {
                                DateTime? date = await DatePickerUtil.pickDate(context,
                                    showRecentPicked: pickedFitnessExpDate, showFuture: true);
                                pickedFitnessExpDate = date;
                                if (date != null) {
                                  _fitnessDateController.text = DatePickerUtil.userViewDateFormatter(date);
                                  fitnessDate = date;
                                }
                              },
                              child: AxleFormTextField(
                                fieldHeading: InputFormConstants.fitnessFieldLabel,
                                fieldHint: InputFormConstants.fitnessFieldHint,
                                fieldController: _fitnessDateController,
                                fieldWidth: isMobile ? screenWidth : 320,
                                validate: Validators(InputFormConstants.fitnessFieldLabel).required(),
                                isRequiredField: true,
                                isFieldEnabled: false,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                DateTime? date = await DatePickerUtil.pickDate(context,
                                    showRecentPicked: pickedInsuranceExpDate, showFuture: true);
                                pickedInsuranceExpDate = date;
                                if (date != null) {
                                  _insuranceController.text = DatePickerUtil.userViewDateFormatter(date);
                                  insuranceDate = date;
                                }
                              },
                              child: AxleFormTextField(
                                fieldHeading: InputFormConstants.insuranceDateLabel,
                                fieldHint: InputFormConstants.insuranceDateHint,
                                fieldController: _insuranceController,
                                fieldWidth: isMobile ? screenWidth : 320,
                                validate: Validators(InputFormConstants.insuranceDateLabel).required(),
                                isRequiredField: true,
                                isFieldEnabled: false,
                              ),
                            ),

                            // * Maker / Manufacturer Name
                            AxleFormTextField(
                              fieldHeading: InputFormConstants.modelFieldLabel,
                              fieldHint: InputFormConstants.modelFieldHint,
                              fieldController: _makerController,
                              fieldWidth: isMobile ? screenWidth : 320,
                              validate: Validators(InputFormConstants.modelFieldLabel).required(),
                              isRequiredField: true,
                              lengthLimit: 20,
                            ),
                            // // * Mobile Number
                            // AxleFormTextField(
                            //   fieldHeading: InputFormConstants.mobileNumberFieldLabel,
                            //   fieldHint: InputFormConstants.mobileNumberFieldHint,
                            //   fieldController: _mobileNumberController,
                            //   fieldWidth: isMobile ? screenWidth : 320,
                            //   // validate: Validators(InputFormConstants.modelFieldLabel).required(),
                            //   isRequiredField: true,
                            // ),
                          ],
                        ),
                        SizedBox(height: isMobile ? 20 : 50.0),
                        Row(
                          mainAxisAlignment: isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                          children: [
                            AxleOutlineButton(
                              buttonWidth: isMobile ? availableWidth * 40 / 100 : availableWidth * 15 / 100,
                              buttonText: HomeConstants.cancelBT,
                              buttonStyle: AxleTextStyle.saveAndContinuePrimaryStyle,
                              onPress: () async {
                                bool result = await const AxleExitAlertDialog().present(context) ?? false;
                                if (result && mounted) {
                                  context.router.pushNamed(RouteUtils.getVehiclesPath());
                                }
                              },
                            ),
                            const SizedBox(width: 12.0),
                            AxlePrimaryButton(
                              buttonWidth: isMobile ? availableWidth * 40 / 100 : availableWidth * 15 / 100,
                              buttonText: HomeConstants.submitBT,
                              buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                              onPress: () async {
                                if (createvehicleFormKey.currentState!.validate() && mounted) {
                                  AxleLoader.show(context);

                                  CreateVehicleInputModel formInput = getFormData();
                                  final bool res = await ref.read(vehicleControllerProvider).createVehicle(formInput);
                                  AxleLoader.hide();
                                  if (res && mounted) {
                                    context.router.pushNamed(RouteUtils.getVehiclesPath());
                                    ref.read(listofVehiclesStateProvider.notifier).state = null;
                                    ref.read(listofVehiclesStateProvider.notifier).state = await ref
                                        .read(vehicleControllerProvider)
                                        .getVehiclesList(params: VehicleQueryParams(pageIndex: 1, size: 15));
                                  }
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CreateVehicleInputModel getFormData() {
    return CreateVehicleInputModel(
      organizationId: _pickedCustomerId.text,
      registrationNumber: _regNumberController.text.trim(),
      registrationDate: regDate.toString(),
      engineNumber: _engineNumberController.text.trim(),
      chasisNumber: _chasisNumberController.text.trim(),
      fuelType: _fuelTypeController.text.trim().toValueCase,
      // contactNumber: _mobileNumberController.text.trim(),
      insuranceExpiryDate: insuranceDate.toString(),
      fitnessUpto: fitnessDate.toString(),
      vehicleType: CreateVehicleType(
        maker: _makerController.text.trim(),
      ),
      vehicleCategory: _vehicleTypeController.text,
    );
  }
}
