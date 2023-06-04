// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/user/domain/fetch_balance_response_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/ui_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/fund_load_org_card.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FundLoadDialog extends ConsumerWidget {
  FundLoadDialog({
    super.key,
    required this.userFundData,
    required this.userOrgFundData,
    required this.orgId,
    // required this.partnerOrgId,
    required this.userEntityId,
    required this.userEnrollmentId,
    required this.name,
  });

  final FetchBalanceResponseModel? userFundData;
  final FetchBalanceResponseModel? userOrgFundData;
  final String orgId;
  // final String partnerOrgId;
  final String userEntityId;
  final String userEnrollmentId;
  final String name;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isMobile = false;
  double screenWidth = 0.0;
  double availableWidth = 0.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(fundLoadLoadingProvider);

    screenWidth = MediaQuery.of(context).size.width;
    isMobile = Responsive.isMobile(context);
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    return SizedBox(
      height: MediaQuery.of(context).size.width * 50 / 100,
      child: AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        titlePadding: isMobile
            ? const EdgeInsets.all(defaultPadding)
            : const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        title: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Add Money',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0),

              // * From Column
              isLoading
                  ? AxleLoader.axleProgressIndicator(
                      height: 100.00,
                      width: 100.00,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'From',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        userOrgFundDataCard(),
                        const SizedBox(height: 12.0),
                        const Text(
                          'To',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        userFundDataCard(),
                        const SizedBox(height: 10.0),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              AxleFormTextField(
                                autofocus: true,
                                fieldHeading: 'Amount',
                                fieldHint: 'Enter Amount',
                                fieldWidth: 350,
                                isOnlyDigits: true,
                                lengthLimit: 6,
                                textType: TextInputType.number,
                                fieldController: amountController,
                                validate: Validators("Amount").required().max(6),
                              ),
                              const SizedBox(height: 10.0),
                              AxleFormTextField(
                                fieldHeading: 'Remarks',
                                fieldHint: 'Enter Remarks',
                                fieldWidth: 350,
                                fieldController: descriptionController,
                                validate: Validators("Remarks").required(),
                                fieldAction: TextInputAction.done,
                                onSubmit: (_) {
                                  onSubmitAddAmount(context: context, ref: ref);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AxleOutlineButton(
                                buttonText: 'Cancel',
                                buttonStyle: AxleTextStyle.saveAndContinuePrimaryStyle,
                                outlineColor: AxleColors.axleBlueColor,
                                buttonWidth: isMobile ? availableWidth * 35 / 100 : 150.0,
                                onPress: () => Navigator.pop(context),
                              ),
                              const SizedBox(width: 10.0),
                              AxlePrimaryButton(
                                buttonText: 'Add Amount',
                                buttonTextStyle: AxleTextStyle.saveAndContinueStyle,
                                buttonColor: AxleColors.axleBlueColor,
                                buttonWidth: isMobile ? availableWidth * 35 / 100 : 150.0,
                                onPress: () {
                                  onSubmitAddAmount(context: context, ref: ref);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  onSubmitAddAmount({required BuildContext context, required WidgetRef ref}) async {
    if (formKey.currentState!.validate()) {
      int amountValue = int.parse(amountController.text);
      String descriptionValue = descriptionController.text;
      if (amountValue > 0 && descriptionValue.isNotEmpty) {
        AxleLoader.show(context);
        bool res = await ref.read(userControllerProvider).fundLoad(
              orgId: orgId,
              // partnerOrgId: partnerOrgId,
              userEntityId: userEntityId,
              userEnrollmentId: userEnrollmentId,
              amount: int.parse(amountController.text),
              description: descriptionController.text.trim(),
            );
        if (res) {
          Navigator.pop(context);
          // ref.read(userBalanceProvider.notifier).state = null;
          ref.read(userBalanceProvider.notifier).state =
              await ref.read(userControllerProvider).fetchUserBalance(entityId: userEntityId);
        }
        AxleLoader.hide();
      } else {
        Snackbar.error("Should be greater than 0 ");
      }
    }
  }

  // * User's Organization Account Balance
  Widget userOrgFundDataCard() {
    if (userOrgFundData != null) {
      final data = userOrgFundData!.data!.message;
      return FundLoadOrgCard(
        title: 'Logistics Organization',
        subtitle: 'Available Balance',
        balance: '₹ ${data.result.isNotEmpty ? data.result[0].balance : '-'}',
        icon: Icons.card_giftcard,
        borderColor: const Color(0xffBBAAEC),
        textColor: const Color(0xff714FD8),
      );
    } else {
      return const Text('Error');
    }
  }

  // * User's Account Balance
  Widget userFundDataCard() {
    if (userFundData != null) {
      final data = userFundData!.data!.message;
      return FundLoadOrgCard(
        title: name,
        subtitle: 'Available Balance',
        balance: '₹ ${data.result.isNotEmpty ? data.result[0].balance : '-'}',
        icon: Icons.card_giftcard,
        borderColor: const Color(0xffBECDD3),
        textColor: const Color(0xff638795),
      );
    } else {
      return const Text('Error');
    }
  }
}
