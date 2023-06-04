import 'dart:convert';

class PpiTxnQueryParams {
  final int? size;
  int? pageIndex;
  String? fromDate;
  String? toDate;
  final String? userId;
  final String? organizationId;
  final String? transactionType;
  final String? userEnrollmentId;
  String? organizationEnrollmentId;
  final String? accountInfoEntity;

  PpiTxnQueryParams({
    this.size,
    this.pageIndex,
    this.fromDate,
    this.toDate,
    this.userId,
    this.organizationId,
    this.transactionType,
    this.userEnrollmentId,
    this.organizationEnrollmentId,
    this.accountInfoEntity,
  });

  PpiTxnQueryParams copyWith({
    int? size,
    int? pageIndex,
    String? fromDate,
    String? toDate,
    String? userId,
    String? organizationId,
    String? transactionType,
    String? userEnrollmentId,
    String? organizationEnrollmentId,
    String? accountInfoEntity,
  }) {
    return PpiTxnQueryParams(
      size: size ?? this.size,
      pageIndex: pageIndex ?? this.pageIndex,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      userId: userId ?? this.userId,
      organizationId: organizationId ?? this.organizationId,
      transactionType: transactionType ?? this.transactionType,
      userEnrollmentId: userEnrollmentId ?? this.userEnrollmentId,
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
    userId != null && userId!.isNotEmpty ? params.addAll({'userId': userId}) : params;
    organizationId != null && organizationId!.isNotEmpty ? params.addAll({'organizationId': organizationId}) : params;
    transactionType != null && transactionType!.isNotEmpty
        ? params.addAll({'transactionType': transactionType})
        : params;
    userEnrollmentId != null && userEnrollmentId!.isNotEmpty
        ? params.addAll({'userEnrollmentId': userEnrollmentId})
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

  factory PpiTxnQueryParams.fromMap(Map<String, dynamic> map) {
    return PpiTxnQueryParams(
      size: map['size']?.toInt(),
      pageIndex: map['pageIndex']?.toInt(),
      fromDate: map['fromDate'],
      toDate: map['toDate'],
      userId: map['userId'],
      organizationId: map['organizationId'],
      transactionType: map['transactionType'],
      userEnrollmentId: map['userEnrollmentId'],
      organizationEnrollmentId: map['organizationEnrollmentId'],
      accountInfoEntity: map['accountInfoEntity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PpiTxnQueryParams.fromJson(Map<String, dynamic> source) => PpiTxnQueryParams.fromMap(source);

  @override
  String toString() {
    return 'PpiTxnQueryParams(size: $size, pageIndex: $pageIndex, fromDate: $fromDate, toDate: $toDate, userId: $userId, organizationId: $organizationId, transactionType: $transactionType, userEnrollmentId: $userEnrollmentId, organizationEnrollmentId: $organizationEnrollmentId, accountInfoEntity: $accountInfoEntity)';
  }
}
