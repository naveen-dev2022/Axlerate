import 'package:auto_route/auto_route.dart';
import 'package:axlerate/router/app_router.gr.dart';
import 'package:axlerate/router/axle_route_path.dart';
import 'package:axlerate/router/guards/active_user_guard.dart';
import 'package:axlerate/router/guards/app_guard.dart';
import 'package:axlerate/router/guards/auth_guard.dart';
import 'package:axlerate/router/guards/authorize_user_for_org_guard.dart';
import 'package:axlerate/router/guards/partner_guard.dart';
import 'package:axlerate/router/guards/pending_user_guard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouterNewProvider = Provider<AppNewRouter>((ref) {
  return AppNewRouter(ref);
});

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppNewRouter extends $AppNewRouter {
  AppNewRouter(this.ref);

  final Ref ref;

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
            path: '/',
            page: AxleAutoRouter.page,
            initial: true,
            children: [
              //RedirectRoute(path: '', redirectTo: AxleRoutePath.auth),
              AutoRoute(
                path: 'auth',
                page: AuthBackground.page,
                guards: [AuthGuard(ref)],
                children: [
                  RedirectRoute(path: '', redirectTo: AxleRoutePath.login),
                  RedirectRoute(
                      path: 'login-with-otp', redirectTo: AxleRoutePath.login),
                  AutoRoute(
                    path: 'login',
                    page: LoginWithOtpForm.page,
                  ),
                  //AutoRoute(path: 'account-activation', page: AccountActivationRoute.page),
                ],
              ),

              // * Error Dashbaord
              CustomRoute(
                path: 'error-dashboard',
                page: ErrorDashbaord.page,
                transitionsBuilder: TransitionsBuilders.noTransition,
              ),

              CustomRoute(
                path: 'account-activation',
                page: AccountActiveRouter.page,
                guards: [PendingUserGuard(ref)],
                children: [
                  CustomRoute(
                    path: ':token',
                    page: AccountActivationRoute.page,
                    initial: true,
                    transitionsBuilder: TransitionsBuilders.noTransition,
                  ),
                ],
              ),

              CustomRoute(
                path: 'app',
                page: AxleScaffold.page,
                initial: true,
                transitionsBuilder: TransitionsBuilders.noTransition,
                guards: [AppGuard(ref)],
                children: [
                  // RedirectRoute(path: '', redirectTo: 'select-org'),
                  CustomRoute(
                    path: 'static-dashboard',
                    page: StaticDashbaord.page,
                    transitionsBuilder: TransitionsBuilders.noTransition,
                  ),
                  CustomRoute(
                    path: AxleRoutePath.profile,
                    page: ProfileRoute.page,
                    transitionsBuilder: TransitionsBuilders.noTransition,
                  ),
                  CustomRoute(
                    path: 'select-org',
                    page: SelectOrgnaizationRoute.page,
                    initial: true,
                    guards: [ActiveUserGuard(ref)],
                    transitionsBuilder: TransitionsBuilders.noTransition,
                  ),
                  CustomRoute(
                      path: ':selOrg',
                      page: SelectedOrgRoute.page,
                      transitionsBuilder: TransitionsBuilders.noTransition,
                      guards: [
                        AuthorizeUserForOrg(ref)
                      ],
                      children: [
                        //* Complete Registration Logistics
                        CustomRoute(
                          path: 'complete-registration',
                          page: CompleteInvitedLogistics.page,
                          transitionsBuilder: TransitionsBuilders.noTransition,
                        ),
                        CustomRoute(
                          path: 'dashboard',
                          page: OrgDashboardRoute.page,
                          initial: true,
                          transitionsBuilder: TransitionsBuilders.noTransition,
                        ),
                        // --** Partners Path **-- //
                        CustomRoute(
                          path: 'partners',
                          page: AxlePartnersRouter.page,
                          transitionsBuilder: TransitionsBuilders.noTransition,
                          children: [
                            RedirectRoute(path: '', redirectTo: 'list'),
                            CustomRoute(
                              path: 'list',
                              page: ListPartnerRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'create',
                              page: CreatePartnerRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: ':partnerId',
                              page: SelectedPartnerRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                              guards: [PartnerByIdResolver(ref)],
                              children: [
                                CustomRoute(
                                  path: 'dashboard',
                                  page: PartnerDashboard.page,
                                  initial: true,
                                  transitionsBuilder:
                                      TransitionsBuilders.noTransition,
                                ),
                              ],
                            ),
                          ],
                        ),
                        // --** Customers Path **-- //
                        CustomRoute(
                            path: 'customers',
                            page: AxleCustomersRouter.page,
                            transitionsBuilder:
                                TransitionsBuilders.noTransition,
                            children: [
                              RedirectRoute(path: '', redirectTo: 'list'),
                              CustomRoute(
                                path: 'list',
                                page: ListLogisticsRoute.page,
                                transitionsBuilder:
                                    TransitionsBuilders.noTransition,
                              ),
                              CustomRoute(
                                path: 'create',
                                page: CreateLogisticsRoute.page,
                                transitionsBuilder:
                                    TransitionsBuilders.noTransition,
                              ),
                              CustomRoute(
                                path: 'invite',
                                page: InviteLogisticsRoute.page,
                                transitionsBuilder:
                                    TransitionsBuilders.noTransition,
                              ),
                              CustomRoute(
                                  path: ':custId',
                                  page: SelectedCustomerRoute.page,
                                  transitionsBuilder:
                                      TransitionsBuilders.noTransition,
                                  children: [
                                    CustomRoute(
                                      path: 'dashboard',
                                      page: LogisticsOrganisationByEnrolmentId
                                          .page,
                                      initial: true,
                                      transitionsBuilder:
                                          TransitionsBuilders.noTransition,
                                    ),
                                    CustomRoute(
                                        path: 'payments',
                                        page: AxlePaymentRouter.page,
                                        transitionsBuilder:
                                            TransitionsBuilders.noTransition,
                                        children: [
                                          CustomRoute(
                                            path: 'list',
                                            page: PaymentsRoute.page,
                                            initial: true,
                                            transitionsBuilder:
                                                TransitionsBuilders
                                                    .noTransition,
                                          ),
                                          CustomRoute(
                                            path: 'create',
                                            page: CreatePaymentRoute.page,
                                            transitionsBuilder:
                                                TransitionsBuilders
                                                    .noTransition,
                                          ),
                                        ]),
                                    CustomRoute(
                                      path: 'org-card-preference',
                                      page: SetOrgPPIPreferenceRoute.page,
                                      // guards: [PPIServiceEnabledGuard(ref)],
                                      transitionsBuilder:
                                          TransitionsBuilders.noTransition,
                                    ),
                                    CustomRoute(
                                      path: 'org-card-fuel-preference',
                                      page:
                                          SetLogisticsFuelPreferenceRoute.page,
                                      // guards: [FuelServiceEnabledGuard(ref)],
                                      transitionsBuilder:
                                          TransitionsBuilders.noTransition,
                                    ),
                                    CustomRoute(
                                      path: 'details',
                                      page: LogisticsDetailedRoute.page,
                                      transitionsBuilder:
                                          TransitionsBuilders.noTransition,
                                    ),
                                    CustomRoute(
                                      path: 'services',
                                      page: AddAxleServiceRoute.page,
                                      transitionsBuilder:
                                          TransitionsBuilders.noTransition,
                                    ),
                                    CustomRoute(
                                      path: 'fund-transfer',
                                      page: FundTransferRoute.page,
                                      transitionsBuilder:
                                          TransitionsBuilders.noTransition,
                                    ),
                                    CustomRoute(
                                      path: 'vehicle-analytics',
                                      page: VehicleWiseUsageRoute.page,
                                      transitionsBuilder:
                                          TransitionsBuilders.noTransition,
                                    ),
                                    CustomRoute(
                                      path: 'vehicles',
                                      page: VehicleRouter.page,
                                      transitionsBuilder:
                                          TransitionsBuilders.noTransition,
                                      children: [
                                        CustomRoute(
                                          path: 'list',
                                          page: ListVehicleByCustomer.page,
                                          initial: true,
                                          transitionsBuilder:
                                              TransitionsBuilders.noTransition,
                                        ),
                                        CustomRoute(
                                            path: ':vehicleRegNo',
                                            page: SelectedVehicle.page,
                                            transitionsBuilder:
                                                TransitionsBuilders
                                                    .noTransition,
                                            children: [
                                              CustomRoute(
                                                path: 'dashboard',
                                                page: VehicleDashboard.page,
                                                initial: true,
                                                transitionsBuilder:
                                                    TransitionsBuilders
                                                        .noTransition,
                                              ),
                                              CustomRoute(
                                                path: 'vehicle-fund-load',
                                                page: VehicleFundLoadRoute.page,
                                                transitionsBuilder:
                                                    TransitionsBuilders
                                                        .noTransition,
                                              ),
                                              CustomRoute(
                                                path: 'services',
                                                page: EnableVehicleServiceRoute
                                                    .page,
                                                transitionsBuilder:
                                                    TransitionsBuilders
                                                        .noTransition,
                                              ),
                                              CustomRoute(
                                                path: 'details',
                                                page: VehicleDetailedRoute.page,
                                                transitionsBuilder:
                                                    TransitionsBuilders
                                                        .noTransition,
                                              ),
                                              CustomRoute(
                                                path: 'gps',
                                                page: GpsDetailRoute.page,
                                                transitionsBuilder:
                                                    TransitionsBuilders
                                                        .noTransition,
                                              ),
                                              CustomRoute(
                                                path: 'manage-tag',
                                                page: VehicleManageFastag.page,
                                                transitionsBuilder:
                                                    TransitionsBuilders
                                                        .noTransition,
                                              ),
                                              CustomRoute(
                                                path:
                                                    'vehicle-fuel-card-preference',
                                                page:
                                                    SetVehicleFuelPreferenceRoute
                                                        .page,
                                                transitionsBuilder:
                                                    TransitionsBuilders
                                                        .noTransition,
                                              ),
                                            ])
                                      ],
                                    ),
                                    CustomRoute(
                                        path: 'staffs',
                                        page: StaffRouter.page,
                                        transitionsBuilder:
                                            TransitionsBuilders.noTransition,
                                        children: [
                                          CustomRoute(
                                              path: 'list',
                                              page: ListUsersRoute.page,
                                              transitionsBuilder:
                                                  TransitionsBuilders
                                                      .noTransition,
                                              initial: true),
                                          CustomRoute(
                                            path: 'user-not-found',
                                            page: UserNotFoundRoute.page,
                                            transitionsBuilder:
                                                TransitionsBuilders
                                                    .noTransition,
                                          ),
                                          CustomRoute(
                                              path: ':staffEnrolId',
                                              page: SelectedStaffRoute.page,
                                              transitionsBuilder:
                                                  TransitionsBuilders
                                                      .noTransition,
                                              children: [
                                                CustomRoute(
                                                    path: 'dashboard',
                                                    page:
                                                        UserChildDashboard.page,
                                                    transitionsBuilder:
                                                        TransitionsBuilders
                                                            .noTransition,
                                                    initial: true),
                                                CustomRoute(
                                                  path: 'manage-card',
                                                  page: ManageCardRoute.page,
                                                  transitionsBuilder:
                                                      TransitionsBuilders
                                                          .noTransition,
                                                ),
                                                CustomRoute(
                                                  path: 'add-services',
                                                  page: AddUserService.page,
                                                  transitionsBuilder:
                                                      TransitionsBuilders
                                                          .noTransition,
                                                ),
                                              ])
                                        ])
                                  ])
                            ]),
                        CustomRoute(
                            path: 'staffs',
                            page: AxleStaffsRouter.page,
                            transitionsBuilder:
                                TransitionsBuilders.noTransition,
                            children: [
                              CustomRoute(
                                path: 'list',
                                page: ListUsersRoute.page,
                                initial: true,
                                transitionsBuilder:
                                    TransitionsBuilders.noTransition,
                              ),
                              CustomRoute(
                                path: 'create',
                                page: CreateUserRoute.page,
                                transitionsBuilder:
                                    TransitionsBuilders.noTransition,
                              ),
                            ]),
                        CustomRoute(
                            path: 'commissions',
                            page: AxlePartnerCommissionRouter.page,
                            transitionsBuilder:
                                TransitionsBuilders.noTransition,
                            children: [
                              CustomRoute(
                                path: '',
                                page: CommissionHistoryRoute.page,
                                initial: true,
                                transitionsBuilder:
                                    TransitionsBuilders.noTransition,
                              ),
                            ]),
                        CustomRoute(
                          path: 'transactions',
                          page: TransactionHistoryRoute.page,
                          transitionsBuilder: TransitionsBuilders.noTransition,
                        ),
                        CustomRoute(
                            path: 'gps-manage',
                            page: AxleGpsRouter.page,
                            transitionsBuilder:
                                TransitionsBuilders.noTransition,
                            children: [
                              CustomRoute(
                                path: 'list',
                                page: ListGpsDevices.page,
                                initial: true,
                                transitionsBuilder:
                                    TransitionsBuilders.noTransition,
                              ),
                              CustomRoute(
                                path: 'add-device',
                                page: AddGpsDevices.page,
                                transitionsBuilder:
                                    TransitionsBuilders.noTransition,
                              ),
                            ]),
                        CustomRoute(
                            path: 'gps-manage',
                            page: AxleGpsRouter.page,
                            transitionsBuilder:
                                TransitionsBuilders.noTransition,
                            children: [
                              CustomRoute(
                                path: 'list',
                                page: ListGpsDevices.page,
                                initial: true,
                                transitionsBuilder:
                                    TransitionsBuilders.noTransition,
                              ),
                              CustomRoute(
                                path: 'add-device',
                                page: AddGpsDevices.page,
                                transitionsBuilder:
                                    TransitionsBuilders.noTransition,
                              ),
                            ]),
                        CustomRoute(
                          path: 'invoice',
                          page: CreateInvoice.page,
                          transitionsBuilder: TransitionsBuilders.noTransition,
                          children: [
                            CustomRoute(
                              path: 'create',
                              page: CreateInvoice.page,
                              initial: true,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                          ],
                        ),
                        CustomRoute(
                          path: 'vehicles',
                          page: AxleVehiclesRouter.page,
                          transitionsBuilder: TransitionsBuilders.noTransition,
                          children: [
                            RedirectRoute(path: '', redirectTo: 'list'),
                            CustomRoute(
                              path: 'list',
                              page: ListVehiclesRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'create',
                              page: CreateVehicleRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                          ],
                        ),
                        CustomRoute(
                          path: 'e-card-verification',
                          page: ECardVerificationRouter.page,
                          transitionsBuilder: TransitionsBuilders.noTransition,
                          children: [
                            CustomRoute(
                              path: 'dashboard',
                              page: EcardVerificationDashboard.page,
                              initial: true,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'search-home',
                              page: SearchDashboardHome.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'challan-initial',
                              page: ChallanInitialRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'challan-history',
                              page: ChallanHistory.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'challan',
                              page: ChallanRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'rc-verification',
                              page: RcRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'rc-details',
                              page: RcDetailRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'rc-history',
                              page: RcHistoryRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'pan-screen',
                              page: PanInitialRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'pan-history',
                              page: PanHistoryRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'pan-details',
                              page: PanRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'aadhaar',
                              page: AadharRouteInitial.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'aadhaar-otp',
                              page: AadharOtpRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'aadhaar-history',
                              page: AadharHistoryRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'aadhaar-detail',
                              page: AadhaarRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'driving-license',
                              page: DrivingLicenseInitial.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'driving-license-history',
                              page: DrHistory.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'driving-license-detail',
                              page: DrivingLicenseRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'credit-score',
                              page: CreditScoreInitial.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                            CustomRoute(
                              path: 'credit-score-detail',
                              page: CibilRoute.page,
                              transitionsBuilder:
                                  TransitionsBuilders.noTransition,
                            ),
                          ],
                        ),
                      ]),
                ],
              ),
            ])
      ];
}
