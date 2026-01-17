import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../domain/core/base/enums/api_status.dart';
import '../../../domain/core/widgets/profile_text_form_field.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/styles/text_styles.dart';
import '../../login/widgets/fade_in_up_widget.dart';
import '../controllers/signup.controller.dart';

class StudentRegistrationForm extends GetView<SignupController> {
  const StudentRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Animated Header
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: const Text(
                    'Get Started!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Register to join as a student',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ProfileTextFormField(
                lable: 'Mobile Number',
                lableStyle: TextStyles.kTSFS16W500,
                hintText: 'Enter your 10-digit mobile number',
                hintStyle: TextStyles.kTSDS12W700.copyWith(
                  color: Colors.grey[500],
                ),
                controller: controller.studentMobileController.value,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                inputformate: [FilteringTextInputFormatter.digitsOnly],
                borderRadius: BorderRadius.circular(12),
                showPrefixIcon: const Icon(
                  Icons.phone_android,
                  color: Color(0xFF667eea),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 14,
                ),
                showBorder: true,
                containerPadding: EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 0,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Password Field - Using ProfileTextFormField with custom suffix
          FadeInUp(
            delay: const Duration(milliseconds: 600),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Obx(
                () => ProfileTextFormField(
                  lable: 'Password',
                  lableStyle: TextStyles.kTSFS16W500,
                  hintText: 'Enter your password',
                  hintStyle: TextStyles.kTSDS12W700.copyWith(
                    color: Colors.grey[500],
                  ),
                  controller: controller.studentPasswordController.value,
                  showText: controller.isStudentRegPasswordVisible.value,
                  maxLength: 50,
                  showPrefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF667eea),
                  ),
                  showSufixIcon: IconButton(
                    icon: Icon(
                      controller.isStudentRegPasswordVisible.value
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: Colors.grey[600],
                    ),
                    onPressed:
                        () => controller.toggleStudentRegPasswordVisibility(),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 14,
                  ),
                  showBorder: true,
                  containerPadding: EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 0,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Password Field - Using ProfileTextFormField with custom suffix
          FadeInUp(
            delay: const Duration(milliseconds: 600),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Obx(() {
                final enabled = controller.isStudentPasswordFilledRx.value;
                final hasError =
                    controller.studentConfirmPasswordError.isNotEmpty;

                return ProfileTextFormField(
                  lable: 'Confirm Password',
                  lableStyle: TextStyles.kTSFS16W500.copyWith(
                    color: enabled ? Colors.black : Colors.grey,
                  ),
                  hintText:
                      enabled
                          ? 'Re-enter your password'
                          : 'Enter password first',
                  hintStyle: TextStyles.kTSDS12W700.copyWith(
                    color: Colors.grey[500],
                  ),
                  isEnabled: enabled,
                  controller: controller.studentConfirmPasswordController.value,
                  showText: controller.isStudentRegCfmPasswordVisible.value,
                  maxLength: 50,

                  showPrefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: enabled ? const Color(0xFF667eea) : Colors.grey,
                  ),

                  showSufixIcon:
                      enabled
                          ? IconButton(
                            icon: Icon(
                              controller.isStudentRegCfmPasswordVisible.value
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: Colors.grey[600],
                            ),
                            onPressed:
                                controller
                                    .toggleStudentRegCfmPasswordVisibility,
                          )
                          : null,

                  showBorder: true,
                  borderRadius: BorderRadius.circular(12),
                  borderColor: hasError ? Colors.red : Colors.grey.shade300,
                  focusedBorderColor: const Color(0xFF667eea),

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 14,
                  ),
                  containerPadding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 0,
                  ),
                );
              }),
            ),
          ),
          Obx(
            () =>
                controller.studentConfirmPasswordError.isEmpty
                    ? const SizedBox(height: 6)
                    : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 6,
                      ),
                      child: Text(
                        controller.studentConfirmPasswordError.value,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
          ),

          SizedBox(height: Get.height * 0.05),

          // Animated Login Button
          FadeInUp(
            delay: const Duration(milliseconds: 800),
            child: Obx(
              () => GestureDetector(
                onTap:
                    controller.apiStudentRegStatus.value == ApiStatus.LOADING
                        ? null
                        : controller.submitStudentRegister,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:
                          controller.apiStudentRegStatus.value ==
                                  ApiStatus.LOADING
                              ? [Colors.grey.shade400, Colors.grey.shade500]
                              : [
                                const Color(0xFF667eea),
                                const Color(0xFF764ba2),
                              ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: (controller.apiStudentRegStatus.value ==
                                    ApiStatus.LOADING
                                ? Colors.grey
                                : const Color(0xFF667eea))
                            .withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child:
                          controller.apiStudentRegStatus.value ==
                                  ApiStatus.LOADING
                              ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : const Text(
                                'REGISTER',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // OR Divider
          FadeInUp(
            delay: const Duration(milliseconds: 1000),
            child: Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.grey.shade300, thickness: 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(color: Colors.grey.shade300, thickness: 1),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Signup Link
          FadeInUp(
            delay: const Duration(milliseconds: 1200),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  final tab = controller.selectedTabIndex.value;
                  debugPrint("BACK TO LOGIN WITH TAB => $tab");

                  Get.offNamed(Routes.LOGIN, arguments: {'tab': tab});
                },

                child: Text(
                  "Back to Login",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2563EB), // highlight color
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
