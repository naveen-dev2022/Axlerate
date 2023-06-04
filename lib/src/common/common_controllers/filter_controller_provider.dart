// It Provides the state of fiter visibility
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterVisibilityProviderPartner =
    StateNotifierProvider.autoDispose<FilterVisibilityNotifier, bool>((ref) {
  return FilterVisibilityNotifier();
});

final filterVisibilityProviderLogistics =
    StateNotifierProvider.autoDispose<FilterVisibilityNotifier, bool>((ref) {
  return FilterVisibilityNotifier();
});
final filterVisibilityProviderVehicle =
    StateNotifierProvider.autoDispose<FilterVisibilityNotifier, bool>((ref) {
  return FilterVisibilityNotifier();
});
final filterVisibilityProviderUser =
    StateNotifierProvider.autoDispose<FilterVisibilityNotifier, bool>((ref) {
  return FilterVisibilityNotifier();
});

// It holds the state of filter visibility
class FilterVisibilityNotifier extends StateNotifier<bool> {
  FilterVisibilityNotifier() : super(false);

  void showFilter() => state = true;
  void hide() => state = false;
}



// --------------------------------------------------------------------------