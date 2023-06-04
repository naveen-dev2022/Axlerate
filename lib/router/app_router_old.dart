// import 'package:axlerate/app_util/enums/org_type.dart';
// import 'package:axlerate/app_util/extensions/extensions.dart';
// import 'package:axlerate/router/app_routes.dart';
// import 'package:axlerate/router/auth_routes.dart';
// import 'package:axlerate/router/axle_route.dart';
// import 'package:axlerate/router/axle_route_path.dart';
// import 'package:axlerate/router/route_utils.dart';
// import 'package:axlerate/src/features/authentication/domain/auth_result.dart';
// import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
// import 'package:axlerate/src/features/authentication/presentation/shared/auth_background.dart';
// import 'package:axlerate/src/features/home/dashboard/shared/axle_view.dart';
// import 'package:axlerate/src/local_storage/local_storage.dart';
// import 'package:axlerate/src/local_storage/storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:safe_device/safe_device.dart';

// final appRouterProvider = Provider<AppRouter>((ref) {
//   return AppRouter(ref);
// });

// class AppRouter {
//   AppRouter(this.ref);

//   final Ref ref;

//   GoRouter get router => _goRouter;

//   //final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
//   final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

//   late final GoRouter _goRouter = GoRouter(
//     initialLocation: AxleRoute.app,
//     debugLogDiagnostics: true,
//     redirect: routeGuard,
//     routes: [
//       ShellRoute(
//           navigatorKey: _shellNavigatorKey,
//           builder: (context, state, child) => _getScaffold(context, state, child),
//           routes: [
//             GoRoute(
//               path: '/',
//               builder: (context, state) => const Text("Initial Location"),
//             ),
//             GoRoute(
//               path: AxleRoute.auth,
//               builder: (context, state) => const Text('Auth'),
//               routes: authRoutes,
//             ),
//             GoRoute(
//               path: AxleRoute.app,
//               builder: (context, state) => const Text("App"),
//               routes: appGoRoutes,
//             )
//           ]),
//     ],
//     errorBuilder: (context, state) => Scaffold(
//       backgroundColor: Colors.red.withOpacity(0.8),
//       body: Center(child: Text(state.error.toString())),
//     ),
//   );

//   /// Based on the current route it returns the common scaffold or background
//   Widget _getScaffold(
//     BuildContext context,
//     GoRouterState routerState,
//     Widget page,
//   ) {
//     if (routerState.subloc.contains('account') || routerState.subloc.contains('filter')) {
//       return page;
//     } else if (routerState.subloc.contains(AxleRoute.auth) || routerState.subloc.contains('password')) {
//       return AuthBackground(screenForm: page);
//     } else {
//       return AxleView(
//         // pageWidget: page,
//         // routerState: routerState,
//         appBarTitle: getTitle(routerState),
//       );
//     }
//   }

//   String getTitle(GoRouterState routerState) {
//     List<String> locations = routerState.subloc.split('/');
//     String toRet = locations.last;

//     if (locations.length > 1) {
//       int length = locations.length;

//       const pattern = r'(axl)|(axu)|(axv)|(axp)';
//       final regExp = RegExp(pattern, caseSensitive: false);
//       String str1 = '';
//       String str2 = '';
//       if (regExp.hasMatch(locations[length - 2])) {
//         str1 = locations[length - 2].toUpperCase();
//       } else {
//         str1 = locations[length - 2].toTitleCase();
//       }

//       if (regExp.hasMatch(locations.last) || locations[length - 2].toLowerCase().contains('vehicle')) {
//         if (locations.last.toLowerCase() == 'view') {
//           str2 = locations.last.toUiTitleCase;
//         } else {
//           str2 = locations.last.toUpperCase();
//         }
//       } else {
//         str2 = locations.last.toUiTitleCase;
//       }

//       toRet = "$str1 • $str2";

//       if (toRet.toLowerCase().contains('select-org')) {
//         toRet = 'Dashboard';
//       } else if (toRet.toLowerCase().contains('customers')) {
//         toRet = 'Dashboard';
//       } else if (toRet.toLowerCase().contains('static dashboard')) {
//         final orgName = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgName) ?? '';
//         final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
//         toRet = '${orgName.toUiCase} • ${orgEnrollId.toUpperCase()}';
//       }
//     }

//     return toRet;

//     //return getPageTitle(routerState.fullpath.toString());
//   }

//   String getPageTitle(String path) {
//     String toRet = "Axlerate";
//     if (path.contains("/:orgId/dashboard")) {
//       return toRet = "Dashboard";
//     } else if (path.contains("/:orgId/partners/view")) {
//       return toRet = "Partners List";
//     } else if (path.contains('/app/:orgId/vehicles/view')) {
//       return toRet = "Vehicles List";
//     } else if (path.contains('/app/:orgId/staffs/view')) {
//       return toRet = "Staff List";
//     }

//     return toRet;
//   }

//   /// Axlerate route guard
//   Future<String?> routeGuard(BuildContext context, GoRouterState routerState) async {
//     // debugPrint('=========================================');
//     // debugPrint("Go FullPath ${routerState.fullpath}");
//     // debugPrint("Go Name ${routerState.name}");
//     // debugPrint("Go Path ${routerState.path}");
//     // debugPrint("Go Location ${routerState.location}");
//     // debugPrint("Go subloc ${routerState.subloc}");

//     /* REMOVED THIS CODE FOR VAPT SUBMISSION */
//     bool isSafeDevice = await detectSafeDevice();
//     if (!isSafeDevice) {
//       // log("JAIL BROKEN DEVICE DETECTED");
//       // Go To Error Screen

//       return RouteUtils.getErrorDashbaord();
//     }
//     // INCLUDE THIS FOR PRDUCTION BUILD */

//     final subloc = routerState.subloc;
//     final isloggedIn = ref.watch(isLoggedInProvider);
//     final authState = ref.watch(authResultProvider);
//     final authToken = ref.watch(authTokenProvider);

//     if (isloggedIn == false && authState == AuthResult.pending) {
//       return '${AxleRoute.accountActivation}?token=$authToken';
//     }

//     // if (ref.watch(authResultProvider) == AuthResult.pending && isloggedIn == false) {
//     // return AxleRoute.accountActivation;
//     // }

//     // if (routerState.subloc == AxleRoute.accountActivation) {
//     //   if (isloggedIn == false) {
//     //     return null;
//     //   }
//     // }

//     if (isloggedIn == true && authState == AuthResult.success) {
//       final orgStatus = ref.read(sharedPreferenceProvider).getString(Storage.selectedOrgStatus) ?? '';
//       final userType = ref.read(localStorageProvider).getOrgType();
//       // log('The USER TYPE role is ---> $userType');

//       // * If User in Invited State
//       if (orgStatus == 'INVITED' && !(subloc.contains('select'))) {
//         final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
//         return '/app/${orgEnrollId.toLowerCase()}/${AxleRoutePath.completeReg}';
//       }

//       // If User Type is LogisticsStaff
//       if (userType == OrgType.logisticsStaff) {
//         if (subloc.contains('profile') ||
//             subloc.contains('select') ||
//             subloc.contains('transactions') ||
//             subloc.contains('manage-card')) {
//           return null;
//         }

//         final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
//         final staffEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.userEnrollmentId) ?? '';

//         // log('Staff Path is --> $subloc');
//         return RouteUtils.getStaffDashboard(orgEnrollId, staffEnrollId);

//         // final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
//         // final userEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.userEnrollmentId) ?? '';
//         // return '/app/$orgEnrollId/customers/$orgEnrollId/staffs/${userEnrollId.toLowerCase()}';
//       }

//       // final orgEnrollId = ref.read(sharedPreferenceProvider).getString(Storage.currentlyPickedOrgEnrollId) ?? '';
//       // If user logged in and user still in auth screen then take them to Select Organization
//       if (subloc.contains('/auth') || subloc == '/' || subloc == '/app') {
//         return '/app/select-org';
//       }

//       // Customers
//       if (subloc.endsWith('/customers') || subloc.endsWith('/customers/')) {
//         return '$subloc/view';
//       }

//       // PartnerS
//       if (subloc.endsWith('/partners') || subloc.endsWith('/partners/')) {
//         return '$subloc/view';
//       }

//       // Staffs
//       if (subloc.endsWith('/staffs') || subloc.endsWith('/staffs/')) {
//         return '$subloc/view';
//       }

//       // Vehicles
//       if (subloc.endsWith('/vehicles') || subloc.endsWith('/vehicles/')) {
//         return '$subloc/view';
//       }
//     } else {
//       // * If user not logged in
//       if (subloc.contains('/app') || subloc == '/') {
//         return AxleRoute.login;
//       }
//     }

//     return null;
//   }

//   /* REMOVED THIS CODE FOR VAPT SUBMISSION */
//   Future<bool> detectSafeDevice() async {
//     bool toRet = true;

//     bool isJailBroken = false;
//     bool isRealDevice = true;
//     bool isSafeDevice = true;

//     if (!kIsWeb) {
//       try {
//         isJailBroken = await SafeDevice.isJailBroken;
//         isRealDevice = await SafeDevice.isRealDevice;
//         // isSafeDevice = await SafeDevice.isSafeDevice;
//       } catch (error) {
//         debugPrint(error.toString());
//       }

//       try {
//         LocalAuthentication auth = LocalAuthentication();
//         final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

//         if (availableBiometrics.isNotEmpty) {
//           isSafeDevice = true;
//         } else {
//           bool isDeviceSupporeted = await auth.isDeviceSupported();
//           if (isDeviceSupporeted) {
//             isSafeDevice = true;
//           } else {
//             isSafeDevice = false;
//           }
//         }
//       } catch (error) {
//         debugPrint("Exception while getting Availabe Biometrics");
//       }

//       // debugPrint("Jail Broken :: $isJailBroken - Real Device :: $isRealDevice - Safe Device :: $isSafeDevice");

//       if (isJailBroken) {
//         toRet = false;
//         ref.read(sharedPreferenceProvider).setString("errorMessage", "This Device appears to be JailBroken.");
//       }

//       if (!isRealDevice) {
//         toRet = false;
//         ref.read(sharedPreferenceProvider).setString("errorMessage", "This Device dosent seems to be Real.");
//       }

//       if (!isSafeDevice) {
//         toRet = false;
//         ref.read(sharedPreferenceProvider).setString("errorMessage", "Enable Password or Pin in you device.");
//       }
//     }

//     return toRet;
//   }
//   // INCLUDE THIS FOR PRDUCTION BUILD */
// }
