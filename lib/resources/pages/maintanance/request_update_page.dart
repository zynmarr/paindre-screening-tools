import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestUpdatePage extends StatefulWidget {
  const RequestUpdatePage({super.key});

  @override
  State<RequestUpdatePage> createState() => _RequestUpdatePageState();
}

class _RequestUpdatePageState extends State<RequestUpdatePage> {
  CollectionReference optionsApp = FirebaseFirestore.instance.collection('options_app');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: optionsApp.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Utils.paindreShowLoading();
            Utils.errorToast(message: 'error.message.unknown'.tr);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            Utils.paindreShowLoading();
          }

          if (snapshot.hasData) {
            BotToast.closeAllLoading();
          }

          return Container(
            height: context.height,
            width: context.width,
            padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 110, width: 110, child: Image.asset('assets/images/maintanance_icon.png')),
                SizedBox(height: 25),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'text.requiredUpdate'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20), // Spasi antara tombol
                SizedBox(
                  width: context.width / 1.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.paindre_innovation.screening_tools_android'); // Ganti dengan URL aplikasi Anda
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(
                      'text.goToPlayStore'.tr.toUpperCase(),
                      style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
