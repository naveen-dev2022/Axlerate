import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum SnackbarType {
  success,
  warn,
  error,
}

class SnackbarConfig {
  String webBgColor;
  Color backgroundColor;
  Color textColor;

  SnackbarConfig(this.webBgColor, this.backgroundColor, this.textColor);
}

class Snackbar {
  SnackbarType type;
  String message;


  // static showSnackBar(String msg){
  //   Fluttertoast.showToast(
  //     msg: msg,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: kIsWeb ? ToastGravity.TOP : ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 7,
  //     webBgColor: config.webBgColor,
  //     backgroundColor: config.backgroundColor,
  //     textColor: config.textColor,
  //     fontSize: 16.0,
  //   );
  // }

  Snackbar(this.type, this.message) {
    SnackbarConfig config = _getConfig(type);
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: kIsWeb ? ToastGravity.TOP : ToastGravity.BOTTOM,
      timeInSecForIosWeb: 7,
      webBgColor: config.webBgColor,
      backgroundColor: config.backgroundColor,
      textColor: config.textColor,
      fontSize: 16.0,
    );
  }

  static void success(message) {
    if (message != null && message.toString().isEmpty) {
      message = 'Success !';
    }
    Snackbar(SnackbarType.success, message);
  }

  static void warn(message) {
    if (message != null && message.toString().isEmpty) {
      message = 'Caution !';
    }
    Snackbar(SnackbarType.warn, message);
  }

  static void error(message) {
    if (message != null && message.toString().isEmpty) {
      message = 'Something went wrong !';
    }
    Snackbar(SnackbarType.error, message);
  }

  SnackbarConfig _getConfig(SnackbarType type) {
    String webBgColor;
    Color backgroundColor;
    Color textColor;

    switch (type) {
      case SnackbarType.success:
        webBgColor = "linear-gradient(to right, #4CAF50, #4CAF50)";
        backgroundColor = Colors.green;
        textColor = Colors.white;
        break;
      case SnackbarType.warn:
        webBgColor = "linear-gradient(to right, #FFC107, #FFC107)";
        backgroundColor = Colors.amber;
        textColor = Colors.white;
        break;
      case SnackbarType.error:
        webBgColor = "linear-gradient(to right, #F44336, #F44336)";
        backgroundColor = Colors.red;
        textColor = Colors.white;
        break;
    }

    return SnackbarConfig(webBgColor, backgroundColor, textColor);
  }
}
