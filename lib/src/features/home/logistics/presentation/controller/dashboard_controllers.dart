import 'package:flutter_riverpod/flutter_riverpod.dart';

final orgDashMainIndexProvider = StateProvider<int>((ref) {
  return 0;
});
final vehDashMainIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final summaryIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final servicesIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final userDashMainIndexProvider = StateProvider<int>((ref) {
  return 0;
});

// * Txn Summary Amount State Providers

final txnTagCreditStateProvider = StateProvider<String?>((ref) {
  return null;
});

final txnTagDebitStateProvider = StateProvider<String?>((ref) {
  return null;
});

final txnPpiCreditStateProvider = StateProvider<String?>((ref) {
  return null;
});

final txnPpiDebitStateProvider = StateProvider<String?>((ref) {
  return null;
});

final partnerTagTxnStateProvider = StateProvider<String?>((ref) {
  return null;
});

final partnerPpiTxnStateProvider = StateProvider<String?>((ref) {
  return null;
});
