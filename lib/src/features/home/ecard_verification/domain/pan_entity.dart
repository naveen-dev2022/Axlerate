import 'dart:convert';
/// statuscode : 200
/// status : true
/// message : "KYC Details for PAN retrieved successfully"
/// reference_id : 20231457
/// data : {"idNumber":"LIHPS5643H","idStatus":"VALID","panStatus":"VALID","lastName":"Dummy","firstName":"Dummy","fullName":"Dummy Dummy","idHolderTitle":"Shri","idLastUpdated":"13/10/2022","aadhaarSeedingStatus":"Y"}

PanEntity panEntityFromJson(String str) => PanEntity.fromJson(json.decode(str));
String panEntityToJson(PanEntity data) => json.encode(data.toJson());
class PanEntity {
  PanEntity({
      num? statuscode, 
      bool? status, 
      String? message, 
      num? referenceId, 
      Data? data,}){
    _statuscode = statuscode;
    _status = status;
    _message = message;
    _referenceId = referenceId;
    _data = data;
}
  PanEntity.unknown() : _data = null;
  PanEntity.fromJson(dynamic json) {
    _statuscode = json['statuscode'];
    _status = json['status'];
    _message = json['message'];
    _referenceId = json['reference_id'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _statuscode;
  bool? _status;
  String? _message;
  num? _referenceId;
  Data? _data;
PanEntity copyWith({  num? statuscode,
  bool? status,
  String? message,
  num? referenceId,
  Data? data,
}) => PanEntity(  statuscode: statuscode ?? _statuscode,
  status: status ?? _status,
  message: message ?? _message,
  referenceId: referenceId ?? _referenceId,
  data: data ?? _data,
);
  num? get statuscode => _statuscode;
  bool? get status => _status;
  String? get message => _message;
  num? get referenceId => _referenceId;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statuscode'] = _statuscode;
    map['status'] = _status;
    map['message'] = _message;
    map['reference_id'] = _referenceId;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// idNumber : "LIHPS5643H"
/// idStatus : "VALID"
/// panStatus : "VALID"
/// lastName : "Dummy"
/// firstName : "Dummy"
/// fullName : "Dummy Dummy"
/// idHolderTitle : "Shri"
/// idLastUpdated : "13/10/2022"
/// aadhaarSeedingStatus : "Y"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? idNumber, 
      String? idStatus, 
      String? panStatus, 
      String? lastName, 
      String? firstName, 
      String? fullName, 
      String? idHolderTitle, 
      String? idLastUpdated, 
      String? aadhaarSeedingStatus,}){
    _idNumber = idNumber;
    _idStatus = idStatus;
    _panStatus = panStatus;
    _lastName = lastName;
    _firstName = firstName;
    _fullName = fullName;
    _idHolderTitle = idHolderTitle;
    _idLastUpdated = idLastUpdated;
    _aadhaarSeedingStatus = aadhaarSeedingStatus;
}

  Data.fromJson(dynamic json) {
    _idNumber = json['idNumber'];
    _idStatus = json['idStatus'];
    _panStatus = json['panStatus'];
    _lastName = json['lastName'];
    _firstName = json['firstName'];
    _fullName = json['fullName'];
    _idHolderTitle = json['idHolderTitle'];
    _idLastUpdated = json['idLastUpdated'];
    _aadhaarSeedingStatus = json['aadhaarSeedingStatus'];
  }
  String? _idNumber;
  String? _idStatus;
  String? _panStatus;
  String? _lastName;
  String? _firstName;
  String? _fullName;
  String? _idHolderTitle;
  String? _idLastUpdated;
  String? _aadhaarSeedingStatus;
Data copyWith({  String? idNumber,
  String? idStatus,
  String? panStatus,
  String? lastName,
  String? firstName,
  String? fullName,
  String? idHolderTitle,
  String? idLastUpdated,
  String? aadhaarSeedingStatus,
}) => Data(  idNumber: idNumber ?? _idNumber,
  idStatus: idStatus ?? _idStatus,
  panStatus: panStatus ?? _panStatus,
  lastName: lastName ?? _lastName,
  firstName: firstName ?? _firstName,
  fullName: fullName ?? _fullName,
  idHolderTitle: idHolderTitle ?? _idHolderTitle,
  idLastUpdated: idLastUpdated ?? _idLastUpdated,
  aadhaarSeedingStatus: aadhaarSeedingStatus ?? _aadhaarSeedingStatus,
);
  String? get idNumber => _idNumber;
  String? get idStatus => _idStatus;
  String? get panStatus => _panStatus;
  String? get lastName => _lastName;
  String? get firstName => _firstName;
  String? get fullName => _fullName;
  String? get idHolderTitle => _idHolderTitle;
  String? get idLastUpdated => _idLastUpdated;
  String? get aadhaarSeedingStatus => _aadhaarSeedingStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idNumber'] = _idNumber;
    map['idStatus'] = _idStatus;
    map['panStatus'] = _panStatus;
    map['lastName'] = _lastName;
    map['firstName'] = _firstName;
    map['fullName'] = _fullName;
    map['idHolderTitle'] = _idHolderTitle;
    map['idLastUpdated'] = _idLastUpdated;
    map['aadhaarSeedingStatus'] = _aadhaarSeedingStatus;
    return map;
  }

}