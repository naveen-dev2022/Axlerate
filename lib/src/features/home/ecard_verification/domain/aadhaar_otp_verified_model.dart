import 'dart:convert';

/// statuscode : 200
/// status : true
/// message : "Success!"
/// reference_id : 20231528
/// data : {"client_id":"123","full_name":"Dummy Dummy","aadhaar_number":"708334513041","dob":"1992-05-16","gender":"M","address":{"country":"India","dist":"xxxxxxxxxxxxxxxxx","state":"xxxxxxxxxxxxxx","po":"xxxxxxxxxxxxxxx","loc":"delllll, Post-lanovo, P.s-Apple, Anchal-HP","vtc":"xxxxxxxxxxxxx","subdist":"xxxxxxxxxxxx","street":"","house":"","landmark":""},"face_status":false,"face_score":-1,"zip":"843324","profile_image":"/9j/4AAQSkZJRgABAgAAAQABAAD/","has_image":true,"email_hash":"","mobile_hash":"dasdsfsxc ser54g434q32q454v546e5exgcbvnhy55434qcasd","raw_xml":"https://dvashajsbdajksz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=","zip_data":"https://njbgsdiafbj.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=","care_of":"S/O: Dummy name","share_code":"1278","mobile_verified":false,"reference_id":"42342342312312","aadhaar_pdf":null,"status":"success_aadhaar","uniqueness_id":"arwesdcsd5764fg7y658745wg56e5crfvg7867543q3456768"}

AadhaarOtpVerifiedModel aadhaarOtpVerifiedModelFromJson(String str) =>
    AadhaarOtpVerifiedModel.fromJson(json.decode(str));

String aadhaarOtpVerifiedModelToJson(AadhaarOtpVerifiedModel data) =>
    json.encode(data.toJson());

class AadhaarOtpVerifiedModel {
  AadhaarOtpVerifiedModel({
    num? statuscode,
    bool? status,
    String? message,
    num? referenceId,
    Data? data,
  }) {
    _statuscode = statuscode;
    _status = status;
    _message = message;
    _referenceId = referenceId;
    _data = data;
  }

  AadhaarOtpVerifiedModel.unknown() : _data = null;

  AadhaarOtpVerifiedModel.fromJson(dynamic json) {
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

  AadhaarOtpVerifiedModel copyWith({
    num? statuscode,
    bool? status,
    String? message,
    num? referenceId,
    Data? data,
  }) =>
      AadhaarOtpVerifiedModel(
        statuscode: statuscode ?? _statuscode,
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

/// client_id : "123"
/// full_name : "Dummy Dummy"
/// aadhaar_number : "708334513041"
/// dob : "1992-05-16"
/// gender : "M"
/// address : {"country":"India","dist":"xxxxxxxxxxxxxxxxx","state":"xxxxxxxxxxxxxx","po":"xxxxxxxxxxxxxxx","loc":"delllll, Post-lanovo, P.s-Apple, Anchal-HP","vtc":"xxxxxxxxxxxxx","subdist":"xxxxxxxxxxxx","street":"","house":"","landmark":""}
/// face_status : false
/// face_score : -1
/// zip : "843324"
/// profile_image : "/9j/4AAQSkZJRgABAgAAAQABAAD/"
/// has_image : true
/// email_hash : ""
/// mobile_hash : "dasdsfsxc ser54g434q32q454v546e5exgcbvnhy55434qcasd"
/// raw_xml : "https://dvashajsbdajksz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential="
/// zip_data : "https://njbgsdiafbj.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential="
/// care_of : "S/O: Dummy name"
/// share_code : "1278"
/// mobile_verified : false
/// reference_id : "42342342312312"
/// aadhaar_pdf : null
/// status : "success_aadhaar"
/// uniqueness_id : "arwesdcsd5764fg7y658745wg56e5crfvg7867543q3456768"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? clientId,
    String? fullName,
    String? aadhaarNumber,
    String? dob,
    String? gender,
    Address? address,
    bool? faceStatus,
    num? faceScore,
    String? zip,
    String? profileImage,
    bool? hasImage,
    String? emailHash,
    String? mobileHash,
    String? rawXml,
    String? zipData,
    String? careOf,
    String? shareCode,
    bool? mobileVerified,
    String? referenceId,
    dynamic aadhaarPdf,
    String? status,
    String? uniquenessId,
  }) {
    _clientId = clientId;
    _fullName = fullName;
    _aadhaarNumber = aadhaarNumber;
    _dob = dob;
    _gender = gender;
    _address = address;
    _faceStatus = faceStatus;
    _faceScore = faceScore;
    _zip = zip;
    _profileImage = profileImage;
    _hasImage = hasImage;
    _emailHash = emailHash;
    _mobileHash = mobileHash;
    _rawXml = rawXml;
    _zipData = zipData;
    _careOf = careOf;
    _shareCode = shareCode;
    _mobileVerified = mobileVerified;
    _referenceId = referenceId;
    _aadhaarPdf = aadhaarPdf;
    _status = status;
    _uniquenessId = uniquenessId;
  }

  Data.fromJson(dynamic json) {
    _clientId = json['client_id'];
    _fullName = json['full_name'];
    _aadhaarNumber = json['aadhaar_number'];
    _dob = json['dob'];
    _gender = json['gender'];
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _faceStatus = json['face_status'];
    _faceScore = json['face_score'];
    _zip = json['zip'];
    _profileImage = json['profile_image'];
    _hasImage = json['has_image'];
    _emailHash = json['email_hash'];
    _mobileHash = json['mobile_hash'];
    _rawXml = json['raw_xml'];
    _zipData = json['zip_data'];
    _careOf = json['care_of'];
    _shareCode = json['share_code'];
    _mobileVerified = json['mobile_verified'];
    _referenceId = json['reference_id'];
    _aadhaarPdf = json['aadhaar_pdf'];
    _status = json['status'];
    _uniquenessId = json['uniqueness_id'];
  }

  String? _clientId;
  String? _fullName;
  String? _aadhaarNumber;
  String? _dob;
  String? _gender;
  Address? _address;
  bool? _faceStatus;
  num? _faceScore;
  String? _zip;
  String? _profileImage;
  bool? _hasImage;
  String? _emailHash;
  String? _mobileHash;
  String? _rawXml;
  String? _zipData;
  String? _careOf;
  String? _shareCode;
  bool? _mobileVerified;
  String? _referenceId;
  dynamic _aadhaarPdf;
  String? _status;
  String? _uniquenessId;

  Data copyWith({
    String? clientId,
    String? fullName,
    String? aadhaarNumber,
    String? dob,
    String? gender,
    Address? address,
    bool? faceStatus,
    num? faceScore,
    String? zip,
    String? profileImage,
    bool? hasImage,
    String? emailHash,
    String? mobileHash,
    String? rawXml,
    String? zipData,
    String? careOf,
    String? shareCode,
    bool? mobileVerified,
    String? referenceId,
    dynamic aadhaarPdf,
    String? status,
    String? uniquenessId,
  }) =>
      Data(
        clientId: clientId ?? _clientId,
        fullName: fullName ?? _fullName,
        aadhaarNumber: aadhaarNumber ?? _aadhaarNumber,
        dob: dob ?? _dob,
        gender: gender ?? _gender,
        address: address ?? _address,
        faceStatus: faceStatus ?? _faceStatus,
        faceScore: faceScore ?? _faceScore,
        zip: zip ?? _zip,
        profileImage: profileImage ?? _profileImage,
        hasImage: hasImage ?? _hasImage,
        emailHash: emailHash ?? _emailHash,
        mobileHash: mobileHash ?? _mobileHash,
        rawXml: rawXml ?? _rawXml,
        zipData: zipData ?? _zipData,
        careOf: careOf ?? _careOf,
        shareCode: shareCode ?? _shareCode,
        mobileVerified: mobileVerified ?? _mobileVerified,
        referenceId: referenceId ?? _referenceId,
        aadhaarPdf: aadhaarPdf ?? _aadhaarPdf,
        status: status ?? _status,
        uniquenessId: uniquenessId ?? _uniquenessId,
      );

  String? get clientId => _clientId;

  String? get fullName => _fullName;

  String? get aadhaarNumber => _aadhaarNumber;

  String? get dob => _dob;

  String? get gender => _gender;

  Address? get address => _address;

  bool? get faceStatus => _faceStatus;

  num? get faceScore => _faceScore;

  String? get zip => _zip;

  String? get profileImage => _profileImage;

  bool? get hasImage => _hasImage;

  String? get emailHash => _emailHash;

  String? get mobileHash => _mobileHash;

  String? get rawXml => _rawXml;

  String? get zipData => _zipData;

  String? get careOf => _careOf;

  String? get shareCode => _shareCode;

  bool? get mobileVerified => _mobileVerified;

  String? get referenceId => _referenceId;

  dynamic get aadhaarPdf => _aadhaarPdf;

  String? get status => _status;

  String? get uniquenessId => _uniquenessId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_id'] = _clientId;
    map['full_name'] = _fullName;
    map['aadhaar_number'] = _aadhaarNumber;
    map['dob'] = _dob;
    map['gender'] = _gender;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['face_status'] = _faceStatus;
    map['face_score'] = _faceScore;
    map['zip'] = _zip;
    map['profile_image'] = _profileImage;
    map['has_image'] = _hasImage;
    map['email_hash'] = _emailHash;
    map['mobile_hash'] = _mobileHash;
    map['raw_xml'] = _rawXml;
    map['zip_data'] = _zipData;
    map['care_of'] = _careOf;
    map['share_code'] = _shareCode;
    map['mobile_verified'] = _mobileVerified;
    map['reference_id'] = _referenceId;
    map['aadhaar_pdf'] = _aadhaarPdf;
    map['status'] = _status;
    map['uniqueness_id'] = _uniquenessId;
    return map;
  }
}

/// country : "India"
/// dist : "xxxxxxxxxxxxxxxxx"
/// state : "xxxxxxxxxxxxxx"
/// po : "xxxxxxxxxxxxxxx"
/// loc : "delllll, Post-lanovo, P.s-Apple, Anchal-HP"
/// vtc : "xxxxxxxxxxxxx"
/// subdist : "xxxxxxxxxxxx"
/// street : ""
/// house : ""
/// landmark : ""

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    String? country,
    String? dist,
    String? state,
    String? po,
    String? loc,
    String? vtc,
    String? subdist,
    String? street,
    String? house,
    String? landmark,
  }) {
    _country = country;
    _dist = dist;
    _state = state;
    _po = po;
    _loc = loc;
    _vtc = vtc;
    _subdist = subdist;
    _street = street;
    _house = house;
    _landmark = landmark;
  }

  Address.fromJson(dynamic json) {
    _country = json['country'];
    _dist = json['dist'];
    _state = json['state'];
    _po = json['po'];
    _loc = json['loc'];
    _vtc = json['vtc'];
    _subdist = json['subdist'];
    _street = json['street'];
    _house = json['house'];
    _landmark = json['landmark'];
  }

  String? _country;
  String? _dist;
  String? _state;
  String? _po;
  String? _loc;
  String? _vtc;
  String? _subdist;
  String? _street;
  String? _house;
  String? _landmark;

  Address copyWith({
    String? country,
    String? dist,
    String? state,
    String? po,
    String? loc,
    String? vtc,
    String? subdist,
    String? street,
    String? house,
    String? landmark,
  }) =>
      Address(
        country: country ?? _country,
        dist: dist ?? _dist,
        state: state ?? _state,
        po: po ?? _po,
        loc: loc ?? _loc,
        vtc: vtc ?? _vtc,
        subdist: subdist ?? _subdist,
        street: street ?? _street,
        house: house ?? _house,
        landmark: landmark ?? _landmark,
      );

  String? get country => _country;

  String? get dist => _dist;

  String? get state => _state;

  String? get po => _po;

  String? get loc => _loc;

  String? get vtc => _vtc;

  String? get subdist => _subdist;

  String? get street => _street;

  String? get house => _house;

  String? get landmark => _landmark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country'] = _country;
    map['dist'] = _dist;
    map['state'] = _state;
    map['po'] = _po;
    map['loc'] = _loc;
    map['vtc'] = _vtc;
    map['subdist'] = _subdist;
    map['street'] = _street;
    map['house'] = _house;
    map['landmark'] = _landmark;
    return map;
  }
}
