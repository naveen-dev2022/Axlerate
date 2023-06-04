import 'package:axlerate/src/common/common_models/label_value_model.dart';

class HomeConstants {
  static const customers = 'Customers';
  static const partners = 'Partners';
  static const vehicles = 'Vehicles';
  static const staffs = 'Staffs';
  static const createVehicle = 'Create Vehicle';
  static const createPartner = 'Create Partner';
  static const addPartner = 'Add Partner';
  static const createCustomer = 'Create Customer';
  static const createStaff = 'Create Staff';
  static const enablePayments = 'Enable Payments';
  static const createPayment = 'Create Payment';

  static const payments = 'Payments';

  static const manageCard = 'Manage Card';
  static const orgCardPreference = 'Organization Card Preference';
  static const vehicleFuelCardPreference = 'Vehicle Fuel And Wallet Preference';
  static const organizationFuelCardPreference = 'Organization Fuel And Wallet Preference';

  // * Cards
  static const cardServices = 'Card Services';
  static const transactionSettings = 'Transaction Settings';

  static const uploadKycDocs = 'Upload KYC Documents';

  //*  Filter Strings
  static const filters = 'Filters';
  static const registrationStatus = 'Registration Status';
  static const natureOfBusiness = 'Nature of Business';
  static const userOnBoardStatus = 'User Onboarding Status';
  static const ppiCardStatus = 'PPI Card Status';
  static const roleOfUser = 'Role of User';
  static const cardHolder = 'Card Holder';
  static const balanceAmount = 'Balance Amount';
  static const tagKycStatus = 'Tag KYC Status';
  static const tagStatus = 'Tag Status';
  static const balanceType = 'Balance Type';
  static const fuelType = 'Fuel Type';

  static const state = 'State';
  static const sortBy = 'Sort by';

  // PPI
  static const kitNumber = 'KIT Number';
  static const prepaidCard = 'Prepaid Card';
  static const primaryDetails = 'Primary Details';
  static const personalDetails = 'Personal Details of Card Holder';
  static const kitNumberMandatoryText =
      'Fill the Kit Details as per the Welcome Kit (All fields marked* are mandatory!)';
  static const permanentAddress = 'Permanent Address';
  static const addressAsPerAadhar = 'Address as per Aadhar';

  static const communicationAddress = 'Communication Address';
  static const communicationAddressHintText =
      'Fill the Communication Address Details as per your ID Proof (All fields marked* are mandatory!)';
  static const clickIfSameAsPermanentAddress = 'Click if same as Permanent Address';

  static const communicationInfo = 'Communication Info';
  static const showFilters = 'Show Filters';

  // Button Texts
  static const cancelBT = 'CANCEL';
  static const submitBT = 'SUBMIT';
  static const reSubmitBT = 'RESUBMIT';
  static const addPrepaidCardBT = 'Add Prepaid Card';
  static const addServicesBT = 'Add Services';

  // User popup menu Text
  static const deactivateUser = 'Deactivate User';
  static const reactivateUser = 'Reactivate User';
  static const switchRole = 'Switch Role';

  static const yesNoList = [
    LabelValueModel(label: 'Yes', value: 'YES'),
    LabelValueModel(label: 'No', value: 'NO'),
  ];
  static const gender = [
    LabelValueModel(label: 'Male', value: 'MALE'),
    LabelValueModel(label: 'Female', value: 'FEMALE'),
    LabelValueModel(label: 'Others', value: 'OTHERS'),
  ];

  static const marriatelStatus = [
    LabelValueModel(label: 'Married', value: 'MARRIED'),
    LabelValueModel(label: 'Unmarried', value: 'UNMARRIED'),
  ];
  static const employmentType = [
    LabelValueModel(label: 'Employed', value: 'EMPLOYED'),
    LabelValueModel(label: 'UnEmployed', value: 'UNEMPLOYED'),
  ];

  static const fillDetails = 'Fill the Details';
  static const fillOrgDetails = 'Fill the Organization Details';

  // Add User Form Headings
  static const organizationDetails = 'Organization Details';
  static const userDetails = 'User Details';

  // Add Vehicle Form Headings
  static const customerDetails = 'Customer Details';
  static const vehicleDetails = 'Vehicle Details';

  // Staff child Dashboard
  static const cardBalance = 'Card Balance';

  // No Data or Error Page Strings

  static const welcome = 'Welcome!';
  static const listCustomerEmptyStrWithParams = 'No Results Found. Try changing the filters.';

  static const listCustomerEmptyStr = 'It\'s empty here. Start adding Customers to view them here.';
  static const listPartnerEmptyStr = 'It\'s empty here. Start adding Partners to view them here.';
  static const welcomeToAxlerateStr = 'We\'re glad to have you on Axlerate.';
  static const logisticStaffDashEmptyStr =
      'We\'re glad to have you on Axlerate.\nAxlerate services that are enabled will appear here.';
  static const listVehiclesStr = 'It’s empty here. Start adding Vehicles to view them here.';
  static const noTxnStr = 'No Transactions found?';
  static const noDataFoundStr = 'No Data Found!';

  static const somethingWentWrong = 'Something went wrong!';

  static const noTxnTrailingStr = 'Make Transactions to see them here.';

  static const underMaintenanceStr = "Under Maintenance";

  HomeConstants._();
}
