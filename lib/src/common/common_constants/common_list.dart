import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

const genderList = ["MALE", "FEMALE"];

const marriatalStatusList = ["MARRIED", "UNMARRIED"];

const titleList = ["Mr.", "Mrs.", "Ms.", "Miss.", "Dr."];

const addPpiToUserTitleList = ["Mr.", "Mrs.", "Ms."];

const employmentTypeList = ["EMPLOYED", "UNEMPLOYED"];

const userRoleList = ["ADMIN", "STAFF"];

const organizationTypeList = ["AXLERATE", "PARTNER", "LOGISTICS"];

const vehicleBalanceList = [
  DropDownValueModel(
    name: 'Customer Level Balance',
    value: 'CUSTOMER_LEVEL_BALANCE',
  ),
  DropDownValueModel(
    name: 'Vehicle Level Balance',
    value: 'VEHICLE_LEVEL_BALANCE',
  )
];

const omcList = [
  DropDownValueModel(name: 'HPCL-Drive Track Plus', value: 'HPCL'),
  // DropDownValueModel(name: 'BPCL-Drive Track Plus', value: 'BPCL')
];

const vehicleMakeList = [
  DropDownValueModel(
    name: 'AMW',
    value: 'AMW',
  ),
  DropDownValueModel(
    name: 'Ashok Leyland',
    value: 'ASHOK_LEYLAND',
  ),
  DropDownValueModel(
    name: 'Bajaj',
    value: 'BAJAJ_AUTO',
  ),
  DropDownValueModel(
    name: 'Bharat Benz',
    value: 'BHARAT_BENZ',
  ),
  DropDownValueModel(
    name: 'Caterpillar',
    value: 'CATERPILLAR',
  ),
  DropDownValueModel(
    name: 'Daimler',
    value: 'DAIMLER',
  ),
  DropDownValueModel(
    name: 'Eicher Motors',
    value: 'EICHER_MOTORS',
  ),
  DropDownValueModel(
    name: 'Force Motors',
    value: 'FORCE_MOTORS',
  ),
  DropDownValueModel(
    name: 'General Motors',
    value: 'GENERAL_MOTORS',
  ),
  DropDownValueModel(
    name: 'Hindustan Motors',
    value: 'HINDUSTAN_MOTORS',
  ),
  DropDownValueModel(
    name: 'Hino Motors',
    value: 'HINO_MOTORS',
  ),
  DropDownValueModel(
    name: 'International Tractors',
    value: 'INTERNATIONAL_TRACTORS',
  ),
  DropDownValueModel(
    name: 'Isuzu Motors',
    value: 'ISUZU_MOTORS',
  ),
  DropDownValueModel(
    name: 'Kamaz Motors',
    value: 'KAMAZ_MOTORS',
  ),
  DropDownValueModel(
    name: 'Mahindra & Mahindra',
    value: 'MAHINDRA_AND_MAHINDRA',
  ),
  DropDownValueModel(
    name: 'MAN',
    value: 'MAN_FORCE_TRUCKS',
  ),
  DropDownValueModel(
    name: 'Mercedes Benz',
    value: 'MERCEDES_BENZ',
  ),
  DropDownValueModel(
    name: 'Piaggio',
    value: 'PIAGGIO_VEHICLES',
  ),
  DropDownValueModel(
    name: 'Scania',
    value: 'SCANIA',
  ),
  DropDownValueModel(
    name: 'SML Isuzu',
    value: 'SML_ISUZU',
  ),
  DropDownValueModel(
    name: 'TAFE',
    value: 'TAFE_TRACTORS',
  ),
  DropDownValueModel(
    name: 'TATA',
    value: 'TATA_MOTORS',
  ),
  DropDownValueModel(
    name: 'TVS Motors',
    value: 'TVS_MOTORS',
  ),
  DropDownValueModel(
    name: 'Volvo',
    value: 'VOLVO_EICHER',
  ),
  DropDownValueModel(
    name: 'Others',
    value: 'OTHERS',
  ),
];

const vehicleProfileIdList = [
  DropDownValueModel(
    name: 'VC4 | Car, Jeep, Van | <7500 KGs | 2 Axle',
    value: '2',
  ),
  DropDownValueModel(
    name: 'VC20 | LCV | <7500 KGs | 2 Axle',
    value: '2',
  ),
  DropDownValueModel(
    name: 'VC5 | LCV | 7500-12000 KGs | 2 Axle',
    value: '2',
  ),
  DropDownValueModel(
    name: 'VC9 | MiniBus | 7500-12000 KGs | 2 Axle',
    value: '2',
  ),
  DropDownValueModel(
    name: 'VC8 | Bus | 16200-25000 KGs | 3 Axle',
    value: '3',
  ),
  DropDownValueModel(
    name: 'VC11 | Truck, LCV | 16200-25000 KGs | 3 Axle',
    value: '3',
  ),
  DropDownValueModel(
    name: 'VC7 | Bus | 12000-16200 KGs | 2 Axle',
    value: '2',
  ),
  DropDownValueModel(
    name: 'VC10 | Truck | 12000-16200 KGs | 2 Axle',
    value: '2',
  ),
  DropDownValueModel(
    name: 'VC12 | Truck | 25000-36600 KGs | 4 Axle',
    value: '4',
  ),
  DropDownValueModel(
    name: 'VC13 | Truck | 36600-45400 KGs | 5 Axle',
    value: '5',
  ),
  DropDownValueModel(
    name: 'VC14 | Truck | 45400-54200 KGs | 6 Axle',
    value: '6',
  ),
  DropDownValueModel(
    name: 'VC15 | Truck | >54200 KGs | 7 Axle & above',
    value: '7',
  ),
];

const kycStatusList = [
  'Approved',
  'Rejected',
];

final natureOfBusinessList = [
  "INDIVIDUAL".toUiCase,
  "SOLE_PROPRIETOR".toUiCase,
  "PARTNERSHIP".toUiCase,
  "PVT_LTD".toUiCase,
  "PUBLIC_LTD".toUiCase,
  "SCHOOL_TRUST_ASSOCIATIONS".toUiCase,
  "GOVT_BODY".toUiCase
];

final vehicleBalanceTypeList = [
  'CUSTOMER_LEVEL_BALANCE'.toUiCase,
  'VEHICLE_LEVEL_BALANCE'.toUiCase,
];

final typeOfBusinessList = [
  "SOLE_PROPRIETOR".toUiCase,
  "PARTNERSHIP".toUiCase,
  "PVT_LTD".toUiCase,
  "PROPREITOR".toUiCase,
];

const typeOfOrganizationList = [
  'Partner Organization',
  'Customer Organization',
];

const graphDataType = ["Year", "Month", "Week", "Day"];
const listOfStates = [
  "Andaman and Nicobar Islands",
  "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chandigarh",
  "Chhattisgarh",
  "Dadra and Nagar Haveli and Daman and Diu",
  "Delhi",
  "Goa",
  "Gujarat",
  "Haryana",
  "Himachal Pradesh",
  "Jammu and Kashmir",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Ladakh",
  "Lakshadweep",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Puducherry",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttar Pradesh",
  "Uttarakhand",
  "West Bengal"
];

const vehicleCategoryList = [
  'Scooter',
  'Motorcycle',
  'Car',
  'Jeep',
  'Van',
  'Light Commercial Vehicle',
  'Mini Bus',
  'Bus',
  'Truck',
  'Container Truck',
  'Trailer Truck',
  'Tanker Truck',
];

final vehicleFuelType = [
  "PETROL".toUiCase,
  "DIESEL".toUiCase,
  "CNG",
  "ELECTRIC".toUiCase,
];

// * Vehicle Mapper Class Lists
final vc4List = [
  const DropDownValueModel(
    name: 'MC4 | Car, Jeep, Van | <7500 KGs | 2 Axle',
    value: 'MC4 | Car, Jeep, Van | <7500 KGs | 2 Axle',
  ),
  const DropDownValueModel(
    name: 'MC20 | LCV | <7500 KGs | 2 Axle',
    value: 'MC20 | Light Commercial Vehicle | <7500 KGs | 2 Axle',
  ),
];

final vc5List = [
  const DropDownValueModel(
    name: 'MC5 | LCV | 7500-12000 KGs | 2 Axle',
    value: 'MC5 | Light Commercial Vehicle | 7500-12000 KGs | 2 Axle',
  ),
  const DropDownValueModel(
    name: 'MC9 | MiniBus | 7500-12000 KGs | 2 Axle',
    value: 'MC9 | MiniBus | 7500-12000 KGs | 2 Axle',
  ),
];

final vc6List = [
  const DropDownValueModel(
    name: 'MC8 | Bus | 16200-25000 KGs | 3 Axle',
    value: 'MC8 | Bus | 16200-25000 KGs | 3 Axle',
  ),
  const DropDownValueModel(
    name: 'MC11 | Truck, LCV | 16200-25000 KGs | 3 Axle',
    value: 'MC11 | Truck, Light Commercial Vehicle | 16200-25000 KGs | 3 Axle',
  ),
];
final vc7List = [
  const DropDownValueModel(
    name: 'MC7 | Bus | 12000-16200 KGs | 2 Axle',
    value: 'MC7 | Bus | 12000-16200 KGs | 2 Axle',
  ),
  const DropDownValueModel(
    name: 'MC10 | Truck | 12000-16200 KGs | 2 Axle',
    value: 'MC10 | Truck | 12000-16200 KGs | 2 Axle',
  ),
];

final vc12List = [
  const DropDownValueModel(
    name: 'MC12 | Truck | 25000-36600 KGs | 4 Axle',
    value: 'MC12 | Truck | 25000-36600 KGs | 4 Axle',
  ),
  const DropDownValueModel(
    name: 'MC13 | Truck | 36600-45400 KGs | 5 Axle',
    value: 'MC13 | Truck | 36600-45400 KGs | 5 Axle',
  ),
  const DropDownValueModel(
    name: 'MC14 | Truck | 45400-54200 KGs | 6 Axle',
    value: 'MC14 | Truck | 45400-54200 KGs | 6 Axle',
  ),
];
final vc15List = [
  const DropDownValueModel(
    name: 'MC15 | Truck | >54200 KGs | 7 Axle & above',
    value: 'MC15 | Truck | >54200 KGs | 7 Axle & above',
  ),
];
List<String> invoiceDocsList = [];
final invoiceDocsListOrigin = [
  'Articles of Association (AOA)',
  'Memorandum of Association (MOA)',
  'Board Resolution',
  'List of Directors / Partners from MCA',
  'Certification of Incorporation',
  'Partnership Deed',
  'Establishment Certificate',
  'Registration Certificate',
  'PAN of the Company/Firm',
  'GST Registration Certificate',
  'Undertaking of Product/Services to be Sold',
  'Current Address Proof of the Company/Firm',
  'KYC of Directors / Partners',
  'Service Agreement',
  'Cancellation Cheque',
  'Legal Opinion document',
  'Merchant Application Form (MAF)',
  'Bank Statement',
  'Certificate of Commencement of Business',
  'Others',
];
List<String> recentTransactionsHeaderItems = [
  "Date & Time",
  "Vehicle Reg. No.",
  "Toll Name",
  "Type",
  "Amount",
  "TXN Type"
];
