class VehicleTripHistoryModel {
  Data? data;

  VehicleTripHistoryModel({this.data});

  VehicleTripHistoryModel.unknown() : data = null;

  VehicleTripHistoryModel.fromJson(Map<String, dynamic> json) {
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
  Result? result;
  List<History>? history;

  Message({this.result, this.history});

  Message.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? code;
  String? msg;

  Result({this.code, this.msg});

  Result.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    return data;
  }
}

class History {
  String? tripTime;
  String? fromLatitude;
  String? fromLongitude;
  String? fromTime;
  String? toTime;
  String? toLatitde;
  String? toLongitude;
  String? kilometer;

  History(
      {this.tripTime,
      this.fromLatitude,
      this.fromLongitude,
      this.fromTime,
      this.toTime,
      this.toLatitde,
      this.toLongitude,
      this.kilometer});

  History.fromJson(Map<String, dynamic> json) {
    tripTime = json['tripTime'];
    fromLatitude = json['fromLatitude'];
    fromLongitude = json['fromLongitude'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    toLatitde = json['toLatitde'];
    toLongitude = json['toLongitude'];
    kilometer = json['kilometer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tripTime'] = tripTime;
    data['fromLatitude'] = fromLatitude;
    data['fromLongitude'] = fromLongitude;
    data['fromTime'] = fromTime;
    data['toTime'] = toTime;
    data['toLatitde'] = toLatitde;
    data['toLongitude'] = toLongitude;
    data['kilometer'] = kilometer;
    return data;
  }
}
