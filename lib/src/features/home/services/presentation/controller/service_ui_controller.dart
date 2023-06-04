import 'package:axlerate/src/features/home/services/domain/states_model.dart';
import 'package:axlerate/src/features/home/services/presentation/controller/service_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateListProvider = FutureProvider.autoDispose<States>((ref) async {
  return await ref.read(serviceControlProvider).getListOfStates();
});

final stateCitiesListProvider = FutureProvider.autoDispose.family<States, String>((ref, String name) async {
  return await ref.read(serviceControlProvider).getListOfCities(state: name);
});

final selectedStateProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});
final selectedCityProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});
