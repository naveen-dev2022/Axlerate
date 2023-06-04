import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/src/common/common_models/name_status_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// It Provides the state of User OnBoard Status fiters
final userOnBoardStatusQueryProvider =
    StateNotifierProvider.autoDispose<UserOnBoardStatusQueryNotifier, List<NameStatusModel>>((ref) {
  return UserOnBoardStatusQueryNotifier();
});

// It holds the state of User OnBoard Status fiters
class UserOnBoardStatusQueryNotifier extends StateNotifier<List<NameStatusModel>> {
  UserOnBoardStatusQueryNotifier()
      : super([
          // NameStatusModel(name: 'INVITED'.toUiCase),
          NameStatusModel(name: 'PENDING'.toUiCase),
          NameStatusModel(name: 'ACTIVE'.toUiCase),
          NameStatusModel(name: 'INACTIVE'.toUiCase),
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

// =========================================================

final ppiStatusQueryProvider =
    StateNotifierProvider.autoDispose<PpiCardStatusQueryNotifier, List<NameStatusModel>>((ref) {
  return PpiCardStatusQueryNotifier();
});

class PpiCardStatusQueryNotifier extends StateNotifier<List<NameStatusModel>> {
  PpiCardStatusQueryNotifier()
      : super(
          [
            NameStatusModel(name: 'ACTIVE'.toUiCase),
            NameStatusModel(name: 'LOCKED'.toUiCase),
            NameStatusModel(name: 'BLOCKED'.toUiCase),
            NameStatusModel(name: 'CLOSED'.toUiCase),
          ],
        );

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

// =========================================================

final roleOfQueryProvider = StateNotifierProvider.autoDispose<RoleOFUserQueryNotifier, List<NameStatusModel>>((ref) {
  return RoleOFUserQueryNotifier();
});

class RoleOFUserQueryNotifier extends StateNotifier<List<NameStatusModel>> {
  RoleOFUserQueryNotifier()
      : super(
          [
            NameStatusModel(name: 'ADMIN'.toUiCase),
            NameStatusModel(name: 'STAFF'.toUiCase),
          ],
        );

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

// =========================================================

// final cardHolderQueryProvider = StateNotifierProvider.autoDispose<
//     CardHolderQueryNotifier, List<NameStatusModel>>((ref) {
//   return CardHolderQueryNotifier();
// });

// class CardHolderQueryNotifier extends StateNotifier<List<NameStatusModel>> {
//   CardHolderQueryNotifier()
//       : super(
//           [
//             NameStatusModel(name: 'ELIGIBLE'),
//             NameStatusModel(name: 'Logistics Admin'),
//             NameStatusModel(name: 'Logistics Staff'),
//           ],
//         );

//   void changeStatus(NameStatusModel item, bool status) {
//     state = [
//       for (final element in state)
//         if (element == item) element.copyWith(status: status) else element
//     ];
//   }

//   List<String> selectedFilter() {
//     List<String> list = [];
//     for (final item in state) {
//       if (item.status) {
//         list.add(item.name.toValueCase);
//       }
//     }
//     return list;
//   }
// }

// =========================================================

// final balanceAmountQueryProvider = StateNotifierProvider.autoDispose<
//     BalanceAmountQueryNotifier, List<NameStatusModel>>((ref) {
//   return BalanceAmountQueryNotifier();
// });

// class BalanceAmountQueryNotifier extends StateNotifier<List<NameStatusModel>> {
//   BalanceAmountQueryNotifier()
//       : super(
//           [
//             NameStatusModel(name: 'Partner Admin'),
//             NameStatusModel(name: 'Logistics Admin'),
//             NameStatusModel(name: 'Logistics Staff'),
//           ],
//         );

//   void changeStatus(NameStatusModel item, bool status) {
//     state = [
//       for (final element in state)
//         if (element == item) element.copyWith(status: status) else element
//     ];
//   }

//   List<String> selectedFilter() {
//     List<String> list = [];
//     for (final item in state) {
//       if (item.status) {
//         list.add(item.name.toValueCase);
//       }
//     }
//     return list;
//   }
// }
