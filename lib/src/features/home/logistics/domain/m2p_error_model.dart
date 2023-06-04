class M2PErrorModel {
  M2PErrorModel({
    required this.error,
    required this.errorCode,
  });

  String error;
  ErrorCode errorCode;

  factory M2PErrorModel.fromJson(Map<String, dynamic> json) => M2PErrorModel(
        error: json["error"],
        errorCode: ErrorCode.fromJson(json["errorCode"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "errorCode": errorCode.toJson(),
      };
}

class ErrorCode {
  ErrorCode({
    required this.displayMessage,
    required this.exception,
  });

  String displayMessage;
  Exception exception;

  factory ErrorCode.fromJson(Map<String, dynamic> json) => ErrorCode(
        displayMessage: json["displayMessage"],
        exception: Exception.fromJson(json["exception"]),
      );

  Map<String, dynamic> toJson() => {
        "displayMessage": displayMessage,
        "exception": exception.toJson(),
      };
}

class Exception {
  Exception({
    this.cause,
    required this.errorCode,
    required this.message,
    this.languageCode,
    this.errors,
    this.suppressed,
    this.localizedMessage,
  });

  dynamic cause;
  String errorCode;
  String message;
  String? languageCode;
  dynamic errors;
  List<dynamic>? suppressed;
  String? localizedMessage;

  factory Exception.fromJson(Map<String, dynamic> json) => Exception(
        cause: json["cause"],
        errorCode: json["errorCode"],
        message: json["message"],
        languageCode: json["languageCode"] ?? '',
        errors: json["errors"],
        suppressed: json["suppressed"] != null ? List<dynamic>.from(json["suppressed"].map((x) => x)) : [],
        localizedMessage: json["localizedMessage"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "cause": cause,
        "errorCode": errorCode,
        "message": message,
        "languageCode": languageCode,
        "errors": errors,
        "suppressed": List<dynamic>.from(suppressed!.map((x) => x)),
        "localizedMessage": localizedMessage,
      };
}
