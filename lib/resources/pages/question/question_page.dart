import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/controllers/question/question.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/resources/components/components.dart';
import 'package:screening_tools_android/resources/pages/question/score_page.dart';

class QuestionArguments {
  final String question;
  final Patient patient;

  QuestionArguments({required this.question, required this.patient});
}

class QuestionPage extends StatefulWidget {
  final String question;
  final Patient patient;
  const QuestionPage({super.key, required this.question, required this.patient});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int sbjScore = 0;
  int peScore = 0;

  List questionSbj = [];
  List questionPE = [];

  String barTitle = 'pain.nociceptive'.tr;

  @override
  void initState() {
    if (widget.question == 'Nyeri Nosiceptive' || widget.question == 'pain.nociceptive') {
      barTitle = 'pain.nociceptive'.tr;
    } else if (widget.question == 'Nyeri Neuropatik' || widget.question == 'pain.neuropathic') {
      barTitle = 'pain.neuropathic'.tr;
    } else if (widget.question == 'Nyeri Sensitisasi Sentral' || widget.question == 'pain.centralSensitization') {
      barTitle = 'pain.centralSensitization'.tr;
    }

    questionSbj =
        questions
            .where((element) => element.name == widget.question && element.type == 'Subjective')
            .map((e) => {'quest': e.toMap(), 'value': ''})
            .toList();
    questionPE =
        questions
            .where((element) => element.name == widget.question && element.type == 'Physical examination')
            .map((e) => {'quest': e.toMap(), 'value': ''})
            .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didpop, result) {
        final dialog = cDialog(
          context,
          middleText: 'dialog.exitPage'.tr,
          onSucces: () => Get.offAllNamed('home-page'),
          onCancel: () => Get.back(),
        );

        return dialog;
      },
      child: Scaffold(
        appBar: cAppBar(title: barTitle, centerTitle: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Container(
                width: context.width,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(offset: Offset(1, 2), color: Colors.black45, blurRadius: 4)],
                ),
                child: Column(
                  children: [
                    Text('questions.type.1'.tr, style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 14),
                    for (var questionSub in questionSbj)
                      Container(
                        margin: EdgeInsets.only(bottom: questionSub == questionSbj.last ? 0 : 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(questionSub['quest']['title'], maxLines: 10),
                                const SizedBox(height: 4),
                                Text(
                                  questionSub['quest']['subTitle'],
                                  maxLines: 6,
                                  style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (questionSub['value'] != true) {
                                      setState(() {
                                        questionSub['value'] = true;
                                        sbjScore += 1;
                                        debugPrint(sbjScore.toString());
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: questionSub['value'] == true ? Colors.green[700] : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.green[700]!),
                                    ),
                                    child: Row(
                                      children: [
                                        if (questionSub['value'] == true)
                                          Icon(MdiIcons.check, size: context.textTheme.bodyMedium!.fontSize, color: Colors.white),
                                        if (questionSub['value'] == true) const SizedBox(width: 4),
                                        Text(
                                          'yes'.tr,
                                          style: context.textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: questionSub['value'] == true ? Colors.white : Colors.green[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    if (questionSub['value'] != false) {
                                      setState(() {
                                        if (sbjScore != 0 && questionSub['value'] != '') {
                                          sbjScore -= 1;
                                        }
                                        questionSub['value'] = false;
                                        debugPrint(sbjScore.toString());
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: questionSub['value'] == false ? Colors.red[700] : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.red[700]!),
                                    ),
                                    child: Row(
                                      children: [
                                        if (questionSub['value'] == false)
                                          Icon(MdiIcons.close, size: context.textTheme.bodyMedium!.fontSize, color: Colors.white),
                                        if (questionSub['value'] == false) const SizedBox(width: 4),
                                        Text(
                                          'no'.tr,
                                          style: context.textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: questionSub['value'] == false ? Colors.white : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: context.width,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(offset: Offset(1, 2), color: Colors.black45, blurRadius: 4)],
                ),
                child: Column(
                  children: [
                    Text('questions.type.2'.tr, style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 14),
                    for (var questionSub in questionPE)
                      Container(
                        margin: EdgeInsets.only(bottom: questionSub == questionSbj.last ? 0 : 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  questionSub['quest']['title'],
                                  maxLines: 10,
                                  style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (questionSub['value'] != true) {
                                      setState(() {
                                        questionSub['value'] = true;
                                        peScore += 1;
                                        debugPrint(peScore.toString());
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: questionSub['value'] == true ? Colors.green[700] : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.green[700]!),
                                    ),
                                    child: Row(
                                      children: [
                                        if (questionSub['value'] == true)
                                          Icon(MdiIcons.check, size: context.textTheme.bodyMedium!.fontSize, color: Colors.white),
                                        if (questionSub['value'] == true) const SizedBox(width: 4),
                                        Text(
                                          'yes'.tr,
                                          style: context.textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: questionSub['value'] == true ? Colors.white : Colors.green[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    if (questionSub['value'] != false) {
                                      setState(() {
                                        if (peScore != 0 && questionSub['value'] != '') {
                                          peScore -= 1;
                                        }
                                        questionSub['value'] = false;
                                        debugPrint(peScore.toString());
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: questionSub['value'] == false ? Colors.red[700] : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.red[700]!),
                                    ),
                                    child: Row(
                                      children: [
                                        if (questionSub['value'] == false)
                                          Icon(MdiIcons.close, size: context.textTheme.bodyMedium!.fontSize, color: Colors.white),
                                        if (questionSub['value'] == false) const SizedBox(width: 4),
                                        Text(
                                          'no'.tr,
                                          style: context.textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: questionSub['value'] == false ? Colors.white : Colors.red[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: context.width,
                child: ElevatedButton(
                  onPressed: () async {
                    cDialog(
                      context,
                      middleText: 'dialog.sure'.tr,
                      onSucces:
                          () => Get.offAllNamed(
                            Routes.score,
                            arguments: ScoreArguments(question: widget.question, patient: widget.patient, sbjScore: sbjScore, peScore: peScore),
                            predicate: (route) => route.settings.name == Routes.home,
                          ),
                      onCancel: () => Get.back(),
                    );
                  },
                  child: Text('button.checkResult'.tr, style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
