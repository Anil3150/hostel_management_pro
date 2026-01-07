import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'config.dart';
import 'domain/core/widgets/check_service_controller.dart';
import 'runner.dart';

import 'infrastructure/navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initialRoute = await Routes.initialRoute;
  Environments.runEnv = Environments.PRODUCTION;
  Get.put(CheckServicesController(), permanent: true);
  runApp(Runner(initialRoute));
}
