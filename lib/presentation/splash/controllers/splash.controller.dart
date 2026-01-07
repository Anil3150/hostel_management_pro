import 'package:get/get.dart';

import '../../../domain/core/interfaces/base_controller.dart';
import '../../../infrastructure/dal/services/secure_storage_services.dart';
import '../../../infrastructure/navigation/routes.dart';

class SplashController extends BaseController {
  final count = 0.obs;
  @override
  void onInit() {
    navigateToHome();
    super.onInit();
  }

  Future<void> navigateToHome() async {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      final token = await SecureStorageServices().readSecureData(key: 'TOKEN');
      if (token != null) {
        Get.offAllNamed(Routes.DASHBOARD);
      } else if (token == null) {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}
