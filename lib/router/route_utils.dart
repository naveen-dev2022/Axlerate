import 'package:axlerate/main.dart';
import 'package:axlerate/router/axle_route_path.dart';
import 'package:axlerate/src/local_storage/storage.dart';

enum AppPage {
  splash,
  login,
  home,
  error,
  onBoarding,
  forgotPassword,
  resetPassword,
  changePassword,
  accountActivation,
  userProfile,
  vehicles,
  transactions,
}

class AppRoute {
  String path;
  String title;
  bool isAuthorised;

  AppRoute(this.path, this.title, this.isAuthorised);

  static bool isAuthorisedRoute(path) {
    AppRoute route = appRoutes.firstWhere((route) => route.path == path, orElse: () => errorRoute);
    return route.isAuthorised;
  }

  static AppRoute getRoute(path) {
    return appRoutes.firstWhere((route) => route.path == path, orElse: () => errorRoute);
  }
}

final AppRoute errorRoute = AppRoute('/error', "Error", false);

final List<AppRoute> appRoutes = [
  AppRoute('/', "Dashboard", true),
  AppRoute('/profile', "Profile", true),
  AppRoute('/auth/login', "Login", false),
  AppRoute('/splash', "Splash", false),
  AppRoute('/start', "Welcome", false),
  AppRoute('/transactions', "Transactions", true),
  AppRoute('/add-vehicles', "Add Vehicles", true),
  AppRoute('/vehicles', "Vehicles", true),
  AppRoute('/auth/forgot-password', "Forgot Password", false),
  AppRoute('/auth/reset-password', "Reset Password", false),
  AppRoute('/auth/change-password', "Change Password", true),
  AppRoute('/auth/account-activation', "Activate Account", false),
  AppRoute('/create-customer', "Create New Customer", false),
  errorRoute
];

class RouteUtils {
  static String getSelectOrganizationPath() {
    return '/app/select-org';
  }

  static String getDashboardPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    // log("orgId in PATH :: $orgId");

    String orgType = sharedPreferences.getString(Storage.currentlyPickedOrgType) ?? '';

    String orgEnrolId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? '';
    if (orgType.contains("LOGISTICS")) {
      return '/app/$orgEnrolId/customers/$orgEnrolId'.toLowerCase();
    }
    if (orgType.contains("PARTNER")) {
      return '/app/$orgEnrolId/partners/$orgEnrolId'.toLowerCase();
    }

    if (orgType.contains("dummy")) {
      return getStaticDashbaordPath();
    }

    return '/app/${orgId.toLowerCase()}/dashboard'.toLowerCase();
  }

  static String getStaticDashbaordPath() {
    return '/app/${AxleRoutePath.staticDash}';
  }

  static String getErrorDashbaord() {
    return '/${AxleRoutePath.errorDash}';
  }

  static String getVehiclesPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/vehicles';
  }

  static String getTransactionsPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/transactions';
  }

  static String getGpsPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/gps';
  }

  static String getCustomerspath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/customers';
  }

  static String getCustomerDashboardPath({required String custEnrollId}) {
    String orgId = (sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "").toLowerCase();
    return '/app/$orgId/${AxleRoutePath.customers}/${custEnrollId.toLowerCase()}';
  }

  static String getFundTransferPath({required String custEnrollId}) {
    return '${getCustomerDashboardPath(custEnrollId: custEnrollId)}/${AxleRoutePath.fundTransfer}';
  }

  static String getCustomerDetailsPath({required String custEnrollId}) {
    return '${getCustomerDashboardPath(custEnrollId: custEnrollId)}/${AxleRoutePath.customerDetails}';
  }

  // static String getCustomerCardPreference({required String custEnrollId}) {
  //   return '${getCustomerDashboardPath(custEnrollId: custEnrollId)}/${AxleRoutePath.manageOrgCardPreference}';
  // }

  static String getCustomerServicesPath({required String custEnrollId}) {
    //return '${getCustomerDetailsPath(custEnrollId: custEnrollId)}/${AxleRoutePath.customerServices}';
    return '${getCustomerDashboardPath(custEnrollId: custEnrollId)}/${AxleRoutePath.customerServices}';
  }

  static String getUserProfilePath() {
    return '/app/profile';
  }

  static String getPartnersPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/partners';
  }

  static String getPartnersDashboardPath(String partnerId) {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    // return '/app/${orgId.toLowerCase()}/partners/view/$partnerId';
    return '/app/${orgId.toLowerCase()}/partners/$partnerId';
  }

  static String getCreatePartnerPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/partners/create';
  }

  static String getInviteCustomerPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/customers/invite';
  }

  static String getCreateCustomerPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/customers/create';
  }

  static String getStaffsPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/staffs';
  }

  static String getCommissionsPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/commissions';
  }

  static String getStaffsListPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/staffs/view';
  }

  static String getAddStaffsPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/staffs/create';
  }

  static String getTagManagementPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/${AxleRoutePath.tagManagement}';
  }

  static String getUserManagementPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/${AxleRoutePath.userManagement}';
  }

  static String getTransactionsHistoryPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/transactions';
  }

  static String getVehicleDashboardPath(String orgEnrolId, String vehicleId) {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/customers/$orgEnrolId/vehicles/${vehicleId.toLowerCase()}';
  }

  static String getVehicleDetailsPath(String orgEnrolId, String vehicleId) {
    return '${getVehicleDashboardPath(orgEnrolId, vehicleId)}/details';
  }

  static String getVehicleServicesPath(String orgEnrolId, String vehicleId) {
    return '${getVehicleDashboardPath(orgEnrolId, vehicleId)}/services';
  }

  static String getVehicleManageTagPath(String orgEnrollId, String vehicleRegNo) {
    return '${getVehicleDashboardPath(orgEnrollId, vehicleRegNo)}/manage-tag';
  }

  static String getVehicleManageFuelCardPath(String orgEnrollId, String vehicleRegNo) {
    return ('${getVehicleDashboardPath(orgEnrollId, vehicleRegNo)}/${AxleRoutePath.manageVehicleFuelCardPreference}')
        .toLowerCase();
  }

  static String getVehicleFuelFundLoadPath(String orgEnrollId, String vehicleRegNo) {
    return ('${getVehicleDashboardPath(orgEnrollId, vehicleRegNo)}/vehicle-fund-load').toLowerCase();
  }

  static String getFundLoadPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgId/${AxleRoutePath.fundLoad}';
  }

  static String getGpsManagePath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/gps-manage';
  }

  static String addGpsPath() {
    return '${getGpsManagePath()}/add-device';
  }

  static String getPaymentsPath(String userOrgEnrollId) {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/customers/${userOrgEnrollId.toLowerCase()}/payments';
  }

  static String getPaymentsEnablePath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/payments/enable';
  }

  static String getInvoicePath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/invoice';
  }

  static String getECardPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/e-card-verification';
  }

  static String getChallanPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/e-card-verification/challan';
  }

  static String getRcPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/e-card-verification/rc-details';
  }

  static String getPanPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/e-card-verification/pan-details';
  }

  static String getAadhaarPath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/e-card-verification/aadhaar';
  }

  static String getDrivingLicensePath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/e-card-verification/driving-license';
  }

  static String getCbilScorePath() {
    String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/${orgId.toLowerCase()}/e-card-verification/cbil-score';
  }

  // static String getCreatePaymentsPath() {
  //   String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
  //   return '/app/${orgId.toLowerCase()}/payments/create';
  // }

  static String getVehicleGpsDetailsPath(String orgEnrolId, String vehicleRegNo) {
    return '${getVehicleDashboardPath(orgEnrolId, vehicleRegNo)}/gps';
  }

  static String getStaffDashboard(String orgEnrolId, String staffEnrolId) {
    String orgEnrollId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgEnrollId/customers/$orgEnrolId/staffs/$staffEnrolId'.toLowerCase();
  }

  static String getStaffManageCardPath(String orgEnrolId, String staffEnrolId) {
    return ('${getStaffDashboard(orgEnrolId, staffEnrolId)}/manage-card').toLowerCase();
  }

  static String getOrgManageCardPath(String orgEnrolId) {
    return ('${getCustomerDashboardPath(custEnrollId: orgEnrolId)}/${AxleRoutePath.manageOrgCardPreference}')
        .toLowerCase();
  }

  static String getOrgManageFuelPath(String orgEnrolId) {
    return ('${getCustomerDashboardPath(custEnrollId: orgEnrolId)}/${AxleRoutePath.manageOrgFuelPreference}')
        .toLowerCase();
  }

  static String staffEnablePpi(String orgEnrolId, String staffEnrolId) {
    return ('${getStaffDashboard(orgEnrolId, staffEnrolId)}/add-card').toLowerCase();
  }

  static String getStaffServices(String orgEnrolId, String staffEnrolId) {
    return ('${getStaffDashboard(orgEnrolId, staffEnrolId)}/add-services').toLowerCase();
  }

  static String getVehiclesListPath() {
    String orgEnrollId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? "";
    return '/app/$orgEnrollId/vehicles/view'.toLowerCase();
  }
}

// extension AppPageExtension on APP_PAGE {
//   String get toPath {
//     switch (this) {
//       case APP_PAGE.home:
//         return "/";
//       case APP_PAGE.userProfile:
//         return "/profile";
//       case APP_PAGE.login:
//         return "/login";
//       case APP_PAGE.splash:
//         return "/splash";
//       case APP_PAGE.error:
//         return "/error";
//       case APP_PAGE.onBoarding:
//         return "/start";
//       case APP_PAGE.forgotPassword:
//         return "/forgot-password";
//       case APP_PAGE.resetPassword:
//         return "/reset-password";
//       case APP_PAGE.changePassword:
//         return "/change-password";
//       case APP_PAGE.accountActivation:
//         return "/account-activation";
//       default:
//         return "/";
//     }
//   }

//   String get toName {
//     switch (this) {
//       case APP_PAGE.home:
//         return "HOME";
//       case APP_PAGE.userProfile:
//         return "PROFILE";
//       case APP_PAGE.login:
//         return "LOGIN";
//       case APP_PAGE.splash:
//         return "SPLASH";
//       case APP_PAGE.error:
//         return "ERROR";
//       case APP_PAGE.onBoarding:
//         return "START";
//       case APP_PAGE.forgotPassword:
//         return "FORGOT PASSWORD";
//       case APP_PAGE.resetPassword:
//         return "RESET PASSWORD";
//       case APP_PAGE.changePassword:
//         return "CHANGE PASSWORD";
//       case APP_PAGE.accountActivation:
//         return "ACTIVATE ACCOUNT";
//       default:
//         return "HOME";
//     }
//   }

//   String get toTitle {
//     switch (this) {
//       case APP_PAGE.home:
//         return "Axlerate - Poral";
//       case APP_PAGE.userProfile:
//         return "Profile Screen";
//       case APP_PAGE.login:
//         return "Log In Scereen";
//       case APP_PAGE.splash:
//         return "Splash Screen";
//       case APP_PAGE.error:
//         return "Error Screen";
//       case APP_PAGE.onBoarding:
//         return "Welcome - Onboarding Screen";
//       case APP_PAGE.forgotPassword:
//         return "Forgot Password Screen";
//       case APP_PAGE.resetPassword:
//         return "Reset Password Screen";
//       case APP_PAGE.changePassword:
//         return "Change Password Screen";
//       case APP_PAGE.accountActivation:
//         return "Activate Account";
//       default:
//         return "My App";
//     }
//   }

//   bool get isAuthorisedRoute {
//     switch (this) {
//       case APP_PAGE.home:
//         return true;
//       case APP_PAGE.userProfile:
//         return true;
//       case APP_PAGE.login:
//         return false;
//       case APP_PAGE.splash:
//         return false;
//       case APP_PAGE.error:
//         return false;
//       case APP_PAGE.onBoarding:
//         return false;
//       case APP_PAGE.forgotPassword:
//         return false;
//       case APP_PAGE.resetPassword:
//         return false;
//       case APP_PAGE.changePassword:
//         return true;
//       case APP_PAGE.accountActivation:
//         return false;
//       default:
//         return false;
//     }
//   }
// }
