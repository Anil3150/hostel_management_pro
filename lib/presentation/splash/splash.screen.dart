import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_pro/domain/core/base/consts/img_const.dart';

import 'controllers/splash.controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E3C72),
              Color(0xFF2A5298),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Icon with Glow and Shadow
              Image.asset(
                SvgConstants.logo,
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ),
              // App Name
              const Text(
                'HOSTEL MANAGER',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
              const Text(
                'PRO',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 8,
                  color: Colors.white70,
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
