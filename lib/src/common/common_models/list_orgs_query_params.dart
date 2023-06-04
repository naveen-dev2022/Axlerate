import 'dart:convert';

// abstract class CommonQueryParams<T> {
//   T fromMap(Map<String, dynamic> map);
//   String? searchText;
//   String? serviceType;
// }

//  extends CommonQueryParams<ListOrgsQueryParams>
class ListOrgsQueryParams {
  int? size;
  int? pageIndex;
  String? sortField;
  String? sortType;
  // @override
  String? searchText;
  List<String>? natureOfBusiness;
  List<String>? status;
  String organizationType;
  String? partnerOrgId;
  List<String>? state;
  // @override
  List<String>? serviceType;

  ListOrgsQueryParams.allOrgs() : organizationType = 'LOGISTICS';

  ListOrgsQueryParams({
    this.size = 15,
    this.pageIndex = 1,
    this.sortField,
    this.sortType,
    this.searchText,
    this.natureOfBusiness,
    this.status,
    required this.organizationType,
    this.partnerOrgId,
    this.state,
    this.serviceType,
  });

  ListOrgsQueryParams copyWith({
    int? size,
    int? pageIndex,
    String? sortField,
    String? sortType,
    String? searchText,
    List<String>? status,
    List<String>? natureOfBusiness,
    String? organizationType,
    String? partnerOrgId,
    List<String>? state,
    List<String>? serviceType,
  }) {
    return ListOrgsQueryParams(
      size: size ?? this.size,
      pageIndex: pageIndex ?? this.pageIndex,
      sortField: sortField ?? this.sortField,
      sortType: sortType ?? this.sortType,
      searchText: searchText ?? this.searchText,
      status: status ?? this.status,
      natureOfBusiness: natureOfBusiness ?? this.natureOfBusiness,
      organizationType: organizationType ?? this.organizationType,
      partnerOrgId: partnerOrgId ?? this.partnerOrgId,
      state: state ?? this.state,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  ListOrgsQueryParams copyFrom(ListOrgsQueryParams params) {
    return ListOrgsQueryParams(
      size: params.size ?? size,
      pageIndex: params.pageIndex ?? pageIndex,
      sortField: params.sortField ?? sortField,
      sortType: params.sortType ?? sortType,
      searchText: params.searchText ?? searchText,
      status: params.status ?? status,
      natureOfBusiness: params.natureOfBusiness ?? natureOfBusiness,
      organizationType: params.organizationType,
      partnerOrgId: params.partnerOrgId ?? partnerOrgId,
      state: params.state ?? state,
      serviceType: params.serviceType ?? serviceType,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {};
    size != null ? params.addAll({'size': size}) : params;
    params.addAll({'organizationType': organizationType});
    pageIndex != null ? params.addAll({'pageIndex': pageIndex}) : params;

    sortField != null ? params.addAll({'sortField': sortField}) : params;
    sortType != null ? params.addAll({'sortType': sortType}) : params;
    searchText != null && searchText!.isNotEmpty ? params.addAll({'searchText': searchText}) : params;
    natureOfBusiness != null && natureOfBusiness!.isNotEmpty
        ? params.addAll({'natureOfBusiness': jsonEncode(natureOfBusiness)})
        : params;
    status != null && status!.isNotEmpty ? params.addAll({'status': jsonEncode(status)}) : params;
    partnerOrgId != null && partnerOrgId!.isNotEmpty ? params.addAll({'partnerOrgId': partnerOrgId}) : params;
    state != null && state!.isNotEmpty ? params.addAll({'state': jsonEncode(state)}) : params;
    serviceType != null && serviceType!.isNotEmpty ? params.addAll({'serviceType': jsonEncode(serviceType)}) : params;
    return params;
  }

  factory ListOrgsQueryParams.fromMap(Map<String, dynamic> map) {
    return ListOrgsQueryParams(
      size: map['size']?.toInt() ?? 0,
      pageIndex: map['pageIndex']?.toInt() ?? 0,
      sortField: map['sortField'],
      sortType: map['sortType'],
      searchText: map['searchText'],
      natureOfBusiness: map['natureOfBusiness'],
      organizationType: map['organisationType'] ?? '',
      partnerOrgId: map['partnerOrgId'],
      serviceType: map['serviceType'],
    );
  }

  // String toJson() => json.encode(toMap());

  factory ListOrgsQueryParams.fromJson(String source) => ListOrgsQueryParams.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListOrgsQueryParams(size: $size, pageIndex: $pageIndex, sortField: $sortField, sortType: $sortType, searchText: $searchText, natureOfBusiness: $natureOfBusiness, organisationType: $organizationType, partnerOrgId: $partnerOrgId, serviceType: $serviceType,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListOrgsQueryParams &&
        other.size == size &&
        other.pageIndex == pageIndex &&
        other.sortField == sortField &&
        other.sortType == sortType &&
        other.searchText == searchText &&
        other.natureOfBusiness == natureOfBusiness &&
        other.organizationType == organizationType &&
        other.partnerOrgId == partnerOrgId &&
        other.serviceType == serviceType;
  }

  @override
  int get hashCode {
    return size.hashCode ^
        pageIndex.hashCode ^
        sortField.hashCode ^
        sortType.hashCode ^
        searchText.hashCode ^
        natureOfBusiness.hashCode ^
        organizationType.hashCode ^
        partnerOrgId.hashCode ^
        serviceType.hashCode;
  }
}
