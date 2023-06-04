import 'package:axlerate/src/common/common_controllers/page_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listVehiclesPageNotifierProvider = StateNotifierProvider<PageNotifierNew, PaginatorModel>((
  ref,
) {
  return PageNotifierNew();
});

// // * Registration Date Provider

// final registrationDateProvider = StateProvider<DateTime?>((ref) {
//   return null;
// });

// // * Fitness Date Provider
// final fitnessDateProvider = StateProvider<DateTime?>((ref) {
//   return null;
// });

// // * Insurance Date Provider
// final insuranceDateProvider = StateProvider<DateTime?>((ref) {
//   return null;
// });

// Vehicle Fund load loading indicator
final vehicleFundLoadLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
