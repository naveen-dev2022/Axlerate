import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerUtil {
  static Future<DateTime?> pickDate(BuildContext context, {bool showFuture = false, DateTime? showRecentPicked}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: showRecentPicked ?? DateTime.now(), //get today's date
      firstDate: showFuture ? DateTime.now() : DateTime(1920), //DateTime.now() - not to allow to choose before today.
      lastDate: showFuture ? DateTime(2100) : DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    return pickedDate;
  }

  // Accepts DateTime as a  paramater and return that DateTime in dd-mm-yyyy this format
  static dateMonthYearFormatter(DateTime date) => DateFormat('dd-MM-yyyy').format(date);

  static monthYearFormatter(DateTime date) => DateFormat('MM/yyyy').format(date);

  static dateLongMonthYearFormatter(DateTime date) => DateFormat('dd-MMM-yyyy').format(date);

  static yearMonthDateFormatter(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  static dateLongMonthYearWithTimeFormatter(DateTime date) => DateFormat('dd-MMM-yyyy, hh:mm aa').format(date);

  static dateLongMonthYearWithTimeFormatterIsd(DateTime date) =>
      DateFormat('dd-MMM-yyyy, hh:mm aa').format(date.toLocal());

  static dateLongMonthYearWithNewLineTimeFormatter(DateTime date) => DateFormat('HH:mm \nMMM dd, yyyy').format(date);
  static dateLongMonthYearWithNewLineTimeFormatterIsd(DateTime date) =>
      DateFormat('hh:mm aa \nMMM dd, yyyy').format(date.toLocal());

  static dateLongMonthFormatter(DateTime date) => DateFormat('dd-MMM').format(date);

  static userViewDateFormatter(DateTime date) => DateFormat.yMMMd().format(date.toLocal());
}
