
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static String dateTimeDisplay(DateTime input, {bool is24HrFormat = true}) {
    return is24HrFormat ? DateFormat('dd-MM-yyyy HH:mm').format(input) : DateFormat('dd-MM-yyyy h:mm a').format(input);
  }

  static String dateTimeApiSend(DateTime input) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(input);
  }

  static String dateTimeDisplayFromString(String input, {bool is24HrFormat = true}) {
    DateTime? dateTime = DateTime.tryParse(input);
    if (dateTime == null) return '';
    return dateTimeDisplay(dateTime, is24HrFormat: is24HrFormat);
  }

  static String dateDisplay(DateTime input) {
    return DateFormat('dd-MM-yyyy').format(input);
  }

  static String dateApiSend(DateTime input) {
    return DateFormat('yyyy-MM-dd').format(input);
  }

  static TimeOfDay timeStringToTimeOfDay24H(String input){
    DateTime dateTime = DateFormat("HH:mm").parse(input);
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
    return timeOfDay;
  }

  static String dateDisplayFromString(String input) {
    DateTime? dateTime = DateTime.tryParse(input);
    if (dateTime == null) return '';
    return dateDisplay(dateTime);
  }

}
