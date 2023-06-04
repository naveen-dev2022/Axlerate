import 'dart:convert';
/// statuscode : 200
/// status : true
/// message : "Success!"
/// reference_id : 20231375
/// data : {"client_id":"license_6831d4304ff32a7671ffb609ce438299","license_number":"TN3820190002729","state":"DL","name":"JOHNY SINGH","permanent_address":"VPO JOHN KLN DISTT DELHI","permanent_zip":"110088","temporary_address":"VPO JOHN KLN DISTT DELHI","temporary_zip":"110088","citizenship":"IND","ola_name":"RTA,DELHI","ola_code":"DL07","gender":"M","father_or_husband_name":"JOHN SINGH","dob":"1979-05-01","doe":"2029-04-30","transport_doe":"1900-01-01","doi":"2015-06-25","transport_doi":"1900-01-01","profile_image":"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","has_image":true,"blood_group":"A+","vehicle_classes":["LMV   ","MCWG  "],"less_info":false,"additional_check":[],"initial_doi":"2015-06-25"}

DrivingLicenseEntity drivingLicenseEntityFromJson(String str) => DrivingLicenseEntity.fromJson(json.decode(str));
String drivingLicenseEntityToJson(DrivingLicenseEntity data) => json.encode(data.toJson());
class DrivingLicenseEntity {
  DrivingLicenseEntity({
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

  DrivingLicenseEntity.unknown() : _data = null;

  DrivingLicenseEntity.fromJson(dynamic json) {
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
DrivingLicenseEntity copyWith({  num? statuscode,
  bool? status,
  String? message,
  num? referenceId,
  Data? data,
}) => DrivingLicenseEntity(  statuscode: statuscode ?? _statuscode,
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

/// client_id : "license_6831d4304ff32a7671ffb609ce438299"
/// license_number : "TN3820190002729"
/// state : "DL"
/// name : "JOHNY SINGH"
/// permanent_address : "VPO JOHN KLN DISTT DELHI"
/// permanent_zip : "110088"
/// temporary_address : "VPO JOHN KLN DISTT DELHI"
/// temporary_zip : "110088"
/// citizenship : "IND"
/// ola_name : "RTA,DELHI"
/// ola_code : "DL07"
/// gender : "M"
/// father_or_husband_name : "JOHN SINGH"
/// dob : "1979-05-01"
/// doe : "2029-04-30"
/// transport_doe : "1900-01-01"
/// doi : "2015-06-25"
/// transport_doi : "1900-01-01"
/// profile_image : "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"
/// has_image : true
/// blood_group : "A+"
/// vehicle_classes : ["LMV   ","MCWG  "]
/// less_info : false
/// additional_check : []
/// initial_doi : "2015-06-25"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? clientId, 
      String? licenseNumber, 
      String? state, 
      String? name, 
      String? permanentAddress, 
      String? permanentZip, 
      String? temporaryAddress, 
      String? temporaryZip, 
      String? citizenship, 
      String? olaName, 
      String? olaCode, 
      String? gender, 
      String? fatherOrHusbandName, 
      String? dob, 
      String? doe, 
      String? transportDoe, 
      String? doi, 
      String? transportDoi, 
      String? profileImage, 
      bool? hasImage, 
      String? bloodGroup, 
      List<String>? vehicleClasses, 
      bool? lessInfo, 
      List<dynamic>? additionalCheck, 
      String? initialDoi,}){
    _clientId = clientId;
    _licenseNumber = licenseNumber;
    _state = state;
    _name = name;
    _permanentAddress = permanentAddress;
    _permanentZip = permanentZip;
    _temporaryAddress = temporaryAddress;
    _temporaryZip = temporaryZip;
    _citizenship = citizenship;
    _olaName = olaName;
    _olaCode = olaCode;
    _gender = gender;
    _fatherOrHusbandName = fatherOrHusbandName;
    _dob = dob;
    _doe = doe;
    _transportDoe = transportDoe;
    _doi = doi;
    _transportDoi = transportDoi;
    _profileImage = profileImage;
    _hasImage = hasImage;
    _bloodGroup = bloodGroup;
    _vehicleClasses = vehicleClasses;
    _lessInfo = lessInfo;
    _additionalCheck = additionalCheck;
    _initialDoi = initialDoi;
}

  Data.fromJson(dynamic json) {
    _clientId = json['client_id'];
    _licenseNumber = json['license_number'];
    _state = json['state'];
    _name = json['name'];
    _permanentAddress = json['permanent_address'];
    _permanentZip = json['permanent_zip'];
    _temporaryAddress = json['temporary_address'];
    _temporaryZip = json['temporary_zip'];
    _citizenship = json['citizenship'];
    _olaName = json['ola_name'];
    _olaCode = json['ola_code'];
    _gender = json['gender'];
    _fatherOrHusbandName = json['father_or_husband_name'];
    _dob = json['dob'];
    _doe = json['doe'];
    _transportDoe = json['transport_doe'];
    _doi = json['doi'];
    _transportDoi = json['transport_doi'];
    _profileImage = json['profile_image'];
    _hasImage = json['has_image'];
    _bloodGroup = json['blood_group'];
    _vehicleClasses = json['vehicle_classes'] != null ? json['vehicle_classes'].cast<String>() : [];
    _lessInfo = json['less_info'];
    // if (json['additional_check'] != null) {
    //   _additionalCheck = [];
    //   json['additional_check'].forEach((v) {
    //     _additionalCheck?.add(Dynamic.fromJson(v));
    //   });
    // }
    _initialDoi = json['initial_doi'];
  }
  String? _clientId;
  String? _licenseNumber;
  String? _state;
  String? _name;
  String? _permanentAddress;
  String? _permanentZip;
  String? _temporaryAddress;
  String? _temporaryZip;
  String? _citizenship;
  String? _olaName;
  String? _olaCode;
  String? _gender;
  String? _fatherOrHusbandName;
  String? _dob;
  String? _doe;
  String? _transportDoe;
  String? _doi;
  String? _transportDoi;
  String? _profileImage;
  bool? _hasImage;
  String? _bloodGroup;
  List<String>? _vehicleClasses;
  bool? _lessInfo;
  List<dynamic>? _additionalCheck;
  String? _initialDoi;
Data copyWith({  String? clientId,
  String? licenseNumber,
  String? state,
  String? name,
  String? permanentAddress,
  String? permanentZip,
  String? temporaryAddress,
  String? temporaryZip,
  String? citizenship,
  String? olaName,
  String? olaCode,
  String? gender,
  String? fatherOrHusbandName,
  String? dob,
  String? doe,
  String? transportDoe,
  String? doi,
  String? transportDoi,
  String? profileImage,
  bool? hasImage,
  String? bloodGroup,
  List<String>? vehicleClasses,
  bool? lessInfo,
  List<dynamic>? additionalCheck,
  String? initialDoi,
}) => Data(  clientId: clientId ?? _clientId,
  licenseNumber: licenseNumber ?? _licenseNumber,
  state: state ?? _state,
  name: name ?? _name,
  permanentAddress: permanentAddress ?? _permanentAddress,
  permanentZip: permanentZip ?? _permanentZip,
  temporaryAddress: temporaryAddress ?? _temporaryAddress,
  temporaryZip: temporaryZip ?? _temporaryZip,
  citizenship: citizenship ?? _citizenship,
  olaName: olaName ?? _olaName,
  olaCode: olaCode ?? _olaCode,
  gender: gender ?? _gender,
  fatherOrHusbandName: fatherOrHusbandName ?? _fatherOrHusbandName,
  dob: dob ?? _dob,
  doe: doe ?? _doe,
  transportDoe: transportDoe ?? _transportDoe,
  doi: doi ?? _doi,
  transportDoi: transportDoi ?? _transportDoi,
  profileImage: profileImage ?? _profileImage,
  hasImage: hasImage ?? _hasImage,
  bloodGroup: bloodGroup ?? _bloodGroup,
  vehicleClasses: vehicleClasses ?? _vehicleClasses,
  lessInfo: lessInfo ?? _lessInfo,
  additionalCheck: additionalCheck ?? _additionalCheck,
  initialDoi: initialDoi ?? _initialDoi,
);
  String? get clientId => _clientId;
  String? get licenseNumber => _licenseNumber;
  String? get state => _state;
  String? get name => _name;
  String? get permanentAddress => _permanentAddress;
  String? get permanentZip => _permanentZip;
  String? get temporaryAddress => _temporaryAddress;
  String? get temporaryZip => _temporaryZip;
  String? get citizenship => _citizenship;
  String? get olaName => _olaName;
  String? get olaCode => _olaCode;
  String? get gender => _gender;
  String? get fatherOrHusbandName => _fatherOrHusbandName;
  String? get dob => _dob;
  String? get doe => _doe;
  String? get transportDoe => _transportDoe;
  String? get doi => _doi;
  String? get transportDoi => _transportDoi;
  String? get profileImage => _profileImage;
  bool? get hasImage => _hasImage;
  String? get bloodGroup => _bloodGroup;
  List<String>? get vehicleClasses => _vehicleClasses;
  bool? get lessInfo => _lessInfo;
  List<dynamic>? get additionalCheck => _additionalCheck;
  String? get initialDoi => _initialDoi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_id'] = _clientId;
    map['license_number'] = _licenseNumber;
    map['state'] = _state;
    map['name'] = _name;
    map['permanent_address'] = _permanentAddress;
    map['permanent_zip'] = _permanentZip;
    map['temporary_address'] = _temporaryAddress;
    map['temporary_zip'] = _temporaryZip;
    map['citizenship'] = _citizenship;
    map['ola_name'] = _olaName;
    map['ola_code'] = _olaCode;
    map['gender'] = _gender;
    map['father_or_husband_name'] = _fatherOrHusbandName;
    map['dob'] = _dob;
    map['doe'] = _doe;
    map['transport_doe'] = _transportDoe;
    map['doi'] = _doi;
    map['transport_doi'] = _transportDoi;
    map['profile_image'] = _profileImage;
    map['has_image'] = _hasImage;
    map['blood_group'] = _bloodGroup;
    map['vehicle_classes'] = _vehicleClasses;
    map['less_info'] = _lessInfo;
    if (_additionalCheck != null) {
      map['additional_check'] = _additionalCheck?.map((v) => v.toJson()).toList();
    }
    map['initial_doi'] = _initialDoi;
    return map;
  }

}