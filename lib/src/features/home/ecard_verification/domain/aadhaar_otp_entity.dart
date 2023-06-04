import 'dart:convert';
/// statuscode : 200
/// status : true
/// message : "Success!"
/// data : {"client_id":"aadhaar_v2_e04d4264bfad6689646b6194664e5b68","otp_sent":true,"if_number":true,"valid_aadhaar":true,"status":"generate_otp_success"}

AadhaarOtpEntity aadhaarOtpEntityFromJson(String str) => AadhaarOtpEntity.fromJson(json.decode(str));
String aadhaarOtpEntityToJson(AadhaarOtpEntity data) => json.encode(data.toJson());
class AadhaarOtpEntity {
  AadhaarOtpEntity({
      num? statuscode, 
      bool? status, 
      String? message, 
      Data? data,}){
    _statuscode = statuscode;
    _status = status;
    _message = message;
    _data = data;
}
  AadhaarOtpEntity.unknown() : _data = null;

  AadhaarOtpEntity.fromJson(dynamic json) {
    _statuscode = json['statuscode'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _statuscode;
  bool? _status;
  String? _message;
  Data? _data;
AadhaarOtpEntity copyWith({  num? statuscode,
  bool? status,
  String? message,
  Data? data,
}) => AadhaarOtpEntity(  statuscode: statuscode ?? _statuscode,
  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get statuscode => _statuscode;
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statuscode'] = _statuscode;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// client_id : "aadhaar_v2_e04d4264bfad6689646b6194664e5b68"
/// otp_sent : true
/// if_number : true
/// valid_aadhaar : true
/// status : "generate_otp_success"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? clientId, 
      bool? otpSent, 
      bool? ifNumber, 
      bool? validAadhaar, 
      String? status,}){
    _clientId = clientId;
    _otpSent = otpSent;
    _ifNumber = ifNumber;
    _validAadhaar = validAadhaar;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _clientId = json['client_id'];
    _otpSent = json['otp_sent'];
    _ifNumber = json['if_number'];
    _validAadhaar = json['valid_aadhaar'];
    _status = json['status'];
  }
  String? _clientId;
  bool? _otpSent;
  bool? _ifNumber;
  bool? _validAadhaar;
  String? _status;
Data copyWith({  String? clientId,
  bool? otpSent,
  bool? ifNumber,
  bool? validAadhaar,
  String? status,
}) => Data(  clientId: clientId ?? _clientId,
  otpSent: otpSent ?? _otpSent,
  ifNumber: ifNumber ?? _ifNumber,
  validAadhaar: validAadhaar ?? _validAadhaar,
  status: status ?? _status,
);
  String? get clientId => _clientId;
  bool? get otpSent => _otpSent;
  bool? get ifNumber => _ifNumber;
  bool? get validAadhaar => _validAadhaar;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_id'] = _clientId;
    map['otp_sent'] = _otpSent;
    map['if_number'] = _ifNumber;
    map['valid_aadhaar'] = _validAadhaar;
    map['status'] = _status;
    return map;
  }

}