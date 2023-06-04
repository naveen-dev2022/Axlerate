import 'dart:convert';

class SimpleVehicleListQueryParams {
  final int? size;
  int? pageIndex;
  final String? sortType;
  String? sortField;
  String? organizationEnrollmentId;
  List<String>? serviceType;
  List<String>? issuerName;

  SimpleVehicleListQueryParams({
    this.size,
    this.pageIndex,
    this.sortType,
    this.sortField,
    this.organizationEnrollmentId,
    this.serviceType,
    this.issuerName,
  });

  SimpleVehicleListQueryParams copyWith({
    int? size,
    int? pageIndex,
    String? sortType,
    String? sortField,
    String? organizationEnrollmentId,
    List<String>? serviceType,
    List<String>? issuerName,
  }) {
    return SimpleVehicleListQueryParams(
      size: size ?? this.size,
      pageIndex: pageIndex ?? this.pageIndex,
      sortType: sortType ?? this.sortType,
      sortField: sortField ?? this.sortField,
      organizationEnrollmentId: organizationEnrollmentId ?? this.organizationEnrollmentId,
      serviceType: serviceType ?? this.serviceType,
      issuerName: issuerName ?? this.issuerName,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {};

    size != null ? params.addAll({'size': size}) : params;
    pageIndex != null ? params.addAll({'pageIndex': pageIndex}) : params;
    sortType != null && sortType!.isNotEmpty ? params.addAll({'sortType': sortType}) : params;
    sortField != null && sortField!.isNotEmpty ? params.addAll({'sortField': sortField}) : params;
    organizationEnrollmentId != null && organizationEnrollmentId!.isNotEmpty
        ? params.addAll({'organizationEnrollmentId': organizationEnrollmentId})
        : params;
    serviceType != null && serviceType!.isNotEmpty ? params.addAll({'serviceType': jsonEncode(serviceType)}) : params;
    issuerName != null && issuerName!.isNotEmpty ? params.addAll({'issuerName': jsonEncode(issuerName)}) : params;
    return params;
  }

  @override
  String toString() {
    return 'SimpleVehicleListQueryParams(size: $size, pageIndex: $pageIndex)';
  }
}
