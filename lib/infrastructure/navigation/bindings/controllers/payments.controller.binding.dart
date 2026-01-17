import 'package:get/get.dart';

import '../../../../presentation/payments/controllers/payments.controller.dart';

class PaymentsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentsController>(
      () => PaymentsController(),
    );
  }
}
