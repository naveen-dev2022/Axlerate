import 'package:axlerate/app_util/enums/report_file_type.dart';
import 'package:axlerate/src/common/common_models/graph_response_model.dart';
import 'package:axlerate/src/common/common_models/list_orgs_query_params.dart';
import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/logistics/presentation/controller/dashboard_controllers.dart';
import 'package:axlerate/src/features/home/partner/data/partner_repository.dart';
import 'package:axlerate/src/features/home/partner/domain/create_partner_input_model.dart';
import 'package:axlerate/src/features/home/partner/domain/orgwise_commission_model.dart';
import 'package:axlerate/src/features/home/partner/domain/partner_dash_count_info_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/downloads/download_file.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listofPartnersStateProvider = StateProvider<ListOrgUpdatedModel?>((ref) {
  return null;
});

final partnerControllerProvider = Provider<PartnerController>((ref) {
  return PartnerController(ref);
});

class PartnerController {
  final Ref ref;

  const PartnerController(this.ref);

  // * Create Partner
  Future<bool> createPartner(CreatePartnerInputModel formInput) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      await ref.read(partnerRepositoryProvider).createPartner(
            userOrgId: userOrgId,
            formInput: formInput,
          );
      Snackbar.success('Partner Organization Created Successfully');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * get List Partners
  Future<ListOrgUpdatedModel?> getPartnersList({ListOrgsQueryParams? queryParams}) async {
    ListOrgUpdatedModel res;
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(partnerRepositoryProvider).getLogisticsList(
            userOrgId: userOrgId,
            queryParams: queryParams,
          );
      res = ListOrgUpdatedModel.fromJson(result.data);
      return res;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      rethrow;
    }
  }

  // * Get Partner Org Dash Count Info
  Future<PartnerDashCountInfoModel> getPartnerDashCount({required String orgId}) async {
    PartnerDashCountInfoModel res = PartnerDashCountInfoModel.unknown();
    try {
      final userOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';

      Response result = await ref.read(partnerRepositoryProvider).getPartnerDashCount(
            userOrgEnrollId: userOrgEnrollId.toLowerCase(),
            orgId: orgId,
          );
      try {
        res = PartnerDashCountInfoModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Partner Dash Count model Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Partner TAG Rewards (Amount) (Dashboard)
  // * dataType : 'year', 'week', 'day', 'month'
  Future<GraphResponseModel> getPartnerTagReward({
    required String orgId,
    required String dataType,
    bool isGraph = false,
  }) async {
    GraphResponseModel res = GraphResponseModel.unknown();

    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(partnerRepositoryProvider).getPartnerTagReward(
            userOrgId: userOrgId,
            orgId: orgId,
            dataType: dataType,
            isGraph: isGraph,
          );
      try {
        // return result.data["data"]["message"]["value"].toString();
        res = GraphResponseModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Partner Tag Reward Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<double> getPartnerTagRewardWithoutGraph({
    required String orgId,
    required String dataType,
  }) async {
    double res = 0.0;

    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      bool isGraph = false;
      Response result = await ref.read(partnerRepositoryProvider).getPartnerTagReward(
            userOrgId: userOrgId,
            orgId: orgId,
            dataType: dataType,
            isGraph: isGraph,
          );
      try {
        // return result.data["data"]["message"]["value"].toString();
        res = num.parse(result.data['data']['message']['value'].toString()).toDouble();
        return res;
      } catch (e) {
        // debugPrint('Partner Tag Reward Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<double> getPartnerLqTagRewardWithoutGraph({
    required String orgId,
    required String dataType,
  }) async {
    double res = 0.0;

    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      bool isGraph = false;
      Response result = await ref.read(partnerRepositoryProvider).getPartnerLqTagReward(
            userOrgId: userOrgId,
            orgId: orgId,
            dataType: dataType,
            isGraph: isGraph,
          );
      try {
        // return result.data["data"]["message"]["value"].toString();
        res = num.parse(result.data['data']['message']['value'].toString()).toDouble();
        return res;
      } catch (e) {
        // debugPrint('Partner Tag Reward Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Partner PPI Rewards (Amount) - (Dashboard)
  // * dataType : 'year', 'week', 'day', 'month'
  Future<GraphResponseModel> getPartnerPpiReward({
    required String orgId,
    String dataType = 'year',
    bool isGraph = false,
  }) async {
    GraphResponseModel res = GraphResponseModel.unknown();

    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(partnerRepositoryProvider).getPartnerPpiReward(
            userOrgId: userOrgId,
            orgId: orgId,
            dataType: dataType,
            isGraph: isGraph,
          );
      try {
        // return result.data["data"]["message"]["value"].toString();
        res = GraphResponseModel.fromJson(result.data);
        return res;
      } catch (e) {
        // debugPrint('Partner TPPIag Reward Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  Future<double> getPartnerPpiRewardWithoutGraph({
    required String orgId,
    String dataType = 'year',
  }) async {
    double res = 0.0;
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      bool isGraph = false;

      Response result = await ref.read(partnerRepositoryProvider).getPartnerPpiReward(
            userOrgId: userOrgId,
            orgId: orgId,
            dataType: dataType,
            isGraph: isGraph,
          );
      try {
        // return result.data["data"]["message"]["value"].toString();
        res = num.parse(result.data['data']['message']['value'].toString()).toDouble();
        return res;
      } catch (e) {
        // debugPrint('Partner TPPIag Reward Error -> $e');
        return res;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get Org Dash Tag TXN Analytics (Debit and Credit)
  // * dataType : 'year', 'week', 'day', 'month'

  Future<void> getPartnerDashTagTxnAnalytics({
    required String orgId,
    String dataType = 'year',
    String txType = 'credit',
  }) async {
    final tagTxnState = ref.read(partnerTagTxnStateProvider.notifier);

    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(partnerRepositoryProvider).getPartnerDashTagTxnAnalytics(
            userOrgId: userOrgId,
            orgId: orgId,
            dataType: dataType,
          );
      try {
        tagTxnState.state = result.data['data']['message']['value'].toString();
      } catch (e) {
        tagTxnState.state = '0';

        // debugPrint('Org Dash TAG txn Analytics Error -> $e');
      }
    } catch (e) {
      tagTxnState.state = '0';
      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  // * Get Org Dash PPI TXN Analytics (Debit and Credit)
  // * dataType : 'year', 'week', 'day', 'month'

  Future<void> getPartnerDashPpiTxnAnalytics({
    required String orgId,
    String dataType = 'year',
  }) async {
    final ppiTxnState = ref.read(partnerPpiTxnStateProvider.notifier);

    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';
      Response result = await ref.read(partnerRepositoryProvider).getPartnerDashPpiTxnAnalytics(
            userOrgId: userOrgId,
            orgId: orgId,
            dataType: dataType,
          );
      try {
        ppiTxnState.state = result.data['data']['message']['value'].toString();
      } catch (e) {
        ppiTxnState.state = '0';

        // debugPrint('Org Dash PPI txn Analytics Error -> $e');
      }
    } catch (e) {
      ppiTxnState.state = '0';

      Snackbar.error(ApiHelper.getErrorMessage(e));
    }
  }

  Future<OrgwiseCommissionResponseMessage> getCommissionData(
      {required String partnerEnrolId, required String startDate, required String endDate}) async {
    OrgwiseCommissionResponseMessage res;
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      Response result = await ref.read(partnerRepositoryProvider).getOrgWiseCommissionData(
          userOrgId: userOrgId.toLowerCase(), orgId: partnerEnrolId, endDate: endDate, startDate: startDate);
      try {
        res = OrgwiseCommissionResponse.fromMap(result.data).data.message;
        return res;
      } catch (e) {
        // debugPrint('list-cashback-summary Error -> $e');
        rethrow;
      }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      rethrow;
    }
  }

  Future<String> downloadCommissionData(
      {required String partnerEnrolId,
      required String startDate,
      required String endDate,
      required ReportFileType fileType}) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
      Response result = await ref.read(partnerRepositoryProvider).downloadOrgWiseCommissionData(
          userOrgId: userOrgId,
          orgId: partnerEnrolId,
          endDate: endDate,
          startDate: startDate,
          fileType: fileType.apiText);

      String url = result.data['data']['message'];

      FileDownloadUtil.getFileFromUrl(url, fileType);

      return url;
      // try {
      //   String url = result.data['data']['message'];
      //   Dio dio = Dio();

      //   if (kIsWeb) {
      //     await launchUrl(Uri.parse(url));
      //   } else {
      //     String path;

      //     // path = await FilePicker.platform.getDirectoryPath();

      //     Directory tempDir = await getApplicationDocumentsDirectory();
      //     tempDir.create();
      //     Directory dir = await tempDir.createTemp("axle");
      //     path = dir.path;

      //     String fileName = url.split('/').last.split('?').first;
      //     String filePath = '$path/$fileName';

      //     await PartnerRepository(dio).downloadFile(url, filePath);
      //     await OpenFilex.open(filePath, type: fileType.mimeType);

      //     // await dir.delete(recursive: true);
      //   }
      //   return url;
      // } catch (e) {
      //   // debugPrint('list-cashback-summary Error -> $e');
      //   rethrow;
      // }
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      rethrow;
    }
  }
}
