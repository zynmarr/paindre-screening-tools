# -------------------------------
# PROGUARD RULES FOR FLUTTER APPS
# -------------------------------

-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# 🔹 Keep MainActivity and any other entry points
-keep class com.paindre_innovation.screening_tools_android.MainActivity { *; }

# 🔹 Keep all classes that use Flutter reflection
-keepattributes *Annotation*
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# 🔹 Keep all serializable and Parcelable classes
-keepclassmembers class * implements java.io.Serializable { *; }
-keepclassmembers class * implements android.os.Parcelable { *; }

# 🔹 Prevent R8 from removing dynamically used classes
-keepnames class * {
    @androidx.annotation.Keep *;
}

# 🔹 Remove logging and debugging info for smaller APK/AAB
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
}

# 🔹 Optimize the code further (remove unused methods)
-optimizationpasses 5
-repackageclasses ''
-allowaccessmodification
-keepattributes *Annotation*

-keep class com.google.android.gms.** { *; }
-keep class com.google.firebase.** { *; }

# Gson
#-keep class com.paindre_innovation.screening_tools_android.models.** { *; }  # Ganti dengan package model Anda
#-keepclassmembers class com.paindre_innovation.screening_tools_android.models.** { *; }  # Ganti dengan package model Anda

# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task