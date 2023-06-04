import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/src/local_storage/local_storage.dart';
import 'package:axlerate/src/local_storage/storage.dart';

class SelectedOrganizationModel {
  String name;
  String type;
  String enrollmentId;
  String status;
  String? logoUrl;

  SelectedOrganizationModel(
      {required this.name, required this.enrollmentId, required this.type, required this.status, this.logoUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'enrollmentId': enrollmentId,
      'logoUrl': logoUrl,
    };
  }

  factory SelectedOrganizationModel.fromMap(Map<String, dynamic> map) {
    return SelectedOrganizationModel(
      name: map['name'] != null ? map['name'] as String : '',
      type: map['type'] != null ? map['type'] as String : '',
      status: map['status'] != null ? map['status'] as String : '',
      enrollmentId: map['enrollmentId'] != null ? map['enrollmentId'] as String : '',
      logoUrl: map['logoUrl'] != null ? map['logoUrl'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectedOrganizationModel.fromJson(String source) =>
      SelectedOrganizationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SelectedOrganizationModel(name: $name, type: $type, enrollmentId: $enrollmentId, logoUrl: $logoUrl)';
  }

  @override
  bool operator ==(covariant SelectedOrganizationModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.type == type && other.enrollmentId == enrollmentId && other.logoUrl == logoUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^ type.hashCode ^ enrollmentId.hashCode ^ logoUrl.hashCode;
  }
}

final selectedOrganizationStateProvider = StateProvider<SelectedOrganizationModel>(
  (ref) {
    dynamic data = ref.read(sharedPreferenceProvider).getString(Storage.selectedOrgData);
    // SelectedOrganizationModel stored = data.fromStorage;
    try {
      // log('The DAta value is -> $data');
      if (data == null) {
        return SelectedOrganizationModel(name: "Choose an Organization", enrollmentId: "", type: "", status: "");
      }
      SelectedOrganizationModel stored = SelectedOrganizationModel.fromJson(jsonDecode(data));
      return SelectedOrganizationModel(
          name: stored.name,
          status: stored.status,
          enrollmentId: stored.enrollmentId,
          type: stored.type,
          logoUrl: stored.logoUrl);
    } catch (e) {
      // debugPrint('The Select Org Error is ---. $e ');
      return SelectedOrganizationModel(name: "Choose an Organization", enrollmentId: "", type: "", status: "");
    }
  },
);
