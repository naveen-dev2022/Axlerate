import 'dart:convert';

class VehicleQueryParams {
  final int size;
  int pageIndex;
  final String? sortField;
  final String? sortType;
  String? searchText;
  final String? partnerOrgId;
  List<String>? fuelType;
  final List<String>? kycStatus;
  final List<String>? balanceType;
  final List<String>? tagStatus;
  List<String>? serviceType;

  VehicleQueryParams(
      {this.size = 15,
      this.pageIndex = 1,
      this.sortField,
      this.sortType,
      this.searchText,
      this.partnerOrgId,
      this.fuelType,
      this.kycStatus,
      this.balanceType,
      this.tagStatus,
      this.serviceType}) {
    // if (serviceType != null && serviceType![0] == "ALL") {
    //   serviceType = null;
    // }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {};
    // log('Inside Params');
    params.addAll({'size': size, 'pageIndex': pageIndex});
    sortField != null && sortField!.isNotEmpty ? params.addAll({'sortField': sortField}) : params;
    sortType != null && sortType!.isNotEmpty ? params.addAll({'sortType': sortType}) : params;
    searchText != null && searchText!.isNotEmpty ? params.addAll({'searchText': searchText}) : params;
    partnerOrgId != null && partnerOrgId!.isNotEmpty ? params.addAll({'partnerOrgId': partnerOrgId}) : params;
    fuelType != null && fuelType!.isNotEmpty ? params.addAll({'fuelType': jsonEncode(fuelType)}) : params;
    kycStatus != null && kycStatus!.isNotEmpty ? params.addAll({'kycStatus': jsonEncode(kycStatus)}) : params;
    balanceType != null && balanceType!.isNotEmpty ? params.addAll({'balanceType': jsonEncode(balanceType)}) : params;
    tagStatus != null && tagStatus!.isNotEmpty ? params.addAll({'tagStatus': jsonEncode(tagStatus)}) : params;
    serviceType != null && serviceType!.isNotEmpty ? params.addAll({'serviceType': jsonEncode(serviceType)}) : params;
    return params;
  }

  factory VehicleQueryParams.fromMap(Map<String, dynamic> map) {
    return VehicleQueryParams(
        size: map['size']?.toInt() ?? 0,
        pageIndex: map['pageIndex']?.toInt() ?? 0,
        sortField: map['sortField'],
        sortType: map['sortType'],
        searchText: map['searchText'],
        partnerOrgId: map['partnerOrgId'],
        fuelType: List<String>.from(map['fuelType']),
        kycStatus: List<String>.from(map['kycStatus']),
        balanceType: List<String>.from(map['balanceType']),
        tagStatus: List<String>.from(map['tagStatus']),
        serviceType: List<String>.from(map['serviceType']));
  }

  VehicleQueryParams copyWith(
      {int? size,
      int? pageIndex,
      String? sortField,
      String? sortType,
      String? searchText,
      String? partnerOrgId,
      List<String>? fuelType,
      List<String>? kycStatus,
      List<String>? balanceType,
      List<String>? tagStatus,
      List<String>? serviceType}) {
    return VehicleQueryParams(
        size: size ?? this.size,
        pageIndex: pageIndex ?? this.pageIndex,
        sortField: sortField ?? this.sortField,
        sortType: sortType ?? this.sortType,
        searchText: searchText ?? this.searchText,
        partnerOrgId: partnerOrgId ?? this.partnerOrgId,
        fuelType: fuelType ?? this.fuelType,
        kycStatus: kycStatus ?? this.kycStatus,
        balanceType: balanceType ?? this.balanceType,
        tagStatus: tagStatus ?? this.tagStatus,
        serviceType: serviceType ?? this.serviceType);
  }

  @override
  String toString() {
    return 'VehicleQueryParams(size: $size, pageIndex: $pageIndex, sortField: $sortField, sortType: $sortType, searchText: $searchText, partnerOrgId: $partnerOrgId, fuelType: $fuelType, kycStatus: $kycStatus, balanceType: $balanceType, tagStatus: $tagStatus)';
  }
}
