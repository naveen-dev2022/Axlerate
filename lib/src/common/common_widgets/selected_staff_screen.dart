import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/features/home/user/domain/updated_user_by_enrolment_model.dart';
import 'package:axlerate/src/features/home/user/presentstion/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedUserDetailsProvider = StateProvider<UpdatedUserByEnrolmentIdModel?>((ref) {
  return null;
});

@RoutePage()
class SelectedStaffScreen extends ConsumerStatefulWidget {
  const SelectedStaffScreen({@PathParam('staffEnrolId') required this.userEnrolmentId, super.key});
  final String userEnrolmentId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectedStaffScreenState();
}

class _SelectedStaffScreenState extends ConsumerState<SelectedStaffScreen> {
  bool isLoading = true;
  UpdatedUserByEnrolmentIdModel? user;
  @override
  void initState() {
    Future(() => getUserDetailByEnrollmentId(widget.userEnrolmentId));
    super.initState();
  }

  getUserDetailByEnrollmentId(String userEnrolmentId) async {
    isLoading = true;
    user = const UpdatedUserByEnrolmentIdModel.unknown();
    ref.read(selectedUserDetailsProvider.notifier).state = await ref.read(userControllerProvider).getUserByEnrolmentId(
          userEnrolmentId: userEnrolmentId.toUpperCase(),
        );
    user = ref.read(selectedUserDetailsProvider);

    if (user!.data == null) {
      // ignore: use_build_context_synchronously
      context.router.replaceNamed('./user-not-found');
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
    // isLoading
    //     ? AxleLoader.axleProgressIndicator()
    //     : user != null
    //         ? const Expanded(child: AutoRouter())
    //         : const Text("User Not Found");
  }
}
