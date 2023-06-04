import 'package:auto_route/auto_route.dart';
import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/features/home/partner/presentation/widgets/partner_commission_orgwise_table.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:go_router/go_router.dart';
@RoutePage()
class CommissionHistoryPage extends ConsumerStatefulWidget {
  const CommissionHistoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommissionHistoryPageState();
}

class _CommissionHistoryPageState extends ConsumerState<CommissionHistoryPage> {
  String orgId = '';
  @override
  void initState() {
    orgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AxleColors.axleBackgroundColor,
      body: Padding(
        padding: isMobile
            ? const EdgeInsets.all(defaultPadding)
            : const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
        child: SingleChildScrollView(
          child: PartnerCommissionOrgwiseTable(partnerEnrolId: orgId),
        ),
      ),
    );
  }
}
