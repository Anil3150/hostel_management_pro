plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.hostel_management_pro"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.hostel_management_pro"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 21
        ndkVersion = "27.0.12077973"
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    flavorDimensions += "hostel_management_pro"
    productFlavors {
        create("dev") {
            dimension = "hostel_management_pro"
            applicationIdSuffix = ""
            resValue("string", "app_name", "Hostel Management")
            versionNameSuffix = " dev"
            applicationId = "com.hostel_management_pro.dev"
        }
        create("prod") {
            dimension = "hostel_management_pro"
            applicationIdSuffix = ""
            resValue("string", "app_name", "Hostel Management")
            applicationId = "com.hostel_management_pro.app"
        }
    }
}

flutter {
    source = "../.."
}
