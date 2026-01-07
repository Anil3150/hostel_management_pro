import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../base/consts/img_const.dart';
import 'check_service_controller.dart';
import 'no_internet.dart';

class DashboardWrapper extends StatelessWidget {
  final Widget child;
  final bool isDashboardPage;

  const DashboardWrapper({
    super.key,
    required this.child,
    required this.isDashboardPage,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckServicesController>();

    return Obx(() {
      // Check both services status
      final internetOn = controller.isConnected.value;
      final locationOn = controller.isLocationOn.value;

      // Determine which error to show (priority to internet error)
      final showError = !internetOn || !locationOn;
      final showInternetError = !internetOn;
      final showLocationError = internetOn && !locationOn;

      if (showError) {
        // Dashboard page shows overlay
        if (isDashboardPage) {
          return Stack(
            children: [
              child,
              if (showInternetError)
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: false,
                    child: NoInternetPage(
                      imagePath: SvgConstants.noInternet,
                      title:  'Network Error',
                      subtitle: 'Please check your Network settings.',
                      onButtonPressed: () => AppSettings.openAppSettings(
                        type: AppSettingsType.wireless,
                      ),
                    ),
                  ),
                )
              else if (showLocationError)
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: false,
                    child: NoInternetPage(
                      imagePath: SvgConstants.noLocation,
                      title: 'No Location Found',
                      subtitle: 'Please enable location services to continue.',
                      onButtonPressed: () => AppSettings.openAppSettings(
                        type: AppSettingsType.location,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }
        // Non-dashboard page replaces entire screen
        else {
          return showInternetError
              ? NoInternetPage(
                  imagePath: 'assets/lotties/noInternetLottie.json',
                  title: 'Network Error',
                  subtitle: 'Please check your Network settings.',
                  onButtonPressed: () => AppSettings.openAppSettings(
                    type: AppSettingsType.wireless,
                  ),
                )
              : NoInternetPage(
                  imagePath: 'assets/lotties/noLocationService.json',
                  title: 'No Location Found',
                  subtitle: 'Please enable location services to continue.',
                  onButtonPressed: () => AppSettings.openAppSettings(
                    type: AppSettingsType.location,
                  ),
                );
        }
      }

      // Both services are enabled - show normal content
      return child;
    });
  }
}