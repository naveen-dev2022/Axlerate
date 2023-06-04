import 'package:axlerate/src/common/common_controllers/page_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final txHistoryToggleSwitchIndex = StateProvider<int>((ref) {
  return 0;
});

final tagTxnPageNotifierProvider = StateNotifierProvider<PageNotifier, List<int>>((ref) {
  return PageNotifier();
});

final ppiTxnPageNotifierProvider = StateNotifierProvider<PageNotifier, List<int>>((ref) {
  return PageNotifier();
});
