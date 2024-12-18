import 'dart:isolate';
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screening_tools_android/app/utils/utils.dart';

class RequestUpdatePage extends StatefulWidget {
  const RequestUpdatePage({super.key});

  @override
  State<RequestUpdatePage> createState() => _RequestUpdatePageState();
}

class _RequestUpdatePageState extends State<RequestUpdatePage> {
  final ReceivePort _port = ReceivePort();

  CollectionReference optionsApp = FirebaseFirestore.instance.collection('options_app');

  submit() async {}

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      // DownloadTaskStatus status = DownloadTaskStatus();
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: optionsApp.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Utils.paindreShowLoading();
              Utils.errorToast(message: "Terjadi kesalahan, silahkan coba lagi");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              Utils.paindreShowLoading();
            }

            if (snapshot.hasData) {
              var option = snapshot.data!.docs[0].data() as Map<String, dynamic>;
              BotToast.closeAllLoading();

              // if (option['maintanance_mode'] == false) {
              //   Future.delayed(Duration(seconds: 2))
              //       .then((value) => Get.offAllNamed('home-page'));
              // }
            }

            return Container(
              height: context.height,
              width: context.width,
              padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 110,
                    width: 110,
                    child: Image.asset('assets/images/maintanance_icon.png'),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Mohon update ke versi terbaru, untuk memakai aplikasi ini...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: context.width / 1.8,
                    child: ElevatedButton(
                      onPressed: () async {
                        final statusStorage = await Permission.storage.request();

                        if (statusStorage.isGranted) {
                          // print(statusStorage);
                          final externalDir = await getExternalStorageDirectory();
                          if (snapshot.hasData) {
                            var option = snapshot.data!.docs[0].data() as Map<String, dynamic>;
                            await FlutterDownloader.enqueue(
                              url: option['application_link'],
                              headers: {}, // optional: header send with url (auth token etc)
                              savedDir: externalDir!.path,
                              showNotification: true, // show download progress in status bar (for Android)
                              openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                            );
                          }
                        } else {
                          // print("status ungranted");
                        }
                      },
                      child: Text(
                        'Refresh'.toUpperCase(),
                        style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
