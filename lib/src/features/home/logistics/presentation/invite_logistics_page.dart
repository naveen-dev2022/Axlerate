import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/common_style_util.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/router/route_utils.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_ui_controller.dart';
import 'package:axlerate/src/features/home/form_widgets/form_section_heading_widget.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:go_router/go_router.dart';
@RoutePage()
class InviteLogisticsPage extends ConsumerStatefulWidget {
  const InviteLogisticsPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateCustomerPageState();
}

class _CreateCustomerPageState extends ConsumerState<InviteLogisticsPage> {
  final GlobalKey<FormState> createPartnerFormKey = GlobalKey<FormState>();

  final TextEditingController _adminUserNameController = TextEditingController(text: '');
  // final TextEditingController _partnerOrgController = TextEditingController();
  final TextEditingController _orgCodeController = TextEditingController();
  //final TextEditingController _pickedIdController = TextEditingController();

  @override
  void dispose() {
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  InputFormConstants.createCustomer,
                  style: AxleTextStyle.headingPrimary,
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  // decoration: CommonStyleUtil.axleContainerDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    spacing: defaultPadding,
                                    runSpacing: defaultPadding,
                                    children: [
                                      // ref.watch(listOrgByTypeProvider('PARTNER')).when(
                                      //       data: (response) {
                                      //         List<ListOrgByTypeDoc> allList = response.data.message.docs;
                                      //         return AxleSearchDropDownField(
                                      //           fieldHeading: InputFormConstants.partnerOrgFieldName,
                                      //           fieldHint: InputFormConstants.partnerOrgFieldHint,
                                      //           fieldWidth: isMobile ? screenWidth : 320,
                                      //           fieldController: _partnerOrgController,
                                      //           dropDownOptions: allList
                                      //               .map((item) =>
                                      //                   '${item.enrollmentId} - ${item.firstName} ${item.lastName} - ${item.city}')
                                      //               .toList(),
                                      //           validate: Validators(InputFormConstants.partnerOrgFieldName).required(),
                                      //           isRequired: true,
                                      //           onChanged: (val) {
                                      //             _partnerOrgController.text = val!;
                                      //             log('Entered Function ');
                                      //             final picked = _partnerOrgController.text.split('-').first.trim();
                                      //             log('Entered SelectedID - $picked');
                                      //             for (final item in allList) {
                                      //               log('${item.enrollmentId}  - 1');
                                      //               if (item.enrollmentId == picked) {
                                      //                 log('${item.enrollmentId}  - 2');

                                      //                 _pickedIdController.text = item.id;
                                      //                 log('Controller -> ${_pickedIdController.text}');
                                      //                 break;
                                      //               }
                                      //             }
                                      //             log('Entered SelectedID 2');
                                      //           },
                                      //         );
                                      //       },
                                      //       error: (error, stackTrace) => const Text('Error'),
                                      //       loading: () => const CircularProgressIndicator(),
                                      //     ),
                                      AxleFormTextField(
                                        fieldHeading: InputFormConstants.orgCodeFieldLabel,
                                        fieldHint: InputFormConstants.orgCodeHint,
                                        fieldController: _orgCodeController,
                                        fieldWidth: isMobile ? screenWidth : 350,
                                        lengthLimit: 3,
                                        inputformatters: [
                                          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                                        ],
                                        validate:
                                            Validators(InputFormConstants.orgCodeFieldLabel).required().min(3).max(3),
                                        isRequiredField: true,
                                        onChange: (val) async {
                                          if (val.length == 3) {
                                            final res =
                                                await ref.read(logisticsControllerProvider).checkOrgCode(code: val);
                                            if (res) {
                                              ref.read(orgCheckIconProvider.notifier).state =
                                                  const Icon(Icons.check, color: AxleColors.axleGreenColor, size: 16.0);
                                            } else {
                                              ref.read(orgCheckIconProvider.notifier).state =
                                                  const Icon(Icons.close, size: 16.0, color: AxleColors.axleRedColor);
                                            }
                                          } else {
                                            ref.read(orgCheckIconProvider.notifier).state =
                                                const Icon(Icons.close, size: 16.0, color: AxleColors.axleRedColor);
                                          }
                                        },
                                        trailingIcon: ref.watch(orgCheckIconProvider),
                                      ),
                                      AxleFormTextField(
                                        fieldHeading: InputFormConstants.mobileNum,
                                        fieldHint: InputFormConstants.mobileNumberFieldHint,
                                        fieldController: _adminUserNameController,
                                        validate: Validators(InputFormConstants.userMobileNoFieldLabel).required(),
                                        fieldWidth: isMobile ? screenWidth : 350,
                                        isOnlyDigits: true,
                                        textType: TextInputType.number,
                                        lengthLimit: 10,
                                        isRequiredField: true,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
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
                            const SizedBox(width: 20.0),
                            AxlePrimaryButton(
                              buttonText: InputFormConstants.saveAndContinueText,
                              buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                              buttonWidth: 200.0,
                              onPress: () async {
                                if (createPartnerFormKey.currentState!.validate()) {
                                  AxleLoader.show(context);
                                  bool res = await ref.read(logisticsControllerProvider).inviteLogistics(
                                        email: _adminUserNameController.text.trim(),
                                        orgCode: _orgCodeController.text.trim(),
                                      );
                                  AxleLoader.hide();
                                  if (res && mounted) {
                                    final orgEnrollId = ref
                                        .read(sharedPreferenceProvider)
                                        .getString(Storage.currentlyPickedOrgEnrollId);
                                    context.router.pushNamed('/app/$orgEnrollId/customers');
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
}
