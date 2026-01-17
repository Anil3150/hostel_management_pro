import 'package:get/get.dart';

import '../../../infrastructure/dal/services/dio_client.dart';
import '../base/enums/api_status.dart';

abstract class BaseController extends GetxController {
  var apiStatus = ApiStatus.SUCCESS.obs;
  DioClient client = DioClient();
}
