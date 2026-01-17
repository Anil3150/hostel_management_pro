import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_pro/domain/core/interfaces/base_controller.dart';

import '../../../domain/core/base/enums/api_status.dart';
import '../../../domain/core/widgets/custom_snack_bars.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../services/signup_repo_impl.dart';

class SignupController extends BaseController {
  final selectedTabIndex = 0.obs;

  // ---------------- OWNER CONTROLLERS ----------------
  Rx<TextEditingController> ownerFullNameController = Rx(
    TextEditingController(),
  );
  Rx<TextEditingController> ownerEmailController = Rx(TextEditingController());
  Rx<TextEditingController> ownerMobileController = Rx(TextEditingController());
  Rx<TextEditingController> ownerUsernameController = Rx(
    TextEditingController(),
  );
  Rx<TextEditingController> ownerPasswordController = Rx(
    TextEditingController(),
  );
  Rx<TextEditingController> ownerConfirmPasswordController = Rx(
    TextEditingController(),
  );

  // ---------------- STUDENT CONTROLLERS ----------------
  Rx<TextEditingController> studentMobileController = Rx(
    TextEditingController(),
  );
  Rx<TextEditingController> studentPasswordController = Rx(
    TextEditingController(),
  );
  Rx<TextEditingController> studentConfirmPasswordController = Rx(
    TextEditingController(),
  );

  // ---------------- VISIBILITY ----------------
  final RxBool isStudentRegPasswordVisible = true.obs;
  final RxBool isOwnerRegPasswordVisible = true.obs;
  final RxBool isStudentRegCfmPasswordVisible = true.obs;
  final RxBool isOwnerRegCfmPasswordVisible = true.obs;

  // ---------------- STATE ----------------
  final RxBool isLoading = false.obs;

  final RxString ownerPasswordError = ''.obs;
  final RxString ownerConfirmPasswordError = ''.obs;
  final RxString studentPasswordError = ''.obs;
  final RxString studentConfirmPasswordError = ''.obs;

  final RxBool isOwnerPasswordFilledRx = false.obs;
  final RxBool isStudentPasswordFilledRx = false.obs;

  var apiOwnerRegStatus = ApiStatus.SUCCESS.obs;
  var apiStudentRegStatus = ApiStatus.SUCCESS.obs;

  // ---------------- INIT ----------------
  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args['tab'] != null) {
      selectedTabIndex.value = args['tab'];
      debugPrint(
        "SIGNUP CONTROLLER CREATED WITH TAB => ${selectedTabIndex.value}",
      );
    }

    // ---------- OWNER ----------
    ownerPasswordController.value.addListener(() {
      isOwnerPasswordFilledRx.value =
          ownerPasswordController.value.text.isNotEmpty;

      if (ownerConfirmPasswordController.value.text.isNotEmpty) {
        validateOwnerPasswords();
      }
    });

    ownerConfirmPasswordController.value.addListener(() {
      validateOwnerPasswords();
    });

    // ---------- STUDENT ----------
    studentPasswordController.value.addListener(() {
      isStudentPasswordFilledRx.value =
          studentPasswordController.value.text.isNotEmpty;

      if (studentConfirmPasswordController.value.text.isNotEmpty) {
        validateStudentPasswords();
      }
    });

    studentConfirmPasswordController.value.addListener(() {
      validateStudentPasswords();
    });
  }

  // ---------------- TAB ----------------
  void changeTab(int index) {
    selectedTabIndex.value = index;
    debugPrint("SIGNUP CONTROLLER TAB => $index");
  }

  // ---------------- TOGGLES ----------------
  void toggleStudentRegPasswordVisibility() =>
      isStudentRegPasswordVisible.value = !isStudentRegPasswordVisible.value;

  void toggleOwnerRegPasswordVisibility() =>
      isOwnerRegPasswordVisible.value = !isOwnerRegPasswordVisible.value;

  void toggleStudentRegCfmPasswordVisibility() =>
      isStudentRegCfmPasswordVisible.value =
          !isStudentRegCfmPasswordVisible.value;

  void toggleOwnerRegCfmPasswordVisibility() =>
      isOwnerRegCfmPasswordVisible.value = !isOwnerRegCfmPasswordVisible.value;

  // ---------------- PASSWORD VALIDATION ----------------

  String? validateStrongOwnerPassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 8) return 'Minimum 8 characters required';
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Add at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Add at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Add at least one number';
    }
    if (!RegExp(r'[!@#\$&*~%^()\-_+=<>?/{}[\]|.,]').hasMatch(password)) {
      return 'Add at least one special character';
    }
    return null;
  }

  bool validateOwnerPasswords() {
    final password = ownerPasswordController.value.text.trim();
    final confirm = ownerConfirmPasswordController.value.text.trim();

    ownerPasswordError.value = '';
    ownerConfirmPasswordError.value = '';

    final strongError = validateStrongOwnerPassword(password);
    if (strongError != null) {
      ownerPasswordError.value = strongError;
      return false;
    }

    if (confirm.isEmpty) return false;

    if (password != confirm) {
      ownerConfirmPasswordError.value = 'Passwords do not match';
      return false;
    }

    return true;
  }

  bool validateStudentPasswords() {
    final password = studentPasswordController.value.text.trim();
    final confirm = studentConfirmPasswordController.value.text.trim();

    studentPasswordError.value = '';
    studentConfirmPasswordError.value = '';

    if (password.isEmpty) return false;
    if (confirm.isEmpty) return false;

    if (password != confirm) {
      studentConfirmPasswordError.value = 'Passwords do not match';
      return false;
    }

    return true;
  }

  // ---------------- OWNER REGISTER ----------------
  Future<void> submitOwnerRegister() async {
    if (apiOwnerRegStatus.value == ApiStatus.LOADING) return;

    if (!validateOwnerPasswords()) {
      CustomSnackbars().showErrorSnack(
        title: 'Invalid password',
        message:
            ownerPasswordError.value.isNotEmpty
                ? ownerPasswordError.value
                : ownerConfirmPasswordError.value,
      );
      return;
    }

    if (ownerFullNameController.value.text.isEmpty) {
      CustomSnackbars().showErrorSnack(
        title: 'Name',
        message: 'Please enter fullname',
      );
      return;
    } else if (ownerEmailController.value.text.isEmpty) {
      CustomSnackbars().showErrorSnack(
        title: 'Email',
        message: 'Please enter email',
      );
      return;
    } else if (ownerMobileController.value.text.isEmpty) {
      CustomSnackbars().showErrorSnack(
        title: 'Mobile',
        message: 'Please enter mobile number',
      );
      return;
    } else if (ownerUsernameController.value.text.isEmpty) {
      CustomSnackbars().showErrorSnack(
        title: 'Username',
        message: 'Please enter username',
      );
      return;
    }

    apiOwnerRegStatus.value = ApiStatus.LOADING;

    try {
      var result = await SignupRepoImpl(client).doOwnerSignup({
        "full_name": ownerFullNameController.value.text.trim(),
        "username": ownerUsernameController.value.text.trim(),
        "email": ownerEmailController.value.text.trim(),
        "mobile_number": ownerMobileController.value.text.trim(),
        "password": ownerPasswordController.value.text.trim(),
      });

      result.fold(
        (error) {
          apiOwnerRegStatus.value = ApiStatus.ERROR;
          CustomSnackbars().showErrorSnack(title: 'FAILED', message: error);
        },
        (response) {
          if (response['status'] == 'success') {
            CustomSnackbars().showSuccessSnack(
              title: 'SUCCESS',
              message: response['message'] ?? 'Registration successful',
            );

            Get.offAllNamed(Routes.LOGIN, arguments: {'tab': 0});
            apiOwnerRegStatus.value = ApiStatus.SUCCESS;
          } else {
            CustomSnackbars().showErrorSnack(
              title: 'FAILED',
              message: response['message'] ?? 'Registration failed',
            );
            apiOwnerRegStatus.value = ApiStatus.ERROR;
          }
        },
      );
    } catch (e) {
      apiOwnerRegStatus.value = ApiStatus.ERROR;
      CustomSnackbars().showErrorSnack(
        title: 'Error',
        message: 'Something went wrong',
      );
    }
  }

   Future<void> submitStudentRegister() async {
    if (apiStudentRegStatus.value == ApiStatus.LOADING) return;

    if (!validateStudentPasswords()) {
      CustomSnackbars().showErrorSnack(
        title: 'Invalid password',
        message:
            studentPasswordError.value.isNotEmpty
                ? studentPasswordError.value
                : studentConfirmPasswordError.value,
      );
      return;
    }

    if (studentMobileController.value.text.isEmpty) {
      CustomSnackbars().showErrorSnack(
        title: 'Mobile',
        message: 'Please enter mobile number',
      );
      return;
    } else if (studentPasswordController.value.text.isEmpty) {
      CustomSnackbars().showErrorSnack(
        title: 'Password',
        message: 'Please enter password',
      );
      return;
    }

    apiStudentRegStatus.value = ApiStatus.LOADING;

    try {
      var result = await SignupRepoImpl(client).doStudentSignup({
        "mobile_number": studentMobileController.value.text.trim(),
        "password": studentPasswordController.value.text.trim(),
        "confirm_password": studentConfirmPasswordController.value.text.trim(),
      });

      result.fold(
        (error) {
          apiStudentRegStatus.value = ApiStatus.ERROR;
          CustomSnackbars().showErrorSnack(title: 'FAILED', message: error);
        },
        (response) {
          if (response['status'] == 'success') {
            CustomSnackbars().showSuccessSnack(
              title: 'SUCCESS',
              message: response['message'] ?? 'Registration successful',
            );

            Get.offAllNamed(Routes.LOGIN, arguments: {'tab': 1});
            apiStudentRegStatus.value = ApiStatus.SUCCESS;
          } else {
            CustomSnackbars().showErrorSnack(
              title: 'FAILED',
              message: response['message'] ?? 'Registration failed',
            );
            apiStudentRegStatus.value = ApiStatus.ERROR;
          }
        },
      );
    } catch (e) {
      apiStudentRegStatus.value = ApiStatus.ERROR;
      CustomSnackbars().showErrorSnack(
        title: 'Error',
        message: 'Something went wrong',
      );
    }
  }

  // ---------------- READY ----------------
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
