import 'package:axlerate/src/common/common_controllers/page_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final partnerCopyAddressProvider = StateProvider<bool>((ref) {
  return false;
});

final listPartnersPageNotifierProvider = StateNotifierProvider<PageNotifierNew, PaginatorModel>((
  ref,
) {
  return PageNotifierNew();
});
