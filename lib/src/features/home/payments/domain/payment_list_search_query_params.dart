class PaymentListQueryParams {
  final int size;
  final int pageIndex;
  final String? sortField;
  final String? sortType;
  final String? searchText;
  final String? status;
  final String? organizationEnrollmentId;

  PaymentListQueryParams({
    this.size = 15,
    this.pageIndex = 1,
    this.sortField,
    this.sortType,
    this.searchText,
    this.status,
    this.organizationEnrollmentId,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {};
    // log('Inside Params');
    params.addAll({'size': size, 'pageIndex': pageIndex});
    sortField != null && sortField!.isNotEmpty ? params.addAll({'sortField': sortField}) : params;
    sortType != null && sortType!.isNotEmpty ? params.addAll({'sortType': sortType}) : params;
    searchText != null && searchText!.isNotEmpty ? params.addAll({'searchText': searchText}) : params;
    status != null && status!.isNotEmpty ? params.addAll({'status': status}) : params;
    organizationEnrollmentId != null && organizationEnrollmentId!.isNotEmpty
        ? params.addAll({'organizationEnrollmentId': organizationEnrollmentId})
        : params;

    return params;
  }

  factory PaymentListQueryParams.fromMap(Map<String, dynamic> map) {
    return PaymentListQueryParams(
      size: map['size']?.toInt() ?? 0,
      pageIndex: map['pageIndex']?.toInt() ?? 0,
      sortField: map['sortField'],
      sortType: map['sortType'],
      searchText: map['searchText'],
      status: map['status'],
      organizationEnrollmentId: map['organizationEnrollmentId'],
    );
  }

  PaymentListQueryParams copyWith({
    int? size,
    int? pageIndex,
    String? sortField,
    String? sortType,
    String? searchText,
    String? status,
    String? organizationEnrollmentId,
    String? partnerOrgId,
    List<String>? fuelType,
    List<String>? kycStatus,
    List<String>? balanceType,
    List<String>? tagStatus,
  }) {
    return PaymentListQueryParams(
      size: size ?? this.size,
      pageIndex: pageIndex ?? this.pageIndex,
      sortField: sortField ?? this.sortField,
      sortType: sortType ?? this.sortType,
      searchText: searchText ?? this.searchText,
      status: status ?? this.status,
      organizationEnrollmentId: organizationEnrollmentId ?? this.organizationEnrollmentId,
    );
  }

  @override
  String toString() {
    return 'PaymentListQueryParams(size: $size, pageIndex: $pageIndex, sortField: $sortField, sortType: $sortType, searchText: $searchText)';
  }
}
