import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../infrastructure/dal/services/dio_client.dart';
import '../base/enums/api_status.dart';

abstract class BaseController extends GetxController {
  ApiStatus apiStatus = ApiStatus.SUCCESS;
  DioClient client = DioClient();
}
