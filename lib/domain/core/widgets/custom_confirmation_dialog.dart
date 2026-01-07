import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomConfirmationDialog {
  static void show({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    IconData icon = Icons.warning,
    Color iconColor = Colors.orange,
    Color confirmButtonColor = Colors.redAccent,
    Color confirmTextColor = Colors.white,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 40),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(cancelText, style: const TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: confirmButtonColor,
                    ),
                    onPressed: () {
                      Get.back(); // close the dialog
                      onConfirm(); // execute confirm action
                    },
                    child: Text(confirmText,style: TextStyle(color: confirmTextColor),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
