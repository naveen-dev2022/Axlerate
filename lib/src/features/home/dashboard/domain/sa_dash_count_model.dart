class SaDashCount {
  Data? data;

  SaDashCount(this.data);

  SaDashCount.unknown() : data = null;

  SaDashCount.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaDashCount && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class Data {
  Message? message;

  Data(this.message);

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
  int? partners;
  int? customers;
  int? vehicles;
  int? staff;
  int? fastag;
  int? prepaidCards;
  int? gps;

  Message(
    this.partners,
    this.customers,
    this.vehicles,
    this.staff,
    this.fastag,
    this.prepaidCards,
    this.gps,
  );

  Message.fromJson(Map<String, dynamic> json) {
    partners = json["partners"];
    customers = json["customers"];
    vehicles = json["vehicles"];
    staff = json["staff"];
    fastag = json["fastag"];
    prepaidCards = json["prepaidCards"];
    gps = json["gps"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['partners'] = partners;
    data['customers'] = customers;
    data['vehicles'] = vehicles;
    data['staff'] = staff;
    data['fastag'] = fastag;
    data['prepaidCards'] = prepaidCards;
    data['gps'] = gps;

    return data;
  }
}
