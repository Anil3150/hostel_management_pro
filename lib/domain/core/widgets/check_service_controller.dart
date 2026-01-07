import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class CheckServicesController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLocationOn = true.obs;

  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  late StreamSubscription<ServiceStatus> locationSubscription;

  // Flags to avoid duplicate navigation/overlays
  bool internetOverlayVisible = false;
  bool internetPageOpen = false;
  bool locationOverlayVisible = false;
  bool locationPageOpen = false;

  @override
  void onInit() {
    super.onInit();
    checkServices();
    listenInternet();
    listenLocation();
  }

  Future<void> checkServices() async {
    await checkInternet();
    await checkLocation();
  }

  // ---------------- INTERNET ----------------
  Future<void> checkInternet() async {
    final results = await Connectivity().checkConnectivity();
    bool hasConnection =
        results.isNotEmpty && results.first != ConnectivityResult.none;

    isConnected.value = hasConnection;

    if (!hasConnection) {
      handleNoInternet();
    } else {
      closeInternetUI();
    }
  }

  void listenInternet() {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((results) {
      bool hasConnection =
          results.isNotEmpty && results.first != ConnectivityResult.none;

      isConnected.value = hasConnection;
      debugPrint("[CheckServices] connectivity changed -> $results");

      if (!hasConnection) {
        handleNoInternet();
      } else {
        closeInternetUI();
      }
    });
  }

  void handleNoInternet() {
    String currentRoute = Get.currentRoute;

    if (currentRoute == '/Dashboard') {
      // Show non-blocking overlay inside dashboard
      if (!internetOverlayVisible) {
        internetOverlayVisible = true;
        // Trigger a rebuild of dashboard with overlay
        update(['dashboard_no_internet']);
      }
    } else {
      // Navigate to standalone NoInternetPage
      if (!internetPageOpen) {
        internetPageOpen = true;
        Get.toNamed('/NoInternetPage');
      }
    }
  }

  void closeInternetUI() {
    if (internetOverlayVisible) {
      internetOverlayVisible = false;
      update(['dashboard_no_internet']);
    }
    if (internetPageOpen && Get.currentRoute == '/NoInternetPage') {
      internetPageOpen = false;
      Get.back();
    }
  }

  // ---------------- LOCATION ----------------
  Future<void> checkLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    isLocationOn.value = serviceEnabled;

    if (!serviceEnabled) {
      handleNoLocation();
    } else {
      closeLocationUI();
    }
  }

  void listenLocation() {
    locationSubscription =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      bool enabled = status == ServiceStatus.enabled;
      isLocationOn.value = enabled;

      debugPrint("[CheckServices] location service changed -> $status");

      if (!enabled) {
        handleNoLocation();
      } else {
        closeLocationUI();
      }
    });
  }

  void handleNoLocation() {
    String currentRoute = Get.currentRoute;

    if (currentRoute == '/Dashboard') {
      if (!locationOverlayVisible) {
        locationOverlayVisible = true;
        update(['dashboard_no_location']);
      }
    } else {
      if (!locationPageOpen) {
        locationPageOpen = true;
        Get.toNamed('/NoLocationPage');
      }
    }
  }

  void closeLocationUI() {
    if (locationOverlayVisible) {
      locationOverlayVisible = false;
      update(['dashboard_no_location']);
    }
    if (locationPageOpen && Get.currentRoute == '/NoLocationPage') {
      locationPageOpen = false;
      Get.back();
    }
  }

  @override
  void onClose() {
    connectivitySubscription.cancel();
    locationSubscription.cancel();
    super.onClose();
  }
}
