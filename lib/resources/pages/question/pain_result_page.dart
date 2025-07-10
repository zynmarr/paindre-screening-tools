import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class PainResultArguments {
  final Patient patient;

  PainResultArguments({required this.patient});
}

class PainResultPage extends StatefulWidget {
  final Patient patient;
  const PainResultPage({super.key, required this.patient});

  @override
  State<PainResultPage> createState() => _PainResultPageState();
}

class _PainResultPageState extends State<PainResultPage> {
  String textResult = 'text.allResultExamination'.tr;
  String textResult2 = 'text.painResultData'.tr;

  @override
  Widget build(BuildContext context) {
    double gWidth = context.width / 2.2;

    return Scaffold(
      appBar: cAppBar(title: 'text.lastResultxamination'.tr, centerTitle: true),
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
            height: context.height,
            width: context.width,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),

            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: gWidth,
                  width: gWidth,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://lh3.googleusercontent.com/pw/AP1GczO9egAuF1P-qsdsxxQ4CTCETHxXNEB3HDLRRZwuZm1gD5na9vERZtAsNDOWxVW4eVwo8-7nlCOUG6y5Bhk0JEVKcfkY8YL07ZlG9XRPhwX5BwhaDU1iEHLxfCPpOjlyRiO0va3YOw7Dh-oyNjqDvVg=w500-h500-s-no-gm',
                    filterQuality: FilterQuality.high,
                    fadeOutDuration: Duration(milliseconds: 500),
                    fadeInDuration: Duration(milliseconds: 300),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: context.width,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(offset: Offset(1, 2), color: Colors.black45, blurRadius: 4)],
                  ),
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('patients/${widget.patient.id}/questionnares_score').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Map<String, dynamic>> item = snapshot.data!.docs.map((p) => p.data()).toList();

                            debugPrint(item.length.toString());

                            if (item.isNotEmpty) {
                              return Column(
                                children: [
                                  Text(
                                    textResult,
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 20),
                                  for (Map<String, dynamic> p in item)
                                    Row(
                                      children: [
                                        Icon(MdiIcons.minus, size: 25),
                                        Text(painName(p['type']), style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  const SizedBox(height: 8),
                                ],
                              );
                            } else {
                              return Text(
                                textResult2,
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                              );
                            }
                          } else {
                            return Text(
                              'error.message.dataNotFound'.tr,
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: context.width / 3,
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed(Routes.home),
                    child: Text('exit'.tr, style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
