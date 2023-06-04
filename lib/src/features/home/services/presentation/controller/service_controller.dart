import 'package:axlerate/src/common/common_models/list_orgs_updated_model.dart';
import 'package:axlerate/src/features/home/services/data/services_repository.dart';
import 'package:axlerate/src/features/home/services/domain/add_ppi_service_input_mode.dart';
import 'package:axlerate/src/features/home/services/domain/add_tag_service_input_modal.dart';
import 'package:axlerate/src/features/home/services/domain/fuel_service_input_model.dart';
import 'package:axlerate/src/features/home/services/domain/fuel_service_input_retry_model.dart';
import 'package:axlerate/src/features/home/services/domain/fuel_service_input_update_model.dart';
import 'package:axlerate/src/features/home/services/domain/response_model.dart';
import 'package:axlerate/src/features/home/services/domain/states_model.dart';
import 'package:axlerate/src/features/home/services/domain/verify_org_kyc_input_model.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceControlProvider = Provider<ServiceController>((ref) {
  return ServiceController(ref);
});

class ServiceController {
  final Ref ref;

  const ServiceController(this.ref);

  // Add PPI service to Organization
  Future<bool> addPpiServiceToOrganization(
    EnablePpiServiceInputModel formInput,
  ) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(servicesRepoProvider).addPpiServiceToOrganization(
            userOrgId: userOrgId,
            formInput: formInput,
          );

      Snackbar.success('PPI Service Enabled Successfully');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  //Retry Add PPI service to Organization
  Future<bool> retryaddPpiServiceToOrganization(
    String orgId,
  ) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(servicesRepoProvider).retryaddPpiServiceToOrganization(
            userOrgId: userOrgId,
            orgId: orgId,
          );

      Snackbar.success('PPI Service Enabled Successfully');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Add Tag service to Organization
  Future<bool> addTagServiceToOrganization(
    AddTagServiceInputModel formInput,
  ) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(servicesRepoProvider).addTagServiceToOrganization(
            userOrgId: userOrgId,
            formInput: formInput,
          );
      // print(result.data);
      Snackbar.success('Tag Service Enabled Successfully');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // * Add GPS service to Organization
  // ! As said by Devi akka, as of now, GPS is by default enabled for a logistics organization (11/01/2023 - 14:19)
  // Future<bool> addGpsServiceToOrganization({
  //   required String orgId,
  //   required String partnerOrgId,
  // }) async {
  //   try {
  //     final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

  //     Response result = await ref.read(servicesRepoProvider).addGpsServiceToOrganization(
  //           userOrgId: userOrgId,
  //           orgId: orgId,
  //           partnerOrgId: partnerOrgId,
  //         );
  //     print(result.data);
  //     Snackbar.success('Service Enabled Successfully');
  //     return true;
  //   } catch (e) {
  //     Snackbar.error(ApiHelper.getErrorMessage(e));
  //     return false;
  //   }
  // }

  // * Get list of States
  Future<States> getListOfStates() async {
    States res = States.empty();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(servicesRepoProvider).getListOfStates(
            userOrgId: userOrgId,
          );
      res = States.fromJson(result.data);
      return res;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get list of Cities
  Future<States> getListOfCities({required String state}) async {
    States res = States.empty();
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(servicesRepoProvider).getListOfCities(
            userOrgId: userOrgId,
            state: state,
          );
      res = States.fromJson(result.data);
      return res;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return res;
    }
  }

  // * Get org By ID
  Future<OrgDoc?> getOrgById(String orgId) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(servicesRepoProvider).getOrgById(
            userOrgId: userOrgId,
            orgId: orgId,
          );
      // print(result.data);
      OrgDoc doc = OrgDoc.fromJson(result.data['data']['message']);
      return doc;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return null;
    }
  }

  // Add Fuel service to Organization
  Future<bool> addFuelServiceToOrganization(
    FuelServiceInputModel formInput,
  ) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(servicesRepoProvider).addFuelServiceToOrganization(
            userOrgId: userOrgId,
            formInput: formInput,
          );
      Snackbar.success('Fuel service enabled for your organization');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));

      return false;
    }
  }

  //Updating Add Fuel service to Organization
  Future<bool> updateAddFuelServiceToOrganization(
    FuelServiceUpdateInputModel formInput,
  ) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(servicesRepoProvider).updateAddFuelServiceToOrganization(
            orgEnrollId: userOrgId,
            formInput: formInput,
          );
      Snackbar.success('Fuel service enabled for your organization');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // Retry Add Fuel service to Organization
  Future<bool> retryAddFuelServiceToOrganization(
    FuelServiceRetryInputModel formInput,
  ) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      await ref.read(servicesRepoProvider).retryAddFuelServiceToOrganization(
            userOrgId: userOrgId,
            formInput: formInput,
          );
      Snackbar.success('Fuel service enabled for your organization');
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  // Approve Fuel service to Organization
  Future<bool> verifyOrgKyc(
    VerifyOrgKycInputModel formInput,
  ) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(servicesRepoProvider).verifyOrgKyc(
            userOrgId: userOrgId,
            formInput: formInput,
          );
      if (result.data['error'] != null) {
        Snackbar.error(ApiHelper.getErrorMessage(result.data['error']));
      } else {
        final res = Mtopresponse.fromJson(result.data);
        print(res);
        Snackbar.success(res.data!.message);
      }
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

  //Create Corporate Wallet for LQTag

  Future<bool> createLqTagCorporateWallet(String orgEnrolId) async {
    try {
      final userOrgId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgId) ?? '';

      Response result = await ref.read(servicesRepoProvider).createLqTagCorporateWallet(
            userOrgId: userOrgId,
            orgEnrollId: orgEnrolId,
          );
      Snackbar.success(result.data['data']['message']);
      return true;
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }

// Get Lq Fleet Corporate Wallet for an organisation
  Future getLqTagCorporateWallet({required String orgEnrolId}) async {
    try {
      final userOrgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';

      Response result = await ref.read(servicesRepoProvider).getLqTagCorporateWallet(
            userOrgEnrollId: userOrgEnrollId.toLowerCase(),
            orgEnrollId: orgEnrolId.toLowerCase(),
          );
      // Snackbar.success(result.data['data']['message']);
      return result.data['data']['message'];
    } catch (e) {
      // debugPrint(e.toString());
      Snackbar.error(ApiHelper.getErrorMessage(e));
      return false;
    }
  }
}
