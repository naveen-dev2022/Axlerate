import 'package:axlerate/app_util/enums/org_type.dart';

class OrgTypeUtil {
  static getOrgTypeString(OrgType type) {
    switch (type) {
      case OrgType.axlerate:
        return 'AXLERATE';
      case OrgType.partner:
        return 'PARTNER';
      case OrgType.logisticsAdmin:
        return 'LOGISTICS';
      default:
        return 'AXLERATE';
    }
  }
}
