import 'package:intl/intl.dart';

NumberFormat axleCurrencyFormatter = NumberFormat.currency(
  name: "INR",
  locale: "en_IN",
  symbol: "₹",
  decimalDigits: 0,
);

NumberFormat axleCurrencyFormatterwithDecimals = NumberFormat.currency(
  name: "INR",
  locale: "en_IN",
  symbol: "₹",
  decimalDigits: 2,
);
