import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hostel_management_pro/presentation/screens.dart';
import '../../infrastructure/theme/colors.dart';
import 'controllers/dashboard.controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          return controller.onWillPop();
        },
        child: Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: const [
              HomeScreen(),
              BroadcastScreen(),
              PaymentsScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            height: Get.height * 0.12,
            decoration: BoxDecoration(
              color: navBgColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: navBgColor,
              elevation: 0,
              selectedItemColor: navSelected,
              unselectedItemColor: navUnselected,
              selectedFontSize: 13,
              unselectedFontSize: 12,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: activeIcon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.campaign_outlined),
                  activeIcon: activeIcon(Icons.campaign),
                  label: 'Broadcast',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.payments_outlined),
                  activeIcon: activeIcon(Icons.payments),
                  label: 'Payments',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: activeIcon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: controller.selectedIndex.value,
              onTap: controller.onItemSelected,
            ),
          ),
        ),
      );
    });
  }

  Widget activeIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB).withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 26, color: const Color(0xFF2563EB)),
    );
  }
}
