import 'dart:developer';

import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:axlerate/src/features/home/logistics/presentation/logistics_mobile_dashboard.dart';

final lqTagWalletsNotifierProvider = StateNotifierProvider<WalletsNotifier, List<WalletDisplayModel>>((ref) {
  return WalletsNotifier(ref);
});

final lqTagWalletsProvider = StateProvider<List<WalletDisplayModel>>((ref) {
  return [];
});
final isLoadinglqTagWallets = StateProvider<bool>((ref) {
  return false;
});

class WalletsNotifier extends StateNotifier<List<WalletDisplayModel>> {
  Ref ref;
  WalletsNotifier(this.ref) : super([]) {
    state = [];
  }

  Future<bool> getAllWalletsForOrg(String orgEnrollId) async {
    try {
      ref.read(isLoadinglqTagWallets.notifier).state = true;
      await ref.read(logisticsControllerProvider).lqTagAccInfoByEnrollmentId(orgEnrollId: orgEnrollId);
      return true;
    } catch (e) {
      return false;
    }
  }

  void addWallets(List<WalletDisplayModel> wallets) {
    List<WalletDisplayModel> currentWallets = state;
    currentWallets.clear();
    for (int i = 0; i < wallets.length; i++) {
      currentWallets = addtoWalletsList(currentWallets, wallets[i]);
    }

    state = currentWallets;
    ref.read(lqTagWalletsProvider.notifier).state = currentWallets;
    ref.read(isLoadinglqTagWallets.notifier).state = false;
    log("fund--message-state");
  }

  List<WalletDisplayModel> getWalletsByType(WalletType type) {
    List<WalletDisplayModel> wallets = state;
    return wallets.where((element) => element.type == type).toList();
    // return wallets;
  }
}

List<WalletDisplayModel> addtoWalletsList(List<WalletDisplayModel> wallets, WalletDisplayModel wallet) {
  List<Color> colors = [Colors.blue, Colors.red, Colors.amber, Colors.green, Colors.cyan];
  wallets.removeWhere((element) => element.kitNo == wallet.kitNo);
  wallets.add(wallet);

  //assignColors
  for (int index = 0; index < wallets.length; index++) {
    wallets[index].walletColor = colors[index % colors.length];
  }
  return wallets;
}
