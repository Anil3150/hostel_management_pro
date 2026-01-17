import 'package:get/get.dart';

import '../../../domain/core/base/consts/app_const.dart';
import '../../../domain/core/interfaces/base_controller.dart';
import '../../../infrastructure/dal/services/secure_storage_services.dart';
import '../../../infrastructure/navigation/routes.dart';

class SplashController extends BaseController {

  var token=''.obs;

  @override
  void onInit() {
    navigateToHome();
    super.onInit();
  }

  Future<void> navigateToHome() async {
    token.value = await SecureStorageServices().readSecureData(key: TOKEN) ?? '';
    print('======================token data================');
    print(token.value);
    if (token.value.isNotEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.toNamed(Routes.DASHBOARD);
      });
    } else if (token.value.isEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.toNamed(Routes.LOGIN);
      });
    }
}
}