import 'dart:convert';

class TagTxnQueryParams {
  final int? size;
  int? pageIndex;
  String? fromDate;
  String? toDate;
  String? fileType;
  final String? filterField;
  final String? filterText;
  final bool? wallet;
  final bool? toll;
  List<String>? type;
  List<String>? transactionType;
  List<String>? natureOfTransaction;
  List<String>? transactionStatus;
  List<String>? selectedUser;
  List<String>? organizationEnrollmentId;
  List<String>? vehicleRegistrationNumber;

  TagTxnQueryParams({
    this.size,
    this.pageIndex,
    this.fromDate,
    this.toDate,
    this.filterField,
    this.filterText,
    this.wallet,
    this.toll,
    this.type,
    this.transactionType,
    this.natureOfTransaction,
    this.transactionStatus,
    this.selectedUser,
    this.organizationEnrollmentId,
    this.vehicleRegistrationNumber,
    this.fileType,
  });

  TagTxnQueryParams copyWith({
    List<String>? serviceType,
    int? size,
    int? pageIndex,
    String? fromDate,
    String? toDate,
    String? filterField,
    String? filterText,
    String? fileType,
    bool? wallet,
    bool? toll,
    List<String>? type,
    List<String>? transactionType,
    List<String>? natureOfTransaction,
    List<String>? transactionStatus,
    List<String>? selectedUser,
    List<String>? organizationEnrollmentId,
    List<String>? vehicleRegistrationNumber,
  }) {
    return TagTxnQueryParams(
      size: size ?? this.size,
      pageIndex: pageIndex ?? this.pageIndex,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      filterField: filterField ?? this.filterField,
      filterText: filterText ?? this.filterText,
      wallet: wallet ?? this.wallet,
      toll: toll ?? this.toll,
      type: type ?? this.type,
      transactionType: transactionType ?? this.transactionType,
      natureOfTransaction: natureOfTransaction ?? this.natureOfTransaction,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      selectedUser: selectedUser ?? this.selectedUser,
      organizationEnrollmentId: organizationEnrollmentId ?? this.organizationEnrollmentId,
      vehicleRegistrationNumber: vehicleRegistrationNumber ?? this.vehicleRegistrationNumber,
      fileType: fileType ?? this.fileType,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {};

    size != null ? params.addAll({'size': size}) : params;
    pageIndex != null ? params.addAll({'pageIndex': pageIndex}) : params;
    fromDate != null && fromDate!.isNotEmpty ? params.addAll({'fromDate': fromDate}) : params;
    toDate != null && toDate!.isNotEmpty ? params.addAll({'toDate': toDate}) : params;
    filterField != null && filterField!.isNotEmpty ? params.addAll({'filterField': filterField}) : params;
    filterText != null && filterText!.isNotEmpty ? params.addAll({'filterText': filterText}) : params;
    wallet != null ? params.addAll({'wallet': wallet}) : params;
    toll != null ? params.addAll({'toll': toll}) : params;
    type != null && type!.isNotEmpty ? params.addAll({'type': jsonEncode(type)}) : params;
    transactionType != null && transactionType!.isNotEmpty
        ? params.addAll({'transactionType': jsonEncode(transactionType)})
        : params;
    natureOfTransaction != null && natureOfTransaction!.isNotEmpty
        ? params.addAll({'natureOfTransaction': jsonEncode(natureOfTransaction)})
        : params;
    transactionStatus != null && transactionStatus!.isNotEmpty
        ? params.addAll({'transactionStatus': jsonEncode(transactionStatus)})
        : params;
    selectedUser != null && selectedUser!.isNotEmpty
        ? params.addAll({'userEnrollmentId': jsonEncode(selectedUser)})
        : params;
    vehicleRegistrationNumber != null && vehicleRegistrationNumber!.isNotEmpty
        ? params.addAll({'vehicleRegistrationNumber': jsonEncode(vehicleRegistrationNumber)})
        : params;
    organizationEnrollmentId != null && organizationEnrollmentId!.isNotEmpty
        ? params.addAll({'organizationEnrollmentId': jsonEncode(organizationEnrollmentId)})
        : params;
    fileType != null && fileType!.isNotEmpty ? params.addAll({'fileType': fileType}) : params;

    return params;
  }

  @override
  String toString() {
    return 'TagTxnQueryParams(size: $size, pageIndex: $pageIndex, sortField: $filterField, type: $type, transactionType: $transactionType, natureOfTransaction: $natureOfTransaction,transactionStatus:$transactionStatus)';
  }
}
