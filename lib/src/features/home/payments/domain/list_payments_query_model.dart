class ListPaymentsQueryModel {
  final String? orderId;
  final int? size;
  final int? pageIndex;
  final String? organizationEnrollmentId;
  final String? status;

  ListPaymentsQueryModel({
    this.orderId,
    this.size,
    this.pageIndex,
    this.organizationEnrollmentId,
    this.status,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {};

    orderId != null && orderId!.isNotEmpty ? params.addAll({'orderId': orderId}) : params;
    size != null ? params.addAll({'size': size}) : params;
    pageIndex != null ? params.addAll({'pageIndex': pageIndex}) : params;
    organizationEnrollmentId != null && organizationEnrollmentId!.isNotEmpty
        ? params.addAll({'organizationEnrollmentId': organizationEnrollmentId})
        : params;
    status != null && status!.isNotEmpty ? params.addAll({'status': status}) : params;

    return params;
  }
}
