import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/core/base/consts/color_cons.dart';
import 'controllers/splash.controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstants.colorGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/icon_login_secure.png",
              height: screenHeight * 0.1,
              width: screenWidth * 0.3, // Constrain width
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.03),
            const Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "S",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Sonsie',
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "ecure your Land !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Sonsie',
                      color: Colors.white,
                    ),
                  ),
                ])
          ],
        ),
      ),
    );
  }
}
