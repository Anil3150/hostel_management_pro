import 'package:get/get.dart';
import 'package:hostel_management_pro/domain/core/interfaces/base_controller.dart';

class DashboardController extends BaseController {

  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

   void onItemSelected(int index)async{
    selectedIndex.value = index;
    if(selectedIndex.value == 0){
     
    }
    if(selectedIndex.value == 1){
     
    }
    if(selectedIndex.value == 3){
      
    }
  }

  Future<bool> onWillPop()async{
    if(selectedIndex.value == -1){
      return true;
    }
    return false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
