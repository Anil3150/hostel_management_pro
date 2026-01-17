import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hostel_management_pro/presentation/signup/widgets/owner_registration_form.dart';
import 'package:hostel_management_pro/presentation/signup/widgets/student_registration_form.dart';

import 'controllers/signup.controller.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- HEADER ----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'HOSTEL MANAGER PRO',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 1.5,
                ),
              ),
            ),

            SizedBox(height: Get.height * 0.02),

            // ---------------- TABS ----------------
            Obx(() {
              final selected = controller.selectedTabIndex.value;
              return Row(
                children: [
                  _buildTab(0, 'OWNER', Colors.blue, selected),
                  _buildTab(1, 'STUDENT', Colors.green, selected),
                ],
              );
            }),

            // ---------------- CONTENT ----------------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(0),
                child: Obx(() {
                  // switch (controller.selectedTabIndex.value) {
                  //   case 0:
                  //     return const OwnerRegistrationForm();
                  //   case 1:
                  //     return const StudentRegistrationForm();
                  //   default:
                  //     return const SizedBox();
                  // }
                  switch (controller.selectedTabIndex.value) {
                    case 0:
                      return const OwnerRegistrationForm(
                        key: ValueKey('owner_form'),
                      );
                    case 1:
                      return const StudentRegistrationForm(
                        key: ValueKey('student_form'),
                      );
                    default:
                      return const SizedBox();
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label, Color activeColor, int selected) {
    final isSelected = selected == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changeTab(index);
          debugPrint("SIGNUP TAB CHANGED TO => $index");
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8), // 🔽 reduced height
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? activeColor : Colors.grey.shade600,
                  letterSpacing: 0.3,
                ),
              ),

              const SizedBox(
                height: 4,
              ), // 🔽 small gap between text & underline
              // Underline (only text width)
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 3,
                width: isSelected ? label.length * 9.0 : 0,
                // 👆 approximate text width
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
