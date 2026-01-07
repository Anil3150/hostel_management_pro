import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../config.dart';
import '../../presentation/splash/splash.screen.dart';
import 'bindings/controllers/splash.controller.binding.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  final dynamic environment;
  const EnvironmentsBadge({super.key, required this.child, this.environment});
  @override
  Widget build(BuildContext context) {
    // var env = ConfigEnvironments.getEnvironments()['env'];
    return environment != Environments.PRODUCTION
        ? Directionality(
            textDirection: TextDirection.rtl,
            child: Banner(
              location: BannerLocation.topStart,
              message: environment!,
              color:
                  environment == Environments.QAS ? Colors.blue : Colors.purple,
              child: child,
            ),
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashControllerBinding(),
    ),
   
  ];
}
