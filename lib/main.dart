import 'dart:ui';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:screening_tools_android/app/controllers/authentication/authentication_controller.dart';
import 'package:screening_tools_android/app/controllers/authentication/role_controller.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/controllers/question/question_controller.dart';
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
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    appleProvider: AppleProvider.appAttest,
    androidProvider: AndroidProvider.playIntegrity,
  );

  await AuthenticationController().init();
  
  await NotificationService.instance.init();
  await InitLanguageCode.init();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  Get.lazyPut(() => AuthenticationController(), fenix: true);
  Get.lazyPut(() => QuestionController(), fenix: true);
  Get.lazyPut(() => PatientController(), fenix: true);
  Get.lazyPut(() => RoleController(), fenix: true);

  runApp(ChangeNotifierProvider(create: (context) => ServiceController(), lazy: true, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Paindre Screening Tools',
      translations: AppTranslations(),
      supportedLocales: const [Locale('en'), Locale('id')],
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
    if (!isLanguageCodeStored()) {
      Locale defaultLocale = getCurrentLocale();
      await setLanguageCode(defaultLocale.languageCode);
    } else {
      String languageCode = getStoredLanguageCode();
      Get.updateLocale(Locale(languageCode));
    }
  }
  static bool isLanguageCodeStored() {
    return GetStorage().hasData('language_code');
  }
  static String getStoredLanguageCode() {
    return GetStorage().read('language_code');
  }
  static Future<void> setLanguageCode(String languageCode) async {
    await GetStorage().write('language_code', languageCode);
    Get.updateLocale(Locale(languageCode));
  }
  static Locale getCurrentLocale() {
    String languageCode = Get.deviceLocale?.languageCode ?? 'en';
    return Locale(languageCode);
  }
}
