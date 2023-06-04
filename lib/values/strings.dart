import 'package:flavor/flavor.dart';

class Strings {
  static const String appVersion = "B64C136408BBB80DFA6717A62D239726";
  static const String buildNumber = "BD100F7414BDC0F9EFD9861B8404CCCF";
  static const String xAuthToken = "x-auth-token";
  static const String xAuthRefreshToken = "x-auth-refresh-token";
  static const String deviceId = "deviceId";
  static const String deviceName = "deviceName";
  static const String fcmToken = "fcmToken";
  static const String currentOrganizationId = "6ca0d3f617fef689fe6d6fcb54db8261";
  static const String currentOrganizationEnrollmentId = "d5c82a05d178facf0e0c978f0818b915";
  static const String currentOrgName = 'current_organisation_name';
  static const String organizations = "d9811f03b461a380c0d6b4a497dbac37";
  static const String organizationType = "5f2dd728140914e4315bb436449970c4";
  static const String organizationStatus = "01d8060f8c747c3cb67b42adec74ede7";
  static const String currentUserName = "d0489078d984efb4178decc00d05ae77";
  // static const String currentUserEmail = "03a5ad938204c4677e06ad76bb31faf3";
  static const String fundUnencodedPath = "/api/fund";
  static const String fundLoadUnencodedPath = "/fundLoad";
  static final String baseUrl = Flavor.I.getString(Keys.apiUrl) as String;
  static final String siteKey = Flavor.I.getString(Keys.apiKey) as String;
  //static const String baseUrl = 'https://732b-103-182-130-59.ngrok-free.app';
  // 'https://api.axlerate.com';
  // "https://1f29-2401-4900-1f20-23c0-f84a-f530-1a45-3f05.in.ngrok.io";
  // 'https://436b-2401-4900-1cd4-fca8-1ef7-65d9-f422-99e2.in.ngrok.io';

  // 'http://staging-api.axlerate.com:3000';
  static const String fcmTokenUnencodedPath = "/api/user/update-fcm";

  static const String refreshTokenUnencodedPath = "/api/user/accessToken";
  static const String loginUnencodedPath = "/api/user/login";
  static const String logoutUnencodedPath = "/api/user/logout";
  static const String getProfileUnencodedPath = "/api/user/profile";
  static const String getAccountUnencodedPath = "/api/user/dashboard";
  static const String getAccountInfoUnencodedPath = "/api/user/dashboardInfo";
  static const String acivateAccountUnencodedPath = "/api/user/activate";
  static const String forgotPasswordUnencodedPath = "/api/user/password/forgot";
  static const String resetPasswordUnencodedPath = "/api/user/password/forgot/set";
  static const String changePasswordUnencodedPath = "/api/user/password/change";
  static const String getAccountInformationUnencodedPath = "/api/accountInformation";
  static const String transactionsUnencodedPath = "/api/transaction";
  static const String getVehiclesUnencodedPath = "/api/vehicle/";
  static const String getVehicleDetailByIdUnencodedPath = "/api/vehicle";
  static const String organizationUnencodedPath = "/api/organization";
  static const String logisticsOrganizationUnencodedPath = "/logistics";
  static const String inviteLogisticsOrganizationUnencodedPath = "/logistics/invite";
  static const String partnerUnencodedPath = "/partner";
  static const String vehicleUnencodedPath = "/vehicle";
  static const String getSignedURLUnencodedPath = "/api/cloud-storage/file-upload-signed-url";
  static const String getDownloadURLUnencodedPath = "/api/cloud-storage/file-download-signed-url";
  static const String lastDebitTransactionUnencodedPath = "/lastDebitTransaction";
  static const String permissionRequest = "Permission Request";
  static const String needPermissions = "Need Permissions";
  static const String camera = "Camera";
  static const String cameraRequestDescription = "Allow Camera Access to scan the Bills during the trip";
  static const String location = "Location";
  static const String locationRequestDescription = "Allow Location Access to get current location";
  static const String photoLibrary = "Photo Library";
  static const String galleryRequestDescription = "Allow Photo Library Access to open the Gallery Images";
  static const String passwordErrorMessage =
      ' should have the following \n 1 lowercase character (a,b,c,d,e,..z), \n 1 uppercase character (A,B,C,D,E ... Z), \n 1 number (0,1,2,....9) and \n 1 special character (\$,&,+,:,,,;,=,?,@,#,|,\',_<,>,.,^,*,(,),%,!,-)';
  static const Pattern passwordPattern =
      r"(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[$&+,:;=?@#|'_<>.^*()%!-])[A-Za-z\d$&+,:;=?@#|'_<>.^*()%!-]";

  //============================================New App Strings=========================================================

  /// Login With Credentials Screen String
  static const submit = 'Submit';
  static const login = 'Login';
  static const or = 'Or';
  static const loginWithOtp = 'Login with OTP';
  static const forgotPassword = 'Forgot Password?';
  // New App Message Strings
  static const loginPageMessage = 'Hi! Welcome Back..🙏';

  // New App Field Strings

  static const fieldUsername = 'Username';
  static const fieldUsernameHint = 'Enter Contact No.';
  static const fieldPassword = 'Password';
  static const fieldPasswordHint = 'Enter Password';

  static const backToLogin = 'Back to Login';

  // Set New Password Screen Strings

  static const setNewpassword = 'Set New Password';
  static const setNewPassPageMessage = 'Your Password must be different to \npreviously used password. 🔐';
  static const otpFieldLabel = 'OTP';
  static const otpFieldHint = 'Enter OTP';
  static const newPassFieldLabel = 'New Password';
  static const newPassFieldHint = 'Enter New Password';
  static const confirmPassFieldLabel = 'Confirm Password';
  static const confirmPassFieldHint = 'Re-enter New Password';

  /// Reset Password Screen Strings
  ///
  // static const resetPassword = 'Reset Password';
  // static const resetPasswordPageMessage = 'No worries, we\'ll send OTP to your \n registered Email ID. 📩';
  // static const reset = 'Reset';
  static const fieldEmailID = 'Email ID';
  static const fieldEmailHint = 'Email Address';

  static const invited = "Invited";

  static const addVehicle = "Add Vehicle";
  static const fastag = "FASTag";
  static const gps = "GPS";
  static const ppiCard = "Prepaid Card";
  static const fuelCard = "Fuel Card";
  static const yesBankTag = "YesBankTag";
  static const livquikTag = "Livquik Tag";
  static const invoice = 'Payments Link';
  static const omcName = 'OMC Name';

  static const analyticsOnRevenue = "Analytics on Revenue";

  //static const axleratePartnerOrgId = '63a6120d1596fb93a539a03e';
  static String dataType = 'year';
}
