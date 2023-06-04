import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
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
import 'package:axlerate/src/features/home/user/presentstion/controller/ui_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:go_router/go_router.dart';
@RoutePage()
class CreateUserPage extends ConsumerStatefulWidget {
  const CreateUserPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends ConsumerState<CreateUserPage> {
  final GlobalKey<FormState> createUserFormKey = GlobalKey<FormState>();

  final TextEditingController _typeOforgController = TextEditingController();
  final TextEditingController _partnerOrgNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _selectedIdController = TextEditingController();

  String pickedOrgId = '';

  @override
  void initState() {
    super.initState();
  }

  bool isSuperAdmin = false;
  List<String> organisationTypeList = ['Customer Organization'];

  double screenWidth = 0.0;
  double availableWidth = 0.0;
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);
    availableWidth = screenWidth - (sideMenuWidth + horizontalPadding * 2);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }
    if (ref.read(localStorageProvider).getOrgType() == OrgType.axlerate) {
      isSuperAdmin = true;
      organisationTypeList = typeOfOrganizationList;
    }

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AxleColors.axleBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Form(
                key: createUserFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isMobile
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () => context.router.pushNamed(RouteUtils.getStaffsPath()),
                                      child: Text("< Back", style: AxleTextStyle.labelLarge))
                                ],
                              ),
                              const SizedBox(height: defaultPadding)
                            ],
                          )
                        : Row(
                            children: [
                              // IconButton(
                              //   onPressed: () => context.router.pushNamed(RouteUtils.getStaffsPath()),
                              //   icon: const Icon(
                              //     Icons.arrow_back,
                              //     color: AxleColors.axlePrimaryColor,
                              //   ),
                              // ),
                              InkWell(
                                  onTap: (() {
                                    context.router.pushNamed(RouteUtils.getStaffsPath());
                                  }),
                                  child: Text("<-", style: AxleTextStyle.headingPrimary)),
                              const SizedBox(width: defaultPadding),
                              Text(HomeConstants.createStaff, style: AxleTextStyle.headingPrimary)
                            ],
                          ),
                    const SizedBox(height: defaultPadding),
                    Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: CommonStyleUtil.axleListingCardDecoration,
                      child: Column(
                        children: [
                          if (isSuperAdmin)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FormSectionHeadingWidget(
                                  title: HomeConstants.organizationDetails,
                                  subTitle: InputFormConstants.mandatoryHint,
                                ),
                                const Divider(
                                  color: AxleColors.axleShadowColor,
                                ),
                                const SizedBox(height: defaultPadding),
                                Wrap(
                                  runSpacing: 20.0,
                                  spacing: 60.0,
                                  children: [
                                    AxleSearchDropDownField(
                                      fieldHeading: InputFormConstants.typeOfOrgFieldlabel,
                                      fieldHint: InputFormConstants.typeOfOrgFieldHint,
                                      fieldController: _typeOforgController,
                                      fieldWidth: isMobile ? screenWidth : 320,
                                      dropDownOptions: organisationTypeList,
                                      validate: Validators(InputFormConstants.typeOfOrgFieldlabel).required(),
                                      isRequired: true,
                                      onChanged: (val) {
                                        _typeOforgController.text = val!;
                                        setSelectedOrgType(val!);
                                      },
                                    ),
                                    ref.watch(selectedOrgTypeProvider).isNotEmpty
                                        ? ref.watch(selectedOrgTypeListProvider(null)).when(
                                              data: (response) {
                                                final selectedOrg = ref.read(selectedOrgTypeProvider);
                                                List<ListOrgByTypeDoc> allList = response.data.message.docs;
                                                return AxleSearchDropDownField(
                                                  fieldHeading: selectedOrg.startsWith('P')
                                                      ? InputFormConstants.partnerOrgFieldName
                                                      : InputFormConstants.customerOrgFieldName,
                                                  fieldHint: InputFormConstants.partnerOrgFieldHint,
                                                  fieldWidth: isMobile ? screenWidth : 320,
                                                  fieldController: _partnerOrgNameController,
                                                  dropDownOptions: allList
                                                      .map((item) =>
                                                          '${item.enrollmentId} - ${item.firstName} ${item.lastName} - ${item.city}')
                                                      .toList(),
                                                  validate: Validators(selectedOrg.startsWith('P')
                                                          ? InputFormConstants.partnerOrgFieldName
                                                          : InputFormConstants.customerOrgFieldName)
                                                      .required(),
                                                  isRequired: true,
                                                  onChanged: (val) {
                                                    _partnerOrgNameController.text = val!;
                                                    // log('Entered Function ');
                                                    final picked =
                                                        _partnerOrgNameController.text.split('-').first.trim();
                                                    // log('Entered SelectedID - $picked');
                                                    for (final item in allList) {
                                                      // log('${item.enrollmentId}  - 1');
                                                      if (item.enrollmentId == picked) {
                                                        // log('${item.enrollmentId}  - 2');

                                                        _selectedIdController.text = item.id;
                                                        // log('Controller -> ${_selectedIdController.text}');
                                                        break;
                                                      }
                                                    }
                                                    // log('Entered SelectedID 2');
                                                  },
                                                );
                                              },
                                              error: (error, stackTrace) => const Text('Error'),
                                              loading: () => const CircularProgressIndicator(),
                                            )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          //
                          SizedBox(height: isMobile ? 0 : defaultPadding),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FormSectionHeadingWidget(
                                title: HomeConstants.userDetails,
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
                                  AxleFormTextField(
                                    fieldHeading: InputFormConstants.mobileNum,
                                    fieldHint: InputFormConstants.mobileNumberFieldHint,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    fieldController: _userNameController,
                                    isOnlyDigits: true,
                                    textType: TextInputType.number,
                                    lengthLimit: 10,
                                    validate: Validators(InputFormConstants.userMobileNoFieldLabel).required(),
                                    isRequiredField: true,
                                  ),
                                  AxleSearchDropDownField(
                                    fieldHeading: InputFormConstants.roleOfUserFieldLabel,
                                    fieldHint: InputFormConstants.roleOfUserFieldHint,
                                    fieldController: _roleController,
                                    fieldWidth: isMobile ? screenWidth : 320,
                                    dropDownOptions: userRoleList,
                                    validate: Validators(InputFormConstants.roleOfUserFieldLabel).required(),
                                    isRequired: true,
                                    onChanged: (val) {
                                      _typeOforgController.text = val!;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                            children: [
                              AxleOutlineButton(
                                buttonWidth: isMobile ? availableWidth * 40 / 100 : availableWidth * 20 / 100,
                                buttonText: HomeConstants.cancelBT,
                                buttonStyle: AxleTextStyle.saveAndContinuePrimaryStyle,
                                onPress: () async {
                                  bool result = await const AxleExitAlertDialog().present(context) ?? false;
                                  if (result && mounted) {
                                    context.router.pushNamed(RouteUtils.getStaffsPath());
                                  }
                                },
                              ),
                              const SizedBox(width: 12.0),
                              AxlePrimaryButton(
                                buttonWidth: isMobile ? availableWidth * 40 / 100 : availableWidth * 20 / 100,
                                buttonText: HomeConstants.submitBT,
                                buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                onPress: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (!isSuperAdmin) {
                                    _selectedIdController.text =
                                        ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ??
                                            '';
                                  }
                                  // print('''
                                  //  userName: ${_userNameController.text},
                                  //         underOrgId: ${_selectedIdController.text},
                                  //         role: ${_roleController.text.toValueCase},
                                  // ''');
                                  if (createUserFormKey.currentState!.validate() && mounted) {
                                    // log('validated');
                                    AxleLoader.show(context);
                                    bool res = await ref.read(userControllerProvider).createUser(
                                          userName: _userNameController.text,
                                          underOrgId: _selectedIdController.text,
                                          role: _roleController.text.toValueCase,
                                        );
                                    AxleLoader.hide();
                                    if (res && mounted) {
                                      context.router.pushNamed(RouteUtils.getStaffsPath());
                                      ref.read(listofUsersStateProvider.notifier).state = null;
                                      ref.read(listofUsersStateProvider.notifier).state =
                                          await ref.read(userControllerProvider).getUsersList();
                                    }
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  setSelectedOrgType(String type) {
    final selectedOrg = ref.read(selectedOrgTypeProvider.notifier);
    switch (type) {
      case 'Partner Organization':
        selectedOrg.state = 'PARTNER';
        break;
      case 'Customer Organization':
        selectedOrg.state = 'LOGISTICS';
        break;
    }
  }

  @override
  void dispose() {
    _typeOforgController.dispose();
    _partnerOrgNameController.dispose();
    _userNameController.dispose();
    _roleController.dispose();
    super.dispose();
  }
}
