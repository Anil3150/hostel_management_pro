import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/broadcast/broadcast.screen.dart';
import '../../presentation/dashboard/dashboard.screen.dart';
import '../../presentation/home/home.screen.dart';
import '../../presentation/login/login.screen.dart';
import '../../presentation/payments/payments.screen.dart';
import '../../presentation/profile/profile.screen.dart';
import '../../presentation/signup/signup.screen.dart';
import '../../presentation/splash/splash.screen.dart';
import 'bindings/controllers/broadcast.controller.binding.dart';
import 'bindings/controllers/dashboard.controller.binding.dart';
import 'bindings/controllers/home.controller.binding.dart';
import 'bindings/controllers/login.controller.binding.dart';
import 'bindings/controllers/payments.controller.binding.dart';
import 'bindings/controllers/profile.controller.binding.dart';
import 'bindings/controllers/signup.controller.binding.dart';
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
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const SignupScreen(),
      binding: SignupControllerBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardScreen(),
      binding: DashboardControllerBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.BROADCAST,
      page: () => const BroadcastScreen(),
      binding: BroadcastControllerBinding(),
    ),
    GetPage(
      name: Routes.PAYMENTS,
      page: () => const PaymentsScreen(),
      binding: PaymentsControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileControllerBinding(),
    ),
  ];
}
