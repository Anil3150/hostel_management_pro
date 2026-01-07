import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'config.dart';
import 'domain/core/widgets/check_service_controller.dart';
import 'infrastructure/navigation/routes.dart';
import 'runner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initialRoute = await Routes.initialRoute;
  Environments.runEnv = Environments.DEV;
  Get.put(CheckServicesController(), permanent: true);
  runApp(Runner(initialRoute));
}
