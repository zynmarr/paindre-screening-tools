import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/controllers/scoring_result/scoring_result.dart';
import 'package:screening_tools_android/app/core/core.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );
  await FlutterDownloader.initialize(debug: false, ignoreSsl: true);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientController()),
        ChangeNotifierProvider(create: (_) => ScoringResultController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Paindre Screening Tools',
      theme: AppTheme().themeData,
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      onGenerateRoute: Routes.generateRoute,
      initialRoute: 'splash-page',
    );
  }
}



// Alias name: upload
// Creation date: Dec 18, 2024
// Entry type: PrivateKeyEntry
// Certificate chain length: 1
// Certificate[1]:
// Owner: CN=Muammar Khadafi, OU=Unknown, O=Paindre Innovation, L=Banda Aceh, ST=Aceh, C=ID
// Issuer: CN=Muammar Khadafi, OU=Unknown, O=Paindre Innovation, L=Banda Aceh, ST=Aceh, C=ID
// Serial number: 442e934ca40b5871
// Valid from: Wed Dec 18 21:07:09 WIB 2024 until: Sun May 05 21:07:09 WIB 2052
// Certificate fingerprints:
//          SHA1: 70:19:4F:F9:63:4E:A8:1E:CE:21:53:C8:DD:D4:37:6D:0A:BF:4F:2E
//          SHA256: 19:66:7B:08:22:7A:40:66:D5:F8:AA:F7:A7:7C:D9:9F:E6:3B:97:EF:65:4E:DB:50:05:56:A3:C2:CD:59:A6:60
// Signature algorithm name: SHA256withRSA
// Subject Public Key Algorithm: 2048-bit RSA key
// Version: 3