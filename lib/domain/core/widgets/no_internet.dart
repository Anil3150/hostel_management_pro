import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../infrastructure/theme/styles/text_styles.dart';

class NoInternetPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
   final VoidCallback onButtonPressed;

  const NoInternetPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
     required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                imagePath,
                height: 200,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style:TextStyles.kTSNFS15.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
             SizedBox(height: Get.height * 0.01),
              Text(
                subtitle,
                style: TextStyles.kTSNFS14.copyWith(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text("Turn On"),
              ),
            ],
          ),
        ),);
  }
}
