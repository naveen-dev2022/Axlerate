import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/logistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SelectedCustomerScreen extends ConsumerStatefulWidget {
  const SelectedCustomerScreen({@PathParam('custId') required this.custId, super.key});
  final String custId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectedCustomerScreenState();
}

class _SelectedCustomerScreenState extends ConsumerState<SelectedCustomerScreen> {
  @override
  void initState() {
    getOrganisation();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   getOrganisation();
  //   super.didChangeDependencies();
  // }

  getOrganisation() {
    Future(
      () async {
        await ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(enrolId: widget.custId.toUpperCase());
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // OrgDoc? org = ref.watch(orgDetailsProvider);
    return const AutoRouter();
  }
}
