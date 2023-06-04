// import 'package:axlerate/router/axle_route.dart';
// import 'package:axlerate/router/axle_route_name.dart';
// import 'package:axlerate/router/axle_route_path.dart';
// import 'package:axlerate/src/features/authentication/presentation/login_with_otp/login_with_otp_form.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// /// Get the Authentication form based on the route location
// NoTransitionPage getAuthForm(BuildContext context, GoRouterState routerState) {
//   final String currentPath = routerState.location;

//   Widget authForm = const LoginWithOtpForm();

//   switch (currentPath) {
//     case AxleRoute.login:
//       authForm;
//       break;
//     case AxleRoute.loginWithOtp:
//       authForm = const LoginWithOtpForm();
//       break;
//     // case AxleRoute.resetPassword:
//     //   authForm = const ResetPasswordForm();
//     //   break;
//     // case AxleRoute.setNewPassword:
//     //   final String data = routerState.extra != null ? routerState.extra as String : '';
//     //   String? contactId = data;
//     //   authForm = SetNewPasswordForm(contactId: contactId);
//     //   break;
//     default:
//       authForm;
//       break;
//   }

//   return NoTransitionPage(child: authForm);
// }

// final authRoutes = [
//   GoRoute(
//     path: AxleRoutePath.login,
//     name: AxleRouteName.login,
//     pageBuilder: (context, state) => const NoTransitionPage(
//       child: LoginWithOtpForm(),
//     ),
//   ),
//   GoRoute(
//     path: AxleRoutePath.loginWithOtp,
//     name: AxleRouteName.loginWithOtp,
//     pageBuilder: (context, state) => const NoTransitionPage(
//       child: LoginWithOtpForm(),
//     ),
//   ),
//   // GoRoute(
//   //   path: AxleRoutePath.resetPassword,
//   //   name: AxleRouteName.resetPassword,
//   //   pageBuilder: (context, state) => const NoTransitionPage(
//   //     child: ResetPasswordForm(),
//   //   ),
//   // ),
//   // GoRoute(
//   //   path: AxleRoutePath.setNewPassword,
//   //   name: AxleRouteName.setNewPassword,
//   //   redirect: (context, state) {
//   //     if (state.extra == null) {
//   //       return '/auth/login';
//   //     }
//   //     return null;
//   //   },
//   //   pageBuilder: (context, state) {
//   //     final String data = state.extra != null ? state.extra as String : '';
//   //     return NoTransitionPage(
//   //       child: SetNewPasswordForm(contactId: data),
//   //     );
//   //   },
//   // ),
//   // GoRoute(
//   //   path: AxleRoutePath.accountActivation,
//   //   name: AxleRouteName.accountActivation,
//   //   redirect: (context, state) {
//   //     final token = state.queryParams['token'];
//   //     if (token == null || token.isEmpty || token == 'null') {
//   //       return '/app/login';
//   //     }
//   //     return null;
//   //   },
//   //   pageBuilder: (context, state) {
//   //     return NoTransitionPage(
//   //       child: AccountActivationPage(
//   //         token: state.queryParams['token'] ?? '',
//   //       ),
//   //     );
//   //   },
//   // ),
// ];
