import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference optionsApp =
      FirebaseFirestore.instance.collection('options_app');

  late var versionApp;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then(
      (value) {
        setState(() {
          versionApp = value.version;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double gWidth = context.width / 2.2;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        final dialog = cDialog(
          context,
          middleText: "Apakah anda ingin keluar dari aplikasi ini?",
          onSucces: () => exit(0),
          onCancel: () => Get.back(),
        );

        return dialog;
      },
      child: Scaffold(
        appBar: cAppBar(context, title: "PAINDRE SCREENING TOOLS"),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            gradient: cGradient(context),
          ),
          child: StreamBuilder(
              stream: optionsApp.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Utils.paindreShowLoading();
                  Utils.errorToast(
                      message: "Terjadi kesalahan, silahkan coba lagi");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  Utils.paindreShowLoading();
                }

                if (snapshot.hasData) {
                  var option =
                      snapshot.data!.docs[0].data() as Map<String, dynamic>;
                  BotToast.closeAllLoading();

                  if (option['maintanance_mode'] == true) {
                    Future.delayed(Duration(seconds: 2))
                        .then((value) => Get.offAllNamed('maintanance-page'));
                  }
                  if (option['is_required_update'] == true && option['version'] != versionApp) {
                    Future.delayed(Duration(seconds: 2))
                        .then((value) => Get.offAllNamed('request-update-page'));
                  }
                }

                return SizedBox(
                  height: context.height,
                  width: context.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        height: gWidth / 1.2,
                        width: gWidth,
                        // padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset('assets/images/screening-logo.png'),
                      ),
                      const SizedBox(height: 60),
                      SizedBox(
                        width: context.width / 1.8,
                        child: ElevatedButton(
                          onPressed: () => Utils.goToNextPage('patient-page'),
                          child: Text(
                            'Data Pasien'.toUpperCase(),
                            style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                      SizedBox(
                        width: context.width / 1.8,
                        child: ElevatedButton(
                          onPressed: () =>
                              Utils.goToNextPage('create-patient-page'),
                          child: Text(
                            'Daftar Pasien Baru'.toUpperCase(),
                            style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
