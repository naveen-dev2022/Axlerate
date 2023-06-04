class Wallet {
  final double balance;
  final String upiId;
  final String? accountNumber;
  final String? ifscCode;
  int? customerLevelCount;
  int? vehicleLevelCount;

  Wallet({
    required this.balance,
    required this.upiId,
    this.accountNumber,
    this.ifscCode,
    this.customerLevelCount = 0,
    this.vehicleLevelCount,
  });
}
