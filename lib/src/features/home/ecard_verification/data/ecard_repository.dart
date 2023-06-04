import 'package:dio/dio.dart';
import 'package:axlerate/values/strings.dart';
import 'package:axlerate/src/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eCardRepositoryProvider = Provider<ECardRepository>((ref) {
  final dio = ref.watch(dioProvider).dio;
  return ECardRepository(dio);
});

class ECardRepository {
  const ECardRepository(this.dio);

  final Dio dio;

  static String baseUrl = '${Strings.baseUrl}/api/organization';
  static String baseDashUrl = '${Strings.baseUrl}/api/dashboard';

  Future<Response> getChallanData({
    required Map<String, dynamic> postParam,
  }) async {
    String path =
        'https://uat.paysprint.in/sprintverify-uat/api/v1/verification/chalan_info';
    dio.options.headers['Token'] =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0aW1lc3RhbXAiOjE2ODAwNjc3MjcsInBhcnRuZXJJZCI6IkNPUlAwMDAwMSIsInJlcWlkIjoia2V5NTg3MDQwIn0.jeI3M-5sndTPP3gYdsKcR8Lc4u9e-NFYeSCAsb-d_Fo';
    dio.options.headers["Authorisedkey"] =
        "TVRJek5EVTJOelUwTnpKRFQxSlFNREF3TURFPQ==";
    try {
      Response response = await dio.post(
        path,
        data: postParam,
      );
      return response;
    } catch (xe) {
      rethrow;
    }
  }

  Future<Response> getRcData({
    required Map<String, dynamic> postParam,
  }) async {
    String path =
        'https://uat.paysprint.in/sprintverify-uat/api/v1/verification/rc_verify';
    dio.options.headers['Token'] =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0aW1lc3RhbXAiOjE2ODAwNjc3MjcsInBhcnRuZXJJZCI6IkNPUlAwMDAwMSIsInJlcWlkIjoia2V5NTg3MDQwIn0.jeI3M-5sndTPP3gYdsKcR8Lc4u9e-NFYeSCAsb-d_Fo';
    dio.options.headers["Authorisedkey"] =
    "TVRJek5EVTJOelUwTnpKRFQxSlFNREF3TURFPQ==";
    try {
      Response response = await dio.post(
        path,
        data: postParam,
      );
      return response;
    } catch (xe) {
      rethrow;
    }
  }

  Future<Response> getPanData({
    required Map<String, dynamic> postParam,
  }) async {
    String path =
        'https://uat.paysprint.in/sprintverify-uat/api/v1/verification/pandetails_verify?=&=';
    dio.options.headers['Token'] =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0aW1lc3RhbXAiOjE2ODAwNjc3MjcsInBhcnRuZXJJZCI6IkNPUlAwMDAwMSIsInJlcWlkIjoia2V5NTg3MDQwIn0.jeI3M-5sndTPP3gYdsKcR8Lc4u9e-NFYeSCAsb-d_Fo';
    dio.options.headers["Authorisedkey"] =
    "TVRJek5EVTJOelUwTnpKRFQxSlFNREF3TURFPQ==";
    try {
      Response response = await dio.post(
        path,
        data: postParam,
      );
      return response;
    } catch (xe) {
      rethrow;
    }
  }

  Future<Response> getAadhaarOtp({
    required Map<String, dynamic> postParam,
  }) async {
    String path =
        'https://uat.paysprint.in/sprintverify-uat/api/v1/verification/aadhaar_sendotp';
    dio.options.headers['Token'] =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0aW1lc3RhbXAiOjE2ODAwNjc3MjcsInBhcnRuZXJJZCI6IkNPUlAwMDAwMSIsInJlcWlkIjoia2V5NTg3MDQwIn0.jeI3M-5sndTPP3gYdsKcR8Lc4u9e-NFYeSCAsb-d_Fo';
    dio.options.headers["Authorisedkey"] =
    "TVRJek5EVTJOelUwTnpKRFQxSlFNREF3TURFPQ==";
    try {
      Response response = await dio.post(
        path,
        data: postParam,
      );
      return response;
    } catch (xe) {
      rethrow;
    }
  }

  Future<Response> verifyOtpGetData({
    required Map<String, dynamic> postParam,
  }) async {
    String path =
        'https://uat.paysprint.in/sprintverify-uat/api/v1/verification/aadhaar_verifyotp';
    dio.options.headers['Token'] =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0aW1lc3RhbXAiOjE2ODAwNjc3MjcsInBhcnRuZXJJZCI6IkNPUlAwMDAwMSIsInJlcWlkIjoia2V5NTg3MDQwIn0.jeI3M-5sndTPP3gYdsKcR8Lc4u9e-NFYeSCAsb-d_Fo';
    dio.options.headers["Authorisedkey"] =
    "TVRJek5EVTJOelUwTnpKRFQxSlFNREF3TURFPQ==";
    try {
      Response response = await dio.post(
        path,
        data: postParam,
      );
      return response;
    } catch (xe) {
      rethrow;
    }
  }


  Future<Response> drivingLicenseData({
    required Map<String, dynamic> postParam,
  }) async {
    String path =
        'https://uat.paysprint.in/sprintverify-uat/api/v1/verification/drivinglicense_verify';
    dio.options.headers['Token'] =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0aW1lc3RhbXAiOjE2ODAwNjc3MjcsInBhcnRuZXJJZCI6IkNPUlAwMDAwMSIsInJlcWlkIjoia2V5NTg3MDQwIn0.jeI3M-5sndTPP3gYdsKcR8Lc4u9e-NFYeSCAsb-d_Fo';
    dio.options.headers["Authorisedkey"] =
    "TVRJek5EVTJOelUwTnpKRFQxSlFNREF3TURFPQ==";
    try {
      Response response = await dio.post(
        path,
        data: postParam,
      );
      return response;
    } catch (xe) {
      rethrow;
    }
  }


  Future<Response> getCibilData({
    required Map<String, dynamic> postParam,
  }) async {
    String path =
        'https://uat.paysprint.in/sprintverify-uat/api/v1/verification/cbil_score';
    dio.options.headers['Token'] =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0aW1lc3RhbXAiOjE2ODAwNjc3MjcsInBhcnRuZXJJZCI6IkNPUlAwMDAwMSIsInJlcWlkIjoia2V5NTg3MDQwIn0.jeI3M-5sndTPP3gYdsKcR8Lc4u9e-NFYeSCAsb-d_Fo';
    dio.options.headers["Authorisedkey"] =
    "TVRJek5EVTJOelUwTnpKRFQxSlFNREF3TURFPQ==";
    try {
      Response response = await dio.post(
        path,
        data: postParam,
      );
      return response;
    } catch (xe) {
      rethrow;
    }
  }


}
