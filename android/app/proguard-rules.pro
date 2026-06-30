# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified in
# <sdk>/tools/proguard/proguard-android.txt

# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.**
-dontwarn androidx.**
-dontwarn com.google.**
-dontwarn com.squareup.**
-dontwarn okhttp3.**
-dontwarn okio.**
-keep class com.google.firebase.** { *; }
-keep class io.grpc.** { *; }
-keep class javax.annotation.** { *; }
