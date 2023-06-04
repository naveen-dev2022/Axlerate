import 'dart:convert';
/// statuscode : 200
/// status : true
/// message : "Success!"
/// reference_id : 20231374
/// data : {"client_id":"rc_565aa11c60db7e343b50a2a5e15128ac","rc_number":"TN38CH1948","registration_date":"2015-12-16","owner_name":"ABHINAV JAIN","father_name":"ABHEY JAIN","present_address":"A-0903, THE RESIDENCE, SECTOR 33, Gurgaon-122001","permanent_address":"A-0903, THE RESIDENCE, SECTOR 33, Gurgaon-122001","mobile_number":"","vehicle_category":"LMV","vehicle_chasi_number":"MA1YU2HHUF6K12744","vehicle_engine_number":"HHF4K21436","maker_description":"MAHINDRA & MAHINDRA LIMITED","maker_model":"XUV500","body_type":"SALOON","fuel_type":"DIESEL","color":"NPERLWHT","norms_type":"EURO 4","fit_up_to":"2030-12-15","financer":"","financed":null,"insurance_company":"The New India Assurance Company Limited","insurance_policy_number":"31030031220100290326","insurance_upto":"2023-12-18","manufacturing_date":"10/2015","manufacturing_date_formatted":"2015-10","registered_at":"SDM GURUGRAM, Haryana","latest_by":"2023-04-13","less_info":true,"tax_upto":"1900-01-01","tax_paid_upto":"1900-01-01","cubic_capacity":"0.00","vehicle_gross_weight":"2510","no_cylinders":"4","seat_capacity":"7","sleeper_capacity":"0","standing_capacity":"","wheelbase":"0","unladen_weight":"1850","vehicle_category_description":"Motor Car(LMV)","pucc_number":"DL00300410001347","pucc_upto":"2023-11-10","permit_number":"","permit_issue_date":"1900-01-01","permit_valid_from":"1900-01-01","permit_valid_upto":"1900-01-01","permit_type":"","national_permit_number":"","national_permit_upto":"1900-01-01","national_permit_issued_by":"","non_use_status":"","non_use_from":"1900-01-01","non_use_to":"1900-01-01","blacklist_status":"","noc_details":"","owner_number":"2","rc_status":"ACTIVE","masked_name":false,"challan_details":null,"variant":null}

RcEntity rcEntityFromJson(String str) => RcEntity.fromJson(json.decode(str));
String rcEntityToJson(RcEntity data) => json.encode(data.toJson());
class RcEntity {
  RcEntity({
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
  RcEntity.unknown() : _data = null;

  RcEntity.fromJson(dynamic json) {
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
RcEntity copyWith({  num? statuscode,
  bool? status,
  String? message,
  num? referenceId,
  Data? data,
}) => RcEntity(  statuscode: statuscode ?? _statuscode,
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

/// client_id : "rc_565aa11c60db7e343b50a2a5e15128ac"
/// rc_number : "TN38CH1948"
/// registration_date : "2015-12-16"
/// owner_name : "ABHINAV JAIN"
/// father_name : "ABHEY JAIN"
/// present_address : "A-0903, THE RESIDENCE, SECTOR 33, Gurgaon-122001"
/// permanent_address : "A-0903, THE RESIDENCE, SECTOR 33, Gurgaon-122001"
/// mobile_number : ""
/// vehicle_category : "LMV"
/// vehicle_chasi_number : "MA1YU2HHUF6K12744"
/// vehicle_engine_number : "HHF4K21436"
/// maker_description : "MAHINDRA & MAHINDRA LIMITED"
/// maker_model : "XUV500"
/// body_type : "SALOON"
/// fuel_type : "DIESEL"
/// color : "NPERLWHT"
/// norms_type : "EURO 4"
/// fit_up_to : "2030-12-15"
/// financer : ""
/// financed : null
/// insurance_company : "The New India Assurance Company Limited"
/// insurance_policy_number : "31030031220100290326"
/// insurance_upto : "2023-12-18"
/// manufacturing_date : "10/2015"
/// manufacturing_date_formatted : "2015-10"
/// registered_at : "SDM GURUGRAM, Haryana"
/// latest_by : "2023-04-13"
/// less_info : true
/// tax_upto : "1900-01-01"
/// tax_paid_upto : "1900-01-01"
/// cubic_capacity : "0.00"
/// vehicle_gross_weight : "2510"
/// no_cylinders : "4"
/// seat_capacity : "7"
/// sleeper_capacity : "0"
/// standing_capacity : ""
/// wheelbase : "0"
/// unladen_weight : "1850"
/// vehicle_category_description : "Motor Car(LMV)"
/// pucc_number : "DL00300410001347"
/// pucc_upto : "2023-11-10"
/// permit_number : ""
/// permit_issue_date : "1900-01-01"
/// permit_valid_from : "1900-01-01"
/// permit_valid_upto : "1900-01-01"
/// permit_type : ""
/// national_permit_number : ""
/// national_permit_upto : "1900-01-01"
/// national_permit_issued_by : ""
/// non_use_status : ""
/// non_use_from : "1900-01-01"
/// non_use_to : "1900-01-01"
/// blacklist_status : ""
/// noc_details : ""
/// owner_number : "2"
/// rc_status : "ACTIVE"
/// masked_name : false
/// challan_details : null
/// variant : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? clientId, 
      String? rcNumber, 
      String? registrationDate, 
      String? ownerName, 
      String? fatherName, 
      String? presentAddress, 
      String? permanentAddress, 
      String? mobileNumber, 
      String? vehicleCategory, 
      String? vehicleChasiNumber, 
      String? vehicleEngineNumber, 
      String? makerDescription, 
      String? makerModel, 
      String? bodyType, 
      String? fuelType, 
      String? color, 
      String? normsType, 
      String? fitUpTo, 
      String? financer, 
      dynamic financed, 
      String? insuranceCompany, 
      String? insurancePolicyNumber, 
      String? insuranceUpto, 
      String? manufacturingDate, 
      String? manufacturingDateFormatted, 
      String? registeredAt, 
      String? latestBy, 
      bool? lessInfo, 
      String? taxUpto, 
      String? taxPaidUpto, 
      String? cubicCapacity, 
      String? vehicleGrossWeight, 
      String? noCylinders, 
      String? seatCapacity, 
      String? sleeperCapacity, 
      String? standingCapacity, 
      String? wheelbase, 
      String? unladenWeight, 
      String? vehicleCategoryDescription, 
      String? puccNumber, 
      String? puccUpto, 
      String? permitNumber, 
      String? permitIssueDate, 
      String? permitValidFrom, 
      String? permitValidUpto, 
      String? permitType, 
      String? nationalPermitNumber, 
      String? nationalPermitUpto, 
      String? nationalPermitIssuedBy, 
      String? nonUseStatus, 
      String? nonUseFrom, 
      String? nonUseTo, 
      String? blacklistStatus, 
      String? nocDetails, 
      String? ownerNumber, 
      String? rcStatus, 
      bool? maskedName, 
      dynamic challanDetails, 
      dynamic variant,}){
    _clientId = clientId;
    _rcNumber = rcNumber;
    _registrationDate = registrationDate;
    _ownerName = ownerName;
    _fatherName = fatherName;
    _presentAddress = presentAddress;
    _permanentAddress = permanentAddress;
    _mobileNumber = mobileNumber;
    _vehicleCategory = vehicleCategory;
    _vehicleChasiNumber = vehicleChasiNumber;
    _vehicleEngineNumber = vehicleEngineNumber;
    _makerDescription = makerDescription;
    _makerModel = makerModel;
    _bodyType = bodyType;
    _fuelType = fuelType;
    _color = color;
    _normsType = normsType;
    _fitUpTo = fitUpTo;
    _financer = financer;
    _financed = financed;
    _insuranceCompany = insuranceCompany;
    _insurancePolicyNumber = insurancePolicyNumber;
    _insuranceUpto = insuranceUpto;
    _manufacturingDate = manufacturingDate;
    _manufacturingDateFormatted = manufacturingDateFormatted;
    _registeredAt = registeredAt;
    _latestBy = latestBy;
    _lessInfo = lessInfo;
    _taxUpto = taxUpto;
    _taxPaidUpto = taxPaidUpto;
    _cubicCapacity = cubicCapacity;
    _vehicleGrossWeight = vehicleGrossWeight;
    _noCylinders = noCylinders;
    _seatCapacity = seatCapacity;
    _sleeperCapacity = sleeperCapacity;
    _standingCapacity = standingCapacity;
    _wheelbase = wheelbase;
    _unladenWeight = unladenWeight;
    _vehicleCategoryDescription = vehicleCategoryDescription;
    _puccNumber = puccNumber;
    _puccUpto = puccUpto;
    _permitNumber = permitNumber;
    _permitIssueDate = permitIssueDate;
    _permitValidFrom = permitValidFrom;
    _permitValidUpto = permitValidUpto;
    _permitType = permitType;
    _nationalPermitNumber = nationalPermitNumber;
    _nationalPermitUpto = nationalPermitUpto;
    _nationalPermitIssuedBy = nationalPermitIssuedBy;
    _nonUseStatus = nonUseStatus;
    _nonUseFrom = nonUseFrom;
    _nonUseTo = nonUseTo;
    _blacklistStatus = blacklistStatus;
    _nocDetails = nocDetails;
    _ownerNumber = ownerNumber;
    _rcStatus = rcStatus;
    _maskedName = maskedName;
    _challanDetails = challanDetails;
    _variant = variant;
}

  Data.fromJson(dynamic json) {
    _clientId = json['client_id'];
    _rcNumber = json['rc_number'];
    _registrationDate = json['registration_date'];
    _ownerName = json['owner_name'];
    _fatherName = json['father_name'];
    _presentAddress = json['present_address'];
    _permanentAddress = json['permanent_address'];
    _mobileNumber = json['mobile_number'];
    _vehicleCategory = json['vehicle_category'];
    _vehicleChasiNumber = json['vehicle_chasi_number'];
    _vehicleEngineNumber = json['vehicle_engine_number'];
    _makerDescription = json['maker_description'];
    _makerModel = json['maker_model'];
    _bodyType = json['body_type'];
    _fuelType = json['fuel_type'];
    _color = json['color'];
    _normsType = json['norms_type'];
    _fitUpTo = json['fit_up_to'];
    _financer = json['financer'];
    _financed = json['financed'];
    _insuranceCompany = json['insurance_company'];
    _insurancePolicyNumber = json['insurance_policy_number'];
    _insuranceUpto = json['insurance_upto'];
    _manufacturingDate = json['manufacturing_date'];
    _manufacturingDateFormatted = json['manufacturing_date_formatted'];
    _registeredAt = json['registered_at'];
    _latestBy = json['latest_by'];
    _lessInfo = json['less_info'];
    _taxUpto = json['tax_upto'];
    _taxPaidUpto = json['tax_paid_upto'];
    _cubicCapacity = json['cubic_capacity'];
    _vehicleGrossWeight = json['vehicle_gross_weight'];
    _noCylinders = json['no_cylinders'];
    _seatCapacity = json['seat_capacity'];
    _sleeperCapacity = json['sleeper_capacity'];
    _standingCapacity = json['standing_capacity'];
    _wheelbase = json['wheelbase'];
    _unladenWeight = json['unladen_weight'];
    _vehicleCategoryDescription = json['vehicle_category_description'];
    _puccNumber = json['pucc_number'];
    _puccUpto = json['pucc_upto'];
    _permitNumber = json['permit_number'];
    _permitIssueDate = json['permit_issue_date'];
    _permitValidFrom = json['permit_valid_from'];
    _permitValidUpto = json['permit_valid_upto'];
    _permitType = json['permit_type'];
    _nationalPermitNumber = json['national_permit_number'];
    _nationalPermitUpto = json['national_permit_upto'];
    _nationalPermitIssuedBy = json['national_permit_issued_by'];
    _nonUseStatus = json['non_use_status'];
    _nonUseFrom = json['non_use_from'];
    _nonUseTo = json['non_use_to'];
    _blacklistStatus = json['blacklist_status'];
    _nocDetails = json['noc_details'];
    _ownerNumber = json['owner_number'];
    _rcStatus = json['rc_status'];
    _maskedName = json['masked_name'];
    _challanDetails = json['challan_details'];
    _variant = json['variant'];
  }
  String? _clientId;
  String? _rcNumber;
  String? _registrationDate;
  String? _ownerName;
  String? _fatherName;
  String? _presentAddress;
  String? _permanentAddress;
  String? _mobileNumber;
  String? _vehicleCategory;
  String? _vehicleChasiNumber;
  String? _vehicleEngineNumber;
  String? _makerDescription;
  String? _makerModel;
  String? _bodyType;
  String? _fuelType;
  String? _color;
  String? _normsType;
  String? _fitUpTo;
  String? _financer;
  dynamic _financed;
  String? _insuranceCompany;
  String? _insurancePolicyNumber;
  String? _insuranceUpto;
  String? _manufacturingDate;
  String? _manufacturingDateFormatted;
  String? _registeredAt;
  String? _latestBy;
  bool? _lessInfo;
  String? _taxUpto;
  String? _taxPaidUpto;
  String? _cubicCapacity;
  String? _vehicleGrossWeight;
  String? _noCylinders;
  String? _seatCapacity;
  String? _sleeperCapacity;
  String? _standingCapacity;
  String? _wheelbase;
  String? _unladenWeight;
  String? _vehicleCategoryDescription;
  String? _puccNumber;
  String? _puccUpto;
  String? _permitNumber;
  String? _permitIssueDate;
  String? _permitValidFrom;
  String? _permitValidUpto;
  String? _permitType;
  String? _nationalPermitNumber;
  String? _nationalPermitUpto;
  String? _nationalPermitIssuedBy;
  String? _nonUseStatus;
  String? _nonUseFrom;
  String? _nonUseTo;
  String? _blacklistStatus;
  String? _nocDetails;
  String? _ownerNumber;
  String? _rcStatus;
  bool? _maskedName;
  dynamic _challanDetails;
  dynamic _variant;
Data copyWith({  String? clientId,
  String? rcNumber,
  String? registrationDate,
  String? ownerName,
  String? fatherName,
  String? presentAddress,
  String? permanentAddress,
  String? mobileNumber,
  String? vehicleCategory,
  String? vehicleChasiNumber,
  String? vehicleEngineNumber,
  String? makerDescription,
  String? makerModel,
  String? bodyType,
  String? fuelType,
  String? color,
  String? normsType,
  String? fitUpTo,
  String? financer,
  dynamic financed,
  String? insuranceCompany,
  String? insurancePolicyNumber,
  String? insuranceUpto,
  String? manufacturingDate,
  String? manufacturingDateFormatted,
  String? registeredAt,
  String? latestBy,
  bool? lessInfo,
  String? taxUpto,
  String? taxPaidUpto,
  String? cubicCapacity,
  String? vehicleGrossWeight,
  String? noCylinders,
  String? seatCapacity,
  String? sleeperCapacity,
  String? standingCapacity,
  String? wheelbase,
  String? unladenWeight,
  String? vehicleCategoryDescription,
  String? puccNumber,
  String? puccUpto,
  String? permitNumber,
  String? permitIssueDate,
  String? permitValidFrom,
  String? permitValidUpto,
  String? permitType,
  String? nationalPermitNumber,
  String? nationalPermitUpto,
  String? nationalPermitIssuedBy,
  String? nonUseStatus,
  String? nonUseFrom,
  String? nonUseTo,
  String? blacklistStatus,
  String? nocDetails,
  String? ownerNumber,
  String? rcStatus,
  bool? maskedName,
  dynamic challanDetails,
  dynamic variant,
}) => Data(  clientId: clientId ?? _clientId,
  rcNumber: rcNumber ?? _rcNumber,
  registrationDate: registrationDate ?? _registrationDate,
  ownerName: ownerName ?? _ownerName,
  fatherName: fatherName ?? _fatherName,
  presentAddress: presentAddress ?? _presentAddress,
  permanentAddress: permanentAddress ?? _permanentAddress,
  mobileNumber: mobileNumber ?? _mobileNumber,
  vehicleCategory: vehicleCategory ?? _vehicleCategory,
  vehicleChasiNumber: vehicleChasiNumber ?? _vehicleChasiNumber,
  vehicleEngineNumber: vehicleEngineNumber ?? _vehicleEngineNumber,
  makerDescription: makerDescription ?? _makerDescription,
  makerModel: makerModel ?? _makerModel,
  bodyType: bodyType ?? _bodyType,
  fuelType: fuelType ?? _fuelType,
  color: color ?? _color,
  normsType: normsType ?? _normsType,
  fitUpTo: fitUpTo ?? _fitUpTo,
  financer: financer ?? _financer,
  financed: financed ?? _financed,
  insuranceCompany: insuranceCompany ?? _insuranceCompany,
  insurancePolicyNumber: insurancePolicyNumber ?? _insurancePolicyNumber,
  insuranceUpto: insuranceUpto ?? _insuranceUpto,
  manufacturingDate: manufacturingDate ?? _manufacturingDate,
  manufacturingDateFormatted: manufacturingDateFormatted ?? _manufacturingDateFormatted,
  registeredAt: registeredAt ?? _registeredAt,
  latestBy: latestBy ?? _latestBy,
  lessInfo: lessInfo ?? _lessInfo,
  taxUpto: taxUpto ?? _taxUpto,
  taxPaidUpto: taxPaidUpto ?? _taxPaidUpto,
  cubicCapacity: cubicCapacity ?? _cubicCapacity,
  vehicleGrossWeight: vehicleGrossWeight ?? _vehicleGrossWeight,
  noCylinders: noCylinders ?? _noCylinders,
  seatCapacity: seatCapacity ?? _seatCapacity,
  sleeperCapacity: sleeperCapacity ?? _sleeperCapacity,
  standingCapacity: standingCapacity ?? _standingCapacity,
  wheelbase: wheelbase ?? _wheelbase,
  unladenWeight: unladenWeight ?? _unladenWeight,
  vehicleCategoryDescription: vehicleCategoryDescription ?? _vehicleCategoryDescription,
  puccNumber: puccNumber ?? _puccNumber,
  puccUpto: puccUpto ?? _puccUpto,
  permitNumber: permitNumber ?? _permitNumber,
  permitIssueDate: permitIssueDate ?? _permitIssueDate,
  permitValidFrom: permitValidFrom ?? _permitValidFrom,
  permitValidUpto: permitValidUpto ?? _permitValidUpto,
  permitType: permitType ?? _permitType,
  nationalPermitNumber: nationalPermitNumber ?? _nationalPermitNumber,
  nationalPermitUpto: nationalPermitUpto ?? _nationalPermitUpto,
  nationalPermitIssuedBy: nationalPermitIssuedBy ?? _nationalPermitIssuedBy,
  nonUseStatus: nonUseStatus ?? _nonUseStatus,
  nonUseFrom: nonUseFrom ?? _nonUseFrom,
  nonUseTo: nonUseTo ?? _nonUseTo,
  blacklistStatus: blacklistStatus ?? _blacklistStatus,
  nocDetails: nocDetails ?? _nocDetails,
  ownerNumber: ownerNumber ?? _ownerNumber,
  rcStatus: rcStatus ?? _rcStatus,
  maskedName: maskedName ?? _maskedName,
  challanDetails: challanDetails ?? _challanDetails,
  variant: variant ?? _variant,
);
  String? get clientId => _clientId;
  String? get rcNumber => _rcNumber;
  String? get registrationDate => _registrationDate;
  String? get ownerName => _ownerName;
  String? get fatherName => _fatherName;
  String? get presentAddress => _presentAddress;
  String? get permanentAddress => _permanentAddress;
  String? get mobileNumber => _mobileNumber;
  String? get vehicleCategory => _vehicleCategory;
  String? get vehicleChasiNumber => _vehicleChasiNumber;
  String? get vehicleEngineNumber => _vehicleEngineNumber;
  String? get makerDescription => _makerDescription;
  String? get makerModel => _makerModel;
  String? get bodyType => _bodyType;
  String? get fuelType => _fuelType;
  String? get color => _color;
  String? get normsType => _normsType;
  String? get fitUpTo => _fitUpTo;
  String? get financer => _financer;
  dynamic get financed => _financed;
  String? get insuranceCompany => _insuranceCompany;
  String? get insurancePolicyNumber => _insurancePolicyNumber;
  String? get insuranceUpto => _insuranceUpto;
  String? get manufacturingDate => _manufacturingDate;
  String? get manufacturingDateFormatted => _manufacturingDateFormatted;
  String? get registeredAt => _registeredAt;
  String? get latestBy => _latestBy;
  bool? get lessInfo => _lessInfo;
  String? get taxUpto => _taxUpto;
  String? get taxPaidUpto => _taxPaidUpto;
  String? get cubicCapacity => _cubicCapacity;
  String? get vehicleGrossWeight => _vehicleGrossWeight;
  String? get noCylinders => _noCylinders;
  String? get seatCapacity => _seatCapacity;
  String? get sleeperCapacity => _sleeperCapacity;
  String? get standingCapacity => _standingCapacity;
  String? get wheelbase => _wheelbase;
  String? get unladenWeight => _unladenWeight;
  String? get vehicleCategoryDescription => _vehicleCategoryDescription;
  String? get puccNumber => _puccNumber;
  String? get puccUpto => _puccUpto;
  String? get permitNumber => _permitNumber;
  String? get permitIssueDate => _permitIssueDate;
  String? get permitValidFrom => _permitValidFrom;
  String? get permitValidUpto => _permitValidUpto;
  String? get permitType => _permitType;
  String? get nationalPermitNumber => _nationalPermitNumber;
  String? get nationalPermitUpto => _nationalPermitUpto;
  String? get nationalPermitIssuedBy => _nationalPermitIssuedBy;
  String? get nonUseStatus => _nonUseStatus;
  String? get nonUseFrom => _nonUseFrom;
  String? get nonUseTo => _nonUseTo;
  String? get blacklistStatus => _blacklistStatus;
  String? get nocDetails => _nocDetails;
  String? get ownerNumber => _ownerNumber;
  String? get rcStatus => _rcStatus;
  bool? get maskedName => _maskedName;
  dynamic get challanDetails => _challanDetails;
  dynamic get variant => _variant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_id'] = _clientId;
    map['rc_number'] = _rcNumber;
    map['registration_date'] = _registrationDate;
    map['owner_name'] = _ownerName;
    map['father_name'] = _fatherName;
    map['present_address'] = _presentAddress;
    map['permanent_address'] = _permanentAddress;
    map['mobile_number'] = _mobileNumber;
    map['vehicle_category'] = _vehicleCategory;
    map['vehicle_chasi_number'] = _vehicleChasiNumber;
    map['vehicle_engine_number'] = _vehicleEngineNumber;
    map['maker_description'] = _makerDescription;
    map['maker_model'] = _makerModel;
    map['body_type'] = _bodyType;
    map['fuel_type'] = _fuelType;
    map['color'] = _color;
    map['norms_type'] = _normsType;
    map['fit_up_to'] = _fitUpTo;
    map['financer'] = _financer;
    map['financed'] = _financed;
    map['insurance_company'] = _insuranceCompany;
    map['insurance_policy_number'] = _insurancePolicyNumber;
    map['insurance_upto'] = _insuranceUpto;
    map['manufacturing_date'] = _manufacturingDate;
    map['manufacturing_date_formatted'] = _manufacturingDateFormatted;
    map['registered_at'] = _registeredAt;
    map['latest_by'] = _latestBy;
    map['less_info'] = _lessInfo;
    map['tax_upto'] = _taxUpto;
    map['tax_paid_upto'] = _taxPaidUpto;
    map['cubic_capacity'] = _cubicCapacity;
    map['vehicle_gross_weight'] = _vehicleGrossWeight;
    map['no_cylinders'] = _noCylinders;
    map['seat_capacity'] = _seatCapacity;
    map['sleeper_capacity'] = _sleeperCapacity;
    map['standing_capacity'] = _standingCapacity;
    map['wheelbase'] = _wheelbase;
    map['unladen_weight'] = _unladenWeight;
    map['vehicle_category_description'] = _vehicleCategoryDescription;
    map['pucc_number'] = _puccNumber;
    map['pucc_upto'] = _puccUpto;
    map['permit_number'] = _permitNumber;
    map['permit_issue_date'] = _permitIssueDate;
    map['permit_valid_from'] = _permitValidFrom;
    map['permit_valid_upto'] = _permitValidUpto;
    map['permit_type'] = _permitType;
    map['national_permit_number'] = _nationalPermitNumber;
    map['national_permit_upto'] = _nationalPermitUpto;
    map['national_permit_issued_by'] = _nationalPermitIssuedBy;
    map['non_use_status'] = _nonUseStatus;
    map['non_use_from'] = _nonUseFrom;
    map['non_use_to'] = _nonUseTo;
    map['blacklist_status'] = _blacklistStatus;
    map['noc_details'] = _nocDetails;
    map['owner_number'] = _ownerNumber;
    map['rc_status'] = _rcStatus;
    map['masked_name'] = _maskedName;
    map['challan_details'] = _challanDetails;
    map['variant'] = _variant;
    return map;
  }

}