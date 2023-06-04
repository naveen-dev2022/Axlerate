import 'package:axlerate/src/features/home/services/domain/add_ppi_service_input_mode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isServiceLoading = StateProvider<bool?>((ref) {
  return true;
});

final selectPartnerOrgIdProvider = StateProvider<String>((ref) {
  return '';
});

// final selectPartnerForLqProvider = StateProvider<String>((ref) {
//   return '';
// });

final ppiDocumentProvider = StateNotifierProvider(
  (ref) {
    return PpiDocumentsNotifier();
  },
);

class PpiDocumentsNotifier extends StateNotifier<List<EnbalePpiServiceKycDocument>> {
  PpiDocumentsNotifier() : super([]);

  void addItem(EnbalePpiServiceKycDocument doc) {
    if (state.length < 4) {
      state.add(doc);
    }
  }
}
