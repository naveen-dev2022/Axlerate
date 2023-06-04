import 'dart:convert';

class VehicleTollQueryParams {
  String? fromDate;
  String? toDate;
  String? fileType;
  String? organizationEnrollmentId;

  VehicleTollQueryParams({
    this.fromDate,
    this.toDate,
    this.organizationEnrollmentId,
    this.fileType,
  });

  VehicleTollQueryParams copyWith({
    String? fromDate,
    String? toDate,
    String? fileType,
    String? organizationEnrollmentId,
  }) {
    return VehicleTollQueryParams(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      organizationEnrollmentId: organizationEnrollmentId ?? this.organizationEnrollmentId,
      fileType: fileType ?? this.fileType,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {};
    fromDate != null && fromDate!.isNotEmpty ? params.addAll({'fromDate': fromDate}) : params;
    toDate != null && toDate!.isNotEmpty ? params.addAll({'toDate': toDate}) : params;
    organizationEnrollmentId != null && organizationEnrollmentId!.isNotEmpty
        ? params.addAll({'organizationEnrollmentId': jsonEncode(organizationEnrollmentId)})
        : params;
    fileType != null && fileType!.isNotEmpty ? params.addAll({'fileType': fileType}) : params;

    return params;
  }
}
