import 'package:flutter/foundation.dart';

@immutable
class AxleRoute {
  static const auth = '/auth';
  static const app = '/app';
  static const login = '/auth/login';
  static const loginWithOtp = '/auth/login-with-otp';
  static const resetPassword = '/auth/reset-password';
  static const setNewPassword = '/auth/set-new-password';
  static const accountActivation = '/auth/account-activation';
  static const home = '/app/home';
  static const orgEnrollId = '/app/:orgId';

  static const profile = '/app/profile';

  static const dashboard = '/app/dashboard';
  static const vehicles = '/app/vehicles';
  static const partners = '/app/partners';
  static const customers = '/app/customers';
  static const createCustomer = '/app/create-customer';
  static const createPartner = '/app/create-partner';
  static const viewCustomers = '/app/view-customers';
  static const viewPartners = '/app/view-partners';

  const AxleRoute._();
}
