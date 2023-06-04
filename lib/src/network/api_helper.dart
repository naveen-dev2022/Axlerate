import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiHelper {
  static getSuccessMessage(Response response) {
    String successMsg = '';
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      try {
        debugPrint("****** helper ${response.data}");
        successMsg = (response.data as Map<String, dynamic>)['data']['message'];
      } catch (e) {
        successMsg = 'Done';
      }
    }
    return successMsg;
  }

  static getErrorMessage(e) {
    String errorMessage = "";
    if (e is DioError && e.response != null) {
      // debugPrint(e.response.toString());
      try {
        errorMessage = (e.response?.data as Map<String, dynamic>)['error'];
      } catch (e) {
        errorMessage = "Something Went Wrong !";
      }
    } else {
      errorMessage = "Unable to load request! Please try again !";
    }
    return errorMessage;
  }

  static String getErrorCode(e) {
    String errorCode = "";
    if (e is DioError && e.response != null) {
      try {
        errorCode = (e.response?.data as Map<String, dynamic>)['errorCode'];
      } catch (e) {
        errorCode = "Something Went Wrong !";
      }
    }
    return errorCode;
  }
}
