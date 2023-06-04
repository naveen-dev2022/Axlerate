import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/list_vehicle_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ListVehicleByCustomer extends ConsumerStatefulWidget {
  const ListVehicleByCustomer({@PathParam('custId') required this.custId, super.key});
  final String custId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListVehicleByCustomerState();
}

class _ListVehicleByCustomerState extends ConsumerState<ListVehicleByCustomer> {
  @override
  Widget build(BuildContext context) {
    return ListVehiclesPage(text: widget.custId);
  }
}
