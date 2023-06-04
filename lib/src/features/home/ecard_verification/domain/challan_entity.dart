import 'dart:convert';

/// statuscode : 200
/// status : true
/// message : "Success!"
/// reference_id : 20230625
/// data : {"request_id":"20223341","vehicleId":"MH01XXXXXX","total":2,"challans":[{"challan_no":"MH11XXXXXXXXXXXXXXXX","date":"2022-03-10 06:24:49","rc_dl_no":"MH01XXXXXX","owner_name":"XXXXXX XXXXXX XXXXXX","accused_name":"XXXXXX XXXXXX XXXXXX","challan_status":"Cash","payment_source":"ON ROAD","amount":1000,"state":"MH","area":"THANDE"},{"challan_no":"MH11XXXXXXXXXXXXXX","date":"2022-03-07 02:23:59","rc_dl_no":"MH01XXXXXX","owner_name":"XXXXXX XXXXXX XXXXXX","accused_name":"XXXXXX XXXXXX XXXXXX","challan_status":"Pending","payment_source":null,"amount":1000,"state":"MH","area":"THANE"}]}

ChallanEntity challanEntityFromJson(String str) =>
    ChallanEntity.fromJson(json.decode(str));

String challanEntityToJson(ChallanEntity data) => json.encode(data.toJson());

class ChallanEntity {
  ChallanEntity({
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

  ChallanEntity.unknown() : _data = null;

  ChallanEntity.fromJson(dynamic json) {
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

  ChallanEntity copyWith({
    num? statuscode,
    bool? status,
    String? message,
    num? referenceId,
    Data? data,
  }) =>
      ChallanEntity(
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

/// request_id : "20223341"
/// vehicleId : "MH01XXXXXX"
/// total : 2
/// challans : [{"challan_no":"MH11XXXXXXXXXXXXXXXX","date":"2022-03-10 06:24:49","rc_dl_no":"MH01XXXXXX","owner_name":"XXXXXX XXXXXX XXXXXX","accused_name":"XXXXXX XXXXXX XXXXXX","challan_status":"Cash","payment_source":"ON ROAD","amount":1000,"state":"MH","area":"THANDE"},{"challan_no":"MH11XXXXXXXXXXXXXX","date":"2022-03-07 02:23:59","rc_dl_no":"MH01XXXXXX","owner_name":"XXXXXX XXXXXX XXXXXX","accused_name":"XXXXXX XXXXXX XXXXXX","challan_status":"Pending","payment_source":null,"amount":1000,"state":"MH","area":"THANE"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? requestId,
    String? vehicleId,
    num? total,
    List<Challans>? challans,
  }) {
    _requestId = requestId;
    _vehicleId = vehicleId;
    _total = total;
    _challans = challans;
  }

  Data.fromJson(dynamic json) {
    _requestId = json['request_id'];
    _vehicleId = json['vehicleId'];
    _total = json['total'];
    if (json['challans'] != null) {
      _challans = [];
      json['challans'].forEach((v) {
        _challans?.add(Challans.fromJson(v));
      });
    }
  }

  String? _requestId;
  String? _vehicleId;
  num? _total;
  List<Challans>? _challans;

  Data copyWith({
    String? requestId,
    String? vehicleId,
    num? total,
    List<Challans>? challans,
  }) =>
      Data(
        requestId: requestId ?? _requestId,
        vehicleId: vehicleId ?? _vehicleId,
        total: total ?? _total,
        challans: challans ?? _challans,
      );

  String? get requestId => _requestId;

  String? get vehicleId => _vehicleId;

  num? get total => _total;

  List<Challans>? get challans => _challans;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['request_id'] = _requestId;
    map['vehicleId'] = _vehicleId;
    map['total'] = _total;
    if (_challans != null) {
      map['challans'] = _challans?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// challan_no : "MH11XXXXXXXXXXXXXXXX"
/// date : "2022-03-10 06:24:49"
/// rc_dl_no : "MH01XXXXXX"
/// owner_name : "XXXXXX XXXXXX XXXXXX"
/// accused_name : "XXXXXX XXXXXX XXXXXX"
/// challan_status : "Cash"
/// payment_source : "ON ROAD"
/// amount : 1000
/// state : "MH"
/// area : "THANDE"

Challans challansFromJson(String str) => Challans.fromJson(json.decode(str));

String challansToJson(Challans data) => json.encode(data.toJson());

class Challans {
  Challans({
    String? challanNo,
    String? date,
    String? rcDlNo,
    String? ownerName,
    String? accusedName,
    String? challanStatus,
    String? paymentSource,
    num? amount,
    String? state,
    String? area,
  }) {
    _challanNo = challanNo;
    _date = date;
    _rcDlNo = rcDlNo;
    _ownerName = ownerName;
    _accusedName = accusedName;
    _challanStatus = challanStatus;
    _paymentSource = paymentSource;
    _amount = amount;
    _state = state;
    _area = area;
  }

  Challans.fromJson(dynamic json) {
    _challanNo = json['challan_no'];
    _date = json['date'];
    _rcDlNo = json['rc_dl_no'];
    _ownerName = json['owner_name'];
    _accusedName = json['accused_name'];
    _challanStatus = json['challan_status'];
    _paymentSource = json['payment_source'];
    _amount = json['amount'];
    _state = json['state'];
    _area = json['area'];
  }

  String? _challanNo;
  String? _date;
  String? _rcDlNo;
  String? _ownerName;
  String? _accusedName;
  String? _challanStatus;
  String? _paymentSource;
  num? _amount;
  String? _state;
  String? _area;

  Challans copyWith({
    String? challanNo,
    String? date,
    String? rcDlNo,
    String? ownerName,
    String? accusedName,
    String? challanStatus,
    String? paymentSource,
    num? amount,
    String? state,
    String? area,
  }) =>
      Challans(
        challanNo: challanNo ?? _challanNo,
        date: date ?? _date,
        rcDlNo: rcDlNo ?? _rcDlNo,
        ownerName: ownerName ?? _ownerName,
        accusedName: accusedName ?? _accusedName,
        challanStatus: challanStatus ?? _challanStatus,
        paymentSource: paymentSource ?? _paymentSource,
        amount: amount ?? _amount,
        state: state ?? _state,
        area: area ?? _area,
      );

  String? get challanNo => _challanNo;

  String? get date => _date;

  String? get rcDlNo => _rcDlNo;

  String? get ownerName => _ownerName;

  String? get accusedName => _accusedName;

  String? get challanStatus => _challanStatus;

  String? get paymentSource => _paymentSource;

  num? get amount => _amount;

  String? get state => _state;

  String? get area => _area;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['challan_no'] = _challanNo;
    map['date'] = _date;
    map['rc_dl_no'] = _rcDlNo;
    map['owner_name'] = _ownerName;
    map['accused_name'] = _accusedName;
    map['challan_status'] = _challanStatus;
    map['payment_source'] = _paymentSource;
    map['amount'] = _amount;
    map['state'] = _state;
    map['area'] = _area;
    return map;
  }
}
