import 'package:axlerate/src/features/authentication/domain/user_decode_model.dart';

// To know whether the string is email or not
extension IsEmail on String {
  bool get isEmail => contains('@');
}

// To get list of Organisations from decoded json which return List<dynamic>
extension GetOrgs on List<dynamic> {
  List<UserDecodedOrganization> get getOrgsList =>
      List<UserDecodedOrganization>.from(map((x) => UserDecodedOrganization.fromJson(x))).toList();
}

// To Capitalize, Title case entensions
extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
  String get toValueCase => toUpperCase().replaceAll(' ', '_').replaceAll('.', '');
  String get toUiCase => replaceAll('_', ' ').toTitleCase();
  String get toUiTitleCase => replaceAll('-', ' ').toTitleCase();
  String get getTillDoc => split('?')[0];
}
