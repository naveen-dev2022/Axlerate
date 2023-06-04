import 'package:axlerate/src/features/home/user/domain/fetch_balance_response_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchBalanceProvider = FutureProvider.autoDispose.family<FetchBalanceResponseModel?, String>((ref, entityId) {
  try {
    final data = ref.read(userControllerProvider).fetchUserBalance(entityId: entityId);
    return data;
  } catch (e) {
    return null;
  }
});
