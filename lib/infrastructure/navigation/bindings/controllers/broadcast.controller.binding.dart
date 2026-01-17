import 'package:get/get.dart';

import '../../../../presentation/broadcast/controllers/broadcast.controller.dart';

class BroadcastControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BroadcastController>(
      () => BroadcastController(),
    );
  }
}
