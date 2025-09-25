import 'dart:ui';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:screening_tools_android/app/controllers/service/notification_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:screening_tools_android/app/controllers/service/service_controller.dart';
import 'package:screening_tools_android/app/core/core.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    appleProvider: AppleProvider.appAttest,
    androidProvider: AndroidProvider.playIntegrity,
  );
  await NotificationService.instance.init();
  await InitLanguageCode.init();

  // Initialize Firebase Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // await ApiService().verifyToken('http://10.140.152.123:3000/verifyToken');
  runApp(ChangeNotifierProvider(create: (context) => ServiceController(), lazy: true, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Paindre Screening Tools',
      // locale: locale,
      translations: AppTranslations(),
      supportedLocales: const [Locale('en'), Locale('id')],
      // locale: Get.deviceLocale, // or set default locale
      localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
      fallbackLocale: const Locale('en'),
      theme: AppTheme().themeData,
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.splash,
    );
  }
}

class InitLanguageCode {
  static Future<void> init() async {
    // Check if language code is stored
    if (!isLanguageCodeStored()) {
      // If not, set default language code to 'en'
      Locale defaultLocale = getCurrentLocale();
      await setLanguageCode(defaultLocale.languageCode);
    } else {
      // If stored, update the locale with the stored language code
      String languageCode = getStoredLanguageCode();
      // debugPrint("Stored language code: $languageCode");
      Get.updateLocale(Locale(languageCode));
    }
  }

  // check if language code is stored in GetStorage
  static bool isLanguageCodeStored() {
    return GetStorage().hasData('language_code');
  }

  // get the stored language code
  static String getStoredLanguageCode() {
    return GetStorage().read('language_code');
  }

  // set the language code in GetStorage
  static Future<void> setLanguageCode(String languageCode) async {
    await GetStorage().write('language_code', languageCode);
    // debugPrint("Language code set to: $languageCode");
    Get.updateLocale(Locale(languageCode));
  }

  // get the current locale
  static Locale getCurrentLocale() {
    String languageCode = Get.deviceLocale?.languageCode ?? 'en';
    return Locale(languageCode);
  }
}

// class _MyAppState extends State<MyApp> {
//   // Locale _locale = Get.locale ?? const Locale('en');

//   // void setLocale(Locale locale) {
//   //   setState(() {
//   //     _locale = locale;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     Locale? locale = Get.deviceLocale; // Automatically gets the device locale
//     Get.updateLocale(locale!); // Update the locale in GetX
    // debugPrint("Current locale: ${Get.locale}");
//     return GetMaterialApp(
//       title: 'Paindre Screening Tools',
//       locale: locale,
//       translations: AppTranslations(),
//       supportedLocales: const [Locale('en'), Locale('id')],
//       // locale: Get.deviceLocale, // or set default locale
//       localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
//       fallbackLocale: const Locale('en'),
//       theme: AppTheme().themeData,
//       debugShowCheckedModeBanner: false,
//       builder: BotToastInit(),
//       navigatorObservers: [BotToastNavigatorObserver()],
//       onGenerateRoute: Routes.generateRoute,
//       initialRoute: Routes.splash,
//     );
//   }
// }

  // @override
  // Widget build(BuildContext context) {
  //   return GetMaterialApp(
  //     title: 'Paindre Screening Tools',
  //     theme: AppTheme().themeData,
  //     debugShowCheckedModeBanner: false,
  //     builder: BotToastInit(),
  //     navigatorObservers: [BotToastNavigatorObserver()],
  //     onGenerateRoute: Routes.generateRoute,
  //     initialRoute: Routes.splash,
  //   );
  // }