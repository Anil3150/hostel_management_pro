import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/core/base/enums/api_status.dart';
import '../../../domain/core/widgets/profile_text_form_field.dart';
import '../../../infrastructure/theme/styles/text_styles.dart';
import '../controllers/login.controller.dart';
import 'custom_text_field.dart';
import 'fade_in_up_widget.dart';

class GuestLoginForm extends GetView<LoginController> {
  const GuestLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: Get.height * 0.02),

          // Animated Header
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in as a guest to continue',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Mobile Number Field - Using ProfileTextFormField
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
                lable: 'Your Name',
                lableStyle: TextStyles.kTSFS16W500,
                hintText: 'Enter your name',
                hintStyle: TextStyles.kTSDS12W700.copyWith(
                  color: Colors.grey[500],
                ),
                controller: controller.guestNameController.value,
                keyboardType: TextInputType.text,
                borderRadius: BorderRadius.circular(12),
                showPrefixIcon: const Icon(
                  Icons.person_outline_rounded,
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

          SizedBox(height: Get.height * 0.05),

          // Animated Login Button
          FadeInUp(
            delay: const Duration(milliseconds: 800),
            child: Obx(
              () => GestureDetector(
                onTap:
                    controller.apiGuestLoginStatus.value == ApiStatus.LOADING
                        ? null
                        : controller.submitGuestLogin,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:
                          controller.apiGuestLoginStatus.value == ApiStatus.LOADING
                              ? [Colors.grey.shade400, Colors.grey.shade500]
                              : [
                                const Color(0xFF667eea),
                                const Color(0xFF764ba2),
                              ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: (controller.apiGuestLoginStatus.value == ApiStatus.LOADING
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
                          controller.apiGuestLoginStatus.value == ApiStatus.LOADING
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
                                'LOGIN',
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
        ],
      ),
    );
  }
}

