import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SelectedPartnerScreen extends ConsumerStatefulWidget {
  const SelectedPartnerScreen({@PathParam('partnerId') required this.partnerId, super.key});
  final String partnerId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectedPartnerScreenState();
}

class _SelectedPartnerScreenState extends ConsumerState<SelectedPartnerScreen> {
  // @override
  // void initState() {
  //   getOrganisation();
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   getOrganisation();
  //   super.didChangeDependencies();
  // }

  // getOrganisation() {
  //   Future(
  //     () {
  //       ref.read(logisticsControllerProvider).getOrganisationByEnrolmentId(enrolId: widget.partnerId.toUpperCase());
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // OrgDoc? org = ref.watch(orgDetailsProvider);
    return const Expanded(child: AutoRouter());

    // Column(
    //   children: [
    //     // Text("Partner is : ${widget.partnerId}"),
    //     // Text("Partner Name is : ${org?.displayName ?? ""}"),
    //     if (org != null) const Expanded(child: AutoRouter())
    //   ],
    // );
  }
}
