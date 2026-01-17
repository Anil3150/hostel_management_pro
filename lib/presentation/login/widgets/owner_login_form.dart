import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hostel_management_pro/presentation/login/controllers/login.controller.dart';

import '../../../domain/core/base/enums/api_status.dart';
import '../../../domain/core/widgets/profile_text_form_field.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/styles/text_styles.dart';
import 'fade_in_up_widget.dart';

class OwnerLoginForm extends GetView<LoginController> {
  const OwnerLoginForm({super.key});

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
                  'Sign in to your owner account',
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
                lable: 'Username',
                lableStyle: TextStyles.kTSFS16W500,
                hintText: 'Enter your username',
                hintStyle: TextStyles.kTSDS12W700.copyWith(
                  color: Colors.grey[500],
                ),
                controller: controller.ownerUsernameController.value,
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
                  controller: controller.ownerPasswordController.value,
                  showText: controller.isOwnerPasswordVisible.value,
                  maxLength: 50,
                  showPrefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF667eea),
                  ),
                  showSufixIcon: IconButton(
                    icon: Icon(
                      controller.isOwnerPasswordVisible.value
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: Colors.grey[600],
                    ),
                    onPressed: () => controller.toggleOwnerPasswordVisibility(),
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

          SizedBox(height: Get.height * 0.05),

          // Animated Login Button
          FadeInUp(
            delay: const Duration(milliseconds: 800),
            child: Obx(
              () => GestureDetector(
                onTap:
                    controller.apiOwnerLoginStatus.value == ApiStatus.LOADING
                        ? null
                        : controller.submitLogin,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:
                          controller.apiOwnerLoginStatus.value == ApiStatus.LOADING
                              ? [Colors.grey.shade400, Colors.grey.shade500]
                              : [
                                const Color(0xFF667eea),
                                const Color(0xFF764ba2),
                              ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: (controller.apiOwnerLoginStatus.value == ApiStatus.LOADING
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
                          controller.apiOwnerLoginStatus.value == ApiStatus.LOADING
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
                  Get.offNamed(Routes.SIGNUP, arguments: {'tab': 0});
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "New owner? ",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey, // first color
                        ),
                      ),
                      TextSpan(
                        text: "Request access",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2563EB), // highlight color
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
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