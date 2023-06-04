import 'dart:convert';

class FuelTxnQueryParams {
  final int? size;
  int? pageIndex;
  String? fromDate;
  String? toDate;
  final String? organizationId;
  final String? vehicleId;
  final String? transactionType;
  final String? vehicleEnrollmentId;
  String? organizationEnrollmentId;
  final String? accountInfoEntity;

  FuelTxnQueryParams({
    this.size,
    this.pageIndex,
    this.fromDate,
    this.toDate,
    this.organizationId,
    this.vehicleId,
    this.transactionType,
    this.vehicleEnrollmentId,
    this.organizationEnrollmentId,
    this.accountInfoEntity,
  });

  FuelTxnQueryParams copyWith({
    int? size,
    int? pageIndex,
    String? fromDate,
    String? toDate,
    String? organizationId,
    String? vehicleId,
    String? transactionType,
    String? vehicleEnrollmentId,
    String? organizationEnrollmentId,
    String? accountInfoEntity,
  }) {
    return FuelTxnQueryParams(
      size: size ?? this.size,
      pageIndex: pageIndex ?? this.pageIndex,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      organizationId: organizationId ?? this.organizationId,
      vehicleId: vehicleId ?? this.vehicleId,
      transactionType: transactionType ?? this.transactionType,
      vehicleEnrollmentId: vehicleEnrollmentId ?? this.vehicleEnrollmentId,
      organizationEnrollmentId: organizationEnrollmentId ?? this.organizationEnrollmentId,
      accountInfoEntity: accountInfoEntity ?? this.accountInfoEntity,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {};
    size != null ? params.addAll({'size': size}) : params;
    pageIndex != null ? params.addAll({'pageIndex': pageIndex}) : params;
    fromDate != null && fromDate!.isNotEmpty ? params.addAll({'fromDate': fromDate}) : params;
    toDate != null && toDate!.isNotEmpty ? params.addAll({'toDate': toDate}) : params;
    organizationId != null && organizationId!.isNotEmpty ? params.addAll({'organizationId': organizationId}) : params;
    transactionType != null && transactionType!.isNotEmpty
        ? params.addAll({'transactionType': transactionType})
        : params;
    vehicleEnrollmentId != null && vehicleEnrollmentId!.isNotEmpty
        ? params.addAll({'vehicleEnrollmentId': vehicleEnrollmentId})
        : params;
    organizationEnrollmentId != null && organizationEnrollmentId!.isNotEmpty
        ? params.addAll({'organizationEnrollmentId': organizationEnrollmentId})
        : params;
    accountInfoEntity != null && accountInfoEntity!.isNotEmpty
        ? params.addAll({'accountInfoEntity': accountInfoEntity})
        : params;

    return params;

    // return {
    //   'pageIndex': pageIndex,
    //   'fromDate': fromDate,
    //   'toDate': toDate,
    //   'userId': userId,
    //   'organizationId': organizationId,
    //   'transactionType': transactionType,
    //   'userEnrollmentId': userEnrollmentId,
    //   'organizationEnrollmentId': organizationEnrollmentId,
    //   'accountInfoEntity': accountInfoEntity,
    // };
  }

  factory FuelTxnQueryParams.fromMap(Map<String, dynamic> map) {
    return FuelTxnQueryParams(
      size: map['size']?.toInt(),
      pageIndex: map['pageIndex']?.toInt(),
      fromDate: map['fromDate'],
      toDate: map['toDate'],
      organizationId: map['organizationId'],
      transactionType: map['transactionType'],
      vehicleEnrollmentId: map['vehicleEnrollmentId'],
      organizationEnrollmentId: map['organizationEnrollmentId'],
      accountInfoEntity: map['accountInfoEntity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FuelTxnQueryParams.fromJson(Map<String, dynamic> source) => FuelTxnQueryParams.fromMap(source);

  @override
  String toString() {
    return 'PpiTxnQueryParams(size: $size, pageIndex: $pageIndex, fromDate: $fromDate, toDate: $toDate, organizationId: $organizationId, transactionType: $transactionType, vehicleEnrollmentId: $vehicleEnrollmentId, organizationEnrollmentId: $organizationEnrollmentId, accountInfoEntity: $accountInfoEntity)';
  }
}
