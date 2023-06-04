class CreatePaymentLinkInputModel {
  CreatePaymentLinkInputModel({
    required this.organizationEnrollmentId,
    required this.orderInfo,
    this.referenceId,
    required this.amount,
    required this.customer,
  });

  final String? organizationEnrollmentId;
  final String? orderInfo;
  final String? referenceId;
  final int? amount;
  final Customer? customer;

  Map<String, dynamic> toJson() => {
        "organizationEnrollmentId": organizationEnrollmentId,
        "orderInfo": orderInfo,
        "referenceId": referenceId,
        "amount": amount,
        "customer": customer?.toJson(),
      };
}

class Customer {
  Customer({
    required this.name,
    required this.emailId,
    required this.phone,
    this.customerId,
    required this.isSaveCustomer,
  });

  final String? name;
  final String? emailId;
  final String? phone;
  final String? customerId;
  final bool? isSaveCustomer;

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": emailId,
        "phone": phone,
        //"customerId": customerId,
        "isSaveCustomer": isSaveCustomer,
      };
}
