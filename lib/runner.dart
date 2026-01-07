import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './config.dart';
import 'domain/core/widgets/check_service_controller.dart';
import 'infrastructure/navigation/navigation.dart';

class Runner extends StatelessWidget {
  final String initialRoute;
  const Runner(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckServicesController(), permanent: true);
    return
        // DevicePreview(
        //   builder: (context) =>
        EnvironmentsBadge(
      environment: Environments.runEnv,
      child: GetMaterialApp(
        color: Colors.white,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        getPages: Nav.routes,
      ),

      // ),
    );
  }
}
