import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/Themes/text_style_config.dart';
import 'package:axlerate/main.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_controllers/wallets_controller.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_outline_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/features/home/logistics/domain/fund_transfer_c2c_model.dart';
import 'package:axlerate/src/features/home/logistics/domain/fund_transfer_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:axlerate/src/features/home/logistics/presentation/logistics_mobile_dashboard.dart';
import 'package:axlerate/src/features/home/user/presentstion/widgets/fund_load_org_card.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/currency_format.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class FundTransferPage extends ConsumerStatefulWidget {
  const FundTransferPage({super.key, @PathParam('custId') required this.orgEnrollId});

  final String orgEnrollId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FundTransferPageState();
}

class _FundTransferPageState extends ConsumerState<FundTransferPage> {
  OrgDoc? org;
  late Future<bool> orgDashLqTagInfoFuture;
  TextEditingController amountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  // String userEnrollmentId = '';

  @override
  void initState() {
    super.initState();
    getAllWallet();
  }

  getAllWallet({bool isLoad = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(enrolId: widget.orgEnrollId.toUpperCase());
      bool isSuccess = await ref.read(lqTagWalletsNotifierProvider.notifier).getAllWalletsForOrg(widget.orgEnrollId);
      if (isSuccess && isLoad) {
        for (WalletDisplayModel e in walletInfoList) {
          if (fromWalletInfo!.id == e.id) {
            fromWalletInfo = WalletDisplayModel(
                id: e.id,
                kitNo: e.kitNo,
                balance: e.balance,
                upiId: e.upiId,
                accountNumber: e.accountNumber,
                ifscCode: e.ifscCode,
                walletName: e.walletName,
                userEnrollmentId: e.userEnrollmentId,
                userEntityId: e.userEntityId,
                organizationEnrollmentId: e.organizationEnrollmentId,
                type: e.type);
          }
          if (toWalletInfo!.id == e.id) {
            toWalletInfo = WalletDisplayModel(
                id: e.id,
                kitNo: e.kitNo,
                balance: e.balance,
                upiId: e.upiId,
                accountNumber: e.accountNumber,
                ifscCode: e.ifscCode,
                walletName: e.walletName,
                userEnrollmentId: e.userEnrollmentId,
                userEntityId: e.userEntityId,
                organizationEnrollmentId: e.organizationEnrollmentId,
                type: e.type);
          }
        }
        setState(() {});
        AxleLoader.hide();
      }
    });
  }

  WalletDisplayModel? toWalletInfo;
  WalletDisplayModel? fromWalletInfo;

  String recipientUserEnrollmentId = '';
  String recipientUserEntityId = '';

  List<WalletDisplayModel> walletInfoList = [];
  Future<bool> getLqTagInfo() async {
    log(org.toString());
    OrganizationService? lqTagService = getOrgService(org, 'TAG', issuerName: 'LIVQUIK');
    // print("----------------${lqTagService!.kycType}");
    try {
      if (lqTagService!.kycType == "MIN_KYC") {
        log("MIN_KYC");
        return false;
      } else {
        log("FULL_KYC");
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    walletInfoList = ref.watch(lqTagWalletsNotifierProvider);
    log("fund_transfer_page_build--");
    //log("fund_transfer_page_build" + walletInfoList.toString());
    bool isMobile = Responsive.isMobile(context);
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;

    double availableWidth = screenWidth - (sideMenuWidth + (defaultPadding * 2));
    if (isMobile) {
      availableWidth = screenWidth - (defaultPadding * 2);
    }

    org = ref.watch(orgDetailsProvider);
    orgDashLqTagInfoFuture = getLqTagInfo();

    return Scaffold(
        body: walletInfoList.isEmpty || org == null
            ? AxleLoader.axleProgressIndicator()
            : GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          fromWalletCard(walletInfoList),
                          const SizedBox(height: 12.0),
                          const Text(
                            'To',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          toWalletCard(walletInfoList),
                          const SizedBox(height: 10.0),
                          Form(
                            // key: formKey,
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
                                  fieldController: remarksController,
                                  validate: Validators("Remarks").required(),
                                  fieldAction: TextInputAction.done,
                                  onSubmit: (_) {
                                    // onSubmitAddAmount(context: context, ref: ref);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                // buttonColor: AxleColors.axleBlueColor,
                                buttonWidth: isMobile ? availableWidth * 35 / 100 : 150.0,
                                onPress: () async {
                                  if (amountController.text.isEmpty) {
                                    Snackbar.error("Please enter a valid amount");
                                    return;
                                  }
                                  // onSubmitAddAmount(context: context, ref: ref);
                                  bool isP2C = false;
                                  bool isC2C = false;
                                  bool isC2P = false;
                                  double amount = double.parse(amountController.text);
                                  if (amount > 0) {
                                    if (fromWalletInfo!.type == WalletType.logistics &&
                                        toWalletInfo!.type == WalletType.user) {
                                      isP2C = true;
                                    } else if (fromWalletInfo!.type == WalletType.user &&
                                        toWalletInfo!.type == WalletType.user) {
                                      isC2C = true;
                                    } else if (fromWalletInfo!.type == WalletType.user &&
                                        toWalletInfo!.type == WalletType.logistics) {
                                      isC2P = true;
                                    }
                                    if (fromWalletInfo!.id == toWalletInfo!.id) {
                                      isP2C = false;
                                      isC2C = false;
                                      isC2P = false;
                                    }
                                    if (isP2C) {
                                      log("P2C Fund Load");
                                      recipientUserEnrollmentId = toWalletInfo!.userEnrollmentId;
                                      recipientUserEntityId = toWalletInfo!.userEntityId;
                                      AxleLoader.show(context);
                                      bool isSuccess = await ref.read(logisticsControllerProvider).lqTagFundTransferP2C(
                                          data: FundTransferModelP2C(
                                              organizationEnrollmentId: widget.orgEnrollId,
                                              userEnrollmentId: recipientUserEnrollmentId,
                                              userEntityId: recipientUserEntityId,
                                              amount: amount,
                                              description: remarksController.text));

                                      if (isSuccess) {
                                        getAllWallet(isLoad: true);
                                      } else {
                                        AxleLoader.hide();
                                      }
                                    } else if (isC2C) {
                                      log("C2C Fund Load");
                                      AxleLoader.show(context);
                                      bool isSuccess = await ref.read(logisticsControllerProvider).lqTagFundTransferC2C(
                                          data: FundTransferModelC2C(
                                              organizationEnrollmentId: widget.orgEnrollId,
                                              fromUserEnrollmentId: fromWalletInfo!.userEnrollmentId,
                                              toUserEnrollmentId: toWalletInfo!.userEnrollmentId,
                                              amount: amount,
                                              description: remarksController.text));

                                      if (isSuccess) {
                                        getAllWallet(isLoad: true);
                                      } else {
                                        AxleLoader.hide();
                                      }
                                    } else if (isC2P) {
                                      log("C2P Fund Load");
                                      recipientUserEnrollmentId = fromWalletInfo!.userEnrollmentId;
                                      recipientUserEntityId = fromWalletInfo!.userEntityId;
                                      AxleLoader.show(context);
                                      bool isSuccess = await ref.read(logisticsControllerProvider).lqTagFundTransferC2P(
                                          data: FundTransferModelP2C(
                                              organizationEnrollmentId: widget.orgEnrollId,
                                              userEnrollmentId: recipientUserEnrollmentId,
                                              userEntityId: recipientUserEntityId,
                                              amount: amount,
                                              description: remarksController.text));

                                      if (isSuccess) {
                                        getAllWallet(isLoad: true);
                                      } else {
                                        AxleLoader.hide();
                                      }
                                    } else {
                                      Snackbar.error("Invalid transaction. Cannot transfer to same wallet.");
                                    }
                                  } else {
                                    Snackbar.error("Please enter a valid amount");
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 30.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }

  Widget fromWalletCard(List<WalletDisplayModel> walletList) {
    //  WalletDisplayModel? walletInfo;
    if (walletList.isNotEmpty && fromWalletInfo == null) {
      int index = 0;
      index = walletList.indexWhere((element) {
        return element.type == WalletType.logistics;
      });
      if (index == -1) {
        index = 0;
      }
      fromWalletInfo = WalletDisplayModel(
          id: walletList[index].id,
          kitNo: walletList[index].kitNo,
          balance: walletList[index].balance,
          upiId: walletList[index].upiId,
          accountNumber: walletList[index].accountNumber,
          ifscCode: walletList[index].ifscCode,
          walletName: walletList[index].walletName,
          userEnrollmentId: walletList[index].userEnrollmentId,
          userEntityId: walletList[index].userEntityId,
          organizationEnrollmentId: walletList[index].organizationEnrollmentId,
          type: walletList[index].type);
    }

    return fromWalletInfo == null
        ? const SizedBox()
        : GestureDetector(
            onTap: (() {
              // ONLY SHOW CORPORATE WALLET HERE - RJ

              if (walletInfoList.length <= 1) {
                Snackbar.error("There are no other users in your organization.");
                return;
              }

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a wallet to send Money from'),
                      titleTextStyle: AxleTextStyle.titleMedium,
                      content: setupAlertDialoadContainer(toWallet: false, fromWallet: true),
                    );
                  });
            }),
            child: fromWalletInfo != null
                ? FundLoadOrgCard(
                    key: UniqueKey(),
                    title: fromWalletInfo!.walletName,
                    subtitle: 'Available Balance',
                    balance: axleCurrencyFormatterwithDecimals.format(fromWalletInfo!.balance),
                    icon: Icons.card_giftcard,
                    borderColor: const Color(0xffBBAAEC),
                    textColor: const Color(0xff714FD8),
                  )
                : const SizedBox(),
          );
  }

  Widget toWalletCard(List<WalletDisplayModel> walletList) {
    if (walletInfoList.isNotEmpty && toWalletInfo == null) {
      String userEnrollmentId = sharedPreferences.getString(Storage.currentLqAdminEnrollmentId) ?? '';
      int index = 0;
      index = walletList.indexWhere((element) {
        return element.type != WalletType.logistics &&
            element.userEnrollmentId.toUpperCase() == userEnrollmentId.toUpperCase();
      });
      if (index == -1) {
        index = 0;
      }
      toWalletInfo = WalletDisplayModel(
          id: walletList[index].id,
          kitNo: walletList[index].kitNo,
          balance: walletList[index].balance,
          upiId: walletList[index].upiId,
          accountNumber: walletList[index].accountNumber,
          ifscCode: walletList[index].ifscCode,
          walletName: walletList[index].walletName,
          userEnrollmentId: walletList[index].userEnrollmentId,
          userEntityId: walletList[index].userEntityId,
          type: walletList[index].type);
    }

    return GestureDetector(
      onTap: (() {
        if (walletInfoList.length <= 1) {
          Snackbar.error("There are no other users in your organization.");
          return;
        }
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Pick a wallet to load Money'),
                titleTextStyle: AxleTextStyle.titleMedium,
                content: setupAlertDialoadContainer(toWallet: true, fromWallet: false),
              );
            });
      }),
      child: toWalletInfo != null
          ? FundLoadOrgCard(
              key: UniqueKey(),
              title: toWalletInfo!.walletName,
              subtitle: 'Available Balance',
              balance: axleCurrencyFormatterwithDecimals.format(toWalletInfo!.balance),
              icon: Icons.card_giftcard,
              borderColor: const Color(0xffBECDD3),
              textColor: const Color(0xff638795),
            )
          : const SizedBox(),
    );
  }

  Widget walletCard(WalletDisplayModel walletInfo) {
    return FundLoadOrgCard(
      title: walletInfo.walletName,
      subtitle: 'Available Balance',
      balance: axleCurrencyFormatterwithDecimals.format(walletInfo.balance),
      icon: Icons.card_giftcard,
      borderColor: const Color(0xffBBAAEC),
      textColor: const Color(0xff714FD8),
    );
  }

  Widget setupAlertDialoadContainer({bool toWallet = false, bool fromWallet = false}) {
    return SizedBox(
      height: 1000.0, // Change as per your requirement
      width: 500.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: walletInfoList.length,
        itemBuilder: (BuildContext context, int index) {
          if (fromWallet &&
              (fromWalletInfo!.type == WalletType.logistics && walletInfoList[index].type == WalletType.logistics)) {
            return const SizedBox();
          }
          if (toWallet &&
              (toWalletInfo!.type == WalletType.logistics && walletInfoList[index].type == WalletType.logistics)) {
            return const SizedBox();
          }
          if (toWallet && (walletInfoList[index].userEnrollmentId == toWalletInfo!.userEnrollmentId)) {
            return const SizedBox();
          }
          if (fromWallet && (walletInfoList[index].userEnrollmentId == fromWalletInfo!.userEnrollmentId)) {
            return const SizedBox();
          }

          return GestureDetector(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  if (fromWallet) {
                    fromWalletInfo = walletInfoList[index];
                  }
                  if (toWallet) {
                    toWalletInfo = walletInfoList[index];
                  }
                });
              },
              child: Column(
                children: [walletCard(walletInfoList[index]), const SizedBox(height: defaultPadding)],
              ));
        },
      ),
    );
  }
}
