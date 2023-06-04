import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/src/common/common_models/name_status_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// =============================================================================

final stateFilterProvider = StateProvider<List<String>>((ref) {
  return [];
});

// =============================================================================

// It Provides the state of Nature of Business fiters
final natureOfBusinessNotifierProviderPartner =
    StateNotifierProvider.autoDispose<NatureOfBusinessFilterNotifier, List<NameStatusModel>>((ref) {
  return NatureOfBusinessFilterNotifier();
}); //For Partner

final natureOfBusinessNotifierProviderLogistics =
    StateNotifierProvider.autoDispose<NatureOfBusinessFilterNotifier, List<NameStatusModel>>((ref) {
  return NatureOfBusinessFilterNotifier();
}); // For Logistics

// It holds the state of Nature of Business fiters
class NatureOfBusinessFilterNotifier extends StateNotifier<List<NameStatusModel>> {
  NatureOfBusinessFilterNotifier()
      : super([
          NameStatusModel(name: 'Individual'),
          NameStatusModel(name: 'Sole Proprietor'),
          NameStatusModel(name: 'Partnership'),
          NameStatusModel(name: 'Pvt. Ltd'),
          NameStatusModel(name: 'Public. Ltd'),
          // NameStatusModel(name: 'School/Trust/Associations'),
          NameStatusModel(name: 'Govt. Body'),
        ]);

  void changeStatus(NameStatusModel item, bool status) {
    state = [
      for (final element in state)
        if (element == item) element.copyWith(status: status) else element
    ];
  }

  List<String> selectedFilter() {
    List<String> list = [];
    for (final item in state) {
      if (item.status) {
        list.add(item.name.toValueCase);
      }
    }
    return list;
  }
}

// ===================================================================================

// It Provides registraction Status
final registrationStatusQueryProviderPartner =
    StateNotifierProvider.autoDispose<RegistrationStatusQueryNotifier, List<NameStatusModel>>((ref) {
  return RegistrationStatusQueryNotifier();
}); //For Partner

final registrationStatusQueryProviderLogistics =
    StateNotifierProvider.autoDispose<RegistrationStatusQueryNotifier, List<NameStatusModel>>((ref) {
  return RegistrationStatusQueryNotifier();
}); //For Logistics

// It holds the state of Nature of Business fiters
class RegistrationStatusQueryNotifier extends StateNotifier<List<NameStatusModel>> {
  RegistrationStatusQueryNotifier()
      : super([
          NameStatusModel(name: 'PENDING'.toUiCase),
          NameStatusModel(name: 'PENDING_KYC'.toUiCase),
          NameStatusModel(name: 'PENDING_DOC_UPLOAD'.toUiCase),
          NameStatusModel(name: 'APPROVED'.toUiCase),
          NameStatusModel(name: 'DECLINED'.toUiCase),
          NameStatusModel(name: 'MIN_KYC_APPROVED'.toUiCase),
        ]);

  void changeStatus(NameStatusModel item, bool status) {
    state = [
      for (final element in state)
        if (element == item) element.copyWith(status: status) else element
    ];
  }

  List<String> selectedFilter() {
    List<String> list = [];
    for (final item in state) {
      if (item.status) {
        list.add(item.name.toValueCase);
      }
    }
    return list;
  }
}

// ===================================================================================

// It Provides onboarding Status
final tagKycStatusQueryProvider =
    StateNotifierProvider.autoDispose<TagKycStatusQueryNotifier, List<NameStatusModel>>((ref) {
  return TagKycStatusQueryNotifier();
});

// It holds the state of Nature of Business fiters
class TagKycStatusQueryNotifier extends StateNotifier<List<NameStatusModel>> {
  TagKycStatusQueryNotifier()
      : super([
          NameStatusModel(name: 'APPROVED'.toUiCase),
          NameStatusModel(name: 'PENDING'.toUiCase),
          NameStatusModel(name: 'PENDING_DOC_UPLOAD'.toUiCase),
          NameStatusModel(name: 'PENDING_KYC'.toUiCase),
          NameStatusModel(name: 'DECLINED'.toUiCase),
        ]);

  void changeStatus(NameStatusModel item, bool status) {
    state = [
      for (final element in state)
        if (element == item) element.copyWith(status: status) else element
    ];
  }

  List<String> selectedFilter() {
    List<String> list = [];
    for (final item in state) {
      if (item.status) {
        list.add(item.name.toValueCase);
      }
    }
    return list;
  }
}

// ===================================================================================

// It Provides tag Status
final tagStatusQueryProvider = StateNotifierProvider.autoDispose<TagStatusQueryNotifier, List<NameStatusModel>>((ref) {
  return TagStatusQueryNotifier();
});

// It holds the state of Nature of Business fiters
class TagStatusQueryNotifier extends StateNotifier<List<NameStatusModel>> {
  TagStatusQueryNotifier()
      : super([
          NameStatusModel(name: 'ACTIVE'.toUiCase),
          NameStatusModel(name: 'LOW_BALANCE'.toUiCase),
          NameStatusModel(name: 'HOTLISTED'.toUiCase),
          NameStatusModel(name: 'BLACKLISTED'.toUiCase),
          NameStatusModel(name: 'BLOCKED'.toUiCase),
          NameStatusModel(name: 'CLOSED'.toUiCase),
        ]);

  void changeStatus(NameStatusModel item, bool status) {
    state = [
      for (final element in state)
        if (element == item) element.copyWith(status: status) else element
    ];
  }

  List<String> selectedFilter() {
    List<String> list = [];
    for (final item in state) {
      if (item.status) {
        list.add(item.name.toValueCase);
      }
    }
    return list;
  }
}

// ===================================================================================

// It Provides balance type Status
final balanceTypeQueryProvider =
    StateNotifierProvider.autoDispose<BalanceTypeQueryNotifier, List<NameStatusModel>>((ref) {
  return BalanceTypeQueryNotifier();
});

// It holds the state of Nature of Business fiters
class BalanceTypeQueryNotifier extends StateNotifier<List<NameStatusModel>> {
  BalanceTypeQueryNotifier()
      : super([
          NameStatusModel(name: 'CUSTOMER_LEVEL_BALANCE'.toUiCase),
          NameStatusModel(name: 'VEHICLE_LEVEL_BALANCE'.toUiCase),
        ]);

  void changeStatus(NameStatusModel item, bool status) {
    state = [
      for (final element in state)
        if (element == item) element.copyWith(status: status) else element
    ];
  }

  List<String> selectedFilter() {
    List<String> list = [];
    for (final item in state) {
      if (item.status) {
        list.add(item.name.toValueCase);
      }
    }
    return list;
  }
}

// It Provides fuel type Status
final fuelTypeQueryProvider = StateNotifierProvider.autoDispose<FuelTypeQueryNotifier, List<NameStatusModel>>((ref) {
  return FuelTypeQueryNotifier();
});

// It holds the state of Nature of Business fiters
class FuelTypeQueryNotifier extends StateNotifier<List<NameStatusModel>> {
  FuelTypeQueryNotifier()
      : super([
          NameStatusModel(name: 'PETROL'.toUiCase),
          NameStatusModel(name: 'DIESEL'.toUiCase),
          NameStatusModel(name: 'CNG'.toValueCase),
          NameStatusModel(name: 'ELECTRIC'.toUiCase),
        ]);

  void changeStatus(NameStatusModel item, bool status) {
    state = [
      for (final element in state)
        if (element == item) element.copyWith(status: status) else element
    ];
  }

  void clearFilter() {
    state = [];
  }

  List<String> selectedFilter() {
    List<String> list = [];
    for (final item in state) {
      if (item.status) {
        list.add(item.name.toValueCase);
      }
    }
    return list;
  }
}
