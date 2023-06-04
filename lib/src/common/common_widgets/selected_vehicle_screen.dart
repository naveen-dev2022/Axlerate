import 'package:auto_route/auto_route.dart';
import 'package:axlerate/src/features/home/vehicles/presentation/controller/vehicle_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SelectedVehicle extends ConsumerStatefulWidget {
  const SelectedVehicle({@PathParam('vehicleRegNo') required this.vehicleRegNo, super.key});
  final String vehicleRegNo;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectedVehicleState();
}

class _SelectedVehicleState extends ConsumerState<SelectedVehicle> {
  bool isLoading = true;
  @override
  void initState() {
    getVehicleByRegistrationNumber();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getVehicleByRegistrationNumber();
    super.didChangeDependencies();
  }

  getVehicleByRegistrationNumber() {
    isLoading = true;
    Future(
      () {
        ref
            .read(vehicleControllerProvider)
            .getVehicleByRegistrationNumber(vehicleEnrolId: widget.vehicleRegNo.toUpperCase());
      },
    );
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Vehicle? vehicle = ref.watch(vehicleDetailsProvider);
    return const AutoRouter();
    //  isLoading
    //     ? AxleLoader.axleProgressIndicator()
    //     : vehicle != null
    //         ? const AutoRouter()
    //         : Center(
    //             child: Text(
    //             "Vehicle Not Found",
    //             style: AxleTextStyle.headingPrimary,
    //           ));
  }
}
