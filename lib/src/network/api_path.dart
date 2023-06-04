class ApiPath {
  static const login = '/login';
  static const logout = '/logout';
  static const user = '/user';
  static const loginWithOtp = '/login-with-otp';
  static const verifyOtp = '/verify-otp';
  static const changePassword = '/password/change';
  static const uploadLogisticsOrgLogo = '/logistics/upload-org-logo';
  static const uploadProfilePic = '/upload-profile-pic';
  static const userProfile = '/profile';
  static const passwordChange = '/password/change';
  static const accessToken = '/accessToken';
  static const generateOtp = '/generate-otp';
  static const setNewPassword = '/password/forgot/set';
  static const activateAccount = '/activate';
  static const verifyGenerateOtp = '/verify-generate-otp';
  static const partner = '/partner';
  static const logistics = '/logistics';
  static const invite = '/invite';
  static const updateInvitedOrg = '/update-invited-org';
  static const lastDebitTxn = '/lastDebitTransaction';
  static const listOrganization = '/listOrganization';
  static const listOrganizationByType = '/listOrganizationByType';
  static const listUser = '/listUser';
  static const userByEnrolmentId = '/getUserByUserEnrolmentId';
  static const ppiGenerateOtp = '/ppi-generate-otp';
  static const addPpiService = '/add-ppi-service';
  static const deactivate = '/deactivate';
  static const reactivate = '/reactivate';
  static const addService = '/addService';
  static const retryPpiCorporate = '/retry-ppi-corporate';
  static const fetchBalance = '/fetch-balance';
  static const getCardPciWidget = '/get-card-pci-widget';
  static const getCardStatus = '/get-card-status';
  static const loadFund = '/loadFund';
  static const fundLoad = '/fundLoad';
  static const vehicleGpsInfo = '/vehicleGpsInfo';
  static const vehicleGpsAccountInfo = '/vehicleGpsAccountInfo';
  static const tripHistory = '/trip-history';
  static const checkOrgCodeAvailability = '/checkOrgCodeAvailability';
  static const vehicle = '/vehicle';
  static const listVehicle = '/listVehicle';
  static const setPreference = '/set-preference';
  static const setPreferenceLimit = '/set-preference-limit';
  static const setPinPciWidget = '/set-pin-pci-widget';
  static const vKycLink = '/vkyc-link';
  static const lqtagvkyclink = '/lqtag-vkyc-link';
  static const lockUnlockCard = '/lock-unlock-card';
  static const fetchPreference = '/fetch-preference';
  static const changeUserRole = '/changeUserRole';
  static const updateCardPreference = '/updateCardPreference';
  static const getOrgById = '/getOrganizationById';
  static const getPpiAccountInfoById = '/getPpiAccountInformationById';
  static const logisticGpsInfo = '/logisticsGpsInfo';
  static const listPpiTransactions = '/list-ppi-transaction';
  static const addTagService = '/addTagService';
  static const addLqtagService = '/initiate-lqtag-service';
  static const getTagClass = '/getTagClass';
  static const setGpsDevice = '/setGpsDevice';
  static const getVehicleById = '/getVehicleById';
  static const getVehicleByRegistrationNumber = '/getVehicleByRegistrationNumber';
  static const logOrg = '/logistics-org';
  static const lqAccInfo = '/lqtag-acc-info';
  static const addLqTagService = '/add-lqtag-service';
  static const lqTagGenerateOtp = '/lqtag-generate-otp';
  static const getLqAccInfoByEnrollId = '/getLqtagAccountInformationByEnrollmentId';
  static const countInfo = '/count-info';
  static const accountInfo = '/acc-info';
  static const ppiAccountInfo = '/ppi-acc-info';
  static const listGpsDevices = '/listGpsDevices';
  static const addGpsDevices = '/addGpsImei';
  static const tagRewards = '/tag-rewards';
  static const ppiRewards = '/ppi-rewards';
  static const tagAnalytics = '/tag-analytics';
  static const ppiAnalytics = '/ppi-analytics';
  static const superAdmin = '/super-admin';
  static const allocateGpsDevices = '/addGpsOrg';
  static const gpsValue = '/value-data';
  static const modifyTruckType = '/modifyTruckType';
  static const updateVehicleThreshold = '/updateVehicleThreshold';
  static const requestInvoice = 'request-invoice';
  static const enableInvoice = 'enable-invoice';
  static const createCharge = 'create-charge';
  static const listPaymentlink = 'list-payment-link';
  static const paymentLink = 'payment-link';
  static const dropPaymentLink = 'drop-payment-link';
  static const invoiceCustomer = 'invoice-customer';

  static const partnerDashTagRewardUnencodedPath = '/api/dashboard/partner/tag-rewards';
  static const partnerDashPpiRewardUnencodedPath = '/api/dashboard/partner/ppi-rewards';
  static const partnerDashLqTagRewardUnencodedPath = '/api/dashboard/partner/lqtag-rewards';

  static const partnerDashTagAnalyticsUnencodedPath = '/api/dashboard/partner/tag-analytics';
  static const partnerDashPpiAnalyticsUnencodedPath = '/api/dashboard/partner/ppi-analytics';

  static const userApiUnencodedPath = '/api/user';
  static const listUserByUserOrgIdUnencodedPath = '/listUserByUserOrgId';

  static const updateGpsnotifications = '/setGpsDeviceNotifications';

  static const listUserByUserOrgEnrolIdUnencodedPath = '/listUserByOrgEnrolmentId';

  static const states = '/getStates';
  static const cities = '/getCities';
  static const addFuelServiceToLogOrg = '/addFuelServiceToLogOrg';
  static const updateOperatorInfo = '/updateOperatorInfo';
  static const addFuelServiceToVehicle = '/addFuelServiceToVehicle';
  static const updateVehicle = '/updateVehicle';
  static const verifyOrgKyc = '/verifyOrgKyc';
  static const verifyVehKyc = '/verifyVehKyc';
  static const fetchLimit = '/fetchLimit';
  static const fetchBalanceFuel = '/fetchBalance';
  static const setLimitOrganization = '/setLimitOrganization';
  static const setLimitVehicle = '/setLimitVehicle';
  static const manageDriverMapping = '/manageDriverMapping';
  static const fetchVehicleStatus = '/fetchVehicleStatus';
  static const cardLoad = '/cardLoad';
  static const cardWithDraw = '/cardWithDraw';
  static const addFundsToVehicleWallet = '/AddFundsToVehicleWallet';
  static const approveDeclineVehicleTagService = '/approve-decline-lqtag-service';

  static const listlqtagserviceusers = '/list-lqtag-service-users';
  static const retryLqTagService = '/retry-lqtag-service';

  static const fileDownloadSignedUrl = '/file-download-signed-url';
  static const fileUploadSignedUrl = '/file-upload-signed-url';
  static const retryAddFuelServiceToLogOrg = '/retryAddFuelServiceToLogOrg';
  static const listLqTagVehicles = '/list-lqtag-vehicles';

  static const addFuelServiceToDriver = '/addFuelServiceToDriver';
  static const fundLoadCorporateToUser = '/fund-load-corporate-user';
  static const fundLoadUserToCorporate = '/fund-load-user-corporate';
  static const fundLoadUserToUser = '/fund-load-user-user';
  static const retryAddFuelServiceToDriver = '/retryAddFuelServiceToDriver';
  static const organizationAccountInformation = '/organization-account-information';
  static const getUserBalance = '/get-user-balance';
  static const listFuelServiceEnabledUsers = '/listFuelServiceEnabledUsers';

  static const addBusinessConfigWithFuelLimits = '/addBusinessConfigWithFuelLimits';

  //Dashboard
  static const logisticsOrgDashCount = '/logistics-org/count-info';
  static const superAdminDashCount = '/super-admin/count-info';
  static const vehicleAccountInfo = '/vehicle/acc-info';
  static const ppiAccountInfoDash = '/logistics-org/ppi-acc-info';
  static const ybTagAccountInfoDash = '/logistics-org/acc-info';
  static const lqTagAccountInfoDash = '/logistics-org/lqtag-acc-info';
  static const lqtagCorporateAccountInfoDash = '/logistics-org/lqtag-corporate-acc-info';
  static const partnerOrgCountInfoDash = '/partner/count-info';
  static const fuelAccInfo = '/fuel-acc-info';

  const ApiPath._();
}
