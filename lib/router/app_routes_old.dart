// import 'package:axlerate/main.dart';
// import 'package:axlerate/src/features/home/logistics/presentation/logistics_dashboard_by_enroll_id.dart';
// import 'package:axlerate/src/local_storage/storage.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:axlerate/src/features/home/user/presentstion/user_child_dashboard.dart';

// final appGoRoutes = [
//   // * Select Organization
//   // GoRoute(
//   //   path: 'select-org',
//   //   name: 'Select Org',
//   //   pageBuilder: (context, state) {
//   //     return const MaterialPage(
//   //       child: SelectOrgnaizationPage(),
//   //     );
//   //   },
//   // ),

//   // * Static Dashbaord //No use
//   // GoRoute(
//   //   path: AxleRoutePath.staticDash,
//   //   name: AxleRouteName.staticDash,
//   //   pageBuilder: (context, state) {
//   //     return const MaterialPage(
//   //       child: StaticDashbaord(),
//   //     );
//   //   },
//   // ),

// // // * Error Dashbaord
// //   GoRoute(
// //     path: AxleRoutePath.errorDash,
// //     name: AxleRouteName.errorDash,
// //     pageBuilder: (context, state) {
// //       return const MaterialPage(
// //         child: ErrorDashbaord(),
// //       );
// //     },
// //   ),
//   // * User Profile
//   // GoRoute(
//   //   path: AxleRoutePath.profile,
//   //   name: AxleRouteName.profile,
//   //   redirect: (context, state) {
//   //     // log('Profile Page redirect');
//   //     return null;
//   //   },
//   //   pageBuilder: (context, state) => const MaterialPage(
//   //     child: ProfilePage(),
//   //   ),
//   // ),

//   GoRoute(
//     path: ':orgId',
//     // redirect: (context, state) => RouteUtils.getDashboardPath(),
//     builder: (context, state) => const Text(""),
//     routes: [
//       //* Dashboard
//       // GoRoute(
//       //     path: AxleRoutePath.dashboard,
//       //     name: AxleRouteName.dashboard,
//       //     redirect: (context, state) {
//       //       String orgType = sharedPreferences.getString(Storage.currentlyPickedOrgType) ?? '';

//       //       // if (orgType.contains("LOGISTICS")) {
//       //       //   return RouteUtils.getDashboardPath();
//       //       // } else {
//       //       //   if (!kIsWeb) {
//       //       //     return RouteUtils.getStaticDashbaordPath();
//       //       //   }
//       //       // }

//       //       if (!kIsWeb && orgType.contains("dummy")) {
//       //         return RouteUtils.getStaticDashbaordPath();
//       //       }

//       //       return null;
//       //     },
//       //     pageBuilder: (context, state) {
//       //       String orgType = sharedPreferences.getString(Storage.currentlyPickedOrgType) ?? '';
//       //       String orgId = sharedPreferences.getString(Storage.currentlyPickedOrgId) ?? '';

//       //       // log("orgType -----> $orgType");

//       //       if (orgType.contains("AXLERATE")) {
//       //         return const MaterialPage(
//       //           child: SuperAdminDashboard(),
//       //         );
//       //       } else if (orgType.contains("PARTNER")) {
//       //         return MaterialPage(
//       //           child: PartnerDashboard(
//       //             orgId: orgId,
//       //             orgType: orgType,
//       //           ),
//       //         );
//       //       } else {
//       //         return MaterialPage(
//       //           child: LogisticsDashboard(
//       //             orgId: orgId,
//       //             orgEnrollId: orgId,
//       //           ),
//       //         );
//       //       }
//       //     }),

//       // //* Complete Registration Logistics
//       // GoRoute(
//       //     path: AxleRoutePath.completeReg,
//       //     name: AxleRouteName.completeReg,
//       //     redirect: (context, state) {
//       //       if (state.extra == null) {
//       //         return '';
//       //       }
//       //     },
//       //     pageBuilder: (context, state) {
//       //       return const MaterialPage(
//       //         child: CompleteInvitedLogistics(),
//       //       );
//       //     }),

//       // * Customers
//       GoRoute(
//         path: 'customers',
//         name: 'Customers',
//         // redirect: (context, state) => state.subloc + '/view',
//         builder: (context, state) => const Text('Customers'),
//         routes: [
//           // GoRoute(
//           //   path: 'view',
//           //   name: 'View Customers',
//           //   pageBuilder: (context, state) => const MaterialPage(
//           //     child: ListLogisticsPage(),
//           //   ),
//           // ),
//           // GoRoute(
//           //   path: 'create',
//           //   name: 'Create Customer',
//           //   pageBuilder: (context, state) => const MaterialPage(
//           //     child: CreateLogisticsPage(),
//           //   ),
//           // ),
//           // GoRoute(
//           //   path: 'invite',
//           //   name: 'Invite Customer',
//           //   pageBuilder: (context, state) {
//           //     return const MaterialPage(
//           //       child: InviteLogisticsPage(),
//           //     );
//           //   },
//           // ),
//           // GoRoute(
//           //     path: 'dashboard',
//           //     name: 'Customer Dashboard',
//           //     redirect: (context, state) {
//           //       if (state.extra == null) {
//           //         return getBackPage(state);
//           //       }
//           //       return null;
//           //     },
//           //     pageBuilder: (context, state) {
//           //       // log(state.toString());
//           //       Map<String, dynamic> data = state.extra != null ? state.extra as Map<String, dynamic> : {};
//           //       return const MaterialPage(
//           //         name: "Customer Dashboard",
//           //         child: LogisticsDashboard(),
//           //       );
//           //     }),
//           GoRoute(
//               path: ':custOrgId',
//               pageBuilder: (context, state) {
//                 final userRole = sharedPreferences.getString(Storage.currentUserRole);
//                 // log('Entering Dashboard Path -> Role -> $userRole');
//                 print("Params ::${state.params}");
//                 if (userRole == 'STAFF') {
//                   final userEnrollId = sharedPreferences.getString(Storage.userEnrollmentId);

//                   return MaterialPage(
//                     child: UserChildDashboard(
//                       userEnrollmentId: userEnrollId!,
//                       orgenrollIdOfUser: state.params['custOrgId']!,
//                     ),
//                   );
//                 }
//                 return MaterialPage(
//                   child: LogisticsOrganisationByEnrolmentId(
//                     enrolId: state.params['custOrgId']!,
//                   ),
//                 );
//               },
//               routes: const [
//                 // GoRoute(
//                 //   path: AxleRoutePath.fundTransfer,
//                 //   name: AxleRouteName.fundTransfer,
//                 //   pageBuilder: (context, state) {
//                 //     final currentLqAdminEnrollmentId = sharedPreferences.getString(Storage.currentLqAdminEnrollmentId);
//                 //     return MaterialPage(
//                 //       child: FundTransferPage(
//                 //         orgEnrollId: state.params['custOrgId']!,
//                 //         // userEnrollmentId: currentLqAdminEnrollmentId ?? '',
//                 //       ),
//                 //     );
//                 //   },
//                 // ),

//                 // GoRoute(
//                 //     path: AxleRoutePath.customerServices,
//                 //     name: AxleRouteName.customerServices,
//                 //     pageBuilder: (context, state) => const MaterialPage(child: AddAxleServicePage()),
//                 //     routes: [
//                 //       GoRoute(
//                 //         path: AxleRoutePath.customerDetails,
//                 //         name: AxleRouteName.customerDetails,
//                 //         pageBuilder: (context, state) => NoTransitionPage(
//                 //             child: LogisticsDetailedScreen(
//                 //           enrolId: state.params['custOrgId']!,
//                 //         )),
//                 //       )
//                 //     ]),

//                 // GoRoute(
//                 //   path: AxleRoutePath.customerDetails,
//                 //   name: AxleRouteName.customerDetails,
//                 //   pageBuilder: (context, state) => NoTransitionPage(
//                 //       child: LogisticsDetailedScreen(
//                 //     enrolId: state.params['custOrgId']!,
//                 //   )),
//                 //   routes: [
//                 //     GoRoute(
//                 //         path: AxleRoutePath.customerServices,
//                 //         name: AxleRouteName.customerServices,
//                 //         pageBuilder: (context, state) => const MaterialPage(child: AddAxleServicePage())),
//                 //   ],
//                 // ),
//                 // GoRoute(
//                 //   path: AxleRoutePath.manageOrgCardPreference,
//                 //   name: AxleRouteName.manageOrgCardPreference,
//                 //   pageBuilder: (context, state) {
//                 //     return NoTransitionPage(child: SetOrgPPIPreferencePage(orgEnrolld: state.params['custOrgId']!));
//                 //   },
//                 // ),
//                 // GoRoute(
//                 //   path: 'vehicles/:vehicleRegNo',
//                 //   name: 'Vehicle Dashboard New',
//                 //   pageBuilder: (context, state) {
//                 //     return MaterialPage(
//                 //       child: VehicleDashboard(
//                 //           vehicleRegNo: state.params['vehicleRegNo']!, orgEnrolld: state.params['custOrgId']!),
//                 //     );
//                 //   },
//                 //   routes: vehicleSubRoutes,
//                 // ),

//                 // GoRoute(
//                 // path: 'staffs/:staffEnrolId',
//                 // name: 'Staff Dashboard New',
//                 // pageBuilder: (context, state) {
//                 //   return MaterialPage(
//                 //     child: UserChildDashboard(
//                 //       userEnrollmentId: state.params['staffEnrolId']!,
//                 //       orgenrollIdOfUser: state.params['custOrgId']!,
//                 //     ),
//                 //   );
//                 // },
//                 // routes: [
//                 // GoRoute(
//                 //     path: 'manage-card',
//                 //     pageBuilder: (context, state) {
//                 //       // print("Staff Manage Path ::${state.fullpath}");
//                 //       return MaterialPage(
//                 //         child: ManageCardPage(
//                 //           userEnrolmentId: state.params['staffEnrolId']!,
//                 //           userOrgId: state.params['custOrgId']!,
//                 //         ),
//                 //       );
//                 //     }),
//                 // GoRoute(
//                 //     path: 'add-services',
//                 //     pageBuilder: (context, state) {
//                 //       return MaterialPage(
//                 //         child: AddUserService(
//                 //           userEnrollmentId: state.params['staffEnrolId']!,
//                 //           orgenrollIdOfUser: state.params['custOrgId']!,
//                 //         ),
//                 //       );
//                 //     }),
//                 // ],
//                 // ),
//               ]),
//         ],
//       ),

//       // * Partners
//       // GoRoute(
//       //   path: 'partners',
//       //   name: 'Partners',
//       //   builder: (context, state) => const Text('Partners'),
//       //   routes: [
//       //     GoRoute(
//       //       path: 'view',
//       //       name: 'View Partners',
//       //       pageBuilder: (context, state) => const MaterialPage(
//       //         child: ListPartnerPage(),
//       //       ),
//       //     ),
//       //     GoRoute(
//       //       path: 'view/:partnerId',
//       //       name: 'Partner Dashboard',
//       //       redirect: (context, state) {
//       //         if (state.extra == null) {
//       //           return getBackPage(state);
//       //         }
//       //         return null;
//       //       },
//       //       pageBuilder: (context, state) {
//       //         Map<String, dynamic> data = state.extra != null ? state.extra as Map<String, dynamic> : {};

//       //         return MaterialPage(
//       //           child: PartnerDashboard(
//       //             orgId: data['orgId'] ?? '',
//       //           ),
//       //         );
//       //       },
//       //     ),
//       //     GoRoute(
//       //       path: 'create',
//       //       name: 'Create Partner',
//       //       pageBuilder: (context, state) => const MaterialPage(
//       //         child: CreatePartnerPage(),
//       //       ),
//       //     ),
//       //   ],
//       // ),

//       // * Staffs (Users)
//       // GoRoute(
//       //   path: 'staffs',
//       //   name: 'Staff',
//       //   builder: (context, state) => const Text('Staff'),
//       //   routes: [
//       // GoRoute(
//       //     path: 'view',
//       //     name: 'View Staff',
//       //     pageBuilder: (context, state) {
//       //       Map<String, dynamic> params = state.extra != null ? state.extra as Map<String, dynamic> : {};
//       //       log("View Staff :: $params");
//       //       return MaterialPage(child: ListUsersPage(userRole: params['userRole']));
//       //     }),
//       // GoRoute(
//       //   path: 'create',
//       //   name: 'Create Staff',
//       //   pageBuilder: (context, state) {
//       //     return const MaterialPage(
//       //       child: CreateUserPage(),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: 'add-ppi',
//       //   name: 'Add PPI',
//       //   redirect: (context, state) {
//       //     if (state.extra == null) {
//       //       return getBackPage(state);
//       //     }
//       //     return null;
//       //   },
//       //   pageBuilder: (context, state) {
//       //     final Map<String, dynamic> passingData =
//       //         state.extra as Map<String, dynamic>;
//       //     log('Printing -> ${passingData['userId']}');
//       //     return MaterialPage(
//       //       child: AddPpiCardToUserPage(
//       //         userId: passingData['userId'],
//       //         organizationID: passingData['organizationID'],
//       //         orgEntityID: passingData['orgEntityID'],
//       //       ),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: 'staff-child-dashboard',
//       //   name: 'Staff Child Dashboard',
//       //   // redirect: (context, state) {
//       //   //   if (state.extra == null) {
//       //   //     return getBackPage(state);
//       //   //   }
//       //   //   return null;
//       //   // },
//       //   pageBuilder: (context, state) {
//       //     // Map<String, dynamic> data = state.extra != null
//       //     //     ? state.extra as Map<String, dynamic>
//       //     //     : {};
//       //     return MaterialPage(
//       //       child: UserChildDashboard(
//       //           // userEntityId: data['entityId'] ?? '',
//       //           // userName: data['userName'] ?? '',
//       //           // userOrgName: data['userOrgName'] ?? '',
//       //           // userEnrollId: data['userEnrollId'] ?? '',
//       //           // userOrgEntityId: data['userOrgEntityId'] ?? '',
//       //           // partnerOrgId: data['partnerOrgId'] ?? '',
//       //           // orgId: data['orgId'] ?? '',
//       //           ),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: 'manage-card',
//       //   name: 'Manage Card',
//       //   redirect: (context, state) {
//       //     if (state.extra == null) {
//       //       return getBackPage(state);
//       //     }
//       //     return null;
//       //   },
//       //   pageBuilder: (context, state) {
//       //     Map<String, dynamic> data = state.extra != null
//       //         ? state.extra as Map<String, dynamic>
//       //         : {};
//       //     return MaterialPage(
//       //         child: ManageCardPage(
//       //             // userName: data['userName'] ?? '',
//       //             // userOrgName: data['userOrgName'] ?? '',
//       //             // userEntityId: data['userEntityId'] ?? '',
//       //             // userOrgId: data['userOrgId'] ?? '',
//       //             ));
//       //   },
//       // ),
//       //   ],
//       // ),

//       // // * Vehicles
//       // GoRoute(
//       //   path: 'vehicles',
//       //   name: 'Vehicles',
//       //   builder: (context, state) => const Text('Vehicles'),
//       //   routes: [
//       //     GoRoute(
//       //       path: 'view',
//       //       name: 'View Vehicles',
//       //       pageBuilder: (context, state) {
//       //         Map<String, dynamic> params = state.extra != null ? state.extra as Map<String, dynamic> : {};
//       //         return MaterialPage(child: ListVehiclesPage(text: params['org']));
//       //       },
//       //     ),
//       //     GoRoute(
//       //       path: 'create',
//       //       name: 'Create Vehicles',
//       //       pageBuilder: (context, state) => const MaterialPage(
//       //         child: CreateVehiclePage(),
//       //       ),
//       //     ),
//       //   ],
//       // ),

//       // //* Tag Management - Coming Soon
//       // GoRoute(
//       //   path: AxleRoutePath.tagManagement,
//       //   name: AxleRouteName.tagManagement,
//       //   pageBuilder: (context, state) => const MaterialPage(
//       //     child: ErrorPage(),
//       //   ),
//       // ),

//       // // GPS Device Management
//       // GoRoute(
//       //     path: AxleRoutePath.gpsManagement,
//       //     name: AxleRouteName.gpsManagement,
//       //     pageBuilder: (context, state) => const MaterialPage(child: ListGpsDevices()),
//       //     routes: [
//       //       GoRoute(
//       //         path: 'add-device',
//       //         name: "AddGPSDevice",
//       //         pageBuilder: (context, state) => const MaterialPage(child: AddGpsDevices()),
//       //       )
//       //     ]),

//       // //* User Management - Coming Soon
//       // GoRoute(
//       //   path: AxleRoutePath.userManagement,
//       //   name: AxleRouteName.userManagement,
//       //   pageBuilder: (context, state) => const MaterialPage(
//       //     child: ErrorPage(),
//       //   ),
//       // ),

//       // // Payments
//       // GoRoute(
//       //   path: AxleRoutePath.payments,
//       //   name: AxleRouteName.payments,
//       //   pageBuilder: (context, state) {
//       //     return const MaterialPage(
//       //       child: PaymentsPage(),
//       //     );
//       //   },
//       //   routes: [
//       //     // GoRoute(
//       //     //   path: 'enable',
//       //     //   name: "Enable Payments",
//       //     //   pageBuilder: (context, state) => const MaterialPage(
//       //     //     child: EnablePaymentsPage(),
//       //     //   ),
//       //     // ),
//       //     GoRoute(
//       //       path: 'create',
//       //       name: "Create Payments",
//       //       pageBuilder: (context, state) {
//       //         String orgEnrollId = sharedPreferences.getString(Storage.currentlyPickedOrgEnrollId) ?? '';
//       //         return MaterialPage(
//       //           child: CreatePaymentPage(orgEnrollId: orgEnrollId),
//       //         );
//       //       },
//       //     )
//       //   ],
//       // ),

//       // //* Transaction History
//       // GoRoute(
//       //   path: AxleRoutePath.transactionHistory,
//       //   name: AxleRouteName.transactionHistory,
//       //   pageBuilder: (context, state) => const MaterialPage(
//       //     child: TransactionHistoryPage(),
//       //   ),
//       // ),

//       // //* Fund Load - Coming Soon
//       // GoRoute(
//       //   path: AxleRoutePath.fundLoad,
//       //   name: AxleRouteName.fundLoad,
//       //   pageBuilder: (context, state) => const MaterialPage(
//       //     child: ErrorPage(),
//       //   ),
//       // ),
//     ],
//   ),
// ];

// // * Return the path to back page as a String
// String getBackPage(GoRouterState state) {
//   List splited = state.subloc.split('/');
//   splited.removeLast();
//   return splited.join('/');
// }
