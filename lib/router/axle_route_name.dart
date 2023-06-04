import 'package:flutter/foundation.dart';

@immutable
class AxleRouteName {
  static const login = 'Login';
  static const loginWithOtp = 'Login With OTP';
  // static const resetPassword = 'Reset Password';
  // static const setNewPassword = 'Set New Passwword';
  static const accountActivation = 'Account Activation';

  static const orgEnrollId = 'OrgId';

  static const home = 'Home';
  static const profile = 'Profile';
  static const app = 'App';
  static const dashboard = 'Dashboard';
  static const completeReg = 'Complete Registration';
  static const vehicles = 'Vehicles';

  static const customers = 'Customers';
  static const createCustomer = 'Create Customer';
  static const viewCustomers = 'View Customers';
  static const customerDetails = 'Customer Details';
  static const customerServices = 'Customer Services';
  static const fundTransfer = 'Fund Transfer';

  static const manageOrgCardPreference = 'Manage Org Card Preference';
  static const manageVehicleFuelCardPreference = 'Manage Vehicle Fuel Card Preference';

  static const partners = 'Partners';
  static const createPartner = 'Create Partner';
  static const viewPartners = 'View Partners';

  static const staff = 'Staff';
  static const fundLoad = "Fund Load";

  static const gpsManagement = "GPS Management";
  static const payments = "Payments";

  static const tagManagement = "Tag Management";
  static const userManagement = "User Management";
  static const transactionHistory = "Transaction History";

  static const staticDash = 'Static Dashboard';
  static const errorDash = 'Error Dashboard';

  const AxleRouteName._();
}
