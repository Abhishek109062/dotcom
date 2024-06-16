import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

void successSnackBar({String msg = '', IconData icon = Icons.check_circle, int duration = 2}) {
  Get.closeCurrentSnackbar();
  Get.closeAllSnackbars();
  Get.showSnackbar(
    GetSnackBar(
      borderColor: Colors.green,
      borderRadius: 10,
      margin: EdgeInsets.all(8),
      messageText: Text(
        msg.isNotEmpty ? msg : ' ',
        style: TextStyle(color: Colors.green),
      ),
      icon: Icon(
        icon,
        color: Colors.green,
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white,
      isDismissible: true, // Allow dismissing by tapping anywhere on the Snackbar
    ),
  );
}

void errorSnackBar(
    {String msg = 'Something Went Wrong.Please Try Again',
    IconData icon = Icons.error_outline,
    int duration = 2,
    int maxLength = 200}) {
  msg = msg.length > 100 ? 'Something Went Wrong.Please Try Again' : msg;

  Get.closeCurrentSnackbar();
  Get.closeAllSnackbars();
  Get.showSnackbar(
    GetSnackBar(
      borderColor: Colors.red,
      borderRadius: 10,
      margin: EdgeInsets.all(8),
      messageText: Text(
        msg.isNotEmpty ? msg : ' ',
        style: TextStyle(color: Colors.red),
      ),
      icon: Icon(
        icon,
        color: Colors.red,
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white,
      isDismissible: true, // Allow dismissing by tapping anywhere on the Snackbar
    ),
  );
}

void infoSnackBar({String msg = '', IconData icon = Icons.message, int duration = 2}) {
  Get.closeCurrentSnackbar();
  Get.closeAllSnackbars();

  Get.showSnackbar(
    GetSnackBar(
      borderColor: Color(0xffFF8000),
      borderRadius: 10,
      margin: EdgeInsets.all(8),
      messageText: Text(
        msg.isNotEmpty ? msg : ' ',
        style: TextStyle(color: Color(0xffFF8000)),
      ),
      icon: Icon(
        icon,
        color: Color(0xffFF8000),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white,
      isDismissible: true, // Allow dismissing by tapping anywhere on the Snackbar
    ),
  );
}
