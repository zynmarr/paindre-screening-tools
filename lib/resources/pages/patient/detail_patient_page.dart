import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/controllers/service/service_controller.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class DetailPatientArguments {
  final Patient patient;
  DetailPatientArguments({required this.patient});
}

class DetailPatientPage extends StatefulWidget {
  final Patient patient;
  const DetailPatientPage({super.key, required this.patient});

  @override
  State<DetailPatientPage> createState() => _DetailPatientPageState();
}

class _DetailPatientPageState extends State<DetailPatientPage> {
  List<Map<String, dynamic>> listScoringResult = [];
  String textResult = 'text.painResultData'.tr; // Default text for no specific pain found

  PatientController patientController = PatientController();

  User? get user => FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    patientController.questionnareScore(patientID: widget.patient.id).get().then((value) {
      setState(() {
        listScoringResult = value.docs.map((p) => p.data() as Map<String, dynamic>).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ServiceController serviceController = context.watch<ServiceController>();
    return Scaffold(
      appBar: cAppBar(
        title: 'title.detailExamination'.tr,
        centerTitle: true,
        leading: GestureDetector(onTap: () => Get.back(), child: Icon(MdiIcons.chevronLeft, size: 20)),
      ),
      resizeToAvoidBottomInset: false,
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
          SizedBox(
            height: context.height,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                children: [
                  Container(
                    width: context.width,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(color: Colors.grey[400]!, spreadRadius: 0.2, blurRadius: 4)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        textKeyWithValue(context, key: '${'name'.tr}: ', value: widget.patient.name),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                        textKeyWithValue(context, key: '${'age'.tr}: ', value: "${widget.patient.age} ${'years'.tr}"),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                        textKeyWithValue(context, key: '${'gender'.tr}: ', value: widget.patient.gender == 'male' ? 'man'.tr : 'woman'.tr),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                        textKeyWithValue(
                          context,
                          key: '${'diagnosis'.tr}: ',
                          value: widget.patient.diagnostic == 'Kosong' ? 'empty'.tr : widget.patient.diagnostic,
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                        textKeyWithValue(context, key: '${'examinerName'.tr}: ', value: widget.patient.responsiblePerson),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                        textKeyWithValue(
                          context,
                          key: '${'dateExamined'.tr}: ',
                          value: Utils.ymdFormat(dateTime: DateTime.tryParse(widget.patient.createdAt)),
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                        textKeyWithValue(
                          context,
                          key: '${'checkUpResult'.tr}: ',
                          maxLines: 3,
                          value: listScoringResult.isEmpty ? textResult : listScoringResult.map((e) => painName(e['type'])).toString(),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                  if (serviceController.role == Roles.admin || user?.uid == widget.patient.userID)
                    SizedBox(
                      width: context.width,
                      child: ElevatedButton(
                        style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                        onPressed:
                            () => cDialog(
                              context,
                              middleText: 'dialog.delete'.tr,
                              onSucces: () async {
                                Get.back();
                                await PatientController().deletePatientAndScores(widget.patient.id);
                                Get.back(result: widget.patient.id);
                              },
                              onCancel: () async {
                                Get.back();
                              },
                            ),
                        child: Text('delete'.tr, style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
