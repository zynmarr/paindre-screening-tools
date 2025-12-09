import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:screening_tools_android/app/controllers/authentication/authentication_controller.dart';
import 'package:screening_tools_android/app/controllers/service/service_controller.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';
import 'package:screening_tools_android/resources/pages/patient/patiens_page.dart';
import 'package:in_app_review/in_app_review.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _optionsApp = FirebaseFirestore.instance.collection('options_app');

  final InAppReview _inAppReview = InAppReview.instance;
  final AuthenticationController _authController = Get.find<AuthenticationController>();

  Future<void> _requestReview() async {
    if (await _inAppReview.isAvailable()) {
      _inAppReview.requestReview();
    }
  }

  @override
  Widget build(BuildContext context) {
    double gWidth = context.width / 1.8;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        cDialog(context, middleText: 'dialog.exit'.tr, onSucces: () => exit(0), onCancel: () => Get.back());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: _buildSettingsFAB(context),
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
              child: StreamBuilder<QuerySnapshot>(
                stream: _optionsApp.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('error.message.network'.tr));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: SpinKitFadingCircle(color: Colors.black, size: 30.0));
                  }

                  if (snapshot.hasData) {
                    final option = snapshot.data!.docs[0].data() as Map<String, dynamic>;
                    context.read<ServiceController>().checkAppStatus(option);
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
                                'https://lh3.googleusercontent.com/pw/AP1GczO9egAuF1P-qsdsxxQ4CTCETHxXNEB3HDLRRZwuZm1gD5na9vERZtAsNDOWxVW4eVwo8-7nlCOUG6y5Bhk0JEVKcfkY8YL07ZlG9XRPhwX5BwhaDU1iEHLxfCPpOjlyRiO0va3YOw7Dh-oyNjqDvVg=w500-h500-s-no-gm', // Ganti dengan URL gambar profil yang valid atau placeholder
                            errorWidget:
                                (context, url, error) => Image.asset('assets/images/screening-logo-transparan.webp'), // Placeholder jika gagal
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildMenuButtons(context),
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

  Widget _buildSettingsFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            title: Text('settings'.tr),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('language'.tr), LanguageDropdown()]),
                const SizedBox(height: 15),

                // Delete Account button
                // ElevatedButton(
                //   onPressed: () async {
                //     await _authController.deleteAccount();
                //   },
                //   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                //   child: Text('Delete Account', style: TextStyle(color: Colors.white)),
                // ),
              ],
            ),
            actions: [TextButton(onPressed: () => Get.back(), child: Text('close'.tr))],
          ),
        );
      },
      heroTag: 'settings'.tr,
      shape: const CircleBorder(),
      elevation: 2,
      tooltip: 'settings'.tr,
      backgroundColor: Colors.white,
      child: Icon(MdiIcons.cog, size: context.textTheme.titleLarge!.fontSize),
    );
  }

  Widget _buildMenuButtons(BuildContext context) {
    return Selector<ServiceController, bool>(
      selector: (context, controller) => controller.role == Roles.admin,
      builder: (context, isUserAdmin, child) {
        return Column(
          children: [
            if (isUserAdmin) ...[
              _button(title: 'button.patientData'.tr, onPressed: () => Get.toNamed(Routes.patient, arguments: PatientArguments(isHistory: false))),
              const SizedBox(height: 12),
            ],
            _button(title: 'button.screeningData'.tr, onPressed: () => Get.toNamed(Routes.patient, arguments: PatientArguments(isHistory: true))),
            const SizedBox(height: 12),
            _button(title: 'button.startScreening'.tr, onPressed: () => Get.toNamed(Routes.createPatient)),
            const SizedBox(height: 12),
            _button(title: "Rating App", onPressed: _requestReview),
            const SizedBox(height: 12),
            _button(
              title: 'button.logout'.tr,
              onPressed: () async {
                cDialog(
                  context,
                  middleText: "dialog.logout".tr,
                  onSucces: () async {
                    try {
                      await _authController.logout();
                    } catch (e) {
                      Utils.errorToast(message: e.toString());
                    }
                  },
                  onCancel: () => Get.back(),
                );
              },
            ),
          ],
        );
      },
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            BotToast.showText(text: 'Language changed to ${newLocale.languageCode}');
            Restart.restartApp();
          });
        }
      },
    );
  }
}
