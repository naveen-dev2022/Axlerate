class PartnerDashCountInfoModel {
  Data? data;

  PartnerDashCountInfoModel({this.data});

  PartnerDashCountInfoModel.unknown() : data = null;

  PartnerDashCountInfoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Message? message;

  Data({this.message});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  int? logisticsOrg;
  int? vehicle;
  int? totalTag;
  int? users;
  int? totalPpi;
  int? gpsDeviceCount;

  Message({this.logisticsOrg, this.vehicle, this.totalTag, this.users, this.totalPpi, this.gpsDeviceCount});

  Message.fromJson(Map<String, dynamic> json) {
    logisticsOrg = json['logisticsOrg'];
    vehicle = json['vehicle'];
    totalTag = json['totalTag'];
    users = json['users'];
    totalPpi = json['totalPpi'];
    gpsDeviceCount = json['gpsDeviceCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logisticsOrg'] = logisticsOrg;
    data['vehicle'] = vehicle;
    data['totalTag'] = totalTag;
    data['users'] = users;
    data['totalPpi'] = totalPpi;
    data['gpsDeviceCount'] = gpsDeviceCount;
    return data;
  }
}
