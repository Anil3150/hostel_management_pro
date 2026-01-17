import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_pro/domain/core/interfaces/base_controller.dart';
import 'package:hostel_management_pro/infrastructure/dal/services/secure_storage_services.dart';
import 'package:hostel_management_pro/presentation/login/services/login_repo_impl.dart';

import '../../../domain/core/base/consts/app_const.dart';
import '../../../domain/core/base/enums/api_status.dart';
import '../../../domain/core/widgets/custom_snack_bars.dart';
import '../../../infrastructure/navigation/routes.dart';

class LoginController extends BaseController {
  // Tab index: 0=Owner, 1=Student, 2=Guest, 3=Admin
  final selectedTabIndex = 0.obs;

  // Owner Registration Form Controllers
  Rx<TextEditingController> ownerUsernameController = Rx(
    TextEditingController(),
  );
  Rx<TextEditingController> ownerPasswordController = Rx(
    TextEditingController(),
  );

  // Student Login Form Controllers
  Rx<TextEditingController> studentLoginMobileController = Rx(
    TextEditingController(),
  );
  Rx<TextEditingController> studentLoginPasswordController = Rx(
    TextEditingController(),
  );

  // Guest Form Controller
  Rx<TextEditingController> guestNameController = Rx(TextEditingController());

  final RxBool isStudentPasswordVisible = true.obs;
  final RxBool isOwnerPasswordVisible = true.obs;
  final RxBool isLoading = false.obs;

  var apiOwnerLoginStatus = ApiStatus.SUCCESS.obs;
  var apiGuestLoginStatus = ApiStatus.SUCCESS.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['tab'] != null) {
      selectedTabIndex.value = args['tab'];
      debugPrint("LOGIN OPENED WITH TAB => ${args['tab']}");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  void changeTab(int index) {
    print('=================switching tab ===========');
    if (selectedTabIndex.value == index) return;

    selectedTabIndex.value = index;

    print('Switched to tab index: $index');

    // ✅ Clear all controllers when switching tab
    ownerUsernameController.value.clear();
    ownerPasswordController.value.clear();

    studentLoginMobileController.value.clear();
    studentLoginPasswordController.value.clear();

    guestNameController.value.clear();

    // ✅ Reset status
    apiOwnerLoginStatus.value = ApiStatus.SUCCESS;
  }

  void toggleStudentPasswordVisibility() {
    isStudentPasswordVisible.value = !isStudentPasswordVisible.value;
  }

  void toggleOwnerPasswordVisibility() {
    isOwnerPasswordVisible.value = !isOwnerPasswordVisible.value;
  }

  String get selectedUserType {
    switch (selectedTabIndex.value) {
      case 0:
        return "OWNER";
      case 1:
        return "STUDENT";
      case 2:
        return "GUEST";
      case 3:
        return "ADMIN"; // if you add admin later
      default:
        return "OWNER";
    }
  }

  Future<void> submitLogin() async {
    final type = selectedUserType;
    String usernameOrMobile = "";
    String password = "";

    if (type == "OWNER") {
      usernameOrMobile = ownerUsernameController.value.text;
      password = ownerPasswordController.value.text;
    } else if (type == "STUDENT") {
      usernameOrMobile = studentLoginMobileController.value.text;
      password = studentLoginPasswordController.value.text;
    }

    apiOwnerLoginStatus.value = ApiStatus.LOADING;

    if (usernameOrMobile.isEmpty) {
      CustomSnackbars().showErrorSnack(
        title: type == "OWNER" ? 'Username' : 'Mobile Number',
        message: 'Please enter ${type == "OWNER" ? 'username' : 'mobile number'}',
      );
      apiOwnerLoginStatus.value = ApiStatus.ERROR;
    } else if (password.isEmpty) {
      CustomSnackbars().showErrorSnack(
        title: 'Password',
        message: 'Please enter password',
      );
      apiOwnerLoginStatus.value = ApiStatus.ERROR;
    } else {
      try {
        var result = await LoginRepoImpl(client).doOwnerLogin({
          "type": type,
          "username": usernameOrMobile,
          "password": password,
        });
        print('=============== $type login in =============');
        print(result);
        result.fold(
          (error) {
            apiOwnerLoginStatus.value = ApiStatus.ERROR;
            CustomSnackbars().showErrorSnack(title: 'FAILED', message: error);
          },
          (response) {
            if (response['status'] == 'success') {
              // The API response structure: {status: success, token: ..., user: {id: ...}}
              final token = response['token']?.toString();
              final userId = response['user']?['id']?.toString();

              if (token != null) {
                SecureStorageServices().writeSecureData(
                  key: TOKEN,
                  value: token,
                );
              }

              if (userId != null) {
                SecureStorageServices().writeSecureData(
                  key: ID,
                  value: userId,
                );
              }

              Get.toNamed(Routes.DASHBOARD);

              CustomSnackbars().showSuccessSnack(
                title: 'SUCCESS',
                message: response['message'] ?? 'Login successful',
              );

              apiOwnerLoginStatus.value = ApiStatus.SUCCESS;
            } else {
              CustomSnackbars().showErrorSnack(
                title: 'FAILED',
                message: response['message'] ?? 'Login failed',
              );

              apiOwnerLoginStatus.value = ApiStatus.ERROR;
            }
          },
        );
      } catch (e) {
        print('Error: $e');
        apiOwnerLoginStatus.value = ApiStatus.ERROR;
      }
    }
  }

  void submitGuestLogin() {
    apiGuestLoginStatus.value = ApiStatus.LOADING;
     if (guestNameController.value.text.isEmpty) {
      CustomSnackbars().showErrorSnack(
        title: 'Guest Name',
        message: 'Please enter guest name',
      );
      apiGuestLoginStatus.value = ApiStatus.ERROR;
    }else {
      // Proceed with guest login logic
      Get.toNamed(Routes.DASHBOARD);

      CustomSnackbars().showSuccessSnack(
        title: 'SUCCESS',
        message: 'Guest login successful',
      );

      apiGuestLoginStatus.value = ApiStatus.SUCCESS;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
