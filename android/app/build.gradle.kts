plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // 👈 في Kotlin DSL لازم الاسم ده مش kotlin-android
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.todo_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"   // 👈 بصيغة Kotlin DSL

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true   // ✅ مهم جداً
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.todo_app"
        minSdk = 21
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
