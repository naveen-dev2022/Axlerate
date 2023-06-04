import 'dart:convert';
/// statuscode : 200
/// status : true
/// message : "Success!"
/// data : {"Equifax_Report":{"InquiryResponseHeader":{"ClientID":"027FP27964","CustRefField":"DB-P23030267","ReportOrderNO":"768987942","ProductCode":["PCRLT"],"SuccessCode":"1","Date":"2023-03-28","Time":"14:01:58"},"InquiryRequestInfo":{"InquiryPurpose":"16","FirstName":"ABCDEFG","LastName":"XYZAB","InquiryPhones":[{"seq":"1","PhoneType":["M"],"Number":"9999999999"}],"IDDetails":[{"seq":"1","IDType":"t","IDValue":"JDKNB0937J","Source":"Inquiry"}]},"Score":[{"Type":"ERS","Version":"3.1"}],"CCRResponse":{"Status":"1","CIRReportDataLst":[{"InquiryResponseHeader":{"CustomerCode":"AFIB","CustRefField":"DB-P23030267","ReportOrderNO":"768987942","TranID":"4682185901","ProductCode":["PCRLT"],"SuccessCode":"1","Date":"2023-03-28","Time":"14:01:57","HitCode":"10","CustomerName":"AFIB"},"InquiryRequestInfo":{"InquiryPurpose":"Fleet Card","FirstName":"ABCDEFG","LastName":"XYZAB","InquiryPhones":[{"seq":"1","PhoneType":["M"],"Number":"9999999999"}],"IDDetails":[{"seq":"1","IDType":"t","IDValue":"JDKNB0937J","Source":"Inquiry"}],"CustomFields":[{"key":"INQUERY_PRODUCT_CODE","value":"PCRLT"}]},"Score":[{"Type":"ERS","Version":"3.1"}],"CIRReportData":{"IDAndContactInfo":{"PersonalInfo":{"Name":{"FullName":"ABCDEFG JKLM NOP ","FirstName":"ABCDEFG ","LastName":"NOP "},"DateOfBirth":"2000-11-09","Gender":"Male","Age":{"Age":"22"}},"IdentityInfo":{"PANId":[{"seq":"1","ReportedDate":"2022-12-31","IdNumber":"JDKNB0937J"}],"NationalIDCard":[{"seq":"1","ReportedDate":"2021-02-28","IdNumber":"XXXXXXXXXXXX"}]},"AddressInfo":[{"Seq":"1","ReportedDate":"2022-12-31","Address":"HOUSE NO 94 XXXXXXXX SXXXX  XXXXX XXXXXXX","State":"OR","Postal":"99999"},{"Seq":"2","ReportedDate":"2022-11-30","Address":"XXXXXXXXXXXXXXXXXXXXX","State":"DL","Postal":"110015","Type":"Office"},{"Seq":"3","ReportedDate":"2022-08-31","Address":"XXXXXXXXXXXXX","State":"OR","Postal":"761119"},{"Seq":"4","ReportedDate":"2022-03-31","Address":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","State":"OR","Postal":"000009","Type":"Primary"},{"Seq":"5","ReportedDate":"2021-10-01","Address":"XXXXXXXXXXXXXXXX","state":"or","postal":"999999","type":"primary"}],"phoneinfo":[{"seq":"1","typecode":"m","reporteddate":"2022-12-31","number":"9348412533"},{"seq":"2","typecode":"m","reporteddate":"2022-11-30","number":"919348412533"}],"emailaddressinfo":[{"seq":"1","reporteddate":"2022-11-30","emailaddress":"mailto:abcd@gmail.com"}]},"RetailAccountDetails":[{"seq":"1","AccountNumber":"EHNJ00000760858","Institution":"XYZ Bank","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"1600","LastPaymentDate":"2023-01-31","DateReported":"2023-02-01","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"02-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"2","AccountNumber":"0000000006601","Institution":"HFJJ Bank","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"1048","PastDueAmount":"0","Open":"Yes","HighCredit":"1622","DateReported":"2023-01-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"3","AccountNumber":"00000000E000760858","Institution":"ABCD Private Limited","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"400","LastPaymentDate":"2023-01-31","DateReported":"2023-01-31","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"4","AccountNumber":"000000004137078","Institution":"HJKL Bank Ltd.","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"3303","PastDueAmount":"0","LastPayment":"6104","WriteOffAmount":"0","Open":"Yes","HighCredit":"3154","LastPaymentDate":"2023-01-20","DateReported":"2023-01-31","DateOpened":"2022-11-07","CreditLimit":"15000","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"5","AccountNumber":"00000087","Institution":"PMJK Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"24769","Open":"Yes","SanctionAmount":"70000","LastPaymentDate":"2022-11-02","DateReported":"2022-11-30","DateOpened":"2020-01-11","RepaymentTenure":"48","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"6","AccountNumber":"0000057309","Institution":"JKLM Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"5964","Open":"Yes","SanctionAmount":"5599","LastPaymentDate":"2022-07-02","DateReported":"2022-11-30","DateOpened":"2021-09-29","RepaymentTenure":"6","InstallmentAmount":"994","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"7","AccountNumber":"00000007878920400000","Institution":"JKLM (Mauritius) Ltd","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"200","PastDueAmount":"0","Open":"Yes","HighCredit":"200","DateReported":"2022-03-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"03-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]}],"RetailAccountsSummary":{"NoOfAccounts":"7","NoOfActiveAccounts":"7","NoOfWriteOffs":"0","TotalPastDue":"0.00","MostSevereStatusWithIn24Months":"30+","SingleHighestCredit":"3154.00","SingleHighestSanctionAmount":"70000.00","TotalHighCredit":"4976.00","AverageOpenBalance":"650.14","SingleHighestBalance":"3303.00","NoOfPastDueAccounts":"0","NoOfZeroBalanceAccounts":"4","RecentAccount":"Credit Card on 07-11-2022","OldestAccount":"Personal Loan on 11-01-2020","TotalBalanceAmount":"4551.00","TotalSanctionAmount":"77599.00","TotalCreditLimit":"23800.0","TotalMonthlyPaymentAmount":"994.00"},"ScoreDetails":[{"Type":"ERS","Version":"3.1","Name":"Equifax Risk Score","Value":"728","ScoringElements":[{"type":"RES","seq":"1","Description":"Number of product trades"},{"type":"RES","seq":"2","code":"2b","Description":"Delinquency or past due amount occurences"},{"type":"RES","seq":"3","code":"5b","Description":"Balance amount of home loan trades"},{"type":"RES","seq":"4","code":"8a","Description":"Sanctioned amount of or lack of credit card trades"}]}],"EnquirySummary":{"Purpose":"ALL","Total":"0","Past30Days":"0","Past12Months":"0","Past24Months":"0"},"OtherKeyInd":{"AgeOfOldestTrade":"38","NumberOfOpenTrades":"7","AllLinesEVERWritten":"0.00","AllLinesEVERWrittenIn9Months":"0","AllLinesEVERWrittenIn6Months":"0"},"RecentActivities":{"AccountsDeliquent":"0","AccountsOpened":"0","TotalInquiries":"0","AccountsUpdated":"4"}}}]}},"statusCode":"200"}
/// reference_id : 20231576

CibilDetailEntity cibilDetailEntityFromJson(String str) => CibilDetailEntity.fromJson(json.decode(str));
String cibilDetailEntityToJson(CibilDetailEntity data) => json.encode(data.toJson());
class CibilDetailEntity {
  CibilDetailEntity({
      num? statuscode, 
      bool? status, 
      String? message, 
      Data? data, 
      num? referenceId,}){
    _statuscode = statuscode;
    _status = status;
    _message = message;
    _data = data;
    _referenceId = referenceId;
}

  CibilDetailEntity.unknown() : _data = null;


  CibilDetailEntity.fromJson(dynamic json) {
    _statuscode = json['statuscode'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _referenceId = json['reference_id'];
  }
  num? _statuscode;
  bool? _status;
  String? _message;
  Data? _data;
  num? _referenceId;
CibilDetailEntity copyWith({  num? statuscode,
  bool? status,
  String? message,
  Data? data,
  num? referenceId,
}) => CibilDetailEntity(  statuscode: statuscode ?? _statuscode,
  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
  referenceId: referenceId ?? _referenceId,
);
  num? get statuscode => _statuscode;
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;
  num? get referenceId => _referenceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statuscode'] = _statuscode;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['reference_id'] = _referenceId;
    return map;
  }

}

/// Equifax_Report : {"InquiryResponseHeader":{"ClientID":"027FP27964","CustRefField":"DB-P23030267","ReportOrderNO":"768987942","ProductCode":["PCRLT"],"SuccessCode":"1","Date":"2023-03-28","Time":"14:01:58"},"InquiryRequestInfo":{"InquiryPurpose":"16","FirstName":"ABCDEFG","LastName":"XYZAB","InquiryPhones":[{"seq":"1","PhoneType":["M"],"Number":"9999999999"}],"IDDetails":[{"seq":"1","IDType":"t","IDValue":"JDKNB0937J","Source":"Inquiry"}]},"Score":[{"Type":"ERS","Version":"3.1"}],"CCRResponse":{"Status":"1","CIRReportDataLst":[{"InquiryResponseHeader":{"CustomerCode":"AFIB","CustRefField":"DB-P23030267","ReportOrderNO":"768987942","TranID":"4682185901","ProductCode":["PCRLT"],"SuccessCode":"1","Date":"2023-03-28","Time":"14:01:57","HitCode":"10","CustomerName":"AFIB"},"InquiryRequestInfo":{"InquiryPurpose":"Fleet Card","FirstName":"ABCDEFG","LastName":"XYZAB","InquiryPhones":[{"seq":"1","PhoneType":["M"],"Number":"9999999999"}],"IDDetails":[{"seq":"1","IDType":"t","IDValue":"JDKNB0937J","Source":"Inquiry"}],"CustomFields":[{"key":"INQUERY_PRODUCT_CODE","value":"PCRLT"}]},"Score":[{"Type":"ERS","Version":"3.1"}],"CIRReportData":{"IDAndContactInfo":{"PersonalInfo":{"Name":{"FullName":"ABCDEFG JKLM NOP ","FirstName":"ABCDEFG ","LastName":"NOP "},"DateOfBirth":"2000-11-09","Gender":"Male","Age":{"Age":"22"}},"IdentityInfo":{"PANId":[{"seq":"1","ReportedDate":"2022-12-31","IdNumber":"JDKNB0937J"}],"NationalIDCard":[{"seq":"1","ReportedDate":"2021-02-28","IdNumber":"XXXXXXXXXXXX"}]},"AddressInfo":[{"Seq":"1","ReportedDate":"2022-12-31","Address":"HOUSE NO 94 XXXXXXXX SXXXX  XXXXX XXXXXXX","State":"OR","Postal":"99999"},{"Seq":"2","ReportedDate":"2022-11-30","Address":"XXXXXXXXXXXXXXXXXXXXX","State":"DL","Postal":"110015","Type":"Office"},{"Seq":"3","ReportedDate":"2022-08-31","Address":"XXXXXXXXXXXXX","State":"OR","Postal":"761119"},{"Seq":"4","ReportedDate":"2022-03-31","Address":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","State":"OR","Postal":"000009","Type":"Primary"},{"Seq":"5","ReportedDate":"2021-10-01","Address":"XXXXXXXXXXXXXXXX","state":"or","postal":"999999","type":"primary"}],"phoneinfo":[{"seq":"1","typecode":"m","reporteddate":"2022-12-31","number":"9348412533"},{"seq":"2","typecode":"m","reporteddate":"2022-11-30","number":"919348412533"}],"emailaddressinfo":[{"seq":"1","reporteddate":"2022-11-30","emailaddress":"mailto:abcd@gmail.com"}]},"RetailAccountDetails":[{"seq":"1","AccountNumber":"EHNJ00000760858","Institution":"XYZ Bank","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"1600","LastPaymentDate":"2023-01-31","DateReported":"2023-02-01","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"02-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"2","AccountNumber":"0000000006601","Institution":"HFJJ Bank","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"1048","PastDueAmount":"0","Open":"Yes","HighCredit":"1622","DateReported":"2023-01-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"3","AccountNumber":"00000000E000760858","Institution":"ABCD Private Limited","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"400","LastPaymentDate":"2023-01-31","DateReported":"2023-01-31","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"4","AccountNumber":"000000004137078","Institution":"HJKL Bank Ltd.","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"3303","PastDueAmount":"0","LastPayment":"6104","WriteOffAmount":"0","Open":"Yes","HighCredit":"3154","LastPaymentDate":"2023-01-20","DateReported":"2023-01-31","DateOpened":"2022-11-07","CreditLimit":"15000","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"5","AccountNumber":"00000087","Institution":"PMJK Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"24769","Open":"Yes","SanctionAmount":"70000","LastPaymentDate":"2022-11-02","DateReported":"2022-11-30","DateOpened":"2020-01-11","RepaymentTenure":"48","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"6","AccountNumber":"0000057309","Institution":"JKLM Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"5964","Open":"Yes","SanctionAmount":"5599","LastPaymentDate":"2022-07-02","DateReported":"2022-11-30","DateOpened":"2021-09-29","RepaymentTenure":"6","InstallmentAmount":"994","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"7","AccountNumber":"00000007878920400000","Institution":"JKLM (Mauritius) Ltd","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"200","PastDueAmount":"0","Open":"Yes","HighCredit":"200","DateReported":"2022-03-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"03-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]}],"RetailAccountsSummary":{"NoOfAccounts":"7","NoOfActiveAccounts":"7","NoOfWriteOffs":"0","TotalPastDue":"0.00","MostSevereStatusWithIn24Months":"30+","SingleHighestCredit":"3154.00","SingleHighestSanctionAmount":"70000.00","TotalHighCredit":"4976.00","AverageOpenBalance":"650.14","SingleHighestBalance":"3303.00","NoOfPastDueAccounts":"0","NoOfZeroBalanceAccounts":"4","RecentAccount":"Credit Card on 07-11-2022","OldestAccount":"Personal Loan on 11-01-2020","TotalBalanceAmount":"4551.00","TotalSanctionAmount":"77599.00","TotalCreditLimit":"23800.0","TotalMonthlyPaymentAmount":"994.00"},"ScoreDetails":[{"Type":"ERS","Version":"3.1","Name":"Equifax Risk Score","Value":"728","ScoringElements":[{"type":"RES","seq":"1","Description":"Number of product trades"},{"type":"RES","seq":"2","code":"2b","Description":"Delinquency or past due amount occurences"},{"type":"RES","seq":"3","code":"5b","Description":"Balance amount of home loan trades"},{"type":"RES","seq":"4","code":"8a","Description":"Sanctioned amount of or lack of credit card trades"}]}],"EnquirySummary":{"Purpose":"ALL","Total":"0","Past30Days":"0","Past12Months":"0","Past24Months":"0"},"OtherKeyInd":{"AgeOfOldestTrade":"38","NumberOfOpenTrades":"7","AllLinesEVERWritten":"0.00","AllLinesEVERWrittenIn9Months":"0","AllLinesEVERWrittenIn6Months":"0"},"RecentActivities":{"AccountsDeliquent":"0","AccountsOpened":"0","TotalInquiries":"0","AccountsUpdated":"4"}}}]}}
/// statusCode : "200"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      EquifaxReport? equifaxReport, 
      String? statusCode,}){
    _equifaxReport = equifaxReport;
    _statusCode = statusCode;
}

  Data.fromJson(dynamic json) {
    _equifaxReport = json['Equifax_Report'] != null ? EquifaxReport.fromJson(json['Equifax_Report']) : null;
    _statusCode = json['statusCode'];
  }
  EquifaxReport? _equifaxReport;
  String? _statusCode;
Data copyWith({  EquifaxReport? equifaxReport,
  String? statusCode,
}) => Data(  equifaxReport: equifaxReport ?? _equifaxReport,
  statusCode: statusCode ?? _statusCode,
);
  EquifaxReport? get equifaxReport => _equifaxReport;
  String? get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_equifaxReport != null) {
      map['Equifax_Report'] = _equifaxReport?.toJson();
    }
    map['statusCode'] = _statusCode;
    return map;
  }

}

/// InquiryResponseHeader : {"ClientID":"027FP27964","CustRefField":"DB-P23030267","ReportOrderNO":"768987942","ProductCode":["PCRLT"],"SuccessCode":"1","Date":"2023-03-28","Time":"14:01:58"}
/// InquiryRequestInfo : {"InquiryPurpose":"16","FirstName":"ABCDEFG","LastName":"XYZAB","InquiryPhones":[{"seq":"1","PhoneType":["M"],"Number":"9999999999"}],"IDDetails":[{"seq":"1","IDType":"t","IDValue":"JDKNB0937J","Source":"Inquiry"}]}
/// Score : [{"Type":"ERS","Version":"3.1"}]
/// CCRResponse : {"Status":"1","CIRReportDataLst":[{"InquiryResponseHeader":{"CustomerCode":"AFIB","CustRefField":"DB-P23030267","ReportOrderNO":"768987942","TranID":"4682185901","ProductCode":["PCRLT"],"SuccessCode":"1","Date":"2023-03-28","Time":"14:01:57","HitCode":"10","CustomerName":"AFIB"},"InquiryRequestInfo":{"InquiryPurpose":"Fleet Card","FirstName":"ABCDEFG","LastName":"XYZAB","InquiryPhones":[{"seq":"1","PhoneType":["M"],"Number":"9999999999"}],"IDDetails":[{"seq":"1","IDType":"t","IDValue":"JDKNB0937J","Source":"Inquiry"}],"CustomFields":[{"key":"INQUERY_PRODUCT_CODE","value":"PCRLT"}]},"Score":[{"Type":"ERS","Version":"3.1"}],"CIRReportData":{"IDAndContactInfo":{"PersonalInfo":{"Name":{"FullName":"ABCDEFG JKLM NOP ","FirstName":"ABCDEFG ","LastName":"NOP "},"DateOfBirth":"2000-11-09","Gender":"Male","Age":{"Age":"22"}},"IdentityInfo":{"PANId":[{"seq":"1","ReportedDate":"2022-12-31","IdNumber":"JDKNB0937J"}],"NationalIDCard":[{"seq":"1","ReportedDate":"2021-02-28","IdNumber":"XXXXXXXXXXXX"}]},"AddressInfo":[{"Seq":"1","ReportedDate":"2022-12-31","Address":"HOUSE NO 94 XXXXXXXX SXXXX  XXXXX XXXXXXX","State":"OR","Postal":"99999"},{"Seq":"2","ReportedDate":"2022-11-30","Address":"XXXXXXXXXXXXXXXXXXXXX","State":"DL","Postal":"110015","Type":"Office"},{"Seq":"3","ReportedDate":"2022-08-31","Address":"XXXXXXXXXXXXX","State":"OR","Postal":"761119"},{"Seq":"4","ReportedDate":"2022-03-31","Address":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","State":"OR","Postal":"000009","Type":"Primary"},{"Seq":"5","ReportedDate":"2021-10-01","Address":"XXXXXXXXXXXXXXXX","state":"or","postal":"999999","type":"primary"}],"phoneinfo":[{"seq":"1","typecode":"m","reporteddate":"2022-12-31","number":"9348412533"},{"seq":"2","typecode":"m","reporteddate":"2022-11-30","number":"919348412533"}],"emailaddressinfo":[{"seq":"1","reporteddate":"2022-11-30","emailaddress":"mailto:abcd@gmail.com"}]},"RetailAccountDetails":[{"seq":"1","AccountNumber":"EHNJ00000760858","Institution":"XYZ Bank","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"1600","LastPaymentDate":"2023-01-31","DateReported":"2023-02-01","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"02-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"2","AccountNumber":"0000000006601","Institution":"HFJJ Bank","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"1048","PastDueAmount":"0","Open":"Yes","HighCredit":"1622","DateReported":"2023-01-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"3","AccountNumber":"00000000E000760858","Institution":"ABCD Private Limited","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"400","LastPaymentDate":"2023-01-31","DateReported":"2023-01-31","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"4","AccountNumber":"000000004137078","Institution":"HJKL Bank Ltd.","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"3303","PastDueAmount":"0","LastPayment":"6104","WriteOffAmount":"0","Open":"Yes","HighCredit":"3154","LastPaymentDate":"2023-01-20","DateReported":"2023-01-31","DateOpened":"2022-11-07","CreditLimit":"15000","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"5","AccountNumber":"00000087","Institution":"PMJK Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"24769","Open":"Yes","SanctionAmount":"70000","LastPaymentDate":"2022-11-02","DateReported":"2022-11-30","DateOpened":"2020-01-11","RepaymentTenure":"48","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"6","AccountNumber":"0000057309","Institution":"JKLM Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"5964","Open":"Yes","SanctionAmount":"5599","LastPaymentDate":"2022-07-02","DateReported":"2022-11-30","DateOpened":"2021-09-29","RepaymentTenure":"6","InstallmentAmount":"994","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"7","AccountNumber":"00000007878920400000","Institution":"JKLM (Mauritius) Ltd","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"200","PastDueAmount":"0","Open":"Yes","HighCredit":"200","DateReported":"2022-03-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"03-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]}],"RetailAccountsSummary":{"NoOfAccounts":"7","NoOfActiveAccounts":"7","NoOfWriteOffs":"0","TotalPastDue":"0.00","MostSevereStatusWithIn24Months":"30+","SingleHighestCredit":"3154.00","SingleHighestSanctionAmount":"70000.00","TotalHighCredit":"4976.00","AverageOpenBalance":"650.14","SingleHighestBalance":"3303.00","NoOfPastDueAccounts":"0","NoOfZeroBalanceAccounts":"4","RecentAccount":"Credit Card on 07-11-2022","OldestAccount":"Personal Loan on 11-01-2020","TotalBalanceAmount":"4551.00","TotalSanctionAmount":"77599.00","TotalCreditLimit":"23800.0","TotalMonthlyPaymentAmount":"994.00"},"ScoreDetails":[{"Type":"ERS","Version":"3.1","Name":"Equifax Risk Score","Value":"728","ScoringElements":[{"type":"RES","seq":"1","Description":"Number of product trades"},{"type":"RES","seq":"2","code":"2b","Description":"Delinquency or past due amount occurences"},{"type":"RES","seq":"3","code":"5b","Description":"Balance amount of home loan trades"},{"type":"RES","seq":"4","code":"8a","Description":"Sanctioned amount of or lack of credit card trades"}]}],"EnquirySummary":{"Purpose":"ALL","Total":"0","Past30Days":"0","Past12Months":"0","Past24Months":"0"},"OtherKeyInd":{"AgeOfOldestTrade":"38","NumberOfOpenTrades":"7","AllLinesEVERWritten":"0.00","AllLinesEVERWrittenIn9Months":"0","AllLinesEVERWrittenIn6Months":"0"},"RecentActivities":{"AccountsDeliquent":"0","AccountsOpened":"0","TotalInquiries":"0","AccountsUpdated":"4"}}}]}

EquifaxReport equifaxReportFromJson(String str) => EquifaxReport.fromJson(json.decode(str));
String equifaxReportToJson(EquifaxReport data) => json.encode(data.toJson());
class EquifaxReport {
  EquifaxReport({
      InquiryResponseHeader? inquiryResponseHeader, 
      InquiryRequestInfo? inquiryRequestInfo, 
      List<Score>? score, 
      CcrResponse? cCRResponse,}){
    _inquiryResponseHeader = inquiryResponseHeader;
    _inquiryRequestInfo = inquiryRequestInfo;
    _score = score;
    _cCRResponse = cCRResponse;
}

  EquifaxReport.fromJson(dynamic json) {
    _inquiryResponseHeader = json['InquiryResponseHeader'] != null ? InquiryResponseHeader.fromJson(json['InquiryResponseHeader']) : null;
    _inquiryRequestInfo = json['InquiryRequestInfo'] != null ? InquiryRequestInfo.fromJson(json['InquiryRequestInfo']) : null;
    if (json['Score'] != null) {
      _score = [];
      json['Score'].forEach((v) {
        _score?.add(Score.fromJson(v));
      });
    }
    _cCRResponse = json['CCRResponse'] != null ? CcrResponse.fromJson(json['CCRResponse']) : null;
  }
  InquiryResponseHeader? _inquiryResponseHeader;
  InquiryRequestInfo? _inquiryRequestInfo;
  List<Score>? _score;
  CcrResponse? _cCRResponse;
EquifaxReport copyWith({  InquiryResponseHeader? inquiryResponseHeader,
  InquiryRequestInfo? inquiryRequestInfo,
  List<Score>? score,
  CcrResponse? cCRResponse,
}) => EquifaxReport(  inquiryResponseHeader: inquiryResponseHeader ?? _inquiryResponseHeader,
  inquiryRequestInfo: inquiryRequestInfo ?? _inquiryRequestInfo,
  score: score ?? _score,
  cCRResponse: cCRResponse ?? _cCRResponse,
);
  InquiryResponseHeader? get inquiryResponseHeader => _inquiryResponseHeader;
  InquiryRequestInfo? get inquiryRequestInfo => _inquiryRequestInfo;
  List<Score>? get score => _score;
  CcrResponse? get cCRResponse => _cCRResponse;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_inquiryResponseHeader != null) {
      map['InquiryResponseHeader'] = _inquiryResponseHeader?.toJson();
    }
    if (_inquiryRequestInfo != null) {
      map['InquiryRequestInfo'] = _inquiryRequestInfo?.toJson();
    }
    if (_score != null) {
      map['Score'] = _score?.map((v) => v.toJson()).toList();
    }
    if (_cCRResponse != null) {
      map['CCRResponse'] = _cCRResponse?.toJson();
    }
    return map;
  }

}

/// Status : "1"
/// CIRReportDataLst : [{"InquiryResponseHeader":{"CustomerCode":"AFIB","CustRefField":"DB-P23030267","ReportOrderNO":"768987942","TranID":"4682185901","ProductCode":["PCRLT"],"SuccessCode":"1","Date":"2023-03-28","Time":"14:01:57","HitCode":"10","CustomerName":"AFIB"},"InquiryRequestInfo":{"InquiryPurpose":"Fleet Card","FirstName":"ABCDEFG","LastName":"XYZAB","InquiryPhones":[{"seq":"1","PhoneType":["M"],"Number":"9999999999"}],"IDDetails":[{"seq":"1","IDType":"t","IDValue":"JDKNB0937J","Source":"Inquiry"}],"CustomFields":[{"key":"INQUERY_PRODUCT_CODE","value":"PCRLT"}]},"Score":[{"Type":"ERS","Version":"3.1"}],"CIRReportData":{"IDAndContactInfo":{"PersonalInfo":{"Name":{"FullName":"ABCDEFG JKLM NOP ","FirstName":"ABCDEFG ","LastName":"NOP "},"DateOfBirth":"2000-11-09","Gender":"Male","Age":{"Age":"22"}},"IdentityInfo":{"PANId":[{"seq":"1","ReportedDate":"2022-12-31","IdNumber":"JDKNB0937J"}],"NationalIDCard":[{"seq":"1","ReportedDate":"2021-02-28","IdNumber":"XXXXXXXXXXXX"}]},"AddressInfo":[{"Seq":"1","ReportedDate":"2022-12-31","Address":"HOUSE NO 94 XXXXXXXX SXXXX  XXXXX XXXXXXX","State":"OR","Postal":"99999"},{"Seq":"2","ReportedDate":"2022-11-30","Address":"XXXXXXXXXXXXXXXXXXXXX","State":"DL","Postal":"110015","Type":"Office"},{"Seq":"3","ReportedDate":"2022-08-31","Address":"XXXXXXXXXXXXX","State":"OR","Postal":"761119"},{"Seq":"4","ReportedDate":"2022-03-31","Address":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","State":"OR","Postal":"000009","Type":"Primary"},{"Seq":"5","ReportedDate":"2021-10-01","Address":"XXXXXXXXXXXXXXXX","state":"or","postal":"999999","type":"primary"}],"phoneinfo":[{"seq":"1","typecode":"m","reporteddate":"2022-12-31","number":"9348412533"},{"seq":"2","typecode":"m","reporteddate":"2022-11-30","number":"919348412533"}],"emailaddressinfo":[{"seq":"1","reporteddate":"2022-11-30","emailaddress":"mailto:abcd@gmail.com"}]},"RetailAccountDetails":[{"seq":"1","AccountNumber":"EHNJ00000760858","Institution":"XYZ Bank","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"1600","LastPaymentDate":"2023-01-31","DateReported":"2023-02-01","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"02-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"2","AccountNumber":"0000000006601","Institution":"HFJJ Bank","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"1048","PastDueAmount":"0","Open":"Yes","HighCredit":"1622","DateReported":"2023-01-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"3","AccountNumber":"00000000E000760858","Institution":"ABCD Private Limited","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"400","LastPaymentDate":"2023-01-31","DateReported":"2023-01-31","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"4","AccountNumber":"000000004137078","Institution":"HJKL Bank Ltd.","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"3303","PastDueAmount":"0","LastPayment":"6104","WriteOffAmount":"0","Open":"Yes","HighCredit":"3154","LastPaymentDate":"2023-01-20","DateReported":"2023-01-31","DateOpened":"2022-11-07","CreditLimit":"15000","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"5","AccountNumber":"00000087","Institution":"PMJK Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"24769","Open":"Yes","SanctionAmount":"70000","LastPaymentDate":"2022-11-02","DateReported":"2022-11-30","DateOpened":"2020-01-11","RepaymentTenure":"48","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"6","AccountNumber":"0000057309","Institution":"JKLM Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"5964","Open":"Yes","SanctionAmount":"5599","LastPaymentDate":"2022-07-02","DateReported":"2022-11-30","DateOpened":"2021-09-29","RepaymentTenure":"6","InstallmentAmount":"994","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"7","AccountNumber":"00000007878920400000","Institution":"JKLM (Mauritius) Ltd","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"200","PastDueAmount":"0","Open":"Yes","HighCredit":"200","DateReported":"2022-03-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"03-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]}],"RetailAccountsSummary":{"NoOfAccounts":"7","NoOfActiveAccounts":"7","NoOfWriteOffs":"0","TotalPastDue":"0.00","MostSevereStatusWithIn24Months":"30+","SingleHighestCredit":"3154.00","SingleHighestSanctionAmount":"70000.00","TotalHighCredit":"4976.00","AverageOpenBalance":"650.14","SingleHighestBalance":"3303.00","NoOfPastDueAccounts":"0","NoOfZeroBalanceAccounts":"4","RecentAccount":"Credit Card on 07-11-2022","OldestAccount":"Personal Loan on 11-01-2020","TotalBalanceAmount":"4551.00","TotalSanctionAmount":"77599.00","TotalCreditLimit":"23800.0","TotalMonthlyPaymentAmount":"994.00"},"ScoreDetails":[{"Type":"ERS","Version":"3.1","Name":"Equifax Risk Score","Value":"728","ScoringElements":[{"type":"RES","seq":"1","Description":"Number of product trades"},{"type":"RES","seq":"2","code":"2b","Description":"Delinquency or past due amount occurences"},{"type":"RES","seq":"3","code":"5b","Description":"Balance amount of home loan trades"},{"type":"RES","seq":"4","code":"8a","Description":"Sanctioned amount of or lack of credit card trades"}]}],"EnquirySummary":{"Purpose":"ALL","Total":"0","Past30Days":"0","Past12Months":"0","Past24Months":"0"},"OtherKeyInd":{"AgeOfOldestTrade":"38","NumberOfOpenTrades":"7","AllLinesEVERWritten":"0.00","AllLinesEVERWrittenIn9Months":"0","AllLinesEVERWrittenIn6Months":"0"},"RecentActivities":{"AccountsDeliquent":"0","AccountsOpened":"0","TotalInquiries":"0","AccountsUpdated":"4"}}}]

CcrResponse ccrResponseFromJson(String str) => CcrResponse.fromJson(json.decode(str));
String ccrResponseToJson(CcrResponse data) => json.encode(data.toJson());
class CcrResponse {
  CcrResponse({
      String? status, 
      List<CirReportDataLst>? cIRReportDataLst,}){
    _status = status;
    _cIRReportDataLst = cIRReportDataLst;
}

  CcrResponse.fromJson(dynamic json) {
    _status = json['Status'];
    if (json['CIRReportDataLst'] != null) {
      _cIRReportDataLst = [];
      json['CIRReportDataLst'].forEach((v) {
        _cIRReportDataLst?.add(CirReportDataLst.fromJson(v));
      });
    }
  }
  String? _status;
  List<CirReportDataLst>? _cIRReportDataLst;
CcrResponse copyWith({  String? status,
  List<CirReportDataLst>? cIRReportDataLst,
}) => CcrResponse(  status: status ?? _status,
  cIRReportDataLst: cIRReportDataLst ?? _cIRReportDataLst,
);
  String? get status => _status;
  List<CirReportDataLst>? get cIRReportDataLst => _cIRReportDataLst;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    if (_cIRReportDataLst != null) {
      map['CIRReportDataLst'] = _cIRReportDataLst?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// InquiryResponseHeader : {"CustomerCode":"AFIB","CustRefField":"DB-P23030267","ReportOrderNO":"768987942","TranID":"4682185901","ProductCode":["PCRLT"],"SuccessCode":"1","Date":"2023-03-28","Time":"14:01:57","HitCode":"10","CustomerName":"AFIB"}
/// InquiryRequestInfo : {"InquiryPurpose":"Fleet Card","FirstName":"ABCDEFG","LastName":"XYZAB","InquiryPhones":[{"seq":"1","PhoneType":["M"],"Number":"9999999999"}],"IDDetails":[{"seq":"1","IDType":"t","IDValue":"JDKNB0937J","Source":"Inquiry"}],"CustomFields":[{"key":"INQUERY_PRODUCT_CODE","value":"PCRLT"}]}
/// Score : [{"Type":"ERS","Version":"3.1"}]
/// CIRReportData : {"IDAndContactInfo":{"PersonalInfo":{"Name":{"FullName":"ABCDEFG JKLM NOP ","FirstName":"ABCDEFG ","LastName":"NOP "},"DateOfBirth":"2000-11-09","Gender":"Male","Age":{"Age":"22"}},"IdentityInfo":{"PANId":[{"seq":"1","ReportedDate":"2022-12-31","IdNumber":"JDKNB0937J"}],"NationalIDCard":[{"seq":"1","ReportedDate":"2021-02-28","IdNumber":"XXXXXXXXXXXX"}]},"AddressInfo":[{"Seq":"1","ReportedDate":"2022-12-31","Address":"HOUSE NO 94 XXXXXXXX SXXXX  XXXXX XXXXXXX","State":"OR","Postal":"99999"},{"Seq":"2","ReportedDate":"2022-11-30","Address":"XXXXXXXXXXXXXXXXXXXXX","State":"DL","Postal":"110015","Type":"Office"},{"Seq":"3","ReportedDate":"2022-08-31","Address":"XXXXXXXXXXXXX","State":"OR","Postal":"761119"},{"Seq":"4","ReportedDate":"2022-03-31","Address":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","State":"OR","Postal":"000009","Type":"Primary"},{"Seq":"5","ReportedDate":"2021-10-01","Address":"XXXXXXXXXXXXXXXX","state":"or","postal":"999999","type":"primary"}],"phoneinfo":[{"seq":"1","typecode":"m","reporteddate":"2022-12-31","number":"9348412533"},{"seq":"2","typecode":"m","reporteddate":"2022-11-30","number":"919348412533"}],"emailaddressinfo":[{"seq":"1","reporteddate":"2022-11-30","emailaddress":"mailto:abcd@gmail.com"}]},"RetailAccountDetails":[{"seq":"1","AccountNumber":"EHNJ00000760858","Institution":"XYZ Bank","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"1600","LastPaymentDate":"2023-01-31","DateReported":"2023-02-01","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"02-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"2","AccountNumber":"0000000006601","Institution":"HFJJ Bank","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"1048","PastDueAmount":"0","Open":"Yes","HighCredit":"1622","DateReported":"2023-01-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"3","AccountNumber":"00000000E000760858","Institution":"ABCD Private Limited","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"400","LastPaymentDate":"2023-01-31","DateReported":"2023-01-31","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"4","AccountNumber":"000000004137078","Institution":"HJKL Bank Ltd.","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"3303","PastDueAmount":"0","LastPayment":"6104","WriteOffAmount":"0","Open":"Yes","HighCredit":"3154","LastPaymentDate":"2023-01-20","DateReported":"2023-01-31","DateOpened":"2022-11-07","CreditLimit":"15000","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"5","AccountNumber":"00000087","Institution":"PMJK Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"24769","Open":"Yes","SanctionAmount":"70000","LastPaymentDate":"2022-11-02","DateReported":"2022-11-30","DateOpened":"2020-01-11","RepaymentTenure":"48","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"6","AccountNumber":"0000057309","Institution":"JKLM Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"5964","Open":"Yes","SanctionAmount":"5599","LastPaymentDate":"2022-07-02","DateReported":"2022-11-30","DateOpened":"2021-09-29","RepaymentTenure":"6","InstallmentAmount":"994","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"7","AccountNumber":"00000007878920400000","Institution":"JKLM (Mauritius) Ltd","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"200","PastDueAmount":"0","Open":"Yes","HighCredit":"200","DateReported":"2022-03-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"03-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]}],"RetailAccountsSummary":{"NoOfAccounts":"7","NoOfActiveAccounts":"7","NoOfWriteOffs":"0","TotalPastDue":"0.00","MostSevereStatusWithIn24Months":"30+","SingleHighestCredit":"3154.00","SingleHighestSanctionAmount":"70000.00","TotalHighCredit":"4976.00","AverageOpenBalance":"650.14","SingleHighestBalance":"3303.00","NoOfPastDueAccounts":"0","NoOfZeroBalanceAccounts":"4","RecentAccount":"Credit Card on 07-11-2022","OldestAccount":"Personal Loan on 11-01-2020","TotalBalanceAmount":"4551.00","TotalSanctionAmount":"77599.00","TotalCreditLimit":"23800.0","TotalMonthlyPaymentAmount":"994.00"},"ScoreDetails":[{"Type":"ERS","Version":"3.1","Name":"Equifax Risk Score","Value":"728","ScoringElements":[{"type":"RES","seq":"1","Description":"Number of product trades"},{"type":"RES","seq":"2","code":"2b","Description":"Delinquency or past due amount occurences"},{"type":"RES","seq":"3","code":"5b","Description":"Balance amount of home loan trades"},{"type":"RES","seq":"4","code":"8a","Description":"Sanctioned amount of or lack of credit card trades"}]}],"EnquirySummary":{"Purpose":"ALL","Total":"0","Past30Days":"0","Past12Months":"0","Past24Months":"0"},"OtherKeyInd":{"AgeOfOldestTrade":"38","NumberOfOpenTrades":"7","AllLinesEVERWritten":"0.00","AllLinesEVERWrittenIn9Months":"0","AllLinesEVERWrittenIn6Months":"0"},"RecentActivities":{"AccountsDeliquent":"0","AccountsOpened":"0","TotalInquiries":"0","AccountsUpdated":"4"}}

CirReportDataLst cirReportDataLstFromJson(String str) => CirReportDataLst.fromJson(json.decode(str));
String cirReportDataLstToJson(CirReportDataLst data) => json.encode(data.toJson());
class CirReportDataLst {
  CirReportDataLst({
      InquiryResponseHeader? inquiryResponseHeader, 
      InquiryRequestInfo? inquiryRequestInfo, 
      List<Score>? score, 
      CirReportData? cIRReportData,}){
    _inquiryResponseHeader = inquiryResponseHeader;
    _inquiryRequestInfo = inquiryRequestInfo;
    _score = score;
    _cIRReportData = cIRReportData;
}

  CirReportDataLst.fromJson(dynamic json) {
    _inquiryResponseHeader = json['InquiryResponseHeader'] != null ? InquiryResponseHeader.fromJson(json['InquiryResponseHeader']) : null;
    _inquiryRequestInfo = json['InquiryRequestInfo'] != null ? InquiryRequestInfo.fromJson(json['InquiryRequestInfo']) : null;
    if (json['Score'] != null) {
      _score = [];
      json['Score'].forEach((v) {
        _score?.add(Score.fromJson(v));
      });
    }
    _cIRReportData = json['CIRReportData'] != null ? CirReportData.fromJson(json['CIRReportData']) : null;
  }
  InquiryResponseHeader? _inquiryResponseHeader;
  InquiryRequestInfo? _inquiryRequestInfo;
  List<Score>? _score;
  CirReportData? _cIRReportData;
CirReportDataLst copyWith({  InquiryResponseHeader? inquiryResponseHeader,
  InquiryRequestInfo? inquiryRequestInfo,
  List<Score>? score,
  CirReportData? cIRReportData,
}) => CirReportDataLst(  inquiryResponseHeader: inquiryResponseHeader ?? _inquiryResponseHeader,
  inquiryRequestInfo: inquiryRequestInfo ?? _inquiryRequestInfo,
  score: score ?? _score,
  cIRReportData: cIRReportData ?? _cIRReportData,
);
  InquiryResponseHeader? get inquiryResponseHeader => _inquiryResponseHeader;
  InquiryRequestInfo? get inquiryRequestInfo => _inquiryRequestInfo;
  List<Score>? get score => _score;
  CirReportData? get cIRReportData => _cIRReportData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_inquiryResponseHeader != null) {
      map['InquiryResponseHeader'] = _inquiryResponseHeader?.toJson();
    }
    if (_inquiryRequestInfo != null) {
      map['InquiryRequestInfo'] = _inquiryRequestInfo?.toJson();
    }
    if (_score != null) {
      map['Score'] = _score?.map((v) => v.toJson()).toList();
    }
    if (_cIRReportData != null) {
      map['CIRReportData'] = _cIRReportData?.toJson();
    }
    return map;
  }

}

/// IDAndContactInfo : {"PersonalInfo":{"Name":{"FullName":"ABCDEFG JKLM NOP ","FirstName":"ABCDEFG ","LastName":"NOP "},"DateOfBirth":"2000-11-09","Gender":"Male","Age":{"Age":"22"}},"IdentityInfo":{"PANId":[{"seq":"1","ReportedDate":"2022-12-31","IdNumber":"JDKNB0937J"}],"NationalIDCard":[{"seq":"1","ReportedDate":"2021-02-28","IdNumber":"XXXXXXXXXXXX"}]},"AddressInfo":[{"Seq":"1","ReportedDate":"2022-12-31","Address":"HOUSE NO 94 XXXXXXXX SXXXX  XXXXX XXXXXXX","State":"OR","Postal":"99999"},{"Seq":"2","ReportedDate":"2022-11-30","Address":"XXXXXXXXXXXXXXXXXXXXX","State":"DL","Postal":"110015","Type":"Office"},{"Seq":"3","ReportedDate":"2022-08-31","Address":"XXXXXXXXXXXXX","State":"OR","Postal":"761119"},{"Seq":"4","ReportedDate":"2022-03-31","Address":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","State":"OR","Postal":"000009","Type":"Primary"},{"Seq":"5","ReportedDate":"2021-10-01","Address":"XXXXXXXXXXXXXXXX","state":"or","postal":"999999","type":"primary"}],"phoneinfo":[{"seq":"1","typecode":"m","reporteddate":"2022-12-31","number":"9348412533"},{"seq":"2","typecode":"m","reporteddate":"2022-11-30","number":"919348412533"}],"emailaddressinfo":[{"seq":"1","reporteddate":"2022-11-30","emailaddress":"mailto:abcd@gmail.com"}]}
/// RetailAccountDetails : [{"seq":"1","AccountNumber":"EHNJ00000760858","Institution":"XYZ Bank","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"1600","LastPaymentDate":"2023-01-31","DateReported":"2023-02-01","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"02-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"2","AccountNumber":"0000000006601","Institution":"HFJJ Bank","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"1048","PastDueAmount":"0","Open":"Yes","HighCredit":"1622","DateReported":"2023-01-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"3","AccountNumber":"00000000E000760858","Institution":"ABCD Private Limited","AccountType":"Consumer Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","Open":"Yes","SanctionAmount":"400","LastPaymentDate":"2023-01-31","DateReported":"2023-01-31","DateOpened":"2022-05-08","TermFrequency":"Monthly","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]},{"seq":"4","AccountNumber":"000000004137078","Institution":"HJKL Bank Ltd.","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"3303","PastDueAmount":"0","LastPayment":"6104","WriteOffAmount":"0","Open":"Yes","HighCredit":"3154","LastPaymentDate":"2023-01-20","DateReported":"2023-01-31","DateOpened":"2022-11-07","CreditLimit":"15000","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"12-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"5","AccountNumber":"00000087","Institution":"PMJK Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"24769","Open":"Yes","SanctionAmount":"70000","LastPaymentDate":"2022-11-02","DateReported":"2022-11-30","DateOpened":"2020-01-11","RepaymentTenure":"48","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"6","AccountNumber":"0000057309","Institution":"JKLM Bank Ltd","AccountType":"Personal Loan","OwnershipType":"Individual","Balance":"0","PastDueAmount":"0","LastPayment":"5964","Open":"Yes","SanctionAmount":"5599","LastPaymentDate":"2022-07-02","DateReported":"2022-11-30","DateOpened":"2021-09-29","RepaymentTenure":"6","InstallmentAmount":"994","TermFrequency":"Monthly","AccountStatus":"Current Account","source":"INDIVIDUAL","History48Months":[{"key":"11-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"},{"key":"10-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"*"}]},{"seq":"7","AccountNumber":"00000007878920400000","Institution":"JKLM (Mauritius) Ltd","AccountType":"Credit Card","OwnershipType":"Individual","Balance":"200","PastDueAmount":"0","Open":"Yes","HighCredit":"200","DateReported":"2022-03-31","DateOpened":"2022-02-16","CreditLimit":"4400","AccountStatus":"Current Account","AssetClassification":"Standard","source":"INDIVIDUAL","History48Months":[{"key":"03-22","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]}]
/// RetailAccountsSummary : {"NoOfAccounts":"7","NoOfActiveAccounts":"7","NoOfWriteOffs":"0","TotalPastDue":"0.00","MostSevereStatusWithIn24Months":"30+","SingleHighestCredit":"3154.00","SingleHighestSanctionAmount":"70000.00","TotalHighCredit":"4976.00","AverageOpenBalance":"650.14","SingleHighestBalance":"3303.00","NoOfPastDueAccounts":"0","NoOfZeroBalanceAccounts":"4","RecentAccount":"Credit Card on 07-11-2022","OldestAccount":"Personal Loan on 11-01-2020","TotalBalanceAmount":"4551.00","TotalSanctionAmount":"77599.00","TotalCreditLimit":"23800.0","TotalMonthlyPaymentAmount":"994.00"}
/// ScoreDetails : [{"Type":"ERS","Version":"3.1","Name":"Equifax Risk Score","Value":"728","ScoringElements":[{"type":"RES","seq":"1","Description":"Number of product trades"},{"type":"RES","seq":"2","code":"2b","Description":"Delinquency or past due amount occurences"},{"type":"RES","seq":"3","code":"5b","Description":"Balance amount of home loan trades"},{"type":"RES","seq":"4","code":"8a","Description":"Sanctioned amount of or lack of credit card trades"}]}]
/// EnquirySummary : {"Purpose":"ALL","Total":"0","Past30Days":"0","Past12Months":"0","Past24Months":"0"}
/// OtherKeyInd : {"AgeOfOldestTrade":"38","NumberOfOpenTrades":"7","AllLinesEVERWritten":"0.00","AllLinesEVERWrittenIn9Months":"0","AllLinesEVERWrittenIn6Months":"0"}
/// RecentActivities : {"AccountsDeliquent":"0","AccountsOpened":"0","TotalInquiries":"0","AccountsUpdated":"4"}

CirReportData cirReportDataFromJson(String str) => CirReportData.fromJson(json.decode(str));
String cirReportDataToJson(CirReportData data) => json.encode(data.toJson());
class CirReportData {
  CirReportData({
      IdAndContactInfo? iDAndContactInfo, 
      List<RetailAccountDetails>? retailAccountDetails, 
      RetailAccountsSummary? retailAccountsSummary, 
      List<ScoreDetails>? scoreDetails, 
      EnquirySummary? enquirySummary, 
      OtherKeyInd? otherKeyInd, 
      RecentActivities? recentActivities,}){
    _iDAndContactInfo = iDAndContactInfo;
    _retailAccountDetails = retailAccountDetails;
    _retailAccountsSummary = retailAccountsSummary;
    _scoreDetails = scoreDetails;
    _enquirySummary = enquirySummary;
    _otherKeyInd = otherKeyInd;
    _recentActivities = recentActivities;
}

  CirReportData.fromJson(dynamic json) {
    _iDAndContactInfo = json['IDAndContactInfo'] != null ? IdAndContactInfo.fromJson(json['IDAndContactInfo']) : null;
    if (json['RetailAccountDetails'] != null) {
      _retailAccountDetails = [];
      json['RetailAccountDetails'].forEach((v) {
        _retailAccountDetails?.add(RetailAccountDetails.fromJson(v));
      });
    }
    _retailAccountsSummary = json['RetailAccountsSummary'] != null ? RetailAccountsSummary.fromJson(json['RetailAccountsSummary']) : null;
    if (json['ScoreDetails'] != null) {
      _scoreDetails = [];
      json['ScoreDetails'].forEach((v) {
        _scoreDetails?.add(ScoreDetails.fromJson(v));
      });
    }
    _enquirySummary = json['EnquirySummary'] != null ? EnquirySummary.fromJson(json['EnquirySummary']) : null;
    _otherKeyInd = json['OtherKeyInd'] != null ? OtherKeyInd.fromJson(json['OtherKeyInd']) : null;
    _recentActivities = json['RecentActivities'] != null ? RecentActivities.fromJson(json['RecentActivities']) : null;
  }
  IdAndContactInfo? _iDAndContactInfo;
  List<RetailAccountDetails>? _retailAccountDetails;
  RetailAccountsSummary? _retailAccountsSummary;
  List<ScoreDetails>? _scoreDetails;
  EnquirySummary? _enquirySummary;
  OtherKeyInd? _otherKeyInd;
  RecentActivities? _recentActivities;
CirReportData copyWith({  IdAndContactInfo? iDAndContactInfo,
  List<RetailAccountDetails>? retailAccountDetails,
  RetailAccountsSummary? retailAccountsSummary,
  List<ScoreDetails>? scoreDetails,
  EnquirySummary? enquirySummary,
  OtherKeyInd? otherKeyInd,
  RecentActivities? recentActivities,
}) => CirReportData(  iDAndContactInfo: iDAndContactInfo ?? _iDAndContactInfo,
  retailAccountDetails: retailAccountDetails ?? _retailAccountDetails,
  retailAccountsSummary: retailAccountsSummary ?? _retailAccountsSummary,
  scoreDetails: scoreDetails ?? _scoreDetails,
  enquirySummary: enquirySummary ?? _enquirySummary,
  otherKeyInd: otherKeyInd ?? _otherKeyInd,
  recentActivities: recentActivities ?? _recentActivities,
);
  IdAndContactInfo? get iDAndContactInfo => _iDAndContactInfo;
  List<RetailAccountDetails>? get retailAccountDetails => _retailAccountDetails;
  RetailAccountsSummary? get retailAccountsSummary => _retailAccountsSummary;
  List<ScoreDetails>? get scoreDetails => _scoreDetails;
  EnquirySummary? get enquirySummary => _enquirySummary;
  OtherKeyInd? get otherKeyInd => _otherKeyInd;
  RecentActivities? get recentActivities => _recentActivities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_iDAndContactInfo != null) {
      map['IDAndContactInfo'] = _iDAndContactInfo?.toJson();
    }
    if (_retailAccountDetails != null) {
      map['RetailAccountDetails'] = _retailAccountDetails?.map((v) => v.toJson()).toList();
    }
    if (_retailAccountsSummary != null) {
      map['RetailAccountsSummary'] = _retailAccountsSummary?.toJson();
    }
    if (_scoreDetails != null) {
      map['ScoreDetails'] = _scoreDetails?.map((v) => v.toJson()).toList();
    }
    if (_enquirySummary != null) {
      map['EnquirySummary'] = _enquirySummary?.toJson();
    }
    if (_otherKeyInd != null) {
      map['OtherKeyInd'] = _otherKeyInd?.toJson();
    }
    if (_recentActivities != null) {
      map['RecentActivities'] = _recentActivities?.toJson();
    }
    return map;
  }

}

/// AccountsDeliquent : "0"
/// AccountsOpened : "0"
/// TotalInquiries : "0"
/// AccountsUpdated : "4"

RecentActivities recentActivitiesFromJson(String str) => RecentActivities.fromJson(json.decode(str));
String recentActivitiesToJson(RecentActivities data) => json.encode(data.toJson());
class RecentActivities {
  RecentActivities({
      String? accountsDeliquent, 
      String? accountsOpened, 
      String? totalInquiries, 
      String? accountsUpdated,}){
    _accountsDeliquent = accountsDeliquent;
    _accountsOpened = accountsOpened;
    _totalInquiries = totalInquiries;
    _accountsUpdated = accountsUpdated;
}

  RecentActivities.fromJson(dynamic json) {
    _accountsDeliquent = json['AccountsDeliquent'];
    _accountsOpened = json['AccountsOpened'];
    _totalInquiries = json['TotalInquiries'];
    _accountsUpdated = json['AccountsUpdated'];
  }
  String? _accountsDeliquent;
  String? _accountsOpened;
  String? _totalInquiries;
  String? _accountsUpdated;
RecentActivities copyWith({  String? accountsDeliquent,
  String? accountsOpened,
  String? totalInquiries,
  String? accountsUpdated,
}) => RecentActivities(  accountsDeliquent: accountsDeliquent ?? _accountsDeliquent,
  accountsOpened: accountsOpened ?? _accountsOpened,
  totalInquiries: totalInquiries ?? _totalInquiries,
  accountsUpdated: accountsUpdated ?? _accountsUpdated,
);
  String? get accountsDeliquent => _accountsDeliquent;
  String? get accountsOpened => _accountsOpened;
  String? get totalInquiries => _totalInquiries;
  String? get accountsUpdated => _accountsUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccountsDeliquent'] = _accountsDeliquent;
    map['AccountsOpened'] = _accountsOpened;
    map['TotalInquiries'] = _totalInquiries;
    map['AccountsUpdated'] = _accountsUpdated;
    return map;
  }

}

/// AgeOfOldestTrade : "38"
/// NumberOfOpenTrades : "7"
/// AllLinesEVERWritten : "0.00"
/// AllLinesEVERWrittenIn9Months : "0"
/// AllLinesEVERWrittenIn6Months : "0"

OtherKeyInd otherKeyIndFromJson(String str) => OtherKeyInd.fromJson(json.decode(str));
String otherKeyIndToJson(OtherKeyInd data) => json.encode(data.toJson());
class OtherKeyInd {
  OtherKeyInd({
      String? ageOfOldestTrade, 
      String? numberOfOpenTrades, 
      String? allLinesEVERWritten, 
      String? allLinesEVERWrittenIn9Months, 
      String? allLinesEVERWrittenIn6Months,}){
    _ageOfOldestTrade = ageOfOldestTrade;
    _numberOfOpenTrades = numberOfOpenTrades;
    _allLinesEVERWritten = allLinesEVERWritten;
    _allLinesEVERWrittenIn9Months = allLinesEVERWrittenIn9Months;
    _allLinesEVERWrittenIn6Months = allLinesEVERWrittenIn6Months;
}

  OtherKeyInd.fromJson(dynamic json) {
    _ageOfOldestTrade = json['AgeOfOldestTrade'];
    _numberOfOpenTrades = json['NumberOfOpenTrades'];
    _allLinesEVERWritten = json['AllLinesEVERWritten'];
    _allLinesEVERWrittenIn9Months = json['AllLinesEVERWrittenIn9Months'];
    _allLinesEVERWrittenIn6Months = json['AllLinesEVERWrittenIn6Months'];
  }
  String? _ageOfOldestTrade;
  String? _numberOfOpenTrades;
  String? _allLinesEVERWritten;
  String? _allLinesEVERWrittenIn9Months;
  String? _allLinesEVERWrittenIn6Months;
OtherKeyInd copyWith({  String? ageOfOldestTrade,
  String? numberOfOpenTrades,
  String? allLinesEVERWritten,
  String? allLinesEVERWrittenIn9Months,
  String? allLinesEVERWrittenIn6Months,
}) => OtherKeyInd(  ageOfOldestTrade: ageOfOldestTrade ?? _ageOfOldestTrade,
  numberOfOpenTrades: numberOfOpenTrades ?? _numberOfOpenTrades,
  allLinesEVERWritten: allLinesEVERWritten ?? _allLinesEVERWritten,
  allLinesEVERWrittenIn9Months: allLinesEVERWrittenIn9Months ?? _allLinesEVERWrittenIn9Months,
  allLinesEVERWrittenIn6Months: allLinesEVERWrittenIn6Months ?? _allLinesEVERWrittenIn6Months,
);
  String? get ageOfOldestTrade => _ageOfOldestTrade;
  String? get numberOfOpenTrades => _numberOfOpenTrades;
  String? get allLinesEVERWritten => _allLinesEVERWritten;
  String? get allLinesEVERWrittenIn9Months => _allLinesEVERWrittenIn9Months;
  String? get allLinesEVERWrittenIn6Months => _allLinesEVERWrittenIn6Months;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AgeOfOldestTrade'] = _ageOfOldestTrade;
    map['NumberOfOpenTrades'] = _numberOfOpenTrades;
    map['AllLinesEVERWritten'] = _allLinesEVERWritten;
    map['AllLinesEVERWrittenIn9Months'] = _allLinesEVERWrittenIn9Months;
    map['AllLinesEVERWrittenIn6Months'] = _allLinesEVERWrittenIn6Months;
    return map;
  }

}

/// Purpose : "ALL"
/// Total : "0"
/// Past30Days : "0"
/// Past12Months : "0"
/// Past24Months : "0"

EnquirySummary enquirySummaryFromJson(String str) => EnquirySummary.fromJson(json.decode(str));
String enquirySummaryToJson(EnquirySummary data) => json.encode(data.toJson());
class EnquirySummary {
  EnquirySummary({
      String? purpose, 
      String? total, 
      String? past30Days, 
      String? past12Months, 
      String? past24Months,}){
    _purpose = purpose;
    _total = total;
    _past30Days = past30Days;
    _past12Months = past12Months;
    _past24Months = past24Months;
}

  EnquirySummary.fromJson(dynamic json) {
    _purpose = json['Purpose'];
    _total = json['Total'];
    _past30Days = json['Past30Days'];
    _past12Months = json['Past12Months'];
    _past24Months = json['Past24Months'];
  }
  String? _purpose;
  String? _total;
  String? _past30Days;
  String? _past12Months;
  String? _past24Months;
EnquirySummary copyWith({  String? purpose,
  String? total,
  String? past30Days,
  String? past12Months,
  String? past24Months,
}) => EnquirySummary(  purpose: purpose ?? _purpose,
  total: total ?? _total,
  past30Days: past30Days ?? _past30Days,
  past12Months: past12Months ?? _past12Months,
  past24Months: past24Months ?? _past24Months,
);
  String? get purpose => _purpose;
  String? get total => _total;
  String? get past30Days => _past30Days;
  String? get past12Months => _past12Months;
  String? get past24Months => _past24Months;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Purpose'] = _purpose;
    map['Total'] = _total;
    map['Past30Days'] = _past30Days;
    map['Past12Months'] = _past12Months;
    map['Past24Months'] = _past24Months;
    return map;
  }

}

/// Type : "ERS"
/// Version : "3.1"
/// Name : "Equifax Risk Score"
/// Value : "728"
/// ScoringElements : [{"type":"RES","seq":"1","Description":"Number of product trades"},{"type":"RES","seq":"2","code":"2b","Description":"Delinquency or past due amount occurences"},{"type":"RES","seq":"3","code":"5b","Description":"Balance amount of home loan trades"},{"type":"RES","seq":"4","code":"8a","Description":"Sanctioned amount of or lack of credit card trades"}]

ScoreDetails scoreDetailsFromJson(String str) => ScoreDetails.fromJson(json.decode(str));
String scoreDetailsToJson(ScoreDetails data) => json.encode(data.toJson());
class ScoreDetails {
  ScoreDetails({
      String? type, 
      String? version, 
      String? name, 
      String? value, 
      List<ScoringElements>? scoringElements,}){
    _type = type;
    _version = version;
    _name = name;
    _value = value;
    _scoringElements = scoringElements;
}

  ScoreDetails.fromJson(dynamic json) {
    _type = json['Type'];
    _version = json['Version'];
    _name = json['Name'];
    _value = json['Value'];
    if (json['ScoringElements'] != null) {
      _scoringElements = [];
      json['ScoringElements'].forEach((v) {
        _scoringElements?.add(ScoringElements.fromJson(v));
      });
    }
  }
  String? _type;
  String? _version;
  String? _name;
  String? _value;
  List<ScoringElements>? _scoringElements;
ScoreDetails copyWith({  String? type,
  String? version,
  String? name,
  String? value,
  List<ScoringElements>? scoringElements,
}) => ScoreDetails(  type: type ?? _type,
  version: version ?? _version,
  name: name ?? _name,
  value: value ?? _value,
  scoringElements: scoringElements ?? _scoringElements,
);
  String? get type => _type;
  String? get version => _version;
  String? get name => _name;
  String? get value => _value;
  List<ScoringElements>? get scoringElements => _scoringElements;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Type'] = _type;
    map['Version'] = _version;
    map['Name'] = _name;
    map['Value'] = _value;
    if (_scoringElements != null) {
      map['ScoringElements'] = _scoringElements?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// type : "RES"
/// seq : "1"
/// Description : "Number of product trades"

ScoringElements scoringElementsFromJson(String str) => ScoringElements.fromJson(json.decode(str));
String scoringElementsToJson(ScoringElements data) => json.encode(data.toJson());
class ScoringElements {
  ScoringElements({
      String? type, 
      String? seq, 
      String? description,}){
    _type = type;
    _seq = seq;
    _description = description;
}

  ScoringElements.fromJson(dynamic json) {
    _type = json['type'];
    _seq = json['seq'];
    _description = json['Description'];
  }
  String? _type;
  String? _seq;
  String? _description;
ScoringElements copyWith({  String? type,
  String? seq,
  String? description,
}) => ScoringElements(  type: type ?? _type,
  seq: seq ?? _seq,
  description: description ?? _description,
);
  String? get type => _type;
  String? get seq => _seq;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['seq'] = _seq;
    map['Description'] = _description;
    return map;
  }

}

/// NoOfAccounts : "7"
/// NoOfActiveAccounts : "7"
/// NoOfWriteOffs : "0"
/// TotalPastDue : "0.00"
/// MostSevereStatusWithIn24Months : "30+"
/// SingleHighestCredit : "3154.00"
/// SingleHighestSanctionAmount : "70000.00"
/// TotalHighCredit : "4976.00"
/// AverageOpenBalance : "650.14"
/// SingleHighestBalance : "3303.00"
/// NoOfPastDueAccounts : "0"
/// NoOfZeroBalanceAccounts : "4"
/// RecentAccount : "Credit Card on 07-11-2022"
/// OldestAccount : "Personal Loan on 11-01-2020"
/// TotalBalanceAmount : "4551.00"
/// TotalSanctionAmount : "77599.00"
/// TotalCreditLimit : "23800.0"
/// TotalMonthlyPaymentAmount : "994.00"

RetailAccountsSummary retailAccountsSummaryFromJson(String str) => RetailAccountsSummary.fromJson(json.decode(str));
String retailAccountsSummaryToJson(RetailAccountsSummary data) => json.encode(data.toJson());
class RetailAccountsSummary {
  RetailAccountsSummary({
      String? noOfAccounts, 
      String? noOfActiveAccounts, 
      String? noOfWriteOffs, 
      String? totalPastDue, 
      String? mostSevereStatusWithIn24Months, 
      String? singleHighestCredit, 
      String? singleHighestSanctionAmount, 
      String? totalHighCredit, 
      String? averageOpenBalance, 
      String? singleHighestBalance, 
      String? noOfPastDueAccounts, 
      String? noOfZeroBalanceAccounts, 
      String? recentAccount, 
      String? oldestAccount, 
      String? totalBalanceAmount, 
      String? totalSanctionAmount, 
      String? totalCreditLimit, 
      String? totalMonthlyPaymentAmount,}){
    _noOfAccounts = noOfAccounts;
    _noOfActiveAccounts = noOfActiveAccounts;
    _noOfWriteOffs = noOfWriteOffs;
    _totalPastDue = totalPastDue;
    _mostSevereStatusWithIn24Months = mostSevereStatusWithIn24Months;
    _singleHighestCredit = singleHighestCredit;
    _singleHighestSanctionAmount = singleHighestSanctionAmount;
    _totalHighCredit = totalHighCredit;
    _averageOpenBalance = averageOpenBalance;
    _singleHighestBalance = singleHighestBalance;
    _noOfPastDueAccounts = noOfPastDueAccounts;
    _noOfZeroBalanceAccounts = noOfZeroBalanceAccounts;
    _recentAccount = recentAccount;
    _oldestAccount = oldestAccount;
    _totalBalanceAmount = totalBalanceAmount;
    _totalSanctionAmount = totalSanctionAmount;
    _totalCreditLimit = totalCreditLimit;
    _totalMonthlyPaymentAmount = totalMonthlyPaymentAmount;
}

  RetailAccountsSummary.fromJson(dynamic json) {
    _noOfAccounts = json['NoOfAccounts'];
    _noOfActiveAccounts = json['NoOfActiveAccounts'];
    _noOfWriteOffs = json['NoOfWriteOffs'];
    _totalPastDue = json['TotalPastDue'];
    _mostSevereStatusWithIn24Months = json['MostSevereStatusWithIn24Months'];
    _singleHighestCredit = json['SingleHighestCredit'];
    _singleHighestSanctionAmount = json['SingleHighestSanctionAmount'];
    _totalHighCredit = json['TotalHighCredit'];
    _averageOpenBalance = json['AverageOpenBalance'];
    _singleHighestBalance = json['SingleHighestBalance'];
    _noOfPastDueAccounts = json['NoOfPastDueAccounts'];
    _noOfZeroBalanceAccounts = json['NoOfZeroBalanceAccounts'];
    _recentAccount = json['RecentAccount'];
    _oldestAccount = json['OldestAccount'];
    _totalBalanceAmount = json['TotalBalanceAmount'];
    _totalSanctionAmount = json['TotalSanctionAmount'];
    _totalCreditLimit = json['TotalCreditLimit'];
    _totalMonthlyPaymentAmount = json['TotalMonthlyPaymentAmount'];
  }
  String? _noOfAccounts;
  String? _noOfActiveAccounts;
  String? _noOfWriteOffs;
  String? _totalPastDue;
  String? _mostSevereStatusWithIn24Months;
  String? _singleHighestCredit;
  String? _singleHighestSanctionAmount;
  String? _totalHighCredit;
  String? _averageOpenBalance;
  String? _singleHighestBalance;
  String? _noOfPastDueAccounts;
  String? _noOfZeroBalanceAccounts;
  String? _recentAccount;
  String? _oldestAccount;
  String? _totalBalanceAmount;
  String? _totalSanctionAmount;
  String? _totalCreditLimit;
  String? _totalMonthlyPaymentAmount;
RetailAccountsSummary copyWith({  String? noOfAccounts,
  String? noOfActiveAccounts,
  String? noOfWriteOffs,
  String? totalPastDue,
  String? mostSevereStatusWithIn24Months,
  String? singleHighestCredit,
  String? singleHighestSanctionAmount,
  String? totalHighCredit,
  String? averageOpenBalance,
  String? singleHighestBalance,
  String? noOfPastDueAccounts,
  String? noOfZeroBalanceAccounts,
  String? recentAccount,
  String? oldestAccount,
  String? totalBalanceAmount,
  String? totalSanctionAmount,
  String? totalCreditLimit,
  String? totalMonthlyPaymentAmount,
}) => RetailAccountsSummary(  noOfAccounts: noOfAccounts ?? _noOfAccounts,
  noOfActiveAccounts: noOfActiveAccounts ?? _noOfActiveAccounts,
  noOfWriteOffs: noOfWriteOffs ?? _noOfWriteOffs,
  totalPastDue: totalPastDue ?? _totalPastDue,
  mostSevereStatusWithIn24Months: mostSevereStatusWithIn24Months ?? _mostSevereStatusWithIn24Months,
  singleHighestCredit: singleHighestCredit ?? _singleHighestCredit,
  singleHighestSanctionAmount: singleHighestSanctionAmount ?? _singleHighestSanctionAmount,
  totalHighCredit: totalHighCredit ?? _totalHighCredit,
  averageOpenBalance: averageOpenBalance ?? _averageOpenBalance,
  singleHighestBalance: singleHighestBalance ?? _singleHighestBalance,
  noOfPastDueAccounts: noOfPastDueAccounts ?? _noOfPastDueAccounts,
  noOfZeroBalanceAccounts: noOfZeroBalanceAccounts ?? _noOfZeroBalanceAccounts,
  recentAccount: recentAccount ?? _recentAccount,
  oldestAccount: oldestAccount ?? _oldestAccount,
  totalBalanceAmount: totalBalanceAmount ?? _totalBalanceAmount,
  totalSanctionAmount: totalSanctionAmount ?? _totalSanctionAmount,
  totalCreditLimit: totalCreditLimit ?? _totalCreditLimit,
  totalMonthlyPaymentAmount: totalMonthlyPaymentAmount ?? _totalMonthlyPaymentAmount,
);
  String? get noOfAccounts => _noOfAccounts;
  String? get noOfActiveAccounts => _noOfActiveAccounts;
  String? get noOfWriteOffs => _noOfWriteOffs;
  String? get totalPastDue => _totalPastDue;
  String? get mostSevereStatusWithIn24Months => _mostSevereStatusWithIn24Months;
  String? get singleHighestCredit => _singleHighestCredit;
  String? get singleHighestSanctionAmount => _singleHighestSanctionAmount;
  String? get totalHighCredit => _totalHighCredit;
  String? get averageOpenBalance => _averageOpenBalance;
  String? get singleHighestBalance => _singleHighestBalance;
  String? get noOfPastDueAccounts => _noOfPastDueAccounts;
  String? get noOfZeroBalanceAccounts => _noOfZeroBalanceAccounts;
  String? get recentAccount => _recentAccount;
  String? get oldestAccount => _oldestAccount;
  String? get totalBalanceAmount => _totalBalanceAmount;
  String? get totalSanctionAmount => _totalSanctionAmount;
  String? get totalCreditLimit => _totalCreditLimit;
  String? get totalMonthlyPaymentAmount => _totalMonthlyPaymentAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['NoOfAccounts'] = _noOfAccounts;
    map['NoOfActiveAccounts'] = _noOfActiveAccounts;
    map['NoOfWriteOffs'] = _noOfWriteOffs;
    map['TotalPastDue'] = _totalPastDue;
    map['MostSevereStatusWithIn24Months'] = _mostSevereStatusWithIn24Months;
    map['SingleHighestCredit'] = _singleHighestCredit;
    map['SingleHighestSanctionAmount'] = _singleHighestSanctionAmount;
    map['TotalHighCredit'] = _totalHighCredit;
    map['AverageOpenBalance'] = _averageOpenBalance;
    map['SingleHighestBalance'] = _singleHighestBalance;
    map['NoOfPastDueAccounts'] = _noOfPastDueAccounts;
    map['NoOfZeroBalanceAccounts'] = _noOfZeroBalanceAccounts;
    map['RecentAccount'] = _recentAccount;
    map['OldestAccount'] = _oldestAccount;
    map['TotalBalanceAmount'] = _totalBalanceAmount;
    map['TotalSanctionAmount'] = _totalSanctionAmount;
    map['TotalCreditLimit'] = _totalCreditLimit;
    map['TotalMonthlyPaymentAmount'] = _totalMonthlyPaymentAmount;
    return map;
  }

}

/// seq : "1"
/// AccountNumber : "EHNJ00000760858"
/// Institution : "XYZ Bank"
/// AccountType : "Consumer Loan"
/// OwnershipType : "Individual"
/// Balance : "0"
/// PastDueAmount : "0"
/// Open : "Yes"
/// SanctionAmount : "1600"
/// LastPaymentDate : "2023-01-31"
/// DateReported : "2023-02-01"
/// DateOpened : "2022-05-08"
/// TermFrequency : "Monthly"
/// AccountStatus : "Current Account"
/// AssetClassification : "Standard"
/// source : "INDIVIDUAL"
/// History48Months : [{"key":"02-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"},{"key":"01-23","PaymentStatus":"000","SuitFiledStatus":"*","AssetClassificationStatus":"STD"}]

RetailAccountDetails retailAccountDetailsFromJson(String str) => RetailAccountDetails.fromJson(json.decode(str));
String retailAccountDetailsToJson(RetailAccountDetails data) => json.encode(data.toJson());
class RetailAccountDetails {
  RetailAccountDetails({
      String? seq, 
      String? accountNumber, 
      String? institution, 
      String? accountType, 
      String? ownershipType, 
      String? balance, 
      String? pastDueAmount, 
      String? open, 
      String? sanctionAmount, 
      String? lastPaymentDate, 
      String? dateReported, 
      String? dateOpened, 
      String? termFrequency, 
      String? accountStatus, 
      String? assetClassification, 
      String? source, 
      List<History48Months>? history48Months,}){
    _seq = seq;
    _accountNumber = accountNumber;
    _institution = institution;
    _accountType = accountType;
    _ownershipType = ownershipType;
    _balance = balance;
    _pastDueAmount = pastDueAmount;
    _open = open;
    _sanctionAmount = sanctionAmount;
    _lastPaymentDate = lastPaymentDate;
    _dateReported = dateReported;
    _dateOpened = dateOpened;
    _termFrequency = termFrequency;
    _accountStatus = accountStatus;
    _assetClassification = assetClassification;
    _source = source;
    _history48Months = history48Months;
}

  RetailAccountDetails.fromJson(dynamic json) {
    _seq = json['seq'];
    _accountNumber = json['AccountNumber'];
    _institution = json['Institution'];
    _accountType = json['AccountType'];
    _ownershipType = json['OwnershipType'];
    _balance = json['Balance'];
    _pastDueAmount = json['PastDueAmount'];
    _open = json['Open'];
    _sanctionAmount = json['SanctionAmount'];
    _lastPaymentDate = json['LastPaymentDate'];
    _dateReported = json['DateReported'];
    _dateOpened = json['DateOpened'];
    _termFrequency = json['TermFrequency'];
    _accountStatus = json['AccountStatus'];
    _assetClassification = json['AssetClassification'];
    _source = json['source'];
    if (json['History48Months'] != null) {
      _history48Months = [];
      json['History48Months'].forEach((v) {
        _history48Months?.add(History48Months.fromJson(v));
      });
    }
  }
  String? _seq;
  String? _accountNumber;
  String? _institution;
  String? _accountType;
  String? _ownershipType;
  String? _balance;
  String? _pastDueAmount;
  String? _open;
  String? _sanctionAmount;
  String? _lastPaymentDate;
  String? _dateReported;
  String? _dateOpened;
  String? _termFrequency;
  String? _accountStatus;
  String? _assetClassification;
  String? _source;
  List<History48Months>? _history48Months;
RetailAccountDetails copyWith({  String? seq,
  String? accountNumber,
  String? institution,
  String? accountType,
  String? ownershipType,
  String? balance,
  String? pastDueAmount,
  String? open,
  String? sanctionAmount,
  String? lastPaymentDate,
  String? dateReported,
  String? dateOpened,
  String? termFrequency,
  String? accountStatus,
  String? assetClassification,
  String? source,
  List<History48Months>? history48Months,
}) => RetailAccountDetails(  seq: seq ?? _seq,
  accountNumber: accountNumber ?? _accountNumber,
  institution: institution ?? _institution,
  accountType: accountType ?? _accountType,
  ownershipType: ownershipType ?? _ownershipType,
  balance: balance ?? _balance,
  pastDueAmount: pastDueAmount ?? _pastDueAmount,
  open: open ?? _open,
  sanctionAmount: sanctionAmount ?? _sanctionAmount,
  lastPaymentDate: lastPaymentDate ?? _lastPaymentDate,
  dateReported: dateReported ?? _dateReported,
  dateOpened: dateOpened ?? _dateOpened,
  termFrequency: termFrequency ?? _termFrequency,
  accountStatus: accountStatus ?? _accountStatus,
  assetClassification: assetClassification ?? _assetClassification,
  source: source ?? _source,
  history48Months: history48Months ?? _history48Months,
);
  String? get seq => _seq;
  String? get accountNumber => _accountNumber;
  String? get institution => _institution;
  String? get accountType => _accountType;
  String? get ownershipType => _ownershipType;
  String? get balance => _balance;
  String? get pastDueAmount => _pastDueAmount;
  String? get open => _open;
  String? get sanctionAmount => _sanctionAmount;
  String? get lastPaymentDate => _lastPaymentDate;
  String? get dateReported => _dateReported;
  String? get dateOpened => _dateOpened;
  String? get termFrequency => _termFrequency;
  String? get accountStatus => _accountStatus;
  String? get assetClassification => _assetClassification;
  String? get source => _source;
  List<History48Months>? get history48Months => _history48Months;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['AccountNumber'] = _accountNumber;
    map['Institution'] = _institution;
    map['AccountType'] = _accountType;
    map['OwnershipType'] = _ownershipType;
    map['Balance'] = _balance;
    map['PastDueAmount'] = _pastDueAmount;
    map['Open'] = _open;
    map['SanctionAmount'] = _sanctionAmount;
    map['LastPaymentDate'] = _lastPaymentDate;
    map['DateReported'] = _dateReported;
    map['DateOpened'] = _dateOpened;
    map['TermFrequency'] = _termFrequency;
    map['AccountStatus'] = _accountStatus;
    map['AssetClassification'] = _assetClassification;
    map['source'] = _source;
    if (_history48Months != null) {
      map['History48Months'] = _history48Months?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// key : "02-23"
/// PaymentStatus : "000"
/// SuitFiledStatus : "*"
/// AssetClassificationStatus : "STD"

History48Months history48MonthsFromJson(String str) => History48Months.fromJson(json.decode(str));
String history48MonthsToJson(History48Months data) => json.encode(data.toJson());
class History48Months {
  History48Months({
      String? key, 
      String? paymentStatus, 
      String? suitFiledStatus, 
      String? assetClassificationStatus,}){
    _key = key;
    _paymentStatus = paymentStatus;
    _suitFiledStatus = suitFiledStatus;
    _assetClassificationStatus = assetClassificationStatus;
}

  History48Months.fromJson(dynamic json) {
    _key = json['key'];
    _paymentStatus = json['PaymentStatus'];
    _suitFiledStatus = json['SuitFiledStatus'];
    _assetClassificationStatus = json['AssetClassificationStatus'];
  }
  String? _key;
  String? _paymentStatus;
  String? _suitFiledStatus;
  String? _assetClassificationStatus;
History48Months copyWith({  String? key,
  String? paymentStatus,
  String? suitFiledStatus,
  String? assetClassificationStatus,
}) => History48Months(  key: key ?? _key,
  paymentStatus: paymentStatus ?? _paymentStatus,
  suitFiledStatus: suitFiledStatus ?? _suitFiledStatus,
  assetClassificationStatus: assetClassificationStatus ?? _assetClassificationStatus,
);
  String? get key => _key;
  String? get paymentStatus => _paymentStatus;
  String? get suitFiledStatus => _suitFiledStatus;
  String? get assetClassificationStatus => _assetClassificationStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['PaymentStatus'] = _paymentStatus;
    map['SuitFiledStatus'] = _suitFiledStatus;
    map['AssetClassificationStatus'] = _assetClassificationStatus;
    return map;
  }

}

/// PersonalInfo : {"Name":{"FullName":"ABCDEFG JKLM NOP ","FirstName":"ABCDEFG ","LastName":"NOP "},"DateOfBirth":"2000-11-09","Gender":"Male","Age":{"Age":"22"}}
/// IdentityInfo : {"PANId":[{"seq":"1","ReportedDate":"2022-12-31","IdNumber":"JDKNB0937J"}],"NationalIDCard":[{"seq":"1","ReportedDate":"2021-02-28","IdNumber":"XXXXXXXXXXXX"}]}
/// AddressInfo : [{"Seq":"1","ReportedDate":"2022-12-31","Address":"HOUSE NO 94 XXXXXXXX SXXXX  XXXXX XXXXXXX","State":"OR","Postal":"99999"},{"Seq":"2","ReportedDate":"2022-11-30","Address":"XXXXXXXXXXXXXXXXXXXXX","State":"DL","Postal":"110015","Type":"Office"},{"Seq":"3","ReportedDate":"2022-08-31","Address":"XXXXXXXXXXXXX","State":"OR","Postal":"761119"},{"Seq":"4","ReportedDate":"2022-03-31","Address":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","State":"OR","Postal":"000009","Type":"Primary"},{"Seq":"5","ReportedDate":"2021-10-01","Address":"XXXXXXXXXXXXXXXX","state":"or","postal":"999999","type":"primary"}]
/// phoneinfo : [{"seq":"1","typecode":"m","reporteddate":"2022-12-31","number":"9348412533"},{"seq":"2","typecode":"m","reporteddate":"2022-11-30","number":"919348412533"}]
/// emailaddressinfo : [{"seq":"1","reporteddate":"2022-11-30","emailaddress":"mailto:abcd@gmail.com"}]

IdAndContactInfo idAndContactInfoFromJson(String str) => IdAndContactInfo.fromJson(json.decode(str));
String idAndContactInfoToJson(IdAndContactInfo data) => json.encode(data.toJson());
class IdAndContactInfo {
  IdAndContactInfo({
      PersonalInfo? personalInfo, 
      IdentityInfo? identityInfo, 
      List<AddressInfo>? addressInfo, 
      List<Phoneinfo>? phoneinfo, 
      List<Emailaddressinfo>? emailaddressinfo,}){
    _personalInfo = personalInfo;
    _identityInfo = identityInfo;
    _addressInfo = addressInfo;
    _phoneinfo = phoneinfo;
    _emailaddressinfo = emailaddressinfo;
}

  IdAndContactInfo.fromJson(dynamic json) {
    _personalInfo = json['PersonalInfo'] != null ? PersonalInfo.fromJson(json['PersonalInfo']) : null;
    _identityInfo = json['IdentityInfo'] != null ? IdentityInfo.fromJson(json['IdentityInfo']) : null;
    if (json['AddressInfo'] != null) {
      _addressInfo = [];
      json['AddressInfo'].forEach((v) {
        _addressInfo?.add(AddressInfo.fromJson(v));
      });
    }
    if (json['phoneinfo'] != null) {
      _phoneinfo = [];
      json['phoneinfo'].forEach((v) {
        _phoneinfo?.add(Phoneinfo.fromJson(v));
      });
    }
    if (json['emailaddressinfo'] != null) {
      _emailaddressinfo = [];
      json['emailaddressinfo'].forEach((v) {
        _emailaddressinfo?.add(Emailaddressinfo.fromJson(v));
      });
    }
  }
  PersonalInfo? _personalInfo;
  IdentityInfo? _identityInfo;
  List<AddressInfo>? _addressInfo;
  List<Phoneinfo>? _phoneinfo;
  List<Emailaddressinfo>? _emailaddressinfo;
IdAndContactInfo copyWith({  PersonalInfo? personalInfo,
  IdentityInfo? identityInfo,
  List<AddressInfo>? addressInfo,
  List<Phoneinfo>? phoneinfo,
  List<Emailaddressinfo>? emailaddressinfo,
}) => IdAndContactInfo(  personalInfo: personalInfo ?? _personalInfo,
  identityInfo: identityInfo ?? _identityInfo,
  addressInfo: addressInfo ?? _addressInfo,
  phoneinfo: phoneinfo ?? _phoneinfo,
  emailaddressinfo: emailaddressinfo ?? _emailaddressinfo,
);
  PersonalInfo? get personalInfo => _personalInfo;
  IdentityInfo? get identityInfo => _identityInfo;
  List<AddressInfo>? get addressInfo => _addressInfo;
  List<Phoneinfo>? get phoneinfo => _phoneinfo;
  List<Emailaddressinfo>? get emailaddressinfo => _emailaddressinfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_personalInfo != null) {
      map['PersonalInfo'] = _personalInfo?.toJson();
    }
    if (_identityInfo != null) {
      map['IdentityInfo'] = _identityInfo?.toJson();
    }
    if (_addressInfo != null) {
      map['AddressInfo'] = _addressInfo?.map((v) => v.toJson()).toList();
    }
    if (_phoneinfo != null) {
      map['phoneinfo'] = _phoneinfo?.map((v) => v.toJson()).toList();
    }
    if (_emailaddressinfo != null) {
      map['emailaddressinfo'] = _emailaddressinfo?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// seq : "1"
/// reporteddate : "2022-11-30"
/// emailaddress : "mailto:abcd@gmail.com"

Emailaddressinfo emailaddressinfoFromJson(String str) => Emailaddressinfo.fromJson(json.decode(str));
String emailaddressinfoToJson(Emailaddressinfo data) => json.encode(data.toJson());
class Emailaddressinfo {
  Emailaddressinfo({
      String? seq, 
      String? reporteddate, 
      String? emailaddress,}){
    _seq = seq;
    _reporteddate = reporteddate;
    _emailaddress = emailaddress;
}

  Emailaddressinfo.fromJson(dynamic json) {
    _seq = json['seq'];
    _reporteddate = json['reporteddate'];
    _emailaddress = json['emailaddress'];
  }
  String? _seq;
  String? _reporteddate;
  String? _emailaddress;
Emailaddressinfo copyWith({  String? seq,
  String? reporteddate,
  String? emailaddress,
}) => Emailaddressinfo(  seq: seq ?? _seq,
  reporteddate: reporteddate ?? _reporteddate,
  emailaddress: emailaddress ?? _emailaddress,
);
  String? get seq => _seq;
  String? get reporteddate => _reporteddate;
  String? get emailaddress => _emailaddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['reporteddate'] = _reporteddate;
    map['emailaddress'] = _emailaddress;
    return map;
  }

}

/// seq : "1"
/// typecode : "m"
/// reporteddate : "2022-12-31"
/// number : "9348412533"

Phoneinfo phoneinfoFromJson(String str) => Phoneinfo.fromJson(json.decode(str));
String phoneinfoToJson(Phoneinfo data) => json.encode(data.toJson());
class Phoneinfo {
  Phoneinfo({
      String? seq, 
      String? typecode, 
      String? reporteddate, 
      String? number,}){
    _seq = seq;
    _typecode = typecode;
    _reporteddate = reporteddate;
    _number = number;
}

  Phoneinfo.fromJson(dynamic json) {
    _seq = json['seq'];
    _typecode = json['typecode'];
    _reporteddate = json['reporteddate'];
    _number = json['number'];
  }
  String? _seq;
  String? _typecode;
  String? _reporteddate;
  String? _number;
Phoneinfo copyWith({  String? seq,
  String? typecode,
  String? reporteddate,
  String? number,
}) => Phoneinfo(  seq: seq ?? _seq,
  typecode: typecode ?? _typecode,
  reporteddate: reporteddate ?? _reporteddate,
  number: number ?? _number,
);
  String? get seq => _seq;
  String? get typecode => _typecode;
  String? get reporteddate => _reporteddate;
  String? get number => _number;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['typecode'] = _typecode;
    map['reporteddate'] = _reporteddate;
    map['number'] = _number;
    return map;
  }

}

/// Seq : "1"
/// ReportedDate : "2022-12-31"
/// Address : "HOUSE NO 94 XXXXXXXX SXXXX  XXXXX XXXXXXX"
/// State : "OR"
/// Postal : "99999"

AddressInfo addressInfoFromJson(String str) => AddressInfo.fromJson(json.decode(str));
String addressInfoToJson(AddressInfo data) => json.encode(data.toJson());
class AddressInfo {
  AddressInfo({
      String? seq, 
      String? reportedDate, 
      String? address, 
      String? state, 
      String? postal,}){
    _seq = seq;
    _reportedDate = reportedDate;
    _address = address;
    _state = state;
    _postal = postal;
}

  AddressInfo.fromJson(dynamic json) {
    _seq = json['Seq'];
    _reportedDate = json['ReportedDate'];
    _address = json['Address'];
    _state = json['State'];
    _postal = json['Postal'];
  }
  String? _seq;
  String? _reportedDate;
  String? _address;
  String? _state;
  String? _postal;
AddressInfo copyWith({  String? seq,
  String? reportedDate,
  String? address,
  String? state,
  String? postal,
}) => AddressInfo(  seq: seq ?? _seq,
  reportedDate: reportedDate ?? _reportedDate,
  address: address ?? _address,
  state: state ?? _state,
  postal: postal ?? _postal,
);
  String? get seq => _seq;
  String? get reportedDate => _reportedDate;
  String? get address => _address;
  String? get state => _state;
  String? get postal => _postal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Seq'] = _seq;
    map['ReportedDate'] = _reportedDate;
    map['Address'] = _address;
    map['State'] = _state;
    map['Postal'] = _postal;
    return map;
  }

}

/// PANId : [{"seq":"1","ReportedDate":"2022-12-31","IdNumber":"JDKNB0937J"}]
/// NationalIDCard : [{"seq":"1","ReportedDate":"2021-02-28","IdNumber":"XXXXXXXXXXXX"}]

IdentityInfo identityInfoFromJson(String str) => IdentityInfo.fromJson(json.decode(str));
String identityInfoToJson(IdentityInfo data) => json.encode(data.toJson());
class IdentityInfo {
  IdentityInfo({
      List<PanId>? pANId, 
      List<NationalIdCard>? nationalIDCard,}){
    _pANId = pANId;
    _nationalIDCard = nationalIDCard;
}

  IdentityInfo.fromJson(dynamic json) {
    if (json['PANId'] != null) {
      _pANId = [];
      json['PANId'].forEach((v) {
        _pANId?.add(PanId.fromJson(v));
      });
    }
    if (json['NationalIDCard'] != null) {
      _nationalIDCard = [];
      json['NationalIDCard'].forEach((v) {
        _nationalIDCard?.add(NationalIdCard.fromJson(v));
      });
    }
  }
  List<PanId>? _pANId;
  List<NationalIdCard>? _nationalIDCard;
IdentityInfo copyWith({  List<PanId>? pANId,
  List<NationalIdCard>? nationalIDCard,
}) => IdentityInfo(  pANId: pANId ?? _pANId,
  nationalIDCard: nationalIDCard ?? _nationalIDCard,
);
  List<PanId>? get pANId => _pANId;
  List<NationalIdCard>? get nationalIDCard => _nationalIDCard;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_pANId != null) {
      map['PANId'] = _pANId?.map((v) => v.toJson()).toList();
    }
    if (_nationalIDCard != null) {
      map['NationalIDCard'] = _nationalIDCard?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// seq : "1"
/// ReportedDate : "2021-02-28"
/// IdNumber : "XXXXXXXXXXXX"

NationalIdCard nationalIdCardFromJson(String str) => NationalIdCard.fromJson(json.decode(str));
String nationalIdCardToJson(NationalIdCard data) => json.encode(data.toJson());
class NationalIdCard {
  NationalIdCard({
      String? seq, 
      String? reportedDate, 
      String? idNumber,}){
    _seq = seq;
    _reportedDate = reportedDate;
    _idNumber = idNumber;
}

  NationalIdCard.fromJson(dynamic json) {
    _seq = json['seq'];
    _reportedDate = json['ReportedDate'];
    _idNumber = json['IdNumber'];
  }
  String? _seq;
  String? _reportedDate;
  String? _idNumber;
NationalIdCard copyWith({  String? seq,
  String? reportedDate,
  String? idNumber,
}) => NationalIdCard(  seq: seq ?? _seq,
  reportedDate: reportedDate ?? _reportedDate,
  idNumber: idNumber ?? _idNumber,
);
  String? get seq => _seq;
  String? get reportedDate => _reportedDate;
  String? get idNumber => _idNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['ReportedDate'] = _reportedDate;
    map['IdNumber'] = _idNumber;
    return map;
  }

}

/// seq : "1"
/// ReportedDate : "2022-12-31"
/// IdNumber : "JDKNB0937J"

PanId panIdFromJson(String str) => PanId.fromJson(json.decode(str));
String panIdToJson(PanId data) => json.encode(data.toJson());
class PanId {
  PanId({
      String? seq, 
      String? reportedDate, 
      String? idNumber,}){
    _seq = seq;
    _reportedDate = reportedDate;
    _idNumber = idNumber;
}

  PanId.fromJson(dynamic json) {
    _seq = json['seq'];
    _reportedDate = json['ReportedDate'];
    _idNumber = json['IdNumber'];
  }
  String? _seq;
  String? _reportedDate;
  String? _idNumber;
PanId copyWith({  String? seq,
  String? reportedDate,
  String? idNumber,
}) => PanId(  seq: seq ?? _seq,
  reportedDate: reportedDate ?? _reportedDate,
  idNumber: idNumber ?? _idNumber,
);
  String? get seq => _seq;
  String? get reportedDate => _reportedDate;
  String? get idNumber => _idNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['ReportedDate'] = _reportedDate;
    map['IdNumber'] = _idNumber;
    return map;
  }

}

/// Name : {"FullName":"ABCDEFG JKLM NOP ","FirstName":"ABCDEFG ","LastName":"NOP "}
/// DateOfBirth : "2000-11-09"
/// Gender : "Male"
/// Age : {"Age":"22"}

PersonalInfo personalInfoFromJson(String str) => PersonalInfo.fromJson(json.decode(str));
String personalInfoToJson(PersonalInfo data) => json.encode(data.toJson());
class PersonalInfo {
  PersonalInfo({
      Name? name, 
      String? dateOfBirth, 
      String? gender, 
      Age? age,}){
    _name = name;
    _dateOfBirth = dateOfBirth;
    _gender = gender;
    _age = age;
}

  PersonalInfo.fromJson(dynamic json) {
    _name = json['Name'] != null ? Name.fromJson(json['Name']) : null;
    _dateOfBirth = json['DateOfBirth'];
    _gender = json['Gender'];
    _age = json['Age'] != null ? Age.fromJson(json['Age']) : null;
  }
  Name? _name;
  String? _dateOfBirth;
  String? _gender;
  Age? _age;
PersonalInfo copyWith({  Name? name,
  String? dateOfBirth,
  String? gender,
  Age? age,
}) => PersonalInfo(  name: name ?? _name,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
  gender: gender ?? _gender,
  age: age ?? _age,
);
  Name? get name => _name;
  String? get dateOfBirth => _dateOfBirth;
  String? get gender => _gender;
  Age? get age => _age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_name != null) {
      map['Name'] = _name?.toJson();
    }
    map['DateOfBirth'] = _dateOfBirth;
    map['Gender'] = _gender;
    if (_age != null) {
      map['Age'] = _age?.toJson();
    }
    return map;
  }

}

/// Age : "22"

Age ageFromJson(String str) => Age.fromJson(json.decode(str));
String ageToJson(Age data) => json.encode(data.toJson());
class Age {
  Age({
      String? age,}){
    _age = age;
}

  Age.fromJson(dynamic json) {
    _age = json['Age'];
  }
  String? _age;
Age copyWith({  String? age,
}) => Age(  age: age ?? _age,
);
  String? get age => _age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Age'] = _age;
    return map;
  }

}

/// FullName : "ABCDEFG JKLM NOP "
/// FirstName : "ABCDEFG "
/// LastName : "NOP "

Name nameFromJson(String str) => Name.fromJson(json.decode(str));
String nameToJson(Name data) => json.encode(data.toJson());
class Name {
  Name({
      String? fullName, 
      String? firstName, 
      String? lastName,}){
    _fullName = fullName;
    _firstName = firstName;
    _lastName = lastName;
}

  Name.fromJson(dynamic json) {
    _fullName = json['FullName'];
    _firstName = json['FirstName'];
    _lastName = json['LastName'];
  }
  String? _fullName;
  String? _firstName;
  String? _lastName;
Name copyWith({  String? fullName,
  String? firstName,
  String? lastName,
}) => Name(  fullName: fullName ?? _fullName,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
);
  String? get fullName => _fullName;
  String? get firstName => _firstName;
  String? get lastName => _lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FullName'] = _fullName;
    map['FirstName'] = _firstName;
    map['LastName'] = _lastName;
    return map;
  }

}

/// Type : "ERS"
/// Version : "3.1"

Score scoreFromJson(String str) => Score.fromJson(json.decode(str));
String scoreToJson(Score data) => json.encode(data.toJson());
class Score {
  Score({
      String? type, 
      String? version,}){
    _type = type;
    _version = version;
}

  Score.fromJson(dynamic json) {
    _type = json['Type'];
    _version = json['Version'];
  }
  String? _type;
  String? _version;
Score copyWith({  String? type,
  String? version,
}) => Score(  type: type ?? _type,
  version: version ?? _version,
);
  String? get type => _type;
  String? get version => _version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Type'] = _type;
    map['Version'] = _version;
    return map;
  }

}

/// InquiryPurpose : "Fleet Card"
/// FirstName : "ABCDEFG"
/// LastName : "XYZAB"
/// InquiryPhones : [{"seq":"1","PhoneType":["M"],"Number":"9999999999"}]
/// IDDetails : [{"seq":"1","IDType":"t","IDValue":"JDKNB0937J","Source":"Inquiry"}]
/// CustomFields : [{"key":"INQUERY_PRODUCT_CODE","value":"PCRLT"}]

InquiryRequestInfo inquiryRequestInfoFromJson(String str) => InquiryRequestInfo.fromJson(json.decode(str));
String inquiryRequestInfoToJson(InquiryRequestInfo data) => json.encode(data.toJson());
class InquiryRequestInfo {
  InquiryRequestInfo({
      String? inquiryPurpose, 
      String? firstName, 
      String? lastName, 
      List<InquiryPhones>? inquiryPhones, 
      List<IdDetails>? iDDetails, 
      List<CustomFields>? customFields,}){
    _inquiryPurpose = inquiryPurpose;
    _firstName = firstName;
    _lastName = lastName;
    _inquiryPhones = inquiryPhones;
    _iDDetails = iDDetails;
    _customFields = customFields;
}

  InquiryRequestInfo.fromJson(dynamic json) {
    _inquiryPurpose = json['InquiryPurpose'];
    _firstName = json['FirstName'];
    _lastName = json['LastName'];
    if (json['InquiryPhones'] != null) {
      _inquiryPhones = [];
      json['InquiryPhones'].forEach((v) {
        _inquiryPhones?.add(InquiryPhones.fromJson(v));
      });
    }
    if (json['IDDetails'] != null) {
      _iDDetails = [];
      json['IDDetails'].forEach((v) {
        _iDDetails?.add(IdDetails.fromJson(v));
      });
    }
    if (json['CustomFields'] != null) {
      _customFields = [];
      json['CustomFields'].forEach((v) {
        _customFields?.add(CustomFields.fromJson(v));
      });
    }
  }
  String? _inquiryPurpose;
  String? _firstName;
  String? _lastName;
  List<InquiryPhones>? _inquiryPhones;
  List<IdDetails>? _iDDetails;
  List<CustomFields>? _customFields;
InquiryRequestInfo copyWith({  String? inquiryPurpose,
  String? firstName,
  String? lastName,
  List<InquiryPhones>? inquiryPhones,
  List<IdDetails>? iDDetails,
  List<CustomFields>? customFields,
}) => InquiryRequestInfo(  inquiryPurpose: inquiryPurpose ?? _inquiryPurpose,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  inquiryPhones: inquiryPhones ?? _inquiryPhones,
  iDDetails: iDDetails ?? _iDDetails,
  customFields: customFields ?? _customFields,
);
  String? get inquiryPurpose => _inquiryPurpose;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  List<InquiryPhones>? get inquiryPhones => _inquiryPhones;
  List<IdDetails>? get iDDetails => _iDDetails;
  List<CustomFields>? get customFields => _customFields;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['InquiryPurpose'] = _inquiryPurpose;
    map['FirstName'] = _firstName;
    map['LastName'] = _lastName;
    if (_inquiryPhones != null) {
      map['InquiryPhones'] = _inquiryPhones?.map((v) => v.toJson()).toList();
    }
    if (_iDDetails != null) {
      map['IDDetails'] = _iDDetails?.map((v) => v.toJson()).toList();
    }
    if (_customFields != null) {
      map['CustomFields'] = _customFields?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// key : "INQUERY_PRODUCT_CODE"
/// value : "PCRLT"

CustomFields customFieldsFromJson(String str) => CustomFields.fromJson(json.decode(str));
String customFieldsToJson(CustomFields data) => json.encode(data.toJson());
class CustomFields {
  CustomFields({
      String? key, 
      String? value,}){
    _key = key;
    _value = value;
}

  CustomFields.fromJson(dynamic json) {
    _key = json['key'];
    _value = json['value'];
  }
  String? _key;
  String? _value;
CustomFields copyWith({  String? key,
  String? value,
}) => CustomFields(  key: key ?? _key,
  value: value ?? _value,
);
  String? get key => _key;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['value'] = _value;
    return map;
  }

}

/// seq : "1"
/// IDType : "t"
/// IDValue : "JDKNB0937J"
/// Source : "Inquiry"

IdDetails idDetailsFromJson(String str) => IdDetails.fromJson(json.decode(str));
String idDetailsToJson(IdDetails data) => json.encode(data.toJson());
class IdDetails {
  IdDetails({
      String? seq, 
      String? iDType, 
      String? iDValue, 
      String? source,}){
    _seq = seq;
    _iDType = iDType;
    _iDValue = iDValue;
    _source = source;
}

  IdDetails.fromJson(dynamic json) {
    _seq = json['seq'];
    _iDType = json['IDType'];
    _iDValue = json['IDValue'];
    _source = json['Source'];
  }
  String? _seq;
  String? _iDType;
  String? _iDValue;
  String? _source;
IdDetails copyWith({  String? seq,
  String? iDType,
  String? iDValue,
  String? source,
}) => IdDetails(  seq: seq ?? _seq,
  iDType: iDType ?? _iDType,
  iDValue: iDValue ?? _iDValue,
  source: source ?? _source,
);
  String? get seq => _seq;
  String? get iDType => _iDType;
  String? get iDValue => _iDValue;
  String? get source => _source;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['IDType'] = _iDType;
    map['IDValue'] = _iDValue;
    map['Source'] = _source;
    return map;
  }

}

/// seq : "1"
/// PhoneType : ["M"]
/// Number : "9999999999"

InquiryPhones inquiryPhonesFromJson(String str) => InquiryPhones.fromJson(json.decode(str));
String inquiryPhonesToJson(InquiryPhones data) => json.encode(data.toJson());
class InquiryPhones {
  InquiryPhones({
      String? seq, 
      List<String>? phoneType, 
      String? number,}){
    _seq = seq;
    _phoneType = phoneType;
    _number = number;
}

  InquiryPhones.fromJson(dynamic json) {
    _seq = json['seq'];
    _phoneType = json['PhoneType'] != null ? json['PhoneType'].cast<String>() : [];
    _number = json['Number'];
  }
  String? _seq;
  List<String>? _phoneType;
  String? _number;
InquiryPhones copyWith({  String? seq,
  List<String>? phoneType,
  String? number,
}) => InquiryPhones(  seq: seq ?? _seq,
  phoneType: phoneType ?? _phoneType,
  number: number ?? _number,
);
  String? get seq => _seq;
  List<String>? get phoneType => _phoneType;
  String? get number => _number;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['PhoneType'] = _phoneType;
    map['Number'] = _number;
    return map;
  }

}

/// CustomerCode : "AFIB"
/// CustRefField : "DB-P23030267"
/// ReportOrderNO : "768987942"
/// TranID : "4682185901"
/// ProductCode : ["PCRLT"]
/// SuccessCode : "1"
/// Date : "2023-03-28"
/// Time : "14:01:57"
/// HitCode : "10"
/// CustomerName : "AFIB"

InquiryResponseHeader inquiryResponseHeaderFromJson(String str) => InquiryResponseHeader.fromJson(json.decode(str));
String inquiryResponseHeaderToJson(InquiryResponseHeader data) => json.encode(data.toJson());
class InquiryResponseHeader {
  InquiryResponseHeader({
      String? customerCode, 
      String? custRefField, 
      String? reportOrderNO, 
      String? tranID, 
      List<String>? productCode, 
      String? successCode, 
      String? date, 
      String? time, 
      String? hitCode, 
      String? customerName,}){
    _customerCode = customerCode;
    _custRefField = custRefField;
    _reportOrderNO = reportOrderNO;
    _tranID = tranID;
    _productCode = productCode;
    _successCode = successCode;
    _date = date;
    _time = time;
    _hitCode = hitCode;
    _customerName = customerName;
}

  InquiryResponseHeader.fromJson(dynamic json) {
    _customerCode = json['CustomerCode'];
    _custRefField = json['CustRefField'];
    _reportOrderNO = json['ReportOrderNO'];
    _tranID = json['TranID'];
    _productCode = json['ProductCode'] != null ? json['ProductCode'].cast<String>() : [];
    _successCode = json['SuccessCode'];
    _date = json['Date'];
    _time = json['Time'];
    _hitCode = json['HitCode'];
    _customerName = json['CustomerName'];
  }
  String? _customerCode;
  String? _custRefField;
  String? _reportOrderNO;
  String? _tranID;
  List<String>? _productCode;
  String? _successCode;
  String? _date;
  String? _time;
  String? _hitCode;
  String? _customerName;
InquiryResponseHeader copyWith({  String? customerCode,
  String? custRefField,
  String? reportOrderNO,
  String? tranID,
  List<String>? productCode,
  String? successCode,
  String? date,
  String? time,
  String? hitCode,
  String? customerName,
}) => InquiryResponseHeader(  customerCode: customerCode ?? _customerCode,
  custRefField: custRefField ?? _custRefField,
  reportOrderNO: reportOrderNO ?? _reportOrderNO,
  tranID: tranID ?? _tranID,
  productCode: productCode ?? _productCode,
  successCode: successCode ?? _successCode,
  date: date ?? _date,
  time: time ?? _time,
  hitCode: hitCode ?? _hitCode,
  customerName: customerName ?? _customerName,
);
  String? get customerCode => _customerCode;
  String? get custRefField => _custRefField;
  String? get reportOrderNO => _reportOrderNO;
  String? get tranID => _tranID;
  List<String>? get productCode => _productCode;
  String? get successCode => _successCode;
  String? get date => _date;
  String? get time => _time;
  String? get hitCode => _hitCode;
  String? get customerName => _customerName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CustomerCode'] = _customerCode;
    map['CustRefField'] = _custRefField;
    map['ReportOrderNO'] = _reportOrderNO;
    map['TranID'] = _tranID;
    map['ProductCode'] = _productCode;
    map['SuccessCode'] = _successCode;
    map['Date'] = _date;
    map['Time'] = _time;
    map['HitCode'] = _hitCode;
    map['CustomerName'] = _customerName;
    return map;
  }

}
//
// /// Type : "ERS"
// /// Version : "3.1"
//
// Score scoreFromJson(String str) => Score.fromJson(json.decode(str));
// String scoreToJson(Score data) => json.encode(data.toJson());
// class Score {
//   Score({
//       String? type,
//       String? version,}){
//     _type = type;
//     _version = version;
// }
//
//   Score.fromJson(dynamic json) {
//     _type = json['Type'];
//     _version = json['Version'];
//   }
//   String? _type;
//   String? _version;
// Score copyWith({  String? type,
//   String? version,
// }) => Score(  type: type ?? _type,
//   version: version ?? _version,
// );
//   String? get type => _type;
//   String? get version => _version;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['Type'] = _type;
//     map['Version'] = _version;
//     return map;
//   }
//
// }
//
// /// InquiryPurpose : "16"
// /// FirstName : "ABCDEFG"
// /// LastName : "XYZAB"
// /// InquiryPhones : [{"seq":"1","PhoneType":["M"],"Number":"9999999999"}]
// /// IDDetails : [{"seq":"1","IDType":"t","IDValue":"JDKNB0937J","Source":"Inquiry"}]
//
// InquiryRequestInfo inquiryRequestInfoFromJson(String str) => InquiryRequestInfo.fromJson(json.decode(str));
// String inquiryRequestInfoToJson(InquiryRequestInfo data) => json.encode(data.toJson());
// class InquiryRequestInfo {
//   InquiryRequestInfo({
//       String? inquiryPurpose,
//       String? firstName,
//       String? lastName,
//       List<InquiryPhones>? inquiryPhones,
//       List<IdDetails>? iDDetails,}){
//     _inquiryPurpose = inquiryPurpose;
//     _firstName = firstName;
//     _lastName = lastName;
//     _inquiryPhones = inquiryPhones;
//     _iDDetails = iDDetails;
// }
//
//   InquiryRequestInfo.fromJson(dynamic json) {
//     _inquiryPurpose = json['InquiryPurpose'];
//     _firstName = json['FirstName'];
//     _lastName = json['LastName'];
//     if (json['InquiryPhones'] != null) {
//       _inquiryPhones = [];
//       json['InquiryPhones'].forEach((v) {
//         _inquiryPhones?.add(InquiryPhones.fromJson(v));
//       });
//     }
//     if (json['IDDetails'] != null) {
//       _iDDetails = [];
//       json['IDDetails'].forEach((v) {
//         _iDDetails?.add(IdDetails.fromJson(v));
//       });
//     }
//   }
//   String? _inquiryPurpose;
//   String? _firstName;
//   String? _lastName;
//   List<InquiryPhones>? _inquiryPhones;
//   List<IdDetails>? _iDDetails;
// InquiryRequestInfo copyWith({  String? inquiryPurpose,
//   String? firstName,
//   String? lastName,
//   List<InquiryPhones>? inquiryPhones,
//   List<IdDetails>? iDDetails,
// }) => InquiryRequestInfo(  inquiryPurpose: inquiryPurpose ?? _inquiryPurpose,
//   firstName: firstName ?? _firstName,
//   lastName: lastName ?? _lastName,
//   inquiryPhones: inquiryPhones ?? _inquiryPhones,
//   iDDetails: iDDetails ?? _iDDetails,
// );
//   String? get inquiryPurpose => _inquiryPurpose;
//   String? get firstName => _firstName;
//   String? get lastName => _lastName;
//   List<InquiryPhones>? get inquiryPhones => _inquiryPhones;
//   List<IdDetails>? get iDDetails => _iDDetails;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['InquiryPurpose'] = _inquiryPurpose;
//     map['FirstName'] = _firstName;
//     map['LastName'] = _lastName;
//     if (_inquiryPhones != null) {
//       map['InquiryPhones'] = _inquiryPhones?.map((v) => v.toJson()).toList();
//     }
//     if (_iDDetails != null) {
//       map['IDDetails'] = _iDDetails?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// seq : "1"
// /// IDType : "t"
// /// IDValue : "JDKNB0937J"
// /// Source : "Inquiry"
//
// IdDetails idDetailsFromJson(String str) => IdDetails.fromJson(json.decode(str));
// String idDetailsToJson(IdDetails data) => json.encode(data.toJson());
// class IdDetails {
//   IdDetails({
//       String? seq,
//       String? iDType,
//       String? iDValue,
//       String? source,}){
//     _seq = seq;
//     _iDType = iDType;
//     _iDValue = iDValue;
//     _source = source;
// }
//
//   IdDetails.fromJson(dynamic json) {
//     _seq = json['seq'];
//     _iDType = json['IDType'];
//     _iDValue = json['IDValue'];
//     _source = json['Source'];
//   }
//   String? _seq;
//   String? _iDType;
//   String? _iDValue;
//   String? _source;
// IdDetails copyWith({  String? seq,
//   String? iDType,
//   String? iDValue,
//   String? source,
// }) => IdDetails(  seq: seq ?? _seq,
//   iDType: iDType ?? _iDType,
//   iDValue: iDValue ?? _iDValue,
//   source: source ?? _source,
// );
//   String? get seq => _seq;
//   String? get iDType => _iDType;
//   String? get iDValue => _iDValue;
//   String? get source => _source;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['seq'] = _seq;
//     map['IDType'] = _iDType;
//     map['IDValue'] = _iDValue;
//     map['Source'] = _source;
//     return map;
//   }
//
// }
//
// /// seq : "1"
// /// PhoneType : ["M"]
// /// Number : "9999999999"
//
// InquiryPhones inquiryPhonesFromJson(String str) => InquiryPhones.fromJson(json.decode(str));
// String inquiryPhonesToJson(InquiryPhones data) => json.encode(data.toJson());
// class InquiryPhones {
//   InquiryPhones({
//       String? seq,
//       List<String>? phoneType,
//       String? number,}){
//     _seq = seq;
//     _phoneType = phoneType;
//     _number = number;
// }
//
//   InquiryPhones.fromJson(dynamic json) {
//     _seq = json['seq'];
//     _phoneType = json['PhoneType'] != null ? json['PhoneType'].cast<String>() : [];
//     _number = json['Number'];
//   }
//   String? _seq;
//   List<String>? _phoneType;
//   String? _number;
// InquiryPhones copyWith({  String? seq,
//   List<String>? phoneType,
//   String? number,
// }) => InquiryPhones(  seq: seq ?? _seq,
//   phoneType: phoneType ?? _phoneType,
//   number: number ?? _number,
// );
//   String? get seq => _seq;
//   List<String>? get phoneType => _phoneType;
//   String? get number => _number;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['seq'] = _seq;
//     map['PhoneType'] = _phoneType;
//     map['Number'] = _number;
//     return map;
//   }
//
// }
//
// /// ClientID : "027FP27964"
// /// CustRefField : "DB-P23030267"
// /// ReportOrderNO : "768987942"
// /// ProductCode : ["PCRLT"]
// /// SuccessCode : "1"
// /// Date : "2023-03-28"
// /// Time : "14:01:58"
//
// InquiryResponseHeader inquiryResponseHeaderFromJson(String str) => InquiryResponseHeader.fromJson(json.decode(str));
// String inquiryResponseHeaderToJson(InquiryResponseHeader data) => json.encode(data.toJson());
// class InquiryResponseHeader {
//   InquiryResponseHeader({
//       String? clientID,
//       String? custRefField,
//       String? reportOrderNO,
//       List<String>? productCode,
//       String? successCode,
//       String? date,
//       String? time,}){
//     _clientID = clientID;
//     _custRefField = custRefField;
//     _reportOrderNO = reportOrderNO;
//     _productCode = productCode;
//     _successCode = successCode;
//     _date = date;
//     _time = time;
// }
//
//   InquiryResponseHeader.fromJson(dynamic json) {
//     _clientID = json['ClientID'];
//     _custRefField = json['CustRefField'];
//     _reportOrderNO = json['ReportOrderNO'];
//     _productCode = json['ProductCode'] != null ? json['ProductCode'].cast<String>() : [];
//     _successCode = json['SuccessCode'];
//     _date = json['Date'];
//     _time = json['Time'];
//   }
//   String? _clientID;
//   String? _custRefField;
//   String? _reportOrderNO;
//   List<String>? _productCode;
//   String? _successCode;
//   String? _date;
//   String? _time;
// InquiryResponseHeader copyWith({  String? clientID,
//   String? custRefField,
//   String? reportOrderNO,
//   List<String>? productCode,
//   String? successCode,
//   String? date,
//   String? time,
// }) => InquiryResponseHeader(  clientID: clientID ?? _clientID,
//   custRefField: custRefField ?? _custRefField,
//   reportOrderNO: reportOrderNO ?? _reportOrderNO,
//   productCode: productCode ?? _productCode,
//   successCode: successCode ?? _successCode,
//   date: date ?? _date,
//   time: time ?? _time,
// );
//   String? get clientID => _clientID;
//   String? get custRefField => _custRefField;
//   String? get reportOrderNO => _reportOrderNO;
//   List<String>? get productCode => _productCode;
//   String? get successCode => _successCode;
//   String? get date => _date;
//   String? get time => _time;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['ClientID'] = _clientID;
//     map['CustRefField'] = _custRefField;
//     map['ReportOrderNO'] = _reportOrderNO;
//     map['ProductCode'] = _productCode;
//     map['SuccessCode'] = _successCode;
//     map['Date'] = _date;
//     map['Time'] = _time;
//     return map;
//   }
//
// }