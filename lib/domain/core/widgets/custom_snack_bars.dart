import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomSnackbars {
  void showSuccessSnack({title, message}) {
    Get.snackbar(title.toString(), message.toString(),
        snackPosition: SnackPosition.TOP, backgroundColor: Colors.greenAccent);
  }

  void showErrorSnack({title, message}) {
    Get.snackbar(
      title.toString(),
      message.toString(),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void showInfoSnack({title, message}) {
    Get.snackbar(
      title.toString(),
      message.toString(),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
