import 'package:flutter/foundation.dart';

@immutable
class AxleRoutePath {
  static const login = 'login';
  static const loginWithOtp = 'login-with-otp';
  // static const resetPassword = 'reset-password';
  // static const setNewPassword = 'set-new-password';
  static const accountActivation = 'account-activation';
  static const auth = 'auth';
  static const home = 'home';
  static const profile = 'profile';
  static const orgEnrollId = ':orgId';

  static const dashboard = 'dashboard';
  static const completeReg = 'complete-registration';

  static const partners = 'partners';
  static const viewPartners = 'view-partners';
  static const createPartner = 'create-partner';

  static const customers = 'customers';
  static const viewCustomers = 'view-customers';
  static const createCustomer = 'create-customer';
  static const customerDetails = 'details';
  static const customerServices = 'services';
  static const fundTransfer = 'fund-transfer';

  static const manageOrgCardPreference = 'org-card-preference';
  static const manageOrgFuelPreference = 'org-card-fuel-preference';
  static const manageVehicleFuelCardPreference = 'vehicle-fuel-card-preference';

  static const vehicles = 'vehicles';

  static const staff = 'staffs';
  static const gpsManagement = 'gps-manage';
  static const payments = 'payments';

  static const tagManagement = 'tag-manage';
  static const userManagement = 'user-manage';
  static const transactionHistory = 'transactions';
  static const fundLoad = 'fund-load';

  static const staticDash = 'static-dashboard';
  static const errorDash = 'error-dashboard';

  const AxleRoutePath._();
}
