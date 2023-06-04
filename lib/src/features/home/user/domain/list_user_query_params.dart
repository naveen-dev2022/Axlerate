import 'dart:convert';

import 'package:flutter/foundation.dart';

class ListUserQueryParams {
  int size;
  int? pageIndex;
  final String? sortField;
  final String? sortType;
  String? searchText;
  List<String>? userRole;
  final List<String>? userStatus;
  final String? organizationType;
  final String? partnerOrgId;
  final List<String>? ppiCardStatus;
  List<String>? serviceType;

  ListUserQueryParams(
      {this.size = 15,
      this.pageIndex,
      this.sortField,
      this.sortType,
      this.searchText,
      this.userRole,
      this.userStatus,
      this.organizationType,
      this.partnerOrgId,
      this.ppiCardStatus,
      this.serviceType});

  ListUserQueryParams copyWith(
      {int? size,
      int? pageIndex,
      String? sortField,
      String? sortType,
      String? searchText,
      List<String>? userRole,
      List<String>? userStatus,
      String? organizationType,
      String? partnerOrgId,
      List<String>? ppiCardStatus,
      List<String>? serviceType}) {
    debugPrint(serviceType.toString());
    return ListUserQueryParams(
        size: size ?? this.size,
        pageIndex: pageIndex ?? this.pageIndex,
        sortField: sortField ?? this.sortField,
        sortType: sortType ?? this.sortType,
        searchText: searchText ?? this.searchText,
        userRole: userRole ?? this.userRole,
        userStatus: userStatus ?? this.userStatus,
        organizationType: organizationType ?? this.organizationType,
        partnerOrgId: partnerOrgId ?? this.partnerOrgId,
        ppiCardStatus: ppiCardStatus ?? this.ppiCardStatus,
        serviceType: (serviceType != null && serviceType.isNotEmpty) ? serviceType : this.serviceType);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {};

    params.addAll({'size': size});
    pageIndex != null ? params.addAll({'pageIndex': pageIndex}) : params;
    sortField != null ? params.addAll({'sortField': sortField}) : params;
    sortType != null ? params.addAll({'sortType': sortType}) : params;
    searchText != null && searchText!.isNotEmpty ? params.addAll({'searchText': searchText}) : params;
    userRole != null && userRole!.isNotEmpty ? params.addAll({'userRole': jsonEncode(userRole)}) : params;
    userStatus != null && userStatus!.isNotEmpty ? params.addAll({'userStatus': jsonEncode(userStatus)}) : params;
    organizationType != null ? params.addAll({'organizationType': organizationType}) : params;
    partnerOrgId != null ? params.addAll({'partnerOrgId': partnerOrgId}) : params;
    ppiCardStatus != null && ppiCardStatus!.isNotEmpty
        ? params.addAll({'ppiCardStatus': jsonEncode(ppiCardStatus)})
        : params;
    serviceType != null && serviceType!.isNotEmpty ? params.addAll({'serviceType': jsonEncode(serviceType)}) : params;
    return params;
  }

  factory ListUserQueryParams.fromMap(Map<String, dynamic> map) {
    return ListUserQueryParams(
        size: map['size']?.toInt() ?? 0,
        pageIndex: map['pageIndex']?.toInt(),
        sortField: map['sortField'],
        sortType: map['sortType'],
        searchText: map['searchText'],
        userRole: List<String>.from(map['userRole']),
        userStatus: List<String>.from(map['userStatus']),
        organizationType: map['organizationType'],
        partnerOrgId: map['partnerOrgId'],
        ppiCardStatus: List<String>.from(map['ppiCardStatus']),
        serviceType: List<String>.from(map['serviceType']));
  }

  factory ListUserQueryParams.fromJson(String source) => ListUserQueryParams.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListUserQueryParams(size: $size, pageIndex: $pageIndex, sortField: $sortField, sortType: $sortType, searchText: $searchText, userRole: $userRole, userStatus: $userStatus, organizationType: $organizationType, partnerOrgId: $partnerOrgId, ppiCardStatus: $ppiCardStatus)';
  }
}
