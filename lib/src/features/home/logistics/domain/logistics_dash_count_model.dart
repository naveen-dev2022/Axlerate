class OrgDashCountModel {
  Data? data;

  OrgDashCountModel(this.data);

  OrgDashCountModel.unknown() : data = null;

  OrgDashCountModel.fromJson(Map<String, dynamic> json) {
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

    return other is OrgDashCountModel && other.data == data;
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
  int? vehicle;
  int? vehicleLevelBalance;
  int? customerLevelBalance;
  int? totalTag;
  int? activeTag;
  int? blackListTag;
  int? lowBalanceTag;
  int? exemptionTag;
  int? nonExemptionTag;
  int? adminUsers;
  int? staffUsers;
  int? totalPpi;
  int? activePpi;
  int? lockedPpi;
  int? blockedPpi;
  int? closedPpi;
  int? gpsDeviceCount;
  int? totalPaymentLink;
  int? duePaymentLink;
  int? paidPaymentLink;
  int? droppedPaymentLink;
  int? totalPaidAmount;
  int? totalDueAmount;

  Message(
    this.vehicle,
    this.vehicleLevelBalance,
    this.customerLevelBalance,
    this.totalTag,
    this.activeTag,
    this.blackListTag,
    this.lowBalanceTag,
    this.exemptionTag,
    this.nonExemptionTag,
    this.adminUsers,
    this.staffUsers,
    this.totalPpi,
    this.activePpi,
    this.lockedPpi,
    this.blockedPpi,
    this.closedPpi,
    this.gpsDeviceCount,
    this.totalPaymentLink,
    this.duePaymentLink,
    this.paidPaymentLink,
    this.droppedPaymentLink,
    this.totalDueAmount,
    this.totalPaidAmount,
  );

  Message.fromJson(Map<String, dynamic> json) {
    vehicle = json['vehicle'];
    vehicleLevelBalance = json['vehicleLevelBalance'];
    customerLevelBalance = json['customerLevelBalance'];
    totalTag = json['totalTag'];
    activeTag = json['activeTag'];
    blackListTag = json['blackListTag'];
    lowBalanceTag = json['lowBalanceTag'];
    exemptionTag = json['exemptionTag'];
    nonExemptionTag = json['nonExemptionTag'];
    adminUsers = json['adminUsers'];
    staffUsers = json['staffUsers'];
    totalPpi = json['totalPpi'];
    activePpi = json['activePpi'];
    lockedPpi = json['lockedPpi'];
    blockedPpi = json['blockedPpi'];
    closedPpi = json['closedPpi'];
    gpsDeviceCount = json['gpsDeviceCount'];
    totalPaymentLink = json['totalPaymentLink'];
    duePaymentLink = json['duePaymentLink'];
    paidPaymentLink = json['paidPaymentLink'];
    droppedPaymentLink = json['droppedPaymentLink'];
    totalDueAmount = json['totalDueAmount'];
    totalPaidAmount = json['totalPaidAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicle'] = vehicle;
    data['vehicleLevelBalance'] = vehicleLevelBalance;
    data['customerLevelBalance'] = customerLevelBalance;
    data['totalTag'] = totalTag;
    data['activeTag'] = activeTag;
    data['blackListTag'] = blackListTag;
    data['lowBalanceTag'] = lowBalanceTag;
    data['exemptionTag'] = exemptionTag;
    data['nonExemptionTag'] = nonExemptionTag;
    data['adminUsers'] = adminUsers;
    data['staffUsers'] = staffUsers;
    data['totalPpi'] = totalPpi;
    data['activePpi'] = activePpi;
    data['lockedPpi'] = lockedPpi;
    data['blockedPpi'] = blockedPpi;
    data['closedPpi'] = closedPpi;
    data['gpsDeviceCount'] = gpsDeviceCount;
    data['totalPaymentLink'] = totalPaymentLink;
    data['duePaymentLink'] = duePaymentLink;
    data['paidPaymentLink'] = paidPaymentLink;
    data['droppedPaymentLink'] = droppedPaymentLink;
    data['totalDueAmount'] = totalDueAmount;
    data['totalPaidAmount'] = totalPaidAmount;
    return data;
  }
}
