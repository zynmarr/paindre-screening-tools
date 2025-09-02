import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:screening_tools_android/app/controllers/service/service_controller.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';
import 'package:screening_tools_android/resources/pages/error/error_page.dart';
// import 'package:in_app_review/in_app_review.dart';
import 'package:screening_tools_android/resources/pages/patient/patiens_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference optionsApp = FirebaseFirestore.instance.collection('options_app');
  Map<String, dynamic> feature = {};
  String? versionApp; // Menggunakan nullable untuk menghindari late initialization error

  // final InAppReview _inAppReview = InAppReview.instance;

  @override
  void initState() {
    super.initState();
    _getAppVersion();
    FirebaseFirestore.instance.collection('features').doc('access_data_users').snapshots().listen((event) {
      setState(() {
        feature = event.data() as Map<String, dynamic>;
      });
    });
  }

  Future<void> _getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        versionApp = packageInfo.version;
      });
    } catch (e) {
      Utils.errorToast(message: "Error when get version app");
    }
  }

  // Future<void> _requestReview() async {
  //   bool isAvailable = await _inAppReview.isAvailable();

  //   if (isAvailable == false) {
  //     return Utils.errorToast(message: "In App Review is not available");
  //   } else {
  //     return _inAppReview.requestReview();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double gWidth = context.width / 1.8;
    // ServiceController serviceController = context.watch<ServiceController>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        final dialog = cDialog(context, middleText: 'dialog.exit'.tr, onSucces: () => exit(0), onCancel: () => Get.back());

        return dialog;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //show dialog when pressed
            Get.dialog(
              barrierDismissible: false,
              AlertDialog(
                title: Text('settings'.tr),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('language'.tr), LanguageDropdown()]),
                  ],
                ),
                actions: [TextButton(onPressed: () => Get.back(), child: Text('close'.tr))],
              ),
            );
          },
          heroTag: 'settings'.tr,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          elevation: 2,
          tooltip: 'settings'.tr,
          backgroundColor: Colors.white,
          child: Icon(MdiIcons.cog, size: context.textTheme.titleLarge!.fontSize),
        ),
        body: Stack(
          children: [
            Positioned(
              left: -1,
              right: -2,
              bottom: 0,
              child: CustomPaint(size: Size(context.width, context.height / 1.9), painter: RPSCustomPainter1()),
            ),
            Positioned(
              left: -2,
              right: -2,
              bottom: -2,
              child: CustomPaint(size: Size(context.width, context.height / 2.0), painter: RPSCustomPainter2()),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: StreamBuilder(
                stream: optionsApp.snapshots(),
                builder: (context, snapshot) {
                  ServiceController serviceController = context.watch<ServiceController>();
                  if (snapshot.hasError) {
                    return Center(child: Text('error.message.network'.tr));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData) {
                    var option = snapshot.data!.docs[0].data() as Map<String, dynamic>;

                    if (option['is_required_update'] == true && option['version'] != versionApp!) {
                      Future.delayed(Duration(seconds: 2), () => Get.offAllNamed(Routes.requestUpdate));
                    }
                    // if (serviceController != null) {}
                    if (serviceController.connectivityResult == ConnectivityResult.none) {
                      Future.delayed(
                        Duration(seconds: 3),
                        () => Get.offAllNamed(Routes.error, arguments: ErrorArguments(message: 'Service Unavailable', code: 503)),
                      );
                    }
                    if (option['maintanance_mode'] == true) {
                      Future.delayed(Duration(seconds: 1), () => Get.offAllNamed(Routes.maintanance));
                    }
                  }

                  return SizedBox(
                    height: context.height,
                    width: context.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 1),
                        SizedBox(
                          height: gWidth,
                          width: gWidth,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://lh3.googleusercontent.com/pw/AP1GczO9egAuF1P-qsdsxxQ4CTCETHxXNEB3HDLRRZwuZm1gD5na9vERZtAsNDOWxVW4eVwo8-7nlCOUG6y5Bhk0JEVKcfkY8YL07ZlG9XRPhwX5BwhaDU1iEHLxfCPpOjlyRiO0va3YOw7Dh-oyNjqDvVg=w500-h500-s-no-gm',
                            filterQuality: FilterQuality.high,
                            fadeOutDuration: Duration(milliseconds: 300),
                            fadeInDuration: Duration(milliseconds: 300),
                          ),
                        ),
                        const SizedBox(height: 30),
                        if (feature['is_admin'] == false || serviceController.role == Roles.admin)
                          _button(
                            title: 'button.patientData'.tr,
                            onPressed: () => Get.toNamed(Routes.patient, arguments: PatientArguments(isHistory: false)),
                          ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                        _button(
                          title: 'button.screeningData'.tr,
                          onPressed: () => Get.toNamed(Routes.patient, arguments: PatientArguments(isHistory: true)),
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                        _button(title: 'button.startScreening'.tr, onPressed: () => Get.toNamed(Routes.createPatient)),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                        // _button(title: "Rating App", onPressed: _requestReview),
                        // const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                        _button(
                          title: 'button.logout'.tr,
                          onPressed: () async {
                            Utils.paindreShowLoading();
                            try {
                              await FirebaseAuth.instance.signOut();
                              Get.offAllNamed(Routes.login);
                            } catch (e) {
                              Utils.errorToast(message: e.toString());
                            } finally {
                              BotToast.closeAllLoading();
                            }
                          },
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button({void Function()? onPressed, required String title}) {
    return SizedBox(
      width: context.width / 1.8,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title.toUpperCase(), style: context.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      value: Get.locale,
      items: const [DropdownMenuItem(value: Locale('en'), child: Text('English')), DropdownMenuItem(value: Locale('id'), child: Text('Indonesia'))],
      onChanged: (Locale? newLocale) async {
        if (newLocale != null) {
          await GetStorage().write('language_code', newLocale.languageCode);
          Get.updateLocale(newLocale);
          // Get.back();
          // Restart the app to apply the new language setting
          WidgetsBinding.instance.addPostFrameCallback((_) {
            BotToast.showText(text: 'Language changed to ${newLocale.languageCode}');
            Restart.restartApp();
          });
        }
      },
      hint: const Text('Select Language'), // Optional hint
      // isExpanded: true, // Makes the dropdown take the full width
    );
  }
}
