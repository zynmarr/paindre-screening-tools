import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:screening_tools_android/app/routes/routes.dart';

class MaintanancePage extends StatefulWidget {
  const MaintanancePage({super.key});

  @override
  State<MaintanancePage> createState() => _MaintanancePageState();
}

class _MaintanancePageState extends State<MaintanancePage> {
  CollectionReference optionsApp = FirebaseFirestore.instance.collection('options_app');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: optionsApp.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('error.message.network'.tr));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SpinKitFadingCircle(color: Colors.black, size: 30.0));
          }

          if (snapshot.hasData) {
            var option = snapshot.data!.docs[0].data() as Map<String, dynamic>;

            if (option['maintanance_mode'] == false) {
              Future.delayed(Duration(seconds: 2)).then((value) => Get.offAllNamed(Routes.home));
            }
          }

          return Container(
            height: context.height,
            width: context.width,
            padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 110, width: 110, child: Image.asset('assets/images/maintanance_icon.webp')),
                SizedBox(height: 25),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'text.maintenanceMode'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: context.width / 1.8,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
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
        },
      ),
    );
  }
}
